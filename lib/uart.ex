defmodule UART.Demo do
  defmodule State do
    defstruct buffer: [""], lock: nil
  end

  @impl :gen_server
  def init(_config) do
    pid = self()
    port = :uart.open("UART2", [{:speed, 9600}, {:rx, 16}])

    :timer.sleep(1000)
    spawn_link(fn -> loop(pid, port) end)
    {:ok, %State{}}
  end

  defp loop(pid, port) do
    IO.inspect("loop_read")
    {:ok, read} = :uart.read(port)
    IO.inspect(read)
    :gen_server.cast(pid, {:append, read})
    loop(pid, port)
  end

  @impl :gen_server
  def handle_cast({:append, new}, %State{buffer: [latest | rest]} = state) when is_binary(new) do
    {current, next} =
      case :binary.split(new, "\r\n") do
        [unfinished_line] -> {unfinished_line, nil}
        [line, ""] -> {line <> "\r\n", nil}
        [line, rest] -> {line <> "\r\n", rest}
      end

    # THIS LINE CRASHES!
    # if(!is_binary(latest), do: :erlang.error({:latest, latest, state}))

    buffer =
      case latest do
        <<_::binary-size(byte_size(latest) - 2), "\r\n">> -> [current, latest | rest]
        _ -> [latest <> current | rest]
      end

    if next == nil do
      {:noreply, %State{state | buffer: buffer}}
    else
      handle_cast({:append, next}, %State{state | buffer: buffer})
    end
  end
end

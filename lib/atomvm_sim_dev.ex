defmodule AtomvmSimDev do
  def start do
    spi_settings = [
      bus_config: [
        miso: 19,
        mosi: 23,
        sclk: 18,
        peripheral: "spi3"
      ]
    ]

    spi = :spi.open(spi_settings)
    {:ok, mount_ref} = :esp.mount("sdspi", "/test", :fat, spi_host: spi, cs: 5)

    path = "/test/123.txt"

    {:ok, pid} = :gen_server.start_link(UART.Demo, [], [])

    # ADC Potentiometer
    # :ok = :esp_adc.start(34)
    # :esp_adc.read(34) |> IO.inspect()

    case :atomvm.posix_open(path, [:o_wronly, :o_creat, :o_excl], 0o644) do
      {:ok, fd} ->
        {:ok, l} = :atomvm.posix_write(fd, "My String")
        IO.inspect(:atomvm.posix_close(fd))
        IO.inspect("File closed")

      err ->
        IO.inspect(err)
        IO.inspect("some error")
    end

    :ok = :esp.umount(mount_ref)
    loop()
  end

  def loop do
    :timer.sleep(1000)
    IO.inspect("loop")
    loop()
  end
end

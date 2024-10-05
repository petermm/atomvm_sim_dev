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
    IO.inspect("spi")
    {:ok, mount_ref} = :esp.mount("sdspi", "/test", :fat, spi_host: spi, cs: 5)
    # {:ok, mount_ref} = :esp.mount("sdmmc", "/test", :fat, [])

    IO.inspect(mount_ref)

    :io.format(~c"Got mount_ref: ~p~n", [mount_ref])

    path = "/test/test.txt"
    IO.inspect("start")

    # :ok = :esp_adc.start(34)

    :timer.sleep(400)

    # :esp_adc.read(34) |> IO.inspect()

    case :atomvm.posix_open(path, [:o_wronly, :o_creat, :o_excl], 0o644) do
      {:ok, fd} ->
        {:ok, l} = :atomvm.posix_write(fd, "My String")
        # IO.inspect(:atomvm.posix_read(fd, 0))
        # :ok = :esp.umount("/test")
        # IO.inspect("posix_write after umount:")
        # IO.inspect(:atomvm.posix_write(fd, "My String123"))
        # IO.inspect("posix_close after umount:")
        IO.inspect(:atomvm.posix_close(fd))
        IO.inspect("done")

      err ->
        IO.inspect(err)
        IO.inspect("some error")
    end

    :ok = :esp.umount(mount_ref)

    # :esp.mount("sdspi", "/test", :fat, spi_host: spi, cs: 5)

    # case :atomvm.posix_open(path, [:o_rdwr], 0x644) do
    #   {:ok, fd} ->
    #     IO.inspect(:atomvm.posix_read(fd, 9))
    #     IO.inspect(:atomvm.posix_close(fd))
    # end

    # {ok, Fd} = atomvm:posix_open("/test/test.txt", [o_rdwr, o_creat], 8#644),
    # ok = atomvm:posix_close(Fd),
    # ok = umount_missing(),
    # ok = esp:umount("/test").
    :ok
  end
end

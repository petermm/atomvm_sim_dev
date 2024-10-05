defmodule AtomvmSimDev.MixProject do
  use Mix.Project

  def project do
    [
      app: :atomvm_sim_dev,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      atomvm: [
        start: AtomvmSimDev,
        flash_offset: 0x250000,
        chip: "auto",
        port: "auto"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exatomvm, git: "https://github.com/atomvm/ExAtomVM", branch: "main"},
      {:neopixel, git: "https://github.com/atomvm/atomvm_neopixel"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

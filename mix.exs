defmodule Trot.Mixfile do
  use Mix.Project

  @version File.read!("VERSION") |> String.trim

  def project do
    [app: :trot,
     version: @version,
     elixir: "~> 1.12",
     deps: deps(),
     name: "Trot",
     docs: [main: "readme",
            extras: ["README.md"],
            source_ref: "v#{@version}",
            source_url: "https://github.com/hexedpackets/trot"],

     # Hex
     description: description(),
     package: package()]
  end

  def application do
    [
     # :crypto required by Plug.Crypto, :eex required by Calliope
     extra_applications: [:logger, :crypto, :eex],
     mod: {Trot, []}]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:cowboy, "~> 2.5"},
      {:poison, "~> 6.0"},
      {:calliope, "~> 0.4.2"},
      {:plug_heartbeat, "~> 1.0"},
      {:ex_doc, "~> 0.33", only: :dev, runtime: false},
      {:inch_ex, ">= 0.0.0", only: :docs},
      {:credo, "~> 1.7.6", only: [:dev, :test], runtime: false},
      {:slime, "~> 1.3"},
    ]
  end

  defp description do
    """
    A web micro-framework based on Plug and Cowboy.
    """
  end

  defp package do
    [maintainers: ["William Huba"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/hexedpackets/trot"},
     files: ~w(mix.exs README.md LICENSE lib VERSION)]
  end
end

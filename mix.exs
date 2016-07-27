defmodule Echo.Mixfile do
  use Mix.Project

  @description """
  A Simple Elixir Echo Server
  """

  def project do
    [app: :echo,
     version: "0.0.1",
     elixir: "~> 1.3.0",
     description: @description,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :exrm_deb, :swab, :redix],
    mod: {Echo, []}]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.13.0", only: :dev},
      {:exrm, "~> 1.0.8"},
      {:exrm_deb, "~> 0.0.6"},
      {:redix, ">= 0.4.0"},
      {:swab, github: "crownedgrouse/swab", branch: "master"}
    ]
  end

  defp package do [
    name: :echo_server,
    license_file: "LICENSE",
    external_dependencies: [],
    maintainers: ["Areski Belaid"],
    vendor: "Areski Belaid",
    licenses: ["MIT"],
    links: %{
      "GitHub" => "https://github.com/areski/echo-server-elixir",
      "Homepage" => "https://github.com/areski/echo-server-elixir"
    }
  ] end

end

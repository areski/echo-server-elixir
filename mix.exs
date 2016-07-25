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
    [applications: [:logger],
    mod: {Echo, []}]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.13.0", only: :dev}
    ]
  end

  defp package do [
    name: :digitalocean,
    maintainers: ["Areski Belaid"],
    licenses: ["MIT"],
    links: %{"GitHub" => "https://github.com/areski/echo-server-elixir"}
  ] end

end

defmodule Templates.Mixfile do
  use Mix.Project

  def project do
    [ app: :templates,
      version: "0.0.6",
      elixir: "~> 1.6.0",
      name: "Templates",
      deps: deps(),
      package: package(),
      description: description(),
      docs: [readme: "README.md", main: "README"],
      test_coverage: [tool: ExCoveralls] ]
  end

  # Configuration for the OTP application
  def application do
    [ application: [:templates, :erlydtl, :calliope],
      mod: { Templates, [] } ]
  end

  defp deps do
    [ { :calliope, "~> 0.4.1" },
      { :ex_doc, "~> 0.18.3", only: :docs },
      { :earmark, "~> 1.2.4", only: :docs },
      { :excoveralls, "~> 0.8.1", only: :test } ]
  end

  defp description do
    """
    A helper library for adding templating to web applications
    """
  end

  defp package do
    %{contributors: ["Shane Logsdon"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sugar-framework/templates",
               "Docs" => "http://sugar-framework.github.io/docs/api/templates/"}}
  end
end

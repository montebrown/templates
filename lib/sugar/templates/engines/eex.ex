defmodule Sugar.Templates.Engines.EEx do
  require EEx

  @moduledoc """
  EEx template engine
  """

  @behaviour Sugar.Templates.Engine

  ## Callbacks

  def compile(template) do
    name = Module.concat([Sugar.Templates.CompiledTemplates.EEx, template.key])
    info = [file: __ENV__.file, line: __ENV__.line, engine: Phoenix.HTML.Engine]
    args = Enum.map([:assigns], fn arg -> {arg, [line: info[:line]], nil} end)
    compiled = EEx.compile_string(template.source, info)

    contents =
      quote do
        def(render(unquote_splicing(args)), do: unquote(compiled))
      end

    case name |> Module.create(contents, info) do
      {:module, ^name, binary, _} ->
        template = %{template | source: nil}
        template = %{template | binary: binary}
        {:ok, template}

      _ ->
        {:error, "Could not create \"#{name}\""}
    end
  end

  def render(template, vars) do
    name = Module.concat([Sugar.Templates.CompiledTemplates.EEx, template.key])

    if not Code.ensure_loaded?(name) do
      compile(template)
    end

    {:ok, apply(name, :render, [vars])}
  end
end

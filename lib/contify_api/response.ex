defmodule ContifyAPI.Response do
  @moduledoc """
  Shared response decoding for ContifyAPI calls.

  Translates `Req` responses into typed result tuples:

  - 2xx with a JSON body — `{:ok, %ResponseModule{}}`
  - 4xx/5xx with an error body — `{:ok, %ContifyAPI.Model.Error{}}` (matches
    legacy `Contify` semantics where API-shaped errors come back as `:ok`)
  - 4xx/5xx without a parseable body — `{:error, %Req.Response{}}`
  - Transport / connection failures — `{:error, exception}`
  """

  alias ContifyAPI.Model
  alias ContifyAPI.Model.Error

  @type api_result(success_t) ::
          {:ok, success_t | Error.t()} | {:error, Exception.t() | Req.Response.t()}

  @doc """
  Decode a `{:ok, %Req.Response{}}` tuple into a typed struct, or a `{:error, _}`
  into the same shape so callers see a single result type.
  """
  @spec decode({:ok, Req.Response.t()} | {:error, Exception.t()}, module() | nil) ::
          api_result(struct())
  def decode({:ok, %Req.Response{body: body, status: status}}, target_module)
      when status in 200..299 do
    {:ok, hydrate(body, target_module)}
  end

  def decode({:ok, %Req.Response{body: body} = response}, _target_module) do
    case hydrate_error(body) do
      %Error{} = error -> {:ok, error}
      _ -> {:error, response}
    end
  end

  def decode({:error, _exception} = result, _target_module), do: result

  @doc """
  Decode a successful response whose body is a JSON array into a list of structs.
  """
  @spec decode_list({:ok, Req.Response.t()} | {:error, Exception.t()}, module()) ::
          {:ok, [struct()] | Error.t()} | {:error, Exception.t() | Req.Response.t()}
  def decode_list({:ok, %Req.Response{body: body, status: status}}, target_module)
      when status in 200..299 and is_list(body) do
    {:ok, Enum.map(body, &to_struct(&1, target_module))}
  end

  def decode_list(result, target_module), do: decode(result, target_module)

  @doc """
  Convert a plain map (with string or atom keys) into a struct of `target_module`,
  recursively hydrating known nested model fields where appropriate.
  """
  @spec to_struct(map() | nil, module()) :: struct() | nil
  def to_struct(nil, _target_module), do: nil

  def to_struct(map, target_module) when is_map(map) do
    attrs =
      map
      |> normalize_keys()
      |> hydrate_nested(target_module)

    struct(target_module, attrs)
  end

  # No body to hydrate (e.g. DELETE 204 returns).
  defp hydrate(nil, _target_module), do: nil
  defp hydrate("", _target_module), do: nil
  defp hydrate(body, nil), do: body
  defp hydrate(body, target_module) when is_map(body), do: to_struct(body, target_module)
  defp hydrate(body, _target_module), do: body

  defp hydrate_error(body) when is_map(body) do
    case normalize_keys(body) do
      %{code: _} = attrs -> struct(Error, attrs)
      %{message: _} = attrs -> struct(Error, attrs)
      _ -> nil
    end
  end

  defp hydrate_error(_), do: nil

  defp normalize_keys(map) when is_map(map) do
    Map.new(map, fn
      {k, v} when is_binary(k) -> {String.to_existing_atom(k), v}
      {k, v} -> {k, v}
    end)
  rescue
    ArgumentError ->
      # Fall back to retaining any string keys that don't map to known atoms.
      Map.new(map, fn
        {k, v} when is_binary(k) ->
          try do
            {String.to_existing_atom(k), v}
          rescue
            ArgumentError -> {k, v}
          end

        {k, v} ->
          {k, v}
      end)
  end

  # Hydrate nested fields per model. We only convert nested structures for
  # known model fields; everything else passes through as-is.
  defp hydrate_nested(attrs, Model.SearchCompanyGet200Response) do
    Map.update(attrs, :results, attrs[:results], &hydrate_list(&1, Model.Company))
  end

  defp hydrate_nested(attrs, Model.InsightsResponse) do
    Map.update(attrs, :results, attrs[:results], &hydrate_list(&1, Model.Insight))
  end

  defp hydrate_nested(attrs, Model.Insight) do
    attrs
    |> hydrate_field(:language, Model.Language)
    |> hydrate_field(:source, Model.Source)
    |> hydrate_list_field(:previews, Model.Preview)
    |> hydrate_list_field(:duplicates, Model.Duplicate)
    |> hydrate_list_field(:attachments, Model.Attachment)
    |> hydrate_list_field(:companies, Model.InsightCompany)
    |> hydrate_list_field(:industries, Model.Tags)
    |> hydrate_list_field(:topics, Model.Tags)
    |> hydrate_list_field(:custom_topics, Model.Tags)
    |> hydrate_list_field(:locations, Model.Tags)
    |> hydrate_list_field(:content_types, Model.Tags)
  end

  defp hydrate_nested(attrs, _target_module), do: attrs

  defp hydrate_list(list, target_module) when is_list(list),
    do: Enum.map(list, &to_struct(&1, target_module))

  defp hydrate_list(other, _target_module), do: other

  defp hydrate_field(attrs, key, target_module) do
    case Map.get(attrs, key) do
      nil -> attrs
      value -> Map.put(attrs, key, to_struct(value, target_module))
    end
  end

  defp hydrate_list_field(attrs, key, target_module) do
    case Map.get(attrs, key) do
      nil -> attrs
      value -> Map.put(attrs, key, hydrate_list(value, target_module))
    end
  end
end

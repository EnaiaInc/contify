# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Deserializer do
  @moduledoc """
  Helper functions for deserializing responses into models
  """

  @doc """
  Update the provided model with a deserialization of a nested value
  """
  def deserialize(model, field, :list, mod, options) do
    model
    |> Map.update!(field, fn value ->
      if is_struct(List.first(value)) do
        value
      else
        Poison.Decode.transform(value, Map.merge(options, %{as: [struct(mod)]}))
      end
    end)
  end

  def deserialize(model, field, :struct, mod, options) do
    model
    |> Map.update!(field, fn value ->
      if is_struct(value) do
        value
      else
        Poison.Decode.transform(value, Map.merge(options, %{as: struct(mod)}))
      end
    end)
  end

  def deserialize(model, field, :map, mod, options) do
    model
    |> Map.update!(
      field,
      &Map.new(&1, fn {key, val} ->
        {key, Poison.Decode.transform(val, Map.merge(options, %{as: struct(mod)}))}
      end)
    )
  end

  def deserialize(model, field, :date, _, _options) do
    value = Map.get(model, field)

    case is_binary(value) do
      true ->
        case DateTime.from_iso8601(value) do
          {:ok, datetime, _offset} -> Map.put(model, field, datetime)
          _ -> model
        end

      false ->
        model
    end
  end
end

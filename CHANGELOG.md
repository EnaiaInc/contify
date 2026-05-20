# Changelog

## 0.2.0 (unreleased)

### Breaking changes

- The HTTP layer is now [`Req`](https://hex.pm/packages/req) instead of
  [`Tesla`](https://hex.pm/packages/tesla). Public function shapes and model
  module names are unchanged, but error tuples on transport failures now
  carry `%Req.TransportError{}` instead of `%Tesla.Env{}`.
- `Poison` has been dropped in favour of `Jason` (used transitively by Req).
  Model modules no longer derive `Poison.Encoder` or implement
  `Poison.Decoder`. Callers that need JSON encoding can derive
  `Jason.Encoder` (or any other protocol) themselves.
- Test stubs now use `Req.Test` instead of `Tesla.Mock`. See `README.md` for
  the new test setup.
- Removed unused generated modules: every `ContifyAPI.Api.*` and
  `ContifyAPI.Model.*` for endpoints we don't expose at the `Contify` public
  module level (custom topics, industries, languages, search location, search
  source, content source, get tags, plain location). The set of model modules
  the `Contify.*` public functions return is unchanged.
- Removed `ContifyAPI.Connection`, `ContifyAPI.RequestBuilder`, and
  `ContifyAPI.Deserializer` (internal to the generated client). Replaced by
  `ContifyAPI.Client` and `ContifyAPI.Response`.

### Tooling

- Modern `mix.exs` with package metadata, ExDoc config, dialyzer config, and
  `warnings_as_errors` for compiler.
- `.formatter.exs` now uses Quokka with autosort + conservative module
  directive sorting.
- Added `credo`, `dialyxir`, `ex_doc`, and `quokka` as dev/test deps.
- Minimum Elixir requirement bumped to `~> 1.18`.
- GitHub Actions CI runs format check, credo, dialyzer, and tests across the
  supported Elixir matrix.

## 0.1.0

- Initial release.

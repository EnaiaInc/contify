[
  plugins: [Quokka],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  quokka: [
    # `:autosort` (for maps and defstructs) is intentionally left out. See
    # https://github.com/emkguts/quokka/issues/164 — autosort detaches
    # group-heading comments from their entries. Re-add once that lands.
    only: [
      :blocks,
      :configs,
      :defs,
      :deprecations,
      :module_directives,
      :pipes,
      :single_node
    ]
  ]
]

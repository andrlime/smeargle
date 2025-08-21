# Smeargle: A resume templating engine

This was a quick two-day project to condense my resume source files for various industries into singular s-expression files, and have OCaml take care of generating and compiling Typst code. It's quite useless of an abstraction, but it simplifies my life quite a lot, especially with the pseudo-Markdown formatting.

There is an example provided in `./examples` that summarises how this tool works.

To add other output formats, the ast `Output` node needs to be extended with another module (e.g. `LaTeX` or `PlainText`). That module needs to be written in a similar way to the Typst module.

## TODO
- [ ] Write unit tests
- [x] Write example templates
- [ ] Add some more fun language features

# Smeargle: A resume templating engine

There is an example provided in `./examples` that summarises how this tool works.

To add other output formats, the ast `Output` node needs to be extended with another module (e.g. `LaTeX` or `PlainText`). That module needs to be written in a similar way to the Typst module.

## TODO
- [ ] Write unit tests
- [x] Write example templates
- [ ] Add some more fun language features

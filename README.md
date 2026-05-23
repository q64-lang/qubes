# qubes

First-party [q64](https://github.com/q64-lang/q64) qubes — distribution units
published to the continuum registry. (A *qube* is what you publish, depend on,
and import; see the [q64 vocabulary](https://github.com/q64-lang/q64#vocabulary).)

> **Status: pre-alpha.** The q64 toolchain is early; these qubes are real
> source that compiles once the compiler and registry are capable enough.

## Qubes

| Qube | Kind | Purpose |
|------|------|---------|
| [`webmcp-client/`](./webmcp-client) | library (`q64/webmcp-client`) | A client for [WebMCP](https://github.com/webmachinelearning/webmcp) — enumerate and invoke the tools a web page registers on `navigator.modelContext`. |

## Examples

| Example | Purpose |
|---------|---------|
| [`examples/tool-caller/`](./examples/tool-caller) | An app that depends on `q64/webmcp-client` (via a local path) and drives its client surface. Demonstrates how a dependency links into a project. |

## License

Dual-licensed under MIT OR Apache-2.0.

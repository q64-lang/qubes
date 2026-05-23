# qubes

A monorepo of first-party [q64](https://github.com/q64-lang/q64) qubes —
distribution units published to the continuum registry. (A *qube* is what you
publish, depend on, and import; see the
[q64 vocabulary](https://github.com/q64-lang/q64#vocabulary).)

This repo is a **qube workspace**: the top-level [`qube.json5`](./qube.json5)
declares each qube as a member, the same shape q64's `stdlib/` uses. `qube build`
from the root builds every member in dependency order; from a member folder it
builds just that qube. Each qube is a top-level directory; its examples live
under it (`<qube>/examples/<name>`). New members are added with a line in the
workspace `members` list.

> **Status: pre-alpha.** The q64 toolchain is early; these qubes are real
> source that compiles once the compiler and registry are capable enough.

## Qubes

| Qube | Kind | Purpose |
|------|------|---------|
| [`webmcp-client/`](./webmcp-client) | library (`q64/webmcp-client`) | A client for [WebMCP](https://github.com/webmachinelearning/webmcp) — enumerate and invoke the tools a web page registers on `navigator.modelContext`. |

Each qube documents its own examples; e.g.
[`webmcp-client/examples/tool-caller/`](./webmcp-client/examples/tool-caller)
depends on `q64/webmcp-client` via a local path and drives its client surface,
demonstrating how a dependency links into a project.

## License

Dual-licensed under MIT OR Apache-2.0.

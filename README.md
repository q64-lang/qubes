# qubes

A monorepo of first-party [q64](https://github.com/q64-lang/q64) qubes —
distribution units published to the continuum registry. (A *qube* is what you
publish, depend on, and import; see the
[q64 vocabulary](https://github.com/q64-lang/q64#vocabulary).)

This repo is a **qube workspace**: the top-level [`qube.json5`](./qube.json5)
declares each qube as a member, the same shape q64's `stdlib/` uses. `qube build`
from the root builds every member in dependency order; from a member folder it
builds just that qube. Each qube is a top-level directory; its example lives
under it (`<qube>/example`). New members are added with a line in the
workspace `members` list.

> **Status: pre-alpha.** The q64 toolchain is early; these qubes are real
> source that compiles once the compiler and registry are capable enough.

> **Address space.** Qubes here are distributed as **source**; the address
> space (`wasm32` / `wasm64`) is chosen at *build* time, not stored in the
> registry. There is no default — a build picks one explicitly (per
> q64's [`spec/memory.md`](https://github.com/q64-lang/q64/blob/main/spec/memory.md)).
> `wasm32` is the universal/WebKit-and-iPad baseline; `wasm64` adds Memory64
> for capable hosts. A qube meant to run in the browser must build `wasm32`.

## Qubes

| Qube | Kind | Purpose |
|------|------|---------|
| [`webmcp-client/`](./webmcp-client) | library (`dev.q64.webmcp_client`) | A client for [WebMCP](https://github.com/webmachinelearning/webmcp) — enumerate and invoke the tools a web page registers on `navigator.modelContext`. |

Each qube documents its own example; e.g.
[`webmcp-client/example/`](./webmcp-client/example) depends on
`dev.q64.webmcp_client` via a local path and drives its client surface,
demonstrating how a dependency links into a project.

## License

Dual-licensed under MIT OR Apache-2.0.

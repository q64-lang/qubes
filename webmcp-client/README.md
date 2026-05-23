# q64/webmcp-client

A q64 client for **WebMCP** — the [Web Model Context
Protocol](https://github.com/webmachinelearning/webmcp), a W3C Web Machine
Learning Community Group draft. A WebMCP page registers **tools** on
`navigator.modelContext` — each a `{ name, description, inputSchema, execute }`
record — that AI agents and assistive technologies discover and invoke. This
qube is the *client* (agent) side: it enumerates a page's tools and calls them.

> **Status: pre-alpha, surface only.** The public surface compiles to a core
> module once the q64 toolchain is capable enough; the browser host binding
> and registry publishing are deferred (see "Deferred" below).

## Surface

```q64
import q64.webmcp_client.{WebMcp, Tool, ToolResult, McpError, find_tool, call}
```

- `face WebMcp` — the capability a host adapter supplies:
  - `list_tools(self) -> Result<[Tool], McpError>`
  - `call_tool(self, name: str, arguments: str) -> Result<ToolResult, McpError>`
- `struct Tool { name, description, input_schema }` — `input_schema` is a JSON
  Schema document (text). Arguments and results are JSON text too, so every
  signature lowers to the WIT canonical ABI.
- `struct ToolResult { content, is_error }`
- `enum McpError { Unsupported, ToolNotFound(str), InvalidArguments(str), ExecutionFailed(str) }`
  (fits `Error`).
- `fn find_tool(mcp, name)` / `fn call(mcp, name, arguments)` — host-independent
  helpers built on the face; they work against any fit (a browser fit, a test
  mock, or the example's canned `DemoTools`).

## Using it

A consumer is handed a `WebMcp` value and calls through it:

```q64
let tools = try mcp.list_tools()
let result = try call(mcp, "echo", r#"{"text":"hi"}"#)
```

See [`example/`](./example) for a runnable shape that supplies an in-process
fit with canned tools.

## Design notes

- **Capability as a face.** `WebMcp` mirrors how `Net`/`Fs` are modelled in
  [`q64/spec/env.md`](https://github.com/q64-lang/q64/blob/main/spec/env.md):
  the runtime supplies a fit, tests/examples supply their own. Methods carry
  the `@ui` effect (→ the `Ui` capability) — the closest existing browser-host
  marker.
- **Why explicit `mcp: WebMcp`, not `env.mcp`.** Adding an `Env` field (and a
  dedicated `@mcp` effect) is a compiler + runtime change; this qube stays a
  self-contained library and takes the capability explicitly, the form
  [`env.md`](https://github.com/q64-lang/q64/blob/main/spec/env.md) blesses for
  library code.

## Deferred

- A `BrowserWebMcp` fit in `q64/runtime/browser/` bridging
  `navigator.modelContext` (the real, runnable client).
- A dedicated `@mcp` effect / `env.mcp` capability field.
- Publishing to the continuum registry (`qube publish`) and installing via
  `qube add` — the registry and those CLI subcommands are not yet implemented.

## License

Dual-licensed under MIT OR Apache-2.0.

# tool-caller

An application qube, living under the qube it demonstrates, that depends on
[`q64/webmcp-client`](../..) and drives its `WebMcp` client surface: it lists
the tools a page exposes and invokes one, printing the results.

The dependency is declared as a **local path** in `qube.json5`:

```json5
"dependencies": {
  "q64/webmcp-client": { "path": "../.." },
}
```

The qube CLI normalises that path to an absolute one and links it via
`q64 --module q64.webmcp_client=<path>/src` — the same mechanism a
registry-resolved dependency uses (see
[`q64/spec/qube-cli.md`](https://github.com/q64-lang/q64/blob/main/spec/qube-cli.md)).

## Running

WebMCP (`navigator.modelContext`) is browser-only and currently behind a flag
in Chrome Canary, so this example ships an in-process `DemoTools` fit with two
canned tools (`echo`, `ping`) instead of a real page. Once the q64 toolchain
can compile multi-module qubes:

```bash
qube web        # builds to wasm and serves at http://localhost:4711/
```

Expected output:

```
page exposes 2 WebMCP tool(s):
  - echo: Echo the 'text' argument back to the caller.
  - ping: Reply with a pong message.
echo returned: {"text":"hello, webmcp"}
```

> **Status: pre-alpha.** The q64 compiler currently round-trips only the
> single-file `hello` example, so this multi-module qube does not build or run
> yet. The source is the contract; execution lands as the toolchain matures.

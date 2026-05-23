//! dev.q64.tool_caller — depends on dev.q64.webmcp_client and drives the WebMcp client.
//!
//! WebMCP (navigator.modelContext) is browser-only and currently ships behind
//! a flag in Chrome Canary. Until the browser runtime adapter supplies a real
//! WebMcp fit, this example uses an in-process fit with two canned tools so
//! the client surface can be exercised. With a host-supplied client the body
//! of `main` is unchanged — only the source of the `WebMcp` value differs (the
//! runtime hands one in rather than `DemoTools {}`).
//!
//! Build for the browser once the toolchain can compile it:
//!
//!   qube web        # serves at http://localhost:4711/

import dev.q64.webmcp_client.{WebMcp, Tool, ToolResult, McpError, find_tool}

/// An in-process WebMcp standing in for a real page until the browser adapter
/// bridges navigator.modelContext.
pub struct DemoTools {}

pub fit DemoTools : WebMcp {
    fn list_tools(self) -> Result<[Tool], McpError> {
        Ok([
            Tool {
                name: "echo",
                description: "Echo the 'text' argument back to the caller.",
                input_schema: r#"{"type":"object","properties":{"text":{"type":"string"}},"required":["text"]}"#,
            },
            Tool {
                name: "ping",
                description: "Reply with a pong message.",
                input_schema: r#"{"type":"object","properties":{}}"#,
            },
        ])
    }

    fn call_tool(self, name: str, arguments: str) -> Result<ToolResult, McpError> {
        match name {
            "echo" -> Ok(ToolResult { content: arguments, is_error: false }),
            "ping" -> Ok(ToolResult { content: r#"{"reply":"pong"}"#, is_error: false }),
            _      -> Err(McpError.ToolNotFound(name)),
        }
    }
}

fn main {
    let mcp = DemoTools {}

    let tools = match mcp.list_tools() {
        Ok(ts) -> ts,
        Err(e) -> panic e,
    }
    env.out("page exposes {tools.len()} WebMCP tool(s):")
    for tool in tools {
        env.out("  - {tool.name}: {tool.description}")
    }

    let echo = match find_tool(mcp, "echo") {
        Ok(t)  -> t,
        Err(e) -> panic e,
    }
    let result = match mcp.call_tool(echo.name, r#"{"text":"hello, webmcp"}"#) {
        Ok(r)  -> r,
        Err(e) -> panic e,
    }
    env.out("{echo.name} returned: {result.content}")
}

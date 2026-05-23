//! q64.webmcp_client.client — the WebMcp capability and client helpers.
//! exports: WebMcp, find_tool, call
//!
//! `WebMcp` is the low-level capability a host adapter supplies: the browser
//! adapter bridges navigator.modelContext; tests and examples supply a fit
//! with canned tools. `find_tool` and `call` are host-independent helpers
//! built on top of the face, so they work against any fit.

import "./tool.q".{Tool, ToolResult}
import "./error.q".{McpError}

/// A handle to a WebMCP tool registry. The browser runtime adapter supplies
/// the production fit over navigator.modelContext; see the qube README.
pub face WebMcp {
    /// Enumerate the tools the page has registered.
    fn list_tools(self) -> Result<[Tool], McpError> @ui

    /// Invoke a registered tool by name with JSON-encoded arguments,
    /// returning its JSON-encoded result.
    fn call_tool(self, name: str, arguments: str) -> Result<ToolResult, McpError> @ui
}

/// Look up a single advertised tool by name.
pub fn find_tool(mcp: WebMcp, name: str) -> Result<Tool, McpError> {
    let tools = try mcp.list_tools()
    for tool in tools {
        if tool.name == name {
            return Ok(tool)
        }
    }
    Err(McpError.ToolNotFound(name))
}

/// Call a tool, failing with ToolNotFound before invoking if the page does
/// not advertise it.
pub fn call(mcp: WebMcp, name: str, arguments: str) -> Result<ToolResult, McpError> {
    let _ = try find_tool(mcp, name)
    mcp.call_tool(name, arguments)
}

//! q64.webmcp_client — a client for WebMCP (the Web Model Context Protocol).
//! exports: WebMcp, Tool, ToolResult, McpError, find_tool, call

pub use WebMcp, find_tool, call from "./client.q"
pub use Tool, ToolResult from "./tool.q"
pub use McpError from "./error.q"

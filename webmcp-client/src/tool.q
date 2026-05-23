//! q64.webmcp_client.tool — WebMCP protocol value types.
//! exports: Tool, ToolResult
//!
//! A WebMCP page (the "server") registers tools on navigator.modelContext;
//! each advertises a name, a natural-language description, and a JSON Schema
//! for its arguments. These records mirror that shape. All fields are str /
//! bool so they lower to the WIT canonical ABI unchanged.

/// A tool advertised by a WebMCP page.
pub struct Tool {
    name: str,
    description: str,
    input_schema: str,
}

/// The outcome of invoking a tool. `content` is the tool's JSON-encoded
/// result; `is_error` mirrors WebMCP's error flag on a tool response.
pub struct ToolResult {
    content: str,
    is_error: bool,
}

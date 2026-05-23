//! q64.webmcp_client.error — the client error type.
//! exports: McpError

/// Why a WebMCP client operation failed.
pub enum McpError {
    Unsupported,
    ToolNotFound(str),
    InvalidArguments(str),
    ExecutionFailed(str),
}

pub fit McpError : Display {
    fn fmt(self) -> str {
        match self {
            Unsupported           -> "WebMCP is not available in this environment",
            ToolNotFound(name)    -> "no WebMCP tool named '{name}'",
            InvalidArguments(msg) -> "invalid arguments: {msg}",
            ExecutionFailed(msg)  -> "tool execution failed: {msg}",
        }
    }
}

pub fit McpError : Error {}

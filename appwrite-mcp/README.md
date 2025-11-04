# MarketTrack Appwrite MCP Server

Model Context Protocol (MCP) server for MarketTrack Appwrite integration. This server provides tools and resources to interact with the MarketTrack Appwrite backend.

## Features

### Tools (13 available)

1. **get_dashboard_stats** - Get dashboard statistics (users, visits, campaigns, pending approvals)
2. **get_pending_users** - List users awaiting approval
3. **approve_user** - Approve a pending user
4. **reject_user** - Reject a pending user with reason
5. **get_all_users** - Get all users with optional filtering
6. **get_user_details** - Get detailed user information with recent visits
7. **get_recent_visits** - Get recent shop visits
8. **get_visit_details** - Get detailed visit information with photos
9. **get_campaigns** - List marketing campaigns
10. **create_campaign** - Create a new marketing campaign
11. **get_reports** - Get user-submitted reports
12. **search_users** - Search users by name, email, or phone

### Resources (3 available)

1. **appwrite://dashboard/stats** - Real-time dashboard statistics
2. **appwrite://users/pending** - Pending users list
3. **appwrite://visits/recent** - Recent shop visits

## Installation

```bash
cd appwrite-mcp
npm install
```

## Configuration

### Environment Variables

- `APPWRITE_ENDPOINT` - Appwrite API endpoint (default: https://sgp.cloud.appwrite.io/v1)
- `APPWRITE_PROJECT_ID` - Appwrite project ID (default: 690911f10028fa64956b)
- `APPWRITE_API_KEY` - Appwrite API key for server-side operations

### VS Code Integration

Add to your VS Code MCP settings (`mcp-config.json` or settings):

```json
{
  "mcpServers": {
    "markettrack-appwrite": {
      "command": "node",
      "args": ["D:\\MARKET_MANAGEMENT\\appwrite-mcp\\index.js"],
      "env": {
        "APPWRITE_ENDPOINT": "https://sgp.cloud.appwrite.io/v1",
        "APPWRITE_PROJECT_ID": "690911f10028fa64956b",
        "APPWRITE_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

## Usage

### Running Standalone

```bash
npm start
```

### Using with MCP Clients

The server uses stdio transport and can be integrated with any MCP-compatible client (VS Code Copilot, Claude Desktop, etc.)

## Collections

- **users** - User profiles and authentication
- **visits** - Shop visit records with photos
- **campaigns** - Marketing campaigns
- **reports** - User-submitted reports

## Storage Buckets

- **visit_photos** - Visit location photos
- **shop_photos** - Shop exterior/interior photos
- **campaign_materials** - Campaign assets
- **report_files** - Report attachments
- **profile_pictures** - User profile images

## Examples

### Get Dashboard Stats

```javascript
// Tool call
{
  "name": "get_dashboard_stats",
  "arguments": {}
}

// Response
{
  "totalUsers": 150,
  "pendingUsers": 12,
  "totalVisits": 1243,
  "totalCampaigns": 8,
  "timestamp": "2025-01-01T12:00:00.000Z"
}
```

### Approve User

```javascript
// Tool call
{
  "name": "approve_user",
  "arguments": {
    "userId": "user123"
  }
}

// Response
{
  "success": true,
  "user": { /* updated user document */ }
}
```

### Search Users

```javascript
// Tool call
{
  "name": "search_users",
  "arguments": {
    "query": "john",
    "limit": 10
  }
}

// Response
{
  "users": [ /* matching users */ ],
  "total": 5,
  "query": "john"
}
```

## Error Handling

All errors are returned in a standardized format:

```json
{
  "error": "Error message",
  "code": "ERROR_CODE"
}
```

## Development

```bash
# Install dependencies
npm install

# Run in development mode (with auto-reload)
npm run dev

# Production mode
npm start
```

## License

MIT

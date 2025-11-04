# Deploying MarketTrack MCP Server

This guide explains how to deploy and use the MarketTrack MCP (Model Context Protocol) server.

## What is the MCP Server?

The MCP server provides a standardized interface to interact with your MarketTrack Appwrite backend. It exposes tools and resources that can be used by AI assistants, automation scripts, and admin interfaces.

## Deployment Options

### Option 1: Local Development (Current Setup)

✅ **Recommended for: Development and testing**

The MCP server is already configured and ready to use locally.

**Status:** ✅ Ready
**Location:** `D:\MARKET_MANAGEMENT\appwrite-mcp\`
**Dependencies:** Installed ✅

**To use:**

1. The server runs via VS Code Copilot integration automatically
2. Or run manually: `npm start` from the `appwrite-mcp` directory

### Option 2: Deploy to Appwrite Functions

❌ **Not currently available** - Appwrite Functions don't support MCP's stdio transport

**Limitation:** MCP servers use stdin/stdout for communication, but Appwrite Functions use HTTP. Would require creating an HTTP wrapper.

### Option 3: Deploy Admin Web Interface (Recommended for Production)

✅ **Recommended for: Production deployment to https://marketm-anagement.appwrite.network/**

Since Appwrite deployments support static sites and Node.js, we need to create a web-based admin panel that uses the Appwrite Web SDK directly.

**Next Steps:**
1. Create static HTML/CSS/JavaScript admin interface
2. Use Appwrite Web SDK for authentication and data operations
3. Deploy to Appwrite Static Site or GitHub Pages
4. Connect to your Appwrite subdomain

## Current Architecture

```
┌─────────────────────────────────────────┐
│         Mobile App (Flutter)            │
│  ┌──────────────────────────────────┐   │
│  │   Direct Appwrite SDK Access     │   │
│  └──────────────────────────────────┘   │
└─────────────────┬───────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────┐
│      Appwrite Cloud (Singapore)         │
│  ┌──────────────────────────────────┐   │
│  │    Database + Storage + Auth     │   │
│  │  Project: 690911f10028fa64956b   │   │
│  └──────────────────────────────────┘   │
└─────────────────┬───────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────┐
│       Admin Interfaces (Multiple)       │
│  ┌──────────────────────────────────┐   │
│  │  1. MCP Server (Local/VS Code)   │   │
│  │     → AI Assistant Integration   │   │
│  │                                  │   │
│  │  2. ASP.NET Core (Local Port)   │   │
│  │     → Full-featured Web UI       │   │
│  │                                  │   │
│  │  3. Static Web UI (Future)       │   │
│  │     → Deploy to Appwrite domain  │   │
│  └──────────────────────────────────┘   │
└─────────────────────────────────────────┘
```

## Using the MCP Server

### In VS Code with GitHub Copilot

1. Ensure Node.js is installed
2. MCP server is auto-configured via `mcp-config.json`
3. Ask Copilot to interact with your MarketTrack data:

**Examples:**
- "Show me dashboard statistics for MarketTrack"
- "List pending users waiting for approval"
- "Approve user with ID xyz123"
- "Get recent shop visits"
- "Create a new campaign for summer promotion"

### Available Commands

**Dashboard & Statistics:**
- Get dashboard stats (users, visits, campaigns)
- View real-time metrics

**User Management:**
- List pending users
- Approve/reject users
- Search users by name/email/phone
- Get user details with visit history

**Visit Monitoring:**
- View recent shop visits
- Get visit details with photos
- Filter visits by user

**Campaign Management:**
- List active/completed campaigns
- Create new campaigns
- Track campaign performance

**Reports:**
- View user-submitted reports
- Filter reports by user

## Environment Variables

Required for the MCP server:

```bash
APPWRITE_ENDPOINT=https://sgp.cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=690911f10028fa64956b
APPWRITE_API_KEY=standard_57c934ee8bf3f80f6aaf1c6db2ed7e5c935b3400309426f01a48780b18668040bbcc20b98219f11751a1eeaed98bea8bb5acd9724b3700fb65a09265f5da8fb16de36afab300f6abf55076ce68b7c63003c70fe8f1b842ab49cd805f11418ae9e238dd3211083dd371b347a29c9c5620206cf68bc185122df393a0bab4fe2008
```

## Testing the MCP Server

### Manual Test

```bash
cd D:\MARKET_MANAGEMENT\appwrite-mcp
npm start
```

The server will start and wait for stdio input. Test with MCP-compatible clients.

### Integration Test (VS Code Copilot)

Ask Copilot:
```
Using the markettrack-appwrite MCP server, show me the dashboard statistics
```

## Next Steps for Production Deployment

To make the admin panel accessible at `https://marketm-anagement.appwrite.network/`:

### Option A: Static HTML Admin Panel

1. Create `admin-web/` directory
2. Build static HTML/CSS/JavaScript interface
3. Use Appwrite Web SDK (client-side)
4. Deploy to Appwrite Static Hosting
5. Connect to your subdomain

### Option B: React/Vue Admin Panel

1. Create React/Vue project in `admin-web/`
2. Install Appwrite Web SDK
3. Build admin interface components
4. Deploy built assets to Appwrite
5. Configure subdomain routing

### Option C: Next.js Admin Panel

1. Create Next.js project
2. Use Appwrite Node SDK (server-side) + Web SDK (client-side)
3. Deploy to Vercel/Netlify
4. Point subdomain via DNS/proxy

## Current Status

✅ MCP Server: Ready and functional
✅ ASP.NET Admin: Working locally (http://localhost:5000)
✅ Mobile App: APK building
❌ Web Admin at Appwrite domain: Not yet created

## Recommendation

For fastest deployment to `https://marketm-anagement.appwrite.network/`:

**Create a static HTML admin panel** that uses the Appwrite Web SDK directly. This will work with Appwrite's static hosting and can be deployed immediately.

Would you like me to create this static admin panel now?

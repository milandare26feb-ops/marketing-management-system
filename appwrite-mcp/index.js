#!/usr/bin/env node
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { Client, Databases, Storage, Query, ID } from 'node-appwrite';

const APPWRITE_ENDPOINT = process.env.APPWRITE_ENDPOINT || 'https://sgp.cloud.appwrite.io/v1';
const APPWRITE_PROJECT_ID = process.env.APPWRITE_PROJECT_ID || '690911f10028fa64956b';
const APPWRITE_API_KEY = process.env.APPWRITE_API_KEY || 'standard_57c934ee8bf3f80f6aaf1c6db2ed7e5c935b3400309426f01a48780b18668040bbcc20b98219f11751a1eeaed98bea8bb5acd9724b3700fb65a09265f5da8fb16de36afab300f6abf55076ce68b7c63003c70fe8f1b842ab49cd805f11418ae9e238dd3211083dd371b347a29c9c5620206cf68bc185122df393a0bab4fe2008';
const DATABASE_ID = 'markettrack_db';

// Initialize Appwrite client
const client = new Client()
  .setEndpoint(APPWRITE_ENDPOINT)
  .setProject(APPWRITE_PROJECT_ID)
  .setKey(APPWRITE_API_KEY);

const databases = new Databases(client);
const storage = new Storage(client);

// Collection IDs
const COLLECTIONS = {
  USERS: 'users',
  VISITS: 'visits',
  CAMPAIGNS: 'campaigns',
  REPORTS: 'reports'
};

// Storage Bucket IDs
const BUCKETS = {
  PHOTOS: 'visit_photos',
  SHOP_PHOTOS: 'shop_photos',
  CAMPAIGN_MATERIALS: 'campaign_materials',
  REPORTS: 'report_files',
  PROFILE_PICTURES: 'profile_pictures'
};

// Create MCP Server
const server = new Server(
  {
    name: 'markettrack-appwrite-server',
    version: '1.0.0',
  },
  {
    capabilities: {
      resources: {},
      tools: {},
    },
  }
);

// ==================== TOOLS ====================

// Tool: Get Dashboard Statistics
server.setRequestHandler('tools/list', async () => ({
  tools: [
    {
      name: 'get_dashboard_stats',
      description: 'Get dashboard statistics including total users, visits, campaigns, and pending approvals',
      inputSchema: {
        type: 'object',
        properties: {},
      },
    },
    {
      name: 'get_pending_users',
      description: 'Get list of users pending approval',
      inputSchema: {
        type: 'object',
        properties: {
          limit: { type: 'number', description: 'Number of results to return', default: 25 },
          offset: { type: 'number', description: 'Offset for pagination', default: 0 },
        },
      },
    },
    {
      name: 'approve_user',
      description: 'Approve a pending user by updating their status',
      inputSchema: {
        type: 'object',
        properties: {
          userId: { type: 'string', description: 'User document ID to approve' },
        },
        required: ['userId'],
      },
    },
    {
      name: 'reject_user',
      description: 'Reject a pending user by updating their status',
      inputSchema: {
        type: 'object',
        properties: {
          userId: { type: 'string', description: 'User document ID to reject' },
          reason: { type: 'string', description: 'Reason for rejection' },
        },
        required: ['userId'],
      },
    },
    {
      name: 'get_all_users',
      description: 'Get all users with optional filtering',
      inputSchema: {
        type: 'object',
        properties: {
          status: { type: 'string', description: 'Filter by status: pending, approved, rejected, active, inactive' },
          limit: { type: 'number', description: 'Number of results to return', default: 25 },
          offset: { type: 'number', description: 'Offset for pagination', default: 0 },
        },
      },
    },
    {
      name: 'get_user_details',
      description: 'Get detailed information about a specific user',
      inputSchema: {
        type: 'object',
        properties: {
          userId: { type: 'string', description: 'User document ID' },
        },
        required: ['userId'],
      },
    },
    {
      name: 'get_recent_visits',
      description: 'Get recent shop visits with details',
      inputSchema: {
        type: 'object',
        properties: {
          limit: { type: 'number', description: 'Number of results to return', default: 25 },
          userId: { type: 'string', description: 'Filter by user ID (optional)' },
        },
      },
    },
    {
      name: 'get_visit_details',
      description: 'Get detailed information about a specific visit including photos',
      inputSchema: {
        type: 'object',
        properties: {
          visitId: { type: 'string', description: 'Visit document ID' },
        },
        required: ['visitId'],
      },
    },
    {
      name: 'get_campaigns',
      description: 'Get all campaigns with optional status filter',
      inputSchema: {
        type: 'object',
        properties: {
          status: { type: 'string', description: 'Filter by status: active, completed, scheduled' },
          limit: { type: 'number', description: 'Number of results to return', default: 25 },
        },
      },
    },
    {
      name: 'create_campaign',
      description: 'Create a new marketing campaign',
      inputSchema: {
        type: 'object',
        properties: {
          name: { type: 'string', description: 'Campaign name' },
          description: { type: 'string', description: 'Campaign description' },
          startDate: { type: 'string', description: 'Start date (ISO 8601)' },
          endDate: { type: 'string', description: 'End date (ISO 8601)' },
          targetAudience: { type: 'string', description: 'Target audience description' },
          budget: { type: 'number', description: 'Campaign budget' },
        },
        required: ['name', 'description', 'startDate', 'endDate'],
      },
    },
    {
      name: 'get_reports',
      description: 'Get user-submitted reports',
      inputSchema: {
        type: 'object',
        properties: {
          userId: { type: 'string', description: 'Filter by user ID (optional)' },
          limit: { type: 'number', description: 'Number of results to return', default: 25 },
        },
      },
    },
    {
      name: 'search_users',
      description: 'Search users by name, email, or phone',
      inputSchema: {
        type: 'object',
        properties: {
          query: { type: 'string', description: 'Search query' },
          limit: { type: 'number', description: 'Number of results to return', default: 25 },
        },
        required: ['query'],
      },
    },
  ],
}));

// Tool Call Handler
server.setRequestHandler('tools/call', async (request) => {
  const { name, arguments: args } = request.params;

  try {
    switch (name) {
      case 'get_dashboard_stats': {
        const [totalUsers, pendingUsers, totalVisits, totalCampaigns] = await Promise.all([
          databases.listDocuments(DATABASE_ID, COLLECTIONS.USERS).then(r => r.total),
          databases.listDocuments(DATABASE_ID, COLLECTIONS.USERS, [
            Query.equal('status', 'pending')
          ]).then(r => r.total),
          databases.listDocuments(DATABASE_ID, COLLECTIONS.VISITS).then(r => r.total),
          databases.listDocuments(DATABASE_ID, COLLECTIONS.CAMPAIGNS).then(r => r.total),
        ]);

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              totalUsers,
              pendingUsers,
              totalVisits,
              totalCampaigns,
              timestamp: new Date().toISOString(),
            }, null, 2),
          }],
        };
      }

      case 'get_pending_users': {
        const { limit = 25, offset = 0 } = args;
        const response = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.USERS,
          [
            Query.equal('status', 'pending'),
            Query.orderDesc('$createdAt'),
            Query.limit(limit),
            Query.offset(offset),
          ]
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              users: response.documents,
              total: response.total,
              limit,
              offset,
            }, null, 2),
          }],
        };
      }

      case 'approve_user': {
        const { userId } = args;
        const updated = await databases.updateDocument(
          DATABASE_ID,
          COLLECTIONS.USERS,
          userId,
          {
            status: 'approved',
            approvedAt: new Date().toISOString(),
          }
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({ success: true, user: updated }, null, 2),
          }],
        };
      }

      case 'reject_user': {
        const { userId, reason = 'Not specified' } = args;
        const updated = await databases.updateDocument(
          DATABASE_ID,
          COLLECTIONS.USERS,
          userId,
          {
            status: 'rejected',
            rejectionReason: reason,
            rejectedAt: new Date().toISOString(),
          }
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({ success: true, user: updated }, null, 2),
          }],
        };
      }

      case 'get_all_users': {
        const { status, limit = 25, offset = 0 } = args;
        const queries = [
          Query.orderDesc('$createdAt'),
          Query.limit(limit),
          Query.offset(offset),
        ];

        if (status) {
          queries.unshift(Query.equal('status', status));
        }

        const response = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.USERS,
          queries
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              users: response.documents,
              total: response.total,
              limit,
              offset,
            }, null, 2),
          }],
        };
      }

      case 'get_user_details': {
        const { userId } = args;
        const user = await databases.getDocument(DATABASE_ID, COLLECTIONS.USERS, userId);
        
        // Get user's visits
        const visits = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.VISITS,
          [
            Query.equal('userId', userId),
            Query.orderDesc('$createdAt'),
            Query.limit(10),
          ]
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              user,
              recentVisits: visits.documents,
              totalVisits: visits.total,
            }, null, 2),
          }],
        };
      }

      case 'get_recent_visits': {
        const { limit = 25, userId } = args;
        const queries = [
          Query.orderDesc('$createdAt'),
          Query.limit(limit),
        ];

        if (userId) {
          queries.unshift(Query.equal('userId', userId));
        }

        const response = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.VISITS,
          queries
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              visits: response.documents,
              total: response.total,
            }, null, 2),
          }],
        };
      }

      case 'get_visit_details': {
        const { visitId } = args;
        const visit = await databases.getDocument(DATABASE_ID, COLLECTIONS.VISITS, visitId);

        // Get user details
        let user = null;
        if (visit.userId) {
          try {
            user = await databases.getDocument(DATABASE_ID, COLLECTIONS.USERS, visit.userId);
          } catch (e) {
            console.error('Error fetching user:', e);
          }
        }

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              visit,
              user,
            }, null, 2),
          }],
        };
      }

      case 'get_campaigns': {
        const { status, limit = 25 } = args;
        const queries = [
          Query.orderDesc('$createdAt'),
          Query.limit(limit),
        ];

        if (status) {
          queries.unshift(Query.equal('status', status));
        }

        const response = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.CAMPAIGNS,
          queries
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              campaigns: response.documents,
              total: response.total,
            }, null, 2),
          }],
        };
      }

      case 'create_campaign': {
        const { name, description, startDate, endDate, targetAudience = '', budget = 0 } = args;
        
        const campaign = await databases.createDocument(
          DATABASE_ID,
          COLLECTIONS.CAMPAIGNS,
          ID.unique(),
          {
            name,
            description,
            startDate,
            endDate,
            targetAudience,
            budget,
            status: 'scheduled',
            createdAt: new Date().toISOString(),
          }
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({ success: true, campaign }, null, 2),
          }],
        };
      }

      case 'get_reports': {
        const { userId, limit = 25 } = args;
        const queries = [
          Query.orderDesc('$createdAt'),
          Query.limit(limit),
        ];

        if (userId) {
          queries.unshift(Query.equal('userId', userId));
        }

        const response = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.REPORTS,
          queries
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              reports: response.documents,
              total: response.total,
            }, null, 2),
          }],
        };
      }

      case 'search_users': {
        const { query, limit = 25 } = args;
        
        // Search across multiple fields
        const response = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.USERS,
          [
            Query.search('fullName', query),
            Query.limit(limit),
          ]
        );

        return {
          content: [{
            type: 'text',
            text: JSON.stringify({
              users: response.documents,
              total: response.total,
              query,
            }, null, 2),
          }],
        };
      }

      default:
        throw new Error(`Unknown tool: ${name}`);
    }
  } catch (error) {
    return {
      content: [{
        type: 'text',
        text: JSON.stringify({
          error: error.message,
          code: error.code || 'UNKNOWN_ERROR',
        }, null, 2),
      }],
      isError: true,
    };
  }
});

// ==================== RESOURCES ====================

server.setRequestHandler('resources/list', async () => ({
  resources: [
    {
      uri: 'appwrite://dashboard/stats',
      name: 'Dashboard Statistics',
      description: 'Real-time dashboard statistics',
      mimeType: 'application/json',
    },
    {
      uri: 'appwrite://users/pending',
      name: 'Pending Users',
      description: 'List of users waiting for approval',
      mimeType: 'application/json',
    },
    {
      uri: 'appwrite://visits/recent',
      name: 'Recent Visits',
      description: 'Recent shop visits',
      mimeType: 'application/json',
    },
  ],
}));

server.setRequestHandler('resources/read', async (request) => {
  const { uri } = request.params;

  try {
    switch (uri) {
      case 'appwrite://dashboard/stats': {
        const [totalUsers, pendingUsers, totalVisits, totalCampaigns] = await Promise.all([
          databases.listDocuments(DATABASE_ID, COLLECTIONS.USERS).then(r => r.total),
          databases.listDocuments(DATABASE_ID, COLLECTIONS.USERS, [
            Query.equal('status', 'pending')
          ]).then(r => r.total),
          databases.listDocuments(DATABASE_ID, COLLECTIONS.VISITS).then(r => r.total),
          databases.listDocuments(DATABASE_ID, COLLECTIONS.CAMPAIGNS).then(r => r.total),
        ]);

        return {
          contents: [{
            uri,
            mimeType: 'application/json',
            text: JSON.stringify({
              totalUsers,
              pendingUsers,
              totalVisits,
              totalCampaigns,
              timestamp: new Date().toISOString(),
            }, null, 2),
          }],
        };
      }

      case 'appwrite://users/pending': {
        const response = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.USERS,
          [
            Query.equal('status', 'pending'),
            Query.orderDesc('$createdAt'),
            Query.limit(25),
          ]
        );

        return {
          contents: [{
            uri,
            mimeType: 'application/json',
            text: JSON.stringify(response.documents, null, 2),
          }],
        };
      }

      case 'appwrite://visits/recent': {
        const response = await databases.listDocuments(
          DATABASE_ID,
          COLLECTIONS.VISITS,
          [
            Query.orderDesc('$createdAt'),
            Query.limit(25),
          ]
        );

        return {
          contents: [{
            uri,
            mimeType: 'application/json',
            text: JSON.stringify(response.documents, null, 2),
          }],
        };
      }

      default:
        throw new Error(`Unknown resource: ${uri}`);
    }
  } catch (error) {
    throw new Error(`Failed to read resource ${uri}: ${error.message}`);
  }
});

// Start the server
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error('MarketTrack Appwrite MCP Server running on stdio');
}

main().catch((error) => {
  console.error('Fatal error in main():', error);
  process.exit(1);
});

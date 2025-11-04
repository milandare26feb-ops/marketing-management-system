// Quick test script for MCP server
// This simulates MCP protocol communication

import { spawn } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

console.log('🧪 Testing MarketTrack MCP Server...\n');

const serverPath = join(__dirname, 'index.js');
const server = spawn('node', [serverPath], {
  env: {
    ...process.env,
    APPWRITE_ENDPOINT: 'https://sgp.cloud.appwrite.io/v1',
    APPWRITE_PROJECT_ID: '690911f10028fa64956b',
    APPWRITE_API_KEY: 'standard_57c934ee8bf3f80f6aaf1c6db2ed7e5c935b3400309426f01a48780b18668040bbcc20b98219f11751a1eeaed98bea8bb5acd9724b3700fb65a09265f5da8fb16de36afab300f6abf55076ce68b7c63003c70fe8f1b842ab49cd805f11418ae9e238dd3211083dd371b347a29c9c5620206cf68bc185122df393a0bab4fe2008',
  },
  stdio: ['pipe', 'pipe', 'pipe'],
});

let responseData = '';

server.stdout.on('data', (data) => {
  const text = data.toString();
  responseData += text;
  console.log('📥 Server Response:', text);
});

server.stderr.on('data', (data) => {
  console.log('ℹ️  Server Log:', data.toString());
});

server.on('close', (code) => {
  console.log(`\n✅ Server process exited with code ${code}`);
  process.exit(code);
});

// Wait for server to start
setTimeout(() => {
  console.log('\n📤 Sending initialize request...');
  
  // Send MCP initialize request
  const initRequest = {
    jsonrpc: '2.0',
    id: 1,
    method: 'initialize',
    params: {
      protocolVersion: '2024-11-05',
      capabilities: {},
      clientInfo: {
        name: 'test-client',
        version: '1.0.0',
      },
    },
  };
  
  server.stdin.write(JSON.stringify(initRequest) + '\n');
  
  // Wait a bit then list tools
  setTimeout(() => {
    console.log('\n📤 Sending tools/list request...');
    const toolsRequest = {
      jsonrpc: '2.0',
      id: 2,
      method: 'tools/list',
      params: {},
    };
    server.stdin.write(JSON.stringify(toolsRequest) + '\n');
    
    // Wait then close
    setTimeout(() => {
      console.log('\n🏁 Test complete. Closing server...');
      server.kill();
    }, 2000);
  }, 1000);
}, 1000);

// Handle errors
server.on('error', (error) => {
  console.error('❌ Error:', error);
  process.exit(1);
});

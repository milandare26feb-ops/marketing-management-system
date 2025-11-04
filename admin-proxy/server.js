const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const path = require('path');
const app = express();

const PORT = process.env.PORT || 3000;
const ADMIN_PANEL_URL = 'http://localhost:5000';

// Serve static files from admin panel build
app.use(express.static(path.join(__dirname, '../deploy/admin/wwwroot')));

// Proxy API requests to .NET backend
app.use('/api', createProxyMiddleware({
  target: ADMIN_PANEL_URL,
  changeOrigin: true,
  pathRewrite: {
    '^/api': ''
  }
}));

// Fallback to index.html for SPA
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../deploy/admin/wwwroot', 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 MarketTrack Admin Proxy running on port ${PORT}`);
  console.log(`📊 Dashboard: http://localhost:${PORT}`);
});

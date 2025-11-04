#!/bin/bash

# MarketTrack Deployment Script for Appwrite

echo "🚀 Starting MarketTrack deployment..."

# 1. Build Admin Panel
echo "📦 Building Admin Panel..."
cd MarketTrackAdmin
dotnet publish -c Release -o ../deploy/admin
cd ..

# 2. Deploy to Appwrite
echo "☁️ Deploying to Appwrite..."

# Install Appwrite CLI if not installed
if ! command -v appwrite &> /dev/null; then
    echo "Installing Appwrite CLI..."
    npm install -g appwrite-cli
fi

# Login to Appwrite
echo "🔐 Logging in to Appwrite..."
appwrite login

# Set project
echo "🎯 Setting project..."
appwrite client --endpoint https://sgp.cloud.appwrite.io/v1 \
    --projectId 690911f10028fa64956b \
    --key standard_57c934ee8bf3f80f6aaf1c6db2ed7e5c935b3400309426f01a48780b18668040bbcc20b98219f11751a1eeaed98bea8bb5acd9724b3700fb65a09265f5da8fb16de36afab300f6abf55076ce68b7c63003c70fe8f1b842ab49cd805f11418ae9e238dd3211083dd371b347a29c9c5620206cf68bc185122df393a0bab4fe2008

# Deploy database schema
echo "🗄️ Deploying database schema..."
appwrite deploy collection --all

# Deploy storage buckets
echo "📂 Deploying storage buckets..."
appwrite deploy bucket --all

# 3. Commit and push to GitHub
echo "📤 Pushing to GitHub..."
git add .
git commit -m "Deployment: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main

echo "✅ Deployment complete!"
echo "🌐 Admin Panel: https://marketm-anagement.appwrite.network/"
echo "📱 Mobile App: Build APK from mobile_app folder"

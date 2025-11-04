# 🚀 Appwrite Subdomain Deployment - Step by Step

## ✅ Build Complete!

Static files তৈরি হয়ে গেছে: `D:\MARKET_MANAGEMENT\admin-web\out\`

---

## 📋 Deployment Steps (Manual - Appwrite Console)

### Step 1: Appwrite Console এ যান

1. Open: https://cloud.appwrite.io/console
2. Login করুন
3. আপনার MarketTrack project (690911f10028fa64956b) select করুন

---

### Step 2: Storage Bucket Create করুন (যদি না থাকে)

1. Left sidebar → **Storage** click করুন
2. **Create Bucket** button click করুন
3. Bucket configuration:
   - **Bucket ID:** `admin-panel`
   - **Name:** `Admin Panel`
   - **Permissions:** Public (Read access for all)
   - **File Security:** Disabled
   - **Maximum File Size:** 50MB
   - Click **Create**

---

### Step 3: Static Files Upload করুন

#### Method A: Manual Upload (Recommended)

1. Storage → `admin-panel` bucket open করুন
2. **Upload File** button click করুন
3. Navigate to: `D:\MARKET_MANAGEMENT\admin-web\out\`
4. Select ALL files এবং folders:
   - `index.html`
   - `404.html`
   - `favicon.ico`
   - `_next/` folder (সম্পূর্ণ)
   - All SVG files
5. Upload করুন (takes 2-3 minutes)

#### Method B: Using Appwrite CLI

```powershell
cd D:\MARKET_MANAGEMENT\admin-web
appwrite storage createFile --bucketId admin-panel --fileId unique() --file ./out/index.html
# Repeat for all files
```

---

### Step 4: Configure Domain

1. Appwrite Console → **Settings** → **Domains**
2. আপনার deployment domain দেখুন:
   - Format: `https://marketm-anagement.appwrite.network/`
3. **Add Custom Route:**
   - Path: `/`
   - Target: Storage Bucket → `admin-panel`
   - File: `index.html`

---

### Step 5: Set Environment Variables (Optional)

যদি Appwrite Functions ব্যবহার করতে চান:

1. Go to **Functions**
2. Create new function
3. Add environment variables:
   ```
   APPWRITE_ENDPOINT=https://sgp.cloud.appwrite.io/v1
   APPWRITE_PROJECT_ID=690911f10028fa64956b
   DATABASE_ID=markettrack_db
   ```

---

## 🎯 Alternative: GitHub Pages Deployment

যেহেতু আপনার GitHub repo already connected:

### Option: Deploy to GitHub Pages

1. **Create `.github/workflows/deploy.yml`:**

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: admin-web
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Build
      run: npm run build
      env:
        NEXT_PUBLIC_APPWRITE_ENDPOINT: ${{ secrets.APPWRITE_ENDPOINT }}
        NEXT_PUBLIC_APPWRITE_PROJECT_ID: ${{ secrets.APPWRITE_PROJECT_ID }}
        NEXT_PUBLIC_APPWRITE_DATABASE_ID: ${{ secrets.APPWRITE_DATABASE_ID }}
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./admin-web/out
```

2. **GitHub Settings:**
   - Repository → Settings → Pages
   - Source: Deploy from a branch
   - Branch: `gh-pages`
   - Folder: `/ (root)`

3. **Add Secrets:**
   - Settings → Secrets → Actions
   - Add: `APPWRITE_ENDPOINT`, `APPWRITE_PROJECT_ID`, `APPWRITE_DATABASE_ID`

---

## ⚡ Fastest Method: Vercel Deployment

**Time: 5 minutes**

1. Go to: https://vercel.com/new
2. Import Git Repository: `marketing-management-system`
3. Configure:
   - **Root Directory:** `admin-web`
   - **Framework Preset:** Next.js (auto-detected)
4. Add Environment Variables (copy from `.env.local`)
5. Click **Deploy**
6. Wait 2-3 minutes
7. Your admin panel is LIVE! ✅

**Custom Domain:**
- Vercel Dashboard → Settings → Domains
- Add: `marketm-anagement.appwrite.network`
- Update DNS (Vercel will provide CNAME)

---

## 📊 Deployment Status

| Method | Time | Difficulty | Cost | Recommendation |
|--------|------|-----------|------|----------------|
| **Vercel** | 5 min | ⭐ Easy | Free | ✅ BEST |
| **GitHub Pages** | 10 min | ⭐⭐ Medium | Free | ✅ Good |
| **Appwrite Storage** | 15 min | ⭐⭐⭐ Hard | Free | ⚠️ Limited |

---

## 🎯 My Recommendation

**Use Vercel** - It's the fastest and most professional:

✅ Automatic deployments (git push = auto deploy)  
✅ Free SSL certificate  
✅ Global CDN (fast worldwide)  
✅ Custom domain support  
✅ Analytics built-in  
✅ Zero configuration  

**Next Best:** GitHub Pages with Actions

---

## 🔗 Current Files

- ✅ Static build: `D:\MARKET_MANAGEMENT\admin-web\out\`
- ✅ Total files: 10+ files including `index.html`, `_next/` folder
- ✅ Size: ~2-3 MB
- ✅ Ready to deploy!

---

## ❓ What Do You Want?

1. **"Vercel deploy করো"** - 5 মিনিটে live হবে (EASIEST) ⭐
2. **"GitHub Pages deploy করো"** - GitHub Actions setup করি (10 min)
3. **"Appwrite Console manually করব"** - আমি guide দিচ্ছি (15 min)

আপনার choice?

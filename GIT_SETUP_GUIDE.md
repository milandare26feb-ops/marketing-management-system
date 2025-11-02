# 🔧 Git Installation & GitHub Setup Guide

## 📥 Step 1: Git Install করুন

### Windows এ Git Install:

1. **Git ডাউনলোড করুন:**
   - যান: https://git-scm.com/download/win
   - "64-bit Git for Windows Setup" ডাউনলোড করুন

2. **Install করুন:**
   - Downloaded file run করুন
   - সব default settings রাখুন
   - "Finish" ক্লিক করুন

3. **Verify করুন:**
   ```powershell
   git --version
   ```
   Output: `git version 2.x.x`

---

## 🔐 Step 2: GitHub Authentication Setup

### Option A: Personal Access Token (Recommended)

1. **GitHub এ যান:**
   - https://github.com/settings/tokens

2. **New Token তৈরি করুন:**
   - Click: "Generate new token" → "Classic"
   - Note: `MarketTrack Mobile App`
   - Expiration: `No expiration` (বা আপনার পছন্দ)
   - Select scopes:
     - ✅ `repo` (full control)
     - ✅ `workflow`
     - ✅ `write:packages`

3. **Token Copy করুন:**
   - Token দেখানো হলে **copy করুন** (একবারই দেখাবে!)

4. **Git Config করুন:**
   ```powershell
   git config --global user.name "Your Name"
   git config --global user.email "ibnatfm@gmail.com"
   ```

5. **Repository Clone/Push করুন:**
   ```powershell
   cd D:\MARKET_MANAGEMENT
   git init
   git remote add origin https://github.com/milandare26feb-ops/marketing-management-system.git
   git add .
   git commit -m "✨ MarketTrack Mobile App with Appwrite"
   git branch -M main
   git push -u origin main
   ```

   **যখন password চাইবে:**
   - Username: `milandare26feb-ops`
   - Password: `YOUR_PERSONAL_ACCESS_TOKEN` (copy করা token paste করুন)

---

### Option B: GitHub CLI (আরও সহজ)

1. **GitHub CLI Install:**
   - ডাউনলোড: https://cli.github.com/
   - Install করুন

2. **Login করুন:**
   ```powershell
   gh auth login
   ```
   - Select: `GitHub.com`
   - Select: `HTTPS`
   - Select: `Login with a web browser`
   - Browser এ authorize করুন

3. **Push করুন:**
   ```powershell
   cd D:\MARKET_MANAGEMENT
   git init
   git add .
   git commit -m "✨ MarketTrack Mobile App"
   gh repo create marketing-management-system --public --source=. --push
   ```

---

## 🚀 Step 3: GitHub Actions Check করুন

1. **Repository এ যান:**
   - https://github.com/milandare26feb-ops/marketing-management-system

2. **Actions Tab:**
   - "Actions" tab ক্লিক করুন
   - Workflow run হচ্ছে কিনা দেখুন

3. **APK Download:**
   - Workflow complete হলে
   - "Artifacts" section এ
   - `markettrack-android-apk` ডাউনলোড করুন

---

## 🎯 Quick Commands

```powershell
# Check Git status
git status

# Add all files
git add .

# Commit changes
git commit -m "Your message"

# Push to GitHub
git push origin main

# Pull latest changes
git pull origin main

# View commit history
git log --oneline
```

---

## ❓ Troubleshooting

### Problem: "git: command not found"
**Solution:** Git install করার পর PowerShell restart করুন

### Problem: "Authentication failed"
**Solution:** Personal Access Token ব্যবহার করুন (password নয়)

### Problem: "Repository not found"
**Solution:** Repository URL check করুন:
```powershell
git remote -v
```

---

## 📞 Need Help?

- **Email:** ibnatfm@gmail.com
- **GitHub:** https://github.com/milandare26feb-ops

---

**আপনি এখন GitHub authentication করতে পারবেন!** 🎉

Good—you picked a useful tool, but don’t assume it’s “install and magic”. It’s a **Node/Next.js app that generates marketing assets**, not a plug-and-play Flutter plugin.

I’ll guide you properly.

---

# 🧠 What you are installing

This repo:
👉 runs a **Next.js web app locally**

You don’t “install” it like Flutter.
You:

> clone → install dependencies → run dev server → generate screenshots in browser

---

# 🟢 STEP 1 — Clone the repo

Open terminal:

```bash id="c1cl1"
git clone https://github.com/ParthJadhav/app-store-screenshots.git
```

Then:

```bash id="c1cl2"
cd app-store-screenshots
```

---

# 🟢 STEP 2 — Install dependencies

Make sure you have Node.js installed (v18+ recommended).

Then run:

```bash id="c1cl3"
npm install
```

or if it uses pnpm:

```bash id="c1cl4"
pnpm install
```

If you don’t know:
👉 try `npm install` first

---

# 🟢 STEP 3 — Start the app

```bash id="c1cl5"
npm run dev
```

Then open:

```txt id="c1cl6"
http://localhost:3000
```

---

# 🧠 What you’ll see

A web interface where you can:

* define app name
* choose theme/colors
* define features
* generate screenshots

---

# 🟡 STEP 4 — Configure your app (IMPORTANT)

Inside the project, look for something like:

* `config`
* `data`
* `settings.json`
* or a form in UI

You will set:

### Example for Spendly:

* App Name: Spendly
* Tagline: Track your expenses easily
* Theme color: your brand color
* Screens:

  * Dashboard
  * Add expense
  * Analytics

---

# 🟢 STEP 5 — Generate screenshots

Usually there’s a button like:

```txt id="c1cl7"
Generate / Export / Download
```

It will output:

* PNG screenshots
* App Store / Play Store sizes
* Mockups

---

# 🔥 VERY IMPORTANT (where people mess up)

## 1. This is NOT connected to Flutter

It does NOT read your app automatically.

You manually input:

* UI descriptions
* screenshots (sometimes uploaded)
* text

---

## 2. You still need real screenshots from your app

So flow is:

1. Run Spendly app
2. Take screenshots
3. Feed them into this tool
4. It beautifies + markets them

---

## 3. If it fails to run

Common issues:

### Node version mismatch

Fix:

```bash id="c1cl8"
node -v
```

If below 18 → upgrade Node.js

---

### Missing dependency errors

Run:

```bash id="c1cl9"
npm install --legacy-peer-deps
```

---

# 🧠 What this tool is REALLY for

Not for developers.

It is for:

> turning a working app into a **marketable product**

That’s the missing step most devs ignore.

---

# 🔥 Brutal truth

Right now your situation is:

* ✔ You can build apps (Flutter)
* ✔ You can deploy (AAB ready)
* ❌ You are weak on **product packaging**

This tool fixes that gap.

---

# 🧭 If you want next level help

I can:

* Help you generate **Spendly Play Store screenshots (high conversion)**
* Write your Play Store description that actually gets installs
* Or build you a **manual Figma-style screenshot system (better than this repo)**

Just say: **“make Spendly store ready”**

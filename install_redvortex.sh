#!/bin/bash

# 🚀 RedVortex Installer - All in One Setup
echo -e "\n🧠 Installing RedVortex Hacker Level-Up System..."

# ─────────────[ STEP 1: Dependency Check ]─────────────
echo -e "\n📦 Checking dependencies..."

if ! command -v bc &>/dev/null; then
    echo "🔧 Installing 'bc' (required for XP math)..."
    sudo apt update && sudo apt install bc -y
else
    echo "✅ 'bc' is already installed."
fi

# ─────────────[ STEP 2: Move Roadmap File ]─────────────
echo -e "\n📁 Setting up roadmap file..."

if [ -f "$HOME/.redvortex_roadmap" ]; then
    echo "🛑 Existing .redvortex_roadmap found. Backing it up..."
    mv "$HOME/.redvortex_roadmap" "$HOME/.redvortex_roadmap.bak"
fi

if [ -f "redvortex_roadmap.txt" ]; then
    cp "redvortex_roadmap.txt" "$HOME/.redvortex_roadmap"
    chmod 644 "$HOME/.redvortex_roadmap"
    echo "✅ Roadmap installed to: $HOME/.redvortex_roadmap"
else
    echo "❌ redvortex_roadmap.txt not found! Please ensure it's in the same folder as this installer."
    exit 1
fi

# ─────────────[ STEP 3: Set Permissions ]─────────────
echo -e "\n🛠 Setting script permissions..."
chmod +x final_ver_lev_up_sys.sh

# ─────────────[ DONE ]─────────────
echo -e "\n🎉 RedVortex is ready!"
echo -e "👉 Run your XP system with:\n"
echo -e "   ./final_ver_lev_up_sys.sh\n"
echo -e "🧠 Level up. Log your progress. Become a legend.\n"


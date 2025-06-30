# 🧠 RedVortex XP System

🚀 A terminal-based hacker leveling system that turns your learning journey into a gamified RPG experience.

Level up your skills, earn XP, complete quests, track your stats, and build your personal hacker legacy — all from the terminal.

---

## 📂 What's Included

| File                    | Purpose                                                |
|-------------------------|--------------------------------------------------------|
| `final_ver_lev_up_sys.sh`   | Main XP system script — Control panel, XP, quests     |
| `redvortex_roadmap.txt`     | Editable roadmap with phase tasks and daily quests    |
| `install_redvortex.sh`      | One-click installer — sets up roadmap, installs deps  |

---

## ⚙️ Installation

Clone the repo and run the installer:

```bash
git clone https://github.com/YourUsername/RedVortex-XP-System.git
cd RedVortex-XP-System
bash install_redvortex.sh
```

This will:
- ✅ Install `bc` (required for XP math)
- ✅ Move and rename the roadmap file to `~/.redvortex_roadmap`
- ✅ Make your XP system script executable

---

## 🧩 Features

- 🎯 XP Tracking + Level System
- 📚 Skillbook with unlockable skills by level
- 📈 Rank Progress Bar with milestones
- 🧩 Daily Quest Generator from roadmap phases
- 🔥 Custom Terminal Control Panel Interface
- 📅 Lifetime Stats + Streak Tracker
- 🛠 Add, Complete, and Manage Quests

---

## 🗂 File Breakdown

- `~/.redvortex_roadmap` → Stores your quest roadmap, phase-wise
- `~/.redvortex_xp` → Tracks XP (auto-generated)
- `~/.redvortex_lvl` → Tracks current level (auto-generated)
- `~/.redvortex_daily_log` → Logs XP gain history
- `~/.redvortex_quests` → Tracks quest descriptions, XP, status

> 🛑 Files like XP and log files are hidden for a reason. Do **not** upload them unless scrubbed.

---

## 🧠 Example Commands

```bash
./final_ver_lev_up_sys.sh    # Launch control panel

# Inside Control Panel:
# [1] Add XP
# [2] View Skillbook
# [3] Show Rank Progress
# [4] Daily XP Summary
# [5] Lifetime Stats
# [9] Generate Daily Quest (from roadmap)
```

---

## ✨ Customize It

- Edit `redvortex_roadmap.txt` with your own phases/tasks
- Change XP rewards, skill names, or ranks
- Automate your hacking journey with structured growth

---

## 💻 Requirements

- bash (any modern Linux shell)
- `bc` (will be auto-installed)
- Optional: `lolcat`, `figlet` for visual upgrades

---

## 📜 License

MIT License – Use it, remix it, learn from it.

---

🧠 Built by hackers, for hackers. Make it yours. Make it legendary.

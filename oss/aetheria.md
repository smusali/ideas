# **Aetheria** — *Simple Mental Health Tracking CLI*

*A lightweight, open-source command-line tool that helps you track your mental health and mood with privacy and simplicity.*

---

## **What is Aetheria?**

Aetheria is a simple CLI tool that lets you track your daily mood, mental health symptoms, and wellness activities directly from your terminal. Perfect for people who want to monitor their mental health without complex tools or privacy concerns.

---

## **Core Features (MVP - 7 Days)**

### **Day 1-2: Basic Setup**
- CLI interface with command parsing
- Local data storage (JSON/SQLite)
- Basic mood entry system

### **Day 3-4: Core Functionality**
- Daily mood rating (1-10 scale)
- Basic symptom tracking (anxiety, depression, sleep)
- Wellness activity logging (exercise, meditation, social)
- Simple mood visualization in terminal

### **Day 5-6: Enhanced Features**
- Notes field for each entry
- Export data to CSV/JSON
- Basic mood trends and statistics
- Privacy controls and data encryption

### **Day 7: Polish & Deploy**
- Package for npm/pip/cargo
- Write comprehensive documentation
- Create installation scripts

---

## **Simple Data Model**

```json
{
  "entries": [
    {
      "id": "uuid",
      "date": "YYYY-MM-DD",
      "mood_rating": 1-10,
      "anxiety_level": 1-10,
      "depression_level": 1-10,
      "sleep_hours": 0-24,
      "activities": ["exercise", "meditation"],
      "notes": "string",
      "created_at": "datetime"
    }
  ],
  "config": {
    "encryption_enabled": true,
    "data_path": "string"
  }
}
```

---

## **Installation & Usage**

```bash
# Install via npm
npm install -g aetheria-cli

# Install via pip
pip install aetheria-cli

# Install via cargo
cargo install aetheria-cli

# Basic usage
aetheria mood 8                    # Log mood rating
aetheria track --anxiety 3         # Track anxiety level
aetheria activity exercise 30      # Log 30min exercise
aetheria view --days 7             # View last 7 days
aetheria export --format csv       # Export data
aetheria stats                     # Show statistics
```

---

## **Configuration**

Create a config file at `~/.aetheria/config.json`:

```json
{
  "data_path": "~/.aetheria/data.json",
  "encryption_enabled": true,
  "reminder_enabled": true,
  "reminder_time": "20:00",
  "export_format": "csv"
}
```

---

## **Why Open Source?**

- **Privacy**: Your mental health data stays on your own machine
- **Transparency**: See exactly how your data is handled
- **Customization**: Modify to fit your specific needs
- **Learning**: Great project for developers to learn CLI development
- **Community**: Others can contribute features they want

---

## **Easy Publishing Plan (7 Days)**

### **Day 1-3: Build & Test**
- Build the core CLI tool
- Test all features thoroughly
- Create comprehensive documentation

### **Day 4: Prepare Launch**
- Create GitHub repository with clear README
- Write installation instructions
- Prepare demo video (2-3 minutes)

### **Day 5: Package & Publish**
- Package for npm, pip, and cargo
- Publish to package registries
- Create GitHub releases

### **Day 6: Community Launch**
- Post on Reddit r/opensource, r/mentalhealth
- Share on Twitter/X with #opensource #mentalhealth #cli
- Submit to Hacker News

### **Day 7: Community Engagement**
- Respond to all comments and feedback
- Create GitHub issues for feature requests
- Engage with contributors

---

## **Marketing Strategy**

### **Target Audience**
- People managing mental health
- CLI enthusiasts and power users
- Mental health professionals
- Open source contributors

### **Key Messages**
- "Track your mental health from the terminal"
- "Privacy-first mental health tracking"
- "Your data, your control"

### **Distribution Channels**
- GitHub (primary)
- npm, pip, cargo registries
- Reddit communities
- Twitter/X mental health community
- Hacker News
- Mental health forums

---

## **Success Metrics**

- **Downloads**: 500+ in first week
- **GitHub Stars**: 150+ in first week
- **Forks**: 25+ active forks
- **Issues**: 12+ feature requests
- **Contributors**: 6+ community contributors

---

## **Future Enhancements**

- Web dashboard for data visualization
- Integration with wearable devices
- Journaling features
- Goal setting and tracking
- Community support features
- Mobile app companion

---

## **Getting Started**

1. Install the CLI tool
2. Configure your preferences
3. Start tracking your mood
4. Explore the features
5. Contribute to the project

---

*Built with ❤️ for the mental health community*

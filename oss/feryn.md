# **Feryn** — *Simple Course Management CLI*

*A lightweight, open-source command-line tool that helps you manage courses, track academic progress, and plan your educational journey with minimal effort.*

---

## **What is Feryn?**

Feryn is a simple CLI tool that lets you manage courses, track academic progress, and plan your educational journey directly from your terminal. Perfect for students, educators, and anyone who wants to organize their academic information without complex systems.

---

## **Core Features (MVP - 7 Days)**

### **Day 1-2: Basic Setup**
- CLI interface with command parsing
- Course and academic management
- Basic progress tracking

### **Day 3-4: Core Functionality**
- Create and manage courses
- Track grades and academic progress
- Plan course schedules
- Generate academic reports

### **Day 5-6: Enhanced Features**
- Export academic data to various formats
- Basic academic analytics
- Reminder system for deadlines
- Course recommendation engine

### **Day 7: Polish & Deploy**
- Package for npm/pip/cargo
- Write comprehensive documentation
- Create installation scripts

---

## **Simple Data Model**

```json
{
  "courses": [
    {
      "id": "uuid",
      "code": "string",
      "name": "string",
      "credits": "number",
      "instructor": "string",
      "semester": "string",
      "grade": "string",
      "status": "enrolled|completed|dropped",
      "created_at": "datetime"
    }
  ],
  "assignments": [
    {
      "id": "uuid",
      "course_id": "uuid",
      "title": "string",
      "due_date": "datetime",
      "grade": "number",
      "weight": "number",
      "status": "pending|submitted|graded"
    }
  ],
  "schedules": [
    {
      "id": "uuid",
      "course_id": "uuid",
      "day": "string",
      "start_time": "string",
      "end_time": "string",
      "room": "string"
    }
  ],
  "progress": {
    "total_credits": "number",
    "gpa": "number",
    "completed_courses": "number",
    "remaining_credits": "number"
  }
}
```

---

## **Installation & Usage**

```bash
# Install via npm
npm install -g feryn-cli

# Install via pip
pip install feryn-cli

# Install via cargo
cargo install feryn-cli

# Basic usage
feryn course add "CS101" "Introduction to Programming" 3    # Add course
feryn grade "CS101" A                                       # Record grade
feryn assignment add "CS101" "Final Project" 2024-12-15     # Add assignment
feryn schedule "CS101" Monday 09:00 10:30 "Room 101"        # Schedule course
feryn progress                                              # Show progress
feryn gpa                                                   # Calculate GPA
feryn export --format csv                                   # Export data
feryn plan --credits 120                                    # Plan degree
feryn reminder add "Study for CS101 exam" --date 2024-12-10 # Add reminder
```

---

## **Configuration**

Create a config file at `~/.feryn/config.json`:

```json
{
  "data_path": "~/.feryn/data.json",
  "default_semester": "Fall 2024",
  "gpa_scale": "4.0",
  "reminder_enabled": true,
  "reminder_days": 7,
  "export_format": "csv",
  "auto_backup": true
}
```

---

## **Why Open Source?**

- **Privacy**: Your academic data stays on your own machine
- **Transparency**: See exactly how course management works
- **Customization**: Modify to fit your specific academic needs
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
- Post on Reddit r/opensource, r/education
- Share on Twitter/X with #opensource #education #cli
- Submit to Hacker News

### **Day 7: Community Engagement**
- Respond to all comments and feedback
- Create GitHub issues for feature requests
- Engage with contributors

---

## **Marketing Strategy**

### **Target Audience**
- Students and learners
- Educators and teachers
- Academic institutions
- Open source contributors

### **Key Messages**
- "Manage your courses from the terminal"
- "Simple academic planning without complexity"
- "Built by students, for students"

### **Distribution Channels**
- GitHub (primary)
- npm, pip, cargo registries
- Reddit communities
- Twitter/X education community
- Hacker News
- Education forums

---

## **Success Metrics**

- **Downloads**: 1500+ in first week
- **GitHub Stars**: 220+ in first week
- **Forks**: 30+ active forks
- **Issues**: 15+ feature requests
- **Contributors**: 7+ community contributors

---

## **Future Enhancements**

- Web dashboard for visual planning
- Integration with learning management systems
- Advanced analytics and reporting
- Course recommendation algorithms
- Mobile app companion
- Collaborative study planning

---

## **Getting Started**

1. Install the CLI tool
2. Configure your academic preferences
3. Add your first course
4. Start tracking your progress
5. Contribute to the project

---

*Built with ❤️ for the education community*

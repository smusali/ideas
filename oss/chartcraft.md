# **ChartCraft** — *Simple Data Visualization CLI*

*A lightweight, open-source command-line tool that helps you analyze and visualize your data with minimal effort.*

---

## **What is ChartCraft?**

ChartCraft is a simple CLI tool that lets you analyze CSV files, create charts and graphs, and get insights about patterns and trends directly from your terminal. Perfect for developers and analysts who want to understand and visualize their data without complex tools.

---

## **Core Features (MVP - 7 Days)**

### **Day 1-2: Basic Setup**
- CLI interface with command parsing
- CSV file parsing and validation
- Basic data analysis engine

### **Day 3-4: Core Functionality**
- Parse and analyze CSV files
- Generate basic statistics (counts, averages, distributions)
- Create charts in terminal (ASCII art)
- Export analysis results

### **Day 5-6: Enhanced Features**
- Export charts as images (PNG, SVG)
- Data filtering and sorting
- Multiple chart types (bar, line, pie, scatter)
- Generate HTML reports

### **Day 7: Polish & Deploy**
- Package for npm/pip/cargo
- Write comprehensive documentation
- Create installation scripts

---

## **Simple Data Model**

```json
{
  "datasets": [
    {
      "id": "uuid",
      "name": "string",
      "file_path": "string",
      "row_count": "number",
      "column_count": "number",
      "created_at": "datetime"
    }
  ],
  "analyses": [
    {
      "id": "uuid",
      "dataset_id": "uuid",
      "type": "summary|distribution|correlation",
      "results": "object",
      "created_at": "datetime"
    }
  ],
  "charts": [
    {
      "id": "uuid",
      "dataset_id": "uuid",
      "title": "string",
      "type": "bar|line|pie|scatter",
      "config": "object",
      "output_path": "string"
    }
  ]
}
```

---

## **Installation & Usage**

```bash
# Install via npm
npm install -g chartcraft-cli

# Install via pip
pip install chartcraft-cli

# Install via cargo
cargo install chartcraft-cli

# Basic usage
chartcraft analyze data.csv                           # Analyze CSV file
chartcraft chart data.csv --type bar --column sales   # Create bar chart
chartcraft summary data.csv                           # Show data summary
chartcraft export data.csv --format html              # Export as HTML
chartcraft filter data.csv --column age --gt 25       # Filter data
chartcraft stats data.csv                             # Show statistics
chartcraft report data.csv --output report.html       # Generate report
```

---

## **Configuration**

Create a config file at `~/.chartcraft/config.json`:

```json
{
  "default_chart_type": "bar",
  "output_format": "terminal",
  "export_path": "./output",
  "chart_width": 80,
  "chart_height": 20,
  "color_enabled": true
}
```

---

## **Why Open Source?**

- **Transparency**: See exactly how your data is processed
- **Privacy**: Your data stays on your own machine
- **Customization**: Modify to fit your specific analysis needs
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
- Post on Reddit r/opensource, r/datascience
- Share on Twitter/X with #opensource #chartcraft #cli
- Submit to Hacker News

### **Day 7: Community Engagement**
- Respond to all comments and feedback
- Create GitHub issues for feature requests
- Engage with contributors

---

## **Marketing Strategy**

### **Target Audience**
- Data analysts and scientists
- Developers working with data
- Researchers and students
- Open source contributors

### **Key Messages**
- "Visualize your data from the terminal"
- "Simple data analysis without complexity"
- "Built by developers, for developers"

### **Distribution Channels**
- GitHub (primary)
- npm, pip, cargo registries
- Reddit communities
- Twitter/X data science community
- Hacker News
- Data science forums

---

## **Success Metrics**

- **Downloads**: 2200+ in first week
- **GitHub Stars**: 320+ in first week
- **Forks**: 40+ active forks
- **Issues**: 18+ feature requests
- **Contributors**: 9+ community contributors

---

## **Future Enhancements**

- Web dashboard for interactive charts
- Advanced statistical analysis
- Machine learning insights
- Real-time data streaming
- Custom chart templates
- Integration with databases

---

## **Getting Started**

1. Install the CLI tool
2. Configure your data analysis preferences
3. Analyze your first CSV file
4. Create your first chart
5. Contribute to the project

---

*Built with ❤️ for the data community* 

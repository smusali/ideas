# **LocalVents — Local Event Discovery CLI**

*"Find and discover local events from multiple sources with a simple command"*


> **Package Rename Note:** The npm name `eventify` is TAKEN (v3.1.0 by Bermi Ferrer, TypeScript event emitter, actively maintained Feb 2026). This project publishes as `localvents` on both PyPI and npm. Both confirmed available (HTTP 404).

---

## Executive Summary

**LocalVents** is an open-source CLI tool that aggregates and searches local events from multiple sources, providing personalized event recommendations based on location, interests, and preferences. It helps users discover nearby events, meetups, and activities through a simple command-line interface.

The tool is designed to be built in 7 days by a single developer and published as a Python package on PyPI.

---

## Problem Landscape

| Challenge | Pain Point | Current Friction |
|-----------|------------|------------------|
| **Information Overload** | Events scattered across multiple platforms | Manual checking of multiple websites |
| **Fragmented Sources** | Meetup, Eventbrite, social media, local sites | No unified search across platforms |
| **Static Search** | Limited filtering options | Hard to find specific types of events |
| **Trust & Freshness** | Outdated listings and cancellations | Wasted time on invalid events |

---

## Solution Overview

LocalVents is a simple CLI tool that:

1. **Aggregates events** from multiple sources (Meetup, Eventbrite, local sites)
2. **Filters and searches** events by location, date, category, and keywords
3. **Provides recommendations** based on user preferences and history
4. **Outputs formatted results** in various formats (table, JSON, calendar)

---

## Core Features

### 1. Event Aggregation
- Fetch events from multiple APIs and websites
- Parse and normalize event data
- Handle different date formats and timezones
- Remove duplicates and invalid events

### 2. Smart Filtering
- Filter by location (city, radius, coordinates)
- Filter by date range and time
- Filter by event category and keywords
- Filter by price range and availability

### 3. Search and Discovery
- Full-text search across event titles and descriptions
- Category-based recommendations
- Popular events and trending activities
- Personalized suggestions based on history

### 4. Output Formats
- Table format for terminal viewing
- JSON for programmatic use
- Calendar format for import
- Markdown for documentation

---

## Usage Examples

```bash
# Search for events in a city
localvents search "San Francisco" --date "this weekend"

# Find specific type of events
localvents search "tech meetups" --location "New York" --radius 10

# Get events for today
localvents today --location "Austin, TX"

# Search with filters
localvents search "music" --date "next week" --price "free" --category "entertainment"

# Export to calendar
localvents search "conference" --location "Seattle" --output calendar --file events.ics

# Get recommendations
localvents recommend --location "Boston" --interests "tech,music,food"

# Check specific venue
localvents venue "The Fillmore" --location "San Francisco"
```

---

## 7-Day Development Plan

### Day 1: Project Setup & Core Structure
- Initialize Python package structure
- Set up CLI framework with click
- Create basic event data models
- Implement configuration management

### Day 2: Event Sources & APIs
- Integrate with Meetup API
- Integrate with Eventbrite API
- Create web scraping for local sites
- Build data normalization pipeline

### Day 3: Search & Filter Engine
- Implement location-based filtering
- Create date range filtering
- Build keyword search functionality
- Add category and price filtering

### Day 4: CLI Interface
- Create main search command
- Add interactive mode
- Implement output formatting
- Build help and documentation

### Day 5: Data Processing
- Create event deduplication
- Implement data validation
- Build recommendation engine
- Add caching for API responses

### Day 6: Output Formats
- Implement table output
- Add JSON export
- Create calendar format
- Build markdown export

### Day 7: Testing & Publishing
- Write comprehensive tests
- Package for PyPI distribution
- Create README and documentation
- Publish to PyPI

---

## Project Structure

```
localvents/
├── localvents/
│   ├── __init__.py
│   ├── cli.py
│   ├── sources/
│   │   ├── __init__.py
│   │   ├── meetup.py
│   │   ├── eventbrite.py
│   │   └── local.py
│   ├── filters/
│   │   ├── __init__.py
│   │   ├── location.py
│   │   ├── date.py
│   │   └── category.py
│   ├── formatters/
│   │   ├── __init__.py
│   │   ├── table.py
│   │   ├── json.py
│   │   └── calendar.py
│   └── utils.py
├── tests/
│   ├── test_sources.py
│   ├── test_filters.py
│   ├── test_formatters.py
│   └── test_cli.py
├── data/
│   ├── categories.json
│   ├── cities.json
│   └── templates/
├── setup.py
├── README.md
├── requirements.txt
└── LICENSE
```

---

## Configuration

Users can configure LocalVents using a `config.yaml` file:

```yaml
# Default settings
default_location: "San Francisco, CA"
default_radius: 25
default_date_range: 7
output_format: "table"

# API Configuration
meetup_api_key: "${MEETUP_API_KEY}"
eventbrite_api_key: "${EVENTBRITE_API_KEY}"

# Search settings
max_results: 50
cache_duration: 3600
respect_rate_limits: true

# Sources
enabled_sources:
  - meetup
  - eventbrite
  - local_sites

# Categories
categories:
  - tech
  - music
  - food
  - sports
  - arts
  - business
  - education
```

---

## API Key Integration

LocalVents supports API keys for enhanced functionality:

```bash
# Set API keys via environment variables
export MEETUP_API_KEY="your-meetup-api-key"
export EVENTBRITE_API_KEY="your-eventbrite-api-key"

# Or via config file
localvents config set meetup_api_key "your-meetup-api-key"
localvents config set eventbrite_api_key "your-eventbrite-api-key"
```

---

## Publishing Plan

### PyPI Package
- Package name: `localvents-cli`
- Version: 1.0.0
- Dependencies: click, requests, beautifulsoup4, pyyaml, tabulate
- Python versions: 3.8+

### Distribution
- PyPI: Primary distribution
- GitHub Releases: Source code and binaries
- Homebrew (macOS): CLI tool installation

### Documentation
- README with usage examples
- PyPI package description
- GitHub wiki for advanced usage
- Quick start guide

---

## Success Metrics

- **Downloads**: 300+ PyPI downloads in first week
- **GitHub Stars**: 75+ stars within first month
- **Community**: 15+ contributors within 3 months
- **Usage**: 1500+ event searches in first month

---

## Future Enhancements

### Phase 2 (Post-7-day launch)
- LLM integration for better event descriptions
- Web interface for non-technical users
- Event recommendation engine
- Integration with calendar apps

### Phase 3
- Real-time event updates
- Social features and event sharing
- Venue and organizer profiles
- Advanced analytics and insights

---

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request
5. Follow the code style guidelines

---

## License

MIT License - see LICENSE file for details

---

**LocalVents** helps users discover local events and activities by aggregating data from multiple sources and providing powerful search and filtering capabilities through a simple command-line interface.

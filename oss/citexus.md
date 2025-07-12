# **Citexus** — *Simple Citation Tracker*

*A lightweight, open-source tool that helps researchers track and organize academic citations with minimal effort.*

---

## **What is Citexus?**

Citexus is a simple web application that lets you save academic citations, organize them by research topic, and track your reading progress. Built for researchers who want to keep their citations organized without complex tools.

---

## **Core Features (MVP - 7 Days)**

### **Day 1-2: Basic Setup**
- Simple web interface for adding citations
- Basic database to store citation information
- User registration and login

### **Day 3-4: Core Functionality**
- Add citations with title, authors, journal, year, DOI, URL
- Organize citations by topics/tags
- Basic search and filtering
- Simple dashboard showing citation counts

### **Day 5-6: Enhanced Features**
- Notes field for each citation
- Reading status tracking (To Read, Reading, Finished)
- Export data to CSV
- Basic citation recommendations based on tags

### **Day 7: Polish & Deploy**
- Responsive design for mobile
- Deploy to free hosting platform
- Write documentation and README

---

## **Simple Data Model**

```
User:
- id, email, password_hash, created_at

Citation:
- id, user_id, title, authors, journal, year, doi, url, notes, status, created_at

Topic:
- id, name, description

CitationTopic:
- citation_id, topic_id

Status Options:
- To Read, Reading, Finished
```

---

## **Why Open Source?**

- **Transparency**: Researchers can see exactly how their data is handled
- **Customization**: Modify it to fit your specific research workflow
- **Learning**: Great project for developers to learn web development
- **Community**: Others can contribute features they want

---

## **Easy Publishing Plan (7 Days)**

### **Day 1-3: Build & Test**
- Build the core application
- Test all features thoroughly
- Create simple documentation

### **Day 4: Prepare Launch**
- Create GitHub repository
- Write compelling README with screenshots
- Prepare demo video (2-3 minutes)

### **Day 5: Initial Launch**
- Post on Reddit r/opensource, r/academia
- Share on Twitter/X with #opensource #research
- Submit to Product Hunt (if ready)

### **Day 6: Community Engagement**
- Respond to all comments and feedback
- Share on LinkedIn with research community
- Post on Hacker News

### **Day 7: Follow-up**
- Create GitHub issues for feature requests
- Engage with contributors
- Plan next iteration based on feedback

---

## **Marketing Strategy**

### **Target Audience**
- Graduate students and researchers
- Academic librarians
- Research institutions
- Open source enthusiasts

### **Key Messages**
- "Track your citations without the complexity"
- "Built by researchers, for researchers"
- "Your citations, your control"

### **Distribution Channels**
- GitHub (primary)
- Reddit communities
- Twitter/X research community
- LinkedIn academic groups
- Hacker News
- Academic forums

---

## **Success Metrics**

- **GitHub Stars**: 100+ in first week
- **Forks**: 20+ active forks
- **Issues**: 10+ feature requests
- **Contributors**: 5+ community contributors
- **Deployments**: 50+ researchers using the app

---

## **Future Enhancements**

- PDF upload and parsing
- Citation network visualization
- Integration with academic databases
- Collaborative citation sharing
- Research timeline tracking
- Mobile app

---

## **Getting Started**

1. Fork the repository
2. Set up local development environment
3. Add your first citation
4. Customize for your needs
5. Share improvements with the community

---

*Built with ❤️ for the research community*

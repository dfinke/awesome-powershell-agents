## What is awesome-powershell-agents?

**Unleash autonomous AI agents in PowerShell—no IT admin badge required.**  
This project showcases how anyone can build and run smart, self-directed agents using the [PSAI module](https://github.com/dfinke/PSAI). These agents aren’t just scripts—they’re digital teammates that automate, analyze, and solve problems with the power of OpenAI, right from your console. Whether you’re wrangling data, troubleshooting, or exploring new workflows, PSAI agents put autonomy and intelligence at your fingertips.

---

## Get Started

To use these agents, you’ll need the [PSAI module](https://github.com/dfinke/PSAI) and an OpenAI API key.

### 1. Install PSAI

Open PowerShell and run:

```powershell
Install-Module -Name PSAI
```

### 2. Get an OpenAI API Key

Sign up at [OpenAI](https://platform.openai.com/account/api-keys) and create an API key.

Set your key in PowerShell:

```powershell
$env:OpenAIKey = "your-api-key-here"
```

You’re now ready to run and build autonomous agents!

---

## What's Next

This is just the beginning. The world of autonomous PowerShell agents is rapidly evolving, and there are endless possibilities ahead. We’re excited to see new ideas, agents, and features from the community. Join us as we push the boundaries of automation and AI—your contributions and creativity will help shape what comes next!

---

### Agent Scripts

- [`Data/Csv-ToExcelMigrationAgent.ps1`](Data/Csv-ToExcelMigrationAgent.ps1)  
	Migrates CSV files to Excel format. Finds CSVs and converts them to `.xlsx` for easier data analysis.

- [`Data/Excel-ReportGeneratorAgent.ps1`](Data/Excel-ReportGeneratorAgent.ps1)  
	Generates reports from Excel files. Finds `.xlsx` files, imports their data, and exports new reports.

- [`Dev/Git-ChangeSummaryAgent.ps1`](Dev/Git-ChangeSummaryAgent.ps1)  
	Summarizes Git changes. Retrieves commit logs and file changes as JSON for quick project insights.

- [`Dev/StackOverflow-GuidedTroubleshooterAgent.ps1`](Dev/StackOverflow-GuidedTroubleshooterAgent.ps1)  
	Guides troubleshooting using Stack Overflow. Finds error logs, reads their content, and helps search for solutions.

- [`Ops/Hot-FixReviewAgent.ps1`](Ops/Hot-FixReviewAgent.ps1)  
	Reviews recent Windows hotfixes and performs web searches for more info on each update.

## How to Contribute

Contributions are welcome from everyone! Whether you want to add a new agent, improve documentation, or suggest a feature, here’s how to get started:

1. **Fork the repository** and clone it to your machine.
2. **Create a new branch** for your changes.
3. **Add your agent script** to the appropriate folder (`Data`, `Dev`, or `Ops`).
4. **Update the README** with a link and description for your new agent.
5. **Commit and push** your changes.
6. **Open a pull request** with a clear description of what you’ve added or changed.

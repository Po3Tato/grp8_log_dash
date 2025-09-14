# Log Intelligence Dashboard
**Log Intelligence Dashboard** - A bash-based tool for monitoring system logs, detecting anomalies, and generating reports. **Linux only**.

## Usage

1. **Run the dashboard:**
   ```
   ./Sentinel_dashboard.sh
   ```

2. **Interactive Menu Options:**
   - **Option 1 - Live Log Monitoring**: Display filtered log entries by level (ERROR, WARNING, INFO)
   - **Option 2 - Anomaly Detection Scan**: Redact sensitive data from logs
   - **Option 3 - Generate Intelligence Report**: Export analysis to timestamped CSV file
   - **Option 4 - View Audit Trail**: Display all log entries
   - **Option 5 - Exit**: Cleans temporary files and exit

3. **Input Requirements:**
   - Place your log file as `sample.log` in the same directory
   - Log format should be: `[LEVEL] YYYY-MM-DD HH:MM:SS - Message`

4. **Output:**
   - CSV reports saved as `report_YYYYMMDD_HHMMSS.csv` in current directory
   - Redacted logs displayed on screen
   - Filtered entries organized by log level

## Features

- **Frequency Count**: Count occurrences of each log level using for loops
- **Data Redaction**: Mask sensitive information using sed and regex
- **Report Generator**: Format timestamps and messages using awk/cut for analysis
- **Interactive Menu**: CLI interface using select, case, and read commands
- **CSV Export**: Generate timestamped CSV reports for data analysis

## Agent Roles

- Agent 1 was in charge of extracting the data and filtering it by Log Level.
- Agent 2 Enginered the Interactive menu and input validation.
- Agent 3 made sure sensitive data be masked and temporary files cleaned.
- Agent 4 Created the repository and working with other agents to put the main script together.


## Example Output
```
# Main Menu
🛡️  Sentinel Systems Log Intelligence Dashboard 🛡️
------------------------------------------------
1) Live Log Monitoring           3) Generate Intelligence Report  5) Exit
2) Anomaly Detection Scan        4) View Audit Trail

Enter your choice (1-5): 
```
```
# Option 1 Output
🛡️  Sentinel Systems Log Intelligence Dashboard 🛡️
------------------------------------------------
1) Live Log Monitoring           3) Generate Intelligence Report  5) Exit
2) Anomaly Detection Scan        4) View Audit Trail

Enter your choice (1-5): 1
Live Log Monitoring - showing filtered log entries:
=== ERROR Entries ===
[ERROR] 2025-09-01 10:05:12 - Connection timeout
[ERROR] 2025-09-01 10:15:30 - Disk full
[ERROR] 2025-09-01 10:25:00 - Failed login from 192.168.1.100
[ERROR] 2025-09-01 10:40:00 - Database connection failed from 10.0.0.15

=== WARNING Entries ===
[WARNING] 2025-09-01 10:10:45 - High memory usage
[WARNING] 2025-09-01 10:30:00 - Suspicious activity from user admin@example.com

=== INFO Entries ===
[INFO] 2025-09-01 10:00:00 - Server started
[INFO] 2025-09-01 10:20:00 - Backup completed
[INFO] 2025-09-01 10:35:00 - Email sent to john.doe@example.org

Press Enter to continue...
```

```
# Generate Report
1) Live Log Monitoring           3) Generate Intelligence Report  5) Exit
2) Anomaly Detection Scan        4) View Audit Trail

Enter your choice (1-5): 3
Generate Intelligence Report:
Saving report to: report_20250914_233935.csv
Report saved successfully!

Press Enter to continue...

# Report Output
cat report_20250914_233935.csv 
Timestamp,Level,Message
"INFO","INFO","Server started"
"ERROR","ERROR","Connection timeout"
"WARNING","WARNING","High memory usage"
"ERROR","ERROR","Disk full"
"INFO","INFO","Backup completed"
"ERROR","ERROR","Failed login from 192.168.1.100"
"WARNING","WARNING","Suspicious activity from user admin@example.com"
"INFO","INFO","Email sent to john.doe@example.org"
"ERROR","ERROR","Database connection failed from 10.0.0.15"
```

## Video Demo

[Youtube Link](https://youtu.be/-uOTY9beQvw)

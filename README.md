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


## Example Output


## Video Demo


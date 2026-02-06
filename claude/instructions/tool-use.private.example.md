### JIRA Integration
Use the `atlassian` MCP where available. If not available, request that the user "re-auths".

As a last resort fallback, use the JIRA API:

```
Base URL: https://<instance>.atlassian.net
API URL: https://<instance>.atlassian.net/rest/api/2/issue/<issueNum>
Token: JIRA_API_TOKEN
Email: <your email>
```

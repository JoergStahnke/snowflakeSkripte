/*
Demozugriff zum Erstellen der Objekte, welche man zur Git Integration in SnowSight benötigt
*/
--Einmalig
CREATE DATABASE github;
CREATE OR REPLACE SCHEMA github.integrations;

// siehe http://docs.snowflake.com/en/developer-guide/git/git-setting-up#label-git-setup-public-network
// https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
// Token Erstellen in GitHub mit Klick auf profile picture ->Settings-> Develeoper Settings->Personal Access Tokens -> Tokens (classic)
USE github.integrations;
CREATE OR REPLACE SECRET jst_secret
  TYPE = password
  USERNAME = 'JoergStahnke'
  PASSWORD = '<token>';

CREATE OR REPLACE API INTEGRATION github_integration_jst
API_PROVIDER = git_https_api
API_ALLOWED_PREFIXES = ('https://github.com/JoergStahnke')
-- Comment out the following line if your forked repository is public
ALLOWED_AUTHENTICATION_SECRETS = (github.integrations.jst_secret)
ENABLED = TRUE;
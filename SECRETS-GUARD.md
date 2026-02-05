# Secrets Guard

Global git pre-push hook that prevents accidental commit of sensitive data.

## Why

Agents have full access to your codebase and credentials. Without guardrails, sensitive data can leak into git history. Once pushed, it's hard to fully remove.

## Install

```bash
secrets-guard install
```

This:
1. Creates a global pre-push hook at `~/.config/git/hooks/pre-push`
2. Creates a patterns file at `~/.config/shelley/secrets-patterns.txt`
3. Configures git to use global hooks

## Add Patterns

```bash
# Emails
secrets-guard add 'your@email\.com'
secrets-guard add 'other@email\.com'

# Phone numbers
secrets-guard add '555[-.]?123[-.]?4567'

# API keys (some defaults included)
secrets-guard add 'my_api_key_prefix_[a-zA-Z0-9]+'

# Location/account IDs
secrets-guard add 'LOC_[A-Za-z0-9]{20}'

# Business names
secrets-guard add 'My Company Name'
```

## Usage

```bash
# List current patterns
secrets-guard list

# Test staged changes
git add .
secrets-guard test

# Scan a directory
secrets-guard scan ~/myproject

# Scan current directory
secrets-guard scan
```

## What Happens

When you (or an agent) tries to push:

```
$ git push origin main
🔍 Scanning for secrets before push...

🚨 BLOCKED: Found sensitive pattern 'your@email\.com'
Matches:
+const email = "your@email.com"

To bypass (emergency only): git push --no-verify
error: failed to push some refs
```

## Patterns File Format

```
# ~/.config/shelley/secrets-patterns.txt
# One regex pattern per line
# Lines starting with # are comments

# Emails
your@email\.com
other@email\.com

# API keys
ghp_[a-zA-Z0-9]{36}
sk-[a-zA-Z0-9]{48}

# Custom patterns
MySecretProjectName
```

## Emergency Bypass

If you're absolutely sure the match is a false positive:

```bash
git push --no-verify
```

Use with extreme caution.

## Best Practices

1. **Run `secrets-guard install` on every new VM**
2. **Add patterns immediately** when you receive new credentials
3. **Scan before open-sourcing**: `secrets-guard scan ~/repo`
4. **Review patterns periodically**: `secrets-guard list`

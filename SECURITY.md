# Security Policy

## Overview

This project follows security best practices to protect the application, user data, and infrastructure.

---

## Quick Security Checklist

### Before Every Deployment

**Critical:**
- [ ] All environment variables configured (no secrets in code)
- [ ] Security headers configured (CSP, X-Frame-Options, etc.)
- [ ] All dependencies scanned (`npm audit`)
- [ ] No high/critical vulnerabilities
- [ ] SSL/TLS enabled

**High Priority:**
- [ ] Input validation on all forms
- [ ] CSRF protection implemented
- [ ] API tokens follow least privilege
- [ ] GitHub Dependabot enabled

---

## Environment Variables

### Rules
- Never commit `.env` files
- Use `.env.example` for documentation
- Prefix client-side variables with `NEXT_PUBLIC_` (Next.js)
- Server-only secrets have no prefix

### Example .env.example
```bash
# Server-only (never exposed to client)
DATABASE_URL=
API_SECRET_KEY=

# Client-safe (exposed to browser)
NEXT_PUBLIC_API_URL=
NEXT_PUBLIC_SITE_URL=
```

---

## Dependency Security

### Automated Scanning
- GitHub Dependabot enabled (weekly)
- Run `npm audit` before each commit
- Review and merge security PRs promptly

### Adding New Dependencies
Before adding a package:
1. Check npm downloads (prefer >1000/week)
2. Check last update (prefer <6 months)
3. Review for known vulnerabilities
4. Verify it's actively maintained

---

## Form & API Security

### Forms
- Implement input validation (client + server)
- Add CSRF protection
- Consider rate limiting
- Sanitize all user inputs
- Use CAPTCHA for public forms (optional)

### APIs
- Validate all inputs
- Use proper authentication
- Implement rate limiting
- Return generic error messages
- Log security events

---

## Security Headers

Recommended headers (configure in your hosting platform):

```
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
Content-Security-Policy: [configured per project]
Strict-Transport-Security: max-age=31536000; includeSubDomains
```

---

## Reporting a Vulnerability

If you discover a security vulnerability:

1. **DO NOT** open a public GitHub issue
2. Email: [SECURITY_EMAIL]
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

**Response Time:** We aim to acknowledge within 48 hours.

---

## Security Updates

| Task | Frequency |
|------|-----------|
| Dependency updates | Weekly (Dependabot) |
| Security patches | Immediately |
| npm audit | Before each commit |
| API token rotation | Every 90 days |
| Security review | Quarterly |

---

## Compliance

This project aims to follow:
- OWASP Top 10 guidelines
- Framework security best practices
- GDPR requirements (if applicable)

---

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Next.js Security](https://nextjs.org/docs/app/building-your-application/configuring/security-headers)
- [npm Security Best Practices](https://docs.npmjs.com/packages-and-modules/securing-your-code)

---

**Last Updated:** [DATE]

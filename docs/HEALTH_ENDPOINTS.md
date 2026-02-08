# Health Check Endpoints

This application provides two health check endpoints:

## Endpoints

### GET /health
Basic health check endpoint that always returns UP when the application is running.

**Response (200 OK):**
```json
{
  "status": "UP"
}
```

### GET /health/db
Database health check endpoint that verifies the connection to Neon PostgreSQL.

**Response (200 OK):**
```json
{
  "status": "UP",
  "database": "PostgreSQL"
}
```

**Response (503 Service Unavailable):**
```json
{
  "status": "DOWN",
  "error": "error message"
}
```

## Configuration

Set the following environment variables to configure the Neon PostgreSQL connection:

- `DATABASE_URL`: JDBC URL for Neon PostgreSQL (e.g., `jdbc:postgresql://your-neon-host.neon.tech/your-db?sslmode=require`)
- `DATABASE_USERNAME`: Database username
- `DATABASE_PASSWORD`: Database password

Example:
```bash
export DATABASE_URL="jdbc:postgresql://your-neon-host.neon.tech/cq?sslmode=require"
export DATABASE_USERNAME="your-username"
export DATABASE_PASSWORD="your-password"
```

If not set, defaults to localhost PostgreSQL instance.

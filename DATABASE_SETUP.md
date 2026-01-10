# Database Setup Guide

## ⚠️ Important: Lombok Configuration

Before running the application, ensure Lombok is properly configured in your IDE:

### IntelliJ IDEA
1. Install Lombok plugin: File → Settings → Plugins → Search "Lombok" → Install
2. Enable annotation processing: File → Settings → Build, Execution, Deployment → Compiler → Annotation Processors → Enable annotation processing ✓
3. Restart IDE

### Eclipse
1. Download lombok.jar from https://projectlombok.org/download
2. Run: `java -jar lombok.jar`
3. Select Eclipse installation directory
4. Click "Install/Update"
5. Restart Eclipse

### VS Code
1. Install "Lombok Annotations Support" extension
2. Reload window

---

# Database Setup Guide

## Overview
The Ocean View Resort Reservation System supports two database configurations:
- **H2 Database** (In-Memory) - For development and testing
- **MySQL Database** - For production deployment

---

## Option 1: H2 Database (Quick Start - Already Configured)

### Advantages
- No installation required
- Instant setup
- Perfect for development and testing
- Built-in web console

### Current Configuration
The application is now configured to use H2 by default. Simply run the application:

```bash
mvn spring-boot:run
```

### Access H2 Console
1. Start the application
2. Open browser: `http://localhost:8080/h2-console`
3. Use these credentials:
   - **JDBC URL**: `jdbc:h2:mem:oceanview_resort`
   - **Username**: `sa`
   - **Password**: (leave empty)

### Data Persistence
⚠️ **Note**: H2 in-memory database resets on application restart. Data is not persisted.

---

## Option 2: MySQL Database (Production)

### Step 1: Install MySQL

#### Windows
1. Download MySQL Installer: https://dev.mysql.com/downloads/installer/
2. Run installer and select "MySQL Server"
3. Choose "Development Default" setup
4. Set root password (default in config: `root`)
5. Complete installation

#### macOS
```bash
brew install mysql
brew services start mysql
mysql_secure_installation
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
sudo mysql_secure_installation
```

### Step 2: Create Database

Connect to MySQL:
```bash
mysql -u root -p
```

Create the database:
```sql
CREATE DATABASE oceanview_resort;
USE oceanview_resort;

-- Verify database creation
SHOW DATABASES;
```

### Step 3: Configure Application

Switch to production profile by running:
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

Or update `application.properties` to use MySQL configuration:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/oceanview_resort?createDatabaseIfNotExist=true
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect
```

### Step 4: Run Application

```bash
mvn clean install
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

---

## Database Schema

The application automatically creates these tables:

### Users Table
```sql
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP
);
```

### Reservations Table
```sql
CREATE TABLE reservations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    reservation_number VARCHAR(255) UNIQUE NOT NULL,
    guest_name VARCHAR(255) NOT NULL,
    address VARCHAR(500) NOT NULL,
    contact_number VARCHAR(10) NOT NULL,
    email VARCHAR(255),
    room_type VARCHAR(50) NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'CONFIRMED',
    number_of_guests INT,
    special_requests TEXT,
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
```

---

## Initial Data

The application includes a `DataInitializer` that automatically creates:

### Default Users
- **Admin**: username=`admin`, password=`admin123`
- **Receptionist**: username=`receptionist`, password=`recep123`
- **Manager**: username=`manager`, password=`manager123`

### Sample Reservations
- 3 sample reservations with different room types and statuses

---

## Database Operations

### View All Tables
```sql
USE oceanview_resort;
SHOW TABLES;
```

### Query Users
```sql
SELECT * FROM users;
```

### Query Reservations
```sql
SELECT * FROM reservations;
SELECT * FROM reservations WHERE status = 'CONFIRMED';
SELECT * FROM reservations WHERE room_type = 'DELUXE';
```

### Backup Database (MySQL)
```bash
mysqldump -u root -p oceanview_resort > backup.sql
```

### Restore Database (MySQL)
```bash
mysql -u root -p oceanview_resort < backup.sql
```

---

## Troubleshooting

### Connection Refused
- Ensure MySQL service is running: `sudo systemctl status mysql` (Linux) or check Services (Windows)
- Verify port 3306 is not blocked by firewall

### Authentication Failed
- Check username/password in `application.properties`
- Reset MySQL root password if needed

### Database Not Found
- The application creates the database automatically if `createDatabaseIfNotExist=true` is in the URL
- Or manually create: `CREATE DATABASE oceanview_resort;`

### H2 Console Not Accessible
- Ensure `spring.h2.console.enabled=true` in properties
- Check application is running on port 8080

---

## Switching Between Databases

### Use H2 (Development)
```bash
mvn spring-boot:run
```

### Use MySQL (Production)
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

### Or set in IDE
Add VM argument: `-Dspring.profiles.active=prod`

---

## Performance Tuning (MySQL)

For production, consider these optimizations in `application-prod.properties`:

```properties
# Connection pooling
spring.datasource.hikari.maximum-pool-size=20
spring.datasource.hikari.minimum-idle=10

# Query optimization
spring.jpa.properties.hibernate.jdbc.batch_size=50
spring.jpa.properties.hibernate.cache.use_second_level_cache=true
```

---

## Security Recommendations

1. **Change default passwords** in production
2. **Use environment variables** for sensitive data:
   ```bash
   export DB_PASSWORD=your_secure_password
   ```
   ```properties
   spring.datasource.password=${DB_PASSWORD}
   ```
3. **Enable SSL** for MySQL connections in production
4. **Restrict database user permissions** - don't use root in production

---

## Next Steps

1. ✅ Choose your database (H2 for quick start, MySQL for production)
2. ✅ Run the application
3. ✅ Access Swagger UI: `http://localhost:8080/swagger-ui.html`
4. ✅ Test authentication with default users
5. ✅ Create and manage reservations

For API documentation, see `API_DOCUMENTATION.md`

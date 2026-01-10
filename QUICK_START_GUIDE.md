# Quick Start Guide

## 🚀 Getting Started in 5 Minutes

This guide will help you set up and run the Ocean View Resort Reservation System quickly.

---

## Prerequisites Checklist

Before you begin, ensure you have:

- [ ] Java 17 or higher installed
- [ ] Maven 3.6+ installed
- [ ] MySQL 8.0+ installed (or use H2 for testing)
- [ ] Git installed
- [ ] Your favorite IDE (IntelliJ IDEA, Eclipse, VS Code)
- [ ] Postman or similar API testing tool (optional)

---

## Step 1: Verify Java Installation

```bash
java -version
```

Expected output:
```
java version "17.0.x" or higher
```

If not installed, download from: https://www.oracle.com/java/technologies/downloads/

---

## Step 2: Verify Maven Installation

```bash
mvn -version
```

Expected output:
```
Apache Maven 3.6.x or higher
```

If not installed, download from: https://maven.apache.org/download.cgi

---

## Step 3: Clone the Repository

```bash
git clone https://github.com/yourusername/oceanview-resort.git
cd oceanview-resort
```

---

## Step 4: Configure Database

### Option A: Using MySQL (Recommended for Production)

1. **Start MySQL Server**

2. **Create Database**
```sql
CREATE DATABASE oceanview_resort;
```

3. **Update Configuration**

Edit `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/oceanview_resort
spring.datasource.username=your_mysql_username
spring.datasource.password=your_mysql_password
```

### Option B: Using H2 (Quick Testing)

No configuration needed! H2 is configured by default for testing.

Just run the application with the test profile:
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=test
```

---

## Step 5: Build the Project

```bash
mvn clean install
```

This will:
- Download all dependencies
- Compile the code
- Run all tests
- Package the application

Expected output:
```
[INFO] BUILD SUCCESS
[INFO] Total time: 45.123 s
```

---

## Step 6: Run the Application

```bash
mvn spring-boot:run
```

Or if you prefer using the JAR:
```bash
java -jar target/hotel-reservation-system-1.0.0.jar
```

Expected output:
```
==============================================
Ocean View Resort Reservation System Started
Access API Documentation: http://localhost:8080/swagger-ui.html
==============================================
```

---

## Step 7: Verify Installation

### Check Application Health

Open your browser and navigate to:
```
http://localhost:8080
```

You should see the welcome page.

### Access API Documentation

```
http://localhost:8080/swagger-ui.html
```

You should see the Swagger UI with all API endpoints.

---

## Step 8: Test the API

### Method 1: Using Swagger UI (Easiest)

1. Go to `http://localhost:8080/swagger-ui.html`
2. Find the "Authentication" section
3. Click on "POST /api/auth/login"
4. Click "Try it out"
5. Use these credentials:
```json
{
  "username": "admin",
  "password": "admin123"
}
```
6. Click "Execute"
7. Copy the JWT token from the response

### Method 2: Using cURL

**Login:**
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin123"
  }'
```

**Create Reservation:**
```bash
curl -X POST http://localhost:8080/api/reservations \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "guestName": "John Doe",
    "address": "123 Main St, Colombo",
    "contactNumber": "0771234567",
    "email": "john@example.com",
    "roomType": "DELUXE",
    "checkInDate": "2025-01-20",
    "checkOutDate": "2025-01-22",
    "numberOfGuests": 2
  }'
```

**Get All Reservations:**
```bash
curl -X GET http://localhost:8080/api/reservations \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE"
```

### Method 3: Using Postman

1. Import the API collection (if provided)
2. Set the base URL: `http://localhost:8080`
3. Login to get JWT token
4. Add token to Authorization header for other requests

---

## Default User Accounts

| Username | Password | Role | Permissions |
|----------|----------|------|-------------|
| admin | admin123 | ADMIN | Full access |
| receptionist | recep123 | RECEPTIONIST | Create, view, update reservations |
| manager | manager123 | MANAGER | All + cancel reservations |

---

## Common Issues & Solutions

### Issue 1: Port 8080 Already in Use

**Solution:** Change the port in `application.properties`:
```properties
server.port=8081
```

### Issue 2: MySQL Connection Failed

**Solution:** Verify MySQL is running:
```bash
# Windows
net start MySQL80

# Linux/Mac
sudo systemctl start mysql
```

### Issue 3: Build Fails

**Solution:** Clean and rebuild:
```bash
mvn clean install -U
```

### Issue 4: Tests Fail

**Solution:** Skip tests temporarily:
```bash
mvn clean install -DskipTests
```

### Issue 5: Out of Memory

**Solution:** Increase Maven memory:
```bash
export MAVEN_OPTS="-Xmx1024m"
mvn clean install
```

---

## Running Tests

### Run All Tests
```bash
mvn test
```

### Run Specific Test Class
```bash
mvn test -Dtest=ReservationServiceTest
```

### Run with Coverage Report
```bash
mvn test jacoco:report
```

View coverage report at: `target/site/jacoco/index.html`

---

## Stopping the Application

Press `Ctrl + C` in the terminal where the application is running.

---

## Next Steps

Now that your system is running:

1. **Explore the API**
   - Visit Swagger UI: `http://localhost:8080/swagger-ui.html`
   - Try different endpoints
   - Test various scenarios

2. **Create Test Data**
   - Create multiple reservations
   - Test different room types
   - Try edge cases

3. **Review Documentation**
   - Read `README.md` for detailed information
   - Check `UML_DIAGRAMS.md` for system design
   - Review `TESTING_DOCUMENTATION.md` for test details

4. **Customize the System**
   - Modify room types and rates
   - Add new features
   - Enhance validation rules

---

## Development Mode

For development with auto-reload:

```bash
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.devtools.restart.enabled=true"
```

---

## Production Deployment

### Build for Production

```bash
mvn clean package -Pprod
```

### Run in Production

```bash
java -jar target/hotel-reservation-system-1.0.0.jar --spring.profiles.active=prod
```

### Environment Variables

Set these for production:

```bash
export SPRING_DATASOURCE_URL=jdbc:mysql://prod-server:3306/oceanview_resort
export SPRING_DATASOURCE_USERNAME=prod_user
export SPRING_DATASOURCE_PASSWORD=secure_password
export JWT_SECRET=your_production_secret_key_here
```

---

## Useful Commands

### Check Application Status
```bash
curl http://localhost:8080/actuator/health
```

### View Logs
```bash
tail -f logs/application.log
```

### Database Console (H2 only)
```
http://localhost:8080/h2-console
```

---

## Getting Help

### Documentation
- API Docs: `http://localhost:8080/swagger-ui.html`
- Help Endpoint: `GET /api/auth/help`

### Support
- Email: support@oceanviewresort.lk
- Module Leader: priyanga@icbtcampus.edu.lk

### Resources
- Spring Boot Docs: https://spring.io/projects/spring-boot
- Spring Security: https://spring.io/projects/spring-security
- JWT: https://jwt.io/

---

## Success Checklist

- [ ] Application starts without errors
- [ ] Can access welcome page at `http://localhost:8080`
- [ ] Can access Swagger UI at `http://localhost:8080/swagger-ui.html`
- [ ] Can login with default credentials
- [ ] Can create a reservation
- [ ] Can view reservations
- [ ] All tests pass

---

## What's Next?

Congratulations! Your Ocean View Resort Reservation System is now running. 

Explore the features:
- ✅ User Authentication
- ✅ Reservation Management
- ✅ Room Availability
- ✅ Bill Calculation
- ✅ Search Functionality

Happy coding! 🎉

---

**Last Updated:** January 2025  
**Version:** 1.0.0

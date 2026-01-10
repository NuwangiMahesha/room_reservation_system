# Quick Database Setup - Ocean View Resort

## 🚀 Fastest Way to Get Started

Your application is **already configured** with an H2 in-memory database. Just follow these steps:

### Step 1: Fix Lombok (One-time setup)

The compilation errors you're seeing are because Lombok isn't configured. Choose your IDE:

#### IntelliJ IDEA
```
1. File → Settings → Plugins
2. Search "Lombok" → Install
3. File → Settings → Compiler → Annotation Processors
4. Check "Enable annotation processing"
5. Restart IDE
```

#### Eclipse
```
1. Download: https://projectlombok.org/download
2. Run: java -jar lombok.jar
3. Select Eclipse folder → Install
4. Restart Eclipse
```

#### VS Code
```
1. Install extension: "Lombok Annotations Support"
2. Reload window
```

### Step 2: Run the Application

**Option A: Using the script (Windows)**
```bash
run-application.bat
```

**Option B: Using Maven directly**
```bash
mvn clean install -DskipTests
mvn spring-boot:run
```

**Option C: Using your IDE**
- Right-click on `HotelReservationApplication.java`
- Select "Run" or "Debug"

### Step 3: Access the Application

Once running, open your browser:

- **API Documentation**: http://localhost:8080/swagger-ui.html
- **H2 Database Console**: http://localhost:8080/h2-console
  - JDBC URL: `jdbc:h2:mem:oceanview_resort`
  - Username: `sa`
  - Password: (leave empty)

---

## 📊 Database is Already Configured!

Your `application.properties` is set up with:
- ✅ H2 in-memory database (no installation needed)
- ✅ Auto-creates tables from JPA entities
- ✅ Sample data loaded on startup
- ✅ H2 console enabled for viewing data

### Default Users (Auto-created)
| Username | Password | Role |
|----------|----------|------|
| admin | admin123 | ADMIN |
| receptionist | recep123 | RECEPTIONIST |
| manager | manager123 | MANAGER |

---

## 🔄 Switch to MySQL (Production)

When you're ready for production:

### 1. Install MySQL
- **Windows**: Download from https://dev.mysql.com/downloads/installer/
- **Mac**: `brew install mysql`
- **Linux**: `sudo apt install mysql-server`

### 2. Create Database
```sql
mysql -u root -p
CREATE DATABASE oceanview_resort;
```

### 3. Update Configuration
Create `application-prod.properties` (already exists in your project):
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/oceanview_resort
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
```

### 4. Run with Production Profile
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

---

## 🗄️ Database Schema

The application automatically creates these tables:

### users
- id, username, password, full_name, role, active, created_at

### reservations
- id, reservation_number, guest_name, address, contact_number
- email, room_type, check_in_date, check_out_date, status
- number_of_guests, special_requests, total_amount
- created_at, updated_at

---

## 🧪 Test the API

### 1. Login
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'
```

### 2. Create Reservation
```bash
curl -X POST http://localhost:8080/api/reservations \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "guestName": "John Doe",
    "address": "123 Main St",
    "contactNumber": "1234567890",
    "email": "john@example.com",
    "roomType": "DELUXE",
    "checkInDate": "2026-02-01",
    "checkOutDate": "2026-02-05",
    "numberOfGuests": 2
  }'
```

---

## 📝 Useful SQL Queries

Access H2 Console and try these:

```sql
-- View all users
SELECT * FROM users;

-- View all reservations
SELECT * FROM reservations;

-- View confirmed reservations
SELECT * FROM reservations WHERE status = 'CONFIRMED';

-- Revenue by room type
SELECT room_type, SUM(total_amount) as revenue 
FROM reservations 
GROUP BY room_type;
```

---

## ❓ Troubleshooting

### "Cannot find symbol" errors
→ Lombok not configured. See Step 1 above.

### "Port 8080 already in use"
→ Change port in `application.properties`: `server.port=8081`

### "Database connection failed"
→ You're using H2 (in-memory), no connection needed!
→ For MySQL, ensure MySQL service is running

### "Access denied for user"
→ Check MySQL username/password in `application-prod.properties`

---

## 📚 More Information

- Full database guide: `DATABASE_SETUP.md`
- API documentation: `API_DOCUMENTATION.md`
- SQL queries: `database-queries.sql`
- Schema details: `database-schema.sql`

---

## ✅ Summary

1. **Fix Lombok** in your IDE (one-time)
2. **Run** `mvn spring-boot:run`
3. **Access** http://localhost:8080/swagger-ui.html
4. **Login** with admin/admin123
5. **Start creating** reservations!

The database is ready to go! 🎉

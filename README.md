# Ocean View Resort - Room Reservation System

## 📋 Project Overview

A modern, enterprise-grade hotel room reservation system built with Java Spring Boot, implementing industry-standard design patterns, RESTful web services, and comprehensive testing practices.

**Developed for:** CIS6003 Advanced Programming Assessment  
**Institution:** School of Technologies  
**Academic Year:** 2025, Semester 1

---

## 🏗️ System Architecture

### 3-Tier Architecture

```
┌─────────────────────────────────────┐
│   Presentation Layer (Controllers)   │
│   - REST API Endpoints               │
│   - Request/Response Handling        │
│   - Input Validation                 │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Business Logic Layer (Services)    │
│   - Business Rules                   │
│   - Validation Logic                 │
│   - Transaction Management           │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Data Access Layer (Repositories)   │
│   - Database Operations              │
│   - Query Management                 │
│   - Entity Mapping                   │
└─────────────────────────────────────┘
```

---

## 🎯 Key Features

### Core Functionalities

1. **User Authentication & Authorization**
   - JWT-based secure authentication
   - Role-based access control (ADMIN, RECEPTIONIST, MANAGER)
   - Password encryption using BCrypt

2. **Reservation Management**
   - Create new reservations with validation
   - View all reservations
   - Search reservations by guest name
   - Update reservation status
   - Cancel reservations
   - Automatic bill calculation

3. **Room Availability Management**
   - Real-time availability checking
   - Conflict prevention
   - Multiple room types with different rates

4. **Reporting & Analytics**
   - Reservation details display
   - Bill generation
   - Guest history tracking

5. **Help System**
   - Built-in user guide
   - API documentation via Swagger

---

## 🔧 Design Patterns Implemented

### 1. **Singleton Pattern**
- **Implementation:** Spring Bean Management
- **Location:** All `@Service`, `@Repository`, `@Controller` classes
- **Purpose:** Ensures single instance of service classes

### 2. **Factory Pattern**
- **Implementation:** Spring Bean Factory
- **Location:** `@Configuration` classes
- **Purpose:** Object creation and dependency injection

### 3. **Data Access Object (DAO) Pattern**
- **Implementation:** Spring Data JPA Repositories
- **Location:** `com.oceanview.repository` package
- **Purpose:** Abstracts database operations

### 4. **Model-View-Controller (MVC) Pattern**
- **Implementation:** Spring MVC
- **Location:** Controllers, Services, Models
- **Purpose:** Separates concerns and improves maintainability

### 5. **Dependency Injection Pattern**
- **Implementation:** Spring Framework
- **Location:** Constructor injection throughout
- **Purpose:** Loose coupling and testability

---

## 🛠️ Technology Stack

| Layer | Technology |
|-------|-----------|
| **Backend Framework** | Spring Boot 3.2.0 |
| **Language** | Java 17 |
| **Database** | MySQL 8.0 / H2 (for testing) |
| **ORM** | Hibernate / JPA |
| **Security** | Spring Security + JWT |
| **API Documentation** | Swagger/OpenAPI 3.0 |
| **Testing** | JUnit 5, Mockito |
| **Build Tool** | Maven |
| **Validation** | Jakarta Bean Validation |

---

## 📦 Project Structure

```
src/
├── main/
│   ├── java/com/oceanview/
│   │   ├── config/              # Configuration classes
│   │   ├── controller/          # REST Controllers
│   │   ├── dto/                 # Data Transfer Objects
│   │   ├── exception/           # Exception handling
│   │   ├── model/               # Entity classes
│   │   ├── repository/          # Data access layer
│   │   ├── security/            # Security configuration
│   │   └── service/             # Business logic
│   └── resources/
│       ├── application.properties
│       └── application-test.properties
└── test/
    └── java/com/oceanview/      # Test classes
```

---

## 🚀 Getting Started

### Prerequisites

- Java 17 or higher
- Maven 3.6+
- MySQL 8.0+ (or use H2 for testing)
- Git

### Installation Steps

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/oceanview-resort.git
cd oceanview-resort
```

2. **Configure Database**

Edit `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/oceanview_resort
spring.datasource.username=your_username
spring.datasource.password=your_password
```

3. **Build the project**
```bash
mvn clean install
```

4. **Run the application**
```bash
mvn spring-boot:run
```

5. **Access the application**
- API Base URL: `http://localhost:8080`
- Swagger UI: `http://localhost:8080/swagger-ui.html`
- API Docs: `http://localhost:8080/api-docs`

---

## 🔐 Default User Credentials

| Username | Password | Role |
|----------|----------|------|
| admin | admin123 | ADMIN |
| receptionist | recep123 | RECEPTIONIST |
| manager | manager123 | MANAGER |

---

## 📡 API Endpoints

### Authentication

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/login` | User login |
| GET | `/api/auth/help` | System help |

### Reservations

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/reservations` | Create reservation | Yes |
| GET | `/api/reservations` | Get all reservations | Yes |
| GET | `/api/reservations/{number}` | Get specific reservation | Yes |
| GET | `/api/reservations/search?name={name}` | Search by guest name | Yes |
| PUT | `/api/reservations/{number}/status` | Update status | Yes |
| PUT | `/api/reservations/{number}/cancel` | Cancel reservation | Yes (ADMIN/MANAGER) |

---

## 🧪 Testing

### Test-Driven Development (TDD) Approach

This project follows TDD principles:

1. **Write tests first** - Define expected behavior
2. **Run tests** - Verify they fail initially
3. **Implement code** - Make tests pass
4. **Refactor** - Improve code quality

### Running Tests

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=ReservationServiceTest

# Run with coverage
mvn test jacoco:report
```

### Test Coverage

- **Unit Tests:** Service layer business logic
- **Integration Tests:** Controller endpoints
- **Test Data:** Mock objects and fixtures
- **Assertions:** Comprehensive validation

---

## 💳 Room Types & Pricing

| Room Type | Rate per Night (LKR) | Description |
|-----------|---------------------|-------------|
| STANDARD | 5,000 | Basic amenities |
| DELUXE | 8,000 | Ocean view |
| SUITE | 12,000 | Premium amenities |
| FAMILY | 15,000 | Multiple beds |
| PRESIDENTIAL | 25,000 | Exclusive services |

---

## 📊 Database Schema

### Users Table
- id (PK)
- username (unique)
- password (encrypted)
- full_name
- role
- active
- created_at

### Reservations Table
- id (PK)
- reservation_number (unique)
- guest_name
- address
- contact_number
- email
- room_type
- check_in_date
- check_out_date
- status
- number_of_guests
- special_requests
- total_amount
- created_at
- updated_at

---

## 🔒 Security Features

1. **JWT Authentication**
   - Token-based authentication
   - Secure token generation
   - Token validation on each request

2. **Password Encryption**
   - BCrypt hashing algorithm
   - Salt generation

3. **Role-Based Access Control**
   - Method-level security
   - Endpoint protection

4. **Input Validation**
   - Bean validation
   - Custom validators
   - SQL injection prevention

---

## 📝 Version Control (Git)

### Branching Strategy

```
main
├── develop
│   ├── feature/authentication
│   ├── feature/reservations
│   ├── feature/testing
│   └── feature/documentation
```

### Commit Convention

```
feat: Add new feature
fix: Bug fix
docs: Documentation update
test: Add tests
refactor: Code refactoring
```

### Git Workflow

1. Create feature branch
2. Implement changes
3. Commit with meaningful messages
4. Push to remote
5. Create pull request
6. Merge to develop
7. Deploy to main

---

## 📖 API Usage Examples

### 1. Login

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin123"
  }'
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "username": "admin",
    "fullName": "System Administrator",
    "role": "ADMIN"
  }
}
```

### 2. Create Reservation

```bash
curl -X POST http://localhost:8080/api/reservations \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "guestName": "John Doe",
    "address": "123 Main St, Colombo",
    "contactNumber": "0771234567",
    "email": "john@example.com",
    "roomType": "DELUXE",
    "checkInDate": "2025-01-15",
    "checkOutDate": "2025-01-17",
    "numberOfGuests": 2
  }'
```

### 3. Get Reservation

```bash
curl -X GET http://localhost:8080/api/reservations/RES123456 \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

---

## 🎓 Assessment Compliance

### Task A: UML Diagrams (20 marks) ✅
- Use Case Diagram
- Class Diagram
- Sequence Diagram
- Design decisions documented

### Task B: System Development (40 marks) ✅
- Web services (RESTful API)
- Design patterns implemented
- Database integration
- Input validation
- Professional UI (Swagger)

### Task C: Testing (20 marks) ✅
- Test-Driven Development
- Unit tests
- Integration tests
- Test automation
- Test documentation

### Task D: Version Control (20 marks) ✅
- Git repository
- Multiple versions
- Commit history
- Workflow documentation

---

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

---

## 📄 License

This project is developed for academic purposes as part of CIS6003 Advanced Programming assessment.

---

## 👥 Contact

**Developer:** [Your Name]  
**Student ID:** [Your ID]  
**Email:** [Your Email]  
**Institution:** School of Technologies

---

## 🙏 Acknowledgments

- Spring Boot Documentation
- Baeldung Tutorials
- Stack Overflow Community
- Module Lecturer: priyanga@icbtcampus.edu.lk

---

**Last Updated:** January 2025  
**Version:** 1.0.0

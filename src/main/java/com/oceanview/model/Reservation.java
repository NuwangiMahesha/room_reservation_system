package com.oceanview.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

/**
 * Reservation Entity - Core business entity
 * Represents a room reservation with guest details
 */
@Entity
@Table(name = "reservations")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reservation {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String reservationNumber;
    
    @NotBlank(message = "Guest name is required")
    private String guestName;
    
    @NotBlank(message = "Address is required")
    private String address;
    
    @NotBlank(message = "Contact number is required")
    @Pattern(regexp = "^[0-9]{10}$", message = "Contact number must be 10 digits")
    private String contactNumber;
    
    @Email(message = "Valid email is required")
    private String email;
    
    @Enumerated(EnumType.STRING)
    @NotNull(message = "Room type is required")
    private RoomType roomType;
    
    @NotNull(message = "Check-in date is required")
    private LocalDate checkInDate;
    
    @NotNull(message = "Check-out date is required")
    private LocalDate checkOutDate;
    
    @Enumerated(EnumType.STRING)
    private ReservationStatus status = ReservationStatus.CONFIRMED;
    
    private Integer numberOfGuests;
    
    private String specialRequests;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal totalAmount;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (reservationNumber == null) {
            reservationNumber = generateReservationNumber();
        }
        calculateTotalAmount();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
        calculateTotalAmount();
    }
    
    /**
     * Generates unique reservation number
     */
    private String generateReservationNumber() {
        return "RES" + System.currentTimeMillis();
    }
    
    /**
     * Calculates total amount based on room type and duration
     */
    public void calculateTotalAmount() {
        if (checkInDate != null && checkOutDate != null && roomType != null) {
            long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
            if (nights > 0) {
                totalAmount = roomType.getRatePerNight().multiply(BigDecimal.valueOf(nights));
            }
        }
    }
    
    /**
     * Gets number of nights for the reservation
     */
    public long getNumberOfNights() {
        if (checkInDate != null && checkOutDate != null) {
            return ChronoUnit.DAYS.between(checkInDate, checkOutDate);
        }
        return 0;
    }
}

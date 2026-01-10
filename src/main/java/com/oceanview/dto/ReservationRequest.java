package com.oceanview.dto;

import com.oceanview.model.RoomType;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

/**
 * Reservation Request DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationRequest {
    
    @NotBlank(message = "Guest name is required")
    @Size(min = 2, max = 100, message = "Guest name must be between 2 and 100 characters")
    private String guestName;
    
    @NotBlank(message = "Address is required")
    private String address;
    
    @NotBlank(message = "Contact number is required")
    @Pattern(regexp = "^[0-9]{10}$", message = "Contact number must be 10 digits")
    private String contactNumber;
    
    @Email(message = "Valid email is required")
    private String email;
    
    @NotNull(message = "Room type is required")
    private RoomType roomType;
    
    @NotNull(message = "Check-in date is required")
    @FutureOrPresent(message = "Check-in date must be today or in the future")
    private LocalDate checkInDate;
    
    @NotNull(message = "Check-out date is required")
    @Future(message = "Check-out date must be in the future")
    private LocalDate checkOutDate;
    
    @Min(value = 1, message = "At least one guest is required")
    @Max(value = 10, message = "Maximum 10 guests allowed")
    private Integer numberOfGuests;
    
    private String specialRequests;
}

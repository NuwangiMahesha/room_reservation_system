package com.oceanview.dto;

import com.oceanview.model.ReservationStatus;
import com.oceanview.model.RoomType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Reservation Response DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationResponse {
    
    private Long id;
    private String reservationNumber;
    private String guestName;
    private String address;
    private String contactNumber;
    private String email;
    private RoomType roomType;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private ReservationStatus status;
    private Integer numberOfGuests;
    private String specialRequests;
    private BigDecimal totalAmount;
    private long numberOfNights;
}

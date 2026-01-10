// Set minimum dates
document.addEventListener('DOMContentLoaded', function() {
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('checkInDate').setAttribute('min', today);
    document.getElementById('checkOutDate').setAttribute('min', today);
    
    // Add event listeners for date and room type changes
    document.getElementById('checkInDate').addEventListener('change', updateCalculation);
    document.getElementById('checkOutDate').addEventListener('change', updateCalculation);
    document.getElementById('roomType').addEventListener('change', updateCalculation);
});

// Update calculation
function updateCalculation() {
    const roomType = document.getElementById('roomType').value;
    const checkIn = document.getElementById('checkInDate').value;
    const checkOut = document.getElementById('checkOutDate').value;
    
    if (roomType && checkIn && checkOut) {
        const nights = calculateNights(checkIn, checkOut);
        const total = calculateTotalAmount(roomType, checkIn, checkOut);
        
        document.getElementById('numberOfNights').textContent = nights;
        document.getElementById('totalAmount').textContent = formatCurrency(total);
        document.getElementById('calculatedAmount').style.display = 'block';
    }
}

// Reset form
function resetForm() {
    document.getElementById('reservationForm').reset();
    document.getElementById('calculatedAmount').style.display = 'none';
    document.getElementById('errorMessage').style.display = 'none';
    document.getElementById('successMessage').style.display = 'none';
}

// Handle form submission
document.getElementById('reservationForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    
    const formData = {
        guestName: document.getElementById('guestName').value,
        address: document.getElementById('address').value,
        contactNumber: document.getElementById('contactNumber').value,
        email: document.getElementById('email').value,
        roomType: document.getElementById('roomType').value,
        checkInDate: document.getElementById('checkInDate').value,
        checkOutDate: document.getElementById('checkOutDate').value,
        numberOfGuests: parseInt(document.getElementById('numberOfGuests').value),
        specialRequests: document.getElementById('specialRequests').value
    };
    
    try {
        const response = await fetch(`${API_BASE_URL}/reservations`, {
            method: 'POST',
            headers: getAuthHeaders(),
            body: JSON.stringify(formData)
        });
        
        const data = await response.json();
        
        if (response.ok && data.success) {
            showSuccess('successMessage', `Reservation created successfully! Reservation Number: ${data.data.reservationNumber}`);
            setTimeout(() => {
                window.location.href = 'view-reservations.html';
            }, 2000);
        } else {
            showError('errorMessage', data.message || 'Failed to create reservation');
        }
    } catch (error) {
        console.error('Error creating reservation:', error);
        showError('errorMessage', 'Unable to create reservation. Please try again.');
    }
});

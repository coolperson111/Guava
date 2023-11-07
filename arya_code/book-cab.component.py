from flask import Flask, request, jsonify

app = Flask(__name__)


# Mocked cab provider API function for demonstration
def book_cab_provider(pickup, dropoff):
    # You can replace this with actual API integration logic
    return f"Booked cab from {pickup} to {dropoff}"


# Initialize an empty list to store bookings
bookings = []
booking_id_counter = 1


def generate_booking_id():
    global booking_id_counter
    booking_id = booking_id_counter
    booking_id_counter += 1
    return booking_id


@app.route('/book_cab', methods=['POST'])
def book_cab():
    try:
        data = request.get_json()
        if not data or 'pickup' not in data or 'dropoff' not in data:
            return jsonify(success=False, message="Invalid JSON data or missing pickup/dropoff"), 400

        pickup = data['pickup']
        dropoff = data['dropoff']

        if not pickup or not dropoff:
            return jsonify(success=False, message="Empty pickup or dropoff location"), 400

        result = book_cab_provider(pickup, dropoff)

        # Generate a unique booking ID
        booking_id = generate_booking_id()

        # Store the booking data
        booking_data = {'id': booking_id, 'pickup': pickup, 'dropoff': dropoff}
        bookings.append(booking_data)

        return jsonify(success=True, message=result, booking_id=booking_id)
    except Exception as e:
        return jsonify(success=False, message=str(e)), 500


@app.route('/cancel_booking/<int:booking_id>', methods=['DELETE'])
def cancel_booking(booking_id):
    try:
        # Find the booking to cancel
        booking_to_cancel = next((booking for booking in bookings if booking['id'] == booking_id), None)
        if not booking_to_cancel:
            return jsonify(success=False, message=f"Booking {booking_id} not found"), 404

        # You can implement cancellation logic here
        bookings.remove(booking_to_cancel)
        return jsonify(success=True, message=f"Booking {booking_id} has been canceled.")
    except Exception as e:
        return jsonify(success=False, message=str(e)), 500


@app.route('/bookings', methods=['GET'])
def get_bookings():
    return jsonify(success=True, bookings=bookings)


@app.route('/booking/<int:booking_id>', methods=['GET'])
def get_booking(booking_id):
    booking = next((booking for booking in bookings if booking['id'] == booking_id), None)
    if not booking:
        return jsonify(success=False, message=f"Booking {booking_id} not found"), 404
    return jsonify(success=True, booking=booking)


if __name__ == '__main__':
    app.run(debug=True)

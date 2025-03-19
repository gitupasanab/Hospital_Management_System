import streamlit as st
import mysql.connector

# Function to connect to the database
def connect_to_database():
    return mysql.connector.connect(
        host="localhost",  # Change this to your host
        user="root",  # Change to your username
        password="Sql@21",  # Change to your password
        database="Hospital_Management_System"  # Change to your database name
    )

# Appointment Scheduling Form
def schedule_appointment():
    st.title("Schedule an Appointment")
    
    patient_id = st.number_input("Patient ID", min_value=1)
    staff_id = st.number_input("Staff ID (Doctor ID)", min_value=1)
    appointment_date = st.date_input("Appointment Date")
    appointment_time = st.time_input("Appointment Time")
    
    if st.button("Schedule Appointment"):
        if patient_id and staff_id and appointment_date and appointment_time:
            try:
                db = connect_to_database()
                cursor = db.cursor()
                cursor.execute("""
                    INSERT INTO Appointments (patient_id, staff_id, appointment_date, appointment_time)
                    VALUES (%s, %s, %s, %s)
                """, (patient_id, staff_id, appointment_date, appointment_time))
                db.commit()
                st.success(f"Appointment scheduled for patient {patient_id} with doctor {staff_id} on {appointment_date} at {appointment_time}")
            except Exception as e:
                st.error(f"Error: {e}")
            finally:
                db.close()
        else:
            st.warning("Please fill in all required fields.")

# Main app execution
if __name__ == "__main__":
    schedule_appointment()

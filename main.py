import streamlit as st
from hms import register_patient
from app import schedule_appointment
from staff import manage_staff

def main():
    menu = ["Register Patient", "Schedule Appointment", "Manage Staff"]
    choice = st.sidebar.selectbox("Select an option", menu)

    if choice == "Register Patient":
        register_patient()
    elif choice == "Schedule Appointment":
        schedule_appointment()
    elif choice == "Manage Staff":
        manage_staff()

if __name__ == "__main__":
    main()

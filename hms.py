import streamlit as st
import streamlit as st
import mysql.connector

# Database connection
def connect_to_database():
    return mysql.connector.connect(
        host="localhost",
        user="root",  
        password="Sql@21", 
        database="Hospital_Management_System" 
    )
# Register Patient Form
def register_patient():
    st.title("Register Patient")
    
    name = st.text_input("Name")
    age = st.number_input("Age", min_value=0, max_value=150, step=1)
    gender = st.selectbox("Gender", ["Male", "Female", "Other"])
    contact_number = st.text_input("Contact Number")
    address = st.text_area("Address")
    medical_history = st.text_area("Medical History")
    treatment_details = st.text_area("Treatment Details")
    
    if st.button("Register"):
        if name and contact_number and address:
            try:
                db = connect_to_database()
                cursor = db.cursor()
                cursor.execute(
                    """
                    INSERT INTO Patients (name, age, gender, contact_number, address, medical_history, treatment_details)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                    """,
                    (name, age, gender, contact_number, address, medical_history, treatment_details)
                )
                db.commit()
                st.success("Patient registered successfully!")
            except Exception as e:
                st.error(f"Error: {e}")
            finally:
                db.close()
        else:
            st.warning("Please fill in all the required fields.")

# Main App
if __name__ == "__main__":
    register_patient()



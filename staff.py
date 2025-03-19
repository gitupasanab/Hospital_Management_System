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

# Staff Registration and Management Form
def manage_staff():
    st.title("Staff Management")
    
    action = st.selectbox("Choose Action", ["Register Staff", "Update Staff Schedule", "View Staff List"])
    
    if action == "Register Staff":
        name = st.text_input("Staff Name")
        role = st.selectbox("Role", ["Doctor", "Nurse", "Admin", "Other"])
        contact_number = st.text_input("Contact Number")
        email = st.text_input("Email")
        schedule = st.text_area("Schedule")
        
        if st.button("Register Staff"):
            if name and role and contact_number and email and schedule:
                try:
                    db = connect_to_database()
                    cursor = db.cursor()
                    cursor.execute("""
                        INSERT INTO Staff (name, role, contact_number, email, schedule)
                        VALUES (%s, %s, %s, %s, %s)
                    """, (name, role, contact_number, email, schedule))
                    db.commit()
                    st.success(f"{role} {name} registered successfully!")
                except Exception as e:
                    st.error(f"Error: {e}")
                finally:
                    db.close()
            else:
                st.warning("Please fill in all required fields.")
    
    elif action == "Update Staff Schedule":
        staff_id = st.number_input("Staff ID", min_value=1)
        new_schedule = st.text_area("New Schedule")
        
        if st.button("Update Schedule"):
            if staff_id and new_schedule:
                try:
                    db = connect_to_database()
                    cursor = db.cursor()
                    cursor.execute("""
                        UPDATE Staff SET schedule = %s WHERE staff_id = %s
                    """, (new_schedule, staff_id))
                    db.commit()
                    st.success(f"Schedule updated for Staff ID {staff_id}")
                except Exception as e:
                    st.error(f"Error: {e}")
                finally:
                    db.close()
            else:
                st.warning("Please fill in all required fields.")
    
    elif action == "View Staff List":
        try:
            db = connect_to_database()
            cursor = db.cursor()
            cursor.execute("SELECT * FROM Staff")
            staff_list = cursor.fetchall()
            
            st.subheader("Staff List:")
            for staff in staff_list:
                st.write(f"Name: {staff[1]}, Role: {staff[2]}, Contact: {staff[3]}, Email: {staff[4]}, Schedule: {staff[5]}")
        except Exception as e:
            st.error(f"Error: {e}")
        finally:
            db.close()

# Main app execution
if __name__ == "__main__":
    manage_staff()

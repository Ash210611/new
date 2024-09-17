import sqlite3
import requests
import json
import time
import shutil
import datetime
count = 0
def copy_file(source_path, destination_path):
    try:
        shutil.copy(source_path, destination_path)
        count =+ 1
        print(f"File copied successfully from '{source_path}' to '{destination_path}'.","count = ",count)
    except FileNotFoundError:
        print("File not found. Please check the file paths.")
    except Exception as e:
        print(f"An error occurred: {e}")

# SQLite database file path

firefox_history_path = 'C:/Users/Akash/Desktop/test/places.sqlite'
chrome_history_path = 'C:/Users/Akash/Desktop/test/History'

# Splunk HEC endpoint URL
hec_url = 'http://ubuntu:8088/services/collector'
hec_token = '2669c84e-2759-476b-94f1-6d10fb58c2cb'

# Connect to SQLite database
def connect_to_db(db_path):
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        return conn, cursor
    except sqlite3.Error as e:
        print(f"Error connecting to database: {e}")
        return None, None

# Query Chrome history
def query_chrome_history(cursor,last_timestamp):
    cursor.execute("SELECT url, title, last_visit_time FROM urls WHERE last_visit_time > ?", (last_timestamp,))
    return cursor.fetchall()

# Query Firefox history
def query_firefox_history(cursor,last_timestamp):
    cursor.execute("SELECT url, title, last_visit_date FROM moz_places WHERE last_visit_date > ?",(last_timestamp,))
    return cursor.fetchall()

# Format data for Splunk
def format_data(url,keyword, timestamp, browser):
    if browser == "Chrome":
        # Chrome uses microseconds since January 1, 1601
        epoch = datetime.datetime(1601, 1, 1)
        last_visit_time_seconds = timestamp / 1000000  # Adjust for Unix epoch start
    else:  # Firefox
        # Firefox uses microseconds since January 1, 1970
        epoch = datetime.datetime(1970, 1, 1)
        last_visit_time_seconds = timestamp / 1000000
    visit_time = epoch + datetime.timedelta(seconds=last_visit_time_seconds)
    # Convert the timestamp to local time
    local_time_final = visit_time.astimezone()
    local_time = str(local_time_final)
    #for firefox
    print(keyword)
    if keyword is not None and browser == "Firefox" :
        final_keyword = keyword
    else:
        final_keyword = "none (Visited a link that was either open by Browser or a hyperlink was directly entered into the search bar)"
    if keyword is not None and browser == "Chrome":
        if 'Google Search' in keyword:
            final_keyword = keyword
        else:
            final_keyword = keyword+"(Visited a hyperlink)"
    return json.dumps({'event': {'url': url, 'Keyword': final_keyword, 'timestamp': local_time, 'browser': browser}})


# Send data to Splunk via HEC
def send_to_splunk(data):
    headers = {'Authorization': 'Splunk ' + hec_token}
    response = requests.post(hec_url, headers=headers, data=data)
    if response.status_code != 200:
        print(f"Failed to send data to Splunk: {response.text}")

# Main loop
last_chrome_timestamp = 0
last_firefox_timestamp = 0
while True:
    # Connect to Chrome history database
    source_path = "C:/Users/Akash/AppData/Local/Google/Chrome/User Data/Default/History"
    destination_path = "C:/Users/Akash/Desktop/test/History"
    copy_file(source_path, destination_path)
    chrome_conn, chrome_cursor = connect_to_db(chrome_history_path)
    if chrome_conn and chrome_cursor:
        chrome_data = query_chrome_history(chrome_cursor,last_chrome_timestamp)
        for url, keyword, timestamp in chrome_data:
            data = format_data(url, keyword, timestamp, 'Chrome')
            send_to_splunk(data)
            last_chrome_timestamp = max(last_chrome_timestamp, timestamp)  # Update last timestamp
        chrome_conn.close()

    # Connect to Firefox history database
    source_path = "C:/Users/Akash/AppData/Roaming/Mozilla/Firefox/Profiles/ym96www6.default-release/places.sqlite"
    destination_path = "C:/Users/Akash/Desktop/test/places.sqlite"
    copy_file(source_path, destination_path)
    firefox_conn, firefox_cursor = connect_to_db(firefox_history_path)
    if firefox_conn and firefox_cursor:
        firefox_data = query_firefox_history(firefox_cursor,last_firefox_timestamp)
        for url, keyword, timestamp in firefox_data:
            data = format_data(url,keyword, timestamp, 'Firefox')
            send_to_splunk(data)
            last_firefox_timestamp = max(last_firefox_timestamp, timestamp)
        firefox_conn.close()

    # Wait for 1 minute before querying again
    time.sleep(1)
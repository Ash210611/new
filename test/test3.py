import datetime
# def format_data(timestamp, browser):
#     if browser == "Chrome":
#         # Chrome uses microseconds since January 1, 1601
#         epoch = datetime.datetime(1601, 1, 1)
#         last_visit_time_seconds = timestamp / 1000000  # Adjust for Unix epoch start
#     else:  # Firefox
#         # Firefox uses microseconds since January 1, 1970
#         epoch = datetime.datetime(1970, 1, 1)
#         last_visit_time_seconds = timestamp / 1000000
#
#     visit_time = epoch + datetime.timedelta(seconds=last_visit_time_seconds)
#     # Convert the timestamp to local time
#     local_time_final = visit_time.astimezone()
#     local_time = str(local_time_final)
#     print(local_time)
#
#
# format_data(13357909302602442,"Chrome")
# format_data(1714133002778000, "Firefox")


import json
from datetime import datetime

def process_entry(url, keyword, timestamp, browser):
    # Convert timestamp (assuming it's in microseconds since the epoch) to a readable format
    local_time = datetime.fromtimestamp(timestamp / 1e6).strftime('%Y-%m-%d %H:%M:%S')

    # Check if the keyword is not None and the browser is Firefox
    if keyword is not None and browser == "Firefox":
        final_keyword = keyword
    else:
        # Set a default message if the keyword is None or the browser is not Firefox
        final_keyword = "none (Visited a link that was either opened by Browser or a hyperlink was directly entered into the search bar)"

    # Create a JSON object with the event data
    return json.dumps({'event': {'url': url, 'Keyword': final_keyword, 'timestamp': local_time, 'browser': browser}})

# Example usage
entry = ('https://www.mozilla.org/privacy/firefox/', None, 1712183593901000, 'Firefox')
print(process_entry(*entry))

























# import datetime
# last_visit_time_microseconds = 13357909302602442  # Replace this with your actual last_visit_time in microseconds
# # Convert microseconds to seconds and add to the epoch time of 1601-01-01
# epoch = datetime.datetime(1601, 1, 1)
# last_visit_time_seconds = last_visit_time_microseconds / 1000000
# timestamp = epoch + datetime.timedelta(seconds=last_visit_time_seconds)
# # Convert the timestamp to local time
# local_time = timestamp.astimezone()
# time_stmap = str(local_time)
#
# print(local_time)
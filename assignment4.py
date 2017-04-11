#!/usr/bin/python
#
# Name: Travis Weaver
# Date: April 5, 2017
# Last Updated: April 6, 2017
# Working build
#
# Command to install mysql connector for Python 2.7:
#
# sudo apt-get install python-pip
# pip install [--egg] mysql-connector-python-rf

from __future__ import print_function
import sys
import mysql.connector

connection = mysql.connector.connect(host = '104.196.222.235', 
							 port = '3306', 
							 user = 'root', 
							 password = 'root',
							 db = 'hotel_booking_hw3')

# Question 2 - Part A

cursor = connection.cursor()
cursor.execute("SELECT * FROM Hotel")

print()
print("Question 2 - Part A: SELECT * FROM Hotel;")
print()
print("%-20s\t %-20s\t %-20s" % ("hotelNo", "hotelName", "city"))
print("%-20s\t %-20s\t %-20s" % ("-------", "---------", "----"))
print()

for row in cursor:
	print("%-20s\t %-20s\t %-20s" % (row[0], row[1], row[2]))

# Question 2 - Part B

cursor = connection.cursor()
cursor.execute("SELECT * FROM Hotel WHERE city = 'London';")

print()
print("Question 2 - Part B: SELECT * FROM Hotel WHERE city = 'London';")
print()
print("%-20s\t %-20s\t %-20s" % ("hotelNo", "hotelName", "city"))
print("%-20s\t %-20s\t %-20s" % ("-------", "---------", "----"))
print()

for row in cursor:
	print("%-20s\t %-20s\t %-20s" % (row[0], row[1], row[2]))

# Question 2 - Part C

cursor = connection.cursor()
cursor.execute("SELECT guestName, guestAddress FROM Guest WHERE guestAddress LIKE '%London%' ORDER BY guestName;")

print()
print("Question 2 - Part C: SELECT guestName, guestAddress FROM Guest WHERE guestAddress LIKE '%London%' ORDER BY guestName;")
print()
print("%-20s\t %-20s" % ("guestName", "guestAddress"))
print("%-20s\t %-20s" % ("---------", "------------"))
print()

for row in cursor:
	print("%-20s\t %-20s" % (row[0], row[1]))

# Question 3 - Part A

cursor = connection.cursor()
cursor.execute("SELECT AVG(price) AS averagePrice FROM Room;")

print()
print("Question 3 - Part A: SELECT AVG(price) AS averagePrice FROM Room;")
print()
print("%-20s" % ("averagePrice"))
print("%-20s" % ("------------"))
print()

for row in cursor:
	print("%-20s" % (row[0]))

# Question 3 - Part B

cursor = connection.cursor()
cursor.execute("SELECT price, type FROM Room \
				WHERE hotelNo = (SELECT hotelNo FROM Hotel WHERE hotelName = 'Grosvenor');")

print()
print("Question 3 - Part B: SELECT price, type FROM Room WHERE hotelNo = (SELECT hotelNo FROM Hotel WHERE hotelName = 'Grosvenor');")
print()
print("%-20s\t %-20s" % ("price", "type"))
print("%-20s\t %-20s" % ("-----", "----"))
print()

for row in cursor:
	print("%-20s\t %-20s" % (row[0], row[1]))

# Question 3 - Part C

cursor = connection.cursor()
cursor.execute("SELECT SUM(price) as grossIncome FROM Room \
				WHERE hotelNo = 13 AND roomNo IN (SELECT roomNo FROM Booking b, Hotel h \
				WHERE (dateFrom <=  CURDATE() AND dateTo >= CURDATE()) AND b.hotelNo = h.hotelNo \
				AND hotelName = 'Grosvenor');")

print()
print("Question 3 - Part C: SELECT SUM(price) as grossIncome FROM Room WHERE hotelNo = 13 AND roomNo IN (SELECT roomNo FROM Booking b, Hotel h WHERE (dateFrom <=  CURDATE() AND dateTo >= CURDATE()) AND b.hotelNo = h.hotelNo AND hotelName = 'Grosvenor');")
print()
print("%-20s" % ("grossIncome"))
print("%-20s" % ("-----------"))
print()

for row in cursor:
	print("%-20s" % (row[0]))

# Question 3 - Part D

cursor = connection.cursor()
cursor.execute("SELECT h.hotelNo, COUNT(r.roomNo) AS numRooms FROM Hotel h, Room r WHERE r.hotelNo = h.hotelNo AND city LIKE '%London%' GROUP BY h.hotelNo;")

print()
print("Question 3 - Part D: SELECT h.hotelNo, COUNT(r.roomNo) AS numRooms FROM Hotel h, Room r WHERE r.hotelNo = h.hotelNo AND city LIKE '%London%' GROUP BY h.hotelNo;")
print()
print("%-20s\t %-20s" % ("hotelNo", "numRooms"))
print("%-20s\t %-20s" % ("-----", "----"))
print()

for row in cursor:
	print("%-20s\t %-20s" % (row[0], row[1]))

# Question 3 - Part E

cursor = connection.cursor()
cursor.execute("SELECT type AS mostBookedType, COUNT(*) AS numTimes FROM Hotel h, Room r WHERE h.city = 'London' AND h.hotelNo = r.hotelNo GROUP BY type ORDER BY numTimes DESC;")

print()
print("Question 3 - Part E: SELECT type AS mostBookedType, COUNT(*) AS numTimes FROM Hotel h, Room r WHERE h.city = 'London' AND h.hotelNo = r.hotelNo GROUP BY type ORDER BY numTimes DESC;")
print()
print("%-20s\t %-20s" % ("hotelNo", "numRooms"))
print("%-20s\t %-20s" % ("-----", "----"))
print()

for row in cursor:
	print("%-20s\t %-20s" % (row[0], row[1]))

# Question 3 - Part F

cursor = connection.cursor()
cursor.execute("SELECT * FROM Room")

print()
print("Question 3 - Part F: UPDATE Room SET price = price * 1.05;")
print()
print("***** Before Update *****")
print()
print("%-20s\t %-20s\t %-20s\t %-20s" % ("roomNo", "hotelNo", "type", "price"))
print("%-20s\t %-20s\t %-20s\t %-20s" % ("------", "-------", "----", "-----"))
print()

for row in cursor:
	print("%-20s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3]))

cursor.execute("UPDATE Room SET price = price * 1.05;")
cursor.execute("SELECT * FROM Room")

print()
print("***** After Update *****")
print()
print("%-20s\t %-20s\t %-20s\t %-20s" % ("roomNo", "hotelNo", "type", "price"))
print("%-20s\t %-20s\t %-20s\t %-20s" % ("------", "-------", "----", "-----"))
print()

for row in cursor:
	print("%-20s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3]))

# Question 3 - Part G

cursor = connection.cursor()
cursor.execute("CREATE OR REPLACE VIEW CheapHotels AS SELECT h.hotelName, r.price, h.city, r.type FROM Hotel h, Room r WHERE h.hotelNo = r.hotelNo ORDER BY r.price ASC;")
cursor.execute("SELECT * FROM CheapHotels")

print()
print("Question 3 - Part G: CREATE OR REPLACE VIEW CheapHotels AS SELECT h.hotelName, r.price, h.city, r.type FROM Hotel h, Room r WHERE h.hotelNo = r.hotelNo ORDER BY r.price ASC;")
print()
print("%-20s\t %-20s\t %-20s\t %-20s" % ("hotelName", "price", "city", "type"))
print("%-20s\t %-20s\t %-20s\t %-20s" % ("---------", "-----", "----", "----"))
print()

for row in cursor:
	print("%-20s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3]))

# Question 3 - Part J(a): SELECT * FROM HotelBookingCount;

cursor = connection.cursor()
cursor.execute("SELECT * FROM HotelBookingCount")

print()
print("Question 3 - Part J(a): SELECT * FROM HotelBookingCount;")
print()
print("%-20s\t %-20s" % ("hotelNo", "bookingCount"))
print("%-20s\t %-20s" % ("-------", "------------"))
print()

for row in cursor:
	print("%-20s\t %-20s" % (row[0], row[1]))

print()

cursor.close()
connection.close()

#
# EOF
#
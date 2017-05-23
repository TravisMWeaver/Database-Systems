#!/usr/bin/python
#
# Name: Travis Weaver
# Date: April 30, 2017
# Last Updated: May 5, 2017
#
# Command to install mysql connector for Python 2.7:
#
# sudo apt-get install python-pip
# pip install [--egg] mysql-connector-python-rf

from __future__ import print_function
from enum import Enum
import sys
import mysql.connector
import numpy as np

connection = mysql.connector.connect(host = '104.196.222.235', 
							 port = '3306', 
							 user = 'root', 
							 password = 'root',
							 db = 'music_rec_info_sys')

class TableNames(Enum):
	Album = 1
	Household = 2
	Instrument = 3
	Instruments_For_Musician = 4
	Musician = 5
	Song_Credits = 6
	Songs = 7

def welcome_message():
	print("\t--- ABC Records ---")
	print("Musical Recording Information System")
	print("------------------------------------")
	print()

def main_menu():
	print("\t--- Main Menu ---")
	print("Please select a category below by entering the corresponding integer.")
	print("---------------------------------------------------------------------")
	print("")
	print("(Option) Category")
	print("-----------------")
	print("(1) View All Records")
	print("(2) Sample Queries")
	print("(3) Insert, Update, and Delete Records")
	print("(0) Exit")
	print("")

def view_all_records_menu():
	print("\t--- View All Records ---")
	print("Please select a table to view all corresponding records.")
	print("--------------------------------------------------------")
	print("")
	print("(Option) Table")
	print("-----------------")
	print("(1) Album")
	print("(2) Household")
	print("(3) Instrument")
	print("(4) Instruments_For_Musician")
	print("(5) Musician")
	print("(6) Song_Credits")
	print("(7) Songs")
	# print("(9) Main Menu")
	print("(0) Exit")
	print("")

def view_record(user_choice):
	table = TableNames(user_choice).name
	cursor = connection.cursor()
	cursor.execute("SELECT * FROM %s" % table)
	print("")
	col_names = cursor.column_names
	col_length = len(col_names)

	if col_length == 1:
		print("%-20s" % (col_names[0]))
		print("%-20s" % ("----------"))
	elif col_length == 2:
		print("%-20s\t %-20s" % (col_names[0], col_names[1]))
		print("%-20s\t %-20s" % ("----------", "----------"))
	elif col_length == 3:
		print("%-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2]))
		print("%-20s\t %-20s\t %-20s" % ("----------", "----------", "----------"))
	elif col_length == 4:
		print("%-40s\t %-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2], col_names[3]))
		print("%-40s\t %-20s\t %-20s\t %-20s" % ("----------", "----------", "----------", "----------"))
	elif col_length == 5:
		print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2], col_names[3], col_names[4]))
		print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % ("----------", "----------", "----------", "----------", "----------"))
	elif col_length == 6:
		print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2], col_names[3], col_names[4], col_names[5]))
		print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s\t %-20s" % ("----------", "----------", "----------", "----------", "----------", "----------"))
	else:
		print("Error: Unsupported number of columns")

	for row in cursor:
		length = len(row)
		if length == 1:
			print("%-20s" % (row[0]))
		elif length == 2:
			print("%-20s\t %-20s" % (row[0], row[1]))
		elif length == 3:
			print("%-20s\t %-20s\t %-20s" % (row[0], row[1], row[2]))
		elif length == 4:
			print("%-40s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3]))
		elif length == 5:
			print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3], row[4]))
		elif length == 6:
			print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3], row[4], row[5]))
		else:
			print("Error: Unsupported number of columns")

def view_query_menu():
	print("\t--- Sample Queries ---")
	print("Please select a query to perform.")
	print("---------------------------------")
	print("")
	print("(Option) Query")
	print("--------------")
	print("(1) View album info for given musician")
	print("(2) View details of musicians, sorted by last name, who can play given instrument")
	print("(3) View details of songs in given album")
	print("(4) View total number of albums with given copyright date")
	print("(5) View most prolific producers in the company (greater than average produced albums)")
	print("(6) View musicians who play more than two instruments")
	print("(7) View total number of songs played by each musician")
	# print("(9) Main Menu")
	print("(0) Exit")
	print("")

def view_query(user_choice):
	cursor = connection.cursor()

	if user_choice == 1:
		mid = input("Enter musician_id: ")
		cursor.execute("SELECT * FROM Album WHERE producer = %d" % mid)
		col_names = cursor.column_names
		print("")
		print("%-40s\t %-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2], col_names[3]))
		print("%-40s\t %-20s\t %-20s\t %-20s" % ("----------", "----------", "----------", "----------"))
		for row in cursor:
			print("%-40s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3]))
	elif user_choice == 2:
		iid = input("Enter instrument_id: ")
		cursor.execute("SELECT m.* FROM Musician m, Instruments_For_Musician i WHERE i.instrument_id = %d AND i.musician_id = m.musician_id ORDER BY m.last_name;" % iid)
		col_names = cursor.column_names
		print("")
		print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2], col_names[3], col_names[4]))
		print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % ("----------", "----------", "----------", "----------", "----------"))
		for row in cursor:
			print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3], row[4]))
	elif user_choice == 3:
		aid = input("Enter album_id: ")
		cursor.execute("SELECT s.* FROM music_rec_info_sys.Album a, music_rec_info_sys.Songs s WHERE a.album_id = s.album_id AND a.album_id = %d;" % aid)
		col_names = cursor.column_names
		print("")
		print("%-40s\t %-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2], col_names[3]))
		print("%-40s\t %-20s\t %-20s\t %-20s" % ("----------", "----------", "----------", "----------"))
		for row in cursor:
			print("%-40s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3]))
	elif user_choice == 4:
		cpd = input("Enter copyright_date: ")
		cpd = str(cpd)
		query = "SELECT * FROM music_rec_info_sys.Album WHERE copyright_date LIKE %s;"
		cursor.execute(query, ("%" + cpd + "%",))
		col_names = cursor.column_names
		print("")
		print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2], col_names[3], col_names[4]))
		print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % ("----------", "----------", "----------", "----------", "----------"))
		for row in cursor:
			print("%-20s\t %-20s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3], row[4]))
	elif user_choice == 5:
		cursor.execute("SELECT m.last_name, m.first_name, COUNT(m.musician_id) AS num_produced FROM music_rec_info_sys.Musician m, music_rec_info_sys.Album a WHERE m.musician_id = a.producer GROUP BY m.musician_id HAVING num_produced > AVG(num_produced);")
		col_names = cursor.column_names
		print("")
		print("%-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2]))
		print("%-20s\t %-20s\t %-20s" % ("----------", "----------", "----------"))
		for row in cursor:
			print("%-20s\t %-20s\t %-20s" % (row[0], row[1], row[2]))
	elif user_choice == 6:
		cursor.execute("SELECT m.last_name, m.first_name, COUNT(i.instrument_id) AS num_instruments FROM music_rec_info_sys.Musician m, music_rec_info_sys.Instruments_For_Musician i WHERE m.musician_id = i.musician_id GROUP BY m.musician_id HAVING num_instruments > 2;")
		col_names = cursor.column_names
		print("")
		print("%-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2]))
		print("%-20s\t %-20s\t %-20s" % ("----------", "----------", "----------"))
		for row in cursor:
			print("%-20s\t %-20s\t %-20s" % (row[0], row[1], row[2]))
	elif user_choice == 7:
		cursor.execute("SELECT m.last_name, m.first_name, COUNT(s.track_number) AS num_songs, m.musician_id FROM music_rec_info_sys.Musician m, music_rec_info_sys.Song_Credits s WHERE m.musician_id = s.musician_id GROUP BY m.musician_id ORDER BY m.last_name;")
		col_names = cursor.column_names
		print("")
		print("%-40s\t %-20s\t %-20s\t %-20s" % (col_names[0], col_names[1], col_names[2], col_names[3]))
		print("%-40s\t %-20s\t %-20s\t %-20s" % ("----------", "----------", "----------", "----------"))
		for row in cursor:
			print("%-40s\t %-20s\t %-20s\t %-20s" % (row[0], row[1], row[2], row[3]))
	elif user_choice == 0:
		print("Exiting...")
	else:
		print("Error: Invalid choice")

def change_record_menu():
	print("\t--- Change Records ---")
	print("Please select a record to change.")
	print("---------------------------------")
	print("")
	print("(Option) Query")
	print("--------------")
	print("(1) Insert a new musician")
	print("(2) Delete an existing song")
	print("(3) Update the address of a musician")
	# print("(9) Main Menu")
	print("(0) Exit")
	print("")

def change_record(user_choice):
	cursor = connection.cursor()

	if user_choice == 1:
		mid = int(raw_input("Enter musician_id: "))	# Could change raw_input to input sans int casting
		ssn = raw_input("Enter SSN: ")
		f_name = raw_input("Enter first name: ")
		l_name = raw_input("Enter last name: ")
		phone_num = raw_input("Enter phone number: ")
		address = raw_input("Enter address: ")
		cursor.execute("INSERT INTO `music_rec_info_sys`.`Household`(`phone_number`, `address`) VALUES ('%s', '%s');" % (phone_num, address))
		cursor.execute("INSERT INTO `music_rec_info_sys`.`Musician`(`musician_id`, `SSN`, `first_name`, `last_name`, `phone_number`) VALUES ('%d', '%s', '%s', '%s', '%s');" % (mid, ssn, f_name, l_name, phone_num))
		connection.commit()
		print("")
		print("Musician added to database")
	elif user_choice == 2:
		aid = input("Enter album_id: ")
		tid = input("Enter track number: ")
		cursor.execute("DELETE FROM `music_rec_info_sys`.`Songs` WHERE album_id = %d AND track_number = %d;" % (aid, tid))
		connection.commit()
		print("")
		print("Song deleted from database")
	elif user_choice == 3:
		mid = input("Enter musician_id: ")
		address = raw_input("Enter new address: ")
		cursor.execute("SELECT m.phone_number FROM music_rec_info_sys.Musician m WHERE musician_id = %d;" % mid)
		row = cursor.fetchone()
		cursor.execute("UPDATE `music_rec_info_sys`.`Household` SET `address`='%s' WHERE `phone_number`='%s';" % (address, row[0]))
		connection.commit()
		print("")
		print("Address updated for musician")
	elif user_choice == 0:
		print("Exiting...")
	else:
		print("Error: Invalid option")

### Main ###

welcome_message()
user_choice = 1

while user_choice != 0:
	main_menu()
	user_choice = input("Enter category: ")
	print("")

	if user_choice == 1:
		view_all_records_menu()
		user_choice = input("Enter table: ")
		view_record(user_choice)
		print("")
	elif user_choice == 2:
		view_query_menu()
		user_choice = input("Enter query: ")
		view_query(user_choice)
		print("")
	elif user_choice == 3:
		change_record_menu()
		user_choice = input("Enter option: ")
		change_record(user_choice)
		print("")
	elif user_choice == 0:
		break;
	else:
		print("Error: Invalid category choice")
		print("")

connection.close()


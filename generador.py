from __future__ import print_function
import sys
import random
import itertools
import math
import re

def generate_books(number_of_books):
	file = open("MOCK_DATA.csv", "r")
	lines = file.readlines()
	books = []
	for i in range(0, number_of_books):
		line = random.randint(0, 999)
		books.append(lines[line][:-1])
	return books

def generate_random_sagas(books):
	sagas = []
	for idx, book in enumerate(books):
		saga_chance = random.randint(1,100)
		if saga_chance <= 15:	#change of being a saga could be given by the user
			saga_size = random.randint(2, 7)	#could be replaced with parameters given by the user
			aux = []
			for i in range(1, saga_size+1):
				aux.append(book + "_" + str(i))
			sagas.append(aux)
			books.pop(idx)

	return books + list(itertools.chain(*sagas)), sagas

def print_problem(books, sagas):
	f = open('problem_test.pddl', 'w')
	f.truncate()	#erease any existing content in the file

	print ("(define (problem libros)", file=f)
	print ("(:domain libros)", file=f)
	print ("(:objects m1 m2 m3 m4 m5 m6 m6 m7 m8 m9 m10 m11 m12 - Mes", file=f)
	print (" ".join(books) + " - Libro", file=f)
	print (")", file=f)
	print ("(:init", file=f)
	for saga in sagas:
		saga_size = len(saga)
		for i in range(0, saga_size-1):
			print ("(predecesor " + saga[i] + " " + saga[i+1] + ")", file=f)
	print ("(mes_libre m1) (mes_libre m2) (mes_libre m3) (mes_libre m4) (mes_libre m5) (mes_libre m6) (mes_libre m7) (mes_libre m8) (mes_libre m9)", file=f)
	print ("(mes_libre m10) (mes_libre m11) (mes_libre m12)", file=f)

	# Choose some books that has been read by the user
	eligible = random.randint(0, int(round(math.sqrt(len(books)))))
	read_books = set()
	for i in range(0, eligible):
		rand_book = random.randint(0, len(books)-1)
		book = books[rand_book]
		p = re.compile("[a-zA-Z_]*[0-9]+")	#match if the book is part of a saga, if so add the first book of the saga to the set
		match = p.match(book)
		if match is None:
			read_books.add(book)
		else:
			first_of_the_saga = re.sub(r"[0-9]+", "1", book)
			read_books.add(first_of_the_saga)
	for book in read_books:
		print ("(libro_leido " + book + ")", file=f)

	# Choose books that the user wants to read
	books_to_read = set()
	eligible = random.randint(1, 12)	#cual es el limite?
	for i in range(0, eligible):
		rand_book = random.randint(0, len(books)-1)
		book = books[rand_book]
		if not rand_book in read_books:
			books_to_read.add(book)
	for book in books_to_read:
		print ("(libro_a_leer " + book + ")", file=f)

	print ("(anterior m1 m2) (anterior m2 m3) (anterior m3 m4) (anterior m4 m5) (anterior m5 m6)", file=f)
	print ("(anterior m6 m7) (anterior m7 m8) (anterior m8 m9) (anterior m9 m10) (anterior m10 m11) (anterior m11 m12)", file=f)
	print (")", file=f)
	print ("(:goal", file=f)
	print ("(forall (?l - Libro) (imply (libro_a_leer ?l) (and", file=f)
	print ("(libro_asignado ?l)", file=f)
	print ("(forall (?pred - Libro) (imply (predecesor ?pred ?l) (libro_asignado ?l)))", file=f)
	print (")", file=f)
	print ("))", file=f)
	print (")", file=f)
	print (")", file=f)

if len(sys.argv) < 2:
	print ("Error: no arguments")
	print ("Usage: please enter a number of books greater or equal than 20")
	exit(-1)

try:
	numberBooks = int(sys.argv[1])
except ValueError:
	print ("Error: not a number")
	print ("Usage: please enter a number of books greater or equal than 20")
	exit(-1)

if numberBooks < 20:
	print ("Error: invalid number")
	print ("Usage: please enter a number of books greater or equal than 20")
	exit(-1)

books = generate_books(numberBooks)
books, sagas = generate_random_sagas(books)
print_problem(books, sagas)
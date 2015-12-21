from __future__ import print_function
import sys
import random
import itertools
import math
import re
import ConfigParser as cp

def generate_books(number_of_books):
	file = open("MOCK_DATA.csv", "r")
	lines = file.readlines()
	books = []
	random_unique_ints = random.sample(range(1000), number_of_books)
	for line in random_unique_ints:
		books.append(lines[line][:-1])
	return books

def generate_random_sagas(books):
	sagas = []
	for idx, book in enumerate(books):
		saga_chance = random.randint(1,100)
		if saga_chance <= CHANCE_SAGA:
			saga_size = random.randint(SAGA_MIN_BOOKS, SAGA_MAX_BOOKS)
			aux = []
			for i in range(1, saga_size+1):
				aux.append(book + "_" + str(i))
			sagas.append(aux)
			books.pop(idx)

	return books + list(itertools.chain(*sagas)), sagas

def generare_random_parallels(books):
	par = []
	max_par = SAGA_MAX_BOOKS
	random_num_saga = random.randrange(1, max_par+1, 2)
	random_unique_ints = random.sample(range(len(books)), random_num_saga)
	for i,j in zip(random_unique_ints[0::2], random_unique_ints[1::2]):
		par.append((books[i], books[j]))
	return par


def print_problem(books, sagas, pars):
	f = open(OUTPUT_FILE, 'w')
	f.truncate()	#erease any existing content in the file

	print ("(define (problem libros)", file=f)
	print ("(:domain libros)", file=f)
	print ("(:objects m1 m2 m3 m4 m5 m6 m6 m7 m8 m9 m10 m11 m12 - Mes", file=f)
	print (" ".join(books) + " - Libro", file=f)
	print (")", file=f)
	print ("(:init", file=f)
	for (x, y) in pars:
		print ("(paralelo " + x + " " + y + ")", file=f)
	for saga in sagas:
		saga_size = len(saga)
		for i in range(0, saga_size-1):
			print ("(predecesor " + saga[i] + " " + saga[i+1] + ")", file=f)

	# Choose some books that has been read by the user
	eligible = random.randint(0, len(books)-1)
	read_books = set()
	for i in range(0, eligible):
		rand_book = random.randint(0, len(books)-1)
		book = books[rand_book]
		p = re.compile("[a-zA-Z_]*[0-9]+")	#match if the book is part of a saga, if so add the last read book of the saga to the set
		match = p.match(book)
		if match is None:
			read_books.add(book)
		else:
			k = 1
			book_of_the_saga = re.sub(r"[0-9]+", str(k), book)
			while book_of_the_saga in read_books:
				k+=1
				book_of_the_saga = re.sub(r"[0-9]+", str(k), book)
			if book_of_the_saga in sagas:
				read_books.add(book_of_the_saga)
	for book in read_books:
		print ("(libro_leido " + book + ")", file=f)

	# Choose books that the user wants to read
	books_to_read = set()
	eligible = random.randint(1, len(books)-eligible)
	for i in range(0, eligible):
		rand_book = random.randint(0, len(books)-1)
		book = books[rand_book]
		if not book in read_books:
			books_to_read.add(book)
	for book in books_to_read:
		print ("(libro_a_leer " + book + ")", file=f)

	print ("(anterior m1 m2) (anterior m1 m3) (anterior m1 m4) (anterior m1 m5) (anterior m1 m6) (anterior m1 m7)", file=f)
	print ("(anterior m1 m8) (anterior m1 m9) (anterior m1 m10) (anterior m1 m11) (anterior m1 m12)", file=f)
	print ("(anterior m2 m3) (anterior m2 m4) (anterior m2 m5) (anterior m2 m6) (anterior m2 m7) (anterior m2 m8)", file=f)
	print ("(anterior m2 m9) (anterior m2 m10) (anterior m2 m11) (anterior m2 m12)", file=f)
	print ("(anterior m3 m4) (anterior m3 m5) (anterior m3 m6) (anterior m3 m7) (anterior m3 m8) (anterior m3 m9)", file=f)
	print ("(anterior m3 m10) (anterior m3 m11) (anterior m3 m12)", file=f)
	print ("(anterior m4 m5) (anterior m4 m6) (anterior m4 m7) (anterior m4 m8) (anterior m4 m9) (anterior m4 m10)", file=f)
	print ("(anterior m4 m11) (anterior m4 m12) (anterior m5 m6) (anterior m5 m7) (anterior m5 m8) (anterior m5 m9) (anterior m5 m10) (anterior m5 m11)", file=f)
	print ("(anterior m5 m12) (anterior m6 m7) (anterior m6 m8) (anterior m6 m9) (anterior m6 m10) (anterior m6 m11) (anterior m6 m12)", file=f)
	print ("(anterior m7 m8) (anterior m7 m9) (anterior m7 m10) (anterior m7 m11) (anterior m7 m12) (anterior m8 m9) (anterior m8 m10) (anterior m8 m11) (anterior m8 m12)", file=f)
	print ("(anterior m9 m10) (anterior m9 m11) (anterior m9 m12) (anterior m10 m11) (anterior m10 m12) (anterior m11 m12)", file=f)
	print (")", file=f)
	print ("(:goal (forall (?l - Libro) (imply (libro_a_leer ?l) (libro_asignado ?l)))))", file=f)

cfg = cp.ConfigParser()
cfg.read("config.ini")

NUM_DIF_BOOKS = int(cfg.get("APP", "num_dif_books"))
CHANCE_SAGA = int(cfg.get("APP", "chance_saga"))
SAGA_MIN_BOOKS = int(cfg.get("APP", "saga_min_books"))
SAGA_MAX_BOOKS = int(cfg.get("APP", "saga_max_books"))
OUTPUT_FILE = cfg.get("APP", "output_file")

books = generate_books(NUM_DIF_BOOKS)
books, sagas = generate_random_sagas(books)
pars = generare_random_parallels(books)
print_problem(books, sagas, pars)
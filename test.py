"""
Introduction to python programing:
    Abuti MArtin.

how to define and inintialise variables in .
    python automatically determines the type of variable itself,
     so you don`t need to add type. here is example
"""

# string denoted as str
# NOTE : string is any plain text enclosed within a quotes -> 👉 " "
mystring = "Hello world!"

# integer denoted as int
myinterger = 567

# float denoted as float
myfloat = 78.99

# boolean denoted as bool
mybool = True
mybool = False

# how to print anything

print(mystring)
print(myinterger)
print(myfloat)
print(mybool)

# how to add numbers
mysum = 56 + 90
print(mysum)
mysubtraction = 89 - 78
print(mysubtraction)

mymultiplication = 90 * 7
print(mymultiplication)

mydivition = 78 / 3
print(mydivition)

# NOTE: in python we don`t end lines with a semicolon (;)

# how to ask user to enter something

myage = input("Enter your age: ")
print(myage)
"""
NOTE: whenever you enter a text from the console or from the program like @myage
its always a string meaning even if its a number like 56, its a string.
meaning 56 is not same as "56", one is an integer another a string,
a string is always enclosed in a double or single quotes
"""

# a program to ask user a name and age and print them
name = input("Enter your name: ")
age = input("Enter your age: ")

print("Your name is " + name)
# NOTE : whenever I add two or more strings like mystring1 + mystring2
#       the output is a combination of both strings
#       example: "Hello" + "World"
#       output will be "Hello World", this is called string concatenation, meaning joining two strings together

# How to create a for loop in python
# lets print numbers between 0 and 20

for i in range(0, 20):
    print(i)


# Python is the easiest of all



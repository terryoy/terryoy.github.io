# Use Ctypes to Wrap C Libraries in Python

- date: 2014-03-23 7:57
- tags: python, linux
- category: guides

------------------------------

In Linux, many libraries are provided in C dll with headers. It is not easy to try with the features if you're a Python programmer, unless you know how to work with C library i Python.

There is a tool to do it, which is _**ctypes**_. You can operate on data types, structs, pointers and functions with it. Now here is a brief guide on how to do it. [Here](http://stackoverflow.com/questions/1942298/wrapping-a-c-library-in-python-c-cython-or-ctypes) is also a comparison of ctypes with other solutions.

### 1. Loading The Library

```python

>>> import ctypes
>>> libc = ctypes.CDLL('libc.so.6')
>>> libc.rand()
1804289383
>>> libc.atoi("12345")
12345

>>> from ctypes.util import find_library # if you need to find the library name
>>> find_library('c')
'libc.so.6'

```

The "ctypes.CDLL()" method will return a class that wraps a Standard C library. Alternatively, there is a "ctypes.WinDLL()" method that wraps a Windows stdcall library.

Ctypes assumes that all methods accept "int" or "char*" as parameters and return "int", in other cases it doesn't work properly. So we'll need to define some attributes for the functions to fix that.

```python

>>> libc.atof("12345.123")
531599
>>> libc.atof.restype=ctypes.c_double
>>> libc.atof("12345.123")
12345.123

```

So every function in the library you can have three attributes to handle that: 

*	**_func_.argtypes** = [ ] 		- a sequence of arguments 
*	**_func_.restype** = xxx		- the type of return value 
*	**_func_.errcheck**	= method(result, func, args) 		- a method that manipulates the _result_(return value) of the executed _func_, and also passed with the original _args_ of this execution. 
	
[Here](http://docs.python.org/2/library/ctypes.html#fundamental-data-types) is a list of fundamental data types that you could use in _argtypes_ and _restype_.


### 2. Structures and Pointers

Since we'll need to define the parameters of the C functions, we need to have a way to work with structure and pointers.

With Ctypes, we can define a structure class by deriving from _ctype.Structure_.

```python

# in C we have this structure:
#
# struct Point {
#     double x, y;
# }
#

# in Python we create this class to represent a structure
class Point(ctypes.Structure):
	_fields_ = [('x', ctypes.c_double),
		('y', ctypes.c_double)];

```
If you want to define an array with ctypes, you can simply use the mutiply method:

```python

>>> int_arr = ctypes.c_int*4
>>> int_arr
<class '__main__.c_long_Array_4'>

```

We could use _ctypes.POINTER() to define the pointer type of ctype types(fundamental types and structures).

```python

>>> type_int_p = ctypes.POINTER(ctypes.c_int) # type of a pointer
>>> type_int_p
<class '__main__.LP_c_long'>
>>> type_int_pp = ctypes.POINTER(int_p) # type of a pointer of the integer pointer
>>> type_int_pp
<class '__main__.LP_LP_c_long'>
>>> type_point_p = ctypes.POINTER(Point) # type of a pointer of the structure Point above
>>> type_point_p
<class '__main__.LP_Point'>

```


### 3. Initialize Variables and Pass Arguments to C

The ctypes data types all have a kind of construction method to initialize variables with values. The instance will be a ctype object with the respective value as defined in C.

```python

>>> ival = ctypes.c_int(100)	# integer value
>>> ival
c_long(100)
>>> ival.value 		# you can convert it's value to a python value by the "value" attribute
100

>>> dval = ctypes.c_double(200.25)	# double value
>>> dval
c_double(200.25)
>>> dval.value
200.25

>>> sval = ctypes.c_char_p("Hello, world!") 	# string value
>>> sval 	# you can see the value is representing a pointer address instead of string
c_char_p(3071487276)
>>> sval.value
'Hello, world!'
>>> ret = libc.printf("%s", sval) # but it can be printed as string with "printf" in C
Hello, world!
>>> ret		# (the return value of "printf" is the printed string length)
13

>>> structval = Point(y=10)		# the Point structure defined above, you can also initialize like "Point(0, 10)"
>>> structval
<__main__.Point object at 0xb74466a4>
>>> (structval.x, structval.y)
(0, 10)

```

When we pass objects to functions, we can pass by _pointer_. In this case we'll have two companion methods _byref()_ and _pointer()_ that works with pointers. Also, for a pointer object you can access it's value by the _contents_ attribute.
The _byref()_ method create a parameter object of pointer, which you can only use in functions(notice the "cparam" object), while the _pointer()_ method returns a pointer object which you can manipulate later.

```python

>>> intc = ctypes.c_int(100)
>>> ctypes.byref(intc)		# the byref() returns a parameter object that only can be used as a foreign function's parameter(notice a "cparam" object). 
<cparam 'P' (0xb7124a70)>
>>> intp = ctypes.pointer(intc)		# the pointer() returns a pointer object that you can further work with it
>>> intp
<__main__.LP_c_long object at 0xb713392c>
>>> intp.contents	# access the data to which the pointer points
c_long(100)
>>> intp.contents.value
100

```

### 4. Interact with C Libraries

(to be finished)



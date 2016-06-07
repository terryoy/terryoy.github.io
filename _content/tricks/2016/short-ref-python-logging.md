# A Short Reference of Python Logging

- date: 2016-05-26 19:55
- tags: python
- category: tricks

-----------------------

I have for many times use the logging function, but never understand it completely. So I go through the document and make some notes, hoping it will help me use it more quickly in the future. 


### 1. Basic Config

If you want to use a programmable method other than a configuration file, the basicConfig() method is the general initializing method.


The most basic form is default log, which you don't need basicConfig(). It is using console output with WARNING level.

```python

>>> import logging
>>> logging.debug('hello') # no output
>>> logging.warn('world')
world

```

The basic config contains a list of below elements:

*	filename	- Using a *FileHandler* to output the log
*	filemode	- file open mode('r', 'w', 'a'), mainly used to choose append or write a new log file
*	format		- A string for specifying the log output template, If you want to lookup a list of supported keywords, look for section 'LogRecord attributes' in the python official document
*	datefmt		- A specified date/time format.
*	level		- set the *root* loglevel for the logger
*	stream		- Specify a stream for the StreamHandler, for example, a buffer output stream or stdout. It will be ignored if "filename" is present.

The logger can be initialized only once when basicConfig() is called. Then 

```python

>>> import logging
>>> logging.basicConfig(filename='program.log', 
		filemode='a',
		format="%(asctime)-15s %(levelname)s [%(module)s] %(message)s",
		datefmt="%Y-%m-%d %H:%M:%S.%f",
		level=logging.DEBUG)

```


### 2. Configuration Object and the Modular Approach

When choosing the Modular Approach of logging, you need to deal with 4 elements:

*	loggers		- the interface that application modules used to log things
*	handlers	- send the log records (that loggers created) to the appropriate destinations
*	filters		- provide a finer grained facility for determining which log records should be output
*	formatters	- specify the layout of the log records in the final output


#### 2.1 Logger hierarchy

The loggers used by all the modules are formed in a conceptual hierarchy by the naming with a separator('.'). For example: 'abc.text', is the descendant of logger 'abc', while 'abc' can be the parent of 'abc.text', 'abc.pdf', 'abc.image', etc. A good convention is to use loggers in a module sense, using in each ```.py``` as below:

```python
logger = logging.getLogger(__name__)
```

The root of all loggers is called the "root" logger, which prints the logger name as "ROOT" in output.
`

#### 2.2 Useful handlers

There are some useful handlers in the section of python *Logging Howto* document. Some of them are listed as here:

*	StreamHandler	- to stream object (default stdin?)
*	FileHandler		- to a disk file
*	**RotatingFileHandler**			- from *BaseRotatingHandler*, send logs to files, rotating log file with a maximum file size.
*	**TimedRotatingFileHandler**	- from *BaseRotatingHandler*, send logs to files, rotating log file at a certain timed intervals.
*	SocketHandler/DatagramHandler	- send log messages to TCP/IP and UDP sockets
*	SMTPHandler		- Send to a designated email address
*	NullHandler		- Do nothing, it's used in development that supports logging with this mock

This shows the variety of logging output scenarios, which you could look them up in the python doc.

#### 2.3 The propagation of loggers

Look at the flow of logging in the below diagram from [python's tutorial](https://docs.python.org/2/howto/logging.html#logging-advanced-tutorial),

![logging flow](https://docs.python.org/2/_images/logging_flow.png)


When a log record is send to the logger in the module, it will first check if its own filter(the filter of a logger) reject it, then pass to its handler; if propagation is set to true(by default), it will pass the log record to it's parent too, so the log record will bubble up till the root logger, and each logger will judge by their handler and filter to decide whether to output the log record. So we often setup a top level logger, and then configure a child logger only if needed.


#### 2.4 Configuring Logging

The most usual approaches are using ```fileConfig()``` and ```dictConfig()```. With fileConfig() you can use a **.conf** file to load the settings, and with dictConfig() you can use even wider range of persistence choices, such as JSON, python file, yaml, etc.





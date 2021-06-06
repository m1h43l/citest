# STOMP Client for RPG

## About
From the former STOMP web site (at codehaus.org):

> The STOMP project is the Streaming Text Orientated Messaging Protocol site (or
> the Protocol Briefly Known as TTMP and Represented by the symbol :ttmp).
> STOMP provides an interoperable wire format so that any of the available Stomp
> Clients can communicate with any STOMP Message Broker to provide easy and 
> widespread messaging interop among languages, platforms and brokers.

The RPG client makes it possible to speak to messaging systems like ActiveMQ, 
RabbitMQ, Apollo, Artemis ... **natively**.


## Protocol

The protocol is listed at [github](https://stomp.github.io/stomp-specification-1.2.html).

> STOMP is a frame based protocol, with frames modelled on HTTP. A frame consists
> of a command, a set of optional headers and an optional body. STOMP is text 
> based but also allows for the transmission of binary messages.

A frame contains data for the Message Queueing Server (command and headers) but 
also the data for the receiver of the message (body).

## Client API

The client API is divided into many smaller modules:

- STOMP - main client module
- STOMPCMD - executing Stomp commands
- STOMPEXT - proxy/interface for RPG Stomp extension modules
- STOMPFRAME - building and working with frames
- STOMPINIT - initialization starter
- STOMPLOG - logging module
- STOMPPARSE - buiding a frame from its serialized state
- STOMPUTIL - utility procedures

Using this STOMP client starts with creating a client instance with the 
`stomp_create` procedure which returns a handle which is used on every later call.

    client = stomp_create('localhost' : 61613);

The socket to the client must be explicitly opened for communicating with the 
server.

    stomp_open(client);

The client not only needs a connection to the server on a network level but also 
on an application level. The server expects a CONNECT STOMP frame.

    stomp_command_connect(client);

After successfully connecting to the server it accepts messages from this client.

    stomp_command_send(client : '/topic/retailprice' : '{ "id":5500 , "oldprice":1.23 , "newprice":1.59 }');

If no more messages are sent or received the client needs to disconnect from the 
server.

    stomp_command_disconnect(client);

The allocated resources must be freed after finishing the communication with the 
server.

    stomp_finalize(client);


## Logging

For debugging purposes logging can be enabled by setting the environment variable
`STOMP_DEBUG` to '1'.

    ADDENVVAR ENVVAR(STOMP_DEBUG) VALUE(1)

Note: Enableing logging results in many job log messages and should only be used
      for debugging.


## Extensions

Some message queuing systems implement the STOMP protocol differently or extending 
the function set by adding new headers to the frames. There is an extension 
mechanism for tweaking the STOMP frames for these systems (STOMPEXT). The 
extension module must implement the `stompext` interface. For each call on a 
procedure in the *COMMAND* module the corresponding procedure in the extension 
module will be called.

For telling the client which extension to use the procedure *stomp_setExtension* 
must be called.

    stomp_setExtension(client : stomp_ext_activemq_create());


## Requirements

This software package has the following dependencies:

- [Message](https://bitbucket.org/m1hael/message)
- [Linked List](https://bitbucket.org/m1hael/llist)
- [libtree](https://bitbucket.org/m1hael/libtree)


## Installation

For standard installation the tool `make` is used. The `Makefile` contains all
instructions for compilation.

    make

will compile the module and bind the service program. You can specify the
target library as following

    make BIN_LIB=MYLIB compile

As this project depends on several other projects it needs the copybooks of 
these projects. The Makefile assumes that the copybooks are placed in the 
directory `/usr/local/include`. You can specify another directory like this

    make INCDIR=/home/mihael/include 


## Documentation

The API documentation is be available at [ILEDocs](http://iledocs.rpgnextgen.com) 
hosted at rpgnextgen.com.

## Links

- [ActiveMQ](https://activemq.apache.org)
- [STOMP](https://stomp.github.io/)

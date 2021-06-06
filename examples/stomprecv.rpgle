**FREE


///
// STOMP : Receive Messages Example
//
// This example registers at the local message queueing system to the queue "price"
// and displays the content of each message. The client will end when an ERROR message
// has been received.
// 
// For displaying debug data add the environment variable STOMP_DEBUG with the value 1.
// ADDENVVAR 'STOMP_DEBUG' '1'
//
// @author Mihael Schmidt
// @date 06.06.2021
// @project STOMP
///


/include 'stomp/stomp.rpginc'


main();
*inlr = *on;


dcl-proc main;
  dcl-s client pointer;
  dcl-s frame pointer;
  dcl-ds content likeds(stomp_util_buffer_t);
  dcl-s message char(50);
  
  // create a STOMP client instance
  client = stomp_create('127.0.0.1' : 61613);
  stomp_setClientId(client : 'mihael');

  // open a socket connection to the message queueing system
  stomp_open(client);
  // connect to the message queueing system (login)
  stomp_command_connect(client : 'mq_username' : 'mq_password');
  // subscribe to the queue "price"
  stomp_command_subscribe(client : '/queue/price');

  // start receiving data
  frame = stomp_receiveFrame(client);
  dow (frame <> *null);
    if (stomp_frame_getCommand(frame) = 'ERROR');
      dsply 'An error occured';
      leave;
    endif;
    
    // display message content
    content = stomp_frame_getBody(frame);
    message = %str(content.data : content.length);
    dsply message;
    stomp_frame_finalize(frame);

    // receive next frame
    frame = stomp_receiveFrame(client);
  enddo;

  // disconnect on the application level
  stomp_command_disconnect(client);
  // close socket
  stomp_close(client);

  on-exit;
    // free resources
    stomp_finalize(client);
end-proc;

**FREE

///
// STOMP : Send Message Example
//
// This example connects to the local message queueing system and sends a message to
// the queue "price".
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

  // create a STOMP client instance
  client = stomp_create('127.0.0.1' : 61613);
  stomp_setClientId(client : 'mihael');

  // open a socket connection to the message queueing system
  stomp_open(client);
  // connect to the message queueing system (login)
  stomp_command_connect(client : 'mq_username' : 'mq_password');

  // send data to queue "price" with content type "application/json" utf-8 encoded
  stomp_command_send(client : '/queue/price' : '{ "id" : 358 , "price" : 1.23 }' : *omit : STOMP_MIME_JSON);

  // disconnect on the application level
  stomp_command_disconnect(client);
  // close socket
  stomp_close(client);

  on-exit;
    // free resources
    stomp_finalize(client);
end-proc;

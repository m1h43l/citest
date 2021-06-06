## STOMP Client Examples

These examples show how to use the STOMP service program.


### Compile

The examples are coded as RPG modules. You need to use the Create RPG Module command
followed by the Create Program command. The code expects the copybooks to be in a 
directory named "stomp". The compile command may look like this:

    CRTRPGMOD STOMPSEND 
        SRCSTMF('/home/mihael/src/stomp/examples/stompsend.rpgle')
        INCDIR('/home/mihael/include')
    
    CRTPGM STOMPSEND BNDSRVPGM(STOMP)

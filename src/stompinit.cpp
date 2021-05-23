extern "C" {
  int stomp_init(void);
  int stomp_command_init(void);
  int stomp_frame_init(void);
  int stomp_log_init(void);
  int stomp_parser_init(void);
  int stomp_mime_init(void);
}

static int dummyInitVar0 = stomp_log_init(); 
static int dummyInitVar1 = stomp_init();
static int dummyInitVar2 = stomp_command_init();
static int dummyInitVar3 = stomp_frame_init();
static int dummyInitVar4 = stomp_parser_init();
static int dummyInitVar5 = stomp_mime_init();
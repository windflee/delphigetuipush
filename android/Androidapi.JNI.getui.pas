//====================================================
//
//  转换来自JarOrClass2Pas(原JavaClassToDelphiUnit)
//  原始作者：ying32
//  QQ: 1444386932、396506155
//  Email：yuanfen3287@vip.qq.com
//
//  修改 By：Flying Wang & 爱吃猪头肉
//  请不要移除以上的任何信息。
//  请不要将本版本发到城通网盘，否则死全家。
//
//  Email：1765535979@qq.com
//  QQ Group：165232328
//
//  生成时间：2020-08-26 14:49:53
//  工具版本：1.0.2018.2.26
//
//====================================================
unit Androidapi.JNI.getui;

interface

uses
  Androidapi.JNIBridge, 
  Androidapi.JNI.JavaTypes, 
  Androidapi.JNI.GraphicsContentViewText;


type

// ===== Forward declarations =====

  JGETUIHelper_1 = interface; //com.yuesehetang.ymkh.getui.GETUIHelper$1
  JGETUIHelper = interface; //com.yuesehetang.ymkh.getui.GETUIHelper
//  JGETUIIntentService = interface; //com.yuesehetang.ymkh.getui.GETUIIntentService
  JGETUIListener = interface; //com.yuesehetang.ymkh.getui.GETUIListener
//  JGETUIPushService = interface; //com.yuesehetang.ymkh.getui.GETUIPushService
  JGTMsgData = interface; //com.yuesehetang.ymkh.getui.GTMsgData

// ===== Forward SuperClasses declarations =====


// ===== Interface declarations =====

  JGETUIHelper_1Class = interface(JObjectClass)
  ['{623FF8B9-0C20-4DAB-9BF9-752FA4122B8A}']
    { static Property Methods }

    { static Methods }

    { static Property }
  end;

  [JavaSignature('com/yuesehetang/ymkh/getui/GETUIHelper$1')]
  JGETUIHelper_1 = interface(JObject)
  ['{7357E6E5-966B-4BF5-8DAE-F8764DDCD0D0}']
    { Property Methods }

    { methods }
    procedure log(s: JString); cdecl; //(Ljava/lang/String;)V

    { Property }
  end;

  TJGETUIHelper_1 = class(TJavaGenericImport<JGETUIHelper_1Class, JGETUIHelper_1>) end;

  JGETUIHelperClass = interface(JObjectClass)
  ['{DC9192F3-111A-4BF5-BBA9-EC0C69D8D9B3}']
    { static Property Methods }

    { static Methods }
    {class} function init: JGETUIHelper; cdecl; //()V
    {class} procedure doInit(context: JContext); cdecl; //(Landroid/content/Context;)V
    {class} procedure setServiceListener(Listener: JGETUIListener); cdecl; //(Lcom/yuesehetang/ymkh/getui/GETUIListener;)V

    { static Property }
  end;

  [JavaSignature('com/yuesehetang/ymkh/getui/GETUIHelper')]
  JGETUIHelper = interface(JObject)
  ['{6BBE22A1-0799-4DA8-86EC-952C77297D6C}']
    { Property Methods }

    { methods }

    { Property }
  end;

  TJGETUIHelper = class(TJavaGenericImport<JGETUIHelperClass, JGETUIHelper>) end;

  JGETUIListenerClass = interface(JObjectClass)
  ['{32DC44A9-9D3E-4ED3-9C95-76900CBDA8C6}']
    { static Property Methods }

    { static Methods }

    { static Property }
  end;

  [JavaSignature('com/yuesehetang/ymkh/getui/GETUIListener')]
  JGETUIListener = interface(IJavaInstance)
  ['{D6AC1C98-56C9-4B39-8480-9D52661B2EEF}']
    { Property Methods }

    { methods }
    procedure onReceiveServicePid(P1: Integer); cdecl; //(I)V
    procedure onReceiveMessageData(P1: JGTMsgData); cdecl; //(Lcom/yuesehetang/ymkh/getui/GTMsgData;)V
    procedure onReceiveClientId(P1: JString); cdecl; //(Ljava/lang/String;)V
    procedure onReceiveOnlineState(P1: Boolean); cdecl; //(Z)V
    procedure onReceiveCommandResult(P1: JGTMsgData); cdecl; //(Lcom/yuesehetang/ymkh/getui/GTMsgData;)V
    procedure onNotificationMessageArrived(P1: JGTMsgData); cdecl; //(Lcom/yuesehetang/ymkh/getui/GTMsgData;)V
    procedure onNotificationMessageClicked(P1: JGTMsgData); cdecl; //(Lcom/yuesehetang/ymkh/getui/GTMsgData;)V

    { Property }
  end;

  TJGETUIListener = class(TJavaGenericImport<JGETUIListenerClass, JGETUIListener>) end;

  JGTMsgDataClass = interface(JObjectClass)
  ['{5565DC8B-BF37-47F3-8A3A-EBA97DBF89E8}']
    { static Property Methods }

    { static Methods }
    {class} function init: JGTMsgData; cdecl; //()V

    { static Property }
  end;

  [JavaSignature('com/yuesehetang/ymkh/getui/GTMsgData')]
  JGTMsgData = interface(JObject)
  ['{497654D4-9BBC-46F9-BA83-CC0E294FD8DF}']
    { Property Methods }

    { methods }
    function getAppid: JString; cdecl; //()Ljava/lang/String;
    procedure setAppid(paramString: JString); cdecl; //(Ljava/lang/String;)V
    function getClientId: JString; cdecl; //()Ljava/lang/String;
    procedure setClientId(paramString: JString); cdecl; //(Ljava/lang/String;)V
    function getMessageId: JString; cdecl; //()Ljava/lang/String;
    procedure setMessageId(paramString: JString); cdecl; //(Ljava/lang/String;)V
    function getTaskId: JString; cdecl; //()Ljava/lang/String;
    procedure setTaskId(paramString: JString); cdecl; //(Ljava/lang/String;)V
    function getTitle: JString; cdecl; //()Ljava/lang/String;
    procedure setTitle(paramString: JString); cdecl; //(Ljava/lang/String;)V
    function getContent: JString; cdecl; //()Ljava/lang/String;
    procedure setContent(paramString: JString); cdecl; //(Ljava/lang/String;)V
    function getPayload: JString; cdecl; //()Ljava/lang/String;
    procedure setPayload(paramString: JString); cdecl; //(Ljava/lang/String;)V
    function getAction: Integer; cdecl; //()I
    procedure setAction(action: Integer); cdecl; //(I)V

    { Property }
  end;

  TJGTMsgData = class(TJavaGenericImport<JGTMsgDataClass, JGTMsgData>) end;

implementation

end.

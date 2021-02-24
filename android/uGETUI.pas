unit uGETUI;

interface

uses
  Classes,
  FMX.Types,
  FMX.Controls,
  FMX.Helpers.Android,
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.getui;

type
  TGTMsgRec = record
    clientid: string;
    appid: string;
    msgid: string;
    taskid: string;
    title: string;
    content: string;
    payload: string;
    action: integer;
  end;

  TOnGTReceiveServicePid = procedure (pid: Integer) of object;
  TOnGTReceiveMessageData = procedure (msg: TGTMsgRec) of object;
  TOnGTReceiveClientId = procedure (clientid: string) of object;
  TOnGTReceiveOnlineState = procedure (online: Boolean) of object;
  TOnGTReceiveCommandResult = procedure (msg: TGTMsgRec) of object;
  TOnGTNotificationMessageArrived = procedure (msg: TGTMsgRec) of object;
  TOnGTNotificationMessageClicked = procedure (msg: TGTMsgRec) of object;

  TJGETUIListenerImpl = class(TJavaLocal, JGETUIListener)
  public
    procedure onReceiveServicePid(P1: Integer); cdecl;
    procedure onReceiveMessageData(P1: JGTMsgData); cdecl;
    procedure onReceiveClientId(P1: JString); cdecl;
    procedure onReceiveOnlineState(P1: Boolean); cdecl;
    procedure onReceiveCommandResult(P1: JGTMsgData); cdecl;
    procedure onNotificationMessageArrived(P1: JGTMsgData); cdecl;
    procedure onNotificationMessageClicked(P1: JGTMsgData); cdecl;
  public
    FonNotificationMessageArrived: TOnGTNotificationMessageArrived;
    FonNotificationMessageClicked: TOnGTNotificationMessageClicked;
    FonReceiveMessageData: TOnGTReceiveMessageData;
    FonReceiveClientId: TOnGTReceiveClientId;
    FonReceiveServicePid: TOnGTReceiveServicePid;
    FonReceiveOnlineState: TOnGTReceiveOnlineState;
    FonReceiveCommandResult: TOnGTReceiveCommandResult;
  end;

  TGeTuiClient = class(TComponent)
  private
    FListener: TJGETUIListenerImpl;
    FonNotificationMessageArrived: TOnGTNotificationMessageArrived;
    FonNotificationMessageClicked: TOnGTNotificationMessageClicked;
    FonReceiveMessageData: TOnGTReceiveMessageData;
    FonReceiveClientId: TOnGTReceiveClientId;
    FonReceiveServicePid: TOnGTReceiveServicePid;
    FonReceiveOnlineState: TOnGTReceiveOnlineState;
    FonReceiveCommandResult: TOnGTReceiveCommandResult;
  public
    procedure doInit;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnNotificationMessageArrived: TOnGTNotificationMessageArrived read FonNotificationMessageArrived write FonNotificationMessageArrived;
    property OnNotificationMessageClicked: TOnGTNotificationMessageClicked read FonNotificationMessageClicked write FonNotificationMessageClicked;
    property OnReceiveMessageData: TOnGTReceiveMessageData read FonReceiveMessageData write FonReceiveMessageData;
    property OnReceiveClientId: TOnGTReceiveClientId read FonReceiveClientId write FonReceiveClientId;
    property OonReceiveServicePid: TOnGTReceiveServicePid read FonReceiveServicePid write FonReceiveServicePid;
    property OonReceiveOnlineState: TOnGTReceiveOnlineState read FonReceiveOnlineState write FonReceiveOnlineState;
    property OonReceiveCommandResult: TOnGTReceiveCommandResult read FonReceiveCommandResult write FonReceiveCommandResult;
  end;

implementation

{ TGeTuiClient }



constructor TGeTuiClient.Create(AOwner: TComponent);
begin
  inherited;
  FListener := TJGETUIListenerImpl.Create;
  TJGETUIHelper.JavaClass.setServiceListener(FListener);
end;

destructor TGeTuiClient.Destroy;
begin

  inherited;
end;

procedure TGeTuiClient.doInit;
begin
  if FListener <> nil then
  begin
    Log.d(' gtclient doinit, listener is not null');
  end;

  FListener.FonReceiveClientId := Self.FonReceiveClientId;
  FListener.FonNotificationMessageArrived := Self.FonNotificationMessageArrived;
  FListener.FonNotificationMessageClicked := Self.FonNotificationMessageClicked;
  FListener.FonReceiveMessageData := Self.FonReceiveMessageData;
  FListener.FonReceiveServicePid := Self.FonReceiveServicePid;
  FListener.FonReceiveOnlineState := Self.FonReceiveOnlineState;
  FListener.FonReceiveCommandResult := Self.FonReceiveCommandResult;

  TJGETUIHelper.JavaClass.doInit(TAndroidHelper.Context);
end;

{ TMyJGETUIListener }

procedure TJGETUIListenerImpl.onNotificationMessageArrived(P1: JGTMsgData);
var msg: TGTMsgRec;
begin
  if assigned(FonNotificationMessageArrived) then
  begin
    FillChar(msg, Sizeof(TGTMsgRec), #0);
    msg.clientid := JStringToString(P1.getClientId);
    msg.appid := JStringToString(P1.getAppid);
    msg.msgid := JStringToString(P1.getMessageId);
    msg.taskid := JStringToString(P1.getTaskId);
    msg.title := JStringToString(P1.getTitle);
    msg.content := JStringToString(P1.getContent);
    TThread.Queue(nil,
      procedure
      begin
        FonNotificationMessageArrived(msg);
      end
    );

  end;

end;

procedure TJGETUIListenerImpl.onNotificationMessageClicked(P1: JGTMsgData);
var msg: TGTMsgRec;
begin
  if assigned(FonNotificationMessageClicked) then
  begin
    FillChar(msg, Sizeof(TGTMsgRec), #0);
    msg.clientid := JStringToString(P1.getClientId);
    msg.appid := JStringToString(P1.getAppid);
    msg.msgid := JStringToString(P1.getMessageId);
    msg.taskid := JStringToString(P1.getTaskId);
    msg.title := JStringToString(P1.getTitle);
    msg.content := JStringToString(P1.getContent);
    TThread.Queue(nil,
      procedure
      begin
        FonNotificationMessageClicked(msg);
      end
    );

  end;

end;

procedure TJGETUIListenerImpl.onReceiveClientId(P1: JString);
begin
  if assigned(FOnReceiveClientId) then
  begin
    TThread.Queue(nil,
      procedure
      begin
        FOnReceiveClientId(JStringToString(P1));
      end
    );

  end;
end;

procedure TJGETUIListenerImpl.onReceiveCommandResult(P1: JGTMsgData);
var msg: TGTMsgRec;
begin
  if assigned(FonReceiveCommandResult) then
  begin
    FillChar(msg, Sizeof(TGTMsgRec), #0);
    msg.clientid := JStringToString(P1.getClientId);
    msg.appid := JStringToString(P1.getAppid);
    msg.msgid := JStringToString(P1.getMessageId);
    msg.taskid := JStringToString(P1.getTaskId);
    msg.title := JStringToString(P1.getTitle);
    msg.content := JStringToString(P1.getContent);
    msg.action := P1.getAction;
    TThread.Queue(nil,
      procedure
      begin
        FonReceiveCommandResult(msg);
      end
    );

  end;

end;

procedure TJGETUIListenerImpl.onReceiveMessageData(P1: JGTMsgData);
var msg: TGTMsgRec;
begin
  if assigned(FonReceiveMessageData) then
  begin
    FillChar(msg, Sizeof(TGTMsgRec), #0);
    msg.clientid := JStringToString(P1.getClientId);
    msg.appid := JStringToString(P1.getAppid);
    msg.msgid := JStringToString(P1.getMessageId);
    msg.taskid := JStringToString(P1.getTaskId);
    msg.payload := JStringToString(P1.getPayload);
    TThread.Queue(nil,
      procedure
      begin
        FonReceiveMessageData(msg);
      end
    );

  end;

end;

procedure TJGETUIListenerImpl.onReceiveOnlineState(P1: Boolean);
begin
  if assigned(FonReceiveOnlineState) then
  begin

    TThread.Queue(nil,
      procedure
      begin
        FonReceiveOnlineState(P1);
      end
    );

  end;
end;

procedure TJGETUIListenerImpl.onReceiveServicePid(P1: Integer);
begin
  if assigned(FonReceiveServicePid) then
  begin

    TThread.Queue(nil,
      procedure
      begin
        FonReceiveServicePid(P1);
      end
    );

  end;
end;

end.

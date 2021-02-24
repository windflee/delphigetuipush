unit GeTuiPushAction3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, qjson,
  System.Net.HttpClient, System.Net.HttpClientComponent, System.Hash;

type
  TGeTuiPushAction = class(TComponent)
  private
    FHttpClient: TNetHTTPClient;
  protected
  public
    procedure setHttpClient(httpClient: TNetHTTPClient);
    function auth: Boolean;
    procedure pushall(title,body: string; payload: string = '');
  end; 
  
  
implementation

uses DateUtils, IniFiles;

{ TFileAction }

const
  GTBaseURL = 'https://restapi.getui.com/v2/';
  GTAppID = '';
  GTAppKey = '';
  GTAppSecret = '';
  GTMasterSecret = '';
  
var  
  bGTAuth: Boolean;
  sGTtoken: string;  


function TGeTuiPushAction.auth: Boolean;
var url, ts: string;
    json: TQJson;
    timestamp: Int64;
    ss: TStringStream;
    today: TDateTime;
begin
  if bGTAuth then
  begin
    Result := True;
    Exit;
  end;

  Result:= True;
  
  url := GTBaseURL + GTAppID + '/auth';
  FHttpClient.ContentType := 'application/json;charset=utf-8';
  json := TQJson.Create;
  try

    today := now;
    timestamp := DateTimeToUnix(today, false);
    ts := Formatdatetime('zzz', today);
    json.Add('appkey', GTAppKey, jdtString);
    json.Add('timestamp', timestamp.ToString + ts, jdtString);
    json.Add('sign', THashSHA2.GetHashString(GTAppKey + timestamp.ToString + ts + GTMasterSecret), jdtString);
    ss:= TStringStream.Create(json.AsJson);
    try
      url := FHttpClient.Post(url, ss).ContentAsString();
      json.Clear;
      json.Parse(url);
      if (json.ValueByName('msg', '') = 'success') and (json.IntByName('code', -1) = 0) then
      begin
        sGTtoken := json.ForcePath('data.token').AsString;
        bGTAuth := True;
        Result:= True;
      end;

    finally
      ss.Free;
    end;
  finally
    json.Free;
  end;

end;

procedure TGeTuiPushAction.pushall(title,body: string; payload: string);
var url, request_id: string;
    json, notify: TQJson;
    ss: TStringStream;
begin
  if auth then
  begin
    url := GTBaseURL + GTAppID + '/push/all';

    FHttpClient.ContentType := 'application/json;charset=utf-8';
    FHttpClient.CustomHeaders['token'] := sGTtoken;

    json := TQJson.Create;
    try
      request_id := Formatdatetime('yyyymmddhhmmsszzz', now);
      json.Add('request_id', request_id, jdtString);
      json.Add('audience', 'all', jdtString);
      json.ForcePath('settings.ttl').AsInteger := 3600000;
      notify := TQJson.Create;
      notify.Add('title', title, jdtString);
      notify.Add('body', body, jdtString);
      if payload <> '' then
      begin
        notify.Add('payload', payload, jdtString);
        notify.Add('click_type', 'payload', jdtString);
      end;

      json.ForcePath('push_message').Add('notification', notify);

      ss := TStringStream.Create(json.AsString, TEncoding.UTF8);
      try
        url := FHttpClient.Post(url, ss).ContentAsString();

        json.Clear;
        json.Parse(url);

      finally
        ss.Free;
      end;

    finally
      json.Free;
    end;
  end;


end;

procedure TGeTuiPushAction.setHttpClient(httpClient: TNetHTTPClient);
begin
  FHttpClient := httpClient;
end;

end.


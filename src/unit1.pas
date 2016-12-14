unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, HTTPApp,
  forms,graphics,jpeg;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1aboutAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1getscreenAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
    procedure WriteTime(b:TBitmap);
  public
    { Public declarations }
  end;

var
  WebModule1: TWebModule1;

implementation

{$R *.DFM}

procedure TWebModule1.WriteTime;
var data:string;
    datarect:TRect;
    t,l:integer;
begin
  data:=DateTimeToStr(Now);
  b.canvas.Font.Name:='Impact';
  b.canvas.Font.Size:=10;
  b.Canvas.Brush.Color:=clBlack;
  t:=b.Height-b.canvas.TextHeight(data);
  l:=b.Width-b.canvas.TextWidth(data);
  datarect:=Rect(l,t,b.Width,b.Height);
  b.Canvas.FillRect(datarect);
  b.Canvas.Font.Color:=clWhite;
  b.Canvas.TextRect(datarect, l,t, data);
end;

procedure TWebModule1.WebModule1aboutAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var sl : TStringList;
begin
  Response.ContentType := 'text/html';
  sl := TStringList.Create;
  sl.Add('<HTML><HEAD>');
  sl.Add('<TITLE>Screen capture ISAPI module</TITLE>');
  sl.Add('</HEAD><BODY>');
  sl.Add('<H3>Screen capture ISAPI module</H3>');
  sl.Add('<H4><a href="http://vmasoft.hypermart.net">(c) VMA soft 2000</a></H4>');
  sl.Add('</BODY></HTML>');
  Response.Content := sl.Text;
  sl.Free;
end;

procedure TWebModule1.WebModule1getscreenAction(Sender: TObject;
 Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  b:TBitmap;
  j:TJPEGImage;
  ms:TMemoryStream;
  DeskTopCanvas: TCanvas;
  DeskTopRect: TRect;
  DestRect: TRect;
  DeskTopDC: HDc;
  w,h,compr:integer;
begin
  b:=TBitmap.Create;
  j:=TJPEGImage.Create;
  ms:=TMemoryStream.Create;
  DeskTopCanvas := TCanvas.Create;
  DeskTopRect := Rect(0,0,Screen.Width,Screen.Height);
  try
     w:=StrToInt(Request.QueryFields.Values['width']);
  except
     w:=Screen.Width;
  end;
  try
     h:=StrToInt(Request.QueryFields.Values['height']);
  except
     h:=Screen.Height;
  end;
  if w=0 then w:=Screen.Width;
  if h=0 then h:=Screen.Height;
  try
     compr:=StrToInt(Request.QueryFields.Values['compr']);
  except
     compr:=100;
  end;
  DestRect := Rect(0,0,w,h);
  try
    DeskTopDC := GetWindowDC(GetDesktopWindow);
    DeskTopCanvas.Handle := DeskTopDC;
    b.Width := w;
    b.Height := h;
    b.Canvas.CopyRect(DestRect,DeskTopCanvas,DeskTopRect);
    ReleaseDC(GetDeskTopWindow,DeskTopDC);
    if Request.QueryFields.Values['time']<>'' then WriteTime(b);

    j.Assign(b);
    j.CompressionQuality:=compr;
    j.Compress;
    j.SaveToStream(ms);
    ms.Position:=0;

    Response.ContentType := 'image/jpeg';
    Response.ContentStream:=ms;
    Response.SendResponse;
  finally
    b.free;
    j.free;
    DeskTopCanvas.Free;
  end;
end;

end.

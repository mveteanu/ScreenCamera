object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Name = 'about'
      PathInfo = '/about'
      OnAction = WebModule1aboutAction
    end
    item
      Default = True
      Name = 'getscreen'
      PathInfo = '/getscreen'
      OnAction = WebModule1getscreenAction
    end>
  Left = 270
  Top = 185
  Height = 269
  Width = 430
end

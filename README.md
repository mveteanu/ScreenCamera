ScreenCapture ISAPI module
==========================

Last update: 2001

Install
-------

Copy file screencapture.dll in the appropriate location on your web server. 
For PWS and IIS this folder is usually c:\inetpub\scripts


Usage example
-------------

   1. http://localhost/scripts/screencapture.dll/about
      Display a short message
      Response type is text/html

   2. http://localhost/scripts/screencapture.dll
      http://localhost/scripts/screencapture.dll?compr=90&time=yes
      Display a screen capture of server screen.
      Response type is image/jpeg

      Optionaly you can provide additional parameters via querystring:
         1) width   - width of the image (by default is screen width)
         2) height  - height of the image (by default is screen height)
         3) compres - number between 1-100 to indicate jpeg compression level (by default is 100 - maximum quality)
         4) time    - if you want to print server time over image

   3. For a quick example, please check "default.asp" file.


VMA
  
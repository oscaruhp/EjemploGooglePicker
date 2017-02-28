<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Uploader.aspx.cs" Inherits="PickerGoogleImagenes.Uploader" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>Google Picker</title>
     
     <script src="js/jquery-3.1.1.js"></script>
     <script src="js/bootstrap.min.js" ></script>
     <!-- Google picker -->
      <script type="text/javascript">

          // The Browser API key obtained from the Google Developers Console.
          var developerKey = 'AIzaSyDc7799W-ebNt1BEAIZ-w-Z99fk8Nka2Oc';

          // The Client ID obtained from the Google Developers Console. Replace with your own Client ID.
          var clientId = "43762573361-qia3ectm28on9jfmmfjbnjgukipcs4af.apps.googleusercontent.com"

          // Scope to use to access user's photos.
          var scope = ['https://www.googleapis.com/auth/photos'];

          var pickerApiLoaded = false;
          var oauthToken;

          // Use the API Loader script to load google.picker and gapi.auth.
          function onApiLoad() {
              gapi.load('auth', { 'callback': onAuthApiLoad });
              gapi.load('picker', { 'callback': onPickerApiLoad });
          }

          function onAuthApiLoad() {
              window.gapi.auth.authorize(
                  {
                      'client_id': clientId,
                      'scope': scope,
                      'immediate': false
                  },
                  handleAuthResult);
          }

          function onPickerApiLoad() {
              pickerApiLoaded = true;
              createPicker();
          }

          function handleAuthResult(authResult) {
              if (authResult && !authResult.error) {
                  oauthToken = authResult.access_token;
                  
              }
          }

          // Create and render a Picker object for picking user Photos.
          function createPicker() {
              if (pickerApiLoaded && oauthToken) {

                  var picker = new google.picker.PickerBuilder().
                    addView(google.picker.ViewId.PHOTO_UPLOAD).
                    addView(google.picker.ViewId.PHOTOS).
                    setDeveloperKey(developerKey).
			        setOAuthToken(oauthToken).
                    setDeveloperKey(developerKey).
                    setCallback(pickerCallback).
                    setLocale('es').
                     build();
                  picker.setVisible(true);
              }
          }

          // A simple callback implementation.
          function pickerCallback(data) {
              var url = 'nothing';
              if (data.action == google.picker.Action.PICKED) {
                  console.log(data);
                  var thumbnail = data.docs[0].thumbnails;
                  ulrImagen = thumbnail[3]['url'];
                  document.getElementById('imgPreview').src = ulrImagen;
                  document.getElementById('txtPreview').value = ulrImagen;
              }
            
          }
    </script>
      <script src="https://apis.google.com/js/api.js?onload=onApiLoad"></script>
      <link rel="stylesheet" href="css/bootstrap.min.css"/>
  </head>
    <body>
        <form id="form1" runat="server">
        <div class="container-fluid text-center">
            <br/><br/>
           
            <div class="row">
             
    <div class="col-md-3 col-md-offset-5">
        <img src="img/logo-01.png" id="imgPreview"  class="img-responsive img-thumbnail"/><br/><br/>
        <textarea id="txtPreview" class="form-control" rows="3"></textarea>
        <br/><br/>
        <a class="btn btn-primary btn-lg btn-block" onclick="createPicker();" > 
            <img width="40" src="img/icono.png" /> Subir /Seleccionar
        </a>
    </div>        
                   
           
            </div>
            
            </div>
            </form>
    </body>
</html>
    
   

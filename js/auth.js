/**
 * Please overwrite the function datascienceandrRenderUserData
 */

// facebook SDK
window.fbAsyncInit = function() {
  FB.init({
    appId      : '1562521020444332',
    version    : 'v2.8'
  });
  FB.AppEvents.logPageView();
};

(function(d, s, id){
   var js, fjs = d.getElementsByTagName(s)[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement(s); js.id = id;
   js.src = "//connect.facebook.net/zh_TW/sdk.js";
   fjs.parentNode.insertBefore(js, fjs);
 }(document, 'script', 'facebook-jssdk'));


var datascienceandrUrlsValue;
function datascienceandrUrls() {
  if (!datascienceandrUrlsValue) {
    datascienceandrUrlsValue = _.sample(["https://api2.datascienceandr.org"]);
  }
  return datascienceandrUrlsValue;
}
var datascienceandrUser;
function datascienceandrAuth(service, token) {
  datascienceandrOverlay();
  if (!datascienceandrIsLogin) return;
  var url = datascienceandrUrls();
  $.ajax({
    url : url + "/api/authUser",
    type : "POST",
    data : {service : service, token : JSON.stringify(token)},
    dataType : "json",
    success: function(data) {
      setTimeout(datascienceandrCloseLoginModal, 100);
    },
    complete: datascienceandrGetUserData,
    error: function(jqXHR, textStatus, errorThrown) {
      throw errorThrown;
    },
    timeout: 5000,
    xhrFields: {
      withCredentials: true
    }
  });
}

var loginClose = $("#login-close");
function datascienceandrCloseLoginModal() {
  loginClose.click();
}

function datascienceandrLogout() {
  var url = datascienceandrUrls();
  $.ajax({
    url : url + "/api/auth/logout",
    type : "POST",
    data : {},
    dataType : "json",
    success: function(data) { },
    complete: datascienceandrRenderUserData,
    error: function(jqXHR, textStatus, errorThrown) {
      throw errorThrown;
    },
    timeout: 5000
  });
  var div = $("#report_container");
  div.empty();
}

var datascienceandr = {
  user : {
    google : null,
    facebook : null,
    classroom : null
  },
  error : {
    google : null,
    facebook : null,
    classroom : null
  }
};

// google
function onGoogleSuccess(user) {
  datascienceandr.user.google = user;
  datascienceandrUser = user.getBasicProfile().getEmail().split("@")[0];
  var token = user.getAuthResponse().id_token;
  datascienceandrAuth("Google", token);
}

// facebook
function datascienceandrFacebookLogin() {
  FB.login(function(response) {
    if (response.status === "connected") {
      FB.api("/me", {fields : "name,email"}, function(response) {
        if (response.email) {
          datascienceandrUser = response.email.split("@")[0];
        } else {
          datascienceandrUser = response.name;
        }
      });
      datascienceandrAuth("Facebook", FB.getAuthResponse().accessToken);
    }
  }, {scope: 'public_profile,email'});
}

// classroom
var 
  datascienceandrClassroomAuthAccount = $("#classroom-account"),
  datascienceandrClassroomAuthPassword = $("#classroom-password");

function datascienceandrClassroomAuth() {
  var time = Date.now();
  var account = datascienceandrClassroomAuthAccount[0].value;
  datascienceandrUser = account;
  var password = datascienceandrClassroomAuthPassword[0].value;
  var randomArray = new Uint8Array(2);
  window.crypto.getRandomValues(randomArray);
  var object = parseInt(Date.now() / 1000) + "-" + _.map(randomArray, function(x) {return x.toString(16);}).join("");
  var shaObj = new jsSHA("SHA-256", "TEXT");
  shaObj.setHMACKey(password, "TEXT");
  shaObj.update(object);
  var hmac = shaObj.getHMAC("HEX");

  datascienceandrAuth("classroom", {
    account : account,
    object : object,
    hmac : hmac
  });
}

// facebook button

// google button
function renderGoogleButton() {
  $("#google-signin").bind("DOMSubtreeModified", function() {
    $("#google-signin-wrapper > img").hide();
  });
  gapi.signin2.render("google-signin", {
    'scope': 'profile email',
    'width': 240,
    'height': 50,
    'longtitle': true,
    'theme': 'dark',
    'onsuccess': onGoogleSuccess,
    'onfailure': function(err) {
      throw err;
    }
  });
}

// disable default login
var datascienceandrIsLogin = false;
function datascienceandrSetLogin() {
  datascienceandrIsLogin = true;
  $("#classroom-login").hide();
}

// overlay
var datascienceandrOverlayDiv = $(".overlay");
function datascienceandrOverlay() {
  if (!datascienceandrIsLogin) return;
  datascienceandrOverlayDiv.show();
  setTimeout(function() {
    datascienceandrOverlayDiv.hide();
  }, 10000);
}


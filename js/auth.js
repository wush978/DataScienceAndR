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
    datascienceandrUrlsValue = _.sample(["https://api.datascienceandr.org", "https://api2.datascienceandr.org"]);
  }
  return datascienceandrUrlsValue;
}
var datascienceandrUser;
function datascienceandrAuth(service, token) {
  if (!datascienceandrIsLogin) return;
  var url = datascienceandrUrls();
  $.ajax({
    url : url + "/api/authUser",
    type : "POST",
    data : {service : service, token : JSON.stringify(token)},
    dataType : "json",
    success: function(data) {
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
var datascienceandrUserData;
function datascienceandrGetUserData() {
  $.ajax({
    url : datascienceandrUrls() + "/api/auth/getCurrentUserRecords",
    type : "POST",
    data : {},
    dataType : "json",
    success : function(data) {
      datascienceandrUserData = data;  
    },
    complete : datascienceandrRenderUserData,
    error: function(jqXHR, textStatus, errorThrown) {
      throw errorThrown;
    },
    timeout : 5000,
    xhrFields: {
      withCredentials: true
    },
    crossDomain: true
  });
}
var reportContainer = $("#report_container");
function datascienceandrRenderUserData() {
  setTimeout(datascienceandrCloseLoginModal, 100);
  var div = reportContainer;
  div.empty();
  var src = '<div id="user_id" style="text-align : center;"><h3>以下是' + datascienceandrUser + '的操作紀錄</h3></div>' +
    '<table id="used_record_table" class="display">' +
    '<thead><td>課程名稱</td><td>單元名稱</td><td>進入/完成</td><td>時間</td></tr></thead>' +
    "<tfoot><tr><td>課程名稱</td><td>單元名稱</td><td>進入/完成</td><td>時間</td></tr></tfoot>" +
    "<tbody>";
  _.forEach(datascienceandrUserData, function(record) {
    var result = "<tr><td>" +
      record.course.split(":")[0] +
      "</td><td>" +
      record.course.split(":")[1] +
      "</td><td>" +
      (record.type == 1 ? "完成" : "進入") +
      "</td><td>" +
      record.created_at +
      "</td></tr>";
    src += result;
  });
  src += "</tbody>";
  div.append(src);
  $("#used_record_table").DataTable({"columnDefs" : []});
}
var 
  classroomLoginClose = $("#classroom-login-close"),
  loginClose = $("#login-close");
function datascienceandrCloseLoginModal() {
  setTimeout(function() {
    try{ loginClose.click(); } catch(e) { loginClose.click(); }
  }, 100);
  try { classroomLoginClose.click(); } catch(e) { classroomLoginClose.click(); }
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
  $("#google-signin-wrapper > img").remove();
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
}


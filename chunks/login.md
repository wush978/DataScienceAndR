<!-- scripts: [{"src" : "https://apis.google.com/js/platform.js?onload=renderGoogleButton", "async" : null, "defer" : null}, {"src" : "js/auth.js"}, {"src" : "js/underscore-min.js"}, {"src" : "js/sha256.js"}] -->

<!-- Button trigger modal -->
<div style="font-size:18px;">
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#login-menu" onclick="datascienceandrSetLogin();">登入</button>或<button class="btn btn-primary btn-lg" onClick="return datascienceandrLogout();">登出</button>
</div>

<!-- Modal -->
<div class="modal fade" id="login-menu" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="text-align:center;">
      <div class="overlay" style="background: rgb(0, 0, 0) none repeat scroll 0% 0%; position: absolute; top: 0px; right: 0px; bottom: 0px; left: 0px; opacity: 0.5; z-index:1060; display: none">
        <div id="loading-img"></div>
      </div>
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="login-close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">請選擇登入的服務</h4>
      </div>
      <div class="modal-body">
        <div class="row" style="text-align: center;">
          <div style="position: relative; padding-right: 20px; padding-left: 20px;">
            <div class="thumbnail" style="width: 300px; display:inline-block; float: none; border: none !important;">
              <div style="width: 260px; height: 60px; display:inline-block;"/>
                <a id="google-signin-wrapper" class="thumbnail" href="#">
                  <img alt="Sign in with Google" style="width: 240px; height: 50px; line-height: 50px;" src=""/>
                  <div id="google-signin"></div>
                </a>
              </div>
              <div style="width: 260px; height: 60px; display:inline-block;">
                <a class="thumbnail" onClick="return datascienceandrFacebookLogin();">
                  <img alt="Sign in with Facebook" style="width: 240px; height: 50px; line-height: 50px;" src="" onClick="return datascienceandrFacebookLogin();"/>
                </a>
              </div>
              <div style="width: 260px; height: 60px; display:inline-block;">
                <a class="thumbnail" onclick='$("#classroom-login").show();'>
                  <img alt="Classroom帳號登入" style="width: 240px; height: 50px; line-height: 50px;" src=""/>
                </a>
              </div>
              <div id="classroom-login" style="display:inline-block; display:none;">
                <div class="input-group">
                  <span class="input-group-addon">帳戶</span>
                  <input id="classroom-account" type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">
                </div>
                
                <div class="input-group">
                  <span class="input-group-addon">密碼</span>
                  <input id="classroom-password" type="password" class="form-control" placeholder="Password" aria-describedby="basic-addon2">
                </div>
                <div class="input-group">
                  <input value="Login" class="btn btn-primary" type="submit" onClick="return datascienceandrClassroomAuth();">
                </div>
              </div> 
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


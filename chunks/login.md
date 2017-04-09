<button class="btn btn-primary" data-toggle="modal" data-target="#login-menu" onClick="return datascienceandrSetLogin();">請選擇登入的服務</button>或<button class="btn btn-primary" onClick="return datascienceandrLogout();">登出</button>

<div id="login-menu" class="modal fade in" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button id="login-close" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
  </div>
  <div class="modal-body">
    <div class="row">
      <div style="position: relative; padding-right: 20px; padding-left: 20px;">
        <ul class="thumbnails" style="text-align: center; font-size: 150%">
          <li class="span3" style="display:inline-block; float:none;">
            <a id="google-signin-wrapper" class="thumbnail" href="#">
              <img alt="Sign in with Google" style="width: 240px; height: 50px; line-height: 50px;" src=""/>
              <div id="google-signin"></div>
            </a>
          </li>
          <li class="span3" style="display:inline-block; float:none;">
            <a class="thumbnail" onClick="return datascienceandrFacebookLogin();">
              <img alt="Sign in with Facebook" style="width: 240px; height: 50px; line-height: 50px;" src="" onClick="return datascienceandrFacebookLogin();"/>
            </a>
          </li>
          <li class="span3" style="display:inline-block; float:none;">
            <!-- <button class="btn btn-primary" data-toggle="modal" data-target="#login-menu">請選擇登入的服務</button> -->
            <a class="thumbnail" data-toggle="modal" data-target="#classroom-login">
              <img alt="Classroom帳號登入" style="width: 240px; height: 50px; line-height: 50px;" src=""/>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>

<div id="classroom-login" class="modal fade in" tabindex="-2" role="dialog" aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button id="classroom-login-close" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
  </div>
  <div class="modal-content">
    <div style="width: 66.66666667%">
			<form class="form-horizontal" action="javascript:void(0);">
					<div class="control-group">
						<label class="control-label" for="account">帳號名稱</label>
						<div class="controls">
							<input id="classroom-account" type="text" required"/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="password">密碼</label>
						<div class="controls">
							<input id="classroom-password" type="password" required"/>
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
							<input value="Login" class="btn btn-primary" type="submit" onClick="return datascienceandrClassroomAuth();">
							<!-- <a id="forgotPasswordLink" href="#">Forgot Password</a> -->
						</div>
					</div>
			</form>
    </div>
  </div>
</div>

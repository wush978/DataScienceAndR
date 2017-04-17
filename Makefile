.PHONY=clean libs.wxs repos.wxs
WXS=libs.wxs courses.wxs project.wxs

all : dsr-installer.msi 

dsr-installer.msi : dsr-installer.wxs $(WXS)
	wixl -o $@ -v $^ -D SourceDir=`pwd`

%.wxs :
	find $(basename $@) -type f | wixl-heat -p "" --var var.SourceDir \
	  --component-group $(basename $@) \
	  --directory-ref INSTALLDIR > $@

clean :
	-rm dsr-installer.msi $(WXS)
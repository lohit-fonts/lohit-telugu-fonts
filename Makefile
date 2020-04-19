all: ttf woff eot ttf-dist sfd-dist web-dist

version:= 2.5.3
font_name:= "lohit-telugu"
font_filename:= "Lohit-Telugu"
source_dir:= "src"
conf_filename:= "66-lohit-telugu.conf"

ttf: ttf-bin
	@echo "----------Generating ttf from sfd file----------"
	./generate.pe $(source_dir)/*.sfd
	@echo "----------Finished generating ttf file----------"
	@echo " "

woff: woff-bin
	@echo "----------Generating woff from ttf file----------"
	 java -jar /usr/share/java/sfnttool.jar -w $(font_filename).ttf $(font_filename).woff
	@echo "----------Finished generating woff file----------"
	@echo " "

eot: eot-bin
	@echo "----------Generating eot from ttf file----------"
	java -jar /usr/share/java/sfnttool.jar -e -x $(font_filename).ttf $(font_filename).eot
	@echo "----------Finished generating eot file----------"
	@echo " "

ttf-dist: ttf
	mkdir -p $(font_name)-ttf-$(version)
	cp -p COPYRIGHT OFL.txt README.md AUTHORS ChangeLog $(source_dir)/$(conf_filename) $(font_filename).ttf $(font_name)-ttf-$(version)
	rm -rf $(font_name)-ttf-$(version)/.git
	tar -czvf $(font_name)-ttf-$(version).tar.gz $(font_name)-ttf-$(version)
	rm -rf $(font_name)-ttf-$(version)

sfd-dist: dist
	mkdir -p $(font_name)-$(version)
	cp -p COPYRIGHT OFL.txt README.md  AUTHORS generate*.pe Makefile ChangeLog $(source_dir)/$(conf_filename) $(source_dir)/$(font_filename).sfd $(font_name)-$(version)
	rm -rf $(font_name)-$(version)/.git
	rm -rf $(font_name)-$(version)/*.ttf
	tar -czvf $(font_name).tar.gz $(font_name)-$(version)
	rm -rf $(font_name)-$(version)

web-dist: webdist
	mkdir -p $(font_name)-web-$(version)
	cp -p COPYRIGHT OFL.txt README.md  AUTHORS  ChangeLog  $(font_filename).woff  $(font_filename).eot $(font_name)-web-$(version)
	rm -rf $(font_name)-web-$(version)/.git
	tar -czvf $(font_name)-web-$(version).tar.gz $(font_name)-web-$(version)
	rm -rf $(font_name)-web-$(version)

clean: cleanall
	rm -f *.ttf *.eot *.woff
	rm -rf *.tar.gz
	rm -rf lohit-telugu*

.PHONY: ttf-bin woff-bin eot-bin webdist dist cleanall version

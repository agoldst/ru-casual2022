## Configuration ##

# name of source
Rmd := ru-casual2022.Rmd
# name of output: stem only, no suffix or file path
target := $(basename $(Rmd))

## Optional configuration ##

md := $(target).md
hugo_root := $(HOME)/www/andrewgoldstone.com
post_target := $(hugo_root)/content/post/$(md)

# the files_source directory is copied UNDER files_target:
post_files_source := figure
post_files_target := $(hugo_root)/static/blog/$(target)

## Knitting ##

markdown: $(md)

# we'll use sed to get the {{< figure >}} shortcodes back from pandoc's 
# aggressive escaping

$(md): $(Rmd)
	R -e 'rmarkdown::render("$(Rmd)", output_file="$(md)")'
	mkdir -p tmp
	mv $(md) tmp/$(md)
	# sed -i .bak 's#$(snip_src)#$(snip_target)#' tmp/$(md)
	pandoc tmp/$(md) -t markdown-raw_attribute -s -o $(md)
	sed -i .bak 's/{{\\</{{</' $(md)
	sed -i .bak 's/{{< figure/{{< figure imgclass="img-padded"/' $(md)
	sed -i .bak 's/\\>}}/>}}/' $(md)
	rm -rf tmp $(md).bak

## Deployment ##

deploy: markdown
	cp -f $(md) $(post_target)
	if [[ -d $(post_files_source) ]] ; then \
	    mkdir -p $(post_files_target) ; \
	    cp -f -R $(post_files_source) $(post_files_target) ; \
	fi

clean:
	rm -f $(md)
	rm -rf $(post_files_source)

.DEFAULT_GOAL := markdown

.PHONY: markdown deploy clean


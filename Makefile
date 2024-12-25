OTTFILE1 = ott/lambda-r.ott
TEXFILE1 = $(OTTFILE1:.ott=.tex)
INPUTS1  = $(wildcard chapters/compilation/*.tex)
OUTPUTS1 = $(patsubst chapters/compilation/%.tex,filtered/compilation/%.tex,$(INPUTS1))

OTTFILE2 = ott/lambda-iu.ott
TEXFILE2 = $(OTTFILE2:.ott=.tex)
INPUTS2  = $(wildcard chapters/arguments/*.tex)
OUTPUTS2 = $(patsubst chapters/arguments/%.tex,filtered/arguments/%.tex,$(INPUTS2))

all: $(TEXFILE1) $(OUTPUTS1) $(TEXFILE2) $(OUTPUTS2)
	latexmk -interaction=nonstopmode -file-line-error -synctex=1 \
		-pdf Thesis

$(TEXFILE1): $(OTTFILE1)
	ott $(OTTFILE1) -o $(TEXFILE1) \
		-tex_wrap false -tex_show_meta false

$(TEXFILE2): $(OTTFILE2)
	ott $(OTTFILE2) -o $(TEXFILE2) -tex_name_prefix IU \
		-tex_wrap false -tex_show_meta false

filtered/compilation/%.tex: chapters/compilation/%.tex $(OTTFILE1)
	ott $(OTTFILE1) -tex_filter $< $@

filtered/arguments/%.tex: chapters/arguments/%.tex $(OTTFILE2)
	ott $(OTTFILE2) -tex_filter $< $@

clean:
	latexmk -c
	rm -rf $(TEXFILE1) $(OUTPUTS1) $(TEXFILE2) $(OUTPUTS2)

.PHONY: all clean

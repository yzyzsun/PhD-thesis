OTTFILE1 = ott/lambda-r.ott
TEXFILE1 = $(OTTFILE1:.ott=.tex)
INPUTS1  = $(wildcard chapters/compilation/*.tex)
OUTPUTS1 = $(patsubst chapters/compilation/%.tex,filtered/compilation/%.tex,$(INPUTS1))

all: $(TEXFILE1) $(OUTPUTS1)
	latexmk -interaction=nonstopmode -pdf Thesis

$(TEXFILE1): $(OTTFILE1)
	ott $(OTTFILE1) -o $(TEXFILE1) \
		-tex_wrap false -tex_show_meta false

filtered/compilation/%.tex: chapters/compilation/%.tex $(OTTFILE1)
	ott $(OTTFILE1) -tex_filter $< $@

clean:
	latexmk -c
	rm -rf $(TEXFILE1) $(OUTPUTS1)

.PHONY: all clean

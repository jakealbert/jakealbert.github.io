all: html pdf

pdf:  resume.pdf
html: resume.html
docx: resume.docx

CSS_FONT = "//fonts.googleapis.com/css?family=Source+Code+Pro|Source+Serif+Pro:400,600,700"

PANDOC = pandoc --smart --standalone --from markdown

PANDOC_TEX  = --to context --template template.tex
PANDOC_HTML = --to html --css $(CSS_FONT) --css resume.css \
 --variable=pagetitle:"Jake Lipton / Resume" \
 --variable=keywords:"jake lipton, resume" \
 --variable=author:"Jake Lipton" \
 --variable=header-includes='<meta name="description" content="Jake Lipton Resume" />'
PANDOC_DOCX = --to docx

%.pdf: %.tex
	context $<

%.tex:  %.md template.tex
	$(PANDOC) $(PANDOC_TEX)  -o $@ $<

%.html: %.md resume.css
	$(PANDOC) $(PANDOC_HTML) -o $@ $<

%.docx: resume.md
	$(PANDOC) $(PANDOC_DOCX) -o $@ $<

clean:
	rm -f resume.html
	rm -f resume.tex
	rm -f resume.tuc
	rm -f resume.log
	rm -f resume.pdf
	rm -f resume.docx

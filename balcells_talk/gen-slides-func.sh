gen_slides(){
	# Quick wrapper function to convert .ipynb into reveal.js slides
	jupyter-nbconvert --to slides $1 --reveal-prefix=reveal.js	
}
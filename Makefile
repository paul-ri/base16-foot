activate-venv=. venv/bin/activate

venv: ## Create virtual environment
	python -m venv $@
	$(activate-venv); \
	pip install -r requirements.txt

build/schemes: venv ## Clone all schemes
	git clone https://github.com/chriskempson/base16-schemes-source build/sources/schemes
	-$(activate-venv); \
	cd build; \
	pybase16 update --custom

build: venv build/schemes ## Build and update themes
	rm -rf build/output
	mkdir -p build/templates/foot
	cp -r templates build/templates/foot
	$(activate-venv); \
	cd build; \
	pybase16 build
	cp -r build/output/foot/themes .
	@echo "Themes copied in 'themes' folder"
.PHONY: build

clean: ## Remove build files
	rm -rf venv build

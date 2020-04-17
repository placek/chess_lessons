all: src/Main.elm
	elm make src/Main.elm --output build/assets/scripts/main.js --optimize

debug: src/Main.elm
	elm make src/Main.elm --output build/assets/scripts/main.js --debug

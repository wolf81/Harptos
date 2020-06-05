.PHONY: test build clean docs

test: 
	# test project	
	set -o pipefail && xcodebuild test -scheme "Harptos macOS" -destination "platform=macOS,arch=x86_64" OBJROOT="$(PWD)/build" -sdk "macosx10.15" | xcpretty

build:
	# build project
	set -o pipefail && xcodebuild build -scheme "Harptos macOS" -destination "platform=macOS,arch=x86_64" OBJROOT="$(PWD)/build" -sdk "macosx10.15" | xcpretty

clean:
	# clean project
	set -o pipefail && xcodebuild clean | xcpretty

docs:
	# generate docs
	jazzy


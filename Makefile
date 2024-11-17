install_lcov:
	@echo "Checking if lcov is installed... 🕵️‍♂️"  
	@command -v lcov >/dev/null 2>&1 || brew install lcov

.SILENT:
.PHONY: test
flutter_test: install_lcov
	@echo "Running tests... 🧪"
	@flutter test --coverage
	@echo "Generating coverage report... 📊"
	@lcov --remove coverage/lcov.info 'lib/**/*.g.dart' -o coverage/lcov.info --ignore-errors unused
	@genhtml -o coverage coverage/lcov.info
	@echo "Tests completed. Check coverage/index.html for detailed report. 🎉"
	@open coverage/index.html

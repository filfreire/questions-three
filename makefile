build:
	poetry install
	poetry build
	# Not sure about this one:
	poetry run python setup.py build

test:
	poetry run python setup.py test

debug:
	# CUSTOM_REPORTERS_FILE=questions_three/reporters/event_logger/color_event_logger.py poetry run python examples/simple_http_check.py
	# CUSTOM_REPORTERS_FILE=custom_reporters poetry run python examples/test_script.py
	poetry run python examples/test_script.py

debug_custom:
	event_reporters=ArtifactSaver,JunitReporter,ResultCompiler CUSTOM_REPORTERS_FILE=custom_reporters poetry run python examples/test_script.py

debug_classic:
	event_reporters=ArtifactSaver,EventLogger,JunitReporter,ResultCompiler poetry run python examples/test_script.py

lint:
	poetry run black --config black.toml .
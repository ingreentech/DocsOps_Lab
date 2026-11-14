# Setup

Environment for the DocsOps Lab project. Tested on Windows 10 with Git Bash.

## Prerequisites
- Git (version: 2.51.0.windows.2)
- Python 3.10 or newer (version used: 3.13.17)

## Steps
1. Clone the repository and open it in Git Bash.
2. Create a virtual environment: python -m venv .venv
3. Activate it: source .venv/Scripts/activate
4. Install dependencies: pip install -r requirements.txt
5. Verify: datasette --version (expected: 0.65.5)

## Verify the installation
Describe the smoke test you ran and what you saw in the browser.

## Installed versions
- Python: version 3.13.17
- Datasette: version 0.65.5
- sqlite-utils: version 4.2.1

## Troubleshooting

### NOTE 1: Python 3.15 is not supported by the dependencies at the time of writing

Symptom: pip install datasette fails with “Failed building wheel for PyYAML” and “Microsoft Visual C++ 14.0 or greater is required”.
Cause: the virtual environment used Python 3.15, for which PyYAML has no prebuilt Windows package.
Fix: install Python 3.13, recreate the environment with py -3.13 -m venv .venv, and reinstall.
 
# RespirationPatternTool
A tool for scientists and therapists to guide subjects to breath along certain patterns or scenarios

The readme file and documentatation is a TODO currently. As soon as the MVP is ready, a usage guide will be written.

## Run with Qt Creator

Later some binary releases might be available. Planned is Win, Mac, Linux .deb and Android. For now it's most simple to build and run the tool in Qt Creator.

All you need is a full Qt 5.12 installation for you system. When you can buld and run hello world with Qt. You also should be able to run Respiration Pattern Tool. Just open the RespirationPatternTool.pro and press the run button.

## Run with python

Since all the application logic is written in QML (a design choice) the Respiration Pattern Tool it was easy to provide a python script to run it with python3.

First install python3 on your machine.

https://www.python.org/downloads/

The recommended way to run the tool is in a virtual environment with the requirements installed. The virtual environment can be set up in the following way.

python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt

With activated environment the script can be run.

python src/python/respiration_pattern_tool.py

On windows please adjust these commands to match windows file extensions and dir seperators.

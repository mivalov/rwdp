# Responsive Web Design with Python (RWDP)
RWDP is a Flask website, which is inspired by the freeCodeCamp's course - [Responsive Web Design](https://www.freecodecamp.org/learn/2022/responsive-web-design/).
The project gathers 5 distinct webpages into a single Python web application:
- Personal Portfolio Webpage
- Tribute Page
- Survey Form
- Product Landing Page
- Technical Documentation Page

## Setup
The project offers 3 ways to run the application locally, with a potential for a deployment in the cloud.

### 1. Docker
The project already includes the necessary files to build and run the application locally with Docker.

#### 1.1 Prerequisites
You need to have at least [Docker Engine](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/) installed on your machine.
Alternatively, Docker offers an easy-to-install application for macOS, Windows and Linux - [Docker Desktop](https://docs.docker.com/get-docker/) - which already includes the necessary tools right out of the box.

#### 1.2 Running the application
In the terminal, navigate to the project directory and execute the following command:
```bash
docker-compose up --build --detach
 ```
This will build the necessary image, and run a container in a detached mode. 
The running container already includes the application and its dependencies, so you will not need to install anything else for this project.

When the execution process is complete, you can open `localhost:5000` in your favourite browser.

### 2. Python Venv
[Venv](https://docs.python.org/3/library/venv.html) is a Python built-in module, which can be used for creating lightweight virtual environments.

#### 2.1 Prerequisites
Currently, the project is uses [Python 3.10.5](https://www.python.org/downloads/release/python-3105/). Therefore, it is recommended to install the same version of Python on your local machine.

#### 2.2 Running the application
In the terminal, navigate to the project directory and execute the following commands:
```bash
# create a virtual environment in the current directory
python3 -m venv .venv

# activate the virtual environment on Linux/macOS within bash/zsh
source .venv/bin/activate

# activate the virtual environment on Windows within cmd.exe
.venv\Scripts\activate.bat

# install the necessary dependencies
python3 -m pip install -r requirements.txt

# start the application (Ctrl+C stops it)
waitress-serve --host=0.0.0.0 --port=5000 rwdp.main:app
```
Once the application is running, you can open `localhost:5000` in your browser of choice.

### 3. Conda
[Conda](https://docs.conda.io/en/latest/) is an open-source package and environment management system for maOS, Windows and Linux.

#### 3.1 Prerequisites
There are two options for installation:
- [Miniconda](https://docs.conda.io/en/latest/miniconda.html) - a minimal distribution, which includes `conda`, Python, their dependencies and a few other useful packages.
- [Anaconda](https://docs.continuum.io/anaconda/) - a Python/R distribution, containing `conda` and a collection of 250 packages related to data science.

You can never go wrong with either of them. In case of a missing package, a simple `conda install <package>` can do the trick.

#### 3.2 Running the application
In the terminal of choice, navigate to the project folder and execute the following:
```bash
# create a virtual environment
conda env create -f requirements.yml

# activate the virtual environment
conda activate rwdp

# start the application (Ctrl+C stops it)
waitress-serve --host=0.0.0.0 --port=5000 rwdp.main:app
```
After the application is running, you can open `localhost:5000` in your preferred browser.

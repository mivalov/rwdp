from flask import Flask, render_template, url_for

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('pages/about.html')

@app.route('/tribute-page')
def tributePage():
    return render_template('pages/tribute-page.html')

@app.route('/survey-form')
def surveyForm():
    return render_template('pages/survey-form.html')

@app.route('/product-landing-page')
def productLandingPage():
    return render_template('pages/product-landing-page.html')

@app.route('/technical-documentation-page')
def technicalDocumentationPage():
    return render_template('pages/technical-documentation-page.html')

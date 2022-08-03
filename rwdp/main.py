from flask import Flask, render_template, url_for

app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/about')
def about():
    return render_template('pages/about.html')


@app.route('/survey-form')
def survey_form():
    return render_template('pages/survey-form.html')


@app.route('/tribute-page')
def tribute_page():
    return render_template('pages/tribute-page.html')


@app.route('/product-landing-page')
def product_landing_page():
    return render_template('pages/product-landing-page.html')


@app.route('/technical-documentation-page')
def technical_documentation_page():
    return render_template('pages/technical-documentation-page.html')

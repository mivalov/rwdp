# **HOW TO MAKE AND SETUP A NEW HTML PAGE**

The whole page structure for the project is made with the help of [Jinja's](https://jinja.palletsprojects.com/en/3.1.x/templates/) template system!  
Every page in the project is an "extention" of the base template html file ("**base-main.html**").

*Located in:*

```directory
rwdp\templates\pages\base\base-main.html
```

The idea behind this is that we don't waste time rewriting code that will be reused in other files.

## **IMPORTANT NOTES:**

### 1. Jinja block indentation

**IMPORTANT:**
*Always indent the content in the Jinja blocks by **2 spaces** ("&nbsp;&nbsp;")*

### 2. Whitespace control

- Jinja block tags are made with [whitespace control](https://jinja.palletsprojects.com/en/3.1.x/templates/#whitespace-control) in mind so it is important to write them as in the examples.

- Some blocks may have addition filter blocks within them to add indents, so the html looks nice and clean with the Jinja blocks stripped. **Write your content between the filter blocks!**

**IMPORTANT:**
*Pay attention to the minus symbol ("-") in the Jinja blocks!*

|Symbol|Affect|
|:---:|:---|
|**-**|strips whitespace|
|**+**|preserves whitespace|

|Jinja block|Outcome|
|:---:|:---|
|`{%- block example ... %}`|strips before|
|`{%+ block example ... %}`|preserves before|
|`{%- block example ... -%}`|strips before and after|
|`{%+ block example ... -%}`|preserves before and strips after|

> *Although the code will work perfectly fine without **whitespace control** in mind, we should always strive to keep things clean and organized as much as we can.*

### 3. Usefull tips

- If you are uncertain were a specific block "inserts" their content  just by reading the examples, open up ("**base-main.html**") and look for that block with the same name and see where it is placed!

   **There cannot be 2 blocks with the same name!**

- For those unfamiliar with Jinja, Jinja blocks allow you to name the "closing block", but of course the name can ONLY be the same as the "opening block"!

   In the examples this is shown on Jinja blocks like "header" and "main", as it is expected of them to be one of the longer blocks in the page. So to not get confused by the same "closing blocks" we can name them with the same name we used for the "opening block".

## HOW TO BUILD A PAGE

Basic layout of the Jinja blocks, what they do and things to be aware of when setting things up.

### **1. Rendering the page**

Our website is build on the [Flask](https://flask.palletsprojects.com/en/2.2.x/) web framework. To [render a page](https://flask.palletsprojects.com/en/2.2.x/quickstart/#rendering-templates) go to the ("**main.py**") file and define the url you want for the page along with the location of your page HTML file.

*Located in:*

```directory
rwdp\main.py
```

*Code:*

```python
@app.route('/example-page-url')
def example_page():
    return render_template('example-page.html')
```

### **2. Building the child template**

Earlier we mentioned that pages are an "extention" of the [base template](https://jinja.palletsprojects.com/en/3.1.x/templates/#base-template) HTML file. We refer to these pages as [child templates](https://jinja.palletsprojects.com/en/3.1.x/templates/#child-template).

#### **2.1 Extend template**

---

"Extending" or in other words copying the content from the *base template* to our new *child template* is done with the `{% extends %}` Jinja tag.

**IMPORTANT:**  
\- *This MUST be the first tag in your child template*  
\- *Your BASE TEMPLATE **needs to be in the same folder or in a subfolder** from where your CHILD TEMPLATE is located.*

```Jinja
{% extends "pages/base/base-main.html" %}
```

#### **2.2 Custom variables**

---

Custom Jinja variables each controlling specific page behaviours making them easier to manipulate and manage.

- ##### **Variable to disable the default navigation completely**

  If needed you can completely remove the default navigation by setting this variable to `true`.

  This will:  
  \- disable all the HTML associated with the default navigation bar  
  \- remove the shylesheet link for the default navigation bar in the `<head>` tag

  ```Jinja
  {# Disables the default navigation bar #}
  {# Removes both its HTML and CSS #}

  {% set nav_disabled = true %}
  ```

- ##### **Variable to set the href link for the "skip navigation" button**

  If you decide to **KEEP** the default navigation bar you musn't forget to:  
  \- set up your nav buttons (Check the ["nav_extra_buttons"](#block-nav_extra_buttons) block)  
  \- set a href link for your hidden "skip navigation" button

  ```Jinja
  {# Sets the href link for the "skip navigation" button #}

  {% set skip_nav_href = '#anchor' %}
  ```

#### **2.3 List of all the EMPTY blocks**

---

Empty Jinja blocks as the name suggests have no predefined content in them. They are there to insert additional content on top of the existing one in the base template file.

**To keep things organized, blocks should be called in the same order in your child template as they are listed here!**

- ##### Block "page_description"

  ---

  This block is OPTIONAL, but there if you need it!

  And as you may have guessed you can set a description for your page with it.

  ```Jinja
  {# Sets the description for your page if needed #}
  {# Align atrributes underneath eachother like in the example #}

  {% block page_description %}
    <meta name="description"
          content="Your page decription goes here!">
  {%- endblock %}
  ```

- ##### Block "stylesheet_extra" (REQUIRED)

  ---

  **It is intended that every page that "extends" the base template page has its own seperate CSS file, so that we keep things organized.**

  The base template page is build in a way that the stylesheet link for the child template is called **LAST** after all other stylesheet links!
  This is so that if you want to overwrite the default styling for your new page, you can easily do it!

  The "stylesheets_extra" block in the base template page is defined as [required](https://jinja.palletsprojects.com/en/3.1.x/templates/#required-blocks).

  **Meaning you MUST include this block and set up a stylesheet link!**

  ```Jinja
  {# Sets the link for the stylesheet for your new page #}
  {# It is the last stylesheet link in the <head> #}
  {# Align atrributes underneath eachother like in the example #}

  {% block stylesheets_extra %}
    <link rel="stylesheet"
          href="{{ url_for('static', filename='css/example.css') }}"/>
  {%- endblock %}
  ```

- ##### Block "title" (REQUIRED)

  ---

  The "title" block in the base template page is defined as [required](https://jinja.palletsprojects.com/en/3.1.x/templates/#required-blocks).

  **Meaning you MUST include this block and set up a page title!**

  ```Jinja
  {# [DEFINED AS REQUIRED] Sets the page title #}
  {# Title text is used in the footer by default #}

  {% block title -%}
    Example page title
  {%- endblock %}
  ```

- ##### Attribute blocks

  ---

  The "attribute" blocks are used ONLY to add attributes to the `<header>` and `<footer>` tags. Usefull if you want to apply different styling on them for the specific page using a different "id" and "classes" for every page.

  **IMPORTANT:**  
  \- Always add **1 space** ("&nbsp;") before the first attribute  
  \- Write the attributes on the same line as the "opening block"  
  \- You can wrap ONLY the "closing block" but need to add "-" at the start of it (see examples)

  ```Jinja
  {# Write your attributes here #}

  {% block header_attr %} class="example"{% endblock %}
  {%- block footer_attr %} id="example"{% endblock %}
  ```

  ```Jinja
  {# Example on how to wrap the closing block if the line gets too long #}
  {# DO NOT LEAVE ANY WHITESPACE BEFORE THE CLOSING BLOCK #}

  {% block header_attr %} class="example-one example-two" id="test"
  {%- endblock %}
  ```

- ##### Block "nav_extra_buttons"

  ---

  **If you decide to KEEP the navigation bar you musn't forget to set up extra buttons if needed, as it will only have a HOME ("return to index") button and the always present ABOUT and GITHUB buttons!**

  **RECOMMENDED:**  
  Add no more than 2 buttons with not so many characters in them as it will cause overflow on high zoom & small screen widths!

  *Of course you can add as many buttons as you like, but you will have to adjust the CSS of the navigation ("**nav.css**") so that everything looks nice and in place!*

  **IMPORTANT:**  
  \- Always add the `class="nav-item"` to all the button `<li>` tags.  
  \- Always add `class="nav-most-right` to the `<li>` tag on the last/most right button. It sets part of the separating line between the left buttons and the static right buttons (ABOUT & GITHUB).

  **NOTE:** *Only available if the default navigation is **ENABLED**.*

  ```Jinja
  {# Set up additional navigation buttons if NEEDED, else REMOVE this block #}
  {# Always add the class "nav-item" to all the buttons #}
  {# Always add the class "nav-most-right" to the last/most right button #}
  {# Available ONLY if default navigation is ENABLED #}

  {% block nav_extra_buttons %}
  {%- filter indent(width=8) %}
    <li class="nav-item">
      <a href="#anchor-one">
        Button1
      </a>
    </li>
    <li class="nav-item nav-most-right">
      <a href="#anchor-two">
        Button2
      </a>
    </li>
  {%- endfilter %}
  {%- endblock %}
  ```

- ##### Block "header_extra"

  ---

  The "header_extra" block is for building on top of the existing content, so **DO NOT** include the `<header>` tag as it is already in it.

  **NOTE:** *Only available if the default navigation is **ENABLED**.*

  ```Jinja
  {# Write your ADITIONAL <header> html here #}
  {# DO NOT add the <header> tag #}
  {# Available ONLY if default navigation is ENABLED #}

  {% block header_extra %}
  {% filter indent(width=4) %}
    <p>
      Extra header content
    </p>
  {%- endfilter %}
  {%- endblock %}
  ```

- ##### Block "header"

  ---

  **This is the block for the `<header>` in the `<body>` tag!**

  In the base template page this block is completely EMPTY!
  It's only in the correct place, meaning you **MUST** add the `<header>` tag.

  **NOTE:** *Only available if the default navigation is **DISABLED**.*

  ```Jinja
  {# Write your <header> html here #}
  {# ALWAYS add the <header> tag #}
  {# Available ONLY if default navigation is DISABLED #}

  {% block header %}
    <header>
      Example header content
    </header>
  {% endblock header %}
  ```

- ##### Block "main"

  ---

  **This is the block for the `<main>` in the `<body>` tag!**

  In the base template page this block is completely EMPTY!
  It's only in the correct place, meaning you **MUST** add the `<main>` tag.

  ```Jinja
  {# Write your <main> html here #}
  {# Always add the <main> tag #}

  {% block main %}
    <main>
      <section>
        <p>
          Example main content one
        </p>
      </section>

      <section>
        <p>
          Example main content two
        </p>
      </section>
    </main>
  {%- endblock main %}
  ```

- ##### Block "footer_title"

  ---

  **By default the footer title is the SAME as the page title defined in the ["title"](#block-title-required) block.**

  If you decide to change it ONLY write in plain text with no tags.
  The "footer_title" block is encased in a `<p>` tag by default in the base template page.

  ```Jinja
  {# Write your footer title here #}
  {# By default it is the same as the text in the "title" block #}

  {% block footer_title -%}
    {{ self.title() }}
  {%- endblock %}
  ```

- ##### Block "footer_extra"

  ---

  The "footer_extra" block is for building on top of the existing content, so **DO NOT** include the `<footer>` tag as it is already in it.

  ```Jinja
  {# Write your ADITIONAL <footer> html here #}
  {# DO NOT add the <footer> tag #}

  {% block footer_extra %}
  {% filter indent(width=4) %}
    <p>
      Extra footer content
    </p>
  {%- endfilter %}
  {%- endblock %}
  ```

- ##### Block "body_extra"

  ---

  The "body_extra" block is for building on top of the existing content, so **DO NOT** include the `<body>` tag as it is already in it.

  **This Jinja block is placed BETWEEN the `<footer>` and the `<scrip>` tags**

  ```Jinja
  {# Write your ADITIONAL <body> html here #}
  {# DO NOT add the <body> tag #}

  {%- block body_extra %}
  {% filter indent(width=4) %}
    <p>
      Extra body content
    </p>
  {%- endfilter %}
  {% endblock %}
  ```

#### **2.4 List of all the FULL blocks**

---

**IMPORTANT:**
*These blocks already have html written in them so if you call them you will essentially **erase** all of their original contents!*

But if you desire to completely rework them the option is there.

- ##### Block "body"

  ---

  The `<body>` is encased in a "body" Jinja block. In it is **ALL** of the main content of the base template page! Calling this block EMPTY will basically make an empty page with only the content in `<head>` intact!

  > *Do not call this block EMPTY unless you want to COMPLETELY **overwrite and rework** all of the content in it. (`<body>`, `<header>`, `<main>`, `<footer>`)*

  ```Jinja
  {# ONLY add if you want to completely rework the default body content #}

  {%- block body %}
  {% endblock %}
  ```

  ```Jinja
  {# Add additional content with the super block #}

  {%- block body %}
    {# Copy old content #}
    {{ super() }}

    {# Add new content #}
    <p>
      Additional body content
    </p>
  {% endblock %}
  ```

**NOTE:** *With the Jinja `{{ super() }}` block you can copy the original content of the block. So you can add additional content while preserving the original. [Read more about the Jinja super blocks.](https://jinja.palletsprojects.com/en/3.1.x/templates/#super-blocks)*

This can essentially make the block act as a more powerfull ["body_extra"](#block-body_extra) block.

- ##### Block "footer"

  ---

  The `<footer>` is encased in a "footer" Jinja n it is **ALL** of the default footer content of the base template page!

  > *Do not call this block EMPTY unless you want to **disable** the default footer or COMPLETELY **overwrite and rework** all of the content in it. (`<footer>`)*

  ```Jinja
  {# ONLY add if you want to disable/rework the default footer #}

  {%- block footer %}
  {% endblock %}
  ```

  ```Jinja
  {# Add additional content with the super block #}

  {%- block footer %}
    {# Copy old content #}
    {{ super() }}

    {# Add new content #}
    <p>
      Additional footer content
    </p>
  {% endblock %}
  ```

**NOTE:** *With the Jinja `{{ super() }}` block you can copy the original content of the block. So you can add additional content while preserving the original. [Read more about the Jinja super blocks.](https://jinja.palletsprojects.com/en/3.1.x/templates/#super-blocks)*

This can essentially make the block act as a more powerfull ["footer_extra"](#block-footer_extra) block.

## EXAMPLE PAGE

**IMPORTANT:** *Blocks should be called/used in the same order & written as shown in the example for consistency and whitespace control across all the pages.*

```jinja
{% extends "pages/base/base-main.html" %}

{# Remove this if you want to keep the default navigation ENABLED #}
{% set nav_disabled = true %}

{# If you decide to keep the default navigation ENABLED #}
{# Set a href link for the "skip navigation" button #}
{% set skip_nav_href = '#anchor' %}

{# ALWAYS INDENT CONTENT IN THE JINJA BLOCK BY 2 SPACES "  " #}

{# [OPTIONAL] Set a description for your page if NEEDED #}
{# Align atrributes underneath eachother like in the example #}
{% block page_description %}
  <meta name="description"
        content="Your page decription goes here!">
{%- endblock %}

{# [REQUIRED] Set a link for the stylesheet for your new page #}
{# It is the last stylesheet link in the <head> #}
{# Align atrributes underneath eachother like in the example #}
{% block stylesheets_extra %}
  <link rel="stylesheet"
        href="{{ url_for('static', filename='css/example.css') }}"/>
{%- endblock %}

{# [REQUIRED] Set a page title #}
{# Title text is used in the footer by default #}
{% block title -%}
  Example page title
{%- endblock %}

{# Write your attributes on the same line as the opening block #}
{# ALWAYS LEAVE 1 SPACE " " BETWEEN THE OPENING BLOCK AND FIRST ATTRIBUTE #}
{# DO NOT LEAVE ANY WHITESPACE BEFORE THE CLOSING BLOCK #}
{# [IMPORTANT] Check information on how to linewrap ONLY the closing block if needed #}
{% block header_attr %} class="example"{% endblock %}
{%- block footer_attr %} id="example"{% endblock %}

{# Set up additional navigation buttons if NEEDED, else REMOVE this block #}
{# Always add the class "nav-item" to all the buttons #}
{# Always add the class "nav-most-right" to the last/most right button #}
{# Available ONLY if default navigation is ENABLED #}
{% block nav_extra_buttons %}
{%- filter indent(width=8) %}
  <li class="nav-item">
    <a href="#anchor-one">
      Button1
    </a>
  </li>
  <li class="nav-item nav-most-right">
    <a href="#anchor-two">
      Button2
    </a>
  </li>
{%- endfilter %}
{%- endblock %}

{# Write your ADITIONAL <header> html here #}
{# DO NOT add the <header> tag #}
{# Available ONLY if default navigation is ENABLED #}
{% block header_extra %}
{% filter indent(width=4) %}
  <p>
    Extra header content
  </p>
{%- endfilter %}
{%- endblock %}

{# Write your <header> html here #}
{# ALWAYS add the <header> tag #}
{# Available ONLY if default navigation is DISABLED#}
{% block header %}
  <header>
    Example header content
  </header>
{% endblock header %}

{# Write your <main> html here #}
{# ALWAYS add the <main> tag #}
{% block main %}
  <main>
    <section>
      <p>
        Example main content one
      </p>
    </section>

    <section>
      <p>
        Example main content two
      </p>
    </section>
  </main>
{%- endblock main %}

{# Write your footer title here #}
{# By default it is the same as the text in the "title" block #}
{% block footer_title -%}
  {{ self.title() }}
{%- endblock %}

{# Write your ADITIONAL <footer> html here #}
{# DO NOT add the <footer> tag #}
{% block footer_extra %}
{% filter indent(width=4) %}
  <p>
    Extra footer content
  </p>
{%- endfilter %}
{%- endblock %}

{# Write your ADITIONAL <body> html here #}
{# DO NOT add the <body> tag #}
{%- block body_extra %}
{% filter indent(width=4) %}
  <p>
    Extra body content
  </p>
{%- endfilter %}
{% endblock %}

{# !!! REMOVE THIS BLOCK UNLESS !!! #}
{# You want to completely rework the default body content #}
{%- block body %}
{% endblock %}

{# !!! REMOVE THIS BLOCK UNLESS !!! #}
{# You want to disable/rework the default footer #}
{%- block footer %}
{% endblock %}
```

# **HOW TO MAKE AND SETUP A NEW HTML PAGE**

The whole page structure for the project is made with the help of [Jinja's](https://jinja.palletsprojects.com/en/3.1.x/templates/) template system!  
Every page in the project is an "extension" of the base template HTML file ("**base-main.html**").

*Located in:*

`rwdp\templates\pages\base\base-main.html`

The idea behind this is that we don't waste time rewriting code that will be reused in other files.

## **IMPORTANT NOTES:**

### 1. Jinja block indentation

- Always indent the content in the Jinja blocks by **2 spaces** ("&nbsp;&nbsp;")

  **IMPORTANT:**  
*If there is a filter block within the Jinja block **DO NOT** indent it!  
Indent only non Jinja content within the filter blocks!*

### 2. Whitespace control

- Jinja block tags are made with [whitespace control](https://jinja.palletsprojects.com/en/3.1.x/templates/#whitespace-control) in mind so it is important to write them as in the [examples](#example-page).

- Some blocks may have additional [filter blocks](https://jinja.palletsprojects.com/en/3.1.x/templates/#list-of-builtin-filters) within them to add indents, so the html looks nice and clean when the Jinja blocks are stripped. **Write your content between the filter blocks!**

**IMPORTANT:**
*Pay attention to the minus symbol ("-") in the Jinja blocks!*

|Symbol|Effect|
|:---:|:---|
|**-**|strips whitespace|
|**+**|preserves whitespace|

|Jinja block with whitespace control|Outcome|
|:---:|:---|
|`{%- block example ... %}`|strips before|
|`{%+ block example ... %}`|preserves before|
|`{%- block example ... -%}`|strips before and after|
|`{%+ block example ... -%}`|preserves before and strips after|

> *Although the code will work perfectly fine without **whitespace control** in mind, we should always strive to keep things clean and organized as much as we can.*

### 3. Useful tips

- If you are uncertain were a specific block "inserts" their content just by reading the examples, open up ("**base-main.html**") and look for that block with the same name and see where it is placed!

   **There cannot be 2 blocks with the same name!**

- For those unfamiliar with Jinja, Jinja blocks allow you to name the "closing block", but of course the name can ONLY be the same as the "opening block"!

   In the examples this is shown on Jinja blocks like "header" and "main", as it is expected of them to be one of the longer blocks in the page. So to not get confused by the same "closing blocks" we can name them with the same name we used for the "opening block".

## HOW TO BUILD A PAGE

Basic layout of the Jinja blocks, what they do and things to be aware of when setting things up.

### **1. Rendering the page**

Our website is build on the [Flask](https://flask.palletsprojects.com/en/2.2.x/) web framework. To [render a page](https://flask.palletsprojects.com/en/2.2.x/quickstart/#rendering-templates) go to the ("**main.py**") file and define the URL you want for the page along with the location of your page HTML file.

*Located in:*

`rwdp\main.py`

*Python code:*

```python
# Render a template
@app.route('/example-page-url')
def example_page():
    return render_template('example-page.html')
```

### **2. Building the child template**

Earlier we mentioned that pages are an "extension" of the [base template](https://jinja.palletsprojects.com/en/3.1.x/templates/#base-template) HTML file. We refer to these pages as [child templates](https://jinja.palletsprojects.com/en/3.1.x/templates/#child-template).

#### **2.1 Extend template**

---

"Extending" or in other words copying the content from the *base template* to our new *child template* is done with the `{% extends %}` Jinja tag.

**IMPORTANT:**  
\- *This MUST be the **first** tag in your child template*  
\- *Your BASE TEMPLATE **needs to be in the same folder or in a subfolder** from where your CHILD TEMPLATE is located.*

```jinja
{% extends "pages/base/base-main.html" %}
```

#### **2.2 Custom variables**

---

Custom Jinja variables each controlling specific page behaviours making them easier to manipulate and manage.

- ##### **Variable to disable the default navigation completely**

  If needed you can completely remove the default navigation by setting the `nav_disabled` variable to `true`.

  **This will:**  
  \- *disable all the HTML associated with the default navigation bar*  
  \- *remove the stylesheet link for the default navigation bar in the `<head>` tag*

  ```jinja
  {# Disables the default navigation bar #}
  {# Removes both its HTML and CSS #}

  {% set nav_disabled = true %}
  ```

- ##### **Variable to set the href link for the "skip navigation" button**

  If you decide to **KEEP** the default navigation bar you mustn't forget to set a href link for your hidden "skip navigation" button

  ```jinja
  {# Sets the href link for the "skip navigation" button #}

  {% set skip_nav_href = '#anchor' %}
  ```

  **NOTE:** *Only available if the default navigation is **ENABLED**.*

#### **2.3 List of all the EMPTY blocks**

---

Empty Jinja blocks as the name suggests have no predefined content in them. They are there **ONLY** to insert additional content on top of the existing one in the base template file.

**To keep things organized, blocks should be called/used in the same order in your child template as they are listed in the [example page structure](#example-structure-for-a-page)!**

- ##### Block "page_description"

  ---

  This block is OPTIONAL, but there if you need it!

  And as you may have guessed you can set a description for your page with it.

  **Align the attributes underneath eachother like in the example.**

  ```jinja
  {# Sets the description for your page if NEEDED #}
  {# Align atrributes underneath eachother like in the example #}

  {% block page_description %}
    <meta name="description"
          content="Your page decription goes here!">
  {%- endblock %}
  ```

- ##### Block "stylesheet_extra" (REQUIRED)

  ---

  **It is intended that every page that "extends" the base template page has its own separate CSS file, so that we keep things organized.**

  The base template page is build in a way that the stylesheet link for the child template is called **LAST** after all other stylesheet links!
  This is so that if you want to overwrite the default styling for your new page, you can easily do it!

  **Align the attributes underneath eachother like in the example.**

  **IMPORTANT:**  
  *The "stylesheets_extra" block in the base template page is defined as* [*required*](https://jinja.palletsprojects.com/en/3.1.x/templates/#required-blocks).

  **Meaning you MUST include this block and set up a stylesheet link!**

  ```jinja
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

  Set up a page title. The text in the page title is used for the ["footer_title"](#block-footer_title) block.

  **IMPORTANT:**  
  *The "title" block in the base template page is defined as* [*required*](https://jinja.palletsprojects.com/en/3.1.x/templates/#required-blocks).

  **Meaning you MUST include this block and set up a page title!**

  ```jinja
  {# [DEFINED AS REQUIRED] Sets the page title #}
  {# Title text is used in the footer by default #}

  {% block title -%}
    Example page title
  {%- endblock %}
  ```

- ##### Block "header"

  ---

  **This is the block for the `<header>` in the `<body>` tag!**

  In the base template page this block is completely EMPTY!
  It's only in the correct place, meaning you **MUST** add the `<header>` tag.

  ```jinja
  {# Write your <header> html here #}
  {# ALWAYS add the <header> tag #}

  {# Available ONLY if the default navigation is DISABLED #}

  {% block header %}
    <header>
      Example header content
    </header>
  {% endblock header %}
  ```

  **NOTE:** *Only available if the default navigation is **DISABLED**.*

- ##### Block "header_attr"

  ---

  The "header_attr" block is used **ONLY** to add attributes to the `<header>` tag. Useful if you want to apply different stylings for the specific page by using a different "id" and "classes" for every page.

  **IMPORTANT:**  
  \- *Always add **1 space** ("&nbsp;") before the first attribute*  
  \- *Write the attributes on the same line as the "opening block"*  
  \- *You can wrap ONLY the "closing block" but need to add "-" at the start of it (see examples)*

  ```jinja
  {# ALWAYS write your attributes on the same line as the opening block #}
  {# ALWAYS leave 1 space (" ") between the opening block and first attribute #}
  {# DO NOT leave any whitespace before the closing block #}

  {# Available ONLY if the default navigation is ENABLED #}

  {% block header_attr %} class="example" id="example"{% endblock %}
  ```

  ```jinja
  {# Example on how to wrap the closing block if the line gets too long #}
  {# DO NOT leave any whitespace before the closing block #}

  {% block header_attr %} class="example-one example-two" id="example-id"
  {%- endblock %}
  ```

  **NOTE:** *Only available if the default navigation is **ENABLED**.*

- ##### Block "header_extra"

  ---

  The "header_extra" block is for building on top of the existing content, so **DO NOT** include the `<header>` tag as it is already in it.

  ```jinja
  {# Write your ADITIONAL <header> html here #}
  {# DO NOT add the <header> tag #}

  {# Available ONLY if the default navigation is ENABLED #}

  {% block header_extra %}
  {% filter indent(width=4) %}
    <p>
      Extra header content
    </p>
  {%- endfilter %}
  {%- endblock %}
  ```

  **NOTE:** *Only available if the default navigation is **ENABLED**.*

- ##### Block "main"

  ---

  **This is the block for the `<main>` in the `<body>` tag!**

  In the base template page this block is completely EMPTY!
  It's only in the correct place, meaning you **MUST** add the `<main>` tag.

  ```jinja
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

- ##### Block "body_extra"

  ---

  The "body_extra" block is for building on top of the existing content, so **DO NOT** include the `<body>` tag as it is already in it.

  **This Jinja block is placed BETWEEN the `<footer>` and the `<scrip>` tags**

  ```jinja
  {# Write your ADITIONAL <body> html here #}
  {# DO NOT add the <body> tag #}

  {%- block body_extra %}
  {% filter indent(width=2) %}
    <p>
      Extra body content
    </p>
  {%- endfilter %}
  {%- endblock %}
  ```

- ##### Block "footer_attr"

  ---

  The "footer_attr" block is used **ONLY** to add attributes to the `<footer>` tag. Useful if you want to apply different stylings for the specific page by using a different "id" and "classes" for every page.

  **IMPORTANT:**  
  \- *Always add **1 space** ("&nbsp;") before the first attribute*  
  \- *Write the attributes on the same line as the "opening block"*  
  \- *You can wrap ONLY the "closing block" but need to add "-" at the start of it (see examples)*

  ```jinja
  {# ALWAYS write your attributes on the same line as the opening block #}
  {# ALWAYS leave 1 space (" ") between the opening block and first attribute #}
  {# DO NOT leave any whitespace before the closing block #}

  {%- block footer_attr %} class="example" id="example"{% endblock %}
  ```

  ```jinja
  {# Example on how to wrap the closing block if the line gets too long #}
  {# DO NOT leave any whitespace before the closing block #}

  {%- block footer_attr %} class="example-one example-two" id="example-id"
  {%- endblock %}
  ```

- ##### Block "footer_title"

  ---

  **By default, the footer title is the SAME as the page title defined in the ["title"](#block-title-required) block.**

  If you decide to change it **ONLY** write in plain text with no HTML tags.
  The "footer_title" block is encased in a `<p>` tag by default in the base template page.

  ```jinja
  {# Write your footer title here #}
  {# By default it is the same as the text in the "title" block #}

  {% block footer_title -%}
    {{ self.title() }}
  {%- endblock %}
  ```

- ##### Block "footer_extra"

  ---

  The "footer_extra" block is for building on top of the existing content, so **DO NOT** include the `<footer>` tag as it is already in it.

  ```jinja
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

#### **2.4 List of all the FULL blocks**

---

**IMPORTANT:**  
*These blocks already have HTML written in them so if you call them EMPTY you will essentially **erase** all of their original contents!*

But if you desire to completely rework them the option is there.

**NOTE:** *In some cases with the Jinja `{{ super() }}` block you can copy the original content of the block. So you can add additional content while preserving the original. [Read more about the Jinja super blocks.](https://jinja.palletsprojects.com/en/3.1.x/templates/#super-blocks)*

- ##### Block "nav_extra_buttons"

  ---

  If you decide to **KEEP** the navigation bar you mustn't forget to set up extra buttons **IF NEEDED**, as it will only have a non-static HOME ("return to index") button and the **always present static About and GitHub buttons!**

  - Position of the HOME button:

    \- **most left/first button** when placed between the `{% block nav_extra_buttons %}` and the `{%- filter indent(width=8) %}` opening blocks  
    *([default position](#example-1-default))*

    \- **most right/last button** when placed between the `{%- endfilter %}` and the `{%- endblock %}` closing blocks  
    *([See example 1](#example-1-default))*

    \- **between other button** when placed between separate filter blocks  
    *([See example 2](#example-2-between))*

    You can remove the HOME button if you remove the `{{ super() }}` block.

  - Button highlighting

    To enable button highlighting for buttons that link to other pages of the site add `class="{{ 'active' if request.path == url_for('example_page') }}"` to their `<a>` tags.  
    *([See example 3](#example-3-highlight))*

  **RECOMMENDED:**  
  Add no more than 2 buttons with not so many characters in them as it will cause overflow on high zoom in & small screen widths!

  > *Of course, you can add as many buttons as you like, but you will have to adjust/overwrite the CSS for the default navigation so that everything looks nice and in place!*

  **IMPORTANT:**  
  *Always add `class="nav-item"` to all the `<li>` tags.*

  ---

  ###### *Example 1 (default)*

  Default layout of the "nav_extra_buttons" block.

  > **DO NOT** *call/use this block EMPTY unless you want to COMPLETELY **remove** all the default non-static buttons.*

  ```jinja
  {# Set up additional navigation buttons if NEEDED, else REMOVE this block #}
  {# ALWAYS add the class "nav-item" to all the buttons #}
  {# DO NOT put the super block inside filter blocks #}

  {# Available ONLY if the default navigation is ENABLED #}

  {% block nav_extra_buttons %}
    {{- super() }} {#- Default HOME button. Remove if not needed #}
  {%- filter indent(width=8) %}
    <li class="nav-item">
      <a href="#anchor-one">
        Button1
      </a>
    </li>
    <li class="nav-item">
      <a href="#anchor-two">
        Button2
      </a>
    </li>
  {%- endfilter %}
  {#- Add the super block here if you want the default HOME button to be last #}
  {%- endblock %}
  ```

  ---

  ###### *Example 2 (between)*

   If you want the HOME button placed between other buttons you will need to encase the other buttons in filter blocks and place the `{{ super() }}` block **between** the filter blocks.

  > **DO NOT** *put the `{{ super() }}` block inside filter blocks as it will create [whitespace](#2-whitespace-control).*

  ```jinja
  {# Set up additional navigation buttons if NEEDED, else REMOVE this block #}
  {# ALWAYS add the class "nav-item" to all the buttons #}
  {# DO NOT put the super block inside filter blocks #}

  {# Available ONLY if the default navigation is ENABLED #}

  {% block nav_extra_buttons %}
  {%- filter indent(width=8) %}
    <li class="nav-item">
      <a href="#anchor-one">
        Button1
      </a>
    </li>
  {%- endfilter %}
    {{- super() }} {#- Default HOME button #}
  {%- filter indent(width=8) %}
    <li class="nav-item">
      <a href="#anchor-two">
        Button2
      </a>
    </li>
  {%- endfilter %}
  {%- endblock %}
  ```

  ---

  ###### *Example 3 (highlight)*

  To enable button highlighting for buttons that link to other pages of the site add `class="{{ 'active' if request.path == url_for('example_page') }}"` to their `<a>` tags.

  The button will highlight when the [page](#1-rendering-the-page) you put in the `url_for('') }}` is rendered/opened.

  In the example **Button2** will be highlighted when the *example_page* is rendered/opened.

  **RECOMMENDED:**  
  Although not necessary for the highlighting to work (as it only checks if the page is rendered/opened), **it is recommended that the href of the button where highlighting is used, links to the same page**.

  ```jinja
  {# Set up additional navigation buttons if NEEDED, else REMOVE this block #}
  {# ALWAYS add the class "nav-item" to all the buttons #}
  {# DO NOT put the super block inside filter blocks #}

  {# Available ONLY if the default navigation is ENABLED #}

  {% block nav_extra_buttons %}
    {{- super() }} {#- Default HOME button #}
  {%- filter indent(width=8) %}
    <li class="nav-item">
      <a href="#anchor-one">
        Button1
      </a>
    </li>
    {#- Navigation button with highlight #}
    {#- Don't forget to change the URL #}
    <li class="nav-item">
      <a class="{{ 'active' if request.path == url_for('index') }}"
      href="{{ url_for('index') }}">
        Button2
      </a>
    </li>
  {%- endfilter %}
  {%- endblock %}
  ```

  **NOTE:** *Only available if the default navigation is **ENABLED**.*

- ##### Block "body"

  ---

  The `<body>` is encased in a "body" Jinja block. In it is **ALL** the default body content of the base template page! Calling this block EMPTY will basically make an empty page with only the content in the `<head>` tag intact!

  **IMPORTANT:**  
  *The `<script>` tags are at the bottom of the `<body>` tag and will also be REMOVED if you call/use this block EMPTY!*

  > **DO NOT** *call/use this block EMPTY unless you want to COMPLETELY **overwrite and rework** all the content in it. (`<body>`, `<header>`, `<main>`, `<footer>`)*

  ```jinja
  {# ONLY add if you want to completely rework the default body content #}
  {# ALWAYS add the <body> tag #}

  {%- block body -%}
    <body>
      New body content
    </body>
  {%- endblock %}
  ```

  **NOTE:** *The `<body>` tag is encased in a "body" Jinja block, so using the `{{ super() }}` block and adding additional content will result in that content being outside the `<body>` tag.*

   Use of the Jinja `{{ super() }}` block is **not adviced**!

- ##### Block "footer"

  ---

  The `<footer>` is encased in a "footer" Jinja block. In it is **ALL** the default footer content of the base template page!

  > **DO NOT** *call/use this block EMPTY unless you want to **disable** the default footer or COMPLETELY **overwrite and rework** all the content in it. (`<footer>`)*

  ```jinja
  {# ONLY add if you want to disable/rework the default footer #}
  {# ALWAYS add the <footer> tag #}

  {%- block footer %}
  {%- filter indent(width=2) -%}
    <footer>
      New footer content
    </footer>
  {%- endfilter %}
  {%- endblock %}
  ```

  **NOTE:** *The `<footer>` tag is encased in a "footer" Jinja block, so using the `{{ super() }}` block and adding additional content will result in that content being outside the `<footer>` tag.*

   Use of the Jinja `{{ super() }}` block is **not adviced**!

## EXAMPLE PAGE

### General information about the Jinja & HTML blocks/tags used for creating a page

|Call/Use order|Marked as|Type|Name/Attribute|Parent Jinja & HTML blocks/tags|
|:---:|:---:|:---:|:---|:---:|
|0|-|extends|path to base template|-|
|1|-|custom variable|"nav_disabled"|-|
|2|-|custom variable|"skip_nav_href"|`<header>`|
|3|OPTIONAL|block|"page_description"|-|
|4|REQUIRED|block|"stylesheets_extra"|-|
|5|REQUIRED|block|"title"|-|
|6|-|block|"body"|-|
|7|-|block|"header"|"body"|
|8|-|block|"header_attr"|`<header>`|
|9|-|block|"nav_extra_buttons"|`<header>`|
|10|-|block|"header_extra"|`<header>`|
|11|-|block|"main"|"body"|
|12|-|block|"body_extra"|"body"|
|13|-|block|"footer"|"body"|
|14|-|block|"footer_attr"|"footer"|
|15|-|block|"footer_title"|"footer"|
|16|-|block|"footer_extra"|"footer"|

If `nav_disabled = true` all Jinja blocks/tags with a parent HTML tag `<header>` are **DISABLED/ERASED** and the ["header"](#block-header) Jinja block becomes available where you can create a new `<header>`.

If any of the parent Jinja & HTML blocks/tags is called/used **EMPTY** all of their child/grandchild Jinja blocks/tags will be **DISABLED/ERASED** and would have to be completely recreated.

### Block/tag hierarchy

|Parent|Children|Grandchildren|
|:---:|:---|:---|
|"body"|`<header>`, "header", "main", "footer", "body_extra"|"skip_nav_href", "header_attr", "nav_extra_buttons", "header_extra", "footer_attr", "footer_title", "footer_extra"|
|`<header>`|"skip_nav_href", "header_attr", "nav_extra_buttons", "header_extra"|-|
|"footer"|"footer_attr", "footer_title", "footer_extra"|-|

**IMPORTANT:**  
*Blocks should be called/used in the same order & written as shown in the example for consistency and whitespace control across all the pages.*

### Example structure for a page

```jinja
{% extends "pages/base/base-main.html" %}

{# REMOVE this if you want to keep the default navigation ENABLED #}
{# REMOVE if you decide to use the "body" block #}
{% set nav_disabled = true %}

{# If you decide to keep the default navigation ENABLED #}
{# Set a href link for the "skip navigation" button #}
{# REMOVE if you decide to use the "body" block #}
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

{# !!! [REMOVE THIS BLOCK UNLESS] !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #}
{# You want to completely rework the default body content #}
{# REMOVE every child/grandchild Jinja block if you decide to use it #}
{# Or in other words remove every Jinja block BELOW it #}
{# ALWAYS add the <body> tag #}
{%- block body -%}
  <body>
    New body content
  </body>
{%- endblock %}

{# Available ONLY if the default navigation is DISABLED !!!!!!!!!!!!! #}
{# Write your <header> html here #}
{# ALWAYS add the <header> tag #}
{% block header %}
  <header>
    New header content
  </header>
{% endblock header %}

{# Available ONLY if the default navigation is ENABLED !!!!!!!!!!!!!! #}
{# ALWAYS write your attributes on the same line as the opening block #}
{# ALWAYS leave 1 space (" ") between the opening block and first attribute #}
{# DO NOT leave any whitespace before the closing block #}
{# [IMPORTANT] Check information on how to linewrap ONLY the closing block if NEEDED #}
{% block header_attr %} class="example"{% endblock %}

{# Available ONLY if the default navigation is ENABLED !!!!!!!!!!!!!! #}
{# Set up additional navigation buttons if NEEDED, else REMOVE this block #}
{# ALWAYS add the class "nav-item" to all the buttons #}
{# DO NOT put the super block inside filter blocks #}
{% block nav_extra_buttons %}
  {{- super() }} {#- Default HOME button. Remove if not needed #}
{%- filter indent(width=8) %}
  <li class="nav-item">
    <a href="#anchor-one">
      Button1
    </a>
  </li>
  {#- Navigation button with highlight #}
  {#- Don't forget to change the URL #}
  <li class="nav-item">
    <a class="{{ 'active' if request.path == url_for('index') }}"
    href="{{ url_for('index') }}">
      Button2
    </a>
  </li>
{%- endfilter %}
{#- Add the super block here if you want the default HOME button to be last #}
{%- endblock %}

{# Available ONLY if the default navigation is ENABLED !!!!!!!!!!!!!! #}
{# Write your ADITIONAL <header> html here #}
{# DO NOT add the <header> tag #}
{% block header_extra %}
{% filter indent(width=4) %}
  <p>
    Extra header content
  </p>
{%- endfilter %}
{%- endblock %}

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

{# Write your ADITIONAL <body> html here #}
{# DO NOT add the <body> tag #}
{%- block body_extra %}
{% filter indent(width=2) %}
  <p>
    Extra body content
  </p>
{%- endfilter %}
{%- endblock %}

{# !!! [REMOVE THIS BLOCK UNLESS] !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #}
{# You want to disable/rework the default footer content #}
{# REMOVE every child/grandchild Jinja block if you decide to use it #}
{# Or in other words remove every Jinja block BELOW it #}
{# ALWAYS add the <footer> tag #}
{%- block footer %}
{%- filter indent(width=2) -%}
  <footer>
    New footer content
  </footer>
{%- endfilter %}
{%- endblock %}

{# ALWAYS write your attributes on the same line as the opening block #}
{# ALWAYS leave 1 space (" ") between the opening block and first attribute #}
{# DO NOT leave any whitespace before the closing block #}
{# [IMPORTANT] Check information on how to linewrap ONLY the closing block if NEEDED #}
{%- block footer_attr %} class="example" id="example"{% endblock %}

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
```

**NOTE:** *When a **parent** is called/used its **children/grandchildren** should not be called/used as they will not do/change anything. Check the [block/tag hierarchy](#blocktag-hierarchy).*

## **FINAL NOTES:**

These instructions are for the features of Flask & Jinja that were used for the creation of the pages for this project! Giving you a better understanding of how the project is structured and meant to work.

**This is not an in-dept guide!**

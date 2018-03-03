<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:exsl="http://exslt.org/common"
    xmlns:str="http://exslt.org/strings"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="exsl str date">
<xsl:output method="html" indent="yes"
  encoding="UTF-8"
  doctype-system="about:legacy-compat"
  doctype-public="html" />

<xsl:template match="testsuites">
<html lang="en">
  <head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />

    <title>Pulp PHPUnit Output Template</title>

    <!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />

  </head>

  <body>

    <header>
      <div class="navbar navbar-dark bg-dark box-shadow">
        <div class="container d-flex">
          <a href="#" class="navbar-brand d-flex align-items-center">
            PHPUnit&#160;<strong>Results</strong>
          </a>
        </div>
      </div>
    </header>

    <main role="main">

      <section class="jumbotron text-center">
        <div class="container">

          <h1 class="jumbotron-heading">Test Results</h1>
		  <p class="">
		 <xsl:attribute name="class">
			<xsl:choose>
			   <xsl:when test="sum(/testsuites/testsuite/@failures)">
					lead text-muted alert alert-danger
				</xsl:when>
			   <xsl:otherwise>lead text-muted</xsl:otherwise>
			</xsl:choose>
		  </xsl:attribute>
			  Failures: <xsl:value-of select="sum(/testsuites/testsuite/@failures)"/></p>
		  <p class="">
		 <xsl:attribute name="class">
			<xsl:choose>
			   <xsl:when test="sum(/testsuites/testsuite/@errors)">
					lead text-muted alert alert-danger
				</xsl:when>
			   <xsl:otherwise>lead text-muted</xsl:otherwise>
			</xsl:choose>
		  </xsl:attribute>

			Errors: <xsl:value-of select="sum(/testsuites/testsuite/@errors)"/></p>
		  <p class="lead text-muted"><xsl:value-of select="count(/testsuites/testsuite/testsuite/testcase)"/> test cases, <xsl:value-of select="sum(/testsuites/testsuite/testsuite/@assertions)"/> assertions</p>
        </div>
      </section>

      <div class="album py-5 bg-light">
        <div class="container">

          <div class="row">
			  <xsl:apply-templates select="//failure"/>
			  <xsl:apply-templates select="//error"/>
          </div>
        </div>
      </div>

    </main>

    <footer class="text-muted">
      <div class="container">
        <p class="float-right">
          <a href="#">Back to top</a>
        </p>
      </div>
    </footer>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('&lt;script src="../../../../assets/js/vendor/jquery-slim.min.js"&gt;&lt;\/script&gt;')</script>

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script type="text/javascript"  src="http://localhost:35729/livereload.js"></script>
  </body>
</html>
</xsl:template>

<xsl:template match="failure">
    <xsl:call-template name="display-failures"/>
</xsl:template>

<xsl:template match="error">
    <xsl:call-template name="display-failures"/>
</xsl:template>

<xsl:template name="display-failures">
            <div class="col-md-6">
              <div class="card mb-6 box-shadow">
                <div class="card-body">
				<code>
				<pre>
				<xsl:value-of
						select="string(.)"
						disable-output-escaping="yes"/>
				</pre>
				</code>
    		    </div>
  		      </div>
  		    </div>
</xsl:template>


</xsl:stylesheet>

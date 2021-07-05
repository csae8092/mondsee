<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="2.0">
    
    <xsl:import href="nav_bar.xsl"/>
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Mondsee Scriptorium</title>
                <link rel="stylesheet" type="text/css" href="css/mondsee.css"/>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" />
            </head>
            
            <body>
                <xsl:call-template name="nav_bar"/>
                <div class="container">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">Shelfmark</th>
                                <th scope="col">Title</th>
                                <th scope="col">Date</th>
                                <th scope="col">Date</th>
                                <th scope="col">Place</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="collection('../data/descriptions')//tei:TEI">
                                <xsl:variable name="full_path">
                                    <xsl:value-of select="document-uri(/)"/>
                                </xsl:variable>
                                <tr>
                                    <td>                                        
                                        <a>
                                            <xsl:attribute name="href">                                                
                                                <xsl:value-of select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="..//tei:fileDesc/tei:titleStmt/tei:title"/>
                                        </a>
                                    </td>
                                    <td>
                                        <xsl:value-of select="..//tei:msDesc/tei:head/tei:title"/>
                                    </td>
                                    <td>
                                        <xsl:apply-templates select="..//tei:msDesc/tei:head/tei:origDate/@notBefore"/><xsl:text>-</xsl:text>
                                        <xsl:apply-templates select="..//tei:msDesc/tei:head/tei:origDate/@notAfter"/>
                                    </td>
                                    <td>
                                        <xsl:apply-templates select="..//tei:msDesc/tei:head/tei:origDate"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="..//tei:msDesc/tei:head/tei:origPlace"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
                <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" />
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" />
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" />
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    <xsl:template match="tei:hi[@rend = 'sup']">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
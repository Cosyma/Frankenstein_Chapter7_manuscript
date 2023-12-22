<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" /> -->
    <xsl:template match="tei:teiHeader"/>

    <xsl:template match="tei:body">
        <div class="row">
        <div class="col-3"><br/><br/><br/><br/><br/>
            <xsl:for-each select="//tei:add[@place = 'marginleft']">
                <xsl:choose>
                    <xsl:when test="parent::tei:del">
                        <del>
                            <xsl:attribute name="class">
                                <xsl:value-of select="attribute::hand" />
                            </xsl:attribute>
                            <xsl:value-of select="."/></del><br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span >
                            <xsl:attribute name="class">
                                <xsl:value-of select="attribute::hand" />
                            </xsl:attribute>
                        <xsl:value-of select="."/><br/>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each> 
        </div>
        <div class="col-9"> 
            <div class="transcription">
                <xsl:apply-templates select="//tei:div"/>
            </div>
        </div>
        </div>    
    </xsl:template>
    

 
    
    <xsl:template match="tei:text">
        <text class="#MWS"><xsl:apply-templates/></text>
    </xsl:template>
    <xsl:template match="tei:text">
        <text class="#PBS"><xsl:apply-templates/></text>
    </xsl:template>
     
    <xsl:template match="tei:add[@hand ='#MWS']">
        <add class="#MWS"><xsl:apply-templates/></add>
    </xsl:template>
    <xsl:template match="tei:add[@hand = '#PBS']">
        <add class="#PBS"><xsl:apply-templates/></add>
    </xsl:template>
    
    <xsl:template match="tei:del[@hand ='#MWS']">
        <add class="#MWS"><xsl:apply-templates/></add>
    </xsl:template>
    <xsl:template match="tei:del[@hand = '#PBS']">
        <add class="#PBS"><xsl:apply-templates/></add>
    </xsl:template>
    <xsl:template match="tei:div">
        <div class="#MWS"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:div">
        <div class="#PBS"><xsl:apply-templates/></div>
    </xsl:template>
    <!-->   
    <xsl:template match="tei:add[@hand ='#MWS']">
        <span class="MWS" >
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:add[@hand = '#PBS']">
        <span class="MWS" >
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:del[@hand = '#MWS']">
        <span class="MWS" >
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:del[@hand = '#PBS']">
        <span class="MWS" >
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <-->     
 
    <xsl:template match="tei:p">
        <p style="
            text-indent:15px;
            font-family: Arial, Helvetica, sans-serif;
            line-height: 200%;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:add[@place = 'marginleft']">
        <span class="marginAdd" >
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
 
    <!-- all the supralinear additions are given in a span with the class supraAdd, 
        make sure to put this class in superscript in the CSS file, -->
    <xsl:template match="tei:add[@place = 'supralinear']">
        <!-->add class to span has the class name add <-->
        <span class="supraAdd">  
            <xsl:apply-templates/>
        </span>  
    </xsl:template>
    
    <xsl:template match="tei:del[@type ='crossedOut']">
        <span class="crossedOut" >
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--tei:lb in <br/> empty elements,-->
    
    <xsl:template match="tei:l">
        <span style="
            display: inline;">
            <xsl:apply-templates/>
        </span>
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <span style="
            display: inline;">
            <xsl:apply-templates/>
        </span>
        <br/>
    </xsl:template>
    
    <!--tei:hi[@rend = 'sup'] in <sup> elements, the underlined text,-->
    <xsl:template match="tei:hi[@rend = 'sup']">
        <span class="sup" style="
            display: inline-block; 
            position: relative;
            bottom: 50%;
            transform: translateY(-40%);            
            font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'u']">
        <span class = "underline" style='
            text-decoration: underline
            '>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'underlinear']">
        <span class = "underlinear" 
            style='display: inline-block; 
            position: relative;
            transform: translateY(30%);            
            font-style: italic;
            letter-spacing: -500px;'>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--﻿the circled page number on the manuscript page-->
    <xsl:template match="tei:hi[@rend = 'circled']">
        <span style="
            color:white; 
            position: absolute;
            top: 0;
            right: 10px;
            border-radius: 40%;
            border: 2px solid white;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--additions with the attribute "overwritten" etc. -->
    <xsl:template match="tei:add[@place = 'overwritten']">
        <span class="overAdd" style="font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>  
    

</xsl:stylesheet>

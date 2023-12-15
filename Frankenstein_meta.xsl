<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    

    <!-- <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" /> -->
 
    <xsl:template match="tei:TEI">
         <div class="row">
             <div class="col-6">
                 <h4>About the manuscript page:</h4>
                 <p><xsl:value-of select="//tei:sourceDesc"/></p>
                 <p><i><xsl:value-of select="//tei:licence"/></i></p>
                 <!-- You can change the way the metadata is visualised as well-->
             </div>
             <div class="col-3">
                 <h4> Manuscript page summary:</h4>
                <ul> 
                    <li>Total number of modifications: 
                        <!-- Counts all the add and del elements, and puts it in a list item -->
                        <xsl:value-of select="count(//tei:del|//tei:add)" /> 
                    </li>
                    
                    <li><!-- count the additions only -->
                        Number of additions: 
                        <xsl:value-of select="count(//tei:add)" /> 
                    </li>
                    <!-- add other list items in which you count things -->
                    <li>
                        Number of deletions: 
                        <xsl:value-of select="count(//tei:del)" />
                    </li>
                    
                    <li>
                        Corrections by Mary Shelley:
                        <xsl:value-of select="count(//tei:add[@hand='#MWS']|//tei:del[@hand='#MWS'])"/>
                    </li>
                    
                    <li>
                        Corrections by ﻿Percy Shelley:
                        <xsl:value-of select="count(//tei:add[@hand='#PBS']|//tei:del[@hand='#PBS'])"/>
                    </li> 
                   
                </ul>
            </div>
            <div class="col-3 bg-dark">
               <h4> Modifications by writer:</h4>
                <div class="form-group">
                    <select class="form-control" id="sel-hand" onChange="selectHand(event)">
                        <option value="both">Both Hands</option>
                        <option value="Mary">Mary Shelley's Hand Highlighted</option>
                        <option value="Percy">Percy Shelley's Hand Highlighted</option>
                        <option onclick="toggleDeletions()">Toggle Deletions</option>
                    </select>
                </div>
            </div>
         </div>
        <hr/>
    </xsl:template>
 
    <!-- Add a parameter to the template to receive the selected hand -->
    <xsl:param name="selectedHand" />
    
    <!-- Modify the template to use the selected hand parameter -->
    <xsl:template match="tei:add[@hand='#MWS']|tei:del[@hand='#MWS']">
        <span style="color: red">
            <!-- Use xsl:if to conditionally apply color based on the selected hand -->
            <xsl:if test="$selectedHand = 'Mary'">
                <xsl:attribute name="style">color: purple</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:add[@hand='#PBS']|tei:del[@hand='#PBS']">
        <span style="color: blue">
            <!-- Use xsl:if to conditionally apply color based on the selected hand -->
            <xsl:if test="$selectedHand = 'Percy'">
                <xsl:attribute name="style">color: yellow</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
        <br/>
    </xsl:template>
    
    
</xsl:stylesheet>



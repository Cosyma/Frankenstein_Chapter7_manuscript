// Declare variables for getting the xml file for the XSL transformation (folio_xml) and to load the image in IIIF on the page in question (number).
let tei = document.getElementById("folio");
let tei_xml = tei.innerHTML;
let extension = ".xml";
let folio_xml = tei_xml.concat(extension);
let page = document.getElementById("page");
let pageN = page.innerHTML;
let number = Number(pageN);

// Loading the IIIF manifest
var mirador = Mirador.viewer({
  "id": "my-mirador",
  "manifests": {
    "https://iiif.bodleian.ox.ac.uk/iiif/manifest/53fd0f29-d482-46e1-aa9d-37829b49987d.json": {
      provider: "Bodleian Library, University of Oxford"
    }
  },
  "window": {
    allowClose: false,
    allowWindowSideBar: true,
    allowTopMenuButton: false,
    allowMaximize: false,
    hideWindowTitle: true,
    defaultView: 'single',
    panels: {
      info: false,
      attribution: false,
      canvas: true,
      annotations: false,
      search: false,
      layers: false,
    },
    views: [
      { key: 'single', behaviors: ['individuals', 'paged'] },
      ],
  },
  "workspaceControlPanel": {
    enabled: false,
  },
  "windows": [{
      loadedManifest: "https://iiif.bodleian.ox.ac.uk/iiif/manifest/53fd0f29-d482-46e1-aa9d-37829b49987d.json",
      canvasIndex: pageN,
      thumbnailNavigationPosition: 'off'
    }],
    
   selectedTheme: 'dark',
 
});




  
  




// function to transform the text encoded in TEI with the xsl stylesheet "Frankenstein_text.xsl", 
// this will apply the templates and output the text in the html <div id="text">
function documentLoader() {

    Promise.all([
      fetch(folio_xml).then(response => response.text()),
      fetch("Frankenstein_text.xsl").then(response => response.text())
    ])
    .then(function ([xmlString, xslString]) {
      var parser = new DOMParser();
      var xml_doc = parser.parseFromString(xmlString, "text/xml");
      var xsl_doc = parser.parseFromString(xslString, "text/xml");

      var xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl_doc);
      var resultDocument = xsltProcessor.transformToFragment(xml_doc, document);

      var criticalElement = document.getElementById("text");
      criticalElement.innerHTML = ''; // Clear existing content
      criticalElement.appendChild(resultDocument);
    })
    .catch(function (error) {
      console.error("Error loading documents:", error);
    });
  }
  
// function to transform the metadate encoded in teiHeader with the xsl stylesheet "Frankenstein_meta.xsl", 
// this will apply the templates and output the text in the html <div id="stats">
function statsLoader() {

    Promise.all([
      fetch(folio_xml).then(response => response.text()),
      fetch("Frankenstein_meta.xsl").then(response => response.text())
    ])
    .then(function ([xmlString, xslString]) {
      var parser = new DOMParser();
      var xml_doc = parser.parseFromString(xmlString, "text/xml");
      var xsl_doc = parser.parseFromString(xslString, "text/xml");

      var xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl_doc);
      var resultDocument = xsltProcessor.transformToFragment(xml_doc, document);

      var criticalElement = document.getElementById("stats");
      criticalElement.innerHTML = ''; // Clear existing content
      criticalElement.appendChild(resultDocument);
    })
    .catch(function (error) {
      console.error("Error loading documents:", error);
    });
  }

// Initial document load
documentLoader();
statsLoader();
  
  function changeFolio(folioValue) {
    // Update the content of the h2 element with the selected folio value
    document.getElementById('folio').innerText = folioValue;
  }


function handleButtonClick(clickedButtonId) {
    // Disable all buttons
    disableAllButtons();

    // Implement the functionality for the clicked button
    console.log("Button clicked:", clickedButtonId);
    // Add your specific functionality for the clicked button here

    // Enable only the clicked button
    document.getElementById(clickedButtonId).disabled = false;
}

function disableAllButtons() {
    // Disable all buttons
    var buttons = document.getElementsByTagName("button");
    for (var i = 0; i < buttons.length; i++) {
        buttons[i].disabled = true;
    }
}


// Modify your existing JavaScript code
/*
// Add an event listener to each dropdown item
document.addEventListener('DOMContentLoaded', function() {
document.getElementById('xml21v').addEventListener('click', function () {
  console.log('Clicked on 21v');
  changeXmlPath('../Frankenstein_Chapter7_manuscript/21v.xml');
});
});

document.getElementById('xml22r').addEventListener('click', function () {
  changeXmlPath('../Frankenstein_Chapter7_manuscript/22r.xml');
});

// Modify the changeXmlPath function to load content dynamically
function changeXmlPath(newPath) {
console.log('Changing XML path to:', newPath);

  // Add your code to dynamically load content based on the new XML path
  $.ajax({
    url: newPath,
    type: 'GET',
    dataType: 'xml',
    success: function(data) {
    console.log('XML loaded successfully');
      // Parse and process the XML data
      // Update the content in the 'text' div or any other appropriate element
      $('#text').html($(data).find('body').text());
    },
    error: function(error) {
      console.log('Error loading XML:', error);
    }
  });
}


  // Event listener for sel1 change
document.getElementById('yourSelectElementId').addEventListener('change', selectHand);
// Add your JavaScript code here to dynamically load content from XML files
$(document).ready(function() {
   // Example using jQuery Ajax
   $.ajax({
     url: 'path/to/21r.xml', // Replace with the actual path to your XML file
     type: 'GET',
     dataType: 'xml',
     success: function(data) {
       // Parse and process the XML data
       // Update the content in the 'text' div or any other appropriate element
       $('#text').html($(data).find('your-xml-element-selector').text());
     },
     error: function(error) {
       console.log('Error loading XML:', error);
     }
   });
});
*/

function selectHand(event) {
    
  var visible_mary = document.getElementsByClassName('#MWS');
  var visible_percy = document.getElementsByClassName('#PBS');
  // Convert the HTMLCollection to an array for forEach compatibility
  var MaryArray = Array.from(visible_mary);
  var PercyArray = Array.from(visible_percy);
    if (event.target.value == 'both') {
    //write an forEach() method that shows all the text written and modified by both hand (in black?). 
    // The forEach() method of Array instances executes a provided function once for each array element.
        MaryArray.forEach(function(element){
            element.style.color='white';
        });
        PercyArray.forEach(function(element){
            element.style.color='white';
        });
    } else if (event.target.value == 'Mary') {
     //write an forEach() method that shows all the text written and modified by Mary in a different color (or highlight it) and the text by Percy in black. 
        MaryArray.forEach(function(element){
            element.style.color='white';
        });
        PercyArray.forEach(function(element){
            element.style.color='#555';
        });
    } else {
     //write an forEach() method that shows all the text written and modified by Percy in a different color (or highlight it) and the text by Mary in black.
        MaryArray.forEach(function(element){
            element.style.color='#555';
        });
        PercyArray.forEach(function(element){
            element.style.color='white';
        });
    }
  } 

// write another function that will toggle the display of the deletions by clicking on a button
// Function to toggle the display of deletions

/*  function toggleVisibility() {
  // Get all elements with the class "del"
  const dataItems = document.querySelectorAll('del');
  // Convert the HTMLCollection to an array for forEach compatibility
  const dataItemsArray = Array.from(dataItems);
  // Toggle visibility of the numbers
  dataItemsArray.forEach(item => {
    item.style.display = item.style.display === 'none' ? '' : 'none';
  });
}*/


function toggleVisibility() {
  // Get all elements with the class "crossedOut"
  const crossedOutItems = document.querySelectorAll('.crossedOut');

  // Toggle visibility of the crossed out items
  crossedOutItems.forEach(item => {
    item.style.display = item.style.display === 'none' ? '' : 'none';
  });
}



// EXTRA: write a function that will display the text as a reading text by clicking on a button or another dropdown list, 
// meaning that all the deletions are removed and that the additions are shown inline (not in superscript)
 let readingMode = false;

  function toggleReadingText() {
  const delElements = document.querySelectorAll('.crossedOut');
  const addElements = document.querySelectorAll('span.supraAdd');
  const metamarkElements = document.querySelectorAll('.underlinear');
  
  if (readingMode) {
        // If in reading mode, show deleted elements and replace supralinear additions
        delElements.forEach(element => {
            element.style.display = '';
        }); 
        addElements.forEach(element => {
           // element.style.color = 'white';
            element.style.display = '';
            element.classList.add('supralinear'); 
        });
        metamarkElements.forEach(element => {
            element.style.display = '';
            element.classList.add('underlinear'); 
        });

    } else {
        // If not in reading mode, hide deleted elements and revert supralinear additions
        delElements.forEach(element => {
            element.style.display = 'none';
        });
        addElements.forEach(element => {
            element.style.display = 'inline';
        });
        metamarkElements.forEach(element => {
            element.style.display = 'none';
        });
        
    }

    readingMode = !readingMode; // Toggle reading mode
}












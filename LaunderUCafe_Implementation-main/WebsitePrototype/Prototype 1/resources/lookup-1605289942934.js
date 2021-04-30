(function(window, undefined) {
  var dictionary = {
    "60d07a2f-3536-4253-9f0f-1b7d3aac4cdb": "Sign-up Page",
    "280f95a4-ccde-4600-be92-af631fa0845a": "HomeDelivery",
    "d12245cc-1680-458d-89dd-4f0d7fb22724": "Home Page",
    "3b623da9-3b19-45c9-9d85-2b79d42159a8": "Login Page",
    "f39803f7-df02-4169-93eb-7547fb8c961a": "Template 1",
    "bb8abf58-f55e-472d-af05-a7d1bb0cc014": "default"
  };

  var uriRE = /^(\/#)?(screens|templates|masters|scenarios)\/(.*)(\.html)?/;
  window.lookUpURL = function(fragment) {
    var matches = uriRE.exec(fragment || "") || [],
        folder = matches[2] || "",
        canvas = matches[3] || "",
        name, url;
    if(dictionary.hasOwnProperty(canvas)) { /* search by name */
      url = folder + "/" + canvas;
    }
    return url;
  };

  window.lookUpName = function(fragment) {
    var matches = uriRE.exec(fragment || "") || [],
        folder = matches[2] || "",
        canvas = matches[3] || "",
        name, canvasName;
    if(dictionary.hasOwnProperty(canvas)) { /* search by name */
      canvasName = dictionary[canvas];
    }
    return canvasName;
  };
})(window);
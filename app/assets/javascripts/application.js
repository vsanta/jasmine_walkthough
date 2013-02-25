// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jasmine
//= require jasmine-html
//= require_tree .

(function() {
    var jasmineEnv = jasmine.getEnv();
    jasmineEnv.updateInterval = 1000;

    var reporter = new jasmine.TrivialReporter();
    var reporterTap = new jasmine.TapReporter();

    jasmineEnv.addReporter(reporter);
    jasmineEnv.addReporter(reporterTap);

    jasmineEnv.specFilter = function(spec) {
        return reporter.specFilter(spec);
    };

    var _codemirrorOptions =  {
        value: "",
        mode: 'javascript',
        lineNumbers: true,
        readOnly: false
    };
    var srcText = CodeMirror.fromTextArea($("#src_text").get(0), _codemirrorOptions);
    srcText.setOption("theme", "monokai");
    var specText = CodeMirror.fromTextArea($("#jasmine_spec_text").get(0),  _codemirrorOptions);


    window.runSpec = function(){
      eval(srcText.getValue());
      eval(specText.getValue());
//      $("#js_spec").remove();
//      var spec_script = $("<script id=\"js_spec\" type=\"text/javascript\"></script>");
//      $("#js_spec_src").html(srcText);
        jasmineEnv.execute();

    };


})();

window.Test = {}
class Test.Runner
  updateInterval: 1000

  srcTextarea: ->
    $("#src_text").get(0)

  specTextarea: ->
    $("#spec_text").get(0)

  constructor: ->
    @env = jasmine.getEnv()
    @srcText = CodeMirror.fromTextArea(@srcTextarea(), @_codemirrorOptions)
    @specText = CodeMirror.fromTextArea(@specTextarea(), @_codemirrorOptions)

    @env.addReporter(new jasmine.TrivialReporter())

    $(".run").on("click", =>
      @run())


  run: ->
    @env.currentRunner_ = new jasmine.Runner(@env);
    eval(@srcText.getValue())
    eval(@specText.getValue())
    @env.execute()


  _codemirrorOptions:
    value: "",
    mode: 'javascript',
    lineNumbers: true,
    readOnly: false,
    theme: "monokai"


$ ->
  new Test.Runner()
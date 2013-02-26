describe "JasmineRunner", ->
  beforeEach ->
    jasmine.TrivialReporter = jasmine.createSpy()
    setFixtures("<textarea id='src_text'></textarea><textarea id='spec_text'></textarea>")


  describe "after instanciated", ->

    beforeEach ->
      spyOn(jasmine.Env.prototype, "addReporter").andCallFake(->)

      @jasmineRunner = new Test.Runner()

    it "should have default interval set to 1000", ->
      expect(@jasmineRunner.updateInterval).toEqual(1000)

    it "should have an instance of jasmine Env", ->
      expect(@jasmineRunner.env).toEqual(jasmine.any(jasmine.Env))

    it "should add a reporter", ->
      expect(jasmine.Env.prototype.addReporter).toHaveBeenCalledWith(jasmine.TrivialReporter.prototype)

  describe "sets up textareas", ->
    describe "srcText", ->
      it "should have a codeMirror for the source textarea", ->
        spyOn(CodeMirror,"fromTextArea").andCallThrough()
        jasmineRunner = new Test.Runner()
        expect(jasmineRunner.srcText).toBeDefined();
        expect(CodeMirror.fromTextArea).toHaveBeenCalled()

    describe "specText", ->
      it "should have a codeMirror for the source textarea", ->
        spyOn(CodeMirror,"fromTextArea").andCallThrough()
        jasmineRunner = new Test.Runner()
        expect(jasmineRunner.specText).toBeDefined();
        expect(CodeMirror.fromTextArea).toHaveBeenCalled()

  describe "run", ->
    beforeEach ->
      @jasmineRunner = new Test.Runner()

    it "should reset runner", ->
      spyOn(jasmine.Env.prototype, "execute")
      spyOn(jasmine, "Runner").andCallThrough()
      @jasmineRunner.run()
      expect(jasmine.Runner).toHaveBeenCalledWith(@jasmineRunner.env)

    it "should execute", ->
      spyOn(@jasmineRunner.env, "execute")
      @jasmineRunner.run()
      expect(@jasmineRunner.env.execute).toHaveBeenCalled()

    it "should eval both src and spec", ->
      jasmineRunner = new Test.Runner()
      spyOn(jasmine.Env.prototype, "execute")

      spyOn(jasmineRunner.srcText, "getValue")
      spyOn(jasmineRunner.specText, "getValue")

      jasmineRunner.run()
      expect(jasmineRunner.srcText.getValue).toHaveBeenCalled()
      expect(jasmineRunner.specText.getValue).toHaveBeenCalled()


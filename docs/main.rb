state = {
  code: '>+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.>>>++++++++[<++++>-]<.>>>++++++++++[<+++++++++>-]<---.<<<<.+++.------.--------.>>+.>++++++++++.',
  output: ''
}

actions = {
  update_code: -> (state, value) {
    state[:code] = value
  },
  run_code: ->(state, e) {
    e.preventDefault()
    interpreter = BrainfuckInterpreter.new
    output = interpreter.run(state[:code])
    state[:output] = output
  }
}

view = ->(state, actions) {
  eval RubyWasmVdom::DomParser.parse(<<-DOM)
    <div class="max-w-lg mx-auto bg-white p-4 rounded-lg shadow">
      <h1 class="text-2xl font-bold mb-4">Brainf*ck Interpreter</h1>
      <form onsubmit='{->(e) { actions[:run_code].call(state, e) }}'>
        <div class="code-container">
          <label for="code-input" class="block font-medium">Code:</label>
          <textarea
            id="code-input"
            class="code-input border border-gray-300 rounded-lg p-2 w-full h-40"
            oninput='{->(e) { actions[:update_code].call(state, e[:target][:value].to_s) }}'
          >
            {state[:code]}
          </textarea>
        </div>
        <div class="mt-4">
          <button
            type="submit"
            class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600"
          >Execute</button>
        </div>
      </form>
      <div class="mt-8">
        <h2 class="text-lg font-bold mb-4">Result:</h2>
        <div class="result-container">
          {state[:output]}
        </div>
      </div>
    </div>
  DOM
}

RubyWasmVdom::App.new(
  el: "#app",
  state:,
  view:,
  actions:
)

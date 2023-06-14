class BrainfuckInterpreter
  def initialize
    @tape = Array.new(30000, 0)
    @pointer = 0
    @output = ""
  end

  def run(code)
    loop_stack = []
    code_ptr = 0

    while code_ptr < code.length
      case code[code_ptr]
      when ">"
        @pointer += 1
      when "<"
        @pointer -= 1
      when "+"
        @tape[@pointer] = (@tape[@pointer] + 1) % 256
      when "-"
        @tape[@pointer] = (@tape[@pointer] - 1) % 256
      when "."
        @output += @tape[@pointer].chr
      when ","
        @tape[@pointer] = $stdin.getbyte
      when "["
        if @tape[@pointer] == 0
          loop_level = 1
          while loop_level > 0
            code_ptr += 1
            if code[code_ptr] == "["
              loop_level += 1
            elsif code[code_ptr] == "]"
              loop_level -= 1
            end
          end
        else
          loop_stack.push(code_ptr)
        end
      when "]"
        if @tape[@pointer] == 0
          loop_stack.pop
        else
          code_ptr = loop_stack.last - 1
        end
      end

      code_ptr += 1
    end

    @output
  end
end

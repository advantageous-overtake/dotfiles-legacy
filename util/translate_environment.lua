#!/usr/bin/env lua

local input_buffer = io.stdin:read("a")

local function translate_environment( buffer )
    local function replace_by_value( variable_identifier )
        return os.getenv( string.gsub( variable_identifier, "%$", "" ) )
    end
    local output_buffer, replacement_count = buffer, math.huge do
        repeat
            output_buffer, replacement_count = string.gsub( output_buffer, "%$[%a_%$][%a%d_%$]+", replace_by_value )
        until replacement_count == 0
    end

    return output_buffer
end

local output_buffer = translate_environment( input_buffer )

io.write( output_buffer )
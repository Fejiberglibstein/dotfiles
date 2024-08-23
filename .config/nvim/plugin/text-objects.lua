local function in_visual_line_mode()
    return vim.fn.mode():find("V") ~= nil
end

local function set_linewise_selection(startline, endline)
    vim.fn.cursor(startline, 0);

    if not in_visual_line_mode() then vim.cmd('norm! V') end
    vim.cmd('norm! o');

    vim.fn.cursor(endline, 0);
end

local function is_line_blank(l)
    return vim.fn.nextnonblank(l) ~= l
end

-------------------- Selecting indents --------------------

local function select_indent(around)
    local line = vim.fn.line('.');
    local indent = vim.fn.indent(line);
    local start_line = line - 1;

    if is_line_blank(line) then
        indent = vim.fn.max({
            vim.fn.indent(vim.fn.nextnonblank(line)),
            vim.fn.indent(vim.fn.prevnonblank(line))
        });
    end

    while start_line > 0 and (vim.fn.indent(start_line) >= indent or is_line_blank(start_line)) do
        start_line = start_line - 1;
    end

    local end_line = vim.fn.line('.') + 1;
    local last_line = vim.fn.line('$');

    while end_line < last_line and (vim.fn.indent(end_line) >= indent or is_line_blank(end_line)) do
        end_line = end_line + 1;
    end

    if not around then
        end_line = end_line - 1;
        start_line = start_line + 1;
    end

    set_linewise_selection(start_line, end_line);
end

for _, v in ipairs({ 'x', 'o' }) do
    vim.keymap.set(v, 'ii', function()
        select_indent(false)
    end);

    vim.keymap.set(v, 'ai', function()
        select_indent(true)
    end);
end


-------------------- Selecting comments --------------------

-- foo
-- vehuqvequi qeiuou[ fe2qr[' h'
-- er2huoie ]]

local function select_comment(around)
    local commentstring = vim.filetype.get_option(vim.bo.filetype, 'commentstring');
    --- @cast commentstring string

    commentstring = commentstring:gsub("%%s", ".*") -- Replace %s with .* (lua regex for any repeated char)
    commentstring = commentstring:gsub("%-", "%%-") -- Replace - with %- since - is part of lua regex
    commentstring = commentstring:gsub(" ", "") -- Replace " " with nothing so empty comments still count


    local comment_pat = '^%s*' .. commentstring .. '$'

    local function line_has_comment(line)
        return string.match(vim.fn.getline(line), comment_pat) ~= nil
    end

    if not line_has_comment(vim.fn.line('.')) then
        return;
    end

    local startline = vim.fn.line('.');
    local endline = vim.fn.line('.');
    local lastLine = vim.fn.line('$');

    while startline > 0 and (line_has_comment(startline) or (around and is_line_blank(startline))) do
        startline = startline - 1;
    end

    while endline < lastLine and (line_has_comment(endline) or (around and is_line_blank(endline))) do
        endline = endline + 1;
    end

    startline = startline + 1;
    endline = endline - 1;
    set_linewise_selection(startline, endline)
end

for _, v in ipairs({ 'x', 'o' }) do
    vim.keymap.set(v, 'ic', function()
        select_comment(false)
    end);
    vim.keymap.set(v, 'ac', function()
        select_comment(true)
    end);
end

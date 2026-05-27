local colors = {
  bg        = '#f4f1e8',
  fg        = '#000000',
  muted     = '#dbd3bd',
  subtle    = '#dbd3bd',
  border    = '#8c959f',

  blue      = '#000000',
  green     = '#000000',
  red       = '#000000',
  purple    = '#000000',
  black     = '#000000',
  white     = '#f4f1e8',
}

return {
  normal = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.black, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  insert = {
    a = { fg = colors.white, bg = colors.red, gui = 'bold' },
    b = { fg = colors.red, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  visual = {
    a = { fg = colors.white, bg = colors.blue, gui = 'bold' },
    b = { fg = colors.blue, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  replace = {
    a = { fg = colors.white, bg = colors.purple, gui = 'bold' },
    b = { fg = colors.purple, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  command = {
    a = { fg = colors.white, bg = colors.green, gui = 'bold' },
    b = { fg = colors.green, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  terminal = {
    a = { fg = colors.black, bg = colors.subtle, gui = 'bold' },
    b = { fg = colors.muted, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  inactive = {
    a = { fg = colors.muted, bg = colors.subtle, gui = 'bold' },
    b = { fg = colors.muted, bg = colors.subtle },
    c = { fg = colors.muted, bg = colors.bg },
  },
}

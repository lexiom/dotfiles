local colors = {
  bg        = '#ffffff',
  fg        = '#0e1116',
  muted     = '#59636e',
  subtle    = '#f6f8fa',
  border    = '#8c959f',

  blue      = '#0349b4',
  green     = '#055d20',
  red       = '#a0111f',
  purple    = '#622cbc',

  black     = '#0e1116',
  white     = '#ffffff',
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

local colors = {
  bg        = '#000000',
  fg        = '#c5c5c5',
  muted     = '#898989',
  subtle    = '#1b1b1b',

  black     = '#000000',
  white     = '#c5c5c5',
}

return {
  normal = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.white, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  insert = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.white, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  visual = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.white, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  replace = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.white, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  command = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.white, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  terminal = {
    a = { fg = colors.white, bg = colors.subtle, gui = 'bold' },
    b = { fg = colors.muted, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  inactive = {
    a = { fg = colors.muted, bg = colors.subtle, gui = 'bold' },
    b = { fg = colors.muted, bg = colors.subtle },
    c = { fg = colors.muted, bg = colors.bg },
  },
}

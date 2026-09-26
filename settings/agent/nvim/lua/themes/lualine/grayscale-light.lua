local colors = {
  bg        = '#f2f2f2',
  fg        = '#000000',
  muted     = '#d4d4d4',
  subtle    = '#e4e4e4',

  black     = '#000000',
  white     = '#f2f2f2',
}

return {
  normal = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.black, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  insert = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.black, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  visual = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.black, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  replace = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.black, bg = colors.subtle },
    c = { fg = colors.fg, bg = colors.bg },
  },

  command = {
    a = { fg = colors.white, bg = colors.black, gui = 'bold' },
    b = { fg = colors.black, bg = colors.subtle },
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

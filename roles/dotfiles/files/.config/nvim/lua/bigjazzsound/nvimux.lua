local nvimux = require('nvimux')

nvimux.config.set_all{
  prefix = '<C-Space>',
  new_window = 'enew',
  new_tab = nil,
  new_window_buffer = 'single',
  quickterm_direction = 'botright',
  quickterm_orientation = 'vertical',
  quickterm_scope = 't',
  quickterm_size = '80',
}

nvimux.bindings.bind_all{
  {'x', ':belowright Tnew', {'n', 'v', 'i', 't'}},
  {'v', ':vertical Tnew', {'n', 'v', 'i', 't'}},
  {'<C-l>', 'gt', {'n', 'v', 'i', 't'}},
  {'<C-h>', 'gT', {'n', 'v', 'i', 't'}},
  {'c', ':tab Tnew', {'n', 'v', 'i', 't'}},
}

nvimux.bootstrap()

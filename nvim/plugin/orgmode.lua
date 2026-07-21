if vim.g.did_load_orgmode_plugin then
  return
end
vim.g.did_load_orgmode_plugin = true

local Menu = require('org-modern.menu')

require('orgmode').setup {
  -- Top-level files only: the agenda scans (and parses) every matched file on
  -- first open. The notes subdirectories (1-notes, 2-maps, 3-sources) hold no
  -- agenda items, so a recursive '~/notes/org/**/*' glob parsed ~400 files
  -- needlessly. This keeps the agenda fast.
  org_agenda_files = { '~/notes/org/*.org' },
  org_default_notes_file = '~/notes/org/notes.org',

  -- Open the agenda (and capture) in a centred floating popup. { 'float', scale }
  -- is relative='editor', sized to 85% of the editor and auto-centred;
  -- win_split_mode governs both windows in 0.7.3 (no agenda-only option exists).
  win_split_mode = { 'float', 0.85 },
  win_border = 'rounded',

  org_startup_indented = true,
  org_hide_emphasis_markers = true,
  org_ellipsis = '…',
  org_tags_column = 0,
  org_log_done = 'time',
  org_agenda_skip_deadline_if_done = true,

  -- The (x) suffixes are fast-access shortcut keys: without them, `cit`
  -- (org_todo) silently cycles to the next state; with them it pops up a
  -- single-keypress selection menu (in the message area). STARTED replaces the
  -- emacs `IN-PROGRESS` because orgmode's agenda match-query parser reads todo
  -- keywords with Lua `%w+` (`[A-Za-z0-9]` only) — hyphens/underscores split
  -- the word, so only an unbroken keyword like `/STARTED` filters in the agenda.
  org_todo_keywords = { 'TODO(t)', 'STARTED(s)', 'WAITING(w)', '|', 'DONE(d)', 'WONT-DO(x)' },

  org_todo_keyword_faces = {
    TODO = ':foreground GoldenRod :weight bold',
    STARTED = ':foreground Cyan :weight bold',
    WAITING = ':foreground Red :weight bold',
    DONE = ':foreground LimeGreen :weight bold',
    ['WONT-DO'] = ':foreground LimeGreen :weight bold',
  },

  org_capture_templates = {
    t = {
      description = 'Quick todo',
      template = '* TODO %?\n:Created: %T',
      target = '~/org/todo.org',
      headline = 'Todos',
    },
    c = {
      description = 'Code To-Do',
      template = '* TODO [#B] %?\n:Created: %T\n%a\nProposed Solution: ',
      target = '~/org/todo.org',
      headline = 'Code Related Tasks',
    },
    r = {
      description = 'Recurring Event',
      template = '** EVENT %?',
      target = '~/org/schedule.org',
      headline = 'Events',
    },
    o = {
      description = 'One-off Event',
      template = '** EVENT %?',
      target = '~/org/schedule.org',
      headline = 'Events',
    },
    w = {
      description = 'Work Log Entry',
      template = '* %?',
      target = '~/org/work-log.org',
      datetree = true,
    },
    n = {
      description = 'Note',
      template = '** %?',
      target = '~/org/notes.org',
      headline = 'Random Notes',
    },
  },

  org_agenda_custom_commands = {
    -- Commands c, S and w are scoped to :work: tagged entries only.
    -- tags/tags_todo views filter via the `match` query (they ignore
    -- tag_filter), so '+work' is prepended there; the agenda view type uses
    -- org_agenda_tag_filter_preset instead.
    c = {
      description = 'Current Work',
      types = {
        {
          type = 'tags_todo',
          match = '+work+PRIORITY="A"',
          org_agenda_overriding_header = 'High Priority:',
        },
        {
          type = 'tags_todo',
          match = '+work-PRIORITY="A"',
          org_agenda_todo_ignore_scheduled = 'all',
          org_agenda_todo_ignore_deadlines = 'all',
          org_agenda_overriding_header = 'Other TODOs:',
        },
        {
          type = 'agenda',
          org_agenda_span = 3,
          org_agenda_start_day = '-1d',
          org_agenda_tag_filter_preset = '+work',
          org_agenda_overriding_header = 'Previous Work:',
        },
      },
    },
    S = {
      description = 'Standup',
      types = {
        {
          type = 'agenda',
          org_agenda_span = 1,
          org_agenda_start_day = '-1d',
          org_agenda_tag_filter_preset = '+work',
          org_agenda_overriding_header = 'Yesterday:',
        },
        {
          type = 'tags_todo',
          match = '+work/STARTED',
          org_agenda_overriding_header = 'Currently Working On:',
        },
        {
          type = 'tags_todo',
          match = '+work/WAITING',
          org_agenda_overriding_header = 'Blocked Items:',
        },
        {
          type = 'tags_todo',
          match = '+work+PRIORITY="A"',
          org_agenda_overriding_header = 'High Priority TODOs:',
        },
      },
    },
    w = {
      description = 'Week Overview',
      types = {
        {
          type = 'agenda',
          org_agenda_span = 7,
          org_agenda_start_on_weekday = 1,
          org_agenda_tag_filter_preset = '+work',
          org_agenda_overriding_header = 'This Week:',
        },
      },
    },
    o = {
      description = 'Combined Overview',
      types = {
        {
          type = 'tags_todo',
          match = '+PRIORITY="A"',
          org_agenda_overriding_header = 'High Priority:',
        },
        {
          type = 'agenda',
          org_agenda_span = 1,
          org_agenda_overriding_header = 'Today:',
        },
        {
          type = 'tags_todo',
          match = 'work',
          org_agenda_overriding_header = 'Work Tasks:',
        },
        {
          type = 'tags_todo',
          match = 'personal',
          org_agenda_overriding_header = 'Personal Tasks:',
        },
      },
    },
    d = {
      description = 'Daily agenda and all TODOs',
      types = {
        {
          type = 'tags_todo',
          match = '+PRIORITY="A"',
          org_agenda_overriding_header = 'High-priority unfinished tasks:',
        },
        {
          type = 'agenda',
          org_agenda_span = 7,
          org_agenda_overriding_header = 'Agenda:',
        },
        {
          type = 'tags_todo',
          match = '-PRIORITY="A"-PRIORITY="C"',
          org_agenda_todo_ignore_scheduled = 'all',
          org_agenda_todo_ignore_deadlines = 'all',
          org_agenda_overriding_header = 'ALL normal priority tasks:',
        },
        {
          type = 'tags_todo',
          match = '+PRIORITY="C"',
          org_agenda_overriding_header = 'Low-priority Unfinished tasks:',
        },
        {
          type = 'tags',
          match = '/DONE',
          org_agenda_overriding_header = 'Done Tasks:',
        },
      },
    },
  },

  -- org-modern: modern floating-window menu for agenda/capture/export prompts.
  ui = {
    menu = {
      handler = function(data)
        Menu:new({
          window = {
            margin = { 1, 0, 1, 0 },
            padding = { 0, 1, 0, 1 },
            title_pos = 'center',
            border = 'single',
            zindex = 1000,
          },
          icons = {
            separator = '➜',
          },
        }):open(data)
      end,
    },
  },
}

-- org-bullets: pretty headline bullets in org buffers.
require('org-bullets').setup()

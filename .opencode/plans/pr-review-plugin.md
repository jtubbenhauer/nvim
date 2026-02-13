# PR Review Plugin Plan

## Overview

A Neovim plugin for reviewing PR changes with a persistent file tree and gitsigns integration.

**Goal**: Replace the current quickfix-based PR review workflow with a dedicated tab layout that:
- Shows changed files in a left pane
- Opens files in a right pane with gitsigns diffed against target branch
- Tracks reviewed state (persisted)
- Auto-unreviews files when edited
- Auto-refreshes when git state changes

## File Structure

```
lua/
├── pr-review/
│   ├── init.lua          # Main module, public API
│   ├── state.lua         # State management, persistence
│   ├── ui.lua            # Buffer/window management
│   ├── filelist.lua      # File list buffer rendering
│   └── autocmds.lua      # Autocommands for auto-unreview, refresh
└── plugins/
    └── pr-review.lua     # lazy.nvim plugin spec (just loads the module)
```

## Data Model

### State (`state.lua`)

```lua
-- In-memory state
M.state = {
  active = false,           -- Is a review session active?
  branch = nil,             -- Target branch (e.g., "origin/main")
  files = {},               -- { path = { reviewed = bool, exists = bool } }
  tab_id = nil,             -- Tab page ID for the review tab
  list_buf = nil,           -- Buffer ID for file list
  list_win = nil,           -- Window ID for file list
  file_win = nil,           -- Window ID for file buffer
}

-- Persistence file: .git/pr-review-state.json
{
  "branch": "origin/main",
  "reviewed": ["src/foo.ts", "src/bar.ts"]
}
```

### Persistence Logic

- **Load**: On `ReviewPR [branch]`, check if `.git/pr-review-state.json` exists
  - If same branch: restore reviewed state
  - If different branch: reset state, save new branch
- **Save**: On every review toggle, write to persistence file
- **Location**: Use `git rev-parse --git-dir` to find `.git` (handles worktrees)

## UI Layout

```
+-------------------+----------------------------------+
| File List         | File Buffer                      |
| width=35, fixed   | winfixwidth=false                |
| winfixwidth=true  |                                  |
|                   |                                  |
|   src/foo.ts      |  (file content with gitsigns)   |
| ✓ src/bar.ts      |                                  |
|   lib/baz.ts      |                                  |
+-------------------+----------------------------------+
```

### File List Buffer Properties

- `buftype=nofile` (scratch buffer)
- `bufhidden=wipe`
- `swapfile=false`
- `filetype=pr_review_list`
- `modifiable=false` (set true only during updates)

### Visual Format

```
  src/components/Button.tsx
✓ src/utils/helpers.ts
  src/App.tsx
```

- `✓` prefix for reviewed files
- Unreviewed: normal text
- Reviewed: `Comment` highlight (dimmed)
- Current file (cursor line): `CursorLine` highlight

## Keymaps (File List Buffer)

| Key | Action |
|-----|--------|
| `<CR>` | Open file under cursor in right pane |
| `o` | Same as `<CR>` |
| `r` | Toggle reviewed state for file under cursor |
| `R` | Refresh file list from git |
| `q` | Close review session (reset gitsigns, close tab) |
| `]u` | Jump to next unreviewed file |
| `[u` | Jump to previous unreviewed file |
| `<C-n>` | Open next unreviewed file in right pane |
| `j` / `k` | Normal navigation |

## Commands

### `:ReviewPR [branch]`

1. If review tab exists → switch to it, optionally refresh if branch differs
2. Else create new review session:
   - Get changed files: `git diff --name-only [branch]...HEAD`
   - Load persisted state if same branch
   - Create new tab
   - Set up split layout
   - Render file list
   - Call `gitsigns.change_base(branch, true)`
   - Set up autocmds

### `:ReviewPRClose`

1. Reset gitsigns: `gitsigns.reset_base(true)`
2. Save state (already saved on each toggle, but ensure)
3. Close the review tab
4. Clear autocmds

### `:ReviewPRRefresh`

1. Re-run `git diff --name-only`
2. Merge with existing state:
   - New files: add as unreviewed
   - Removed files: remove from list
   - Existing files: keep reviewed state
3. Re-render file list

## Autocmds

### Auto-unreview on Edit

```lua
-- Group: PRReviewAutoUnreview
-- Event: BufWritePost
-- Pattern: * (filtered to tracked files)
-- Callback: If file is in review list and was reviewed, mark unreviewed
```

### Auto-refresh on Git Changes

```lua
-- Group: PRReviewAutoRefresh  
-- Event: FocusGained, BufEnter (on review tab)
-- Also: Watch .git/HEAD, .git/index via uv.fs_event or gitsigns' watcher
-- Callback: Check if file list changed, refresh if so
```

### Tab/Window Cleanup

```lua
-- Group: PRReviewCleanup
-- Event: TabClosed
-- Callback: If review tab closed, cleanup state, reset gitsigns
```

## Gitsigns Integration

### On Session Start
```lua
require("gitsigns").change_base(branch, true)  -- global=true
```

### On Session End
```lua
require("gitsigns").reset_base(true)  -- global=true
```

### Consideration
- `change_base` affects ALL buffers globally
- User might have manually changed base elsewhere - we override it
- On close, we reset to index (default) - this is expected behavior

## Implementation Phases

### Phase 1: Core Structure
- [ ] Create `lua/pr-review/` directory structure
- [ ] Implement `state.lua` with in-memory state
- [ ] Implement `ui.lua` with tab/window creation
- [ ] Implement `filelist.lua` with basic rendering
- [ ] Create `:ReviewPR` command in `init.lua`
- [ ] Basic `<CR>` to open file, `q` to close

### Phase 2: Review State
- [ ] Add reviewed toggle (`r` key)
- [ ] Implement persistence to `.git/pr-review-state.json`
- [ ] Load state on session start
- [ ] Visual distinction for reviewed files

### Phase 3: Navigation & UX
- [ ] `]u` / `[u` for unreviewed navigation
- [ ] `<C-n>` for next unreviewed + open
- [ ] Highlight current file in list when buffer changes
- [ ] `:ReviewPRClose` command

### Phase 4: Auto Features
- [ ] Auto-unreview on `BufWritePost`
- [ ] Auto-refresh on git changes
- [ ] Handle edge cases (rebase, checkout, etc.)

### Phase 5: Polish
- [ ] Handle deleted files gracefully
- [ ] Handle binary files
- [ ] Status line integration (X/Y reviewed)
- [ ] Optional: integration with existing `<leader>pr*` keymaps

## Edge Cases to Handle

1. **File deleted on disk but in diff**: Show in list, mark as deleted, skip on open
2. **Binary files**: Show in list, maybe skip or show message on open
3. **Review tab accidentally closed**: Cleanup state properly via autocmd
4. **Multiple neovim instances**: Each has own state (acceptable for now)
5. **Branch changes mid-review**: Detect and offer to refresh
6. **Rebase/cherry-pick**: Refresh picks up new file list
7. **File renamed**: Old path removed, new path added (unreviewed)

## Future Enhancements (Not in v1)

- Tree view (grouped by directory) - toggle between flat/tree
- Inline diff preview in file list hover
- Integration with GitHub PR comments (via octo.nvim)
- Review notes per file
- Share review state with team (PR comment?)

## Dependencies

- `gitsigns.nvim` (required) - for `change_base()` API
- `nvim-web-devicons` (optional) - for file icons in list

## Testing Plan

1. Manual testing workflow:
   - Create branch with changes
   - Run `:ReviewPR main`
   - Navigate files, toggle reviewed
   - Close and reopen - state persists
   - Edit a reviewed file - becomes unreviewed
   - Commit changes - file list updates

2. Edge case testing:
   - Run on main branch (no changes)
   - Run with invalid branch name
   - Close tab via `:tabclose` vs `:ReviewPRClose`
   - Multiple `:ReviewPR` calls

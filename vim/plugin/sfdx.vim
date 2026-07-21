vim9script
# SFDX Integration for Vim 9
# Ported from nvim/lua/config/sfdx.lua
# Uses Vim 9 job_start() for async SFDX CLI execution

# === Helper: Print results after job completes ===
def PrintResults(results: list<string>)
  # Defer display to avoid issues with async echo
  timer_start(0, (_) => {
    for line in results
      echomsg line
    endfor
  })
enddef

# === Core: Async SFDX Job Runner ===
# Replaces plenary.job from the nvim config
def SfdxJob(args: list<string>, start_msg: string)
  if !executable('sfdx')
    echoerr 'sfdx executable not found in PATH'
    return
  endif

  var output: list<string> = []

  echomsg start_msg

  var job_cmd = ['sfdx'] + args
  var job_opts = {
    out_cb: (ch, msg) => {
      add(output, msg)
      echomsg msg
    },
    err_cb: (ch, msg) => {
      add(output, msg)
      echomsg msg
    },
    exit_cb: (job, status) => {
      PrintResults(output)
    },
    env: {CI: '1'},
  }

  var job = job_start(job_cmd, job_opts)
  if job_status(job) == 'fail'
    echoerr 'Failed to start SFDX job: ' .. string(job_cmd)
  endif
enddef

# === Deploy current file ===
def g:SfdxDeploy()
  var filepath = expand('%:p')
  SfdxJob(
    ['project', 'deploy', 'start', '--ignore-conflicts', '-d', filepath],
    'Deploying source...'
  )
enddef

# === Validate deploy (dry-run) ===
def g:SfdxValidate()
  var filepath = expand('%:p')
  SfdxJob(
    ['project', 'deploy', 'start', '--dry-run', '--ignore-conflicts', '-d', filepath],
    'Deploying source (dry run)...'
  )
enddef

# === Retrieve source ===
def g:SfdxRetrieve()
  var filepath = expand('%:p')
  SfdxJob(
    ['project', 'retrieve', 'start', '--ignore-conflicts', '--source-dir', filepath],
    'Retrieving source...'
  )
enddef

# === Retrieve source with conflict handling ===
def g:SfdxRetrieveConflicts()
  var filepath = expand('%:p')
  SfdxJob(
    ['project', 'retrieve', 'start', '--source-dir', filepath],
    'Retrieving source (with conflict detection)...'
  )
enddef

# === Execute Anonymous Apex ===
def g:SfdxExecAnon()
  var filepath = expand('%:p')
  SfdxJob(
    ['apex', 'run', '--file', filepath],
    'Executing anonymous Apex...'
  )
enddef

# === Run Apex Test for current file ===
def g:SfdxRunTest()
  var test_class_name = expand('%:t:r')
  SfdxJob(
    ['apex', 'run', 'test', '--tests', test_class_name, '--synchronous'],
    'Running test for ' .. test_class_name
  )
enddef

# === SOQL Query from file ===
def g:SfdxQueryFile()
  execute '!sfdx data query --file "' .. expand('%') .. '"'
enddef

# === SOQL Query from visual selection ===
def g:SfdxVisualQuery()
  var [_, l1, c1, _] = getpos("'<")
  var [_, l2, c2, _] = getpos("'>")
  var lines = getline(l1, l2)
  if len(lines) == 0
    return
  endif
  # Trim selection to exact columns
  if len(lines) == 1
    lines[0] = strpart(lines[0], c1 - 1, c2 - c1 + 1)
  else
    lines[0] = strpart(lines[0], c1 - 1)
    lines[-1] = strpart(lines[-1], 0, c2)
  endif
  var query = join(lines, ' ')
  # escape % # ! so the :! command line doesn't expand them (SOQL LIKE '%x%')
  execute '!sfdx data query -q "' .. escape(query, '"%#!') .. '"'
enddef

# === Open org in browser ===
def g:SfdxOpenOrg()
  execute '!sfdx org open'
enddef

# === Create Apex class ===
def g:SFDXCreateApexClass(classname: string, template: string = 'DefaultApexClass', outputdir: string = 'force-app/main/default/classes')
  SfdxJob(
    ['apex', 'generate', 'class', '--name', classname, '--template', template, '--output-dir', outputdir],
    'Creating new apex class...'
  )
enddef

# Command wrapper for CreateApexClass
# Usage: :SFDXCreateApexClass MyClass [template] [outputdir]
def CreateApexClassCmd(args: string)
  var parts = split(args)
  if len(parts) == 0
    echoerr 'Usage: :SFDXCreateApexClass <classname> [template] [outputdir]'
    return
  endif
  var classname = parts[0]
  var template = len(parts) > 1 ? parts[1] : 'DefaultApexClass'
  var outputdir = len(parts) > 2 ? parts[2] : 'force-app/main/default/classes'
  g:SFDXCreateApexClass(classname, template, outputdir)
enddef
command! -nargs=+ SFDXCreateApexClass CreateApexClassCmd(<q-args>)

# === Key Mappings ===
# Mirrors nvim/lua/config/sfdx.lua mappings

# Deploy source (current file)
nnoremap <leader>sd <ScriptCmd>g:SfdxDeploy()<CR>
# Validate deploy (dry run)
nnoremap <leader>sv <ScriptCmd>g:SfdxValidate()<CR>
# Retrieve source
nnoremap <leader>sr <ScriptCmd>g:SfdxRetrieve()<CR>
# Retrieve with conflict handling
nnoremap <leader>sch <ScriptCmd>g:SfdxRetrieveConflicts()<CR>
# Execute anonymous Apex
nnoremap <leader>sae <ScriptCmd>g:SfdxExecAnon()<CR>
# Run Apex tests
nnoremap <leader>st <ScriptCmd>g:SfdxRunTest()<CR>
# SOQL query from file (normal mode)
nnoremap <leader>sq :!sfdx data query --file "%" <CR>
# SOQL query from visual selection
xnoremap <leader>sq <ScriptCmd>g:SfdxVisualQuery()<CR>
# Open org in browser
nnoremap <leader>so <ScriptCmd>g:SfdxOpenOrg()<CR>
# Org switching — prompts for alias
nnoremap <leader>dxd :!dxd<Space>

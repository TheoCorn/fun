import os, strformat, osproc
import cinterface

proc getFunFolderDir(): string =
  let cwd = getCurrentDir()

  var path = cwd
  while not dirExists(&"{path}/.fun"):
    path = path.parentDir()
    if path.len == 1:
      echo "Could not find fun directory"
      quit 3
  return path

when isMainModule:
  let funFolderDir =  getFunFolderDir()
  let funFolder = &"{funFolderDir}/.fun"
  if commandLineParams().len() < 1:
    echo "Please provide a function name"
    quit 1
  let funcName = paramStr(1)
  let funcPath = &"{funFolder}/{funcName}"
  if not fileExists(funcPath):
    echo &"Function {funcName} does not exist"
    quit 1
  let canExecute = canExecute(funcPath.cstring)
  if not canExecute:
    echo &"Function {funcName} is not executable"
    quit 2

  let args = commandLineParams()[1..^1]
  let funProcess = startProcess(funcPath, workingDir = funFolderDir, args = args, options = {poParentStreams})
  quit funProcess.waitForExit()

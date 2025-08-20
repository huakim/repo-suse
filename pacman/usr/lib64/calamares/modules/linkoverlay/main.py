import os
def run():
  try: os.symlink('.', '/run/overlay')
  except FileExistsError: pass

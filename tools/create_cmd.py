#! /usr/bin/env python

import sys
import string
import os

content='''commandlinefu_id: 0000
translator:
  weibo: ''
hide: true
command: |-
  %(cmd)s
summary: |-
  %(trans)s'''

def create(cmd,trans):
    "create new yaml file"
    filename=''
    for token in cmd.split():
        # reserve ascii letters and digits only
        filename+=token.translate(None,token.translate(None,string.ascii_letters+string.digits))+'_'
    filename=filename[0:len(filename)-1]+'.yaml'
    pathname=sys.path[0][0:sys.path[0].rfind('/')]+'/_data/'+filename
    
    # file exists
    if os.path.isfile(pathname):
        print 'create fail: maybe a similar command exists'
        return

    try:
        wfile=open(pathname,'w')
        try:
            wfile.write(content % {"cmd":cmd,"trans":trans})
        except Exception as e:
            wfile.close()
            os.system('rm '+pathname)
            print 'write file error:'
            print e
        else:
            print 'create success...'
            # can't place wfile.close() to finally block, since 'git add' should execute after close()
            wfile.close() 
            os.system('git add '+pathname)
    except Exception as e:
        print 'open file in write mode error:'
        print e
    
    

if __name__ == '__main__':

    cmd=''
    trans=''
    while not cmd:
        cmd=raw_input("Input the new command:")
    while not trans:
        trans=raw_input("input the translation:")
    create(cmd,trans)
    

#!/usr/bin/python

import sys
import os
import chardet
import codecs

dcnt = 300

def removeBOM(codec,f):
##    print "removing bom ...",
    if codec=="utf-16le":
        bom = codecs.BOM_UTF16_LE
    elif codec=="utf-16be":
        bom = codecs.BOM_UTF16_BE
    elif codec=="utf-8":
        bom = codecs.BOM_UTF8
    else:
##        print "codec not fount",codec
        return f

    if f[:len(bom)]==bom:
##        print "remove bom:",codec
        return f[len(bom):]
##    print "bom not removed"
    return f


def utf8Tozh(u,codec):
        u=removeBOM(codec,u)
        for c in ('ascii','big5','gb2312','gbk','jp','euc_kr','utf16','utf32','utf-8'):
                encc = c
                try:
                        return encc,u.decode(codec)[:dcnt].encode(c)
                except UnicodeEncodeError as e:
##                        print e
                        if "u266a" in str(e): #ignore error by this char
                        	# print "u266a"
                        	return encc,u
                except:
                        pass

                try:
                        return encc,u.decode("utf-8-sig")[:dcnt].encode(c)
                except UnicodeEncodeError as e:
                        # print e
                        if "u266a" in str(e): #ignore error by this char
                        	# print "u266a"
                        	return encc,u
                except:
                        pass
        return "unknown",u


def zh2utf8(text,codec):
    return text.decode(codec,'ignore').encode("utf8")


def lang_detect(text):
    zhcodec=['utf-8','utf-8-sig',"utf-16le","utf-16be"]
    codex = chardet.detect(text[:dcnt])["encoding"].lower()
##    print "Encoding:", codex,
    if codex in zhcodec:
        encc,u=utf8Tozh(text,codex)
##        print ",",encc
        return codex,encc
    return codex,""


def codexdetect(text):
    for c in ('ascii','big5','gb2312','gbk','jp','euc_kr','utf16','utf32','utf-8'):
        enc = c
        try:
            text.decode(c)
            return c
        except:
            pass
    return ""

def unicode(text):
    enc = codexdetect(text)
    return text.decode(enc)


def utf8(text):
    return unicode(text).encode("utf8")


def main1():
##    file = sys.argv[1]
##    print file
##    path = os.path.dirname(file)
    path = sys.argv[1]
##    print path
    for f in os.listdir(path):
##        print f
        if ".srt" in f:
            text = open(os.path.join(path, f),"r").read()
            print "["+f+"]", lang_detect(text)


def checkAndConvert(fullname):
    likelyKeep = ["big5","gb2312"]
    encConvert = ["big5","gb2312","utf-16le","utf-16be"]

    f=os.path.basename(fullname)
    try:
        text = open(fullname,"r").read()
    except:
        print ">>%s Access Error." % fullname
        return
    enc,likely = lang_detect(text)
    print f,"[",enc,likely,"]",
    if enc=="utf-8" or enc=="utf-8-sig":
        if likely in likelyKeep: print "-> KEEP"
        else:
            print "-> DEL"
            os.remove(fullname)
    elif enc in encConvert:
        print "-> CONVERT"
        u=zh2utf8(text,enc)
        open(fullname,"w").write(u)
    else:
        print "-> DEL"
        os.remove(fullname)


##def isChnSrt(f,ext):
##    if ".srt" in f and "chn" in f: return True
##    return False
##
##
##def isChnAss(f):
##    if ".ass" in f and "chn" in f: return True
##    return False
##
##
##def isChnSsa(f):
##    if ".ssa" in f and "chn" in f: return True
##    return False


def isChn(f,ext):
    if ext in f and "chn" in f: return True
    return False


def getNewName(f,suffix,num):
    removeList = ["gb","big5","chn"]
    tokens=f.split('.')
    suf="%s%s" % (suffix,("" if num == 0 else num))
    tokens2 = tokens[:]
    for t in tokens2:
        for r in removeList:
            if r in t:
##                print f,"=> remove",t,"because of",r
                tokens.remove(t)
                continue
    tokens.insert(-1,suf)
    return ".".join(tokens)


def renameExt(fullname,ext):
    path = os.path.dirname(fullname)
    filename_noext = os.path.splitext(os.path.basename(fullname))[0]
    zhcnt = 0
    for f in os.listdir(path):
        if filename_noext in f:
            if isChn(f,ext):
                print "================================="
##                print "Renaming",zhcnt,f
##                rename(path,f,zhcnt)
                newf=getNewName(f,"zh",zhcnt)
                zhcnt = zhcnt + 1
                print f,"->",newf
                try:
                    os.rename(os.path.join(path,f), os.path.join(path,newf))
                except:
                    print ">>Access Error."


def renameSubtitles(fullname):
    renameExt(fullname,".srt")
    renameExt(fullname,".ass")
    renameExt(fullname,".ssa")
##    print filename_noext,":"
##    zhcnt = 0
##    for f in os.listdir(path):
##        if filename_noext in f:
##            if isChnAss(f):
##                print "================================="
##                rename(path,f,zhcnt)
##                zhcnt = zhcnt + 1


def main():
    videoExt = [".avi",".mkv",".mp4"]
    path = sys.argv[1]
    print "================================="
    print "checkAndConvert"
    for root, dirs, files in os.walk(path):
        for f in files:
            fullname = os.path.join(root, f)
##            if isChnSrt(f):
            if isChn(f,".srt"):
                print "================================="
                checkAndConvert(fullname)

    print "================================="
    print "renameSubtitles"
    for root, dirs, files in os.walk(path):
        for f in files:
            fullname = os.path.join(root, f)
            for ext in videoExt:
                if ext in f:
                    renameSubtitles(fullname)


if __name__ == '__main__':
	main()

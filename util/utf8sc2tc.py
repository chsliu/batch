import sys
import os
import ConfigParser
import traceback
import chardet
from lang_detect import zh2utf8,lang_detect

resource_file = 'convert2utf8.res';
cfg = None
tc = ""
sc = ""

def convert_simplified_to_traditional(t_str, s_str, o_str):
    str = u""
    for i in range(0, len(o_str)) :
        if s_str.find(o_str[i]) != -1 :
            str += t_str[s_str.index(o_str[i])]
        else :
            str += o_str[i]
    return str
	

def get_mapping():
	global cfg,tc,sc
	
	if not cfg:
		res = os.path.join(os.path.dirname(os.path.realpath(__file__)),resource_file)
		if not os.path.isfile (res): raise "MSG_RESOURCE_FILE_NOT_FOUND"
		cfg = ConfigParser.ConfigParser()
		cfg.readfp(open(res))
		tc = cfg.get("mapping","traditional_str")
		sc = cfg.get("mapping","simplified_str")
		tc = tc.decode('utf8')
		sc = sc.decode('utf8')
	return tc, sc
	

def utf8_sc2tc(utf8_sc):
	#print os.path.dirname(os.path.realpath(__file__))
	tcmapping, scmapping = get_mapping()
	return convert_simplified_to_traditional(tcmapping ,scmapping, utf8_sc).encode('utf8')


def unicode_sc_to_utf8_tc(utf8_sc):
	# global cfg

	# print cfg
	tcmapping, scmapping = get_mapping()
	# print cfg
	return convert_simplified_to_traditional(tcmapping ,scmapping, utf8_sc).encode('utf8')


def utf8_str_to_utf8_tc(utf8str):
	unicodeCodec = ['utf-8','utf-8-sig',"utf-16le","utf-16be"]
	unicodegb = ["gb2312","gbk"]
	
	d=chardet.detect(utf8str)
	if d["encoding"]:
		c=d["encoding"].lower()	
		
		enc,likely = lang_detect(utf8str)
		
		if c in unicodeCodec:
			if likely in unicodegb:
				return unicode_sc_to_utf8_tc(utf8str.decode(c))
				
	# print ">>Encoding not found"
	return utf8str
	

def str_to_utf8_tc():
	gbCodec = ["gb2312","gbk"]
	
	# d=chardet.detect(utf8str)
	# if d["encoding"] == None:
		# print ">>Encoding not found"
		# return utf8str
	# c=d["encoding"].lower()
	# if c in gbCodec:
		# backF=utf8_sc2tc(zh2utf8(backF,c).decode("utf8"))	
	
	
def main():
	argc = len(sys.argv)

	if argc > 3 or argc == 1:
		print("MSG_WRONG_ARGC");
	elif argc == 3 :
		mode = sys.argv[2]
	elif argc == 2 :
		mode = 'gbk'
	else:
		print("MSG_WRONG_ARGC")
	
	target_file = sys.argv[1]
	
	txt = open(target_file, 'r').read()

	try:
		utf8_tc=utf8_sc2tc(txt.decode(mode))
		utf_tc = target_file+".tc"
		open(utf_tc, 'w').write(utf8_tc)
	except:
		traceback.print_exc()
		print("MSG_NOT_SUPPORT_ENCODING")


if __name__ == '__main__':
	main()

	
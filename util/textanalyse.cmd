@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
import re
from functools import cmp_to_key
import urllib


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)


def getTokens(maxtokenlen, text):
	list = []
	if text:
		for width in [x+1 for x in range(len(text))]:
		# for width in [x+1 for x in range(maxtokenlen)]:
			list.extend([text[i:i+width] for i in range(len(text)-width+1)])	
	return list
	

def getTokens_dump(list):
	index = 0
	for item in list:
		warning(index,"\"",item,"\"")
		index = index + 1
	
	
def popular(dict,list,data):
	for key in list:
		try: 
			if data not in dict[key]: dict[key].append(data)
		except: dict[key] = [data]
	
	
def popular_dump(dict):
	for key in dict:
		for item in dict[key]:
			warning(key,":", item)
	
		
def calculate(dict):
	rank = {}
	for key in dict:
		try: rank[len(dict[key])].append(key)
		except: rank[len(dict[key])] = [key]
	
	return rank
	
	
def calculate_dump(rank):
	for ranking in rank:
		for item in sorted(rank[ranking]):
			warning(ranking,":","\"",item,"\"")
	
	
def isRemovableText(textFragment,textlist):
	for other in textlist:
		if len(other) > len(textFragment): 
			if textFragment in other:
				return True
	return False	
	

def rev_compare_length(x,y): 
	return len(y) - len(x)
	
	
def reduce(rank):
	for ranking in rank:
		if ranking == 1: continue #ignore single occurrence
		list = rank[ranking]
		# print(sorted(list))
		sortedlist = sorted(list)
		for text in sortedlist:
			if isRemovableText(text,sortedlist): list.remove(text)
		rank[ranking] = sorted(list,key=cmp_to_key(rev_compare_length))
	return rank
	
	
def report(rank, dict, ignores):
	# warning(rank)
	# warning(dict)
	topcount = 0
	for ranking in reversed(sorted(rank.keys())):
		# warning(ranking)
		if ranking == 1: continue #ignore single occurrence
		# if topcount >= 3: return
		topcount = topcount + 1
		for key in rank[ranking]:
			if len(key) == 1: continue #ignore short keywords
			if key in ignores: continue #ignores
			for text in dict[key]:
				warning_item("[",ranking,"]","\"",key,"\"",":",text)
		
		
def genkeywords(rank, dict, ignores):
	list = []
	for ranking in reversed(sorted(rank.keys())):
		if ranking == 1: continue #ignore single occurrence
		for key in rank[ranking]:
			if len(key) == 1: continue #ignore short keywords
			if key in ignores: continue #ignores from outside list
			list.append(key)
	return list

				
def parse(file):
	pattern = u',|!|:|-|#|\(|\)|\|| |｜|│|－|：|「|　|\n|\?|\d+|\w+'
	ignoreWords = ['EXTINF','YouTube']
	d = {}
	for line in file:
		# print(getTokens(line))
		line = line.decode('utf-8')
		# warning_item(line)
		# list = getTokens(line)
		list = getToken2(5,pattern,line)
		# warning(list)
		popular(d,list,line)
		
	# popular_dump(d)
	rank = calculate(d)
	# calculate_dump(rank)
	rank = reduce(rank)
	# calculate_dump(rank)
	report(rank, d, ignoreWords)
	# list = genkeywords(rank, d, ignoreWords)
	

def getToken2(maxtokenlen,splitPattern,line):
	# phrases = line.split()
	phrases = re.split(splitPattern,line)
	# getTokens_dump(phrases)
	list = []
	for phrase in phrases:
		list.extend(getTokens(maxtokenlen, phrase))
	# getTokens_dump(list)
	# list.extend(re.findall('\d+',line))
	list.extend(re.findall('[a-zA-Z]+',line))
	return list
	
	
def testphrase(file):
	pattern = u',|!|:|-|#|\(|\)|\|| |｜|│|－|：|「|　|\n|\?|\d+|\w+'
	for line in file:
		line = line.decode('utf-8')
		list = getToken2(5,pattern,line)
		getTokens_dump(list)
	
def readData(f):
	table = {}
	line = f.readline()
	# warning_item("Reading",len(line),line)
	while line:
		line = line.strip()
		# warning("Stripped",len(line),line)
		if len(line) and line[0] == '#':
			url = f.readline().strip()
			if "=== " not in line: #ignore this title line
				if url: table[line]=url
				# warning("Adding",line.strip(),url.strip())
		line = f.readline()
		# warning_item("Reading",len(line),line)
	return table
	
	
def readData_dump(table):
	for item in table:
		warning(item,":",table[item])
	

def countTitleUrl(titles, table):
	count = 0
	for title in titles:
		title = title.encode("utf-8")
		if title in table:
			count = count + 1
	return count
	
def parsem3u(file, maxtokenlen, ignoresPatterns, ignorePhrases, importantPhrases, keywordfile):
	# warning("parsem3u")
	# pattern = u'\d+|\[a-zA-Z]+'
	# pattern = u',|!|:|-|#|\(|\)|\|| |｜|│|－|：|「|　|\n|\?|\d+|\w+'
	# ignoreKeyWords = ['EXTINF','YouTube']
	keyword2Title = {}
	# warning("readData")
	table = readData(file)
	# readData_dump(table)
	# return
	for title in table:
		title = title.decode('utf-8')
		warning("[Get Token from]",title)
		keywords = getToken2(maxtokenlen, ignoresPatterns,title)
		# warning("keywords from title:",title)
		# getTokens_dump(keywords)
		# return
		warning("[Popular Keywords]")
		popular(keyword2Title,keywords,title)
	# popular_dump(keyword2Title)
	# return
	warning("[Calculate Keyword Ranking]")
	keywordRanking = calculate(keyword2Title)
	# calculate_dump(keywordRanking)
	# return
	warning("[Reduce Ranking]")
	keywordRanking = reduce(keywordRanking)
	# calculate_dump(keywordRanking)
	# return
	warning("[Generate Keywords List]")
	keywordlist = genkeywords(keywordRanking, keyword2Title, ignorePhrases)
	# getTokens_dump(keywordlist)
	# getTokens_dump(sorted(keywordlist))
	# return
	listdump(keywordlist,keywordfile)
	warning("[Output Titles Grouped by Keywords]")
	for keyword in importantPhrases:
		if keyword in keyword2Title:
			if countTitleUrl(keyword2Title[keyword],table) > 0:
				print("#EXTINF:0, ===",keyword.encode("utf-8"),"===")
				print("https://www.youtube.com/results?q="+urllib.quote(keyword.encode("utf-8")))
				print("")
				list = keyword2Title[keyword]
				for title in list:
					title = title.encode("utf-8")
					if title in table:
						print(title)
						print(table[title])
						table.pop(title)			
				print("")
				print("")
	for keyword in keywordlist:
	# for keyword in sorted(keywordlist):
		if countTitleUrl(keyword2Title[keyword],table) > 0:
			print("#EXTINF:0, ===",keyword.encode("utf-8"),"===")
			print("https://www.youtube.com/results?q="+urllib.quote(keyword.encode("utf-8")))
			print("")
			list = keyword2Title[keyword]
			for title in list:
				title = title.encode("utf-8")
				if title in table:
					print(title)
					print(table[title])
					table.pop(title)
			print("")
			print("")
	if len(table) > 0:
		print("#EXTINF:0, === 其他 ===")
		print("https://www.youtube.com/")
		print("")
		for title in sorted(table):
			title = title
			print(title)
			print(table[title])
		print("")
		print("")
		
	
def readPatterns(file):
	pattern = [' ']
	for line in file:
		line = line.strip().decode('utf-8')
		pattern.append(line)
	pat = '|'.join(pattern)
	# warning(pattern,pat)
	return pat
	
	
def readPhrases(file):
	list = []
	for line in file:
		line = line.strip()
		if len(line) == 0: continue
		if line[0] == '#': continue
		line = line.decode('utf-8')
		list.append(line)
	# warning(list)
	return list
	

def listdump(list, filename):
	f = open(filename, 'w')
	for item in sorted(list, reverse=True):
		f.write(item.encode("utf-8"))
		f.write("\n")
	f.close()
	

def listload(list, filename):
	for line in open(filename, 'r'):
		list.append(line.strip().decode('utf-8'))

	
def main():
	f = sys.stdin
	
	maxtokenlen = 5
	try:
		maxtokenlen = int(sys.argv[1])
	except: pass

	ignoresPatterns = ''
	try:
		file = open(sys.argv[2],'r')
		ignoresPatterns = readPatterns(file)
		file.close()
	except: pass
	# return

	ignoresPhrases = []
	try:
		file = open(sys.argv[3],'r')
		ignoresPhrases = readPhrases(file)
		file.close()
	except: pass

	importantPhrases = []
	try:
		file = open(sys.argv[4],'r')
		importantPhrases = readPhrases(file)
		file.close()
	except: pass

	keywordfile = "keywords.txt"
	try:
		keywordfile = sys.argv[5]
	except: pass

	# testphrase(f)
	# parse(f)
	parsem3u(f, maxtokenlen, ignoresPatterns, ignoresPhrases, importantPhrases, keywordfile)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)

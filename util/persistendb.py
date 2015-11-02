from __future__ import print_function
import sys
import os
import gzip
import pickle
import UserDict


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)


class PersistenDB(UserDict.DictMixin):
	def __init__(self, maxitem=1000):
		self.dict = {}
		self.age = {}
		self.count = 0
		self.ischanged = False
		self.filename = None
		self.maxitem = maxitem
	
	def open(self, dbfilename):
		self.filename = dbfilename
		if os.path.isfile(self.filename):
			try:
				pkl_file = gzip.open(self.filename, 'rb')
				db = pickle.load(pkl_file)
				self.dict.update(db)
				age = pickle.load(pkl_file)
				self.age.update(age)
				count = pickle.load(pkl_file)
				self.count = self.count + count
			except:
				pass
			finally:
				pkl_file.close()
			
	
	def keys(self):
		return self.dict.keys()
	
	def __len__(self):
		return len(self.dict)
	
	def has_key(self, key):
		return key in self.dict
	
	def __contains__(self, key):
		return key in self.dict
	
	def get(self, key, default=None):
		if key in self.dict:
			return self[key]
		return default
	
	def stack(self):
		import traceback
		for line in traceback.format_stack():
			print(line.strip())
	
	def __getitem__(self, key):
		# warning("[__getitem__]", self.count, key)
		# self.stack()
		self.count = self.count + 1
		self.age[key] = self.count
		return self.dict[key]
	
	def __setitem__(self, key, value):
		# warning("[__setitem__]", self.count, key, value)
		# self.stack()
		self.ischanged = True
		self.count = self.count + 1
		self.age[key] = self.count
		self.dict[key] = value
	
	def __delitem__(self, key):
		self.ischanged = True
		del self.age[key]
		del self.dict[key]
	
	
	def retire(self):
		# countmin = self.count - self.maxitem
		index = len(self.dict)-self.maxitem
		if index <= 0: return
		countmin = sorted(self.age.values())[index]
		# print(index,sorted(self.age.values())[index])		
		
		keys = self.dict.keys()
		retired = 0
		for key in keys:
			try: 
				count = self.age[key]
				if count < countmin:
					warning("[Retired]", self.dict[key])
					retired = retired + 1
					del self.age[key]
					del self.dict[key]
			except:
				pass
				
		# if retired: warning("[Retired", retired, "]")
		
		
	def close(self):
		# warning("[close]")
		if self.dict is None:
			return
		try:
			if self.ischanged:
				self.retire()
				warning_item("[Saving]", self.filename)
				pkl_file = gzip.open(self.filename, 'wb')
				pickle.dump(self.dict, pkl_file)
				pickle.dump(self.age, pkl_file)
				pickle.dump(self.count, pkl_file)
				pkl_file.close()
				warning("[", len(self.dict), "Done ]")
				self.ischanged = False
		except:
			pass

	def __del__(self):
		if self.filename is not None: self.close()
	
	
# def main():
	# db = PersistenDB("dummy.pkl")
	# db[123] = "abc"
	# db.close()
	
	
# if __name__ == '__main__':
	# main()			

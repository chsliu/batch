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
				warning("[Opening",self.filename,"]")
				pkl_file = gzip.open(self.filename, 'rb')
				
				try: 
					db = pickle.load(pkl_file)
					self.dict.update(db)
				except: pass
				
				try: 
					age = pickle.load(pkl_file)
					self.age.update(age)
				except: pass
				
				try: 
					count = pickle.load(pkl_file)
					self.count = self.count + count
				except: pass
				
			except:
				warning(sys.exc_info())
				warning("[Open",self.filename,"failed]")
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
		# warning("[Retire",self.filename,"step1]")
		try: countmin = sorted(self.age.values())[index]
		except: countmin = sys.maxint
		# warning("[Retire",self.filename,"step2]")
		# print(index,sorted(self.age.values())[index])		
		
		keys = self.dict.keys()
		# retired = 0
		for key in keys:
			try: 
				count = self.age[key]
				if count < countmin:
					warning("[Retired]", self.dict[key][:68])
					# retired = retired + 1
					del self.age[key]
					del self.dict[key]
			except:
				warning("[AgeCounted]", self.dict[key][:68])
				self.age[key] = count
				
		# if retired: warning("[Retired", retired, "]")
		
	
	def report(self):
		try: 
			warning("[", len(self.dict), "Items", len(self.dict)*100/self.maxitem, "% Used ]")
		except:
			# warning("[", len(self.dict), "Items ]")
			pass
	
	
	def close(self):
		# warning("[Closing",self.filename,"changed(",self.ischanged,")]")
		if self.dict is None:
			return
		try:
			# warning("[Closing",self.filename,"step1]")
			if self.ischanged:
				# warning("[Closing",self.filename,"step2]")
				self.retire()
				warning_item("[Saving]", self.filename)
				pkl_file = gzip.open(self.filename, 'wb')
				pickle.dump(self.dict, pkl_file)
				pickle.dump(self.age, pkl_file)
				try:
					if hasattr(self, 'count'): pickle.dump(self.count, pkl_file)
				except: 
					# warning(sys.exc_info()[0])
					warning(sys.exc_info())
					warning("[Close",self.filename,"pickle.dump failed]")
				pkl_file.close()
				self.ischanged = False
				# warning("[", len(self.dict), "Done ]")
				self.report()
		except:
			warning(sys.exc_info())
			warning("[Close",self.filename,"failed",sys.exc_info()[0],"]")

	def __del__(self):
		if self.filename is not None: self.close()


from datetime import datetime, timedelta
		
class PersistenDBDated(PersistenDB):
	def __init__(self, expiredelta=timedelta(1)):
		self.dict = {}
		self.age = {}
		self.ischanged = False
		self.filename = None
		self.expiredelta = expiredelta
	
	def __getitem__(self, key):
		if key in self.age:
			if type(self.age[key]) == int: 
				self.ischanged = True
		self.age[key] = datetime.now()
		return self.dict[key]
		
	def __setitem__(self, key, value):
		self.ischanged = True
		self.age[key] = datetime.now()
		self.dict[key] = value
	
	def retire(self):
		timemin = datetime.now() - self.expiredelta
		keys = self.dict.keys()
		for key in keys:
			try: 
				time = self.age[key]
				try:
					if time < timemin:
						warning("[Retired]", self.dict[key])
						del self.age[key]
						del self.dict[key]
				except:
					# warning("[Retired!]", self.dict[key])
					# del self.age[key]
					# del self.dict[key]
					warning("[AgeDated]", self.dict[key])
					self.age[key] = datetime.now()
					
			except:
				pass
	
	def report(self):
		warning("[", len(self.dict), "Items ]")
	
	
# def main():
	# db = PersistenDB("dummy.pkl")
	# db[123] = "abc"
	# db.close()
	
	
# if __name__ == '__main__':
	# main()			

#coding:utf-8
from tools.singleton import Singleton
from db.mysqlapp import MySQLApp
class Dal_base:
    __metaclass__ = Singleton
    def __init__(self):
        self._m_cache = dict()
        self._m_cacheKeys = []

    def add(self,mInstance):
        mInstance.id = mInstance.save()
        self._m_cache[mInstance.id] = mInstance
        self._m_cacheKeys.append(mInstance.id)
        return mInstance.id

    def get(self,pk,modelclass):
        pk = int(pk)
        if (pk in self._m_cache) == False:
           md = modelclass.get(pk)
           if md == None:
              return None
           self._m_cache[pk] = md
        return self._m_cache[pk]

    def update(self,pk,modelclass,**kwargs):
        pk = int(pk)
        if (pk in self._m_cache) == False:
           self.get(pk,modelclass)
        md = self._m_cache[pk]
        for k,v in kwargs.iteritems():
            if md.__mappings__[k].innertype == 'int':
                v = (int)(v)
            elif md.__mappings__[k].innertype == 'str':
                v = v.encode("utf-8")

            self._m_cache[pk][k] = v
        return self._m_cache[pk].update(pk,**kwargs)

    def delete(self,pk,modelclass):
        pk = int(pk)
        if (pk in self._m_cache) == False:
           self.get(pk,modelclass)

        self._m_cache[pk].delete(pk)
        self._m_cacheKeys.remove(pk)
        del self._m_cache[pk]

#根据某种属性返回满足条件的记录
    def getValueByAttr(self,attr,value):
        result = []
        bfit = True
        for k, v in self._m_cache.iteritems():
            if isinstance(value, dict):#如果是字典则逐一判断每个元素是否符合要求
                for k1, v1 in value.iteritems():
                    if v[attr][k1] != v1:
                        bfit = False
                        break
                if bfit:
                    result.append(k)
            else:
                if v[attr] == value:
                    result.append(k)
        return result




    # 模糊匹配
    def getFuzzyMatch(self,attr,value):
        result = []
        bfit = True
        for k, v in self._m_cache.iteritems():
                if isinstance(value, dict):#如果是字典则逐一判断每个元素是否符合要求
                    for k1, v1 in value.iteritems():
                        if v[attr][k1] != v1:
                            bfit = False
                            break
                    if bfit:
                        result.append(k)
                else:
                    if value in v[attr]:
                        result.append(k)
        return result

    def initDB(self,tablename,cls):
            db = MySQLApp().getInstance()
            sql = 'select  * from ' + tablename
            db.query(sql)
            result = db.fetchAllRows()

            #对行进行循环
            for row in result:
                md = cls(**row)
                self._m_cache[md.id] = md
                self._m_cacheKeys.append(md.id)
                print(md)

            db.close()

    #取得所有id
    def getAllID(self):
         return self._m_cacheKeys

        #取得所有记录
    def getAll(self):
         return self._m_cache

    def getFuzzyQuery(self,attr,value):
        if value == "":
            res = self.getAllID()
        else:
            values = long(value)
            res = self.getValueByAttr(attr,values)
        return  res

    def getFuzzyNickQuery(self,attr,value):
        if value == "":
            res = self.getAllID()
        else:
            res = self.getFuzzyMatch(attr, value)
        return  res


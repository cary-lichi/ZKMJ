#-*-coding:utf-8-*-
'''
对应的是user表
'''

## 对局记录类
class RecordAssist():
    def __init__(self):##牌类型，牌字
       self.m_nID= None
       self.m_nWinCount = None
       self.m_nScore = None

    def __cmp__(self, other):
        if self.m_nScore > other.m_nScore:
            return -1
        elif self.m_nScore == other.m_nScore:
            return 0
        else:
            return 1
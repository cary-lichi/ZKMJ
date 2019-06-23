#-*-coding:utf-8-*-
from logic.gameplay.ACMJ import ACMJ
class Common(ACMJ):
    def __init__(self):
        ACMJ.__init__(self)
        return
    # 检测胡
    def CheckHU(self,cmj):  ##检测是否胡牌
        if self.IsHu(cmj):
            return True
        elif self.QiQiaoDui(cmj):
            return True
        else:
            return False
    ##平胡
    def IsHu(self,cmj):##检测是否胡牌
        sptArr = cmj.m_MyPAIVec
        baoNum = len(cmj.m_BaoPAIVec)  # 手中宝牌的数量



        needBaoArr = [0,0,0,0,0]  # 需要宝的数量
        for i,a in enumerate(sptArr):
            needNum = self.getNeedBaoNumToZhengPu_ZhouKou(a)
            needBaoArr[i] = needNum
        # 将在"万"中
        needBaoNum = needBaoArr[self.MJPAI_ZFB] + needBaoArr[self.MJPAI_FENG] + needBaoArr[self.MJPAI_BING] + needBaoArr[self.MJPAI_TIAO]
        if needBaoNum <= baoNum:
            leftBaoNum = baoNum - needBaoNum  # // 剩下可用于去拼"万"成整扑一将的癞子数量
            num = self.getBaoNumToZhengPuJiang_ZhouKou(sptArr[self.MJPAI_WAN])
            if leftBaoNum >= num:
                return True

        # 将在"筒"中
        needBaoNum = needBaoArr[self.MJPAI_ZFB] + needBaoArr[self.MJPAI_FENG] + needBaoArr[self.MJPAI_WAN] + needBaoArr[self.MJPAI_TIAO]
        if needBaoNum <= baoNum:
            leftBaoNum = baoNum - needBaoNum  # // 剩下可用于去拼"万"成整扑一将的癞子数量
            num = self.getBaoNumToZhengPuJiang_ZhouKou(sptArr[self.MJPAI_BING])
            if leftBaoNum >= num:
                return True

        # 将在"条"中
        needBaoNum = needBaoArr[self.MJPAI_ZFB] + needBaoArr[self.MJPAI_FENG] + needBaoArr[self.MJPAI_BING] + needBaoArr[self.MJPAI_WAN]
        if needBaoNum <= baoNum:
            leftBaoNum = baoNum - needBaoNum  # // 剩下可用于去拼"万"成整扑一将的癞子数量
            num = self.getBaoNumToZhengPuJiang_ZhouKou(sptArr[self.MJPAI_TIAO])
            if leftBaoNum >= num:
                return True

        # 将在"风"中
        needBaoNum = needBaoArr[self.MJPAI_ZFB] + needBaoArr[self.MJPAI_WAN] + needBaoArr[self.MJPAI_BING] + needBaoArr[self.MJPAI_TIAO]
        if needBaoNum <= baoNum:
            leftBaoNum = baoNum - needBaoNum  # // 剩下可用于去拼"万"成整扑一将的癞子数量
            num = self.getBaoNumToZhengPuJiang_ZhouKou(sptArr[self.MJPAI_FENG])
            if leftBaoNum >= num:
                return True

        # 将在"中发白"中
        needBaoNum = needBaoArr[self.MJPAI_WAN] + needBaoArr[self.MJPAI_FENG] + needBaoArr[self.MJPAI_BING] + needBaoArr[self.MJPAI_TIAO]
        if needBaoNum <= baoNum:
            leftBaoNum = baoNum - needBaoNum  # // 剩下可用于去拼"万"成整扑一将的癞子数量
            num = self.getBaoNumToZhengPuJiang_ZhouKou(sptArr[self.MJPAI_ZFB])
            if leftBaoNum >= num:
                return True

        return False
    ##七巧对
    def QiQiaoDui(self,cmj):
        sptArr = cmj.m_MyPAIVec
        baoNum = len(cmj.m_BaoPAIVec)  # 手中宝牌的数量
        num = len(cmj.m_BaoPAIVec)
        for arr in sptArr:
            num += len(arr)
        if(num<14): #七小对手中必须有14张牌
            return False
        danNum = 0 #//单牌默认为零
        for i in range(1, len(sptArr)):
            a = sptArr[i]
            danArr = self.separate2Same(a) #//除去对子返回所有单牌的数组
            danNum += len(danArr)
        if baoNum >= danNum:
            return True
        else:
            return False

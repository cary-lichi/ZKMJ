package view 
{
	import laya.ui.Box;
	import laya.ui.Clip;
	import laya.ui.Image;
	import laya.ui.Label;
	import tool.Tool;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RecordItem extends Box 
	{
		protected var m_imgBg:Image;//背景
		protected var m_imgRank:Image;	//排名
		protected var m_clipRankNum1:Clip;//名次
		protected var m_clipRankNum2:Clip;//名次
		protected var m_clipRankNum3:Clip;//名次
		protected var m_imgHeadBg:Image;//头像背景
		protected var m_imgHead:Image;//头像
		protected var m_labName:Label;//昵称
		protected var m_labIntegralTitle:Label;//积分名称
		protected var m_labIntegralBg:Image;//积分背景
		protected var m_labIntegral:Label;//积分
		protected var m_diamonds:Image;//钻石
		protected var m_winSum:Label//本周胜场
		
		public function RecordItem() 
		{
			//背景
			m_imgBg = new Image;
			m_imgBg.width = 838;
			m_imgBg.height = 131;
			m_imgBg.skin = "record/img_RankingBg.png";
			this.addChild(m_imgBg);
			//排名
			m_imgRank = new Image;
			m_imgRank.width = 120;
			m_imgRank.height = 125;
			m_imgRank.left = 27;
			m_imgRank.top = 3;
			m_imgBg.addChild(m_imgRank);
			
			//名次
			m_clipRankNum1 = new Clip;
			m_clipRankNum2 = new Clip;
			m_clipRankNum3 = new Clip;
			m_clipRankNum1.skin = "record/clip_number.png";
			m_clipRankNum1.clipX = 10;
			m_clipRankNum1.clipY = 1;
			m_clipRankNum1.centerY = 0;
			m_clipRankNum2.skin = "record/clip_number.png";
			m_clipRankNum2.clipX = 10;
			m_clipRankNum2.clipY = 1;
			m_clipRankNum2.centerY = 0;
			m_clipRankNum3.skin = "record/clip_number.png";
			m_clipRankNum3.clipX = 10;
			m_clipRankNum3.clipY = 1;
			m_clipRankNum3.centerY = 0;
			
			m_imgBg.addChild(m_clipRankNum1);
			m_imgBg.addChild(m_clipRankNum2);
			m_imgBg.addChild(m_clipRankNum3);
			
			//本周胜场
			m_winSum = new Label;
			m_winSum.left = 371;
			m_winSum.color = "#6d3f2f";
			m_winSum.font = "SimHei";
			m_winSum.fontSize = 24;
			m_winSum.top = 75;
			m_imgBg.addChild(m_winSum);
			
			
			//头像背景
			m_imgHeadBg = new Image;
			m_imgHeadBg.skin = "record/img_HeadBg.png";
			m_imgHeadBg.left = 190;
			m_imgHeadBg.top = 10;
			m_imgBg.addChild(m_imgHeadBg);
			
			//头像
			m_imgHead = new Image;
			m_imgHead.width = 100;
			m_imgHead.height = 100;
			m_imgHead.centerX = 0;
			m_imgHead.centerY = 0;
			m_imgHeadBg.addChild(m_imgHead);
			
			//昵称
			m_labName = new Label;
			m_labName.color = "#6d3f2f";
			m_labName.font = "SimHei";
			m_labName.fontSize = 24;
			m_labName.left = 325;
			m_labName.top = 33;
			m_labName.width = 200;
			m_labName.align = "center";
			m_imgBg.addChild(m_labName);
			
			//积分名称
			m_labIntegralTitle = new Label;
			m_labIntegralTitle.color = "#6d3f2f";
			m_labIntegralTitle.font = "SimHei";
			m_labIntegralTitle.fontSize = 24;
			m_labIntegralTitle.left = 550;
			m_labIntegralTitle.top = 53;
			m_labIntegralTitle.text = "奖励：";
			m_imgBg.addChild(m_labIntegralTitle);
			
			//积分背景
			m_labIntegralBg = new Image;
			m_labIntegralBg.skin = "record/img_integralBg.png";
			m_labIntegralBg.left = 633;
			m_labIntegralBg.top = 40;
			m_imgBg.addChild(m_labIntegralBg);
			
			//钻石
			m_diamonds = new Image;
			m_diamonds.skin = "common/img_diamonds.png";
			//m_diamonds.centerX = 0;
			m_diamonds.width = 40;
			m_diamonds.height = 40;
			m_diamonds.left = 20;
			m_diamonds.top = 5;
			m_labIntegralBg.addChild(m_diamonds);
			
			//积分
			m_labIntegral = new Label;
			m_labIntegral.color = "#6d3f2f";
			m_labIntegral.font = "SimHei";
			m_labIntegral.left = 70;
			m_labIntegral.top = 13;
			m_labIntegral.fontSize = 24;
			m_labIntegralBg.addChild(m_labIntegral);
			
		}
		public function MyRank():void 
		{
			m_imgBg.skin = "";
			m_imgBg.left = 20;
			m_labName.color = "#ffffff";
			m_labIntegralTitle.color = "#ffffff";
			m_labIntegralBg.skin = "record/img_myintegrallg.png";
			m_winSum.color = "#ffffff";
			m_diamonds.visible = false;
			m_labIntegral.visible = false;
			m_labIntegralTitle.visible = false;
			m_labIntegralBg.visible = false;
		}
		//设置信息
		public function SetDal(RankRecord:*):void 
		{
			//头像
			m_imgHead.skin = RankRecord.sHeadimg?RankRecord.sHeadimg:Tool.getHeadUrl();
			//昵称
			m_labName.text = RankRecord.sName;
			//积分
			m_labIntegral.text = RankRecord.nRankAward;
			//胜场
			m_winSum.text = "胜局:" + RankRecord.nWinCount;
			//奖励
			if (RankRecord.nRankAwardType == 1)
			{
				m_diamonds.skin="common/img_diamonds.png";
			}
			else if (RankRecord.nRankAwardType == 2)
			{
				m_diamonds.skin="common/img_ma.png";
			}
			
		}
		//展示排名
		public function showRank(rank:int):void 
		{
			rank = rank + 1;
			m_clipRankNum1.visible = false;
			m_clipRankNum2.visible = false;
			m_clipRankNum3.visible = false;
			m_imgRank.visible = false;
			m_imgRank.width = 116;
			m_imgRank.height = 130;
			m_imgRank.centerY = 0;
			if (rank == 0)
			{
				m_imgRank.skin = "record/img_Notlisted.png";
				m_imgRank.width = 101;
				m_imgRank.height = 35;
				m_imgRank.centerY = 0;
				m_imgRank.visible = true;
			}
			else if (rank == 1)
			{
				m_imgRank.skin = "common/img_gold.png";
				m_imgRank.visible = true;
			}
			else if (rank == 2)
			{
				m_imgRank.skin = "common/img_silver.png";
				m_imgRank.visible = true;
			}
			else if (rank == 3)
			{
				m_imgRank.skin = "common/img_copper.png";
				m_imgRank.visible = true;
			}
			else
			{
				var num:int = rank;
				var ge:int ;
				var shi:int ;
				if (rank < 10)
				{
					m_clipRankNum1.index = num;
					m_clipRankNum1.x = 65;
					m_clipRankNum1.visible = true;
				}
				else if(rank<100)
				{
					ge= Math.floor(num % 10);
					num = num / 10;
					shi= Math.floor(num % 10);
					num = num / 10;
					m_clipRankNum1.index = shi;
					m_clipRankNum2.index = ge;
					m_clipRankNum1.x = 45;
					m_clipRankNum2.x = 85;
					m_clipRankNum1.visible = true;
					m_clipRankNum2.visible = true;
				}
				else if (rank = 100)
				{
					m_clipRankNum1.index = 1;
					m_clipRankNum2.index = 0;
					m_clipRankNum3.index = 0;
					m_clipRankNum1.visible = true;
					m_clipRankNum2.visible = true;
					m_clipRankNum3.visible = true;
					m_clipRankNum1.x = 25;
					m_clipRankNum2.x = 65;
					m_clipRankNum3.x = 105;
				}
			}
		}
		
	}

}
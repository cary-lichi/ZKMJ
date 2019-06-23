package view 
{
	import core.GameIF;
	/**
	 * ...
	 * @author ...
	 */
	public class GameHappySettlementView extends GameSettlementView 
	{
		
		public function GameHappySettlementView() 
		{
			super();
			
		}
		public override function SetGamerBottomInfo(gamerInfo:*,gamer:*,message:*):void 
		{
			m_user0Id.text = gamer.nGID.toString();
			m_user0Name.text = gamer.sNick;
			var gameCoin:int = gamerInfo.nGameCoin * 500;
			if (gameCoin > 0) {
				m_score0.text = "+" + gameCoin.toString()+"金币";
				m_score0.color = "#f7f200";
			}
			else if (gameCoin < 0)
			{
				m_score0.text = gameCoin.toString()+"金币";
				m_score0.color = "#41ed04";
			}
			else if (gameCoin == 0)
			{
				m_score0.text = "0";
				m_score0.color = "#dbdbdb";
			}
			m_imgHu.visible = false;
			m_imgPing.visible = false;
			m_imgBai.visible = false;
			if (gamerInfo.bHu)
			{
				m_imgHu.visible = true;
			}
			else if (message.bHuang)
			{
				m_imgPing.visible = true;
			}
			else
			{
				m_imgBai.visible = true;
			}
			var hupaiType:* = GameIF.GetJson()['hupaiType'];
			m_zhuang0.visible = gamerInfo.bBoss?true:false;
			for each(var listinfo:int in gamerInfo.nHuOPList)
			{
				m_win0Type.text = hupaiType[listinfo];
			}
		}
		public override function SetGamerLeftInfo(gamerInfo:*,gamer:*):void 
		{
			m_boxGamer1.visible = true;
			m_user1Id.text = gamer.nGID.toString();
			m_user1Name.text = gamer.sNick;
			var gameCoin:int = gamerInfo.nGameCoin * 500;
			if (gameCoin > 0) {
				m_score1.text = "+" + gameCoin.toString()+"金币";
				m_score1.color = "#f7f200";
			}
			else if (gameCoin < 0)
			{
				m_score1.text = gameCoin.toString()+"金币";
				m_score1.color = "#41ed04";
			}
			else if (gameCoin == 0)
			{
				m_score1.text = "0";
				m_score1.color = "#dbdbdb";
			}
			m_zhuang1.visible = gamerInfo.bBoss?true:false;
			var hupaiType:* = GameIF.GetJson()['hupaiType'];
			for each(var listinfo1:* in gamerInfo.nHuOPList)
			{
				m_win1Type.text =hupaiType[listinfo1];
			}
		}
		public override function SetGamerTopInfo(gamerInfo:*,gamer:*):void 
		{
			m_boxGamer2.visible = true;
			m_user2Id.text = gamer.nGID.toString();
			m_user2Name.text = gamer.sNick;
			var gameCoin:int = gamerInfo.nGameCoin * 500;
			if (gameCoin > 0) {
				m_score2.text = "+" + gameCoin.toString()+"金币";
				m_score2.color = "#f7f200";
			}
			else if (gameCoin < 0)
			{
				m_score2.text = gameCoin.toString()+"金币";
				m_score2.color = "#41ed04";
			}
			else if (gameCoin == 0)
			{
				m_score2.text = "0";
				m_score2.color = "#dbdbdb";
			}
			m_zhuang2.visible = gamerInfo.bBoss?true:false;
			var hupaiType:* = GameIF.GetJson()['hupaiType'];
			for each(var listinfo2:* in gamerInfo.nHuOPList)
			{
				m_win2Type.text =hupaiType[listinfo2];
			}
		}
		
		public override function SetGamerRightInfo(gamerInfo:*,gamer:*):void 
		{
			m_boxGamer3.visible = true;
			m_user3Id.text = gamer.nGID.toString();
			m_user3Name.text = gamer.sNick;
			var gameCoin:int = gamerInfo.nGameCoin * 500;
			if (gameCoin > 0) {
				m_score3.text = "+" + gameCoin.toString()+"金币";
				m_score3.color = "#f7f200";
			}
			else if (gameCoin < 0)
			{
				m_score3.text = gameCoin.toString()+"金币";
				m_score3.color = "#41ed04";
			}
			else if (gameCoin == 0)
			{
				m_score3.text = "0";
				m_score3.color = "#dbdbdb";
			}
			m_zhuang3.visible = gamerInfo.bBoss?true:false;
			var hupaiType:* = GameIF.GetJson()['hupaiType'];
			for each(var listinfo3:* in gamerInfo.nHuOPList)
			{
				m_win3Type.text =hupaiType[listinfo3];
			}
		}
	}

}
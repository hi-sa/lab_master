class TestController < ApplicationController

  def index
    ozaken = ["ozashige","yukimori66","makikomaki","twinkle7v","willing_cs","bokocchi","wakagon55","kimamanimoko","armiii1106","rittan92","natsu_56","vvsaki","idemiki56","minami911103_1","MNMF_012","fre_sia","u_chii","utti58","kmd7777","marn_mj","sukky111","asrn_x","kbsw_90","mogulla3","keimaejima","kinoshinnn","pocchamen","Beechan1002","mosuke5","rosedust1192"]

    #@hoge = Twitter.user_timeline('mogulla3').limit
    @hoge = Twitter.user('mogulla3')

    #@hoge.each do |h|
    #  h.text
    #end

  end


end

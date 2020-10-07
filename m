Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5428640F
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Oct 2020 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgJGQaj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Oct 2020 12:30:39 -0400
Received: from sonic309-14.consmr.mail.bf2.yahoo.com ([74.6.129.124]:40008
        "EHLO sonic309-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727954AbgJGQai (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Oct 2020 12:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602088237; bh=PxMwWzXvs+dqOoH0/FHvFmQpYH2JguaCUHYAVLLmaiw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=bSXRsQDLv/trIglwvR6ekx+5n0zoRDOnRIXoYId4rspfmVyDQ+HO6eYmXiLiOQIPWR6dJBYdY4M1q979OOQ1TKjDFtnwKquq1Ob3JMOTaIsyTSjilWMzNgLVTY4ji2kQ/JaQ6QKxdqIdzoPFh/74Q1bet+/el2lUyJID3dNnojhKSE1oFBWBY/mTdrUi0P73iHEcbJI+Iq/hvn5QsLxuwV7VGZBIMwvdvP/iGc6pjOdpcpQ1qEtBs932WktMM+3FPKW+TcmFBAduZNiV9+axEah3eYjSRSd2ZoMwal6qX4Ti6Uclw1xfmwyFcHhMWElQyc00lSMLda0YLqtvuqhdcw==
X-YMail-OSG: dnUtNsIVM1ksuZcOc23XYRVNRi2KvP98NXGHdsAi28G.4.j3LzR3teOzcMgJdV6
 I9RFmM0M3xx0XbrxH8auo_1akYgWVB.dRSVHIzgRK0z5hKx5VFXU4dJtCGAc22MGL5lLZwLuriqx
 spHXYJhLgjdOnN7IWn6k8UVsktxReUTOZSvffpMNjGN6HQM2GZkYT4zJYWbavaVbDj4squR6VDsG
 FUPdmjFf_TeRoNar3kYz09J7F737j0hKxKrB5C1UoqySZ4CrJkeCYcCqo6qjLzguiHgWollDFs9G
 wfUhfC__40GHcoR5U.tnb5qO9NkrcEsDCxVN0Yl3TF9R7SuF9eZUUNRi6p1q1qFpmebYHOu0LYlg
 XDWhmcA8Gwj76jCE8zPtY.ndhdUj32w1_jwb8T.5ImGSXELCGBTytNYFshPcp8Ua2JkFFvF7AEdq
 iHZ5_uGt.SmED8hs8oTSH81SBw.PrKO2a867uLjDMYkzg3YMMlzoagsbI._.zcvxQLQF3Z4wI7go
 HVgXyVOK3cgsxDNN9uLZ0PBzPZupw7knpfbTrMUHtBZ0zq90ClywEq7ct3yk4MBS9Sr1iFfm4ZNu
 oWrDUHzm_I8nKttgpWvu4sc9nJFuwsr9mOBdy8h726BxmI.VKfukWu91TYmzhiuAm6.MkLwTx5s7
 aUsvcBlxc0MxNly27ydL4MsSXXLkzfERFT6x9xuzEIoAD8yMO2jUSh5l6KqoNH9z2EVoW5YZOhrr
 OEsIeDnDNTRHYneliFW4sDaexyko3TwKr2Pp7JlEigfgiCb4iF6gqxgc4mr2thIYq4bkT4Ls_81K
 X4aQbMndFHLEAO_QuNMA54Rb3AqGudPYJJ7V8CoZFGKKmyEOz_ThVLuAueq.wZI53AczG8jVl7se
 pLPk5ZMEidaXsZIHJSu7XTUaZj4YR.y0fxjcsA9LW5OHxpz2ZH6AJq36gQAFb8Sd1DQ9OVPJZ0G1
 LWM3bpXug5ZtmnJBAVWOTCE2scF5vKdFgupYZWPle66bt9DbMw9OQwMUvOZEvxs7moY0PLV5aiA6
 d5ekeyaKjOhGBmVwJg2SYofzVimr63heoPJpFi8u902gixnanCPdsaH7mvQ7PGE3BRBl2yMRiQr7
 EH6veU.EzJ1aDRCvkc7RuOoHy6vFYKXRaJCGllfAgmslsFZCzucfimYVY8Q9sPv_QmZQkiy_r_KR
 IofCL2oGnGutvGQued8CdlpR1KyU2Q22Q.Rmrk9sIRuQg4gq9UwmZgqkKL7l2Ezb8LJzN4CtP4Vy
 9oiQiOtjhDsbbwwEZqzPwNLMX.k2hDjTEKqth9LNJb3MGugX0Usz4sIS3uH974jxBeXagmm3eoh8
 aHcJXeRD2GmKa6Rws6fMUn_xzhK0JeENSAISfAuT4nF6t03_3FQfzo47ObE0mORHnDgvPwAH9BR8
 B9pNTnrTSHLzrBEGuV7FORtCOmb27cguo1_W8_ZbjsY_Dog--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Oct 2020 16:30:37 +0000
Date:   Wed, 7 Oct 2020 16:30:36 +0000 (UTC)
From:   Marilyn Robert <fredodinga22@gmail.com>
Reply-To: marilyobert@gmail.com
Message-ID: <1859654730.147012.1602088236348@mail.yahoo.com>
Subject: =?UTF-8?B?0J3QsNGY0LzQuNC70LAg0LrQsNGYINCz0L7RgdC/0L7QtNCw0YDQvtGC?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
References: <1859654730.147012.1602088236348.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCtCd0LDRmNC80LjQu9CwINC60LDRmCDQs9C+0YHQv9C+0LTQsNGA0L7Rgg0KDQrQiNCw0YEg
0YHRg9C8IDY4LdCz0L7QtNC40YjQvdCwINC20LXQvdCwLCDQutC+0ZjQsCDRgdGC0YDQsNC00LAg
0L7QtCDQv9GA0L7QtNC+0LvQttC10L0g0LrQsNGA0YbQuNC90L7QvCDQvdCwINC00L7RmNC60LAs
INC+0LQg0YHQuNGC0LUg0LzQtdC00LjRhtC40L3RgdC60Lgg0LjQvdC00LjQutCw0YbQuNC4LCDQ
vNC+0ZjQsNGC0LAg0YHQvtGB0YLQvtGY0LHQsCDQvdCw0LLQuNGB0YLQuNC90LAg0YHQtSDQstC7
0L7RiNC4INC4INC+0YfQuNCz0LvQtdC00L3QviDQtSDQtNC10LrQsCDQvNC+0LbQtdCx0Lgg0L3Q
tdC80LAg0LTQsCDQttC40LLQtdCw0Lwg0L/QvtCy0LXRnNC1INC+0LQg0YjQtdGB0YIg0LzQtdGB
0LXRhtC4INC60LDQutC+INGA0LXQt9GD0LvRgtCw0YIg0L3QsCDQsdGA0LfQuNC+0YIg0YDQsNGB
0YIg0Lgg0LHQvtC70LrQsNGC0LAg0YjRgtC+INGB0LUg0ZjQsNCy0YPQstCwINC60LDRmCDQvdC1
0LAuINCc0L7RmNC+0YIg0YHQvtC/0YDRg9CzINC/0L7Rh9C40L3QsCDQvdC10LrQvtC70LrRgyDQ
s9C+0LTQuNC90Lgg0L3QsNC90LDQt9Cw0LQg0Lgg0L3QsNGI0LjRgtC1INC00L7Qu9Cz0Lgg0LPQ
vtC00LjQvdC4INCx0YDQsNC6INC90LUg0LHQtdCwINCx0LvQsNCz0L7RgdC70L7QstC10L3QuCDR
gdC+INC90LjRgtGDINC10LTQvdC+INC00LXRgtC1LCDQv9C+INC90LXQs9C+0LLQsNGC0LAg0YHQ
vNGA0YIg0LPQviDQvdCw0YHQu9C10LTQuNCyINGG0LXQu9C+0YLQviDQvdC10LPQvtCy0L4g0LHQ
vtCz0LDRgtGB0YLQstC+Lg0KDQrQlNC+0LDRk9Cw0Lwg0LrQsNGYINCy0LDRgSDQvtGC0LrQsNC6
0L4g0YHQtSDQv9C+0LzQvtC70LjQsiDQt9CwINGC0L7QsCwg0L/QvtC00LPQvtGC0LLQtdC9INGB
0YPQvCDQtNCwINC00L7QvdC40YDQsNC8INGB0YPQvNCwINC+0LQgMiwgMzAwLCAwMDAg0LXQstGA
0LAg0LfQsCDQv9C+0LzQvtGIINC90LAg0YHQuNGA0L7QvNCw0YjQvdC40YLQtSwg0YHQuNGA0L7Q
vNCw0YjQvdC40YLQtSDQuCDQv9C+0LzQsNC70LrRgyDQv9GA0LjQstC40LvQtdCz0LjRgNCw0L3Q
uNGC0LUg0LzQtdGT0YMg0LLQsNGI0LjRgtC1INGB0L7QsdGA0LDQvdC40ZjQsCAvINC+0L/RiNGC
0LXRgdGC0LLQvi4g0JfQsNCx0LXQu9C10LbQtdGC0LUg0LTQtdC60LAg0L7QstC+0Zgg0YTQvtC9
0LQg0LUg0LTQtdC/0L7QvdC40YDQsNC9INCy0L4g0LHQsNC90LrQsCDQutCw0LTQtSDRiNGC0L4g
0YDQsNCx0L7RgtC10YjQtSDQvNC+0ZjQvtGCINGB0L7Qv9GA0YPQsy4gQXBwcmVjaWF0ZdC1INGG
0LXQvdCw0Lwg0LDQutC+INC+0LHRgNC90LXRgtC1INCy0L3QuNC80LDQvdC40LUg0L3QsCDQvNC+
0LXRgtC+INCx0LDRgNCw0ZrQtSDQt9CwINC/0YDQvtC/0LDQs9C40YDQsNGa0LUg0L3QsCDQvNCw
0YHQsNC20LDRgtCwINC90LAg0LrRgNCw0LvRgdGC0LLQvtGC0L4sINGc0LUg0LLQuCDQtNCw0LTQ
sNC8INC/0L7QstC10ZzQtSDQtNC10YLQsNC70Lgg0LfQsCDRgtC+0LAg0LrQsNC60L4g0LTQsCDQ
v9C+0YHRgtCw0L/QuNGC0LUuDQoNCtCR0LvQsNCz0L7QtNCw0YDQsNC8DQrQky3Rk9CwINCc0LXR
gNC40LvQuNC9INCg0L7QsdC10YDRgg==

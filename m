Return-Path: <linux-integrity+bounces-4229-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2A9DAC47
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4B4281E4F
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878231DE4F8;
	Wed, 27 Nov 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r4n08GLB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A3225D6
	for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732727836; cv=none; b=Pk6HlUYXvoGOo4wJ1FFadYl9cMqm83jgksAC8s1YeS461umXo6M4MVdeIL8d3IG3H/NMzTvYaTZFUOo4Qu36N3RE4vKXw15O63Q2pnBuwB2LeLdzRpCTjR2FB5w/qcajqfeK6tkrxkRaHPam6C2hPImP0mo8gq+NP4VtKTHJE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732727836; c=relaxed/simple;
	bh=L79I11L2z+rrxrCQyklWD07u3nQS8TNFgmPUNvjm9IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhOKQf9amWb8OKtruPkzNeHz3qRwD2AFSJ5zWeHIEPH0ngMWNtnJWJE0al7GDgX/ZF+gcLXltcW8+PCDq8D2XeDMEswUrRLR8U5T+ArzQyLvckjzpRbmWP8ylWDfbVzs34xK1AEqWSSscqMTeGOgrxJPf1hOOFKqPP9t1NHpRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=r4n08GLB; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732727827; bh=92VQ0EJGjqXyMSmRVSvze4laOBLgiuS7qVK0UeNMrKg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=r4n08GLBe7D6bA/DkkfTJ6laX2X3krxu16AdsI44Dkg+vyi+lik7zODaZuQ/q7qBBrKhdrmRKxUKyjYE4yF9A3o+O8Agg+cCapYP4affUZIHvm333Y6W9rYpvCqtp6vFj9iTgtszIdmHy+Xd4n58gIi24ZkFfSzarsPGlzal4jMW9LGLsOrrebV8HchbGvgGThl+9xsYCMdwP9QUWLq8Ed5gmZ47h2dCAycnYrCfkqldMsLRDCDUjL2uMhLE/ewU0wX1pMC2tMiuJp2ndKqcocxloWjKDBpbGoyGkG8YEy3hmZvnIhaqKi7bc8IPZebi3jS7bEzdkHhkKM4Y+qjLRA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732727827; bh=9k2i2RwS8rMX8KGy0vZ+Qx8SJH3FTFmvX+v98dOh86d=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hFzKqIb/86N8BB5LwF+ot7Q6MT7Tom8dQWv+wsoFVl46loZ8Qq6Rqvfxfc2UUEhDI59E9QgRSOOdWTOmfnEHtd0p/e/6o2vyUmNssB2lOruR2RvbeaHPdgL5YyUpeOpSLD8KkNFnxG9VPFYWUbrG7/qOEQwd/+/m1Kd0jaR5nFdw6TiFDzCakN8Ecqn5ipZ1iX0Hf1U2Xn3BtNKc6nZOE70gi3WCt90n6/uY3wkgrTqnFL8/G40m9LR1FzWocztLV2M6nJdppNbb78tQGtqgSjQWbDUVsW/C5HhGLtaABAytpDDF2k7TRdtjUzyJ/G8BMfa5mbbG38oh64biX6kHoA==
X-YMail-OSG: .LcDm_sVM1lZPWDwTAPsGjEa_AolNsFrlCc3sTnbtbpYL6YY_qJpLWPc8WEIWmJ
 irEzB8rZecsnDY4F.j14EzNubyeJMe.m640kLs.FaXVKF6kra_0a8yJl1G.o7HoENc59FZly3Whi
 Yshl3X_jnbawnK4oQjT0rCYpdrid.WhKeD8aqaPRxV.nvEZ4HUAW3ceQLNPIEe8yUTkUtTEmFv5I
 2Y.kyBJEUd2zAvIYIJ7Ckx3TvoQVUGKxaHKCcO8ENsOsnbM.20a3ILTlas.IxKad9c6S6GrzrNFn
 Amg3SJdhE3QBIIuvXWkSZL1.ukfoVb4lSl2JwvpXJTEqPp3HBMlyQkSUgNpq2hDR3eiT0eOvLkSp
 B.XfaMdxAB6rD4MA_VcuCuJBKPxuV68tdOPHau2r35sIGH6gWEw.T0Bg32IJrc5J3CSAj2pgRz0R
 NldQ57aZLjpe1BByRlPRmuI6rFrcYqcLCR4GQ59kUe_VlBEJOPrVqqnBCFxQutOZ4e9EogjjKHm2
 iq6e2Akhs9IqZmCro3.9gfBr.uTsynlzU41S4BB4FdlbwOHrbDk1dgAg7YodKGWd7Y_DMIKbC2yY
 cBmlCU3bXE2XFj1qzskVDj_JaFugckRA_DLYH3nM.LEHGrOZ0zOaU6kAjICxp8WJkfFqTDw5VNfD
 4Fqzl7j3wA32K9RcSxHJel.zYpntSCrHGFtsE2gB_5U_xF.Yo4NOjnzD4myBnLTj9KTcukTV8WGt
 bTziSxbo5Tdfi_S6gWndV4JK47ZFZ7ctCNZy7Eo5aJVSe6jV6rSm0SM6zUYN0ktmH0_a6QKpVS2y
 fT0RSAhCfzvhnmgtvlvfLBCFbt4gS8Ars.FrRys0mn.mk_au3QWxp4l2cqdsvKZxz6_RVJVt2w2p
 yQ8_fIsULtq1YYiOoBbGOuF4lStwE0ViSpNEXzzCpR_t.dR4QPws9bz0FSOoO4vKLQkmgzEn.C.J
 ecHfc.1IZlYYII0IeCyq.dimCuG7fPDTn9gjJ.8UrJjMv24k9yecXN86psdmlRUcWateGVVnGsbh
 9PUrga.L3CLYkadFEe1faqHXKGsRZI72Ig.lVATLXLnDA4duyLcy6LRDOY4P1LAkvOB7mhijt.Gg
 Y1us6R5EiTYA3T2xkqulGjAvZerdgdBnHoylllJqzh32wfD5ywYWUnFU0slisz9JrnJCHwrUsMr.
 N34g0ypnOKtop8uJ9Dg4lbiDAYX7DzAPtjRVhlemzZ_8K27GZYQ56x0.pmfpZPYaTnwIXZaYQGjP
 sWWC4XG8IKtCJOAGbtgLQw7xL5lXaXPQkus26JV.mWIu5NxYdJdeau_ia2hMMgwi1Egq3_r4C93K
 TRmEKQDpnNfNfH8ovkgfJGKQKBCLdqQFE0kiJxTtiIDXiYXrOzpjnJ5aweXVA7MTVldLSucGM8YZ
 UYd6qqROJhQimIVKXqOLmu0KY30GGMUuuRAKAbW_nVhK3n8leQYSsoYYqeA1ifFBoSLK8SxAg3br
 _zE9X3IZZ1TdQTSz7Ze8YRxMUp_5yeG2FDXXBGBn7dEptxH1eXOIG2ekJXAREDEUiJ8mhtnZG4.G
 bG9q9sRQ_4tlbRsQ2tYX6L7Kla5bXUMsqkndojWCadJNXx2bnwNS77UYNpl0hGVakIPC0nhvgyro
 z8r1Y4cv5P9166GeTrn3lHrbcMvueE7EZXQ4nzYN.Yn1wYLfe3G0Nv.iu7eSSrkirFFoV0FIkhTJ
 Lw0kWmSMXBMxbY98Cd3El8QnzDfc3zHCBj9SE4z9Q08Q6ER.7kON74MFc3iOX4Gh1czUF3gKLR75
 C6eGX24Xeaj8WWKxR6pjRtePeV0BddhMm3g4ENOjYpQ7Yna2DXXtld5c6dB1sjhiTSgXCNMRRj7C
 .DQmbbdsLZByjSkxiEsUnDPbhKnUjGL0n4bpS9WUuzpy7CmiBl5WY97_p6icgtLO0hFdKvPoGvt3
 KpRtaksBbZs8oUIsEqys2Asx_nHNcXKTFoZAc5CA7zQq6e5ABfK8kwahSxj50yHSDVNoaMFxYzQZ
 8Imxn_ndylun9lO7Ze0VIfztfsr_1_R2SKFIqeV7LWxVwbccxDfZtYA9BKYmBhw42luIcs84zcPg
 01NeLm_6Pd5YM1nMx_WmnLcFFOf_sN.EY41GX.A2pqhWV2ml9D4aNt0RO2PTCG4yAdMfBgZttEtu
 8GMNGgssc1AUVxv0eNedt8ntqRDziQv9eW4B1.APdYXnYX42DsCKnvBGI1M6TjHlZmU9782_5sXw
 Hv9ZaqziAAjLo66SveShVXYP.9myck2BLOOhtMyA3FrFjY3U8VKPaNX28neBC.x5Y8kiWPOinJT7
 k_mkGAzz3kdGd
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a0b34c38-582a-4c85-bc89-c06858cde1b6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2024 17:17:07 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 58d101dfcfeb40f72ee72f271e72bb46;
          Wed, 27 Nov 2024 17:17:02 +0000 (UTC)
Message-ID: <4e1a707a-bcd7-440d-a9ad-bd664deca5d6@schaufler-ca.com>
Date: Wed, 27 Nov 2024 09:17:00 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IMA,LSM: Uncover hidden variable in ima_match_rules()
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 "M: Roberto Sassu" <roberto.sassu@huawei.com>,
 "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "R: Eric Snowberg" <eric.snowberg@oracle.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
 <77003d04-f3a4-46b1-9368-510b529fda44@schaufler-ca.com>
 <CAHC9VhTmyHr1U97mE0YwueJ_-8p_sBK-CB6O8rWMUz1Gr70iKw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTmyHr1U97mE0YwueJ_-8p_sBK-CB6O8rWMUz1Gr70iKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/26/2024 8:02 PM, Paul Moore wrote:
> On Tue, Nov 26, 2024 at 1:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> The variable name "prop" is inadvertently used twice in
>> ima_match_rules(), resulting in incorrect use of the local
>> variable when the function parameter should have been.
>> Rename the local variable and correct the use if the parameter.
> /if/of/
>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>  security/integrity/ima/ima_policy.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
> Aside from the typo above (which can be fixed during the merge) this
> looks good to me.  Based on the discussion in the previous revision it
> looks like Roberto would prefer this go via the LSM tree, so I'm going
> to merge this into lsm/stable-6.13 and send this up to Linus later
> this week (or early next depending on how my holiday travels go);
> additional testing is always welcome :)

Thank you.

> I'm also going to swap Roberto's reviewed-by tag for his ack which he
> gave on the previous revision as this is touching IMA code.

Works for me.



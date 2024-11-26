Return-Path: <linux-integrity+bounces-4215-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0E9D9D45
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 19:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E8B16504B
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9411DB361;
	Tue, 26 Nov 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CWlxu1d/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0E1DD879
	for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645295; cv=none; b=HHMVeMwTG0Cn1fQFthYeyti4nCIL01Q4L9Rm0+aHtPU5VsvTlZO1aMRoGlUFGRY4BSxvD3sfiVfgfFpDqn4b+12kTTGRePJjKNPLsvyaZ2iD/k+m8hymyfrt7zfOitTuFErmX2ay+0tfxi2xXhuV56F9l1i1kAYuz+/a6hO/m8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645295; c=relaxed/simple;
	bh=kgu/8heoFL26/8+SrMsvaQzy6PxggChIOLBjf0ZIOG4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tSj7MA9P7TKEyilUZUPhlfbcb4/CSoAWRwdNOMvuajimQSnYQ+oi49MqC5ASZVmXarf1rGGNMkDc9yuSYs/zGwOA0L0O3XhC2xLB0PinpDE3uRVJlxP4Lp4MQe0RObX4QPo6meKCXQmp2pLDYZ8nIxW1NaG5BdalaIxwXWEjAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CWlxu1d/; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732645285; bh=iq9ZgR0bPF3dCmO2VEAGc8zOrSJ8HYs5megjwQ5dlak=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=CWlxu1d/BisL3kzLovhu3dDnwPCup4iZBjFqe1njMaHWtaOtZFKsagBENNf3HbNtEetyJLG20n0NXeD+k15vnrGkONI5t9uiuS5wGqQDBBqfVuZP5JXXIs1wulrhKeAgGvAlxy8ar033rdT+iNb03pbyd6n2C+5Y3GqdMcQi8ZmKUx3ekGLEgxQim3Z0aIB2SfKekETv3M1U99YsqH9EPSc7rT5mNLtWRL3wCN7ScSTUFxyDNas0f68WvAd2prncM7vlDBWt0CtyffOBC+42zrkn/TJ3TAlGdPFSuwEx15CBGn2Qasg8LKqK2eSNR3d/j/SnhawVYVUKvUAwN6myOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732645285; bh=YXUitMr6QYQnRGCmTWRAzmhfzaph8+qyAnQ0Qn3rEem=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=lzKNeXcvSL7Mtchg3GiFUrwbFgQ9TmUkm6wGmYfV4VG+v/NEMibfuXMass9/tzMXOrewAQixY67t2e8/Q6VjOXzjHOGGKC+jU6ve17FP0k61yBDjCLemckK3mcBp2FGOe2okH9g4fB0oKqSldZ0vh6E3ndCRgME2aEwMSwMA3sRiY386xMUUdhjT07YmmW8OJN5YLxDr8tBsUS5TCWmAnFHZyqoSCHlTwm4ESigbeCQ9927S5vZxAuEgut/+3H2YqPsOSzWX8wNnx8da6pWOUm3AcFmVj8bggXkkuFxWcKMMTsAOtWnwQPQvdXLIbs9qMygswVdgAqDEk/b/lws2BA==
X-YMail-OSG: 99LyrCkVM1mxEbGfR8IM0G1bsY4qI0dUywLEmrGAZIdb5Pil8ovmyY1rm0T8j05
 ja1CQmyxntEedHwkNrxELAQtu5M19TQzMhi2S.YGwSiKmEpFZCwMKMpkwyIdMiQ5tS3P5apNbn6D
 NhrlE11H.ayo3_x6G5CC8sWTO9y5BEtSGAsKdnj0Xpfcp5QpR45bvgv2e2NpviSpgwisuJO1e2Gj
 vpClKQ1MYaLOg3ap.9RC5A00a.M_XH1YYCyEV9vM6XabjhdxQX8AQ9G.SEP0sNFNLGQIi22ta.Lm
 _EkLv.fJPGHM1shFdJq7tBAnJmA5fIw9Wr_RYsB6KKr_9QDkbhOspYKRaVgD9Hbj18TYQ3cjz.C6
 _9rZ2KnOjF8wouc299AGk46pEbfE02l95ZoVAjP3AGHsWr4kDOYUIfQz0NJ05bsXQJpAltzEdeyt
 xv8sPzNY7ym4HnKMEv3TumEgFXFu_8tIU5htyQTW5OAcPKjYmupNYjLYJ7p07ducIH87Eadiv0QO
 FhJpXaj3PkIZQVtNk1RIyx7rUfKnnq2AroBwjhKkeDPXSYtWPLW_gpXkl07qVtrTUgiqvlnhQErs
 rwyRzjVTiVV9DvUO0Y3IQG4lriRwF37ewCo1lLIDCbhE5jm9xODoPfyEXkGjpw6BQBO6yL3htegV
 U4.KEoKxA1oE1TRruUXCiSRrPzCrIPwKjpsDPwnNWMK4tncQ1iLramK9Z5LvwXHDQPHzQZTkITkr
 wmt0H13FecFypjQzz6b7.dSb4ky_dJc76igJSSrwebpqqigXyWv5FK12u0jcow43mhtX7ZDH3_9W
 9YqNfF7jkFo_L74IJuP5Fu8cqzECz90wNNCOJVa1H4RsqAOlEjf.3qfCOOEeDbg1odLVuTnwg6SN
 nwrBkMSmMx_uXb1nC6BqCcvoCyRhan0ZpLNLlF489yJ3yFdIGqbI6yKP2T9ATyMKjt3N3mJAoNQz
 eZScI9wHOtF8xpHGvaThRcpUtEBxBlM_DL269kQn3ZXeUbQb.CEGdSGZko.89ab5Npwr3VwIlhMT
 w0YAKqAGOXghsBdFzunznE4FBfi8XIMW5XMZQRs7XIabHel34BVVG94kTPWmMjKYwCq.IVcHSnxs
 vCbKv3PdHS2nyQQ2csJeXZFprVPypinZNmjKOOJmKTqvAlgstb4CNTy00ItgzvPg43xJDvrx84h5
 zKAcSVndl8xZfiSxjFe9wc6mCb.iOIWcnuheVrBobPINgmVrpfq6.7ZkVo3DkXHy5xEFvxHqkk2I
 0w0wNyD6YrGhusMUHZRouQwnvkwv3PJsLle.aXxPIxdqga2Yekmq9L1fWSUDbK1I.geCw4sLIiYd
 zoRnIcG.BTYUgvI5BxmTf2VmaTJmLQChn9LEfGfngFupy8nGkozTEVFU.ic_7TGImuiWP6tuuiKU
 y24TbppqASIT8cTtjwNMWixVyML1nxO0j6GBN9oQytNrS6oqCPQbMggZBRSJj_UmM0RcFRJHds8b
 LTHUlmVmogt9UXIJiwfqI7xsLt7fX3u6e7c4tjSNpAqhtIwjKGBquLuhpf6Ah9SyAB8pX2DYNWqO
 5EdgNCJlNzKoQrDUC4CxbpgOORjpVoS49mtD3X3uUkAWGf.MjkvQS9AR4Mq0WE.sHIBuzfUm9Co2
 mCTj4QX1WOXISUJngCmdPhSvqSGyVAKPA7U5BzZSmMBuRY3rxlv8uQHW7NdY1eTBg0F4lw5aUhRw
 W6Hu2_Xz85C8pzqudzqeUIEb05VQc.4rQGdo8D35NjC1VJ7o7gKJVJDkgGoM7.IZFzIUUUqqWV0B
 gWWDf1GJPo7i46TmsH0QXB9435GiSBOEeZxOMF0sY6TnjwdF3hj2arE6d3qCMj9pmikL9W6BrH9H
 AJzpL9Wjz.O2EuMgFegHRo1d5stGk9CLP8Z7Sk7ooPhLv_D.olvAEoSRpfv315kIxLe6jNrZw2lb
 VoM2.P6LwEPRzjGqnMnggQwWxYEEs4Y2Gex_JeAJnxNFPgoar92cM3QUj.ZM5SbhV7pHgcyWiZgJ
 o9cX6iIKAjz_kYLktl.TarQskmMdZm4ON_M.qFtRwm.oise8Y8kqcjTCUyMVa_.6716ZkE2WrxLB
 k6dwzEG.5Vm4GPV1PzyMTaJqSNwQIWIGHZUzUlHXvFYnUx8CyFfVldh5rRDEs.PJekghtIpnekNo
 fTQOpdNrD0i46wNSDK5pxUF.KBTMcJo9awUEckmXCZMXGnwjcWc7hKtYWr._6.zLOFUzsEWw5Tta
 mFuD7.hDB_3Zgxw1Bl.uGHi0ghO5Y1bdL8g1uOIxEQkPEuMi_rnQnkCfJYRmadH7ZIr1hgNi__mB
 0.7kXpYaDZDGbAerp7NGRGpDWMQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 35fe37b8-9eb3-490c-8976-d0d9495fd0b9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Nov 2024 18:21:25 +0000
Received: by hermes--production-gq1-5dd4b47f46-wrqn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 55e9207d670faa2d9a961105f9775dc7;
          Tue, 26 Nov 2024 18:21:22 +0000 (UTC)
Message-ID: <77003d04-f3a4-46b1-9368-510b529fda44@schaufler-ca.com>
Date: Tue, 26 Nov 2024 10:21:20 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] IMA,LSM: Uncover hidden variable in ima_match_rules()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-integrity@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 "M: Roberto Sassu" <roberto.sassu@huawei.com>,
 "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "R: Eric Snowberg" <eric.snowberg@oracle.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 LSM List <linux-security-module@vger.kernel.org>
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The variable name "prop" is inadvertently used twice in
ima_match_rules(), resulting in incorrect use of the local
variable when the function parameter should have been.
Rename the local variable and correct the use if the parameter.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_policy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index dbfd554b4624..21a8e54c383f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -635,7 +635,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		struct lsm_prop prop = { };
+		struct lsm_prop inode_prop = { };
 
 		if (!lsm_rule->lsm[i].rule) {
 			if (!lsm_rule->lsm[i].args_p)
@@ -649,15 +649,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getlsmprop(inode, &prop);
-			rc = ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
+			security_inode_getlsmprop(inode, &inode_prop);
+			rc = ima_filter_rule_match(&inode_prop,
+						   lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
+			rc = ima_filter_rule_match(prop, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
 			break;



Return-Path: <linux-integrity+bounces-4199-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D09D8C23
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 19:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AA7B23D87
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7E318E047;
	Mon, 25 Nov 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jSvsYFhB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8E1B3943
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559021; cv=none; b=sLTZb/EpUrAQQ2CiBxkCZ84R5PjhGoNSFoLmABYhFxKvC1MVcdiMCf5wW4HalqcNhTGIL6ebb/VAWoW1EnxV0eCQH+9xTgR7dG0NMwfc6vVTWxEfWKWlk8+GsaeoWieFfRMRj+rOO/wfRLwKPudn58P8oMMQ5MpMdGJgxuAz41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559021; c=relaxed/simple;
	bh=YHvD89ypCzvc+EQcn72GALt/0li+wW7m9x/8dJo2Qjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2TE5yhYFyNHpLx5sSj5efAtI/JPDIvIFcUmpl/6J54vx34jdpJ3ThMCREL9zH5Uisg8+xbbQW0+xN5LKOUjc7Gz322s82gSVbnnL349jbyRwhB7NCRveq7Av5I6UWkEbIlot6XGHmoAKWHncexaweBg06fDTipMTOAp6njmpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jSvsYFhB; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732559017; bh=xPuvY5JerMkx+NC8d6r41YRBlGA2w923pW+wZxAPzzU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jSvsYFhBWoXf65vewxViqmkQJpPCowHNeGmycbegjDu3VpeD9XXTCTi85jK+5afpXaTBqoczSL1XjII2vjAjngCEf/4i0FG2nCr8EhiZ7aK07a6LeNBkybsID0xXtyvyPOUVMaZBkHiSTXER9k4z3LdLu6PesESd2R3YcWDfwVrw++0CV0j5DhtC8ZxCK+1iMUOF+A3dGek6L/OauGeSoUGvJpHfyJf6PTIDDA6vwKG4tXFwNWQ3uzXswoMwbiq/A339/BEPVDLbcUn7dNc2b6+76oN9lo1VIdF/oIicwkyLlYbFtL9sZ/lqKEoqc3NZktY3Gv4eN1Kpbnt45GooKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732559017; bh=+UPjGVBbOlFIHZEMhMeOE6Pzqnt5NGPlhpHUqf7Khc5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jt0HW0NAdEhFNlw9JhruCj92bym339k6GPzfkSN7qiCDwhs/javAOCceTNLX1jVmh3WpugYsmR7zT5HkBwtVkv9gLAiMm8dw8fqF39FVGzf9z3A/6/B1+d9HTHIwnfRpMJsAIuyCPTvuZnTNyYVv3k9/tRklv+zNha6SxBezJxGI0xWvJIO3FM+omZFEYxXTTRwMGv+BHK4UF8GPwLR7XgYU2x8zBCtinqd0J/mzb3MJKYUsEMfWNIgUqRxX1dwR2mkdavHDdfEmHS5w9GeRRlzPw9aQEWHcipuKa7Hxnl6XvjdWvViILDGOzNQtT5awlPKjjDohTfuEPcLSBdSnNw==
X-YMail-OSG: muio1oIVM1nk5uS.mFdlN1I7v4jNMMw82Gp0yLCGNUL0Zq.teunEHvj3Cp2Koel
 HJpd5f4sw3dWchbhlDzc1VKGrtic6ChtsWFgwc6ugVwn76ZSe92MXV9RhEV2ixA7Cvs_59xuTkRj
 yI.79ZIs84vIaVW_DxXH4gGzQlZzmGigNPU4_Oye6Ora4kI54h98cgvGISdClkoAfC9vhhLgGH0x
 HfZQl6pOtjc6D_nSOz85N_gUO0ssHNnLRb8oGmci6pW9HNGdGCXcm19mlIM76m2LtK1PV3OyZ0fT
 ohkxuX0NUl1zw2s0WNS7q8UtemffnA2.CALR4nICQNqs3CDDPO8shzu4YqpgUfzD5yqaPZm3orX4
 KAAGc7SZWv4dWDsUe6oLGtF220QtVJHNHvfyvsXFwiRC6KWBxbIXQGkbn6JJG_mSM0tG1Dh8noWK
 e48G.vmglr.sIHW1aPNt.9AruGRurzAAmklAVHb6JIWo57SFgGYgSc77SPTgW9gywa8CB2QX9674
 0M6jlg8TH_CrEruVS5xR_WpGyp839LRPE5Qmc.bIMs.MfaPru2sFyfweynmv0JlVIsMZH8sMoh6P
 uaXnfG9HuCsf6ZngG7aXa20v.BcRJ72Uj4R_ZuR7Zw_O.AGcElgYWwFJ9spQ7wZvO6BQ4yqGYb5O
 6r.vyU9I.C7Sjy7Kjwxum.UJ3pxYDquajmHzUvGQqf6243v8plsy8vy_KytvTgBxVqtua9bghzx9
 cWTGrrND7.E3hqc7xc0PDjKSc5cTHIXUTpikePSRLcCVgKmf.K.bT2k9SSxxN8UcCQb9Y0mS0.yl
 VtQxn0Z3lARv0AAmQiQuLJNTSVlCnyjBvPx1vo3yUUC0U9Ml2It26w57EvlM0YfGx779WQzQS_qO
 YMEa03RsCaBBP0sAWgZxUwM6uTNQ2ehiaDnnXPp9vacaiGjRJHrMwRAY3vXhizPRm50uPjgoa8S3
 vynLU0jNa1otAH9EziGw8XdyElT8yZqMP0tF6k7MkDRxqZlUtlNkBAnyjbjF2vEhrYVDa4uq04.v
 Cgnc5lLKrXjgp78ge39ot93RlwOYrpTtJP5BFQEPlishwbF4Ll8M.3b1GbP7zaolLALgA8lB7OeZ
 8NNkZxMcdGg49V8NG1nfxPrQtopb184hGqCXCIUAUndhSbstOhxV6Ha0HDy0w3btR9m2sd9uhI1L
 MPnpYNSckvdxP0sflNOQGcbO5.RVLWVOCH0SpmgHzSNeVIq4cQU1xWlSJkz7vnFKuCSCEQgkp1_2
 ScPuOj_nVc2OOOn3NbWjaWItpFL1Yw.KOQRprhuC3syJpg_ktxAinghvw2z2vHahALkuLwW8jBif
 OJzNSjWpah2zWGVPTSI3HkxGOp3lop4bPg2Vjf9vEXLDYanPxLJHOEmgzGAXPqOM7LE_NUiGAPVq
 eagkZQHsWzLPHaEryBNX9L5o7hQaL_uS4ilWR0wtGJ6Jg.Rn.YzRBHUTFSN6fDYr_RjrztnFXt66
 cxBD9cOKrw.izF.JzdTNCuVTL5GBL5NVp9mkZm6qEekbvst1KUlkLh5sUWxy8zBfxoZJMd9VJIUg
 jcX1NYH_BOhOTgSKlhaBZNgvku8nsMOSt552FLsRIYcd51UQigHApw2l9TXDcHOkIslPrrbDAT6V
 JdzDmgzWWwO6rO3RveBKcjWq8vOXUw1hd7OkPYljzEm4QjX.YmbdjXgAhlCla0efCdtYRO8z6lkj
 b71HSWPPXKZw426b3yGapzsyFjZ0oIcr7ATqG8arDuORE4yJla6qQARxgTTErZoMBSJM6ZHnnEuC
 ymmX2RiOEygh23KglgbC6MprlMOSZhZ.M7sQaP0HXpuZduRivPbvoYWRfKzCCQBp8vF9JMgqTKf7
 2VePflGVVdLM2e68qA6LEwVnbYZvBtPrDSBM7cpcqkl_.J0xil.GJZLkmhIl1xGj7j6wso2Eq7qB
 V8khNTCvQ4095Z4niha21x8cFWX.wCtqY3eTvOnzh7xGJTiBeiabGpxGQL7khY.bdgPobah77u7h
 FG6KwPayvMfCZZRKel3TQbyZ2.4tDwyrBkamflsH59kSt04Ngq7NaW4nvaWR6xrHEXhXtF7aCYQz
 NVMMU20UzoMIj6XI3qbInascFLl9Xl0IlsxoousGMhr9VX.CjCcUXy1yEfRSwugaMyfi4GLzcReG
 84PIkinMasFU2c1fpyAwjCCJ8qrBvWhyoSOZI9Qu9eLBaNPXudS1CgiliHWlqF4CWMD.kbYij45d
 EjNhR2JqeK_v8S9QxzjXdfmNSEAl1ZODnkoj4_jkTYVRcioCLGwP8J4PbBy3Qh7Gl4eABZ3.qPsI
 HdZysSu9_wF660wTUbwtn5_ngrQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0db83dbc-2fe4-4f2a-9e17-5d341e7162ec
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Nov 2024 18:23:37 +0000
Received: by hermes--production-gq1-5dd4b47f46-9j75b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 403f3a5c5a348f902df6e107bf921b4c;
          Mon, 25 Nov 2024 18:23:34 +0000 (UTC)
Message-ID: <92e5fd64-8c75-4e82-981a-846364fc7a38@schaufler-ca.com>
Date: Mon, 25 Nov 2024 10:23:31 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ima: property parameter unused in ima_match_rules()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 "M: Roberto Sassu" <roberto.sassu@huawei.com>,
 "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "R: Eric Snowberg" <eric.snowberg@oracle.com>,
 Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>,
 LSM List <linux-security-module@vger.kernel.org>
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/25/2024 3:38 AM, Christian Göttsche wrote:
> Hi,
>
> I noticed that the `prop` parameter of `ima_match_rules()` is
> currently unused (due to shadowing).
> Is that by design or a mishap of the recent rework?
>
> Related commits:
>
> 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")

The shadowing was inadvertent. The use of lsm_prop data is
corrected by this patch.

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



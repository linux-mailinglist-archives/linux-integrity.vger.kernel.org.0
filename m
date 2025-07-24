Return-Path: <linux-integrity+bounces-6723-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86FB114CC
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 01:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D31CE6699
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777A246BA4;
	Thu, 24 Jul 2025 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dkKmAMd3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E124677E
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400291; cv=none; b=hv6yrv54Q2Ynb1GY12iqw9JHNAYXn6WosBuW+mPijrxHJdB5QCyGRAXdzXeZ5mRQBWWq5lm4tqMXO81+egymURIBjqeOGWDR/rx0REix6ceHrBqmXoFbuGHdQcmNKVD88nfRE9ZXkEDl343nXBkZWogt70LgM8sqTh5dHBIOPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400291; c=relaxed/simple;
	bh=XHYHudj1zGIHsgf8QKwaE+KHtRAovlH9b4mhcpUL+bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOZ8ZATL2NYRbF+RPVIWBqOY36ZqF98oIS1cT0gjBG0KNXd/ZyDd5ZabcRA45xFbTEpb30KN2JAu5jqZHmEwyngNtepf2/q/uWREYZ8fgokJ01kxkKNSN5txLGDROhhwTZFN2tEBzMsiDWdQwYgEG0clKR6LRhU4s4OvoWoMdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dkKmAMd3; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400289; bh=uZgpN1Km88LdCIqp+CIBcJROA9HsWTJ5tGp4QJ800AA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dkKmAMd3cRuvcQbNVZtHFs/fNs+wf6JEiiy8ZH14ZiDEhQbfF6suNliXQWtTTBcpbD2M20Q2fa2/XusKOI1liNwnI2HjHWLd4IAMR4gu88+6jdsVGN4DsSCza4vunRG5xaCns5d8je6uz23pCBcZb9dtwvgGP1dhzUsIPJ4GDoPny52C9Y3yKQwlyRBVKs4pAG3X9Pf4rBLJBe1FJ0gSXHO504CkjHCLuVjJchSz+aoPOsOyuPtpMCJU9getVOOjmAm6E029MNCzmpFdVdV7iruOA1Irg8nCiGirPWNvtRoHJcoyvoegz5Hq005FwqSud/u8zh0XdpmS664+lFDmpw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400289; bh=yHpH1OBhYjkZ+HRVd17d9g9VlBxg0xcEvvzOnbJ4U7+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WEuckNEPd+8/j0pN6o8w0BAdh637pr6NLGr+1XJNrJenLMpK5Ak7c+B+6KkMRdUQYfhQRyHLWSExq2bnaaH8LN0iRNSePBCsNZTtfUzYO013lQ2dxGEf82ZYF7xmnh94AU1RI5sioIg559kCs93ryRTOwZp47EVmi5hNmWI5zF33vPRUsXyUKX1lPZ11QB7UY8i9/EUS71zy14PtBL3wqQPbaeDHYrMxspjSIAAJPGyZ+PmwEvhRfhwvZ18JGDhH9q2vsjQS3fcIUYUBsZBtV/DxkJwq0ylTw9gqKYFBRhSI24ZwBlv4C5q/LNBAIBqRq0rptmL7eLSCVR8JxUh3qQ==
X-YMail-OSG: nUl6nR0VM1mFh8JWPUoEiK79GVfACEJpxSjjjs5bOQcYdNGQi7M_zmQyLmtyufP
 A0ZEllH0y1yDLQ8n4Uq46GuEZblZ2e5GppS7OU04Jn7piQSsj0PIFYGJlPzWe7390ByowS6fMOyL
 LGRxjczARp74eLGn66767gGY_NzXdPnTnkzXmFDJq0bf6o2gtwGNGxv1QfsvTmgLQpZ_KwpKJ.Rv
 kEUIO59FTrglVcDuIRHvcO_1.EgWTxW_3Tx278l0PVGNSav7slZghT.XapiBRx5nHKiyQklNFK25
 okHzAaq7kesMlOSp5W.lUt3uZzQNoZb8VHruZGCuDbnIbPpFqfQr2ewp3y2j3GGw9U2BFK81twE9
 HWtOzs7AG6SwZAI1Fel0ELFbw9_QBhqs1hoCOA5ItF1UHmkuhOJ00PnmbritoIOwKfrjmgsgHPac
 aoWokViefgYpG6EWLO8yYc3NVvbc9JJN3yVBMzNa4sjK2I4MEBGF7ExytYtWRaQQvrl4Lkj4tdLD
 Z8_9USjGmz0djwDXQ13Gr7m8vO1EXyWOJFADCy42XE6KOfT9bOaTdASmh_wIY2.AJc3GPG5GKd8I
 XP3.de0_XutZUnHD_k07ETT5VA.a_EcGqRguKTChdpDwF3_HEL8Ww6q._aUTkAy.98C89NROFBDr
 mK0RNUQCHJg_wqD9GzWzPvnVt0QlaZnEAhridFztKyrYoDheUdRQJGEb4IcuRBDgO.HQ4T.q5.v7
 S9kEDSD.hzHk7vAyB_OTWZWLMLMFDXzR89j_35ACo0U4O7xbBjFIDAXZiE7YmUmpmBxbk9wtnNhO
 FjWljoRV0uIawanrSntyKh9VLAbah4G2ui.5SwpwaF6Wlh2MAd7MvgslNyOF1x94KZyzlrUwJkm2
 cRV.JYvXsHiD336JZg6gZUlw8qmiTgPGjiCA34PbInvi1q2pGHEVhjS4cfAyeypbU6ibOQzeC7Xu
 850qeR9HOeiNksVSw68HTSNpUDrhia6TMHcOwQ1z4UrkPWsnW1F99QG0H5SvhIIGR7.9omwgCSGC
 vlVTEOFP_koyDRik_NDgf0cVJNcfP0QzJmH6asCRXdhbJN9KggxfThDaYJsJUH2phsirriaPwm4e
 BKB2Fq3C8aoc28ynGF0YH45iLioIvjRcO8_NLXvqAAqvoQm_YFNjOEex2fRjvolcTjvb3z7rZJdD
 DsZD_9FKGTh69gcO9YITjs3AWtdRLb8wRQmX6tsxPPGK4emI.G0diUlSK7ZKR2HnOwwBB81GgZAQ
 PNF217RB_lTFyCiV7VyXi5FaQ6srY4vBhEqptl2Fs.dUD6IVaImSppcCJVgKggKnrJJU8EvC7G.b
 CpoQYmPPhbUpwznhscqkHReUwxsmCH_xVKc7Jjpk5_aC3wsJQP.fkiLUlzwZyRHjY59WTPXEeV_T
 1o4fII4Ux_BHFzfAeZBhvzOlHtJg4ekbOsjClpyxDR4wGr9cvQORoRqRO9549qa8lDeDvzlQukXN
 jDWvNThiggZ8cQAYGUj84A9oZOCzndglnLrQJFfjbwwZyKyEv4J6E6LwaFS3tSi1HgBc67dacdpW
 pmml7Ony9fr1zyer2k7oolFWVmRoAkT.9dpdqmvOA3zqNnqn6YEdzCS2Ssf5sVbF_9GoF.GodslH
 eCkruUhGw7dOLEEXsUpKFX1QcUsMk5tjauyZR62pUNqWtfzeZpxdNVXm8JAVcjJDHX3rvBRfgWb1
 pL0oFLL9Hg_F2XK6yFa0FNRJug708Y6SII5AfUh.MIFlYLC_12cpRu41UaQLIpUFlbMBYT06JFEN
 zblVPxK3anxFDzjNk5zhD8.IwwfYflKJ2N1PbVUUx9jXnOn1KIZi1KTGH9Nc8fo.uzu6pMfY4lI7
 lAvhzpS26pAAaoXJHaBwcYqF_yexqnXsWft.PbBLc2x6nmagKP.SKSJsYBYNPK21Ksrz_TrdTAdk
 NbzC6_sOxKnG.qT9WR97Gl2zsby_fGoIic.CZ0uA.04bENGRxgAQVoc_H5DQoHtJWkdMOcgYEfi5
 0w8tCi6qyyy2HY7o4mgBc05O3ql.8zyS0wqbvo88qcLUwbj39zTm52zrFtYajkxVmZHtDg4R6hcp
 stYNhyB8wwaKg5E7LutGR47ATz2JXA3.nVAAVd_Y0dHMugQb_L3yXV0fY.7CXtAuINeAYgPc0EyU
 xzL932.F2Y1AH3bgP0Eq32uwz6P0Z6VLkJijcyzjAo.XPzko_CPZaSjACLQKQdmUyYE5GWhQA7GG
 7pEX.wB4J25PuYYUSsgfGqPmuQunsECDdiosKZM0VFK5uK4VXp_1fjNSFQXs3HTwUN7Qm24HrBq5
 nk949YzVJx7YoTy.mjs.x0OBg88K8ae_O9HdC9nL4Aivciw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bf546b7e-2dfc-46c1-aa85-601ade6a41ac
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:38:09 +0000
Received: by hermes--production-gq1-74d64bb7d7-lwch7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8ec1eeaa68ac2fad6105d502852c9335;
          Thu, 24 Jul 2025 23:38:05 +0000 (UTC)
Message-ID: <d701e258-7623-4afb-b5a5-5548613928e8@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:38:03 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 34/34] lsm: add a LSM_STARTED_ALL notification
 event
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-70-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-70-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
> boot when all of the LSMs have been started.
>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/security.h | 1 +
>  security/lsm_init.c      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c57a9a7499ea..b9cace094f0f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -85,6 +85,7 @@ struct timezone;
>  
>  enum lsm_event {
>  	LSM_POLICY_CHANGE,
> +	LSM_STARTED_ALL,
>  };
>  
>  struct dm_verity_digest {
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index f178a9a2f9d4..6812a13f64c9 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -550,6 +550,7 @@ static int __init security_initcall_late(void)
>  
>  	rc = lsm_initcall(late);
>  	lsm_pr_dbg("all enabled LSMs fully activated\n");
> +	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
>  
>  	return rc;
>  }


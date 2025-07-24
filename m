Return-Path: <linux-integrity+bounces-6714-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9902CB10F03
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D233A173EB9
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD8244698;
	Thu, 24 Jul 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QT12BMrJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA42E9ED1
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371897; cv=none; b=IWfKEKhKoacHwydnQ3ZbeQThK5m971hByl+6KTuxGy2tLEtSwCaAPJ5phhH7snYEtRLcJth5A+dpyvnfLh3c6/+vLLCVdiU5KSXM2Ubd7/wyVGrKEJqRPQWJNRbBR25+Bu8yYcKOm27Dyw4sWw36bjpKlZp65it6ecLUutxUAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371897; c=relaxed/simple;
	bh=bBLooHaiCmZDlxx3ZG2PzdSBaR8iXfnMGJBx19f6Y9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fItfm0TET99ylf/5Py6gthEML4pTj1Kp2yNJoaIOVhfem6EB7XVK/Y+uQIQcmfIvqROBjsyqXPMsvg0jh6u+3IjfgodththG06gNjX2v7y/lqn63Z2xhWgQXbM9rxfWx1dm380j3pjhw/s/Vb/yPeIsZ9ei9BnkNESQp7fihFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QT12BMrJ; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371895; bh=5qfc52S/67JlzhRVwFb0IzivsOnmTc/mkWxqk7B/e/g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QT12BMrJt3LY18OCnnqB1c4in1oVj49bdf4JemV1cs+Hwj7NtUVMi6BU1giupWe8LGPt0Fhe6w/qD/93IfZMsS7lLsNC2ywEfB8U05bdTpUJMTrsGYiIA8iRMmcdfXXm6HbQ9mPencqrY9LTdXowp4Qwdtckcxcz13NNOPlp8+ZAG9e1Sy9s6k8owXbaTGOOJoNRNHDTpXikpPYsv6gNuLq9tZNz7rrYS+bBSFB75+unf/QjBInVrMQug/V1hhiKbFRixNJclHO8E24+21fBagBAza20zvXlgBxKB+QXB4biH/cFTHsWQ4acFkcjhRcINCmJ/lLBWZuPOk9g7xfAGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371895; bh=cQFdn0d1fmDHBlfajwXmPqDeZyuN4HDy1k8OVJ7S4Nn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VPd/tVPXi2YLHJwHrMLkFiCMPTewTtKnhcj+KEtEOLAnD/WZvhkeGterjLztXDVC5KtoCRLW81fc3N8VkrITzFgWp6iCC3iL0ywPKBJfs/nrEdfL0lVnvN2iYiM5rks8t0eJefSdKAV34iKCjX8gwmS4m1hQE0WJM3wkr7PS39fgzmYMXfBbJ3aTNvSEkVlPOwV0Poj4jbzPiudFKaJJb2pkNa5fXEVFqev3D2gm+pm7ASbc2H5i3yZGbTSKL4KbWA09pV2T/GCec6P+0yoqdCoGW4d62l3HTcO27bThXqj1IYOJwTqjWMWDpWso5YGacOENR9f5lHzM3fafIQdIvQ==
X-YMail-OSG: RojDrJAVM1kZo5qyDdQXzAS3sAagMq95qEYM8P6zaXFXouIzTuLNDdQ6nQnCM1f
 hdh9zREfdO4sj8WnYVJs2LtH7GVb52tpcFehEksy5OVckgH1w4Rp1ADa78TzYMcNRAXu61E_13IV
 ro_UXfKSj1jhGHaGXmElmHosx_bdkvwtNEZCSZ7GieJfN9lypKHkQ17AcM7a4kiQZrlKgpijVn36
 rZNSN0dKal3Ka6UkBeISU1eK_Ntw6JaAcYfe5xa6E96jtpfWRQzwN2HewCVO3opVZhY7eP2dvV6a
 hID_utGsxwkiQs3t.LRcYhqpkVgRJmNYAXGTWhfIXKkL_mhVLU7PqmPcPhZzZDr0Vqp1Hzu6yoME
 Y7_f36Wa.9cIK.ILrExLqd0AaNVQZ4UiNFe.HGu8ZOnwxMyRQCz8axZdAlVsqgoZShCQkTbJ4BUu
 Zjqg3qH8hZwH6Q7KZRvou7uYriKq9hiBtlsTDJDXlPa74uzwr0Bx8YzMWRDsKho4fTquPrbynafg
 G2JpHppvmqeGjf3BmThIxcEf9ZG900mlPEyaMImNaAFcyEM6o4RCWuJbKV0YgJ6ouyoU7mn7VjZI
 nL.4GcKeFWVFIBrcbvIyrU_F3.LiyK5dpXVZqpLEpNnaQI6ohW8824fmio6Rdg_UNxHieUR7jWgh
 qZJWeoon57FnNVhUsP8r5WN1xoNZES7OkXTi5.CVSjzp0Z4TzfxWhlUh2pj67.HRbCxHE7gDyVhg
 L4OhVPUjFuDtRU9fsbUCuIaGvlVMGxW3dY29Zcn6_ncVklmBcoA3F6uZUrOp8D2LlBMx._9pkvJ0
 TDjZCGrub4.XswebdCdRzUFkdQTDRAoputXrzg0vdVvMMgdVscEGd_8ygiVcuNHBXXazsu1a4B8H
 E7xwK3QHP8s67fWgME9I_Epe_TNzyuw_GeLQj7GNjKLY1LKQgTon.l8_PIO.c6P9VVyLhzKdVHzV
 4pC_CvPkMnOl5OxFc2Ku_LNDLVxlFNlUWv32U81qihyJCo_.7tGeGeThNoK_VE0dQsxWWDP197J3
 MTFsY2r4e177pkb5NpQ0UF4fPX0SAm1LB3_kl5O8fUI6wz2g_l_XqJo.CMOc09kK22XdUfQPvbfs
 GysGFh0TQbBUawU9TE5NbOzA9q7iTykqM8Dx8ht0A9qNExKhnZ.4eTKlVOSjjQ0SVM8eaZUtFQL_
 yHWMHWsAq9cnkHt5651u1hH4bZskNajAbPoN145HKoJA_XD6oD9lW57E9HzpHbn6i9XB56MQznDI
 0CBVQwjEFIpzh9Wn8nAX6sdp_fWpC__p0XANoDAPBMUueHRqYN6pPxz63biBi.wYlZjxXVjWK8Au
 0wl1aQiysBFxr.8_VCDQiTTJl9QmXgDF2pMUT9O6Q4nyP2Zu04IuKQRMmKFoieBERQzHNkHKjYub
 C3u8PbIa6fegrvbvLDSi99vlSV_D3U35uTAAHjO74V..cGBwOrKjNmervUHn825kKe7CiNDtKzPe
 TBD4nkZAoK3F3dT66I4i7pJCmFmR1CE6KP.OYbZxcmi8sxNIIENUmxh_1xNG6yvf88X7LPxb1kd5
 O4pY65iUIXVTIP6XmbP1bsj8imsrstG_hot2udenmab1LhpsCu7Ao7GA0AwFN0gd7bEoM8vZl6gM
 FYm5ZatuVxWwWEUnDjtuR9oh0iNPzfH7LQqi4Ve05poFlbsfV.ggstxZStPB_DcPCerQXnLLZIAZ
 TtNSG3WVHK7_6kk5nvbnwkV3RffxrobsVZxuI2hjFhXePBdzeO1IbKhHU0E8VXL9cewk33ngXald
 eD7Uzg0br5ZmGOEB1T5vdXiA1mJcl6mNGBDMVKpFfgAZ9WeIXC6NXoLPMIM3RN6YjPT4dyoxKU_l
 Z..gI7f8ZY4VSn7iLQOFcOfaAJU03hmMyW.vphmyyEeLzYItpHHqDtIXQoY98.kBR76_Vuo93ZOK
 ZUlE6ERrzic4BI1KNVdIDmRnscsN5t3Myuefdp0WNW2GHqXbTwBhLu5LmoeK3hlNL1Apic_qFKj9
 xglRFVJVifxnbyuvfB1tZMoAEmA4KcU8Ykr2lSiUzH8_sOVok.SBBQ5OMgSHkuSASIgCnmoBnBrX
 597qw1VLb0Tqce5H4RIu8f7clXZaGq4V3QfYsQI1Sw75_iYPwcUbnUgOfWb2b713BpKkE2O2WKY5
 N2SP5kPn2MJcEKll4xq1B.J5vZFPABWKPOs.ow4bnBKZHawFY52X0BXjIMAKx1sFq1PE.Ph5qBK8
 CuaZMofihMKJ4Hr0ch.6zIdUO78j7g5fUp1jyJSytyvoz84PiqEIUP_PkyfBzWO2DpG6ckiWPEbh
 QTie_SzqgL0l_S63hqN0_1BxB2MRhgp8ntoGOPapHbjDy
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ee6653a1-eb5d-40b4-9ff8-eb0a17b4f50b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:44:55 +0000
Received: by hermes--production-gq1-74d64bb7d7-r4nbl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f279eaa4f66920badc68f99f553bceb3;
          Thu, 24 Jul 2025 15:44:50 +0000 (UTC)
Message-ID: <aceb3835-0e96-487f-91e6-e1263660ad04@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:44:48 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 12/34] lsm: rework the LSM enable/disable
 setter/getter functions
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
 <20250721232142.77224-48-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-48-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> In addition to style changes, rename set_enabled() to lsm_enabled_set()
> and is_enabled() to lsm_is_enabled() to better fit within the LSM
> initialization code.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 62 ++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 80b57aef38a0..14bb6f4b4628 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,6 +10,10 @@
>  
>  #include "lsm.h"
>  
> +/* LSM enabled constants. */
> +static __initdata int lsm_enabled_true = 1;
> +static __initdata int lsm_enabled_false = 0;
> +
>  /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -75,37 +79,33 @@ static int __init lsm_debug_enable(char *str)
>  }
>  __setup("lsm.debug", lsm_debug_enable);
>  
> -/* Mark an LSM's enabled flag. */
> -static int lsm_enabled_true __initdata = 1;
> -static int lsm_enabled_false __initdata = 0;
> -static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +/**
> + * lsm_enabled_set - Mark a LSM as enabled
> + * @lsm: LSM definition
> + * @enabled: enabled flag
> + */
> +static void __init lsm_enabled_set(struct lsm_info *lsm, bool enabled)
>  {
>  	/*
>  	 * When an LSM hasn't configured an enable variable, we can use
>  	 * a hard-coded location for storing the default enabled state.
>  	 */
> -	if (!lsm->enabled) {
> -		if (enabled)
> -			lsm->enabled = &lsm_enabled_true;
> -		else
> -			lsm->enabled = &lsm_enabled_false;
> -	} else if (lsm->enabled == &lsm_enabled_true) {
> -		if (!enabled)
> -			lsm->enabled = &lsm_enabled_false;
> -	} else if (lsm->enabled == &lsm_enabled_false) {
> -		if (enabled)
> -			lsm->enabled = &lsm_enabled_true;
> +	if (!lsm->enabled ||
> +	    lsm->enabled == &lsm_enabled_true ||
> +	    lsm->enabled == &lsm_enabled_false) {
> +		lsm->enabled = enabled ? &lsm_enabled_true : &lsm_enabled_false;
>  	} else {
>  		*lsm->enabled = enabled;
>  	}
>  }
>  
> -static inline bool is_enabled(struct lsm_info *lsm)
> +/**
> + * lsm_is_enabled - Determine if a LSM is enabled
> + * @lsm: LSM definition
> + */
> +static inline bool lsm_is_enabled(struct lsm_info *lsm)
>  {
> -	if (!lsm->enabled)
> -		return false;
> -
> -	return *lsm->enabled;
> +	return (lsm->enabled ? *lsm->enabled : false);
>  }
>  
>  /* Is an LSM already listed in the ordered LSMs list? */
> @@ -139,7 +139,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  	lsm_idlist[last_lsm++] = lsm->id;
>  
>  	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
> -		   is_enabled(lsm) ? "enabled" : "disabled");
> +		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>  }
>  
>  static void __init lsm_set_blob_size(int *need, int *lbs)
> @@ -162,17 +162,17 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  {
>  	struct lsm_blob_sizes *blobs;
>  
> -	if (!is_enabled(lsm)) {
> -		set_enabled(lsm, false);
> +	if (!lsm_is_enabled(lsm)) {
> +		lsm_enabled_set(lsm, false);
>  		return;
>  	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
>  		init_debug("exclusive disabled: %s\n", lsm->id->name);
> -		set_enabled(lsm, false);
> +		lsm_enabled_set(lsm, false);
>  		return;
>  	}
>  
>  	/* Mark the LSM as enabled. */
> -	set_enabled(lsm, true);
> +	lsm_enabled_set(lsm, true);
>  	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
>  		init_debug("exclusive chosen:   %s\n", lsm->id->name);
>  		lsm_exclusive = lsm;
> @@ -203,7 +203,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  /* Initialize a given LSM, if it is enabled. */
>  static void __init initialize_lsm(struct lsm_info *lsm)
>  {
> -	if (is_enabled(lsm)) {
> +	if (lsm_is_enabled(lsm)) {
>  		int ret;
>  
>  		init_debug("initializing %s\n", lsm->id->name);
> @@ -237,7 +237,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		lsm_for_each_raw(major) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>  			    strcmp(major->id->name, lsm_order_legacy) != 0) {
> -				set_enabled(major, false);
> +				lsm_enabled_set(major, false);
>  				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
>  					   lsm_order_legacy, major->id->name);
>  			}
> @@ -283,7 +283,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	lsm_for_each_raw(lsm) {
>  		if (exists_ordered_lsm(lsm))
>  			continue;
> -		set_enabled(lsm, false);
> +		lsm_enabled_set(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",
>  			   origin, lsm->id->name);
>  	}
> @@ -316,12 +316,12 @@ static void __init lsm_init_ordered(void)
>  
>  	pr_info("initializing lsm=");
>  	lsm_early_for_each_raw(early) {
> -		if (is_enabled(early))
> +		if (lsm_is_enabled(early))
>  			pr_cont("%s%s",
>  				first++ == 0 ? "" : ",", early->id->name);
>  	}
>  	lsm_order_for_each(lsm) {
> -		if (is_enabled(*lsm))
> +		if (lsm_is_enabled(*lsm))
>  			pr_cont("%s%s",
>  				first++ == 0 ? "" : ",", (*lsm)->id->name);
>  	}
> @@ -434,7 +434,7 @@ int __init security_init(void)
>  	 */
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
> -			   is_enabled(lsm) ? "enabled" : "disabled");
> +			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>  	}
>  
>  	/* Load LSMs in specified order. */


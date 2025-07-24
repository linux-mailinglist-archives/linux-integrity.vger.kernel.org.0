Return-Path: <linux-integrity+bounces-6717-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD06B10F26
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE55C1CE162F
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25E2EA16E;
	Thu, 24 Jul 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FBLNIYPO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C002E973E
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372137; cv=none; b=PeLftCSFXqdcTWAGv5AOZ/USw7b3aLunD7ci9BQC6olR8LYX1UaGJMpQi9pWc29ThvBexb/9KYL6YyjfvDibzub1nRm3qsLv0ZLphm1q8i8n1tJSgSSMDNgUBL8yfuv28jz2X82UTSfVQG3OZqpD97vJQ/o7QMaTRYCEGre867E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372137; c=relaxed/simple;
	bh=jVVa9Xe0+SBaOiIElfqhCIntfihgaQ+gkZBJfgjvLJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqwsDvYVxRrEs/nqY9UXDYTTTKYAk7Qdas+j1JEs/5MJ4G2Y+EpLfSZtTCHSD1r+h9qW3WfRaBs96wS8vOcFvTXYS63jz/ZFmIIIjOhNAGeFTk/of6x22skaR/IcSFI94cAyFM+F6ZFYDcbmGpRCcBSQ/ynyqC0m7zuFp3Io5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FBLNIYPO; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753372135; bh=KwKeW8J1nTUuct1uuMWKRWPoeb2EfVrnBdJ+Z7/C/7E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FBLNIYPO/+k+hKRTTUtiJOQpctC6YoQ1HeIl8PVpPlapxhkEBholCwG/qkbLJwvmCPNZiMF90+KcXilgcAM6DsN1FV3GQKTFc5mQJjK7b5WgSBlxDv1/f/xcmL2rLARtI3dDGqO1iogkm9lcmbBrq4DF2P1ptH+ieLLQAvjeHIxzXQ1o/v5J9L2HCcSJta6xC2kXGM4oZVLet/aQdt/ZxTwWxbIWrE3t9jQZoJ9Pg9cvWyyyBHSaQyYqgv+Cfjolt7OmxrsNs/RFnA2HtXM5d8duAODVb88b+nSIuzV9xfsnKEhbNBO0nYM0YrMFJH5FCdH6228DbCYLCa+TH8o0xQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753372135; bh=/l426wAuuynPHI8Ikajo89SxtYhNDvMSH7hJBwJGfAa=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AfEMXSMwMpI0UrnqX6YdWug1DC64F8wujdCCACMqE4iebEKb1aZhceLIq5nJsZ6zh0Mt/SIxRMCmR591lOdn2eFNm7cc+eZQKFcuOjx4rtVy93a+WqjDLTd+tvFtNvf17zKLWR5mcRslrWd5G6p3+HeXS3x/k1Mfg20LffQYcWMO9k3WWDnortBlDAIynV3PTICEh3Q7Rb+mOhk0ueIXFRbODcUfKSi4hR9CDsEXlikZCAuCkKCYRtv3q4wW3wwfUmbrsz6oDipkM49r1IeK8c2+0KmM7Cg/U98QNoujt6brH2dQcurDEgaiCHJMu3hQKm05A/rP6W0JP1SDs8pW8Q==
X-YMail-OSG: 3ISRCKkVM1lpYUnxh9tlcg0wOEwl2LU7LJ4REmT3rIyYmLEkqidq1lsyL2xg4j6
 iuIbcs36Z633.ATtSjtfpuCNvBOIEE.YQZTvTmxWKm6mx7kwZm7cBtyMw0hn4UWlv0qkffssDr37
 oW3wYyC1mat.0lv6guCS6E9tS2vdflbMKMgQ.kXXMwlYtU2SDOEDGA5YiiYA7QDGz5NGf4ZW9ZEv
 1WveabOrJLPL6.VPZiIz0zazQBxi_Oa3sEgnJrf.cs3ZsWq4pzlN5cSu9XHcvTcU.1LywybQqjtL
 87mjo60lKs2EX9YiS66G0GGvLn6kntBtIA0ejAIIc9Fdh06DYrH3vV3mQ_FAkIpZ3uX_jbGuJmzC
 aHHklrt8nKa3VVz2BRMiOWd_5og1Fd_jWk_bL96DOykQyz1dXU.I4Mg.cR9AZoCa_ZcnX92PeTZH
 F.a8OUnnOK3x.BobHpDk5nsrxYYrUz7KDoW9zJg_qDIt7cU5FYcDDSfZGN6h3h4d3XUyBW_UGwSp
 KY.bR1hPBCfLOdj5zy7Ul6ldW3ALaJGkxxqJeVxmOyqB4MRERkoS0yCtGTMaSbaN.SRDipGGu1oo
 cBtg8hdvkpmIKGS8ksjPVSJH3G9j2.O3mtwNpqACUf7xDugE5IV17HoQrPTF4cldgFf9BLObJAzj
 Jabg_SVAHAuO.5B0QvC12sAzyvEZzyMvFlomBhdHPQKfU0sPtfflEqvqg8r6uaFx8puKCDU4HLiu
 ZQoKJNUALrvzCQzajXWu2o5khTEKFGSAhZuEdscG1qI53T2WJQmjZfxCep.m1dd8wK2ZjnitK3ok
 OhJmNDVQ7e1DqOJLONHOyn3HxcBavH.Sr.YIirFbmbUy9F2.BwgeL6RXDFgHSA3oN7zUyU7l1Qtm
 tcaHE3U8pp5B3qP0cCcH20E5kDvMJzoeG3B3arGGVSNhPNCLT9SwRs39ueH32mn1GQb5G529fzx_
 CVArS39XfFGtfv1IEPM0bZf1.9aYfMTHmHommmRdxTAFa8JYH632ttKA00WHCPWocs1iAQor4TAH
 fq5fQiDAOgjRFyZvBGfpeUNPMhW97XXnEab9hdTN60omqDCmS28QaUS_8gVwkVr8KCGk1N0aqEpQ
 rExk3OU6crqHGWN9MNP_GhEJQr1O8b9VG5hMCg0RHj9qlNIJCuiErmC3bYzITv.8UA5nTyORHhBE
 piw88GdI0S9fgg2iqT_V.VOCeZnI3U3KheUOKaAAwesqvYdtPg74SQkPZ409EjS1FQ5rmBPwGP5_
 KRcWuHGroiEuyldjJr3jgmxDmz8fN5EMYyBE0cjAhDl9BK1A_vsdPjIHWE.Pqn6ECLljaDbJGvVR
 _yLBybdNOrhRAPdrCr7PQia9WQ0.UBJzklALx._wgdo9OYGkpRhnHPrtcNreqQb_BJXHheAl9IXR
 RIQ_3svA3wgQMqUzhwFZa7A.VNpva3aEgDnIxk1CSV2un8vXAjGhg7ZldOecchgPYq4avZnLh536
 JiI0vRHVvs83c_sktItB7u4oCMDdJ4h6.GfP8pUBt2hJ.KNhw052RVmxjOHRF2bxjUOwJzdQVFsI
 DiTVHika5a0VtkZeYfBbDWEWZlDfkrSyCTaR0aXUIVTY9hk8.rjya97wDTabBdVOAaWH6TDvqnxs
 z.O7ibJpTHJ6ELR.DXXZPT_1Ho1.ynPaBKU6qcfZ3_8xhprJhMvZSy_6CAh5WDNcgLGdVtge4ztU
 v.eLyQB7eiQFnuSVhHhrb7PmQ6EH10mORdikRotOb7.2MY0wDY6KGdh12gKnRZCZOJrXvIHDpRmh
 8UnssF5aWTtz3ZTJqmEHcF0E4WtWbrXbkqb54MKwAdWnO4Vvdqh7QE9fPqongEe7dKWVPD9BAoE5
 XohLA.IvnUa3Xuijn17525DrAvV2jpb0QbWO8k3DgLbaKXq5P1NuYTYGzI0u59usED6tC7hCB7Y4
 ICJLUHgtSdOR0YtDPFWUbMAkvGdynGjEMGk1w6YiP7ki96gIarGG23B5VFNs0wllcqog5KhljVYs
 ORZvjow3soIZB8JUq_yLIC3YJK3JayXS4CiZxSrwbPmFILxFsjRI3iZoNBtWbyTtX0ZkiHu02brZ
 3QVhNeMYv0vCtx2pGACgxIFl8Jnl7PHpg16Om.4mHZlM_t4mdmnLTJBucQX4l0bkE7H0am6nbB4c
 KB0JX2Ubs9IrxQ2jLSb.tdsguTT4a9HZWT6rZeONiG6dmN43ltmxxmC70J02.AdcFeX0pHlajgRl
 kpWGpPJouj.Yam1n.KgVmcwBcbENIlbCH5beG2c7DmNqxPbLJAWU5McffSgT4yygVIsZ3.DYLwiA
 puwDS9Y14hrLxhsZrzbVHvyITEDTd9zPF827ltGnahnhktw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cfceda94-85c3-4414-b59f-d6257e31f2e0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:48:55 +0000
Received: by hermes--production-gq1-74d64bb7d7-mh87r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 061fa2e34252f4ff20978e548f48970a;
          Thu, 24 Jul 2025 15:48:52 +0000 (UTC)
Message-ID: <d499e2c1-69d3-4b15-ae0e-84063274c9d2@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:48:50 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 15/34] lsm: rename/rework ordered_lsm_parse() to
 lsm_order_parse()
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
 <20250721232142.77224-51-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-51-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
> consistency with the other LSM initialization routines, and also
> do some minor rework of the function.  Aside from some minor style
> decisions, the majority of the rework involved shuffling the order
> of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
> LSM_FLAG_LEGACY checks are handled first; it is important to note
> that this doesn't affect the order in which the LSMs are registered.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 8c632ab77da9..b1156f414491 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -225,83 +225,75 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>  	}
>  }
>  
> -/* Populate ordered LSMs list from comma-separated LSM name list. */
> -static void __init ordered_lsm_parse(const char *order, const char *origin)
> +/**
> + * lsm_order_parse - Parse the comma delimited LSM list
> + * @list: LSM list
> + * @src: source of the list
> + */
> +static void __init lsm_order_parse(const char *list, const char *src)
>  {
>  	struct lsm_info *lsm;
>  	char *sep, *name, *next;
>  
> -	/* LSM_ORDER_FIRST is always first. */
> -	lsm_for_each_raw(lsm) {
> -		if (lsm->order == LSM_ORDER_FIRST)
> -			lsm_order_append(lsm, "  first");
> -	}
> -
> -	/* Process "security=", if given. */
> +	/* Handle any Legacy LSM exclusions if one was specified. */
>  	if (lsm_order_legacy) {
> -		struct lsm_info *major;
> -
>  		/*
> -		 * To match the original "security=" behavior, this
> -		 * explicitly does NOT fallback to another Legacy Major
> -		 * if the selected one was separately disabled: disable
> -		 * all non-matching Legacy Major LSMs.
> +		 * To match the original "security=" behavior, this explicitly
> +		 * does NOT fallback to another Legacy Major if the selected
> +		 * one was separately disabled: disable all non-matching
> +		 * Legacy Major LSMs.
>  		 */
> -		lsm_for_each_raw(major) {
> -			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->id->name, lsm_order_legacy) != 0) {
> -				lsm_enabled_set(major, false);
> +		lsm_for_each_raw(lsm) {
> +			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
> +			     strcmp(lsm->id->name, lsm_order_legacy)) {
> +				lsm_enabled_set(lsm, false);
>  				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   lsm_order_legacy, major->id->name);
> +					   lsm_order_legacy, lsm->id->name);
>  			}
>  		}
>  	}
>  
> -	sep = kstrdup(order, GFP_KERNEL);
> +	/* LSM_ORDER_FIRST */
> +	lsm_for_each_raw(lsm) {
> +		if (lsm->order == LSM_ORDER_FIRST)
> +			lsm_order_append(lsm, "first");
> +	}
> +
> +	/* Normal or "mutable" LSMs */
> +	sep = kstrdup(list, GFP_KERNEL);
>  	next = sep;
>  	/* Walk the list, looking for matching LSMs. */
>  	while ((name = strsep(&next, ",")) != NULL) {
> -		bool found = false;
> -
>  		lsm_for_each_raw(lsm) {
> -			if (strcmp(lsm->id->name, name) == 0) {
> -				if (lsm->order == LSM_ORDER_MUTABLE)
> -					lsm_order_append(lsm, origin);
> -				found = true;
> -			}
> +			if (!strcmp(lsm->id->name, name) &&
> +			    lsm->order == LSM_ORDER_MUTABLE)
> +				lsm_order_append(lsm, src);
>  		}
> -
> -		if (!found)
> -			init_debug("%s ignored: %s (not built into kernel)\n",
> -				   origin, name);
>  	}
> +	kfree(sep);
>  
> -	/* Process "security=", if given. */
> +	/* Legacy LSM if specified. */
>  	if (lsm_order_legacy) {
>  		lsm_for_each_raw(lsm) {
> -			if (lsm_order_exists(lsm))
> -				continue;
> -			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
> -				lsm_order_append(lsm, "security=");
> +			if (!strcmp(lsm->id->name, lsm_order_legacy))
> +				lsm_order_append(lsm, src);
>  		}
>  	}
>  
> -	/* LSM_ORDER_LAST is always last. */
> +	/* LSM_ORDER_LAST */
>  	lsm_for_each_raw(lsm) {
>  		if (lsm->order == LSM_ORDER_LAST)
> -			lsm_order_append(lsm, "   last");
> +			lsm_order_append(lsm, "last");
>  	}
>  
> -	/* Disable all LSMs not in the ordered list. */
> +	/* Disable all LSMs not previously enabled. */
>  	lsm_for_each_raw(lsm) {
>  		if (lsm_order_exists(lsm))
>  			continue;
>  		lsm_enabled_set(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",
> -			   origin, lsm->id->name);
> +			   src, lsm->id->name);
>  	}
> -
> -	kfree(sep);
>  }
>  
>  /**
> @@ -319,9 +311,9 @@ static void __init lsm_init_ordered(void)
>  				lsm_order_legacy, lsm_order_cmdline);
>  			lsm_order_legacy = NULL;
>  		}
> -		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
> +		lsm_order_parse(lsm_order_cmdline, "cmdline");
>  	} else
> -		ordered_lsm_parse(lsm_order_builtin, "builtin");
> +		lsm_order_parse(lsm_order_builtin, "builtin");
>  
>  	lsm_order_for_each(lsm) {
>  		lsm_prepare(*lsm);


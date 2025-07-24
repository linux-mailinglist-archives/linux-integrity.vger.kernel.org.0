Return-Path: <linux-integrity+bounces-6709-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F086DB10EB9
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A9C3B3E25
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7222EA173;
	Thu, 24 Jul 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="B3Duyy4D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic312-29.consmr.mail.ne1.yahoo.com (sonic312-29.consmr.mail.ne1.yahoo.com [66.163.191.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16C2E9EAC
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371001; cv=none; b=PNlhnYfvYdeQILOBOP6RXXZ0BNpcX7MNUNxgmtvg2MY2728o/MzpimjU7XhLsHABQOUa+YI5YFPtxjmtpRI4k9Lb6HOBAB94+0bVQ0nI7w0QB5guIdjuFVKGVRZAqZQvr5Xwfb5xJG6M3TyvxQbjZtmb6wksqQE71YZ4AMsumYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371001; c=relaxed/simple;
	bh=bu4+EeurYeFCvN6EZYEkLMGgI7z1ksMkAjNB3fbChiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwJY9KJ8kIeKipauxibMcozYZaWZ3Wto1+ccDvI7u30i7b2IoQrw8pawD0fH/vni2BF2ag5q45TrLlQer88ySprecAQWlphJIxVPdjCyeCOHJLTYHiR7kV7nxmJ+TNjrmTRHtMzd3Ijueqwe2IHcSStA2HZF5THJZ7YTquf48p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=B3Duyy4D; arc=none smtp.client-ip=66.163.191.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753370999; bh=n89hw//G/TiR4YffPd0vOqeZKCw+kE3uOGRCRP5IHog=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=B3Duyy4Dr8eWTL5ep1zfH7305NOV+G3PEwk4ry5udASdWUVKoQx/cq+QJTQTnTgIt1bVR/k0+EJH0zqzEPkDM7/UaBWF2vB2Fm0vXVqVfE3wMuS1Sj3kvSNEVoqIYvy8folm81iHZCodCLKA6FWfQueuhmRegP6rEDXDL+26P9/qm2fOOeNfMklEAgI0BpwGoOS5P0Vh6xVRzn0RxCGd7y1EFLPZ5Vpml6OrgIK8bpr/r1TXR70ZGXLPXkNCjIWBYjNVw4py+aGAlazmHxeA5VCCsSVHKLSucixoa/IFFUMJQ42LKWRDZymKFRGD6JrY7p3Y9EBU2aGWP8ONguhq3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753370999; bh=cg86u7/RPNa/q3piutUmvoTK8k9rLDFQgeJ1T3VDHET=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mXy4yXi3y2iOl0UWRSCK+EUIbITzNe/nhP6BL3Qrpv+sKPwW+QalM4uHzXl+KiYNAOR2ksr16lh+qgsJb2XXF2IfYAKz2/rK5nauCW3lBKkJGyx6hxpZsfcKyvtHEYPSHfYl7G7M/YaHRqsZrjXDjGpoGw96/RX1AaAUB+RxuJzQ0UJqhVBOP69I9Gq20SoxIBfwdvsBv/U7XKqz4z+MZeJHSvN2/oBLpIdPALeMg5FU2F1mxP0qmQYc0rJMhOPjsaydJ4vZXp9GearJ0DnfjKFugMCJSDGhhXWsWHlPreAnutGn1B5x+tnnNTgdXa9MntLnT1dPCJEP+73r0D4QEw==
X-YMail-OSG: y3UlXPEVM1liXemuqzgj0ZFVmC_hY33t8yOhlcwOvTLVL_7.fV3kHKD4CWBu9HQ
 BTzMo7EjNPBiqfeLBMBqm9dlBUmKvkIR9DHJ0IMdATfCLE.QhZNRzI3ouU34kXshaMMbDScWl6dL
 v1hxT6rvVjx17iAPmODq_AHM2rP0ma7pp0wLIxCVaw6Uzhj7POllzC3I.8KOmqducAPllJB0pLe9
 H_f8sOA7GLpox4EwPt8XVp41LoeEZkeKXXisxbM7gC1MTVHS3_BR.pUmz5rInzFPcoiwwjHWuDw1
 w9Qqv.hN1ECI9jzZFvVBLH1RrB1Jzy9PYDBDc8slcWV3tudVq46X.fcCmQh_ygmKFJYVDy3RgRNY
 rpmMuyBGyqyz8.2HFqrLTH2QtZaX6uD1EzRfI.CJvJkb.B0cfQYgWIwu340G1M6hPaJH5AGpes_3
 CmJC5gL4RverRTgRjVjIVLiou_.D_q2mYqltIcxU6AKkcpRbRIIgTDO62XlzD.zD5aMp86JUR7BZ
 0JxXWNiDbrAf0aIRVpiMFN76n3QvoomIR06WL3aW1.q5waCpPmKu4AFVEOK3EaO4qj5ZY0MgCa2e
 F.5TKQRd958H8R9AAFOCRTwfaNl4rqdobiNFZCWUcAm_RMAm2usFKKSP6P2ZHQf3Kepo71eQk7yq
 dXf49kQ2Kla_9DR77FfTbZxJRCqk4rwQ9HPqnIr1rh4p4N_xT770Sk7_Qn2g2oUvXX74EpRm9QHY
 UT2gAkXJbMsWa_UbyKx43seT43Rh2ruVv9coXi2vr8KYHXvK6xzA7nVrzsxwY.DvLBUDP.vl4xG1
 FUYxwLE1486Z.LrEWV9qGanAYyvDb.FelyhYmLc.jx2OQ2CLb2VC8VNBCnWyy8YGBc1nqIuqt8iV
 smOzALbwRR.KvUSWa3AFe.4szaNl8RuTPJKP5RbGOqPQdK0QHSIBqLKEiesVo78yFan8HdWvVWlW
 Eezv0aEQChGWywOl9zeZTN0ffei6MnmTAAjKPko2SF8di4NdophZY9RNIub4.hy0rpRAIWLz0ov_
 SfvGFUTpnSWXvgwa1zAMF5.cBSEWCJpSy3nvGsJzS05iGKPgLIUhqROQvyENhmdfh05ConQ.rq__
 b16tQjXvNT2DTOM5NEiwaPP5j4J.86_29cMMAxk6H91xzG4d8Y8RbeaB35R5PcCfdNkCrULZQ2Uw
 QVo_B8yTF68_cv35bYlIc3TDrvHQy0QSS_Q1wP5waaZBSIAfki_cPPKTF3ML8kZDW27O66aaXYMl
 3ePt4Rx6lM6.gsElQUROMA4Z8KIgjkxqiqIBILj8qvxroXxVwB.qMNnD0WizAvDiOVNyWyZ58qtJ
 wjN.QgchEg9v_CbTdgOY8W_kfXSg4KCngUoIrzIwXVf7EUtnZr8DiA78j8goBKqNPTZMC46nZtNe
 GkE9s7t2vnuZ0GzgpblehyaVBJOHPLnhqHNcDqkbvXnLg.S6JVRw7vO_LeOiy5H1897uJL1PiSnt
 T2C8r1CUHoqt1REl1BXQGlv65HSr8EpiLwi0Ls1gMD9qOKFI7AaAZ8BpOa7xKhyOvyrDNYm0N4ma
 Nvczehk81cAayGw6Jw5wGHdcy2DE0u6.9Jhn2cP.W00OK2Hr9vL3jRiF.B.gMUP2tB7_9GX3T09T
 twvz3N8LlnkCnRr6TvCxmVP.2nGWut6mmooBxiu.mmZbbULMFlmi40MT_z7DsB_4yZLytTQknGGl
 plLdTtaSuYdprOY89rQudaK2AjRba42Hna3.RK6NjqnEwhCXNef4AXQFj6evq0fVxO_IBMX3Crqr
 Vk6sm.bA14lEhdgnulHNA71S2yBqQX6yrsUHZxzJzGFmFUt3zWGXxbca9Te5ZfFdvkBLr4VZH_8F
 QoCgTMmGJW.1qXCT3n3Jb_aHkeTrNkDB69uM1GsTBblK0yaS_Gru593p_JeMbO.A7RcBZrggVMUF
 89gfEk_bF7orh0lQ665worPTiROiEplGgmR7bKBm.Lg5ltt3OLKjXoms4Cw5hGoAdy_3ssFFP_Qa
 9VvZTP.2BSwIYzFJtphX3CGlWOy8.hKMdpEYHlao98qmIcygiKIQYJciaKjxvImKUug2Mtm7njWE
 OYA.C52Y4Pmp_DEdXipjylooemxzFXgFl97daGnuyJ71TDEq2URZ2Vx9MqW.yRl7vB._asmhhW5o
 mWlAjwgaV.n.YY0trx_4FNz1Fl1ZPRlvBK3z0wm9HUujubLkXlOvqk7FQuTXhPLp_iUPUAoEwv8_
 Y.agJaC89zuJ1HjqdWyNbfGKyUL2vamBL1dTmKBW98SCbLVkXWrd6Cbk7Si5OtSU0cYdUZwcFT69
 psfiuUM81Ii.arjlPb8Iftm_I0j9W_0hYrQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ab3cd072-44aa-4f2f-90dd-ef67ac1ec043
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:29:59 +0000
Received: by hermes--production-gq1-74d64bb7d7-2dlqg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a4d55be7f5ac235f3d5ce4ab540a3c6;
          Thu, 24 Jul 2025 15:19:47 +0000 (UTC)
Message-ID: <3f1d48db-5a92-4f4f-9672-5f2da5f90c4b@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:19:45 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/34] lsm: integrate report_lsm_order() code into
 caller
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
 <20250721232142.77224-41-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-41-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> With only one caller of report_lsm_order(), insert the function's code
> directly into the caller and ger rid of report_lsm_order().
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index a73c3769dfea..d20c6df55e7d 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -288,26 +288,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> -static void __init report_lsm_order(void)
> -{
> -	struct lsm_info **lsm, *early;
> -	int first = 0;
> -
> -	pr_info("initializing lsm=");
> -
> -	/* Report each enabled LSM name, comma separated. */
> -	lsm_early_for_each_raw(early) {
> -		if (is_enabled(early))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> -	}
> -	lsm_order_for_each(lsm) {
> -		if (is_enabled(*lsm))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> -	}
> -
> -	pr_cont("\n");
> -}
> -
>  /**
>   * lsm_early_cred - during initialization allocate a composite cred blob
>   * @cred: the cred that needs a blob
> @@ -338,7 +318,9 @@ static void __init lsm_early_task(struct task_struct *task)
>  
>  static void __init ordered_lsm_init(void)
>  {
> +	unsigned int first = 0;
>  	struct lsm_info **lsm;
> +	struct lsm_info *early;
>  
>  	if (chosen_lsm_order) {
>  		if (chosen_major_lsm) {
> @@ -354,7 +336,16 @@ static void __init ordered_lsm_init(void)
>  		lsm_prepare(*lsm);
>  	}
>  
> -	report_lsm_order();
> +	pr_info("initializing lsm=");
> +	lsm_early_for_each_raw(early) {
> +		if (is_enabled(early))
> +			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> +	}
> +	lsm_order_for_each(lsm) {
> +		if (is_enabled(*lsm))
> +			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> +	}
> +	pr_cont("\n");
>  
>  	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
>  	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);


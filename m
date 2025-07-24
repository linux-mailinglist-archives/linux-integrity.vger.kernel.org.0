Return-Path: <linux-integrity+bounces-6715-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83317B10F09
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB77AC137E
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60562271462;
	Thu, 24 Jul 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Elf4X5Na"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic312-29.consmr.mail.ne1.yahoo.com (sonic312-29.consmr.mail.ne1.yahoo.com [66.163.191.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E57EACD
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371945; cv=none; b=fzZEddiDIBCojWEyoR633IJj5+KmBpgDK5c00TXTaTkM7Ic3SAPFIsBRwtp59+2+ZPftX+tP3Oc059/TPRqAK3T8HrI8yf7QveXFwYXphQyOIWDHuOa50sZCUDs5twCkZHsJmjUSgDVeU/2g3fgElZEs5hTXpm0zKtyADP5Iu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371945; c=relaxed/simple;
	bh=RfWx3IT/Dfi2vCX8TaJHaDlwNP4dr5cFydxS1VPapDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2VD4CCZMycZ01Jm/WX9Ksv1JNe+Rue5l2ryi4vON3nsP+p2IWXlEWLupEQ6EDxzcyWjS3J8quOMYt9ewi0yHA+Uh/v3B9fsGy8e+8AmAnEgS/mF/UhXJwmrP+09QPW8vtm9ilo+Plq9vbtap49mVQrWlWk6OqJlrLdbEaHjEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Elf4X5Na; arc=none smtp.client-ip=66.163.191.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371941; bh=drSZZJc7KnHQWPy3OlWJc6SGwU80UJ2QNCELJqDtJfM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Elf4X5NayY83GAp+JBwRQzI90v068j9jRIxfvHacZD8M9UyPEs6ND947zTjpZfIRauDmBnTdoZLguVCqbEnkx4ECs/g+K4LvUwEpgL2bngiuzJmFiD5uSMmw9NYZeZS+PaBMHJq2btvfYjrv5/MSPj15RjtjRBizmu8R3YF221JGX/IUxrrcqXa+bthbbyVIg2ASuoW5WrE1VaaOnZEJ21hZgrmZcaTmXYs10V4MneOkPB3a2i/mWbnSSG8GQ89gRKWsA3K4tJPw9kDwVZVeMn/I4G1HV4Mb1FoN8zjNCxbD7YiXtXB8z7FK81jURMnDZmGjQldgVO4XIo8KW3UlbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371941; bh=htRkHF/uFnWruv2vXwKPYLSKZuolYaecfBebow5s1W+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bsyFZDivaa5jfKfSCpdw1NCsuo7GDBfSAOq5Lps0ltSKekhkPpWOFzdM0z2oZAHpsiAlxl0PAfYHwUb/hD34Nf1rHczrg2hVO8Kqm6PVcI0FrVlyL1tF1b+Bw8neiLzRSOtSIrvFds5wwfLOyOkRoJLpg6n6P7VcYKxJ6yQBNtEF24ChGncdQt/q2m37ywUakxUu2tJX92aMBuVqShm5G6LZeNCdkDRGKiMHP+laqCsehpDkqqHAy9w39nIYcBP563QsNheMRbUINNOCdlMTbUwEcBYeSh6rIf2fjEx1/KH7GO24r/hRrIoK01zBJUH3AadyzVsx2ZGlvF/ja3MZfg==
X-YMail-OSG: ejFicP8VM1nVh50sgLHoFpk8Ky1BNz2CIw1XH16VYQ2B7mRBtEpM3xD0fPZG0PK
 i_1ihKK7zKX4aFIuYbfhxeNwGLfpJioaBcJop4IzFJwW4xVV3LYfEPbkKtmVQPrSL0Hz4pH1mwNf
 3yRxiKreSosUdPSHWNkQpcyVE8w_.lwPFRiChp2q3dO5BpH1vj18iZ7xW74tmHZ2WrzzwV8HIIZS
 weRXVsI8G_.kbv9wln8kZGxUGkVAGNDzc95jIyaAqGD3K8.fTToROJRdehivzPrJzH_Zo3b.F73r
 jIJr1tbOD6v__uPBZQJJ4nzk9t1Ip.1K1FgjTGow7T1HN9slctumXw9zngxCTWpUyibpkDMmOh7r
 J4BrUI_2s1q2i3bVVCAvWVcqLqdxQzONh0.7J9DlR83e_meDwUo08OTl2VQ_Pfz_D6DKZGCRdA81
 znilJQQAGi7eM48eOT2L5IbLwli890XWP.tjcanFlrh2n0phTifk8LwJKhh0T6KXUFzUakKlPr64
 G55KEhv3o7KY85cn0FcLEAjZmxnnLijtMVgD8A4Etgmr0R1VvDr8hynRdYxXwUNusY7Wo.E2lXLy
 gQ5d8uffuc_oL9lqiYiH98_S1ZBbGkP_CepNJRnWlxPu_iCBKcH69fap5xStSK07zVnNTaIdpgRZ
 Twhd22A8kqBieOorgalmwyxLtl4aU8OEah4LN2QdEUJkt3KVax1Fw6MAyyloygBrvUN2nXJy9ON0
 ZOPb4PPJdIxL.D3YAR5kiFOI5ymzfCIsVcOgzNpzSLCilxjxAAi3.nXEbWar_H_w7Muj36l657Wc
 lJgFiWcKEawYJyo4VqKx.EzPgp0hobHTJRdw4db9fXnqp_EcDY4I0E28aLnkDPtz95BDk1TjFJVz
 Cm8rkxSzJ1qjiaFQ4.ePJnBn8o7SP6GRGSM3TmBmZImHizgoAFf6AUpbYAFpEq2w8q2vMboZVHya
 PEY14K5g0JHEjgwaF8yzGfXR1c0nVEMjJH1LgYEOlNbfaXMVis6h7lJFkDkzvbZ1YobUek0S77Fm
 ZwrnbqiJ_Jkc1EpRbKrv.b7tS8q6lf0gm9nRgHKQ9xgsyOxZ9XuEJNp.gWo.CJ0xd_u3FBytqUZ5
 qFiW3iM_pSLkCFY2oHoBn6PeiIwmVIztroWbOz1n9vTK724mWGEJI0xabyAwS0._q00cfBUXKZtp
 PntyU_N7vDrM_CF1hFR7SxyJL.Sm2aGMypkmq_6SpoDX5.NBuN_3O3T5FqLf1oiuMK20rMjgChc0
 OuA7oMKjcBaVlmBfah5RYZMbLI3yIPRH3vn2hfhgLbUfkmjGChlY3B7kwp75jfhtTU8JpIImJuQh
 qRY6NeFkNY5cvrSPqyGyz1kVYLThbc8i.Dtb8GKFHpQcnK_4n9x8girKFMyHIV06SSkQJCczUDpt
 l9RjrTYsN6bagcQrbrUtzWBURAZxbu7xs6VU.PPxt7EZulTFVS7jNMteaPBW6NdJetCm92dpV.CL
 pnGdyx6__CHYrzyyHjdG5ezP2CU2U4qIzsxMnadCRnpaKg1ZEwJvQLbRgzee6VRcucAW6AWq2To2
 KbFJUq5hPDYmMN.g245FMoRSiOGgb.f.jlWvHtX2kKGLdzo0i6BB6BBpo_XuT9YXHWjKGt_MGOlR
 Gwuvi7Zl87GL7_nmRYMPfaKSQMBVczD83sbtQsjRiRKti_8ZdDKsnKGFnqk1cMXVGgwKEW_yNEYU
 p9SMBoyKpm7oxXngFaKnH_CGge2qiaHAaa3SIVMSxDUc4HRpDbKshXQ7XGIG1tb8m6Sy7fUQT34N
 9Vbc_xW2Fi_F26W9Tuui_cXV.3eN5A11kN3kPKh_CR6v2Ecbdp7moKube74pG7cch8SBwRQXF4HW
 xWCmbslpeDgdbNB2oYYT6BvJhjuG9.BkGPRea0MGZMVf0HIHilUru5RPpJLyVRKzYbgD8vKKnGug
 QowCN9COkErryY6iLa_DyI1XllmCdZif8zwYmV1ASZVZQ9YzqHjdd8kZlf4iY_u8szkaHyNUTIuq
 .pjAMSqjIe5QrhVfXepwmxvODe3m3dIDFsAHKijxtz4Fs.FjWTIf9jRHCvim0LTUV1rnapykDLwq
 xnlP8puVUgDhdnneX57F_qZEOk.6QXSmCK.WtPdMIOQyzjrsSnT2W4Ump_uNjnNdByCKmvaXigq4
 LCUZSX.QF3cg3T_ZA4SRdcab4jhLk5wBiRUruQlAHNwDg21C0fX9wIsAa.AZGY98azR4aTOm7za7
 2uKD7JntamfIb_7gkIUoIWm0E6crEnOjjvji2rlioJsXfjKbo7NIcGNpOnQERZ3Dmut5MDHEsHTs
 yD53aSGkpCOOxz6BOTPHpJ2tqI62Odivit5.5ujN4h4rL
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ffe29407-1ea1-4b60-abcb-87dec5ba8e0a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:45:41 +0000
Received: by hermes--production-gq1-74d64bb7d7-nrjbm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af95a8417b47573dc49b0b74d139f449;
          Thu, 24 Jul 2025 15:45:36 +0000 (UTC)
Message-ID: <74bbeb65-a1ee-498e-9de1-65dcf72d1079@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:45:34 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/34] lsm: rename exists_ordered_lsm() to
 lsm_order_exists()
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
 <20250721232142.77224-49-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-49-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Also add a header comment block to the function.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 14bb6f4b4628..01825da2755f 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
>  	return (lsm->enabled ? *lsm->enabled : false);
>  }
>  
> -/* Is an LSM already listed in the ordered LSMs list? */
> -static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +/**
> + * lsm_order_exists - Determine if a LSM exists in the ordered list
> + * @lsm: LSM definition
> + */
> +static bool __init lsm_order_exists(struct lsm_info *lsm)
>  {
>  	struct lsm_info **check;
>  
> @@ -126,7 +129,7 @@ static int last_lsm __initdata;
>  static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  {
>  	/* Ignore duplicate selections. */
> -	if (exists_ordered_lsm(lsm))
> +	if (lsm_order_exists(lsm))
>  		return;
>  
>  	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
> @@ -266,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	/* Process "security=", if given. */
>  	if (lsm_order_legacy) {
>  		lsm_for_each_raw(lsm) {
> -			if (exists_ordered_lsm(lsm))
> +			if (lsm_order_exists(lsm))
>  				continue;
>  			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
>  				append_ordered_lsm(lsm, "security=");
> @@ -281,7 +284,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  
>  	/* Disable all LSMs not in the ordered list. */
>  	lsm_for_each_raw(lsm) {
> -		if (exists_ordered_lsm(lsm))
> +		if (lsm_order_exists(lsm))
>  			continue;
>  		lsm_enabled_set(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",


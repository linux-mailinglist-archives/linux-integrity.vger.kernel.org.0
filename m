Return-Path: <linux-integrity+bounces-6727-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC92B114DA
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 01:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BB75A58F1
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 23:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC03244681;
	Thu, 24 Jul 2025 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fFRhge8P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCF243367
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400636; cv=none; b=gm6FNyEtRoTFfwYnvwsC2+HRFth4N+iJXI5RzIs9SRM+VftT6OGesz0RFKG+2nnx8Zewx64EFYBfi9KTPDG2X463U2LFBWYFBTiyPfsCmLCt4yE+1AuLJ42wI2nr3vJQh6E8OZLvnmJvGGWjMvTWcHqDjQDGUvuNPho9JUoaQOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400636; c=relaxed/simple;
	bh=YbOeze7ECz3Llv4uDVl8l449YhyZ6RW9K0G37fCuqMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvLCJdUXZGhnSOrSyAxO/T59+5ENXIxP0GrixT1I3nxoGiSF+XiYnibX5oZXxOZVaao9+WclOr31WlQBAz7uScgo98CifOQ6MiwEYaW/yQg9tMES3+aWuC3/BSyGJOnODDOWogzSvlZfufd8HIM29NY8Ql+7jed8ZeNpSFLRkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fFRhge8P; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400634; bh=uBigJSQPfynB0/6KQaVWLOPeIA885N2UFq2G6FlXDMU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fFRhge8PxAQz2ioYJqgMP2aewC7ejKTRGW+8zzTIZAz2tFgkZkoBkcWnOAmZq/JLfk5WfHotNfl8YsvtIDEjIABIG4J9flyJV+pPgticr1Iq4fB6HjHzOIMswtOapMmMG5pw71EBEWC1aZjuS/MKADI3iyyAhHkst/aT0ZpyfyV8ukRdyu8h+lNtpE2cNgr0dxH5UcGo4US5RUMJoC7ZvV4rk1IM5/YXEkxCDZwcwGxu7A8bdK5ZbrRISxZKBXEV/oWn372v8MwgRBtgUwe8+HYOxKNqy+ctnLYI+b7Ii2oWnVI7mM75/UlbIIdpzMrnFby9PVYTxZtSgxPBtVSrBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400634; bh=KFBZgjtO26njdXHElYPwbTTdvb3omgHrdN7ThbWItnk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UwjztbtbvQVDOmuAw0NFV/tsCSMTl/B6587Vw9lRUIcyqK4tGBRXtOr2wcOcGrbYo3EE+bEmH+XFKysffw1FzwsMBy4svNeKdaT+cdkcly8iFtjcRfvCpgOUp8U5lRjmWrsFYRmQ6L3+1YIN0vpJJ3OHwEhU3mzqZYR8ae1wXG7zpeyXxXyk+KpKbzBnSYo3gZRR1TeT/FDuJaRSfjybSlDfLo3WfF+NLQRV0tBMYGAk/u5aOpM39rgezkjFht1iEB28/ZRsVhIO36N2sW98cmlkJXgKHN1BXqlVdft1XI9TWjp/0cR1lYJWf1LAtFBtAngLXQdBEgH6fMLtRFTnIA==
X-YMail-OSG: gC3SCPgVM1lD6VuQu38NS87Kg9mTEEalR5ODOUuETJpYEefelosPR3gqTHsGNgL
 Xx.Kse9mx3nyfUB74lZBTlxk.DWPysbnaz1kKRqTAlrZj6FEf81vYjFbQ2xp4.D3SxBQNWm6dLCB
 MRzym6v.cruvMeL8beEXaR_yMJBwD_cbonbKECAP3v5YFTDhM8I0OOXbvYalDQt66QtfLp7ZSsYd
 dpAtOiFIQbv..ypRFTX0KwpAIShhJmWXXKqv91W5diZbFdtL0veDB0td16Myr_EKnaqVCpyphN5y
 E9IXpZqBCz1aCkZzdyQp3joXb60V42W6DTB_1AKuxwcwExpr3EtVmEWnK.he0OzdCzeryUrZCOv0
 UHiljBU_AAPplZ.kCmVMLfpH3d.Kfcy7Y.PT5hSZmMthpCAcz7.bQrT1pfs36zcFv6vKJc10LMlP
 VHAApf1gytnQwC27ifFXM0sNIiw76EWybva68GEZXnEqeCREhXiWNDnrPHaXDDSg9yOxKmee979d
 EeaPDaJjj9op1KGQ8OHJuIRPyS098JBlXpMoeMl8E8oJc4C2dG_DqlmeiiYQwnq33tPZUpDZQSkC
 McDvuhBJKZhcBbI7ZCB.T1pJjj61MC8R18Jbocm7fYcTWDtvW2Cwl4CoffcziDgMgfg0qxPDsiOq
 9nnt7MHBfATuA5mfZNVwtlWmf6p9nVtAOuN9.rrC.7fzwQqtpCxPDBJvVYnCGvZQOTqvadw3g8H7
 gETwTyKS9Dr0vPBU.Rn5vUJJJA8dyKLh9JdG..3tNveyS63PP9sVFGgpdwb82udWVxYRwah9LFcI
 mhXRGxuZ2yz3hF9mLWjrjz3hUO8V1PiCbZW.yhCsEHjz0MFAi3ttAYYBDc6abCKflpcjeavR2a_P
 ejafuLms_KLgBJiXE7bqHJ0fZ6P1tiFDRxUBi5odCd9X0qDUd2bzMpjB6ckDps_vqeLDGOU0WhkF
 NVDh9vH2YF9HeFR3a6gT9EGMFhaaMyr81TVskRaTtA7S61b9o4PgED_1318K6VWLeUF4trsEROWS
 BCdovPHqXhMgKEATM_tk_G3lc0YoXaLguxeFHOMhJqcnZEbgnyXBGfmmuMV0ZRzn7JHcaiR7UE7R
 1vSIvI9W.EVoJNCzDuzZvuAYIFJnZfpgSOBMf7zN8hsf2WTda84DwpitOSgjfL3JEOtRgWVmPrnJ
 0leuJL1mkPu6jzHnjnYYm9_ryNyuY_WwER7.n7BBWQeiaY30UOhhkcISFrSs742cR5kstQibwIUb
 ZWK2hhghj3YdRCaAgcaFaIwEG4yc5qq0mOtWHWbWVeUNP1g2srwhQsKR4e67Lc_Mwx9r5gsa1hUt
 0L9v3tOaFEWuolcWk42JJWaN83ALcThypUkhLvuPyb.1forZkjxXYM8aCAVe3JYsNm139jzObTOr
 Llyvx_b0YNR0KIj8CJ5b1CGkSURtYRA3Oi5UBSukhppfK0icGY8qsx6Aec6QKuKJSuItut4MPyR.
 6Lmcdy7DqwcZAtn4DsiypcjuBrTMrq3xHcEuaiWOsjVX4vnRUsqaobJ_0ee6afshJuXS1E0pkok.
 1xx4o_sVtwWwSKgHNWL2aZnEsw.MHZbUJx3ql_ZLwiHyMpm2CGBLttqkogjRxQ0TgX2IVI5zZ1ZJ
 tgSPYAQRkZDvSytQ.tlAIWW3A4Q3JZXIbTiHvYV922at5VzQM8e06D9G57qPj6GFwYCtHoQwn7Ho
 OMTh7qEw152Xek5dP0SPvkYJywK3bEh6Gs8exVyDfZ9AazNPAdTskIdL8CBujsX58eIPxF5PwMju
 b.BD1mZW0gu8TVFkdU_9eRPQh882IQJCfgVCLvEizYzOMjWwy7zxEQPpNrSCg.UQzKFTOc7oNIbi
 F3Iqg.z4MhtaiDw2h5jlF_X.KzHt9ZkQPM4uEDcYqPB3EUiTFc.LjWxl_Sb8X.QpyWQWZyygl7JJ
 X8GoMowJJuwGYtDwtK.MqEhm3dj79P2af8VzmdpaBVDo4EQx5LtYBvs2a8IdKlEahRAmTqfB50Sy
 3s.B2N80SHoEev87nMrBmI8f4Yl.D5MTOLZ5cAjXZkdrxGq2UhnEePg1pe_oresOe2YinJSNvS4b
 _xZVDI8AAWDeM.z5AHdHPvasTVTIcOu8hiFp_OgsCRVHhbE4aIAFXeIfefyZpTv0K.BqyqoRxemH
 1SbXaURIbx6i2lOXJLDBcF.IRlhanAH6bAatMtMVoMBaHiNxPKU3cLFByy4t4AMh2DGgONLuJ7BJ
 EinMIBXH611.B_5tvUzOYdTWDLhSLwTLILWm61nS8Diu0BfPW3chf5DzoNk3uEovxQbx13TGTq_s
 5hr8juwQj1G3sKfJ3tFU6_NmcYVwug8qt9q3Sgcse
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 25a8d14a-b37f-4bf2-abb3-522748c3eb8d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:43:54 +0000
Received: by hermes--production-gq1-74d64bb7d7-s6s6l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 711ba924fc937641c6a9ca1d4c11542e;
          Thu, 24 Jul 2025 23:33:46 +0000 (UTC)
Message-ID: <50711f3e-d498-4dca-90c4-347a2b32c3c8@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:33:43 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 21/34] lsm: output available LSMs when debugging
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
 <20250721232142.77224-57-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-57-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> This will display all of the LSMs built into the kernel, regardless
> of if they are enabled or not.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 0a8e4c725055..7e794f4515ea 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -360,6 +360,8 @@ int __init early_security_init(void)
>  {
>  	struct lsm_info *lsm;
>  
> +	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
> +
>  	lsm_early_for_each_raw(lsm) {
>  		lsm_enabled_set(lsm, true);
>  		lsm_order_append(lsm, "early");
> @@ -382,9 +384,24 @@ int __init security_init(void)
>  	struct lsm_info **lsm;
>  
>  	if (lsm_debug) {
> -		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
> +		struct lsm_info *i;
> +
> +		cnt = 0;
> +		lsm_pr("available LSMs: ");
> +		lsm_early_for_each_raw(i)
> +			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
> +		lsm_for_each_raw(i)
> +			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
> +		lsm_pr_cont("\n");
> +
> +		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
> +
>  		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
>  		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
> +
> +		/* see the note about lsm_pr_dbg() in early_security_init() */
> +		lsm_early_for_each_raw(i)
> +			lsm_pr("enabled LSM early:%s\n", i->id->name);
>  	}
>  
>  	if (lsm_order_cmdline) {


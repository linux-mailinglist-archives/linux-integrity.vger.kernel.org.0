Return-Path: <linux-integrity+bounces-5517-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B731A75ECE
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 08:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927983A7CBE
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 06:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873038F80;
	Mon, 31 Mar 2025 06:23:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58D610C
	for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743402185; cv=none; b=flXV3LqpkTVwxaz3dITEXLiMEpdfQXN63mOUtkYQP0vvul5ZZmCTfTv5MONFt8LoVuARFKq4YYHPBWLXCoiRU+gSRKzEs/8Dak/yxmOAZubzGK4aS3UlxfGzlq7z2DnlxiLDTaX69xm5cqNebFIsznNxMuzbhL5aRMuf4jOGIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743402185; c=relaxed/simple;
	bh=oH+Wbu6F5z9wb8fvQB+csw0VGB1NqVeGjkD0sTvS0y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zml7YgCeuwBxCklwPpL2qZvN+S/Cp1u66eLOU+kXhIUY45Sr4p9tasquLALwtPpBiQYg8m3jFoSNH2/WIlJpF8HCruBsyhIPnLgcb8u6NsLuIXGf8iY/kImxYYxmN2OY/zE3u1hRJhuEXEtJAqkRr3gsjnEMHMGejnFF7LKCTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae850.dynamic.kabel-deutschland.de [95.90.232.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9DCC861E64783;
	Mon, 31 Mar 2025 08:22:27 +0200 (CEST)
Message-ID: <42ae3379-992e-45fc-acfc-0f808ff0d406@molgen.mpg.de>
Date: Mon, 31 Mar 2025 08:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
References: <20250331061611.253919-1-bhe@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250331061611.253919-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Baoquan,


Thank you for your patch. I’d add the knob name to the commit message 
summary/title, so it shows up in `git log --oneline`.

Am 31.03.25 um 08:16 schrieb Baoquan He:
> It doesn't make sense to run IMA functionality in kdump kernel, and that
> will cost extra memory. It would be great to allow IMA to be disabled on
> purpose, e.g for kdump kernel.
> 
> Hence add a knob here to allow people to disable IMA if needed.

`initcall_blacklist=…` could be used already. I prefer a dedicated 
parameter too though.

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>   security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 28b8b0db6f9b..5d677d1389fe 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -38,11 +38,27 @@ int ima_appraise;
>   
>   int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
>   static int hash_setup_done;
> +static int ima_disabled = 0;
>   
>   static struct notifier_block ima_lsm_policy_notifier = {
>   	.notifier_call = ima_lsm_policy_change,
>   };
>   
> +static int __init ima_setup(char *str)
> +{
> +	if (strncmp(str, "off", 3) == 0)
> +                ima_disabled = 1;
> +        else if (strncmp(str, "on", 2) == 0)
> +                ima_disabled = 0;
> +        else
> +                pr_err("invalid ima setup option: \"%s\" ", str);

I’d add the allowed strings.

> +
> +	return 1;
> +}
> +__setup("ima=", ima_setup);
> +
> +
> +
>   static int __init hash_setup(char *str)
>   {
>   	struct ima_template_desc *template_desc = ima_template_desc_current();
> @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
>   {
>   	int error;
>   
> +	if (ima_disabled) {
> +		pr_info("IMA functionality is disabled on purpose!");

… on Linux CLI.

> +		return 0;
> +	}
> +
>   	ima_appraise_parse_cmdline();
>   	ima_init_template_list();
>   	hash_setup(CONFIG_IMA_DEFAULT_HASH);


Kind regards,

Paul


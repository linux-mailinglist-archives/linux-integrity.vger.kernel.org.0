Return-Path: <linux-integrity+bounces-7169-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236EB860C5
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 18:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2F11CC172E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2276A3161AE;
	Thu, 18 Sep 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXQZpLIS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDB3161A7
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212883; cv=none; b=cFcOsQSP/Dw5hxqhbS4pDjsBjzxt4C6RHFPzDG+NyNk6vztSThCFR+QhJ8tPlzxQn1rHFHKvgzQrFTyyoAmBFzfPnYuYFQqizoPUsWm5Df/ZWn8YraoCOxPWVgN/3r5IrxfMeHPzziMOWqwt09BMUEwSDBSSErct5FPosYYmFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212883; c=relaxed/simple;
	bh=3Qn24l8N5Au0KLn5ucoyynfgIDi0rungOsDhIyBOEto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJVbsy6NZErmvgB3szXOrQuajnuHScI1aV9WH9W3+0FANGSmT8JCJUMmGbIdeRJYZGJfyPtz+qiO9tC6oOGZsM/8cFpoSTK+uEf/L621MG+AZM3XYD6lljnVo7DcfdqPN2PE5FYihj8d2v2jMpQSllpj4ztej+cnpxSeL/ROQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXQZpLIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24956C4CEE7;
	Thu, 18 Sep 2025 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758212882;
	bh=3Qn24l8N5Au0KLn5ucoyynfgIDi0rungOsDhIyBOEto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXQZpLISJmIVB0dtqgCYGzLlWXUABTGZ7YC6He6sIa29nQ3xMQkKNN1OicrF38Ao1
	 bCbJoHgd2Ybb3+oQrxJcu00gvv0xH6+Wo9JU7mvwPDPJ0nmZdsS5lulRSt1n2+MZev
	 7xl5IB/zTvjyfnnck6L1lR+IrZez8TBO5n2TEuMLdljzA56L5tUkeHUbAU/pbyZvLZ
	 ibTOn7hZZR8YTzye3/D5Awyx/fDBRCCJdoJxHwLeBrYFtbwwU191a4wq7vJlhZb78P
	 +PXtBqlp6QwBqQMoRrd2M9EQkrSDggcHhoN5tQkPbg3QKWoI7BL8SmEVV7ZVpqmtwF
	 5Tenouh1pY9pQ==
Date: Thu, 18 Sep 2025 19:27:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= JOUEN <fjouen@sealsq.com>
Cc: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Issue with TPM kernel code
Message-ID: <aMwzDvvpGH4dfj2O@kernel.org>
References: <GVAP278MB0280F83F8CE1884D26A0BA35B116A@GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GVAP278MB0280F83F8CE1884D26A0BA35B116A@GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM>

On Thu, Sep 18, 2025 at 08:50:39AM +0000, Frédéric JOUEN wrote:
> Good morning All,
> 
>  
> 
> I have created two issues into the raspberrypi linux github regarding the TPM
> driver interface. 
> 
> Issues are :
> 
>   ● https://github.com/raspberrypi/linux/issues/7053

For this I'd hope to get some sort of draft of a patch at minimum
(e.g. with RFC tag). It does not have to be fully working if it
shows the problem.

>   ● https://github.com/raspberrypi/linux/issues/7054


I.e. this: https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-Version-1p06_pub.pdf

It can be updated. I don't think that timeout did exist when at
the time this was first implemented i.e. it's an improvement
not a bug fix and thus I'd reconsider this:

static u8 tpm2_ordinal_duration_index(u32 ordinal)
{
	switch (ordinal) {
	/* Startup */
	case TPM2_CC_STARTUP:                 /* 144 */
		return TPM_MEDIUM;

	case TPM2_CC_SELF_TEST:               /* 143 */
		return TPM_LONG;

	case TPM2_CC_GET_RANDOM:              /* 17B */
		return TPM_LONG;

	case TPM2_CC_SEQUENCE_UPDATE:         /* 15C */
		return TPM_MEDIUM;
	case TPM2_CC_SEQUENCE_COMPLETE:       /* 13E */
		return TPM_MEDIUM;
	case TPM2_CC_EVENT_SEQUENCE_COMPLETE: /* 185 */
		return TPM_MEDIUM;
	case TPM2_CC_HASH_SEQUENCE_START:     /* 186 */
		return TPM_MEDIUM;

	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
		return TPM_LONG_LONG;

	case TPM2_CC_PCR_EXTEND:              /* 182 */
		return TPM_MEDIUM;

	case TPM2_CC_HIERARCHY_CONTROL:       /* 121 */
		return TPM_LONG;
	case TPM2_CC_HIERARCHY_CHANGE_AUTH:   /* 129 */
		return TPM_LONG;

	case TPM2_CC_GET_CAPABILITY:          /* 17A */
		return TPM_MEDIUM;

	case TPM2_CC_NV_READ:                 /* 14E */
		return TPM_LONG;

	case TPM2_CC_CREATE_PRIMARY:          /* 131 */
		return TPM_LONG_LONG;
	case TPM2_CC_CREATE:                  /* 153 */
		return TPM_LONG_LONG;
	case TPM2_CC_CREATE_LOADED:           /* 191 */
		return TPM_LONG_LONG;

	default:
		return TPM_UNDEFINED;
	}
}


It's quite horrible with all the indirection and everything and
hard to patch.

We'd be better of with something like 

static const struct {
	unsigned long ordinal;
	unsigned logn duration; /* msecs */
} tpm2_duration_map[] = {
	{TPM2_CC_STARTUP, 750},
	{TPM2_CC_SELFTEST, 3000},
	{TPM2_CC_GET_RANDOM, 2000}
	/* ... */
}

And change tpm2_calc_ordinal_duration as:

unsigned long tpm2_ordinal_to_duration(u32 ordinal)
{
	int i;

	for (i = 0; i < ARRAY_SIZE(tpm2_duration_table); i++) {
		if (ordinal == tpm2_duration_map[i].ordinal)
			return tpm2_duration_map[i].duration;
	}

	return TPM2_DURATION_DEFAULT;
}

This essentially drops the chip parameter: as of today we have only
common table from TPM2 and tpm_tis is the only driver that modifies
chip->duration. Further, tpm_tis does this exactly for TPM 1 devices.

If there's ever need to make it laaf driver specific it's easy 
enough to make a copy of the template into something like
'chip->duration_map' but right now there is no such use.

I think this would be a pretty good long-term solution for this
and similar issues.

> 
>  
> 
> For both Phil Elwell redirects me to you. 
> 
> How can address these issues in a proper way ?
> 
>  
> 
> On my side I’m currently working  in SEALSQ France (a WISeKey company). 
> 
> We are about to release a new TPM device including PQC features.
> 
> But today we are facing some troubles such as the issues listed above with
> using current linux kernel.
> 
>  
> 
> Best Regards,
> 
> Frederic Jouen
> 
>  
> 

Polite remark, and this also how vger works: use plain text email.
The list drops HTML mail and thus your original message won't
appear at lore.kernel.org (but since I responded this response
luckily will).

BR, Jarkko


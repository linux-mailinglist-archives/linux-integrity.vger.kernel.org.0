Return-Path: <linux-integrity+bounces-8330-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAnwIBW7eGm0sgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8330-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 14:18:13 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66E94C5F
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 14:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59616302659B
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298635295F;
	Tue, 27 Jan 2026 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fKRZetWf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ziIfFb0f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fKRZetWf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ziIfFb0f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57FE1EA7CC
	for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519884; cv=none; b=KlTnxDdIShzmBfR/SRHnf2+MW+1Au02fHQA6XE7d+All1z2vq71HEnb/eL4m1eKYzRJnRxXFVny5zRwQm2Cy0iys3ivhAUsQWA+os3uh9/xQDXrNktfpxgCProUta8uW7SEcGtAX+V/k2UKI6dTD4xSKpLBGPkCVFdgGUFBaghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519884; c=relaxed/simple;
	bh=iiiFiNdyXb9jcUtTnmVf2efs+aiTvkWWWhK32WPbvjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCB206Cf5FByrNKJ5ptzDneYNQpgCeBWePY09Jexhp6/jtqa00MwFuOOfoG8c692p3sgZgDnmpUcRfgC0QPrGtWkS49gYrcc85RLZ5If6XWlDwi+Jl7fQqDnPwXZArwd2Am6A1Pgg0siBIAXui0LwNac31DFNdpkiA8Y7bJ6Q+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fKRZetWf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ziIfFb0f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fKRZetWf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ziIfFb0f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B661C5BCC2;
	Tue, 27 Jan 2026 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769519880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7CfnF2kx0qMIIPnj5Jo/t+HYTn/GkMopLuRmOO+Hi0=;
	b=fKRZetWfMZbqeVsYgRCfG2lF88zv2A8Gb7PtBYhZGVY9dmnqqhXi6FyhMsXKzVArEzZMbS
	QuqhOHmYt/l+6g2ZOy4NLwHiZPQAvsPGciPJ3hx5smQ6BDOmm1Dnm0/sQR3fM+B4iSjQx8
	Y1exqAWPcFo5n1iHeuxh9VLsJTsAZ48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769519880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7CfnF2kx0qMIIPnj5Jo/t+HYTn/GkMopLuRmOO+Hi0=;
	b=ziIfFb0fKF5nSyZFk3tEpsP/4CcUozxdaY0p0FP3wxlvDuV4M0eAbXmpWr65Pu2EQM36Ip
	CVtZWYaQBAUIPbCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769519880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7CfnF2kx0qMIIPnj5Jo/t+HYTn/GkMopLuRmOO+Hi0=;
	b=fKRZetWfMZbqeVsYgRCfG2lF88zv2A8Gb7PtBYhZGVY9dmnqqhXi6FyhMsXKzVArEzZMbS
	QuqhOHmYt/l+6g2ZOy4NLwHiZPQAvsPGciPJ3hx5smQ6BDOmm1Dnm0/sQR3fM+B4iSjQx8
	Y1exqAWPcFo5n1iHeuxh9VLsJTsAZ48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769519880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7CfnF2kx0qMIIPnj5Jo/t+HYTn/GkMopLuRmOO+Hi0=;
	b=ziIfFb0fKF5nSyZFk3tEpsP/4CcUozxdaY0p0FP3wxlvDuV4M0eAbXmpWr65Pu2EQM36Ip
	CVtZWYaQBAUIPbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D9F3EA61;
	Tue, 27 Jan 2026 13:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PYBkIgi7eGmqfwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 27 Jan 2026 13:18:00 +0000
Date: Tue, 27 Jan 2026 14:17:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima_setup.sh: Fix check of signed policy requirement
Message-ID: <20260127131755.GA146899@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260121083343.127613-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121083343.127613-1-pvorel@suse.cz>
X-Spam-Score: -3.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8330-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvorel@suse.cz,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[pvorel@suse.cz];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: DA66E94C5F
X-Rspamd-Action: no action

Hi Mimi, all,

> Kernel code in arch_get_ima_policy() depends also on
> CONFIG_IMA_ARCH_POLICY added in v5.0:
> d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86")

> Fixes: c38b528783 ("ima_{conditionals, policy}: Handle policy required to be signed")
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Mimi, all,

> FYI I'd like to merge it this week to get it into LTP release.

> Kind regards,
> Petr

I dared to merge this to get it into upcoming LTP release (this/next week).

Kind regards,
Petr

>  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 1bce78d425..df0b8d1532 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -466,10 +466,11 @@ require_evmctl()
>  }

>  # 56dc986a6b20b ("ima: require signed IMA policy when UEFI secure boot is enabled") # v6.5-rc4
> +# d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86") # v5.0
>  check_need_signed_policy()
>  {
>  	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
> -		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY'
> +		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,CONFIG_IMA_ARCH_POLICY'
>  }

>  # loop device is needed to use only for tmpfs


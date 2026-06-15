Return-Path: <linux-integrity+bounces-9797-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id darVK2/tL2rMJAUAu9opvQ
	(envelope-from <linux-integrity+bounces-9797-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 14:17:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CABF6861B4
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 14:17:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VkKpD52b;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9797-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9797-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15258300F153
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503953B0ADC;
	Mon, 15 Jun 2026 12:17:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0630F92D;
	Mon, 15 Jun 2026 12:17:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525868; cv=none; b=T4/Odkns0sGNbRPcfbQ52DXd+mt5AhtC+tWx+cRZ+YRFFYQlVGctyGHaShekOvscmRLLPPobIwsho+QDRsCn3gfBUloMvQc2FhSdXfC2VSiGg8f41cK3d1U0rNtViJNy9auA1B9lmm96H+4Mf95oLm6ycyYkIpOcyGMwpynB6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525868; c=relaxed/simple;
	bh=fLIGOXgAZtsSKBEYYodyCYn2FgEOA2Fme6i2MBSLr9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4la+XPfoADszT74wCebR47U7lVZdf1sJkFTjGiozAV3P+UMQOvO7dJGmxVe3ru8LLXy1uRMACo0aNBIM+kXg/+XcxBmGtq8Zc3T+SiL9IvqFzp7TyeYbot+BEX8Eqgz7IpobN2LgOuSsL1OKHoJxBmGSy533iB9Ab9la1+hWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkKpD52b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0A2291F000E9;
	Mon, 15 Jun 2026 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525866;
	bh=KsX+Beu6boU4Mdxu5+HSbWrO8RbfbRLaAx1VTbiHGk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VkKpD52bCO8oeSI1lsueit/Wm+dI6Idw9gXOnZIZzHR+hVSsrqk1RqbY5O8I/2jxK
	 Ecg9LREPFnJdWbsiAjqFLgqDGUbMgaC5wV0iF3gNcdDaOWVNehLPiNYo2rzO4a4SZQ
	 pPM2M4L+CasdBSa/rNvCYkvI8DKhvqU/hPbRl2P3dzNuZcUwnTKHUVOwKZR1as7rx5
	 iJl6OQJw1/c8fQcvc7h2Su3yM+wjIoS9lVSVby0V0Y2o+p+A7huT23YAd817UvZEAZ
	 LJJ8RE/ILREK218iXLAJIK4l0ofE2FmD5SuGZxvPrhmKxbuvQL20rAet6zzrJhzUHS
	 lX7KkJddZltyQ==
Date: Mon, 15 Jun 2026 15:17:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Jun <chenjun102@huawei.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_tis: add settle delay after releasing locality
Message-ID: <ai_tZ0VM9PDCRMfl@kernel.org>
References: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9797-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:chenjun102@huawei.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CABF6861B4

On Mon, Jun 15, 2026 at 05:48:43AM +0100, Daniel Golle wrote:
> tpm_tis_core_init() releases locality 0 then immediately reclaims it via
> tpm_chip_start(); some TPMs (e.g. Nuvoton NPCT, TPM 2.0) need a few ms
> before granting it again, so probe fails with -1. This back-to-back
> release/request was added with the locality claim around TPM_INT_ENABLE.
> 
> Wait for the chip to settle after releasing the locality. A delay of
> TPM_TIMEOUT (5 ms) in __tpm_tis_relinquish_locality() is reliable; values
> below 3 ms are not.
> 
> Fixes: 0ef333f5ba7f ("tpm: add request_locality before write TPM_INT_ENABLE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 21d79ad3b164..6b90ff50c78d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -171,6 +171,8 @@ static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
>  {
>  	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>  
> +	tpm_msleep(TPM_TIMEOUT);
> +
>  	return 0;
>  }
>  
> -- 
> 2.54.0
> 

Can rebase to my for-next-tpm and resend v2?

BR, Jarkko


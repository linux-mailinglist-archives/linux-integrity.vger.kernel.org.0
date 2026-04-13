Return-Path: <linux-integrity+bounces-9166-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK3MHS7N3GmcWQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9166-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 13:02:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DE3EB08F
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E09030045BC
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599722156C;
	Mon, 13 Apr 2026 11:01:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C7324B32
	for <linux-integrity@vger.kernel.org>; Mon, 13 Apr 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078095; cv=none; b=QoAAYi1QETNirKfPVzYeWcwuMtqJiFKnpR9Ge3RwLQs107UkyWqugoBV9vNjxPZDc9kXgSz9G5drjuY1s5P6lUyy/DLZMrnnJ+m+HKPgraM2UnYdUsKrSngzxvrpCNhHKglUTRoF8ZJph7eYRqNmBXzcr4l7Mz7L7UmWJHEBlKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078095; c=relaxed/simple;
	bh=BTAb5P3FcxAPfrVAIVK0AI9lyHr0Q7MtwgUjM7kClJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG3x5cPdPwK+sPBkwyo1se1ARoFrmnMiEyVibTMUF6nVox2HYh9flqugA+6pV12qcGmMcbmnE9i9s8/2RpuYhZ2fQfyWjwdYfi3NhAqMfd/N1vTLykT/F79gOMmEIHASbOdEYH9qZpPflEGxSx3c14i/n8jP9L0KGDt/UVWu720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1wCF2U-0007TR-PF; Mon, 13 Apr 2026 13:01:10 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wCF2S-0059mD-2y;
	Mon, 13 Apr 2026 13:01:08 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wCF2S-00000007THT-3LMn;
	Mon, 13 Apr 2026 13:01:08 +0200
Date: Mon, 13 Apr 2026 13:01:08 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Josh Snyder <josh@code406.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	David Gstir <david@sigma-star.at>, sigma star Kernel Team <upstream+dcp@sigma-star.at>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, 
	Sumit Garg <sumit.garg@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trusted-keys: move pr_fmt out of trusted-type.h
Message-ID: <cie3zqy5phlopdrxsxpniujwr6i3cpdkfrwjvth3a7ypwjx3ee@hqjl67jnfdch>
References: <20260411-trusted-key-header-v1-1-407c2cd954db@code406.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411-trusted-key-header-v1-1-407c2cd954db@code406.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9166-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-integrity,dcp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,code406.com:email]
X-Rspamd-Queue-Id: 081DE3EB08F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Josh,

On 26-04-11, Josh Snyder wrote:
> Defining pr_fmt in a widely-included header leaks the "trusted_key: "
> prefix into every translation unit that transitively includes
> <keys/trusted-type.h>. dm-crypt, for example, ends up printing
> 
>     trusted_key: device-mapper: crypt: dm-10: INTEGRITY AEAD ERROR ...
> 
> dm-crypt began including <keys/trusted-type.h> in commit 363880c4eb36
> ("dm crypt: support using trusted keys"), which predates the pr_fmt
> addition, so the regression has been live from the moment the header
> gained its own pr_fmt definition.
> 
> Move the pr_fmt definition into the trusted-keys source files that
> actually want the prefix.
> 
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Josh Snyder <josh@code406.com>
> ---
>  include/keys/trusted-type.h               | 6 ------
>  security/keys/trusted-keys/trusted_caam.c | 2 ++
>  security/keys/trusted-keys/trusted_core.c | 2 ++
>  security/keys/trusted-keys/trusted_dcp.c  | 2 ++
>  security/keys/trusted-keys/trusted_pkwm.c | 2 ++
>  security/keys/trusted-keys/trusted_tpm1.c | 2 ++
>  security/keys/trusted-keys/trusted_tpm2.c | 2 ++
>  7 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 03527162613f7..54da1f174aeab 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -11,12 +11,6 @@
>  #include <linux/rcupdate.h>
>  #include <linux/tpm.h>
>  
> -#ifdef pr_fmt
> -#undef pr_fmt
> -#endif
> -
> -#define pr_fmt(fmt) "trusted_key: " fmt
> -
>  #define MIN_KEY_SIZE			32
>  #define MAX_KEY_SIZE			128
>  #if IS_ENABLED(CONFIG_TRUSTED_KEYS_PKWM)
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index 601943ce0d60f..a31fd89c0e5c5 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -4,6 +4,8 @@
>   * Copyright 2025 NXP
>   */
>  
> +#define pr_fmt(fmt) "trusted_key: " fmt

Can we adapt this patch further to include the trusted-key type as well?
E.g. 'trusted_key-caam'.

Regards,
  Marco


Return-Path: <linux-integrity+bounces-9203-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGYuOLb632ntbAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9203-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 22:53:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E4407BFB
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 22:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46B9312644D
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283B37BE6A;
	Wed, 15 Apr 2026 20:51:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2738BF7D
	for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286291; cv=none; b=eQAYhycKuNRH8ECCv/3hJtGvAXq5NLRaUex0Wh2VOqCG/nt1MkVQjZfBn4BoSV03QQZrLnvA9thPdEHn1n+MPOdgxXWCytsjW3NdPlU4R+CdL9gLShNmxpOK9rrJmxjdaPkvFI8yNgWxlDgEODW/DYsLW+3YzJQ0hHucpAgkbcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286291; c=relaxed/simple;
	bh=3+xeCs6CoJoi5hWppl4/gvvijdHtPfDDs/mbwv+7i6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz2kMT40aU8lXS79ffClMwTm+2e3x9gnBemK0ZKqIpBZptxy1P7MZctEwSKSXDCo62RJCG5yWK9/1nvu3XpPNHUA0yl+4xvN79vWwb5H3xjwe8Iu7N/2B9lPb5rFMp/KQJPoGL3qKrkJwE7iqdf66TJzgOub4ngXuXOnMBOB0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1wD7CM-0003dE-L2; Wed, 15 Apr 2026 22:50:58 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wD7CK-005ZJS-2u;
	Wed, 15 Apr 2026 22:50:56 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wD7CK-0000000BkCP-3GMT;
	Wed, 15 Apr 2026 22:50:56 +0200
Date: Wed, 15 Apr 2026 22:50:56 +0200
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
Subject: Re: [PATCH v2] trusted-keys: move pr_fmt out of trusted-type.h
Message-ID: <hiwdugym6tachxbnbkubjiwehjgjf5mqlpzhhacxioazi243hm@5ms7nm6n5u72>
References: <20260415-trusted-key-header-v2-1-5244f9ef0d09@code406.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-trusted-key-header-v2-1-5244f9ef0d09@code406.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9203-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity,dcp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,code406.com:email,pengutronix.de:url]
X-Rspamd-Queue-Id: 540E4407BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-15, Josh Snyder wrote:
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
> actually want the prefix, with specific prefixes for each key type.
> 
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Josh Snyder <josh@code406.com>
> ---
> Changes in v2:
> - specific pr_fmt based on trusted key type
> ---
>  include/keys/trusted-type.h               | 6 ------
>  security/keys/trusted-keys/trusted_caam.c | 2 ++
>  security/keys/trusted-keys/trusted_core.c | 2 ++
>  security/keys/trusted-keys/trusted_dcp.c  | 2 ++
>  security/keys/trusted-keys/trusted_pkwm.c | 2 ++
>  security/keys/trusted-keys/trusted_tpm1.c | 2 ++
>  security/keys/trusted-keys/trusted_tpm2.c | 2 ++

You missed the trusted_tee.c, sorry for not spotting this earlier.

Regards,
  Marco

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
> index 601943ce0d60f..71c173bb2f727 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -4,6 +4,8 @@
>   * Copyright 2025 NXP
>   */
>  
> +#define pr_fmt(fmt) "trusted_key: caam: " fmt
> +
>  #include <keys/trusted_caam.h>
>  #include <keys/trusted-type.h>
>  #include <linux/build_bug.h>
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index 0b142d941cd2e..159af9dcfc774 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -6,6 +6,8 @@
>   * See Documentation/security/keys/trusted-encrypted.rst
>   */
>  
> +#define pr_fmt(fmt) "trusted_key: " fmt
> +
>  #include <keys/user-type.h>
>  #include <keys/trusted-type.h>
>  #include <keys/trusted_tee.h>
> diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
> index 7b6eb655df0cb..41a23e2f30891 100644
> --- a/security/keys/trusted-keys/trusted_dcp.c
> +++ b/security/keys/trusted-keys/trusted_dcp.c
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2021 sigma star gmbh
>   */
>  
> +#define pr_fmt(fmt) "trusted_key: dcp: " fmt
> +
>  #include <crypto/aead.h>
>  #include <crypto/aes.h>
>  #include <crypto/algapi.h>
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index bf42c6679245a..108db105b639f 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2025 IBM Corporation, Srish Srinivasan <ssrish@linux.ibm.com>
>   */
>  
> +#define pr_fmt(fmt) "trusted_key: pwkm: " fmt
> +
>  #include <keys/trusted_pkwm.h>
>  #include <keys/trusted-type.h>
>  #include <linux/build_bug.h>
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 6ea728f1eae6f..207be849796ed 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -6,6 +6,8 @@
>   * See Documentation/security/keys/trusted-encrypted.rst
>   */
>  
> +#define pr_fmt(fmt) "trusted_key: tpm1: " fmt
> +
>  #include <crypto/hash_info.h>
>  #include <crypto/sha1.h>
>  #include <crypto/utils.h>
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 6340823f8b53c..2a540b1af0b33 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -4,6 +4,8 @@
>   * Copyright (C) 2014 Intel Corporation
>   */
>  
> +#define pr_fmt(fmt) "trusted_key: tpm2: " fmt
> +
>  #include <linux/asn1_encoder.h>
>  #include <linux/oid_registry.h>
>  #include <linux/string.h>
> 
> ---
> base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
> change-id: 20260411-trusted-key-header-a544a4f149d2
> 
> Best regards,
> --  
> Josh
> 
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


Return-Path: <linux-integrity+bounces-9651-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB9bHZOKEmqr0gYAu9opvQ
	(envelope-from <linux-integrity+bounces-9651-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:20:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4FD5C1700
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D172A300E39D
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 05:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45E2EF653;
	Sun, 24 May 2026 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIMeYT2t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A99299943;
	Sun, 24 May 2026 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779600015; cv=none; b=KI+ujy79Jf70BGoreBPI7DblzTaGgkH6YCP0KJOR2uXS+ds9o+nZLPNxSoECKCC5gDTsCevf2EjDULcoMFc1PoSfGgqBqqszxD3E49983rKaHmKpFJZG3AN+zGZdvotnly+rYPlLJXyktExca/1eRCCtEiGgGLpcosAIxD23KVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779600015; c=relaxed/simple;
	bh=nUk/or31ZcblcYRwbmyWvZEzsmOMAvxw8SC3x0CpR3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+z5dUPblxeY6wukGjT1q5jeV9SbvUHKRNKYqdwzHZqj80zOrZA6NmKjdo4Ihh1Ib6aHQOeiaUiT14ePZ200OOWD577K4uvMJIENcETWS/z8MfVTgrtEyG+U1Tuj4K8jVwfrUNmr6cr0c/1Jp+SlbFsTPpnjb033HU++DoEHw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIMeYT2t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1A28C1F000E9;
	Sun, 24 May 2026 05:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779600013;
	bh=YcuWooOWqE1a2Oivr+lPqrNpS1vi6j7CJ0wzXBRkecc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JIMeYT2tFZ7SD2DMmH3HrRFpzYagXdYGswGtNnbkROo1dLSmY5oM5uQXYlbQAUpAT
	 CgJZ4Aj+iS5vMSd+pKUXLP9ElmpUmD00zGFVOKoZWbfRDBF8peltrjUbgXxm1FzV58
	 q463qJkh57SF1T6I3M0zO9RH3yvzV7s5ABtm61dgb+hIMBIhwD3teUMIbKDNrUesQ9
	 CPDa6sYvPCTh6Ds/CcGktSQVjNiQuNTBi+zhlkX+nZpnSgbsItMWaVq71ZYIXYlAmh
	 z72AC8P098XI9enzzXt5Bmx+m/MxnaASSGhJWRyeKs5OysIQXnJgjLxmf4qwccvb9z
	 cFhhEaYJ2fwZA==
Date: Sun, 24 May 2026 08:20:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]
Message-ID: <ahKKikSt249xjoqK@kernel.org>
References: <20260524051519.3708075-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524051519.3708075-1-jarkko@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9651-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CA4FD5C1700
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 08:15:11AM +0300, Jarkko Sakkinen wrote:
> This series introduces key type for operating with asymmetric keys using
> a TPM2 chip.
> 
> Change Log
> ==========
> 
> v8:
> - Reset patch change logs given the overhaul of the code and patches.
> - Have only single new subkey type.
> - Make key type only use TPM operations.
> - Use TPM2_Sign for both ECC and RSA keys.
> - Align key descriptions with other key types.
> 
> Previous versions
> =================
> 
> * v7: https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@kernel.org/
> * v6: https://lore.kernel.org/linux-integrity/20240528035136.11464-1-jarkko@kernel.org/
> * v5: https://lore.kernel.org/linux-integrity/20240523212515.4875-1-jarkko@kernel.org/
> * v4: https://lore.kernel.org/linux-integrity/20240522005252.17841-1-jarkko@kernel.org/
> * v3: https://lore.kernel.org/linux-integrity/20240521152659.26438-1-jarkko@kernel.org/
> * v2: https://lore.kernel.org/linux-integrity/336755.1716327854@warthog.procyon.org.uk/
> * v1: https://lore.kernel.org/linux-integrity/20240520184727.22038-1-jarkko@kernel.org/
> * Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/
> 
> 
> Jarkko Sakkinen (3):
>   lib/asn1_encoder: Add asn1_encode_integer_bytes()
>   crypto: Migrate TPMKey ASN.1 objects from trusted-keys
>   keys: asymmetric: tpm2_asymmetric
> 
>  crypto/Kconfig                            |    7 +
>  crypto/Makefile                           |    6 +
>  crypto/asymmetric_keys/Kconfig            |   17 +
>  crypto/asymmetric_keys/Makefile           |    1 +
>  crypto/asymmetric_keys/tpm2_asymmetric.c  | 1096 +++++++++++++++++++++
>  crypto/tpm2_key.asn1                      |   11 +
>  crypto/tpm2_key.c                         |  150 +++
>  include/crypto/tpm2_key.h                 |   46 +
>  include/linux/asn1_encoder.h              |    3 +
>  include/linux/tpm.h                       |   10 +
>  lib/asn1_encoder.c                        |   62 ++
>  security/keys/trusted-keys/Kconfig        |    2 +-
>  security/keys/trusted-keys/Makefile       |    2 -
>  security/keys/trusted-keys/tpm2key.asn1   |   11 -
>  security/keys/trusted-keys/trusted_tpm2.c |  119 +--
>  15 files changed, 1421 insertions(+), 122 deletions(-)
>  create mode 100644 crypto/asymmetric_keys/tpm2_asymmetric.c
>  create mode 100644 crypto/tpm2_key.asn1
>  create mode 100644 crypto/tpm2_key.c
>  create mode 100644 include/crypto/tpm2_key.h
>  delete mode 100644 security/keys/trusted-keys/tpm2key.asn1
> 
> -- 
> 2.47.3
> 

There's some initial test code for this too:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-test.git/tree/overlay/usr/local/bin/tpmdd_tpm2_asymmetric.sh?h=main

Ugh, that's one hell of an url...

BR, Jarkko


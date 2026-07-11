Return-Path: <linux-integrity+bounces-9923-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iRVtJAGJUmq2QgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9923-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 20:18:41 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 923647427AD
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 20:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Quytj4KT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9923-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9923-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3E71300515F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783512517A5;
	Sat, 11 Jul 2026 18:18:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7693043B2;
	Sat, 11 Jul 2026 18:18:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793916; cv=none; b=O0WR/PqatJUME555ThqUTLVDkgv1qjCBclFkq3jlFVbYEfGEKCD49w1JF1j7U/PeUb5QzVsRsgAZ7yqx9JH15XItLJeNm6twOaSDkafZUj7sOV0u7UQKDGfcVA586qtXXz97uDTeBjOEEiLe9dC54f+tqyInbSZ2CNHve2OXVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793916; c=relaxed/simple;
	bh=qKKIsCXcVUBZU3uc3zUUqOctHFwHaU2JVITvx17odJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgqiB5IzFxYgs5jX6VKy12oAdrvbAAYukKmNQGUld3y6wQNCOiIv16rbpNR1xi9cc8UhM1fvhHSIGHqHAm4i/TFn8obH6WN07B5mviqZukh66d6shYZiDUWRUnlMqjt5OVdH+9eC80UFjgcKdloZNhM+q+W4MOPwjJ0eNqrOTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Quytj4KT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 20AD21F000E9;
	Sat, 11 Jul 2026 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783793913;
	bh=E7vKDBmC/PLx4EQvGKIBYk7PhCr0DaSZmFLJOx/Zqbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Quytj4KTWKdnH9uKdTwsNQ4KefbEakv1Wx88va+TEzqspyUHDuwu6GnN+kw+ia2U3
	 NzLALeG5absvJmH4BdKeBq2cXvs+VgmeZHf2xhQxTiPGmVgyg6aGe9UeG/p8PWiCOT
	 Vy2y4jNgNwGDhptMPEPchRpkiTyGwJ4NdoRhCU9mJtYsIZOrhUmoGvpqKqidIETr24
	 yiULYY6iXdCZx/GMqr6GkXM/KfMG0sedYDjqO+j1gbIOhy7pDb6iv443tRMM3ejoDZ
	 gE8uAaJywn817DGq18OMltwvFUMrC0H/bJyMAHJq1h07+SktQeTbFnN85qKJmoluvZ
	 a5nydifpMh5Cg==
Date: Sat, 11 Jul 2026 21:18:30 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	luto@amacapital.net, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v2 10/10] tpm-buf: Add TPM buffer support header for
 standalone reuse
Message-ID: <alKI9mUBTOCjPbbG@kernel.org>
References: <20260711160110.267780-1-ross.philipson@gmail.com>
 <20260711160110.267780-11-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711160110.267780-11-ross.philipson@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ross.philipson@gmail.com,m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-integrity@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-efi@vger.kernel.org,m:dpsmith@apertussolutions.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:bp@alien8.de,m:hpa@zytor.com,m:dave.hansen@linux.intel.com,m:ardb@kernel.org,m:mjg59@srcf.ucam.org,m:James.Bottomley@hansenpartnership.com,m:peterhuewe@gmx.de,m:luto@amacapital.net,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:corbet@lwn.net,m:kanth.ghatraju@oracle.com,m:daniel.kiper@oracle.com,m:andrew.cooper3@citrix.com,m:trenchboot-devel@googlegroups.com,m:rossphilipson@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9923-lists,linux-integrity=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,gondor.apana.org.au,davemloft.net,lwn.net,oracle.com,citrix.com,googlegroups.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustedcomputinggroup.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 923647427AD

On Sat, Jul 11, 2026 at 09:01:10AM -0700, Ross Philipson wrote:
> Extract all the functions and definitions for TPM buffer handling
> and separate them into their own header.
> 
> Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
> ---
>  drivers/char/tpm/tpm-buf.c |  3 +-
>  include/linux/tpm.h        | 34 +--------------------
>  include/linux/tpm_buf.h    | 60 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 34 deletions(-)
>  create mode 100644 include/linux/tpm_buf.h
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 1e5c11c312a8..233e81d3f149 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -4,7 +4,8 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/tpm.h>
> +#include <linux/tpm_command.h>
> +#include <linux/tpm_buf.h>
>  
>  static void __tpm_buf_size_invariant(struct tpm_buf *buf, u16 buf_size)
>  {
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 598dd53a10d8..0db277af45c3 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -26,6 +26,7 @@
>  #include <crypto/aes.h>
>  
>  #include <linux/tpm_command.h>
> +#include <linux/tpm_buf.h>
>  
>  struct tpm_chip;
>  struct trusted_key_payload;
> @@ -200,44 +201,11 @@ enum tpm_chip_flags {
>  
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>  
> -enum tpm_buf_flags {
> -	/* TPM2B format: */
> -	TPM_BUF_TPM2B		= BIT(0),
> -	/* The buffer is in invalid and unusable state: */
> -	TPM_BUF_INVALID		= BIT(1),
> -};
> -
> -/*
> - * A buffer for constructing and parsing TPM commands, responses and sized
> - * (TPM2B) buffers.
> - */
> -struct tpm_buf {
> -	u8 flags;
> -	u16 length;
> -	u16 capacity;
> -	u8 handles;
> -	u8 data[];
> -};
> -
>  struct tpm2_hash {
>  	unsigned int crypto_id;
>  	unsigned int tpm_id;
>  };
>  
> -void tpm_buf_init(struct tpm_buf *buf, u16 buf_size);
> -void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size);
> -void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
> -void tpm_buf_reset_sized(struct tpm_buf *buf);
> -u16 tpm_buf_length(struct tpm_buf *buf);
> -void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
> -void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
> -void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
> -void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> -u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
> -u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
> -u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
> -void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
> -
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
>   */
> diff --git a/include/linux/tpm_buf.h b/include/linux/tpm_buf.h
> new file mode 100644
> index 000000000000..f8c105d8b8bf
> --- /dev/null
> +++ b/include/linux/tpm_buf.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Following copyright information was take from the original file
> + * <include/linux/tpm.h> where the definitions were moved from:
> + *
> + * Copyright (C) 2004,2007,2008 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + * Debora Velarde <dvelarde@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org
> + */
> +
> +#ifndef __LINUX_TPM_BUF_H__
> +#define __LINUX_TPM_BUF_H__
> +
> +#include <linux/types.h>
> +#include <linux/bits.h>
> +
> +enum tpm_buf_flags {
> +	/* TPM2B format: */
> +	TPM_BUF_TPM2B		= BIT(0),
> +	/* The buffer is in invalid and unusable state: */
> +	TPM_BUF_INVALID		= BIT(1),
> +};
> +
> +/*
> + * A buffer for constructing and parsing TPM commands, responses and sized
> + * (TPM2B) buffers.
> + */
> +struct tpm_buf {
> +	u8 flags;
> +	u8 handles;
> +	u16 length;
> +	u16 capacity;
> +	u8 data[];
> +};
> +
> +void tpm_buf_init(struct tpm_buf *buf, u16 buf_size);
> +void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size);
> +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +void tpm_buf_reset_sized(struct tpm_buf *buf);
> +u16 tpm_buf_length(struct tpm_buf *buf);
> +void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
> +void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> +u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
> +u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
> +u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
> +void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
> +
> +#endif
> -- 
> 2.55.0
> 

I would probably ack them all as I've seen these many times and
there's not much anything new. Just waiting for additional
feedback before applying them.

BR, Jarkko


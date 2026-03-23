Return-Path: <linux-integrity+bounces-9028-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOAnGgTNwGkgLQQAu9opvQ
	(envelope-from <linux-integrity+bounces-9028-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:17:56 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F32EC9D8
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 240F4300B3DE
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE133993;
	Mon, 23 Mar 2026 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXaZFslR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5A19004A;
	Mon, 23 Mar 2026 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243071; cv=none; b=HXthTHmixmzfhRqCDc/QUSmaq4IbJnMsJRerZc0VfY1SVYS7CgMF4cXL3H6+vhZfNNkcs7mdRNyG6kJO4ikys6Au8UfusM5yEvF87JjincCRqozo8l5miOovqHIV3pUZqjTxr2Ge1mroQYxpbX9JuIBv8tAFf1EpWUi5q3golp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243071; c=relaxed/simple;
	bh=uP585akYgE+Qe94jGmXguGEFbReCVNzuHD7gj8fWNTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQYHOfUeOMjhLpnN14Dfq/RzOsmyyfds3uaNYc9FX1QWxj6WbzoV9qSAq88b+csTulITzD45I+YiCzPI3AnITq21OQq9s1Re/o+qxxzvm2nff0hQhlOD0D6VR2HF30TrAVxYPB+sBtvkYtRebwvRE/jh/CNf+CUN+gdKEoV8PeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXaZFslR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71B8C4CEF7;
	Mon, 23 Mar 2026 05:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774243071;
	bh=uP585akYgE+Qe94jGmXguGEFbReCVNzuHD7gj8fWNTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXaZFslRjPDtcXWc1vyePDoIZ3UGlihdz1rZzdVxzq5GMSuJnQj0DYjda1eCwGM43
	 IWLtEvh9c4ZY02OwZALOMoyKTLVY1lNFQVZWvlcEKhULt31YP5xUyxck6LmfdzdU6i
	 hm4dWi7UyC75rGNJxZpF7gL0NQLb2CyTpcQm5qM6lnyD0RAoHaqZGqCLz04tSMZYqX
	 ZV7XnImVp5FsDxOGgIKEV1bMtHp+tcc64I6UXg4rWigxZbNXNe1uTXwu2r5wxstx+y
	 xokCvQAz9ihZf9HEAvp2DCef3f4BkHPU8awBrHWELVMna/OBkHrjv/VHGIES6ihtu3
	 ne2MSkvEMKp5A==
Date: Mon, 23 Mar 2026 07:17:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nayna Jain <nayna@linux.ibm.com>
Cc: Srish Srinivasan <ssrish@linux.ibm.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] keys/trusted_keys: clean up debug message logging
 in the tpm backend
Message-ID: <acDM-hNRThVPRYhq@kernel.org>
References: <20260220183426.80446-1-ssrish@linux.ibm.com>
 <20260220183426.80446-2-ssrish@linux.ibm.com>
 <7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9028-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 286F32EC9D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 06:45:23PM -0400, Nayna Jain wrote:
> 
> On 2/20/26 1:34 PM, Srish Srinivasan wrote:
> > The TPM trusted-keys backend uses a local TPM_DEBUG guard and pr_info()
> > for logging debug information.
> > 
> > Replace pr_info() with pr_debug(), and use KERN_DEBUG for print_hex_dump().
> > Remove TPM_DEBUG.
> > 
> > No functional change intended.
> There is functional change here.  This change allows secret and nonce in the
> function dump_sess() to be logged to kernel logs when dynamic debug is
> enabled. Previously, it was possible only in the debug builds and not the
> production builds at runtime. With this change, it is always there in
> production build. This can result in possible attack.

Good catch, thank you. It's in my master branch still (not in -next).

TPM_DEBUG should be removed in all cases. If you really want to read
a secret, use tracing tools.

This only proves that the print should exist or should be a constant
value, or overwritten same length value.


> Instead of doing this change, I think add a comment to prevent this sort of
> change in the future.
> 
> Thanks & Regards,
> 
>     - Nayna
> 
> > 
> > Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >   security/keys/trusted-keys/trusted_tpm1.c | 40 +++++++----------------
> >   1 file changed, 12 insertions(+), 28 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > index c865c97aa1b4..216caef97ffc 100644
> > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > @@ -46,28 +46,25 @@ enum {
> >   	SRK_keytype = 4
> >   };
> > -#define TPM_DEBUG 0
> > -
> > -#if TPM_DEBUG
> >   static inline void dump_options(struct trusted_key_options *o)
> >   {
> > -	pr_info("sealing key type %d\n", o->keytype);
> > -	pr_info("sealing key handle %0X\n", o->keyhandle);
> > -	pr_info("pcrlock %d\n", o->pcrlock);
> > -	pr_info("pcrinfo %d\n", o->pcrinfo_len);
> > -	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
> > +	pr_debug("sealing key type %d\n", o->keytype);
> > +	pr_debug("sealing key handle %0X\n", o->keyhandle);
> > +	pr_debug("pcrlock %d\n", o->pcrlock);
> > +	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
> > +	print_hex_dump(KERN_DEBUG, "pcrinfo ", DUMP_PREFIX_NONE,
> >   		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> >   }
> >   static inline void dump_sess(struct osapsess *s)
> >   {
> > -	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
> > +	print_hex_dump(KERN_DEBUG, "trusted-key: handle ", DUMP_PREFIX_NONE,
> >   		       16, 1, &s->handle, 4, 0);
> > -	pr_info("secret:\n");
> > -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> > +	pr_debug("secret:\n");
> > +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
> >   		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
> > -	pr_info("trusted-key: enonce:\n");
> > -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> > +	pr_debug("trusted-key: enonce:\n");
> > +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
> >   		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
> >   }
> > @@ -75,23 +72,10 @@ static inline void dump_tpm_buf(unsigned char *buf)
> >   {
> >   	int len;
> > -	pr_info("\ntpm buffer\n");
> > +	pr_debug("\ntpm buffer\n");
> >   	len = LOAD32(buf, TPM_SIZE_OFFSET);
> > -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
> > -}
> > -#else
> > -static inline void dump_options(struct trusted_key_options *o)
> > -{
> > -}
> > -
> > -static inline void dump_sess(struct osapsess *s)
> > -{
> > -}
> > -
> > -static inline void dump_tpm_buf(unsigned char *buf)
> > -{
> > +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
> >   }
> > -#endif
> >   static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
> >   		       unsigned int keylen, ...)

BR, Jarkko


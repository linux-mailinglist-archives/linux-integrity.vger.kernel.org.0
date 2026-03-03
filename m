Return-Path: <linux-integrity+bounces-8881-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJQOI0pUp2lsgwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8881-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:36:10 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A5B1F79D9
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EFCF3037074
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2026 21:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728F47D92C;
	Tue,  3 Mar 2026 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6pwecVG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E56384230;
	Tue,  3 Mar 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573766; cv=none; b=UMs3qFcQSl6zEAt5YDEcWPKTs23TzEiKSeBa7jFK5wkLr1QJMVHvIfwy9iWXrefIkAHGvTqvzgiRuEj1EEvMCRS6MB70AhNJLyKBUfKS/BFuAJ5rC2F+j8rVFCtIb1/IHCSkgNyjvmuidBTj24K55aoIXnvDNd7j/4db+L2FlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573766; c=relaxed/simple;
	bh=tlbsP2G+L6KG27VSvXaXUHDNd1DGCTivoA/PsRbsM6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foJLant8EzRHuxNY3bJuvHnWnDCWp+DjZRMhQuIm39kGfENRuBpW1E7VoLp5tCYUcdO6ipewal61asSYiwBqxFiOCREYsm6kaSUaPnTk3wey/sBHOrjr75R/JaQe65FFabGOwfszARXpUYWEMKTsgEG7pVuKwwR7JB7vSmlVcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6pwecVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B340C116C6;
	Tue,  3 Mar 2026 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573765;
	bh=tlbsP2G+L6KG27VSvXaXUHDNd1DGCTivoA/PsRbsM6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6pwecVG64hTs9NyOHWl/bxfdpz8hNtgfudLLvSLjo7nrSpWNYsw8Za+Fs+vDOLDD
	 FVnlAmW5MLkU8i5gKk1A42tBD8LgnrOp5axoxAfYyqkvmySFa7I2y4fR88EXGetHSa
	 cr4HVj5Vy3Egf0Xrsk+oNbJVC5jf0sNs/OVaIa1V5ZQQhc/E9wJNklkfwFqzfWdFEk
	 +6kXyJSa7mYiiXGt+r3dWcsqS+mgEDpTdExrCOM3DVVWii8HAEvhPnrYQbR6Bk/QQq
	 SVsEruEoxBQlMmu41Mna2o1WMJhLR3tvqJoYooNeY8WqQyqvfvnfukVEqzDk3TVJ7J
	 8aDVNnPqCcRoQ==
Date: Tue, 3 Mar 2026 23:36:01 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, nayna@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] keys/trusted_keys: clean up debug message logging
 in the tpm backend
Message-ID: <aadUQcb-j5CnGUfZ@kernel.org>
References: <20260220183426.80446-1-ssrish@linux.ibm.com>
 <20260220183426.80446-2-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220183426.80446-2-ssrish@linux.ibm.com>
X-Rspamd-Queue-Id: 34A5B1F79D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-8881-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:04:25AM +0530, Srish Srinivasan wrote:
> The TPM trusted-keys backend uses a local TPM_DEBUG guard and pr_info()
> for logging debug information.
> 
> Replace pr_info() with pr_debug(), and use KERN_DEBUG for print_hex_dump().
> Remove TPM_DEBUG.
> 
> No functional change intended.
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 40 +++++++----------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index c865c97aa1b4..216caef97ffc 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -46,28 +46,25 @@ enum {
>  	SRK_keytype = 4
>  };
>  
> -#define TPM_DEBUG 0
> -
> -#if TPM_DEBUG
>  static inline void dump_options(struct trusted_key_options *o)
>  {
> -	pr_info("sealing key type %d\n", o->keytype);
> -	pr_info("sealing key handle %0X\n", o->keyhandle);
> -	pr_info("pcrlock %d\n", o->pcrlock);
> -	pr_info("pcrinfo %d\n", o->pcrinfo_len);
> -	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
> +	pr_debug("sealing key type %d\n", o->keytype);
> +	pr_debug("sealing key handle %0X\n", o->keyhandle);
> +	pr_debug("pcrlock %d\n", o->pcrlock);
> +	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
> +	print_hex_dump(KERN_DEBUG, "pcrinfo ", DUMP_PREFIX_NONE,
>  		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
>  }
>  
>  static inline void dump_sess(struct osapsess *s)
>  {
> -	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
> +	print_hex_dump(KERN_DEBUG, "trusted-key: handle ", DUMP_PREFIX_NONE,
>  		       16, 1, &s->handle, 4, 0);
> -	pr_info("secret:\n");
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> +	pr_debug("secret:\n");
> +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
>  		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
> -	pr_info("trusted-key: enonce:\n");
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> +	pr_debug("trusted-key: enonce:\n");
> +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
>  		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
>  }
>  
> @@ -75,23 +72,10 @@ static inline void dump_tpm_buf(unsigned char *buf)
>  {
>  	int len;
>  
> -	pr_info("\ntpm buffer\n");
> +	pr_debug("\ntpm buffer\n");
>  	len = LOAD32(buf, TPM_SIZE_OFFSET);
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
> -}
> -#else
> -static inline void dump_options(struct trusted_key_options *o)
> -{
> -}
> -
> -static inline void dump_sess(struct osapsess *s)
> -{
> -}
> -
> -static inline void dump_tpm_buf(unsigned char *buf)
> -{
> +	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
>  }
> -#endif
>  
>  static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>  		       unsigned int keylen, ...)
> -- 
> 2.43.0
>

Applied.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


Return-Path: <linux-integrity+bounces-9182-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KWgJDnV3mnwIwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9182-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:00:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8CB3FF2DE
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32E883022CB1
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589D42DF152;
	Wed, 15 Apr 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQPjqHLI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D02FF15B;
	Wed, 15 Apr 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211255; cv=none; b=UrmF9WDIYvBnkGEmvHNp3i//+lPwlFIIak63AC31DEXKKESOBJm7+mNwn91nZa8Xz1w38eBY9jGaap5uuF1PSnjVM4aKMnoajf1U3dUm9XLDDAH/v2Cx8O4VHRasfPWAATjejo24mXBzr3GeWZg0tgdG59DMFKVXCgBlJOsirZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211255; c=relaxed/simple;
	bh=J/DrcishR3iBNw3YdadLBYeJ6NA6pMrUvrXGVexs9Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY1G1SRrvsbgLli4AphTMEgxnSyWQrYjcwZ4Jk+eRMDvKBcxKFJA2en3n7KCqvqWPWyRGE2LJiAQNgWB/ai1OpGgCClT0jIJK4iq9PqTPdlpIk9HlV7IUKjL6+PaikbnWSYzS2U/vI2OJjbDtzMznqiI74ou81YwWiK79lSC2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQPjqHLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E28C19425;
	Wed, 15 Apr 2026 00:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211255;
	bh=J/DrcishR3iBNw3YdadLBYeJ6NA6pMrUvrXGVexs9Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQPjqHLIL7R+j1Lgwv7IQwfN5rtRAR7PuAy7xq8PBc9w33ri9wPpb0J8ID36V970/
	 5agOyAG5NtLql9Og4XCEKdpLWWrBV25425f3IRzFDfAE07EgbP/cxkipaasgJZ2a5o
	 XlsBJDzKBzl7MqUQTbNC27aAJWbT72PPAMLfLdDZEzR/tKTWf9PwOxptt+LiEvqoes
	 XEy0CbFnVogYOQMDPqK/JcdN4g6abwwnCxLN9Q5oY65x3CxVCKfbNSLzCbtfTj4FCK
	 jpaUEkS1PTHLsHCbk7aOptmspfPP7Q1WWmvx/3sty2bDeswtL2P3duEKRKnU4Ugof/
	 mv8dzHfPVwo4A==
Date: Wed, 15 Apr 2026 03:00:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, noodles@meta.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm2-sessions: Fix missing tpm_buf_destroy() in
 tpm2_read_public()
Message-ID: <ad7VM66hswU2L4Hp@kernel.org>
References: <20260408164359.24968-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408164359.24968-1-gunnarku@amazon.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,meta.com,vger.kernel.org,amazon.com];
	TAGGED_FROM(0.00)[bounces-9182-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A8CB3FF2DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 04:43:37PM +0000, Gunnar Kudrjavets wrote:
> tpm2_read_public() calls tpm_buf_init() but fails to call
> tpm_buf_destroy() on two exit paths, leaking a page allocation:
> 
> 1. When name_size() returns an error (unrecognized hash algorithm),
>    the function returns directly without destroying the buffer.
> 
> 2. On the success path, the buffer is never destroyed before
>    returning.
> 
> All other error paths in the function correctly call
> tpm_buf_destroy() before returning.
> 
> Fix both by adding the missing tpm_buf_destroy() calls.
> 
> Fixes: bda1cbf73c6e ("tpm2-sessions: Fix tpm2_read_public range checks")
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>  drivers/char/tpm/tpm2-sessions.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 09df6353ef04..f7c6c043fef4 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -203,8 +203,10 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
>  	rc = tpm_buf_read_u16(&buf, &offset);
>  	name_size_alg = name_size(&buf.data[offset]);
>  
> -	if (name_size_alg < 0)
> +	if (name_size_alg < 0) {
> +		tpm_buf_destroy(&buf);
>  		return name_size_alg;
> +	}
>  
>  	if (rc != name_size_alg) {
>  		tpm_buf_destroy(&buf);
> @@ -217,6 +219,7 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
>  	}
>  
>  	memcpy(name, &buf.data[offset], rc);
> +	tpm_buf_destroy(&buf);
>  	return name_size_alg;
>  }
>  #endif /* CONFIG_TCG_TPM2_HMAC */
> 
> base-commit: 03e5553f5fb99cb47c315e167a604a9c69e6f724
> -- 
> 2.47.3
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied.

BR, Jarkko


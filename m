Return-Path: <linux-integrity+bounces-9188-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNwuKWf23mkNNAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9188-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:22:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C023FFB6A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D01303A8D0
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37A308F3B;
	Wed, 15 Apr 2026 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFwihBry"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDE279DC2;
	Wed, 15 Apr 2026 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219749; cv=none; b=hsbvLy9VSb7qp7zzXQEMmMZKQO+Qy6+KYJGm67Ym1Ro0IBLICTDNrdbnY5QVUrW0ymau7WmCswrzGmiGFsogKQZU0sM6/8uYdyuuu7hGJcLxc8+0mWb8tiVGcWCB3QI5pgJKJb89XIDkIPFIqMC8NVmuQ1ux9ftwafMT0rgLd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219749; c=relaxed/simple;
	bh=PapM6JDwBzKK8n+ebpnYeRmHps4iWUPOEaBN6VUPKFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz6nDKk2Tvj7XA1czTOgj9aRmFqDTCnWnoKPtK/Hc5weXmMasaAq9wGSECLhvaYQCNchW4OemqIzK2yxEZD+BVp1uZ8Cs9emnqaGgz7NyKoMcr5JDTer5F6IJnN1g9IfckI0KtAUjwC6xAiRw760ZxyWWdDn+gkOBQDnsDcdPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFwihBry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFE6C19425;
	Wed, 15 Apr 2026 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776219748;
	bh=PapM6JDwBzKK8n+ebpnYeRmHps4iWUPOEaBN6VUPKFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFwihBryRAS2q1Y3ZpXhvAbUkDhiMuoDxkWmFd5Ibdup7xnaaEHO1479YAJifj2Ii
	 QcJPt5tGe+GGv2XmSATC8NmzQt3bQChOiIBzQmAcFrtj9zemd45MYMz4CBt6jIZnyn
	 9OQkReB9ljOaCX47g31d4A6wtvjxgd78ReYPuDoATr/yuJtYKebSYhh/JhvPHZWrXA
	 SvtiqR8wCnFx5mDkttiNn+2XIvHKHvOB2BZlrlthsqUdxlH9IqLs/EXXwvxVMnzPGl
	 eN6/uOu++t+gsvhbXXLUoVLbeWQIlVqC0t8C07m5a1AabyQ4JSP3Zn0qZfwmIYQWQe
	 qlMIrvND3hhyQ==
Date: Wed, 15 Apr 2026 05:22:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, James.Bottomley@hansenpartnership.com,
	ardb@kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm: Use kfree_sensitive() to free auth session in
 tpm_dev_release()
Message-ID: <ad72YI-lJJQWHJ_a@kernel.org>
References: <20260409172108.11600-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409172108.11600-1-gunnarku@amazon.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,hansenpartnership.com,kernel.org,vger.kernel.org,amazon.com];
	TAGGED_FROM(0.00)[bounces-9188-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1C023FFB6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 05:20:54PM +0000, Gunnar Kudrjavets wrote:
> tpm_dev_release() uses plain kfree() to free chip->auth, which contains
> sensitive cryptographic material including HMAC session keys, nonces,
> and passphrase data (struct tpm2_auth).
> 
> Every other code path that frees this structure uses kfree_sensitive()
> to zero the memory before releasing it: both tpm2_end_auth_session()
> and tpm_buf_check_hmac_response() do so. The tpm_dev_release() path
> is the only one that does not, leaving key material in freed slab
> memory until it is eventually overwritten.
> 
> Use kfree_sensitive() for consistency with the rest of the driver and
> to ensure session keys are scrubbed during device teardown.
> 
> Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 082b910ddf0d..17d9d71774ec 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -247,7 +247,7 @@ static void tpm_dev_release(struct device *dev)
>  	kfree(chip->work_space.context_buf);
>  	kfree(chip->work_space.session_buf);
>  #ifdef CONFIG_TCG_TPM2_HMAC
> -	kfree(chip->auth);
> +	kfree_sensitive(chip->auth);
>  #endif
>  	kfree(chip);
>  }
> 
> base-commit: 03e5553f5fb99cb47c315e167a604a9c69e6f724
> -- 
> 2.47.3
> 

Applied.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


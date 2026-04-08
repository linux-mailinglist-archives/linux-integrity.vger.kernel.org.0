Return-Path: <linux-integrity+bounces-9143-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JkIOTAZ1mkxBAgAu9opvQ
	(envelope-from <linux-integrity+bounces-9143-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 11:00:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 075063B9863
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BECF3003491
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2026 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395CD39E6FC;
	Wed,  8 Apr 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7DdA8z8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8C351C05;
	Wed,  8 Apr 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638809; cv=none; b=qnZxlpGYHqDx7haXHMhRw37U2mm7PswqTlAzGk3SM6yTeuh7DvXLy3ligvVNZcmwersCYAoWaCMN/UdFxmTxut+LtBqNMm8ByR0ZRNTRfJVdsewA9TkkJhEHwWFTi/aifsM69xmBLF71ZG+wZNkCGul0ElMRax7ECZRnvbTZpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638809; c=relaxed/simple;
	bh=y/h9jzSlvrAXWw00saDusO19LxC0QhLxb3OJkuh0I8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjHddwePYbbAamBsNgXAnzpfP3hvQByG6TdY0Gziim2+x7D201tkvvT+rqfmTh4gJRSguPcYHgbNX383hNsDXpuGI/kfp6KT9tOremJfhiCJIBdqeB7J7FCqxck7J1po236Cv8Osw56IGrd97MP96TsKqyLe49R5tS2hwpExJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7DdA8z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96887C19424;
	Wed,  8 Apr 2026 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775638809;
	bh=y/h9jzSlvrAXWw00saDusO19LxC0QhLxb3OJkuh0I8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7DdA8z8LCGG6h94yDqopKUl87zh2eI+kj9ktlquu752CDH2PMTXuKxgDETOinNHi
	 JXcR5I4UJhgcvIb3vjzDEjlq+gtw5U9CUxmxOSZG49D57VC1DZIijdgykt10m6I4KG
	 pCfsqK/596nC3eWz2ZWDSdtpFk19ZqjN1wp4A2wom1/Jn1+JlJ5La9ZUQaa2lD/AQm
	 md+6oefdhy9jPPvrCDukn/uIcoK7hLjePPtN3BXCyjzifcrAL0vJfI2Z6urYRFAfwU
	 RYF9xZJSo556bbhNhqS8ipy1PHYn9esjMM+/P+snSXv+eF1Tzm75wOYqwlcmnSqUUz
	 +HqF9WaO5N/+w==
Date: Wed, 8 Apr 2026 12:00:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, noodles@meta.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm: Fix auth session leak in tpm2_get_random() error
 path
Message-ID: <adYZFcidEve-dpgb@kernel.org>
References: <20260402181156.29396-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402181156.29396-1-gunnarku@amazon.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,meta.com,vger.kernel.org,amazon.com];
	TAGGED_FROM(0.00)[bounces-9143-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 075063B9863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 06:11:39PM +0000, Gunnar Kudrjavets wrote:
> When tpm_buf_fill_hmac_session() fails inside the do-while loop in
> tpm2_get_random(), the function returns directly after destroying the
> buffer, without ending the auth session via tpm2_end_auth_session().
> 
> This leaks the TPM auth session resource. All other error paths within
> the loop correctly reach the 'out' label which calls both
> tpm_buf_destroy() and tpm2_end_auth_session().
> 
> Fix this by replacing the early return with a goto to the existing 'out'
> label, which already handles both cleanup operations. The redundant
> tpm_buf_destroy() call is removed since 'out' takes care of it.
> 
> Fixes: 6e9722e9a7bf ("tpm2-sessions: Fix out of range indexing in name_size")
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index e00f668f8c84..b11e6fa8b740 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -295,10 +295,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  		}
>  		tpm_buf_append_u16(&buf, num_bytes);
>  		err = tpm_buf_fill_hmac_session(chip, &buf);
> -		if (err) {
> -			tpm_buf_destroy(&buf);
> -			return err;
> -		}
> +		if (err)
> +			goto out;
>  
>  		err = tpm_transmit_cmd(chip, &buf,
>  				       offsetof(struct tpm2_get_random_out,
> 
> base-commit: 7f2a32c0e87814f0e7852b17fa9f10321f882c36
> -- 
> 2.47.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


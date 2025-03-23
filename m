Return-Path: <linux-integrity+bounces-5401-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2243A6D117
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 21:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A63A85E0
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532719C54A;
	Sun, 23 Mar 2025 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpnyTeh4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E33136E;
	Sun, 23 Mar 2025 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762500; cv=none; b=jlTot7viKRxOFfmkZ//EzTQhK/Kb/cWGDxr62Z2x9FXxtW0Ykic8Aj2oqxKqOnAwzc7NDk2SQ6T6uLxvEEvxxjzH7vczb00RowB8jVi2C+zNqD/tCfaj4MAkW5H3SyGL+37nU2tisPR6YDAkGpkAFIFQ9z5f1tuYRx/XQgJJ3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762500; c=relaxed/simple;
	bh=EYXh4Ei0xF6xrZbksN5MtMBwJ2r30Zaz9yCebfl8g2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4GmCWDtJbEn92Hc15Qq8BFNuv+vvlkQbCsbn+n/NxSJ3yDFZSt0EO00f+VCzPqJ2k4fTgKAVY0+NdQT9XGdT2wBuGfiL6Ju0fQsieVD6oUR94ZOzb8MCSp2rUzpoHakfmGULPzlwQ7n70Kl2iOJt/1Jm9YMXyVpkYehW1XpbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpnyTeh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B0DC4CEE2;
	Sun, 23 Mar 2025 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742762500;
	bh=EYXh4Ei0xF6xrZbksN5MtMBwJ2r30Zaz9yCebfl8g2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpnyTeh4edQ8aHjC4jOP5Hgq/Ll/6DEMOlt9KqAsJCZMRiZ56UO3j6xlKRD6sCgL6
	 3/Mlv+WuKPDQk989NBpmSgpEvIcSyUggwLHdLqmsX7LYadKCHGjeti02fK+b4P+hjm
	 Ht7e5uBtIfKfQheVNOelRt+7MfTkMc6RrXDvVhNxwVCf178K1tgjY6i+y5tgOH9biw
	 +aDoLZWKip3CSaODwCnMw3xVUlVw5I4kLMlFT8e79Bz8F4xnj1T6ruJmuSx5UFrTKe
	 ZMa1LVIsYqPxQnamBLXSQ1UpvBQ7X2T9q5Pt7d/yXr4cFTGe6kCXrus+VfCr8BFLPL
	 OkMU3I0GSRcsg==
Date: Sun, 23 Mar 2025 22:41:35 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nicolai Stange <nstange@suse.de>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/13] tpm: enable bank selection for PCR extend
Message-ID: <Z-Bx_-EvcfCzWqr7@kernel.org>
References: <20250323140911.226137-1-nstange@suse.de>
 <20250323140911.226137-8-nstange@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323140911.226137-8-nstange@suse.de>

On Sun, Mar 23, 2025 at 03:09:05PM +0100, Nicolai Stange wrote:
> The existing tpm_pcr_extend() extends all of a PCR's allocated banks with
> the corresponding digest from the provided digests[] argument.

Why not "just" tpm_pcr_extend(). We don't have a concept of
"non-existing tpm_pcr_extend()".

"tpm_pcr_extend() extends the allocated PCR banks ..."

or something.

> 
> An upcoming code change to IMA will introduce the need to skip over those

Don't talk about upcoming code changes. Just explain why IMA depends on
the change.

> banks it does not have a hash algorithm implementation available for.
> 
> Introduce tpm_pcr_extend_sel() to support this.
> 
> tpm_pcr_extend_sel() also expects a digests[] array, always being the
> number of allocated PCR banks in size, just as it's the case for the
> existing tpm_pcr_extend(). In addition to that however, it takes a
> 'banks_skip_mask', and will skip the extension of any bank having its
> corresponding bit set there.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++++++++--
>  drivers/char/tpm/tpm.h           |  3 ++-
>  drivers/char/tpm/tpm2-cmd.c      | 29 +++++++++++++++++++++++++++--
>  include/linux/tpm.h              |  3 +++
>  4 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index b1daa0d7b341..88b4496de1df 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -314,6 +314,26 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
>   */
>  int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		   struct tpm_digest *digests)
> +{
> +	return tpm_pcr_extend_sel(chip, pcr_idx, digests, 0);
> +}
> +EXPORT_SYMBOL_GPL(tpm_pcr_extend);

I'd add just an extra argument to tpm_pcr_extend().

BR, Jarkko 


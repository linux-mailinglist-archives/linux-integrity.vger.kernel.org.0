Return-Path: <linux-integrity+bounces-8153-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA710CEF020
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 17:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B099F30021D8
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F45295DBD;
	Fri,  2 Jan 2026 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8qhdNjl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618626FA50;
	Fri,  2 Jan 2026 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767372766; cv=none; b=o6zdESqYRT7xQkpbZ/fL9yclvWufW9LlrJK3KlGs1OF9UMSQU7oSTfZuF1K2WfjaaYU1RW2d7nisqbjW4mbYNzKlOFhtt4zu8qwVcj41jnf+ZydCvKLMrfR/PIXhnu5qmbt8ugDqXia9AoLvlz5ks7+ECb42epYyWeLW8nFpQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767372766; c=relaxed/simple;
	bh=mJwb0X8ztaxoOxs3qWJsxo4uQ8ZGUfCMXRbTjF2whfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o46fezV8DtuylopkWVlh0kOQnPahyFiI2tEWXpiIU3uBTcbsNh5CNKZNQbcINtz4aeG8yKmKBC8GOpPaEyDLTumM0gdoNFd3LcnqnRi5saCW/IJApCBpHK2qLnnuXbqpa7AtTrcssrfpo5OyRsjRq/8r/ahTaJ+mYvL6IOUM5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8qhdNjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9654CC116B1;
	Fri,  2 Jan 2026 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767372766;
	bh=mJwb0X8ztaxoOxs3qWJsxo4uQ8ZGUfCMXRbTjF2whfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8qhdNjl/eCIiv6ZDr1YPpS3ZsI/X1NdIwdN7HEspAoes/zz6Eog2hEYmFI0XUpHP
	 l78dTKq916MPgIuM0c+V0By0VfOKDQ2ziP6xX5jqJjGjsISr6juJLRoTQanhZ0GiZ7
	 HEsYTxwW/gW547mHIRxaO78O2a7EhQvL+fsOrvZr9ft93/fl+0ff+144h5QRPKAbsY
	 i0F8M0FWjYL56Lslve34mjpF9k3JzVn0Kt2rLwdNYtnno7CQfwYV51aUChZNGooe5c
	 Y3TnywBcqzeTmMpZgt130PjejoPEaJ4DaSpCQ+5i4h+GkCGPEKwgdAavCG644gRZ4+
	 XwV0T8Z995LpQ==
Date: Fri, 2 Jan 2026 18:52:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm2-space: Skip handle check when context load
 returns -ENOENT
Message-ID: <aVf32R-7LHUACtHY@kernel.org>
References: <20251226111217.50747-1-alperyasinak1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226111217.50747-1-alperyasinak1@gmail.com>

On Fri, Dec 26, 2025 at 02:12:16PM +0300, Alper Ak wrote:
> When tpm2_load_context() returns -ENOENT, the session is marked as
> forgotten by setting session_tbl[i] to 0. Although tpm2_load_context()
> also sets handle to 0 in this case, the subsequent comparison
> "handle != space->session_tbl[i]" (0 != 0) is always false and serves
> no purpose.
> 
> Add continue to skip this unnecessary comparison when load fails with
> -ENOENT, making the control flow clearer and fix possible
> uninitialized 'handle' variable.
> 
> Fixes: 4d57856a21ed2 ("tpm2: add session handle context saving and restoring to the space code")
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>

There is no regression here.

> ---
>  drivers/char/tpm/tpm2-space.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 60354cd53b5c..7dfbe07ecf5b 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -213,6 +213,7 @@ static int tpm2_load_space(struct tpm_chip *chip)
>  		if (rc == -ENOENT) {
>  			/* load failed, just forget session */
>  			space->session_tbl[i] = 0;
> +			continue;
>  		} else if (rc) {
>  			tpm2_flush_space(chip);
>  			return rc;
> -- 
> 2.43.0
> 

This really does nothing too useful to the code, which we really want
to be conservative to change to begin with.

BR, Jarkko


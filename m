Return-Path: <linux-integrity+bounces-7089-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56EFB584D2
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 20:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262F91A280B6
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137723ABA0;
	Mon, 15 Sep 2025 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4/+tQuL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EC1FBCB0;
	Mon, 15 Sep 2025 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961758; cv=none; b=hZdoeIieOZKL/bXlT2CPN0CWihxAk4Y3jFdK/CNwnMjoof8CZTKmrmiddVKnsmhoQMSfH3L1h+lW29XrX05Rkpqzt68O5NrdMjePNJGP6SAFpEx1vEWCzTB97w3FwGMbKnMkbsMZ6bw9Pd1R8GqGQaeWCDdj/7aqlh0oxL2FpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961758; c=relaxed/simple;
	bh=jGa4P8r8qgsP5wEh2koJGsDYIlxbZTXvkbhvkpHoqts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcXkAuUdodejHoFpR61/PaS+URCrCTuFLToXKq5LPlV7mFgXT4v49S/dJuR1IWF1b2xst0Ql3wUoJjCgR4NaCaXN/zzkr07WGFU2QXZfQp0glrsL+QrXHoCWKyI5utNbK7rykLUYPXLaA9n+9uDmGQZhFCQusnZ/buMpRpn8hK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4/+tQuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E63DC4CEF1;
	Mon, 15 Sep 2025 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961758;
	bh=jGa4P8r8qgsP5wEh2koJGsDYIlxbZTXvkbhvkpHoqts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4/+tQuLGZ0e0I3NJQ2fZVWBdZJwUqSc4Khkps+UsIEBaYBk4asO6ZjIY8mosnIfX
	 z1l+TbOzrdA0SMjKvwe/lWMzOh2aDZt7nokP75EA8q/Dk6o7UekeBU9fWDvRaNH5WD
	 EnjWBNEeZUTwcXl2aoQ08gzbQUmtDu/U7Oq1SOfWA9yMy4wFkiPDh6pZeEk+vE63CV
	 9ch8vhaDrTX1+I3jEMJR26d08+uSnYSv1qPLz9/eyYlFjHyG/dATQcENT3L492Tlx5
	 YthPfsXaw61hk8ia3IGV4/Ne6PsawDQOUbIG4k2klRBBNj39dHylzamgtJhpLwbWo1
	 C65aD9aTWzTcQ==
Date: Mon, 15 Sep 2025 21:42:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
	christophe.ricard@gmail.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm_tis: Fix incorrect arguments in
 tpm_tis_probe_irq_single
Message-ID: <aMheGdW3jqfGIPlh@kernel.org>
References: <20250915182105.6664-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915182105.6664-1-gunnarku@amazon.com>

On Mon, Sep 15, 2025 at 06:20:44PM +0000, Gunnar Kudrjavets wrote:
> The tpm_tis_write8() call specifies arguments in wrong order. Should be
> (data, addr, value) not (data, value, addr). The initial correct order
> was changed during the major refactoring when the code was split.
> 
> Fixes: 41a5e1cf1fe1 ("tpm/tpm_tis: Split tpm_tis driver into a core and TCG TIS compliant phy")
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 4b12c4b9da8b..8954a8660ffc 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -978,8 +978,8 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	 * will call disable_irq which undoes all of the above.
>  	 */
>  	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> -		tpm_tis_write8(priv, original_int_vec,
> -			       TPM_INT_VECTOR(priv->locality));
> +		tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality),
> +			       original_int_vec);
>  		rc = -1;
>  	}
> 
> 
> base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
> --
> 2.47.3
> 

Amazing catch, thank you. Have you been able to verify this?

I'm asking this because post this there was a lot of unsuccesful
attempts to enable irqs in the tis driver (which have never really
worked too well since epoch) so perhaps this could move things
forward.

Thus, I'm interested do you happen to have a working testing
environment?


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


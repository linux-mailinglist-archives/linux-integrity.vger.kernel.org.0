Return-Path: <linux-integrity+bounces-7395-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0531BC280E
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Oct 2025 21:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEB819A2D2E
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Oct 2025 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CBB22D4F6;
	Tue,  7 Oct 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLpS61BS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833A22172C;
	Tue,  7 Oct 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865123; cv=none; b=n9+Rz/KX9x/KLpVGVhHUc2+BjP4fLXbQ5dZAaAOaR6/BPA/SL5+RMmO/EZl/8j76Ts++ZMEFzqIHICoefF1MuKACL5WUKAzvu13j09IRBRxmySQqv0UZdKK1T25Tp5lV7MdlNzyhAGlvPQT/6nTSCMfudvPjQNy9q1ZFDOxQKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865123; c=relaxed/simple;
	bh=nzAwztI0+ApyNKq3ya5FejLfcx6q+aoJwQfJH3QO1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tblQn8utWVygDOqyJ13k1yPCardsDMr2JOCtZP4BBsAN5vTTgPBlhco8u+NdSxOi0cwGr36uMMCJk+8UHMe9k0PpEzr4haLM6aA/XIsJn+2FZjsN6egC5lmdLxVnNXOErQXgwOiw8ws0iLtpgvTXErhdF2+kowl13NGA3ujG+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLpS61BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDE6C4CEF1;
	Tue,  7 Oct 2025 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759865123;
	bh=nzAwztI0+ApyNKq3ya5FejLfcx6q+aoJwQfJH3QO1dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLpS61BS3xppycjSk6rS+WRuTGq/q+DQlvYwtCVP/PRdTYVjz/PLSTHQFdPzzTu3v
	 ZYd7OFajzQHXJpGtgLFXnOW1rGSuegIo7TIee7I8uuf6dewcXErUs7zY/v22aA1LXX
	 0WWhsauAnMemUXHfB1cLd5v7cwyRaX6O5VjA5V7KCU5Iy3V3jJSJYBlL+FcdLt4Wfg
	 c3XDF1eDU/BiZXAwWJVlrYk7oxjfUJg2HElR1q6e57q0huCj1rqTqM5z2FqhGal+Mv
	 Nw1qXCkebMKvY0qKtVs5+gjKWQFd0/C07FTjtA+3N9BoZijRJwcdferCaygb3W71pd
	 SvyW2MW4dN/Wg==
Date: Tue, 7 Oct 2025 22:25:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shahriyar Jalayeri <shahriyar@posteo.de>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: infineon: add bounds check in tpm_inf_recv
Message-ID: <aOVpH_31JEhiN6qv@kernel.org>
References: <20251007090736.17942-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007090736.17942-1-shahriyar@posteo.de>

On Tue, Oct 07, 2025 at 09:07:39AM +0000, Shahriyar Jalayeri wrote:
> Add two buffer size validations to prevent buffer overflows in
> tpm_inf_recv():
> 
> 1. Validate that the provided buffer can hold at least the 4-byte header
>    before attempting to read it.
> 2. Validate that the buffer is large enough to hold the data size reported
>    by the TPM before reading the payload.
> 
> Without these checks, a malicious or malfunctioning TPM could cause buffer
> overflows by reporting data sizes larger than the provided buffer, leading
> to memory corruption.
> 
> Fixes: ebb81fdb3dd0 ("[PATCH] tpm: Support for Infineon TPM")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
> ---
>  drivers/char/tpm/tpm_infineon.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b8..8b90a8191 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -250,6 +250,11 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  	number_of_wtx = 0;
>  
>  recv_begin:
> +    /* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data size */
> +	if (count < 4) {
> +		return -EIO;
> +	}
> +
>  	/* start receiving header */
>  	for (i = 0; i < 4; i++) {
>  		ret = wait(chip, STAT_RDA);
> @@ -268,6 +273,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  		/* size of the data received */
>  		size = ((buf[2] << 8) | buf[3]);
>  
> +		if (size + 6 > count) {
> +			return -EIO;
> +		}
> +
>  		for (i = 0; i < size; i++) {
>  			wait(chip, STAT_RDA);
>  			buf[i] = tpm_data_in(RDFIFO);
> -- 
> 2.43.0
> 

Nitpick: we don't use curly braces for one line statements.
AFAIK scripts/checkpatch.pl complains about this. Other than that
I don't see any issues.

BR, Jarkko


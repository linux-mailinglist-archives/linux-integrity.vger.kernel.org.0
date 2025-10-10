Return-Path: <linux-integrity+bounces-7419-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37CBCE1DA
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 19:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EF43AF96C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AA622256F;
	Fri, 10 Oct 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBn8gSWA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12D1F790F;
	Fri, 10 Oct 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118018; cv=none; b=RcZPG0ae8A5UC3sSKrZlSNzUNhJJwACiNE4XOdBZzUN8jCWYz5EF2b/k+UW7Zw5gfsUoIKBxdQnQDmwdBAeXd9Fateum6MpCB2Ffan4BUQ/vLp82K9KAqtgjAt7fAMLIxz2vDIUVv631wN8dgLcQI4uhX6QSXqR7l6hbvbn9U8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118018; c=relaxed/simple;
	bh=RzhZkNLLsGCV263SjIvZrIVe28BWcM9v2GPR3PA6Wsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6U8cPSiKIvHMKt/mGZXuZNV6CNnyHZDSvMn321XbrGXZYfvQl687vh3NNHeK0++K+sVJR8LeFFM07RZXFnB02DZxHWqLYOJNuh92ZKHSSRAfG7naepKy78Mh1pnjAD2O9QqVAvMoE0dnkDHA2bXfg57sGgkw7AdKiwJDoTovak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBn8gSWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BFFC4CEF1;
	Fri, 10 Oct 2025 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760118017;
	bh=RzhZkNLLsGCV263SjIvZrIVe28BWcM9v2GPR3PA6Wsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBn8gSWA1d5QleXKAWMWUW3HvC3QmAyh2KicHxPOHIgIxU+il/tmO61PYDXonSCUt
	 tlgaEzXWal5kdGBU8emq9dx0SGGeyk3YAw9IQY9PcAUkXSZ/NnN1R+tOEJLLBIARmU
	 jY9spwn307KwMFRKRFVTiEq+DhGBqeGmYR9e5yUzWFVig8loL1CeCJ5jq9z5V4qCUg
	 0CT93zX8/a1R19TAzhilX8Eg9fikpy3yoxOHTWI+FeLvoFUkZIyC8M1Yo02On7B8Xh
	 2vxQFghgsCmOH70jCqKCcFYJo8rB1g97TF+0frAYKtgAeqO+Xkycp1/gMtmWKYc1tM
	 Z9QiTwqdj12zw==
Date: Fri, 10 Oct 2025 20:40:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shahriyar Jalayeri <shahriyar@posteo.de>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: infineon: add bounds check in tpm_inf_recv
Message-ID: <aOlE_cREuIuCw2do@kernel.org>
References: <20251010065252.4377-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010065252.4377-1-shahriyar@posteo.de>

On Fri, Oct 10, 2025 at 06:52:55AM +0000, Shahriyar Jalayeri wrote:
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
>  drivers/char/tpm/tpm_infineon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b8..0fe4193a3 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -250,6 +250,10 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  	number_of_wtx = 0;
>  
>  recv_begin:
> +    /* expect at least 1-byte VL header, 1-byte ctrl-tag, 2-byte data size */

This is definitely good enough :-)

But is that comment misaligned? Does VL come from "VLAN"?

> +	if (count < 4)
> +		return -EIO;
> +
>  	/* start receiving header */
>  	for (i = 0; i < 4; i++) {
>  		ret = wait(chip, STAT_RDA);
> @@ -268,6 +272,9 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  		/* size of the data received */

I'd delete the above comment.

>  		size = ((buf[2] << 8) | buf[3]);

And use here:

https://elixir.bootlin.com/linux/v6.17.1/source/include/linux/byteorder/generic.h#L108

Not exactly in scope but it would be good convention and make
the check after it more readable.

>  
> +		if (size + 6 > count)
> +			return -EIO;
> +
>  		for (i = 0; i < size; i++) {
>  			wait(chip, STAT_RDA);
>  			buf[i] = tpm_data_in(RDFIFO);
> -- 
> 2.43.0
> 

BR, Jarkko


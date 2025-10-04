Return-Path: <linux-integrity+bounces-7367-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFD4BB8D39
	for <lists+linux-integrity@lfdr.de>; Sat, 04 Oct 2025 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D917619C0071
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Oct 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD7C26A1AC;
	Sat,  4 Oct 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULJ1yQrv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207E25DCE0;
	Sat,  4 Oct 2025 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759581191; cv=none; b=DW0q+6ZGMKcaJz3FCV9hz2w87C5uCshveDYI2uw+fs+nAfXn+UMnRxZQocUGn/07u26gJYZLkpNfgy/1apEMQkhNP/YAQljGIFUIlC52Cplmrr0sqCX7hGde/18IdN/wDuy8LDqIqtZQyrMhOM9LfXf8hdI/+OVAOPMwrDg1SmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759581191; c=relaxed/simple;
	bh=MMzlP6JXiHbRwU9pXqCAynbSHSe8WVCyF2HPgA0IR+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+oW9tJdx5LOlVY02EJ3HQWv5oHF+vOD78FWxLe4AXnaOUAH/x5kBP/tLcZFIjbbH4U+1Ozsg+GFvTveUchPHO1VSL+hxHC/Gh8Xbjm4gD6YPxtu5rKnPMgSqP/U4pBmJ3wHlwIOjVTaJmFYRHMMkGCFJyZjRgEL2VkHVEEulV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULJ1yQrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78C8C4CEF1;
	Sat,  4 Oct 2025 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759581188;
	bh=MMzlP6JXiHbRwU9pXqCAynbSHSe8WVCyF2HPgA0IR+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULJ1yQrvBK2LoUiuqWNZxd1sAcwBBJU/u0r0JCju3tIhtbtgUvoShD49HuFGqxidQ
	 f4iQ8j2QkexJksJ2xS50N6F1f90P6clx36UuCR26M6GZI+1egR5vdAV0wi/hIYnkTb
	 pUVZLez+lFKTCqptb2QvjFnDR52ZKUyOtTk5wbChC+Kp7jVf/TWmoi4C8LjZsZ/Qap
	 l5gLYhdgoQnkQGqgAF4oqqwa/wVHeoLk4zDw8nKD+DxkOeCVKRFXv4NPW5OGpv61sI
	 A18PH4+CxPlaHaiv0QFVidcl1kHZFStKkjVd7ownIQiNcJcJ19sxVYcMQqzZ8CCAAr
	 mrYTmAkQ/r69g==
Date: Sat, 4 Oct 2025 15:33:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shahriyar Jalayeri <shahriyar@posteo.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: infineon: add bounds check in tpm_inf_recv
Message-ID: <aOEUAOUolS6mlf1n@kernel.org>
References: <20251004090413.8885-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004090413.8885-1-shahriyar@posteo.de>

On Sat, Oct 04, 2025 at 09:04:17AM +0000, Shahriyar Jalayeri wrote:
> Add two buffer size validations to prevent buffer
> overflows in tpm_inf_recv():
> 
> 1. Validate that the provided buffer can hold at
>    least the 4-byte header before attempting to
>    read it.

What is this 4 byte header? Please describe what it is.

> 2. Validate that the buffer is large enough to
>    hold the data size reported by the TPM before
>    reading the payload.
> 
> Without these checks, a malicious or malfunctioning
> TPM could cause buffer overflows by reporting data
> sizes larger than the provided buffer, leading to
> memory corruption.
> 
> The error messages include both the expected and
> actual buffer sizes to indicate that the operation
> is aborted.

Paragraphs should be 75 chars per line.

> 
> Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
> ---

Please version your patches e.g., "git format-patch -v2"

And before diff stat it would be good to have a changelog.


>  drivers/char/tpm/tpm_infineon.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b8..385bac46a 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -247,11 +247,20 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  	int i;
>  	int ret;
>  	u32 size = 0;
> +	u32 header_size = 4;

Please don't use local variable for a constant.


>  	number_of_wtx = 0;
>  
>  recv_begin:
> +	if (count < header_size) {
> +		dev_err(&chip->dev,
> +			"Buffer too small (count=%zd, header_size=%u), "
> +			"operation aborted\n",
> +			count, header_size);
> +		return -EIO;
> +	}
> +
>  	/* start receiving header */
> -	for (i = 0; i < 4; i++) {
> +	for (i = 0; i < header_size; i++) {
>  		ret = wait(chip, STAT_RDA);
>  		if (ret)
>  			return -EIO;
> @@ -268,6 +277,14 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  		/* size of the data received */
>  		size = ((buf[2] << 8) | buf[3]);
>  
> +		if (size > count) {
> +			dev_err(&chip->dev,
> +				"Buffer too small for incoming data "
> +				"(count=%zd, size=%u), operation aborted\n",
> +				count, size);
> +			return -EIO;
> +		}
> +
>  		for (i = 0; i < size; i++) {
>  			wait(chip, STAT_RDA);
>  			buf[i] = tpm_data_in(RDFIFO);
> -- 
> 2.43.0
> 

Other than that, same comments apply as for the previous version.

BR, Jarkko


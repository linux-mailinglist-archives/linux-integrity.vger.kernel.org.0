Return-Path: <linux-integrity+bounces-5764-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57498A84365
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 14:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD06188F10D
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 12:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8722836A2;
	Thu, 10 Apr 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPe4nNb8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449091DDC0F;
	Thu, 10 Apr 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288666; cv=none; b=g+0l3QZMv0RLiS3PDQNCkpvjv+h+A4xmshnVvvp17lgiU2PrfSiy3nse1qXdnaT2dFiLtF1RYFOqcMCqVknKLJR6WbV+TYdW23apsjrd2rDJLpFV6HUW8r9ChFMvCcwRawQK0YZPPVOCnGpOqVXJbgPrWU/WJTY6w1HJg279IOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288666; c=relaxed/simple;
	bh=sPKm1/Nz6ZhOYtb/EBIrtiQ37Zx68yFWZK7cGLk4dIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFbKLjHDFYfqq6T8jbKr1sOsj8HwsnP/gx6auULloVn69Zpx0u/0pg1lW0LxRxA1XVijT2LqpmjkprLNq9zUjsHpczJEFhaaAB86dH/Wget9zuoA4X4yPlW4SIJehLKPss+Wj4cnA4VpohsbAUZ+y8sXUBL8/mzzXocfX532voE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPe4nNb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E857C4CEDD;
	Thu, 10 Apr 2025 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744288664;
	bh=sPKm1/Nz6ZhOYtb/EBIrtiQ37Zx68yFWZK7cGLk4dIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPe4nNb8Rj61smw7NSryO5eHHvcfvGZXPo7sfzrPFef+EufqQdBpgcc10lb7/l7Hv
	 2OTZlHzAMbjjYiKnPGX2X77h4lH8D7qyRBToXyX64l8+Z9/ykI0bS+4owY1ZSM1Y+9
	 D/qayDHpmxXH9a1dUkAREFQmMtPV7OI494avInjBqwRnxr1qksHuaBmhbhjUfc+DgG
	 ukWlCK5lnFU2a5AJifYQlEkn9hcd+5wnzGe2Ba/fMwn/RP1/+FbcTnizxxzQ7KMrDK
	 aRtgNjMoA5tUORBscXVM56MfHNUstljCEHfUDH73q+iRawMJWv8fGNuARKuf6ApNtX
	 mrIaCBhFtKxyQ==
Date: Thu, 10 Apr 2025 15:37:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: tpm: tpm-buf: Add sanity check fallback in read
 helpers
Message-ID: <Z_e7jK00SZWSsWOg@kernel.org>
References: <20250410103442.17746-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410103442.17746-1-purvayeshi550@gmail.com>

On Thu, Apr 10, 2025 at 04:04:42PM +0530, Purva Yeshi wrote:
> Fix Smatch-detected issue:
> 
> drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
> uninitialized symbol 'value'.
> drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
> uninitialized symbol 'value'.
> drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
> uninitialized symbol 'value'.
> 
> Zero-initialize the return values in tpm_buf_read_u8(),
> tpm_buf_read_u16(), and tpm_buf_read_u32() to guard against
> uninitialized data in case of a boundary overflow.
> 
> Add defensive initialization ensures the return values are
> always defined, preventing undefined behavior if the unexpected
> happens.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
> V1 - https://lore.kernel.org/all/20250409205536.210202-1-purvayeshi550@gmail.com/
> V2 - Update commit message to clarify patch adds a sanity check
> 
>  drivers/char/tpm/tpm-buf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index e49a19fea3bd..dc882fc9fa9e 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -201,7 +201,7 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
>   */
>  u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
>  {
> -	u8 value;
> +	u8 value = 0;
>  
>  	tpm_buf_read(buf, offset, sizeof(value), &value);
>  
> @@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
>   */
>  u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
>  {
> -	u16 value;
> +	u16 value = 0;
>  
>  	tpm_buf_read(buf, offset, sizeof(value), &value);
>  
> @@ -235,7 +235,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
>   */
>  u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
>  {
> -	u32 value;
> +	u32 value = 0;
>  
>  	tpm_buf_read(buf, offset, sizeof(value), &value);
>  
> -- 
> 2.34.1
> 
> 

It's good and I think this change is appropriate overall!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


Return-Path: <linux-integrity+bounces-8154-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBCDCEF0B2
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 18:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CEAD300A1F9
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D42BFC8F;
	Fri,  2 Jan 2026 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYaaPqmn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27162BCF7F;
	Fri,  2 Jan 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374250; cv=none; b=SwOuIhgV8U9z/VvvJqpyKkInLg+DdJV7k1BDtzWKAMnmsKaugtxYfW+kBAM2TI9NG4OK4ZcSsQD0zJtJdu5s//sIjBNN17MX8YUsvsD5gNoDPV8s/wCpSzJWKrziY/sWPWaZhtcFvnTxGK8gGjE7AaIlrqheklNlnSWVomt5txg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374250; c=relaxed/simple;
	bh=YgB0mPBmMT5gK8d4pVwBQIODAR287z0W1MLn7j7Ul/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/VZaHcL1GfXBZNqSeDzsG4NbCIhURrqT0D0DLNnjEEESEANoEzgvrg6UyD8ODGG406ZQ3+y18yK1qjeRdNPiQuavOtqZc/qoeJPO+1KMvKjEmdBjRZmvdrAAOYWAyW3G90YnhBWEBE+Y0eFUOGv7RSTPxYtaM/GZ2TUyO3dERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYaaPqmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A70C116B1;
	Fri,  2 Jan 2026 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767374249;
	bh=YgB0mPBmMT5gK8d4pVwBQIODAR287z0W1MLn7j7Ul/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYaaPqmn/ruKWV7jELrEy3+pF+bvrqSIQot9RNz9MP4VbwogzTIykf31WQA1NwNZM
	 BI4uNU/ry0Tt6dGrxVysMDv3vTZwD2m//8+0zcHS4tSSFMk1KAvCgpGNppd2jpMF24
	 9bGSuRZmJa7nZJKAorGdqd317yDSOoUmJJ+r4hLZN/MSXwwQXT9RRS6NSgqX0py/3L
	 bsVrFuIbQNkx+m8z/uDtAzcY5frJmJ6qR8IZQ+eLLFd6gsPHjYzTMoRxZIvglDh2Rp
	 jtPh47cuncyde9483hgXcpeDAjYgViiwq1nt5a9LJvJdhwsIobNgPfAP2xJzeGPK+1
	 lZZHI6R7Eqx/g==
Date: Fri, 2 Jan 2026 19:17:24 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
	Bryan Freed <bfreed@chromium.org>,
	Andi Shyti <andi.shyti@gmail.com>,
	Kent Yoder <key@linux.vnet.ibm.com>,
	Marcel Selhorst <tpmdd@selhorst.net>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_i2c_infineon: Fix locality leak on
 get_burstcount() failure
Message-ID: <aVf9pNiv4fKAKgl9@kernel.org>
References: <20251226102339.45054-1-alperyasinak1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226102339.45054-1-alperyasinak1@gmail.com>

On Fri, Dec 26, 2025 at 01:23:38PM +0300, Alper Ak wrote:
> get_burstcount() can return -EBUSY on timeout. When this happens, the
> function returns directly without releasing the locality that was
> acquired at the beginning of tpm_tis_i2c_send().
> 
> Use goto out_err to ensure proper cleanup when get_burstcount() fails.
> 
> Fixes: aad628c1d91a ("char/tpm: Add new driver for Infineon I2C TIS TPM")
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
> ---
>  drivers/char/tpm/tpm_i2c_infineon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> index bdf1f329a679..8b7d32de0b2e 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -544,8 +544,10 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  		burstcnt = get_burstcount(chip);
>  
>  		/* burstcnt < 0 = TPM is busy */
> -		if (burstcnt < 0)
> -			return burstcnt;
> +		if (burstcnt < 0) {
> +			rc = burstcnt;
> +			goto out_err;
> +		}
>  
>  		if (burstcnt > (len - 1 - count))
>  			burstcnt = len - 1 - count;
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


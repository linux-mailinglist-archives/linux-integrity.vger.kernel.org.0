Return-Path: <linux-integrity+bounces-5584-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3EA7A9B2
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 20:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797EA1897F9F
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0C24EAB2;
	Thu,  3 Apr 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrC+m/6S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C321C8E0;
	Thu,  3 Apr 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706148; cv=none; b=B3OyjiHnoJhfV8aewmivrxVLOZPnw/ZasxBZVsn/n9b3m3cZIpbNHsIZXm5D8crlGV2RdtsehTWuYXq/oZjI+6FfzlzdZ426x2VtqEa1lKUcImUZ1rZ9+PhN8hPPWGXlvBZMjHurf1bsh+U6fIZMzBXoWjxsreq1AQ+qLKO9c4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706148; c=relaxed/simple;
	bh=s45X84IIvCopoQvZb69UcpWo49cbjpZHfRljFldp7wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeqfgf76psqOJqVzHjNF+5QFhdJq2CZJY9XdnzUL/CrZrzaew8uum7NC1+Aj+/ZfEptKjZ7bFAQ5peX6g0BoqAHLl0ZfU6Yq62U8xl54bDTgKqUY3ctb+cbw7nj2i5o25zKI8rPXOo4r4PbYDVmtx0JhO2/S7QhKZczAam/AweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrC+m/6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E992C4CEE3;
	Thu,  3 Apr 2025 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706147;
	bh=s45X84IIvCopoQvZb69UcpWo49cbjpZHfRljFldp7wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TrC+m/6SwS5iEmnQSgZGYa2UU1QjewOxKBHOmIs5VduBvTLDNHRpAoKuMW6cdWAqI
	 PEDFVEt73BJwdvB1banX8g/KUgCGHv3iDW29if/bVCqbj0eeH6RQAJCO/59AbDxpO2
	 2Ds1tk7ldIO91ueoaC/VkIViGVc6DnU5FLRpMHqts0J/kvDY26JvyMWSQ0twA2Yh5W
	 jIAdMFD4W5fRjHNCmLodQR6XgWhIc6Q477Ss06lTxzwWZczQCw70mG1/TpMSJFZvZA
	 Y7NuJMSFPaMo1wV/iYoVWyyf5NNIV9rMeKWVPgsddfTyRXSlA9JSKdkf7DxsyJJv1C
	 7dI74Egizs52g==
Date: Thu, 3 Apr 2025 21:49:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] tpm: tis: Increase the default for timeout B
Message-ID: <Z-7YHkb_2Dpz7GpV@kernel.org>
References: <Z-6Gau3aCB7B3pB9@earth.li>
 <20250403182519.8412-1-msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403182519.8412-1-msuchanek@suse.de>

On Thu, Apr 03, 2025 at 08:25:05PM +0200, Michal Suchanek wrote:
> With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> C) can reach up to about 2250 ms.
> 
> Timeout C is retried since
> commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")
> 
> Timeout B still needs to be extended.
> 
> Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> V2: Only extend timeout B

git format-patch --v2 ;-)

NP, but use --v3 next time...

> ---
>  drivers/char/tpm/tpm_tis_core.h | 2 +-
>  include/linux/tpm.h             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 970d02c337c7..c272c25eb9d4 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -54,7 +54,7 @@ enum tis_int_flags {
>  enum tis_defaults {
>  	TIS_MEM_LEN = 0x5000,
>  	TIS_SHORT_TIMEOUT = 750,	/* ms */
> -	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> +	TIS_LONG_TIMEOUT = 4000,	/* 4 sec */

nit: secs (that said, don't care that much)

>  	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
>  	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
>  };
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 6c3125300c00..3db0b6a87d45 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -224,7 +224,7 @@ enum tpm2_const {
>  
>  enum tpm2_timeouts {
>  	TPM2_TIMEOUT_A          =    750,
> -	TPM2_TIMEOUT_B          =   2000,
> +	TPM2_TIMEOUT_B          =   4000,
>  	TPM2_TIMEOUT_C          =    200,
>  	TPM2_TIMEOUT_D          =     30,
>  	TPM2_DURATION_SHORT     =     20,
> -- 
> 2.47.1
> 

Have you tested with:

https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=de9e33df7762abbfc2a1568291f2c3a3154c6a9d

?

BR, Jarkko


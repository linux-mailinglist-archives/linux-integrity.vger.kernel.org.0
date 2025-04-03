Return-Path: <linux-integrity+bounces-5582-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DBBA7A99B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 20:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9792818900A4
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E00252906;
	Thu,  3 Apr 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aszIuPaG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3A1DA5F;
	Thu,  3 Apr 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705531; cv=none; b=SUHYmftUL7uSmJ5ZCyUl9PnhACAYpHvX9lQpN9KGyKQcf4fyosEp9AaX6dkgJBkdTqonjG1OQk3Cu+bXCszSOKNERhy3BT0+pZOyDyqW07xc1PbxDy6kWaMtjb2NCreOIwLNJHrXP1fX680wG5sAGEgQM/IusDtvPBcNQJ9OYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705531; c=relaxed/simple;
	bh=nOQIOEoiwz2UPGEUjwxqisj2bkBWUcs3VcWP/J11NGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX+20MfLlkjl32RL8lQ1XEEh1MhFWvnPsNvea9wgX2ZkTxDW6WN4dy3RxVJ0BLRXfOCB/G5bIBjtMkz4MkjCHLI0kiYres0g78KQbRU8d3yyOr6Se6hIhF1Il4L97MU/Jvp9hCQovOYvWbGrCw1JDvIkH6wv94VEWgm6g8CuP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aszIuPaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D93C4CEE3;
	Thu,  3 Apr 2025 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743705530;
	bh=nOQIOEoiwz2UPGEUjwxqisj2bkBWUcs3VcWP/J11NGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aszIuPaGmDMu1omT3wn0gZ1lJ2JK+QS2YwE7qOb/P+y5d5oEPNRM+o8GgvOXOxIfg
	 apwCIW5KTz328BdEruJXPCz1nHquEyBjkRzyeCvMAUo1074lJ32320iTR12wYun6/F
	 vZkhtt1oWa2uwsNMUFSLme7Y/kHAvLJEf9KmpTYwroo1AbiUuJLRZrw6agYmOyPQnr
	 Y1ZN3/UgGUz7xAs7aJQPOCsBeBOanuPt6qYwXZFWS5vMrDwsODwHG5Vr+GojtCxGeu
	 VfcWKuRpdx26BRGKiKBTA6n9XWcaNY7NzYiQqKt22qLKj7toZfGeBhdF0ILNqD/EYV
	 J/aFhG0z1w63A==
Date: Thu, 3 Apr 2025 21:38:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-7VtSv675dPIsTu@kernel.org>
References: <20250402172134.7751-1-msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402172134.7751-1-msuchanek@suse.de>

On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
> With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> C) can reach up to about 2250 ms.
> 
> Extend the timeout duration to accommodate this.
> 
> Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> An alternative would be to add an entry to vendor_timeout_overrides but
> I do not know how to determine the chip IDs to put into this table.
> ---
>  drivers/char/tpm/tpm_tis_core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 970d02c337c7..1ff565be2175 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -54,7 +54,7 @@ enum tis_int_flags {
>  enum tis_defaults {
>  	TIS_MEM_LEN = 0x5000,
>  	TIS_SHORT_TIMEOUT = 750,	/* ms */
> -	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> +	TIS_LONG_TIMEOUT = 4000,	/* 2 sec */

/* 4 secs */

>  	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
>  	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
>  };
> @@ -64,7 +64,7 @@ enum tis_defaults {
>   */
>  #define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
>  #define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
> -#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
> +#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_C)
>  #define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
>  
>  #define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
> -- 
> 2.47.1
> 
> 

BR, Jarkko


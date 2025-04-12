Return-Path: <linux-integrity+bounces-5853-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0754EA869E6
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 02:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BE49A6E69
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 00:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7F78F36;
	Sat, 12 Apr 2025 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADJQyR64"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576078F24;
	Sat, 12 Apr 2025 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418856; cv=none; b=OWo8tgeJ80L3tmje7EtpRW16PhJGrb+9GlN5R0xd3fAdhjg1uJv1H/HwP4EGrMGubCkh8KWk29YNT5mKV5Raw/2RCM1SAUlSwTsano3thvvOoi7izxtsVs+EOV/psnxZJaLGKlUeDJ+My/gGm3cR6k1tGAAmvMsi8wC9YlkB1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418856; c=relaxed/simple;
	bh=rlH3+hFUHiUrNulW5hKgAfhzSfSTh0htqokszVXTTio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWdIrJDiXKfHHDHV6ncUOiJUgV9K5WnLBN9VRQQo9fwSKsIDOuxTq+jr7voemgB4VDfM3q+ev1B+4gJNIEmwo0u3J6NCX+0vzZnNjxmmYBkirIsxT0WWueDIdNvLEe83/ew0Ggstix+se2FgKI7sLnxbG3iJZe4tWNi6QZZkLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADJQyR64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA0BC4CEE2;
	Sat, 12 Apr 2025 00:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744418855;
	bh=rlH3+hFUHiUrNulW5hKgAfhzSfSTh0htqokszVXTTio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADJQyR64fh8FtvR81MAqmmbo57Q8MKKNJu0IVgl8PPuK8ThK74npi8ZbWxPiiqX3x
	 eUCifYfDTQ3HZIXXYX78/LnrAD8DaHTUsg8Kd5trUG0Wzdmnf1ykTZhn8UkehdgLn/
	 jR1tnhQQEmF0LJZMPnt5E1vrmm9yJ9NP57nxJ536AfGjT7eizETcXtxh5C3xT43lFN
	 9GW86K8Ht23n+1IoeL3yK9DdfhYAfx0s811cZ6cWZ0u7Bd8BfFqnum+nJZ6L2lM3F/
	 5vuN3JgHy/jY5HQi6JjezxyE2t2yPbhp67TUnasCgKn+lAWTCDZiCYlFElsBrtASYU
	 8Nt0+yyoa6ryA==
Date: Sat, 12 Apr 2025 03:47:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Winston Wen <wentao@uniontech.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] tpm: add __always_inline for tpm_is_hwrng_enabled
Message-ID: <Z_m4I3iaHj453ZM0@kernel.org>
References: <31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com>
 <20250411105459.90782-1-chenlinxuan@uniontech.com>
 <D513EE4F40467A51+20250411105459.90782-6-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D513EE4F40467A51+20250411105459.90782-6-chenlinxuan@uniontech.com>

On Fri, Apr 11, 2025 at 06:54:54PM +0800, Chen Linxuan wrote:
> From: Winston Wen <wentao@uniontech.com>
> 
> On x86_64 with gcc version 13.3.0, I compile kernel with:

Use passive:

"Presume that kernel is compiled for x86_64 with gcc version 13.3.0:"

> 
>   make defconfig
>   ./scripts/kconfig/merge_config.sh .config <(
>     echo CONFIG_TCG_TPM=y
>     echo CONFIG_HW_RANDOM=m
>   )
>   make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once"
> 
> Then I get a link error:

"This results a link error:"

> 
>   ld: vmlinux.o: in function `tpm_add_hwrng':
>   tpm-chip.c:(.text+0x6c5924): undefined reference to `hwrng_register'
>   ld: vmlinux.o: in function `tpm_chip_unregister':
>   (.text+0x6c5bc9): undefined reference to `hwrng_unregister'
>   ld: vmlinux.o: in function `tpm_chip_register':
>   (.text+0x6c5c9b): undefined reference to `hwrng_unregister'

The resolution is lacking i.e., why adding __always_inline addresses
the linking problem.

> 
> Signed-off-by: Winston Wen <wentao@uniontech.com>
> Co-Developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e25daf2396d3..48cc74d84247 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -534,7 +534,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  	return tpm_get_random(chip, data, max);
>  }
>  
> -static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
> +static __always_inline bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
>  {
>  	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
>  		return false;
> -- 
> 2.48.1
> 

BR, Jarkko


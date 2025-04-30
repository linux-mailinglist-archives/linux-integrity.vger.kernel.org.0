Return-Path: <linux-integrity+bounces-6103-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E8AA512B
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7F47AA34B
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2362192E3;
	Wed, 30 Apr 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nflcwBLK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D77405A;
	Wed, 30 Apr 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029218; cv=none; b=eSrvE4iUCxMHLwU9f566Jpedx0R3iJTY0HBw4cjY2lmFq8x6JB4up3j5hndhnQHq+QTM4yRwkHPS1P0SmPfyF4FYB0cHgjnafGHdVRt7yEfyh4twyirSKuoDGYKntd8p+NZc2fsXmJv4My9603WJp5hn1V81fyup46fA3LQbadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029218; c=relaxed/simple;
	bh=soJAtQ/95K0qhMDwUc6Jg9lOyFJXTYDM54IGj7C7NM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPc6oZuXcFz9B8HKi3ClOXspnp1Mb/wtPpj79cDP1dpJR1dCacP6GlZuYnJhDV+FznBT/6WefvcpC7wgLnrzVIyOKfjtp1x9aLKNARuoymtVhGnygp2Fi8Jga8TNDrsAxxCgZT1XDPDfPqQR2hQhQ8iCEK4N3F4X9RkD6hN9Yfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nflcwBLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E308C4CEE7;
	Wed, 30 Apr 2025 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746029218;
	bh=soJAtQ/95K0qhMDwUc6Jg9lOyFJXTYDM54IGj7C7NM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nflcwBLKxWZiUP7NYwl3WUucfxNnRxj3cXrtcW+IgLmfoAHernqYTD/cOk1vx+Aiw
	 fM/LZb9mqx0XZsoFsGszhVQNUKpq+nxzoOnW1LAzuKK72QryssAzMJSi+cZJxV5lfE
	 +0BDqbNaxX6ATMTZzSICbyKQNSRjxOa0k8bB1hhgPmco53mGLpIuQDTSr3mzukPfYO
	 OUAMokxguTNBULy0ZaSGbx78Xs3OfoumozydqW5UX5v6KdKtFm3A6STg4JcMimAbiW
	 ybFM7JkqUj4balokNEtGI68CmdFETR9ld7h5xkWrZHMtuYCPCqE/ypBrAPSZyISO2o
	 fgpa7xLtELKrw==
Date: Wed, 30 Apr 2025 19:06:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_crb: ffa_tpm: fix/update comments describing the
 CRB over FFA ABI
Message-ID: <aBJKnYJgke_clJOn@kernel.org>
References: <20250430154723.1025101-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430154723.1025101-1-stuart.yoder@arm.com>

On Wed, Apr 30, 2025 at 10:47:23AM -0500, Stuart Yoder wrote:
> -Fix the comment describing the 'start' function, which was a cut/paste
>  mistake for a different function.
> 
> -The comment for DIRECT_REQ and DIRECT_RESP only mentioned AArch32
>  and listed 32-bit function IDs.  Update to include 64-bit.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
> v2:
>   -squashed the two comment updates into a single patch
> 
>  drivers/char/tpm/tpm_crb_ffa.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 3169a87a56b60..134747911ba38 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -38,9 +38,11 @@
>   * messages.
>   *
>   * All requests with FFA_MSG_SEND_DIRECT_REQ and FFA_MSG_SEND_DIRECT_RESP
> - * are using the AArch32 SMC calling convention with register usage as
> - * defined in FF-A specification:
> - * w0:    Function ID (0x8400006F or 0x84000070)
> + * are using the AArch32 or AArch64 SMC calling convention with register usage
> + * as defined in FF-A specification:
> + * w0:    Function ID
> + *          -for 32-bit: 0x8400006F or 0x84000070
> + *          -for 64-bit: 0xC400006F or 0xC4000070
>   * w1:    Source/Destination IDs
>   * w2:    Reserved (MBZ)
>   * w3-w7: Implementation defined, free to be used below
> @@ -68,7 +70,8 @@
>  #define CRB_FFA_GET_INTERFACE_VERSION 0x0f000001
>  
>  /*
> - * Return information on a given feature of the TPM service
> + * Notifies the TPM service that a TPM command or TPM locality request is
> + * ready to be processed, and allows the TPM service to process it.
>   * Call register usage:
>   * w3:    Not used (MBZ)
>   * w4:    TPM service function ID, CRB_FFA_START
> -- 
> 2.34.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


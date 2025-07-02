Return-Path: <linux-integrity+bounces-6585-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD13AF6439
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 23:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924384E4340
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701892BE630;
	Wed,  2 Jul 2025 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCV11yrS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EA2BE62F;
	Wed,  2 Jul 2025 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492305; cv=none; b=SmVYg9AxkYjT//Pxvf+VUvqzIx1IzWLvXkgvk50azC9dYD7jPucoOcGPlUOEgH2jJVB+cFuW/c7Hh37ChdEC8r5PtkhlPvraD1Gny3HBlmoIQ06hasuDDvLsiF6kigOU2DkZj1owWRByrb1PX+KUNM5a34J1wZfTsATYueptMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492305; c=relaxed/simple;
	bh=Y91bfcFboLc9TQFnlee0SCl5WcJl4J9e4VfYgvhJPB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWdaQRE0qgTuXy3ajoxcHJPxuz8GXOsADOQXLdy6GvABDJRA/6Hru2Kw67kMWNDq6cROwV4uSZByvA8QGgaVu3Sbrz96YXO929CjgTKHCQtztpl18JTDPovCzIm8A070kZIykCdg2HeSd12qLUCyn8XcAvvEYmccHsLhau+BTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCV11yrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA71C4CEEE;
	Wed,  2 Jul 2025 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751492304;
	bh=Y91bfcFboLc9TQFnlee0SCl5WcJl4J9e4VfYgvhJPB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCV11yrSHut1diowD+L/PUReBbtxNktGuyl0SgTGXq8utvJApU00amIwYe7HhMxkk
	 mTh4kTc+YXmv1aE7XDFx9N5RWdub1qovyVxNEURWJxu8CE6Ocjd9C1vsAL0PJQdxK8
	 TAXQiTLxErzzWbmpmb3v8VYmfappRbdiB3Y39VFAMNjKWYcmNUJT6bnLpSEegvLdY2
	 U1ibbCIQ6UvvZ4+JSatNOB8LO3Jed9xQpp/YOTqIbxxNKB/ycZFQjlMhteARnuY8u/
	 C3mIiLz5c8OQX2iq7/efOEjcU8fymkJfGMnT+bFb6QNy3Rv/pxfPas3UkZ28W4pBcO
	 dkR+pXan8U8jA==
Date: Thu, 3 Jul 2025 00:38:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tpm_crb_ffa: Fix typos in function name
Message-ID: <aGWmzF8_dMP9As_3@kernel.org>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
 <20250626184521.1079507-2-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626184521.1079507-2-prachotan.bathi@arm.com>

On Thu, Jun 26, 2025 at 01:45:19PM -0500, Prachotan Bathi wrote:
> s/recieve/receive in __tpm_crb_ffa_send_receive
> 
> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 4ead61f01299..089d1e54bb46 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -178,7 +178,7 @@ int tpm_crb_ffa_init(void)
>  }
>  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>  
> -static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
> +static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>  				      unsigned long a0,
>  				      unsigned long a1,
>  				      unsigned long a2)
> @@ -251,7 +251,7 @@ int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
>  
>  	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
>  
> -	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
> +	rc = __tpm_crb_ffa_send_receive(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
>  	if (!rc) {
>  		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
>  			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
> @@ -289,7 +289,7 @@ int tpm_crb_ffa_start(int request_type, int locality)
>  
>  	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
>  
> -	return __tpm_crb_ffa_send_recieve(CRB_FFA_START, request_type, locality, 0x00);
> +	return __tpm_crb_ffa_send_receive(CRB_FFA_START, request_type, locality, 0x00);
>  }
>  EXPORT_SYMBOL_GPL(tpm_crb_ffa_start);
>  
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


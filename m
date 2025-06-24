Return-Path: <linux-integrity+bounces-6499-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B27AE7106
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jun 2025 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40E01BC045E
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jun 2025 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05972256C7E;
	Tue, 24 Jun 2025 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+pzpIub"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19012405E8;
	Tue, 24 Jun 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798203; cv=none; b=QH6BFSITjy0jxISHnYlFa8clf+/gRR1eN/1vIW9XgMeaUpR7NKALp1piZt0yxX1yY7RISyOkUuUw2+3cfhRGcGBRjdDwAMENA6Fxszoc9Nymh7ZGa3w5vEKvk9NpphesWTEWI4XpIE3nzBge/Y3hqrURO9hhh6vs/LoN/IHP3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798203; c=relaxed/simple;
	bh=aGe9ueG/mhpQ8OApLXAL0LycRHnjuzuivmQlrxXLcWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ55Og2NP1oaDOI/k8LYCWTs7veHDfgiiWanoDCGT8xizYKmloQdkvwqYcfOBQEkX0GPmJe4g/yYj4FddOpiQk7MgGnAqAHpt3xOHvfIG8b2kdC24HNCAj49xqkAOMHuN1htevX2W+EF8n7ZbPk9m9vEzsF6Iopurcdy7gUBpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+pzpIub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E105C4CEE3;
	Tue, 24 Jun 2025 20:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750798203;
	bh=aGe9ueG/mhpQ8OApLXAL0LycRHnjuzuivmQlrxXLcWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+pzpIub+yklVfJkDQvLOWne3dVevjDJoWEZBI2k0i7oyLIuYS4MdmbyYsd9Vje+1
	 xqy4y1/7fYuIAyusg9Hd1AoJ52Jnfy2C33/810ywnsXRmVbomgubqKbUetjaRDs6vE
	 J9LNaVm0R3EsSxGW0TC4aEc6pos52pC/WyWq5HJ90HsHQ/K6+aN82VY1MJH4aVgJFQ
	 sUz4YC8ZfTPY4ao8a8ybKwaTm/8TVSfcWK/Kak8lU7jebP03YYrvwj0VT8WqJL+IBv
	 SrKajzbCRqNH/J1EUbmOsjIAIk/snDB+8KfKRbBBQWfMSfs2S+vLxsN+OXGTx5aIkC
	 Pa1p4UGQ5RfHg==
Date: Tue, 24 Jun 2025 23:49:59 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] tpm_crb_ffa: Fix typos in function name
Message-ID: <aFsPd7u3hGGEzvaE@kernel.org>
References: <20250617160544.444321-1-prachotan.bathi@arm.com>
 <20250617160544.444321-2-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617160544.444321-2-prachotan.bathi@arm.com>

On Tue, Jun 17, 2025 at 11:05:43AM -0500, Prachotan Bathi wrote:
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


Return-Path: <linux-integrity+bounces-5974-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC81A95653
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5147B7A52A8
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1821EF375;
	Mon, 21 Apr 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUp44QdV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C41EB9E1;
	Mon, 21 Apr 2025 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261711; cv=none; b=OPh7PqDkONmqqfpFOp6J2SkRT1Kkm4+pE+YJGMO0dc5XvRHhaJ5Mv41sdgXZXCpCiq0NdRMC1/zsbTN1qvS99//9yXusJoZiZ+h5KYnIQXgw2XeXWn5yPURg+vlO7/+fFIPQMDBIaGiWyxllLgHCko2GIQ6laUm/MUNXO+LLsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261711; c=relaxed/simple;
	bh=nEF9FBgVl+xbfUy1g58s4YuIiAfXhF7xs7ILK7Z2sEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfJQ5iNFn7yRz3Y4SpnGCoHO8ftGID7gnuABV0kT2qDMixBNqtCaEHCDe75GZrrGcK6HjpqAO3Nj+SB/t38mySxvojvOs0i7lt8eaP3E2WxoameVnFfhEmZxO2Xz6ayuaYF5utLuQQgKrPyvMk3rJ9kOHqSg+d9PpyFnRnAGu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUp44QdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26751C4CEE4;
	Mon, 21 Apr 2025 18:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745261711;
	bh=nEF9FBgVl+xbfUy1g58s4YuIiAfXhF7xs7ILK7Z2sEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUp44QdVDqhFgBSzrP5etYynpr7EWUmb0QtocxSiONi9qPorw7x2paUl5s7Hd1dLY
	 fMPI/zR7JXA0mUfKO9EboVjpPfD7RhcEiRq9loi/DlqAsNue+y8JE6QRZhJOpcIF2x
	 0f3BMHR1CpPs2aqoK/DirgyqpIVwl5HvEuPpa2qJi4BQns3WQ78eM7o316zR7u2r+J
	 noEEGnSjlETcW+CqAjrPgySFo+bb1oBz/1MVKIhXCcrZSQYRaUThraVGovDwYp1JPw
	 OvwmJHSwINX002vwOCDeafIdkOQsaH8DkdvTfY3HXFP7kLouUAwDM6KicDkqGn88Wf
	 CT/i/6N4UXjnA==
Date: Mon, 21 Apr 2025 21:55:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-crypto@vger.kernel.org, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v8 5/5] MAINTAINERS: Add tpm_loongson.c to LOONGSON
 CRYPTO DRIVER entry
Message-ID: <aAaUih-kWUUePH6z@kernel.org>
References: <20250418093600.1363-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418093600.1363-1-zhaoqunqin@loongson.cn>

On Fri, Apr 18, 2025 at 05:36:00PM +0800, Qunqin Zhao wrote:
> Changes to Loongson TPM driver would be best reviewed by the Loongson
> crypto driver maintainers.
> 
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> v8: None
> v7: Added tag from Jarkko and Huacai
> v6: "tpm_lsse.c" -> "tpm_loongson"
> v4-v5: None
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a4726df8f..eb99b7a66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13916,6 +13916,7 @@ LOONGSON CRYPTO DRIVER
>  M:	Qunqin Zhao <zhaoqunqin@loongson.cn>
>  L:	linux-crypto@vger.kernel.org
>  S:	Maintained
> +F:	drivers/char/tpm/tpm_loongson.c
>  F:	drivers/crypto/loongson/
>  
>  LOONGSON-2 SOC SERIES CLOCK DRIVER
> -- 
> 2.45.2
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


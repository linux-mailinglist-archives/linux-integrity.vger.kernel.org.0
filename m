Return-Path: <linux-integrity+bounces-7610-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF39EC4387E
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 05:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E46D3AD33A
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 04:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC021257E;
	Sun,  9 Nov 2025 04:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfkeOS4/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C81E2614;
	Sun,  9 Nov 2025 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762663471; cv=none; b=qoth25vPjsG7Em/9sw+C3sCgc7aPbTW7rfCREMvzhoeKgs4ysnRGFJEPz89LFyyCpf9/kxGNLA8xf3UytkSrqhoQw839JiX3SAVNTNg4e+K0c//Qew5ZctFeMxSxLxjcQP3tEwrhNqkSCYoQbzOC/7ooSmQW5GN2VN2kaCV3x1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762663471; c=relaxed/simple;
	bh=dSCMVlxgbRxcltCVOS9fSnz1bcEq369Ld7O2nD6fddw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/T7yUQYWg/I+tly7O1JRIVU0unbn5rmLfdJM+GzNfrvIJk4Ja47kjX7hr79TegdB2EnO5Ux98zvw5aT55wTQfRDxwgZ+SUMbuKjCGkeYwpLbGdWjCUBG/VtBa1N9xYi67Ot8RXuafNDZIT78zeYF66Dw21+rc13E2yN7aAe9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfkeOS4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60905C4CEFB;
	Sun,  9 Nov 2025 04:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762663470;
	bh=dSCMVlxgbRxcltCVOS9fSnz1bcEq369Ld7O2nD6fddw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfkeOS4/JtxImUwSj1soiduL4+DZleZRSeCAwhCyUPXYStMv+GFxlSibW3TERsP+w
	 f2Vby8JhBlrpQMLi30S3EhFRG6RFMJPhB7wYk8X+tLbmUixXqnUVllzsocTseQqegM
	 YGAjgZsOuPw/2z5KFxycHyGW1yd1lhT0aT1PRY9eDVdGTJCm81tUzgsLO8Bih5CGDZ
	 dzKqvEfiYoa7V88ADhHs6/EjiPPZgt9A+pwP7ByOgArIYG3JrMjUmdIlRMhht9b10J
	 z2oZtl+00nIAReL+DxLKKygweSdVMxBXck4Zy+CEs7LHD9ehc+d4Roy4BeGHMfc8H4
	 /MgzLlqee7Xxg==
Date: Sun, 9 Nov 2025 06:44:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: a.fatoum@pengutronix.de, kernel@pengutronix.de,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH] KEYS: Remove the ad-hoc compilation flag CAAM_DEBUG
Message-ID: <aRAcK_eBtt5MajSh@kernel.org>
References: <20251028132254.841715-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028132254.841715-1-yebin@huaweicloud.com>

On Tue, Oct 28, 2025 at 09:22:54PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Fix the broken design based on Jarkko Sakkinen's suggestions as follows:
> 
> 1. Remove the ad-hoc compilation flag (i.e., CAAM_DEBUG).
> 2. Substitute pr_info calls with pr_debug calls.
> 
> Closes: https://patchwork.kernel.org/project/linux-integrity/patch/20251024061153.61470-1-yebin@huaweicloud.com/
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  security/keys/trusted-keys/trusted_caam.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index 601943ce0d60..c903ee7328ca 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -28,16 +28,10 @@ static const match_table_t key_tokens = {
>  	{opt_err, NULL}
>  };
>  
> -#ifdef CAAM_DEBUG
>  static inline void dump_options(const struct caam_pkey_info *pkey_info)
>  {
> -	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
> +	pr_debug("key encryption algo %d\n", pkey_info->key_enc_algo);
>  }
> -#else
> -static inline void dump_options(const struct caam_pkey_info *pkey_info)
> -{
> -}
> -#endif
>  
>  static int get_pkey_options(char *c,
>  			    struct caam_pkey_info *pkey_info)
> -- 
> 2.34.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


Return-Path: <linux-integrity+bounces-7532-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE5FC114D7
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 21:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FF5423705
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 20:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8E30FC37;
	Mon, 27 Oct 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/jgZRkL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B892C11FB;
	Mon, 27 Oct 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595484; cv=none; b=bGBOUK3ECeL0yiusWGU87Z5Tccav1AaCkbXcIRdrpFWE/sY4UBNeZVlCtf3ddOHytcfDWHdZeQ5mOgs+Nd+fKOKseCJqzImCOJ7vC6SAkC4wyb2Gpap1OmsK+IycbQAmmhefOIJqWSjYjtp0ev9hln7UdmFJM507rD25GywaLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595484; c=relaxed/simple;
	bh=EnNKNaiHm5HxfSb4yNWmz72UgSxuTATcZtZuzLoFWrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMuyCQGD8/pAtzZotXrmNm4UvMoHyhEb5noeI+Hk3vmAIUtilBLYJboa/dPei6OaRKrjXQXpD+4NS6cZRJPhIbf/14qxdyil8RvLuOZuPQuE25+sXqi7OZEk27MF6GuwNrNQsu4/QGR/Vid6j59ErXM+joT3YyfRDrwQKVHHB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/jgZRkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A117AC4CEFD;
	Mon, 27 Oct 2025 20:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595484;
	bh=EnNKNaiHm5HxfSb4yNWmz72UgSxuTATcZtZuzLoFWrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/jgZRkL+95td/zRH3IvCLUPQZ8c6y871vYAogLjA/3AbE9qZ/3G8rkgJeA2x3CnX
	 fZKDJ3CJwSenU29b4nDzSZi/Lv+xF4gtq8ovALvORfiXTL36horYYvDT34aevA/PIC
	 7t8SesDf2tsko4Bhqv5vVyCr7IHdEPKnb71l0QFIAI6EHBzElixntecgtBfHiblF9o
	 4jAcPiXfUXRwB+LrDzxe+sc1ppbtEH/J1b3T055gD1Y5vJ7DTOQHzLAfeoWnLuIQin
	 m/2BpxY2gUDLpYesEpocbcYJG9vUnhOJBX49YSiinGvhXLdAsfwNpj/uQEO9mIe7rE
	 O63wSH+L1bfxA==
Date: Mon, 27 Oct 2025 22:04:40 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: a.fatoum@pengutronix.de, kernel@pengutronix.de,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH] KEYS: fix compilation warnings in the dump_options()
 function
Message-ID: <aP_QWHPHpGr-nUZD@kernel.org>
References: <20251024061153.61470-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024061153.61470-1-yebin@huaweicloud.com>

On Fri, Oct 24, 2025 at 02:11:53PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> security/keys/trusted-keys/trusted_caam.c: In function ‘dump_options’:
> security/keys/trusted-keys/trusted_caam.c:37:20: note: the ABI of passing struct with a flexible array member has changed in GCC 4.4
>    37 | static inline void dump_options(struct caam_pkey_info pkey_info)
>       |                    ^~~~~~~~~~~~
> 
> To solve the above problem, pass 'struct caam_pkey_info*' type parameter
> to the dump_options() function.
> 
> Fixes: 9eb25ca6c973 ("KEYS: trusted: caam based protected key")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  security/keys/trusted-keys/trusted_caam.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index 090099d1b04d..dd7a69bcf6a3 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -29,12 +29,12 @@ static const match_table_t key_tokens = {
>  };
>  
>  #ifdef CAAM_DEBUG
> -static inline void dump_options(struct caam_pkey_info pkey_info)
> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>  {
> -	pr_info("key encryption algo %d\n", pkey_info.key_enc_algo);
> +	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
>  }
>  #else
> -static inline void dump_options(struct caam_pkey_info pkey_info)
> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>  {
>  }
>  #endif

Please fix the broken design while at it:

1. Remove the ad-hoc compilation flag (i.e., CAAM_DEBUG).
2. Substitute pr_info calls with pr_debug calls.

Then you can turn then on and off either dynamically, or alternatively 
from the kernel command-line [1].

[1] https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html

BR, Jarkko


Return-Path: <linux-integrity+bounces-7554-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B8C26ED6
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 21:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9B3A4F5A68
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70142F12B0;
	Fri, 31 Oct 2025 20:41:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61132936B;
	Fri, 31 Oct 2025 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761943285; cv=none; b=gdDZ4TBwJh+S7ehNqgUoersuU9S+A3R1qtewYCrlARoRXIl+XC6Wef5UoLdtwTtLdxEY8YwGWwdc1hcIEbFd02mXO5k3hxX0XJYiv/Tqnh3UD7TBUI8y3MEWOqOl0knVVxoHXndse0bbgDBo5Kh4pIKkF+E8pv6t9EGp3PZLWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761943285; c=relaxed/simple;
	bh=VKMH5ADN6Y0bkl3xfKiVPjr68oDFbpdP0A37HXd3aNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ27DNHGuKjTPg5ecWn5HDppGTvhkwmM3ZmnMYx83K5+LDWqs6mi14oJvtU8JbtKyU4Dg+8+w7GWcQ80yexonJcSBZap9r2tlECKNH3IA+dFr3s5NT+k62QzSk+rcMsLmaC7KFRXsUdfD7P/5q06svkof7tRKrUu+a4H5EE782E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C2E533F4; Fri, 31 Oct 2025 15:41:20 -0500 (CDT)
Date: Fri, 31 Oct 2025 15:41:20 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: a.fatoum@pengutronix.de, kernel@pengutronix.de,
	James.Bottomley@hansenpartnership.com, jarkko@kernel.org,
	zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH] KEYS: Remove the ad-hoc compilation flag CAAM_DEBUG
Message-ID: <aQUe8LXwyeZXTzBl@mail.hallyn.com>
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

Reviewed-by: Serge Hallyn <serge@hallyn.com>

(I guess this is only in linux-next right now?)

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


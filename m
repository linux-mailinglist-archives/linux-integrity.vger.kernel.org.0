Return-Path: <linux-integrity+bounces-5338-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818EFA6A918
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 15:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A13A7B1828
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460A1E2852;
	Thu, 20 Mar 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRdovX/x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0291E1DF1;
	Thu, 20 Mar 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482336; cv=none; b=edEn8ZmWLxjAWKa2FttfR/3rB2RtDO3ag+eiC71OQFIWnzRZisrHYZ7g83I7rLvjo0rWlJijLxQ7/opPJ6c9EBzJ47XRm/5491+5PYBys0jMD9+UxYlbyEnav0nMA9buWdnnQ2pE9106wPyUF/AAdib2OU51gwySB6x1XE8IRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482336; c=relaxed/simple;
	bh=i4ccmJVw2G//TPp4o3Pkz8L4ugx1OstMRn3/JVIzkS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o94Dl7H4saouxuR7chpW15JCZ+mvTaULUwkYkDeNnxC6ut15xU/Wm8XlmNsbzM4NjNO20CQcYD9ZKlPCYvzl+C/Hm7+uVIALMS0ORvKRl010ok6L40fEhKiD3f/MWxWQg+dPo3if8cJQr0ejsVyMBMEBTDGbrrIiI/YtIvvWzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRdovX/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC853C4CEE7;
	Thu, 20 Mar 2025 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482335;
	bh=i4ccmJVw2G//TPp4o3Pkz8L4ugx1OstMRn3/JVIzkS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRdovX/xFzu7cs3TIl6sDxyxMGTcZrvfa4PBJcP8ZRZBL/8LGFWM2/fs6YW1+PKNL
	 h/PvCPsvfP4TxVIRVySFnp1TqJnaTa5M9pRU3bikqiQZpPhJfBITDuDKZGlLkTnVIk
	 jaPbNJ8S0EFO+JrhSMAn7DdsOo6MHcd/bFaGylaM817gFG5qBGniZ9vbT7N++q+vvw
	 MIubR1BHM5jyREb3SvsIldN38qyPOgEmf01VtBBOe+LH7vb6MteLunc2pGS29NHn/w
	 L+LiAMt6fWLBq0vhJEM9xu7N9kxOJxisHiZ+gzWhA/BMPYrzgEDDRzfmBbBNBnQyDj
	 Dq6CuauAmUF2A==
Date: Thu, 20 Mar 2025 16:52:10 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when secure
 boot be disabled"
Message-ID: <Z9wrmoPHWoxdEImx@kernel.org>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9wDxeRQPhTi1EIS@gardel-login>

On Thu, Mar 20, 2025 at 01:02:13PM +0100, Lennart Poettering wrote:
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index d1fdd113450a..7783bcacd26c 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -7,7 +7,6 @@
>  #include <linux/err.h>
>  #include <linux/efi.h>
>  #include <linux/slab.h>
> -#include <linux/ima.h>
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
>  #include "../integrity.h"
> @@ -211,10 +210,6 @@ static int __init load_uefi_certs(void)
>  		kfree(dbx);
>  	}
> 
> -	/* the MOK/MOKx can not be trusted when secure boot is disabled */
> -	if (!arch_ima_get_secureboot())
> -		return 0;
> -
>  	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
>  	if (!mokx) {
>  		if (status == EFI_NOT_FOUND)

The original commit message is foggy:

"
    integrity: Do not load MOK and MOKx when secure boot be disabled

    The security of Machine Owner Key (MOK) relies on secure boot. When
    secure boot is disabled, EFI firmware will not verify binary code. Then
    arbitrary efi binary code can modify MOK when rebooting.

    This patch prevents MOK/MOKx be loaded when secure boot be disabled.
"

Given that I don't understand the problem it is trying to solve:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> --
> 2.48.1
> 
> 
> Lennart
> 
> --
> Lennart Poettering, Berlin
> 

Jarkko


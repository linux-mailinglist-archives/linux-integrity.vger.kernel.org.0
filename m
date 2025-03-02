Return-Path: <linux-integrity+bounces-5037-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BFEA4B451
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Mar 2025 20:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D9E169184
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Mar 2025 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4C1E9B30;
	Sun,  2 Mar 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2f68+Nd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8518C1D79A6;
	Sun,  2 Mar 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740942692; cv=none; b=YsINh4mZS2e/tzU4nQuunYpReT0U1C9Y0t0WWoWwmaNfzHhTLndW3c1i+YpJGDbHartT06BW/K3JacgPC/Rpu5p852cVNpaH8khttiHMRx/LwCxgrZpCXu0yC38y4vgEwf+H3+Aupx8W8TIhMt5exCj3TumpVhbp5dv3jJuH2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740942692; c=relaxed/simple;
	bh=XZV369gKHSeDsDgsRRK780FOKNoHFAEPdkxGBRpva7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzvXR5vcqkndTUvYP696GggBcQhTA78o9u87nm9R5LbOmKlwbfb9HJaymic1SE7damr/cN544fxsaoIJlZz6nFiqsvd7lpbKMwRo4UMhicUny9BnuPVEa+cTLoSsIZNCQfgzu1omRVfj6sjguN3cyCjAAFiCqBQ1SpHpHSVnqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2f68+Nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6636CC4CED6;
	Sun,  2 Mar 2025 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740942691;
	bh=XZV369gKHSeDsDgsRRK780FOKNoHFAEPdkxGBRpva7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2f68+Ndzfu+Y4MZCvf08RK6JG1U3c0VjsGyrfgWobqKPw70akKWS986eYuJ0gLzL
	 85TL8lXrBhltygr6z/TWneIKSneEUaeq66vT/8q6eIU6UYGRolUIgDZIYcTguFgf/G
	 SQUTgvaO110AmBcBP5urGcyAXZY5T9Exy+BZyFq7vdVmah8XWnrrB0e/bU/Di/CiKw
	 uiJ08O4CQcHxZMnDh+6ySlo7mRZ1Q2KCcozq+DjZ57vdWOgIolPpUU87UxiVL1+/Ao
	 HzfoB0dsgTO1PZgjh6KKFSfMuqPit8nydQijOWr8QtNs34TIFJwWqXjY+LDBbdzow9
	 UPpkBRqg8HlBQ==
Date: Sun, 2 Mar 2025 21:11:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: ftpm_tee: remove incorrect of_match_ptr annotation
Message-ID: <Z8StX2KM24wQNdjA@kernel.org>
References: <20250225163718.4169649-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225163718.4169649-1-arnd@kernel.org>

On Tue, Feb 25, 2025 at 05:37:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=1 shows a warning about of_ftpm_tee_ids being unused when
> CONFIG_OF is disabled:
> 
>     drivers/char/tpm/tpm_ftpm_tee.c:356:34: error: unused variable 'of_ftpm_tee_ids' [-Werror,-Wunused-const-variable]
> 
> Drop the unnecessary of_match_ptr().
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> An earlier version had this combined with other changes, I made it
> a separate patch now
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 139556b21cc6..8d9209dfc384 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -362,7 +362,7 @@ MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
>  static struct platform_driver ftpm_tee_plat_driver = {
>  	.driver = {
>  		.name = "ftpm-tee",
> -		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
> +		.of_match_table = of_ftpm_tee_ids,
>  	},
>  	.shutdown = ftpm_plat_tee_shutdown,
>  	.probe = ftpm_plat_tee_probe,
> -- 
> 2.39.5
> 

It's now in my master (back from holidays)

BR, Jarkko


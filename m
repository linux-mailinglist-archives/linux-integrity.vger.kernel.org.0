Return-Path: <linux-integrity+bounces-5031-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC4A4A7BA
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 02:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8FC3B8F35
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 01:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7168D14A0BC;
	Sat,  1 Mar 2025 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcO+D4+b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B585C5E;
	Sat,  1 Mar 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794287; cv=none; b=AnbZNGSfYd8H1SOksg+pt+tVPCpvkCgl7S9lFuMfYn1FGNzJpYnXMvsfQjpFCSs/xFLovMlbb74VToDjDhjzbz8xLJtPV0JfDC1QnoPBYio8rRnRMu0hK+nowURl+Rszi94bY9nBxgyFEUKfkvuKgAutjBKzCoLHH2ygX2pEgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794287; c=relaxed/simple;
	bh=RA0ZjtxpWH/AGE0YH5BgYOTCLJEvkB3EQ+6WfwlCeqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvWk2G5+15wjSmeKXPiv5/Cpaim+h6Nm61k4JfneiPg7uUt6m8TRjXH9mkNe4MeAj81nb9M0HcsgH8R+Pq67B8B7brbfRvbhRLi2MOJYsrX7zBKIBI/Zm7DTeRsJBOPcYcnjlekCvqkfa5jAEinwJo4+cxdE7DOFxwAIFT+zGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcO+D4+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D35C4CED6;
	Sat,  1 Mar 2025 01:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740794286;
	bh=RA0ZjtxpWH/AGE0YH5BgYOTCLJEvkB3EQ+6WfwlCeqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcO+D4+bzI7UmbDd3NN/vgTzX7ALAuv7oVl9gQGDYH5E7xYmVFpbU6RCdUqb4M87v
	 P9rbYEkqk9bQe6/4xEeWpTBhSl3BIQ4ohZ23YKUhX/BQ6avqflzXtulipO92fTAg71
	 p5yIEMFldHxmbuDMg7ICVB27trQIdZOJteY4lXDbSplrxGa3SVF3jxk44Ux7iYt9uo
	 WjEzYKLjZOR8GFPgZ73NXo02YRYW3Fj519xGHa9ZRZ+LorW15ZMoc5dEqfZVOOI5zN
	 yfcfelLrl6KN/F40JrVTJmA8nyL4PQjyfMjEUzXr/HYhm2JdcRGIAPs+2drgidgtma
	 vsigBUkwzS9JA==
Date: Sat, 1 Mar 2025 03:58:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: ftpm_tee: remove incorrect of_match_ptr annotation
Message-ID: <Z8JpqmXE9xJDA3X8@kernel.org>
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

On Tue, Feb 25, 2025 at 05:37:15PM +0100, Arnd Bergmann wrote: > From: Arnd Bergmann <arnd@arndb.de>
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

I've been on holiday (back at work on Monday).

Moving to my TODO folder, thanks.

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

BR, Jarkko


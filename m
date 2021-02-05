Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F43310286
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 03:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBECFJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 21:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhBECFH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 21:05:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB18064F8C;
        Fri,  5 Feb 2021 02:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612490667;
        bh=a5SkZ9ToIlPVKBvkHANzaTJxWRyFUM3+72lidawO2FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3ATyfTJrUwcqOdjrKuEuX5MLQcxkUZ3biRRym+9vVyHOfWnfwDhKgS9g3AXpT4fn
         04EKJ9iY8MRWsD1twEOxYn9oigEYG1ZGNQuktOIsoXPculhwKciwqWRbB11FdKnpt3
         4TMzk5kexC+uax+jT6zOQ5RmxA5oJmsY3HRTDEo4gxTeiiLrXXeazS+RbI6hZX0mCm
         tN88+Wvtcn/Or92HO4Pc5SBjJJE0gZcNsYnGVs+JKrq4oiQFxJoGEJfHyf0bscwxQe
         rqUhsorSQDuA/rCIq1tSu55ji8hFm+xa3YV6KEvphU1mUWn27+JVa80neTkjXxTlZ7
         3+onlWT6k3vkQ==
Date:   Fri, 5 Feb 2021 04:04:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/ppi: Constify static struct attribute_group
Message-ID: <YBynopNwhIhGBXv/@kernel.org>
References: <20210204215427.49047-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204215427.49047-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 04, 2021 at 10:54:27PM +0100, Rikard Falkeborn wrote:
> The only usage of ppi_attr_grp is to put its address in an array of
> pointers to const struct attribute_group. Make it const to allow the
> compiler to put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Thanks.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
>  drivers/char/tpm/tpm_ppi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index b2dab941cb7f..40018a73b3cb 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -358,7 +358,7 @@ static struct attribute *ppi_attrs[] = {
>  	&dev_attr_tcg_operations.attr,
>  	&dev_attr_vs_operations.attr, NULL,
>  };
> -static struct attribute_group ppi_attr_grp = {
> +static const struct attribute_group ppi_attr_grp = {
>  	.name = "ppi",
>  	.attrs = ppi_attrs
>  };
> -- 
> 2.30.0
> 
> 

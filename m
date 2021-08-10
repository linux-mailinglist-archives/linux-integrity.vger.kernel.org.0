Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E69B3E7D57
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhHJQT5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 12:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhHJQT4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 12:19:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D515600CC;
        Tue, 10 Aug 2021 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628612374;
        bh=rUrQspPgCz1GB/kLMPpAV5Oz5uFIYwUtwRxo8l8CgxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoKJI/tWK/6kSLtIxyJfheigFp9Dbk39gOIdQawyWlg/IV94uf8MeVLmFCk/QQFGZ
         nrURh8v2Y/B2Ah/51rD46AOuFfzffVzne77EWYedGNlu+fHlDNjC/TI0ahcurePvdQ
         MRbnVzVIw3VloWG+nu87QnB1v4o+O5LBh8KhXkybvvbw7+Z0+xXZajZMOnP5Zy6vMx
         yYLnP9WMwnDJVHB+x0oKDdtdOqdf8pStAfdCAqjQzZjXJxNo/bsOltJkph/KE8sFoa
         J/M+fytEJTw0ReNNrAkT0GAGy4pF2vseBrTdWNnLtxsewLz4VYcDA+jV7RlAr0AEMR
         jXgBkj8miZhkA==
Date:   Tue, 10 Aug 2021 19:19:32 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v3 02/14] x86/boot: Add missing handling of
 setup_indirect structures
Message-ID: <20210810161932.wdwfu3wosjytdj4h@kernel.org>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
 <1628527136-2478-3-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628527136-2478-3-git-send-email-ross.philipson@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 09, 2021 at 12:38:44PM -0400, Ross Philipson wrote:
> One of the two functions in ioremap.c that handles setup_data was
> missing the correct handling of setup_indirect structures.

What is "correct handling", and how was it broken?

What is 'setup_indirect'?

> Functionality missing from original commit:

Remove this sentence.

> commit b3c72fc9a78e (x86/boot: Introduce setup_indirect)

Should be.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")

 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/mm/ioremap.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index ab74e4f..f2b34c5 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -669,17 +669,34 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  
>  	paddr = boot_params.hdr.setup_data;
>  	while (paddr) {
> -		unsigned int len;
> +		unsigned int len, size;
>  
>  		if (phys_addr == paddr)
>  			return true;
>  
>  		data = early_memremap_decrypted(paddr, sizeof(*data));
> +		size = sizeof(*data);
>  
>  		paddr_next = data->next;
>  		len = data->len;
>  
> -		early_memunmap(data, sizeof(*data));
> +		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +			early_memunmap(data, sizeof(*data));
> +			return true;
> +		}
> +
> +		if (data->type == SETUP_INDIRECT) {
> +			size += len;
> +			early_memunmap(data, sizeof(*data));
> +			data = early_memremap_decrypted(paddr, size);
> +
> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +				paddr = ((struct setup_indirect *)data->data)->addr;
> +				len = ((struct setup_indirect *)data->data)->len;
> +			}
> +		}
> +
> +		early_memunmap(data, size);
>  
>  		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
>  			return true;
> -- 
> 1.8.3.1
> 
> 

/Jarkko

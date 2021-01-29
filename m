Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F7308BC5
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Jan 2021 18:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhA2RmH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 12:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232649AbhA2RhA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 12:37:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7881C64E06;
        Fri, 29 Jan 2021 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611941763;
        bh=UU3PVz9wczpUtXMLDgF1j7n5nGXjETwd6kHnGceGTmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Egkn8VYL5xQe4bwWplZcAw7ap+1YC4uCHmi759G/EtZ/DcRoGHVBcCJLPUA8cUKFs
         YA/r7Rgqog5WXiGx4WxNizNqM/YK5Om5JUQ03O1c0PbWtj1HzMIu8V4g91GeM7GV37
         jGvCoAnmLaqgivjZsnI0pB1NfyBTC4IhIA2U1hc0K1ucVlPpEiVqvnq1uZ9+nLYSrP
         hl9X7Lq+qfkDCb4yH7sONyua1KVpTWmd4zrkEfqdg6NYUivDAxaW3RZ4Ru3Hc73y2K
         exlTX14UqhOGxgPaUdR8QW6WuscoiToTo0QSDcWNXsyc47+CarIgAwmRwu17e/xjSN
         bYTMlSvs9nlBg==
Date:   Fri, 29 Jan 2021 19:35:57 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Hulk Robot <hulkci@huawei.com>, Wang Hai <wanghai38@huawei.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: fix error return code in
 tpm_ibmvtpm_probe()
Message-ID: <YBRHfZeqAirQolIN@kernel.org>
References: <20210126014753.340299-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126014753.340299-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 25, 2021 at 08:47:53PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Return error code -ETIMEDOUT rather than '0' when waiting for the
> rtce_buf to be set has timed out.
> 
> Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks! Should I add

Cc: stable@vger.kernel.org to this?

/Jarkko


>  drivers/char/tpm/tpm_ibmvtpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 994385bf37c0..813eb2cac0ce 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -687,6 +687,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  				ibmvtpm->rtce_buf != NULL,
>  				HZ)) {
>  		dev_err(dev, "CRQ response timed out\n");
> +		rc = -ETIMEDOUT;
>  		goto init_irq_cleanup;
>  	}
>  
> -- 
> 2.25.4
> 
> 

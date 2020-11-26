Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796412C4DCF
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Nov 2020 04:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgKZDfU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Nov 2020 22:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387414AbgKZDfU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Nov 2020 22:35:20 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B3520578;
        Thu, 26 Nov 2020 03:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606361719;
        bh=Pm86dA96vUB8ve/WV9A5oJB00MJ+s60jMcnkxr4UFJo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ao43ezJomqCbc8UXSXpuCxDN6NNJmTWH9EJcqzDgLvZaJZ9Wg6lnU4GQFDMO0AYw+
         d+DefLfOulwbgxAPWLfgHsJrqlzxao1dhx6WLIFrGh2fBDv5BqHqrlWxgIvK9vCWTA
         vNIrbJDnVXQs47LMpv0bSM8ltuFv7p9/om+dkb3g=
Message-ID: <4192b5a07ebd0539dd8244afe9e065b4996f4f4a.camel@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: fix error return code in
 tpm_ibmvtpm_probe()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Wang Hai <wanghai38@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, stefanb@linux.ibm.com, nayna@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 26 Nov 2020 05:35:15 +0200
In-Reply-To: <20201124135244.31932-1-wanghai38@huawei.com>
References: <20201124135244.31932-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-11-24 at 21:52 +0800, Wang Hai wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before
> proceeding")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Provide a reasoning for -ETIMEOUT in the commit message.

/Jarkko

> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
> b/drivers/char/tpm/tpm_ibmvtpm.c
> index 994385bf37c0..813eb2cac0ce 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -687,6 +687,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev
> *vio_dev,
>                                 ibmvtpm->rtce_buf != NULL,
>                                 HZ)) {
>                 dev_err(dev, "CRQ response timed out\n");
> +               rc = -ETIMEDOUT;
>                 goto init_irq_cleanup;
>         }
>  



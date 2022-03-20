Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4DA4E1DEE
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Mar 2022 22:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbiCTVWN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Mar 2022 17:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiCTVWM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Mar 2022 17:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6415A2F;
        Sun, 20 Mar 2022 14:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93D316124B;
        Sun, 20 Mar 2022 21:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5749DC340E9;
        Sun, 20 Mar 2022 21:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647811248;
        bh=2polGcx4AD8GfFvR+v/6Gp6MCQ0HH8HWhgoMv5fTTZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+QDZFOYV82/icqr1QmEbjgMGMZnPNZJbIZhlDQkOVT7xLmsQ3QvJIqEKp9qZjqqV
         7Z3mghJm4q3LLPHDEipOQW4i5n/CQbfUc8yXR/wA7Yhzmnx04iz6kZw//aQb21WEXa
         TFrsf9+Iab15PeAz7+eqD5gHb7wWLQ5pBwwNCd9butf+UtA0H9iXxLBvBUMQP3fYb/
         DmM9LqmmauefDO0Gn5HICWsGmjYB31xaOo346jzM5v6546aua262OfGWiMW/AqAl0M
         Tri5m98nhG/ajKpOJglzTmQUWGdShW3HmKow8eAyS9KML2XwuUzQdT0Tc5bvR1B0nc
         Kde7ydEp4Wiww==
Date:   Sun, 20 Mar 2022 23:21:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, nayna@linux.ibm.com,
        stefanb@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tpm: ibmvtpm: Correct the return value in
 tpm_ibmvtpm_probe()
Message-ID: <Yjea7INzTZ2T9RWz@kernel.org>
References: <20220318060201.50488-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318060201.50488-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 18, 2022 at 02:02:01PM +0800, Xiu Jianfeng wrote:
> Currently it returns zero when CRQ response timed out, it should return
> an error code instead.
> 
> Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 3af4c07a9342..d3989b257f42 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -681,6 +681,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
>  				ibmvtpm->rtce_buf != NULL,
>  				HZ)) {
> +		rc = -ENODEV;
>  		dev_err(dev, "CRQ response timed out\n");
>  		goto init_irq_cleanup;
>  	}
> -- 
> 2.17.1
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

This will require reviewed by from someone who knows this driver
better.

BR, Jarkko

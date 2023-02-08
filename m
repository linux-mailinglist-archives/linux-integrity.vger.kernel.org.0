Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2386668E556
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 02:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBHBS4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 20:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBHBSw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 20:18:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB56642BC8
        for <linux-integrity@vger.kernel.org>; Tue,  7 Feb 2023 17:18:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 876DC6145B
        for <linux-integrity@vger.kernel.org>; Wed,  8 Feb 2023 01:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B437C433EF;
        Wed,  8 Feb 2023 01:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675819124;
        bh=OOUl0rRu7QOot8KbJKdw3AMyDs/1Xei2X4+RK0XXbQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STsY2BuQZbs06oikM7O+JmLxLBFR4NCewv1QX9pTpoBRrssPE9jV9EvyVwVZpcPm3
         ANd+8ez4m/a6DD+IpUeoTgF+SosoCpxb+X8QqaDfArSuNNbjVSbAlVNpHVHmM2dyp9
         WTNvFmqkQ356nUFgbS7oZH+h0xWoHBOjhN42AA99+NtwVQ9v3a06naQsbLUZRDAE5q
         atD4eEyL59fFvgx7Csq+KCWeEOWMXYh8xohUwmSOmg/W3EzNC6qbimt0mmvFh0HNsX
         1+NI8QV0kOreJiYuryfYFbkudZBA5NX1sPTFjFVCUG2NB9agRZ3GFhjKUE3giW0I2p
         prG2EiaF4ZeYg==
Date:   Wed, 8 Feb 2023 03:18:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        eajames@linux.ibm.com
Subject: Re: [PATCH -next] tpm: of: fix return value check in
 tpm_read_log_memory_region()
Message-ID: <Y+L4b2rLYUe8091O@kernel.org>
References: <20230129072637.279576-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129072637.279576-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 29, 2023 at 03:26:37PM +0800, Yang Yingliang wrote:
> devm_memremap() never returns NULL pointer, it will return
> ERR_PTR() when it fails, so replace the check with IS_ERR().
> 
> Fixes: b0474a20b153 ("tpm: Add reserved memory event log")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/char/tpm/eventlog/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index c815cadf00a4..6a818a026c94 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -43,7 +43,7 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
>  
>  	chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
>  						 MEMREMAP_WB);
> -	if (!chip->log.bios_event_log) {
> +	if (IS_ERR(chip->log.bios_event_log)) {
>  		dev_info(&chip->dev, "err memremap\n");
>  		return -ENOMEM;
>  	}
> -- 
> 2.25.1
> 

Thanks. I will squash this with the patch and add your sob.

BR, Jarkko

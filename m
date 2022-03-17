Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE04DC02A
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Mar 2022 08:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiCQHdR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Mar 2022 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCQHdQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Mar 2022 03:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00071C16F0;
        Thu, 17 Mar 2022 00:32:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6486A60B91;
        Thu, 17 Mar 2022 07:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B6C340EC;
        Thu, 17 Mar 2022 07:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647502319;
        bh=KtTP/N7askke7st8XcU0jM7vVHx3t+bRGSD56B7pp8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n04DmdsEBh1KYufQk+GgyjL27uzPL9C9Nn5PHqYjez/6ROjDtQ75WY4U+L7DFRVAq
         sFUwuHG0gt70auwmEvkXPQ4MwDhYxrdR7mJ4tCJkWlX6ImEhcHDkr+eXmbDvpA4xQz
         KT701uvkBR2tgKgpApS5HUNlLTqDt6a8sChCKDZJl/GIa9SWezvEp6gR20hl47M+vA
         6xxOzkcDLuK7Iq1P85MPBPG+6nYSOU9IqiXc2IZZVgpMe7BmaaYqNylIcFxHPCT6sp
         C3p4TwR+SQTk5rX6mR2BkLaxqH81hzuszrBVQFThFe8OWa6J8oMS4qeXkmMXKUZjwq
         SMyATWiHHjqug==
Date:   Thu, 17 Mar 2022 09:31:10 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     GUO Zihua <guozihua@huawei.com>, linux-integrity@vger.kernel.org,
        wangweiyang2@huawei.com, xiujianfeng@huawei.com,
        weiyongjun1@huawei.com, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix memory leak in tpmm_chip_alloc
Message-ID: <YjLjvqWdhy6REIrn@iki.fi>
References: <20220307104827.40843-1-guozihua@huawei.com>
 <20220314163705.GA64706@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314163705.GA64706@ziepe.ca>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 14, 2022 at 01:37:05PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 07, 2022 at 06:48:27PM +0800, GUO Zihua wrote:
> > Fix a memory leak in tpmm_chip_alloc. devm_add_action_or_reset would
> > call put_device on error, while tpm->devs is left untouched. Call
> > put_device on tpm->devs as well if devm_add_action_or_reset returns an
> > error.
> > 
> > Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm")
> > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> >  drivers/char/tpm/tpm-chip.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index b009e7479b70..0a92334e8c40 100644
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -308,6 +308,12 @@ static int tpm_class_shutdown(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static void tpm_chip_free(struct tpm_chip *chip)
> > +{
> > +	put_device(&chip->devs);
> > +	put_device(&chip->dev);
> > +}
> > +
> >  /**
> >   * tpm_chip_alloc() - allocate a new struct tpm_chip instance
> >   * @pdev: device to which the chip is associated
> > @@ -396,8 +402,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> >  	return chip;
> >  
> >  out:
> > -	put_device(&chip->devs);
> > -	put_device(&chip->dev);
> > +	tpm_chip_free(chip);
> >  	return ERR_PTR(rc);
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_chip_alloc);
> > @@ -420,8 +425,8 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
> >  		return chip;
> >  
> >  	rc = devm_add_action_or_reset(pdev,
> > -				      (void (*)(void *)) put_device,
> > -				      &chip->dev);
> > +				      (void (*)(void *)) tpm_chip_free,
> > +				      chip);
> >  	if (rc)
> 
> This looks like the same issue as was adressed by the recent discussion..

Both fixes (Lino, jejb) are also part of my PR:

[*] https://lore.kernel.org/linux-integrity/Yi64TJXqto+VdoOo@iki.fi/

> Jason

BR, Jarkko

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E464DC038
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Mar 2022 08:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiCQHfU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Mar 2022 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiCQHfT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Mar 2022 03:35:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963D99EF5;
        Thu, 17 Mar 2022 00:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7E9FB81DBB;
        Thu, 17 Mar 2022 07:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D938FC340EC;
        Thu, 17 Mar 2022 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647502441;
        bh=Wc1sRQU3uR0mSmWJBBzRcK0/llPMJJOfk/1hcqIXzP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEN4IKfBRDjB60E9+Brs4yqItI8jiftoePia8kIWx7rX0cye4EcmpXs0vCtNXpSyK
         a/0XxVFR24GHu4P1xkwAFnctI6CYibMjw/49t/3TpRKxdBzveddzwhPDnMSGvU/8xM
         UkqvQJ/QSwYKzU0o0pPENQsypkF1pNprm8UH58RzxUNo/7Ctm/k/ZbyTfwfo3fRbnp
         9XJS1e21KcxUwnDWfuj4JTak8QBgM62W3d5eBrPNftYDSGtRqrMSkS0CE89oMt6hPE
         GbMH6CCW+plBK4smtX6B1DVybJr+RqrQy9oQI62tDdV2YKqFR3U1d0sG562pV5IdAR
         hAoecqZNh0POw==
Date:   Thu, 17 Mar 2022 09:33:11 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        wangweiyang2@huawei.com, xiujianfeng@huawei.com,
        weiyongjun1@huawei.com, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix memory leak in tpmm_chip_alloc
Message-ID: <YjLkN/EDH4m9AdhN@iki.fi>
References: <20220307104827.40843-1-guozihua@huawei.com>
 <20220314163705.GA64706@ziepe.ca>
 <bd3219cc-9258-096e-3e28-e81eb0e695b8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd3219cc-9258-096e-3e28-e81eb0e695b8@huawei.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 15, 2022 at 09:55:07AM +0800, Guozihua (Scott) wrote:
> 
> 
> On 2022/3/15 0:37, Jason Gunthorpe wrote:
> > On Mon, Mar 07, 2022 at 06:48:27PM +0800, GUO Zihua wrote:
> > > Fix a memory leak in tpmm_chip_alloc. devm_add_action_or_reset would
> > > call put_device on error, while tpm->devs is left untouched. Call
> > > put_device on tpm->devs as well if devm_add_action_or_reset returns an
> > > error.
> > > 
> > > Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm")
> > > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > >   drivers/char/tpm/tpm-chip.c | 13 +++++++++----
> > >   1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > index b009e7479b70..0a92334e8c40 100644
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -308,6 +308,12 @@ static int tpm_class_shutdown(struct device *dev)
> > >   	return 0;
> > >   }
> > > +static void tpm_chip_free(struct tpm_chip *chip)
> > > +{
> > > +	put_device(&chip->devs);
> > > +	put_device(&chip->dev);
> > > +}
> > > +
> > >   /**
> > >    * tpm_chip_alloc() - allocate a new struct tpm_chip instance
> > >    * @pdev: device to which the chip is associated
> > > @@ -396,8 +402,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> > >   	return chip;
> > >   out:
> > > -	put_device(&chip->devs);
> > > -	put_device(&chip->dev);
> > > +	tpm_chip_free(chip);
> > >   	return ERR_PTR(rc);
> > >   }
> > >   EXPORT_SYMBOL_GPL(tpm_chip_alloc);
> > > @@ -420,8 +425,8 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
> > >   		return chip;
> > >   	rc = devm_add_action_or_reset(pdev,
> > > -				      (void (*)(void *)) put_device,
> > > -				      &chip->dev);
> > > +				      (void (*)(void *)) tpm_chip_free,
> > > +				      chip);
> > >   	if (rc)
> > 
> > This looks like the same issue as was adressed by the recent discussion..
> > 
> > Jason
> > .
> 
> Hi Jason,
> 
> Would you mind refer me to the discussion?

Please test: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

And use tag tpmdd-next-v5.18-v2

If issues persists, let us know or send a fix.

BR, Jarkko

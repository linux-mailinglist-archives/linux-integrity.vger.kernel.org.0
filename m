Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A568E564
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 02:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBHBbb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 20:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBHBba (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 20:31:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82FC41B43
        for <linux-integrity@vger.kernel.org>; Tue,  7 Feb 2023 17:31:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6124A61472
        for <linux-integrity@vger.kernel.org>; Wed,  8 Feb 2023 01:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21769C433D2;
        Wed,  8 Feb 2023 01:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675819887;
        bh=Mo53OLjt4Sca2xHjjyCX7r/avIeE4iFbXAORcjV8Erk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+oHIrXMN1uWBqyBj0ww6n5H9A0vSNjoBcl/wlRQrcIyIj1sIlQAPs1TDxHWEDIY4
         i9pkWdlKnH74+McypXw21W0YzkDBYXPIG9an+A4JnOaVZjheEYzxusb9YUzoEcBleZ
         WIko6FzTunIQRktAebZ5yvQoxdpW3WB4iVC0CGkROmQ1hSwjp/w/LSPOpNEuhbDlRd
         W9uopsSfBueEIKGaWsI84p+Y5SxhSirJ4qUHDBF4QzxHGEtssRZZhW4JF/oHdDPUxi
         XF//nYKII1zlX7ku+okDryix0LfuLQ3FTcJOf+/mX/jcuOVEmvukPnY5ByVJIq7ZGb
         S10ylKSwOTVGQ==
Date:   Wed, 8 Feb 2023 03:31:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        eajames@linux.ibm.com
Subject: Re: [PATCH -next] tpm: of: fix return value check in
 tpm_read_log_memory_region()
Message-ID: <Y+L7aljS8aV3VgQM@kernel.org>
References: <20230129072637.279576-1-yangyingliang@huawei.com>
 <Y+L4b2rLYUe8091O@kernel.org>
 <Y+L6VE9k7lYwbfU8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+L6VE9k7lYwbfU8@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 08, 2023 at 03:26:51AM +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 08, 2023 at 03:18:45AM +0200, Jarkko Sakkinen wrote:
> > On Sun, Jan 29, 2023 at 03:26:37PM +0800, Yang Yingliang wrote:
> > > devm_memremap() never returns NULL pointer, it will return
> > > ERR_PTR() when it fails, so replace the check with IS_ERR().
> > > 
> > > Fixes: b0474a20b153 ("tpm: Add reserved memory event log")
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >  drivers/char/tpm/eventlog/of.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> > > index c815cadf00a4..6a818a026c94 100644
> > > --- a/drivers/char/tpm/eventlog/of.c
> > > +++ b/drivers/char/tpm/eventlog/of.c
> > > @@ -43,7 +43,7 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
> > >  
> > >  	chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
> > >  						 MEMREMAP_WB);
> > > -	if (!chip->log.bios_event_log) {
> > > +	if (IS_ERR(chip->log.bios_event_log)) {
> > >  		dev_info(&chip->dev, "err memremap\n");
> > >  		return -ENOMEM;
> > >  	}
> > > -- 
> > > 2.25.1
> > > 
> > 
> > Thanks. I will squash this with the patch and add your sob.
> 
> Ugh, in the review three dev_info()'s went out of my radar.
> 
> They make no sense so I'll drop them.

    tpm: Add reserved memory event log
    
    Some platforms may desire to pass the event log up to Linux in the
    form of a reserved memory region. In particular, this is desirable
    for embedded systems or baseboard management controllers (BMCs)
    booting with U-Boot. IBM OpenBMC BMCs will be the first user.
    Add support for the reserved memory in the TPM core to find the
    region and map it.
    
    Signed-off-by: Eddie James <eajames@linux.ibm.com>
    [jarkko: removed spurious dev_info()'s from tpm_read_log_memory_region()]
    Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
    [yang: return -ENOMEM when devm_memremap() fails]
    Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

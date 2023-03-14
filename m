Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539C96B952F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 14:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjCNND2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjCNNDK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 09:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63458A8C48;
        Tue, 14 Mar 2023 05:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 776176175E;
        Tue, 14 Mar 2023 12:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE349C433EF;
        Tue, 14 Mar 2023 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678798679;
        bh=XnyblwAgX0B41szpHXPCReOlxq2b0/RpzHRsaRHH/no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Plu4H5rW/pLyuo2hyyAQiDkZa1vHyZ5TD5lAQM9UlKM9LNiw9rplPathRJBKGh9BG
         VDNnrqAnrOX1++PkEdl/cVw/0b3e+v9L5qkHXDCLv9sipPzz8pTdU7zDojkz3KmdMj
         KNWh/L94l+tr5pn9emZW3oNLJ0rvPjn5EVH5BIm2HgA2ep1owLDqdRBl9s60VlGC8h
         Si7v2SqgrcSz20Ez3N21EFw1+xqGXE3SxzWIqbxZMC3p1hONFvT2KurGnqvOJH1TA0
         N1HpZOdhb7yvf6borwgmdXgJmqdUy2QY8+1CMbb7gqFGfchK5ucaurmQuPM7F0Om9e
         fffJRJ01rLLLQ==
Date:   Tue, 14 Mar 2023 14:57:47 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 10/12] tpm: fix up the tpm_class shutdown_pre pointer
 when created
Message-ID: <ZBBvSxnoMphDMpfj@kernel.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
 <20230313181843.1207845-10-gregkh@linuxfoundation.org>
 <ZBBV0N+eHSf2TYli@kernel.org>
 <ZBBuZ9dLtM2iQyg3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBuZ9dLtM2iQyg3@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 01:53:59PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 14, 2023 at 01:09:04PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 13, 2023 at 07:18:41PM +0100, Greg Kroah-Hartman wrote:
> > > Do not wait until long after the struct class has been created to set
> > > the shutdown_pre pointer for the tpm_class, assign it right away.
> > > 
> > > This is the only in-kernel offender that tries to modify the
> > > device->class pointer contents after it has been assigned to a device,
> > > so fix that up by doing the function pointer assignment before it is
> > > matched with the device.  Because of this, the patch should go through
> > > the driver core tree to allow later changes to struct device to be
> > > possible.
> > > 
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: linux-integrity@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/char/tpm/tpm-chip.c      | 3 +--
> > >  drivers/char/tpm/tpm-interface.c | 1 +
> > >  drivers/char/tpm/tpm.h           | 1 +
> > >  3 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > index b99f55f2d4fd..7c444209a256 100644
> > > --- a/drivers/char/tpm/tpm-chip.c
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -282,7 +282,7 @@ static void tpm_dev_release(struct device *dev)
> > >   *
> > >   * Return: always 0 (i.e. success)
> > >   */
> > > -static int tpm_class_shutdown(struct device *dev)
> > > +int tpm_class_shutdown(struct device *dev)
> > >  {
> > >  	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
> > >  
> > > @@ -337,7 +337,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> > >  	device_initialize(&chip->dev);
> > >  
> > >  	chip->dev.class = tpm_class;
> > > -	chip->dev.class->shutdown_pre = tpm_class_shutdown;
> > >  	chip->dev.release = tpm_dev_release;
> > >  	chip->dev.parent = pdev;
> > >  	chip->dev.groups = chip->groups;
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index 8763c820d1f8..43e23a04433a 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -467,6 +467,7 @@ static int __init tpm_init(void)
> > >  	int rc;
> > >  
> > >  	tpm_class = class_create("tpm");
> > > +	tpm_class->shutdown_pre = tpm_class_shutdown;
> > >  	if (IS_ERR(tpm_class)) {
> > >  		pr_err("couldn't create tpm class\n");
> > >  		return PTR_ERR(tpm_class);
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index 24ee4e1cc452..a45eb39db0c4 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -183,6 +183,7 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip);
> > >  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> > >  int tpm_pm_suspend(struct device *dev);
> > >  int tpm_pm_resume(struct device *dev);
> > > +int tpm_class_shutdown(struct device *dev);
> > >  
> > >  static inline void tpm_msleep(unsigned int delay_msec)
> > >  {
> > > -- 
> > > 2.39.2
> > > 
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Are you going to pick this?
> 
> Yes, as the changelog text said, I'd like to take it through my tree,
> thanks!

OK, right. Just wanted to prevent any races, thanks.

BR, Jarkko

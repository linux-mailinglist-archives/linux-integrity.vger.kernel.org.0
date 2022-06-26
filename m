Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C770F55AF82
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jun 2022 08:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiFZGoI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jun 2022 02:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFZGoH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jun 2022 02:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C15BF5E;
        Sat, 25 Jun 2022 23:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F8176112C;
        Sun, 26 Jun 2022 06:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7952EC34114;
        Sun, 26 Jun 2022 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656225845;
        bh=9ZJU86lQ5UWr7OdwF+1fcUD9JncNiwNET9qCr7/rCP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZiN3O1jc4XfSZ74OjHhMQldK57BUIPxLvJA71N/4gP3uPnfTG2la9niGt/78l5tM
         wmUaPSpvD/cAoKi9v2+kqBExMyu7HQmoDuy/EOGB5zIPBPmFg17vUT+I3P9L2eLOkl
         b9tmszguhYIzCZ+gjzdHOE12gtmAuSIYx9HQQ36IYCVCKcxbIaJCXiQdkThucbFQsG
         8koiiOUpX/hU9KE37GjwK1YOzjHmv6evWLGj5A9LnIhey1EEN9STm/6sBeOt1XuPVo
         4EpQ0ssCq93iBH4EXZLiFm32fzrJqvOridFuZkniUcLm2pidAj+QxXE7QNAr/go8YK
         sz8i+YKoXMs6g==
Date:   Sun, 26 Jun 2022 09:44:02 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v6 5/9] tpm, tpm_tis: Only handle supported interrupts
Message-ID: <YrgAMk1ORcTUtZ1b@kernel.org>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
 <20220621132447.16281-6-LinoSanfilippo@gmx.de>
 <Yrf/azvJlzWfOE9y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrf/azvJlzWfOE9y@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jun 26, 2022 at 09:40:43AM +0300, Jarkko Sakkinen wrote:
> On Tue, Jun 21, 2022 at 03:24:43PM +0200, Lino Sanfilippo wrote:
> > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > 
> > According to the TPM Interface Specification (TIS) support for "stsValid"
> > and "commandReady" interrupts is only optional.
> > This has to be taken into account when handling the interrupts in functions
> > like wait_for_tpm_stat(). To determine the supported interrupts use the
> > capability query.
> > 
> > Also adjust wait_for_tpm_stat() to only wait for interrupt reported status
> > changes. After that process all the remaining status changes by polling
> > the status register.
> > 
> > Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 119 +++++++++++++++++++-------------
> >  drivers/char/tpm/tpm_tis_core.h |   1 +
> >  2 files changed, 72 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index 09d8f04cbc81..cb469591373a 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -53,41 +53,63 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> >  	long rc;
> >  	u8 status;
> >  	bool canceled = false;
> > +	u8 sts_mask = 0;
> > +	int ret = 0;
> >  
> >  	/* check current status */
> >  	status = chip->ops->status(chip);
> >  	if ((status & mask) == mask)
> >  		return 0;
> >  
> > -	stop = jiffies + timeout;
> > +	/* check what status changes can be handled by irqs */
> > +	if (priv->int_mask & TPM_INTF_STS_VALID_INT)
> > +		sts_mask |= TPM_STS_VALID;
> >  
> > -	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> > +	if (priv->int_mask & TPM_INTF_DATA_AVAIL_INT)
> > +		sts_mask |= TPM_STS_DATA_AVAIL;
> > +
> > +	if (priv->int_mask & TPM_INTF_CMD_READY_INT)
> > +		sts_mask |= TPM_STS_COMMAND_READY;
> > +
> > +	sts_mask &= mask;
> 
> I would instead mask out bits and write a helper function
> taking care of this:
> 
> static u8 tpm_tis_filter_sts_mask(u8 int_mask, u8 sts_mask)
> {
>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

Ignore this line (wrote this out of top of my head).

>         if (!(int_mask & TPM_INTF_STS_VALID_INT))
>                 sts_mask &= ~TPM_STS_VALID;
> 
>         if (!(int_mask & TPM_INTF_DATA_AVAIL_INT))
>                 sts_mask &= ~TPM_STS_DATA_AVAIL;
> 
>         if (!(int_mask & TPM_INTF_CMD_READY_INT))
> 		sts_mask &= ~TPM_STS_COMMAND_READY;
> 
>         return sts_mask;
> }
> 
> Less operations and imho somewhat cleaner structure.
> 
> Add suggested-by if you want.
> 
> BR, Jarkko


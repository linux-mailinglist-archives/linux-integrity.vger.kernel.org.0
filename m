Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04270D63E
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 09:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjEWH4y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjEWH4f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 03:56:35 -0400
X-Greylist: delayed 642 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 00:55:33 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB3129;
        Tue, 23 May 2023 00:55:33 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D6AC4280014D1;
        Tue, 23 May 2023 09:44:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C0B52DDCD0; Tue, 23 May 2023 09:44:43 +0200 (CEST)
Date:   Tue, 23 May 2023 09:44:43 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <20230523074443.GA21236@wunner.de>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 23, 2023 at 09:48:23AM +0300, Péter Ujfalusi wrote:
> On 22/05/2023 17:31, Lino Sanfilippo wrote:
[...]
> This looked promising, however it looks like the UPX-i11 needs the DMI
> quirk.

Why is that?  Is there a fundamental problem with the patch or is it
a specific issue with that device?


> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -752,6 +752,55 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
> >  	return status == TPM_STS_COMMAND_READY;
> >  }
> >  
> > +static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
> > +{
> > +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > +	int intmask = 0;
> > +
> > +	dev_err(&chip->dev, HW_ERR
> > +		"TPM interrupt storm detected, polling instead\n");
> 
> Should this be dev_warn or even dev_info level?

The corresponding message emitted in tpm_tis_core_init() for
an interrupt that's *never* asserted uses dev_err(), so using
dev_err() here as well serves consistency:

	dev_err(&chip->dev, FW_BUG
		"TPM interrupt not working, polling instead\n");

That way the same severity is used both for the never asserted and
the never deasserted interrupt case.


> > +	if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
> > +		tpm_tis_handle_irq_storm(chip);
> 
> Will the kernel step in and disbale the IRQ before we would have
> detected the storm?

No.  The detection of spurious interrupts in note_interrupt()
hinges on handlers returning IRQ_NONE.  And this patch makes
tis_int_handler() always return IRQ_HANDLED, thus pretending
success to genirq code.


> >  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
> >  	tpm_tis_relinquish_locality(chip, 0);
> >  	if (rc < 0)
> > -		return IRQ_NONE;
> > +		goto unhandled;
> 
> This is more like an error than just unhandled IRQ. Yes, it was ignored,
> probably because it is common?

The interrupt may be shared and then it's not an error.

Thanks,

Lukas

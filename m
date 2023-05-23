Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C293E70E036
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 17:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjEWPR2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbjEWPRK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 11:17:10 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C1E52;
        Tue, 23 May 2023 08:16:46 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4471A100D585B;
        Tue, 23 May 2023 17:16:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 157B3261AB8; Tue, 23 May 2023 17:16:42 +0200 (CEST)
Date:   Tue, 23 May 2023 17:16:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <20230523151642.GA31298@wunner.de>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
 <20230523074443.GA21236@wunner.de>
 <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 23, 2023 at 12:14:28PM +0300, Péter Ujfalusi wrote:
> On 23/05/2023 10:44, Lukas Wunner wrote:
> > On Tue, May 23, 2023 at 09:48:23AM +0300, Péter Ujfalusi wrote:
> >> On 22/05/2023 17:31, Lino Sanfilippo wrote:
> > [...]
> >> This looked promising, however it looks like the UPX-i11 needs the DMI
> >> quirk.
> > 
> > Why is that?  Is there a fundamental problem with the patch or is it
> > a specific issue with that device?
> 
> The flood is not detected (if there is a flood at all), interrupt stops
> working after about 200 interrupts - in the latest boot at 118th.

You've got a variant of the "never asserted interrupt".

That condition is currently tested only once on probe in tpm_tis_core_init().
The solution would be to disable interrupts whenever they're not (or no
longer asserted).  

However, that's a distinct issue from the one addressed by the present
patch, which deals with a "never *de*asserted interrupt".


> >>> +	dev_err(&chip->dev, HW_ERR
> >>> +		"TPM interrupt storm detected, polling instead\n");
> >>
> >> Should this be dev_warn or even dev_info level?
> > 
> > The corresponding message emitted in tpm_tis_core_init() for
> > an interrupt that's *never* asserted uses dev_err(), so using
> > dev_err() here as well serves consistency:
> > 
> > 	dev_err(&chip->dev, FW_BUG
> > 		"TPM interrupt not working, polling instead\n");
> > 
> > That way the same severity is used both for the never asserted and
> > the never deasserted interrupt case.
> 
> Oh, OK.
> Is there anything the user can do to have a ERROR less boot?

You're right that the user can't do anything about it and that
toning the message down to KERN_WARN or even KERN_NOTICE severity
may be appropriate.

However the above-quoted message for the never asserted interrupt
in tpm_tis_core_init() should then likewise be toned down to the
same severity.

I'm wondering why that message uses FW_BUG.  That doesn't make any
sense to me.  It's typically not a firmware bug, but a hardware issue,
e.g. an interrupt pin may erroneously not be connected or may be
connected to ground.  Lino used HW_ERR, which seems more appropriate
to me.


> >>>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
> >>>  	tpm_tis_relinquish_locality(chip, 0);
> >>>  	if (rc < 0)
> >>> -		return IRQ_NONE;
> >>> +		goto unhandled;
> >>
> >> This is more like an error than just unhandled IRQ. Yes, it was ignored,
> >> probably because it is common?
> > 
> > The interrupt may be shared and then it's not an error.
> 
> but this is tpm_tis_write32() failing, no? If it is shared interrupt and
> we return IRQ_HANDLED unconditionally then I think the core will think
> that the interrupt was for this device and it was handled.

No.  The IRQ_HANDLED versus IRQ_NONE return values are merely used
for book-keeping of spurious interrupts.  If IRQ_HANDLED is returned,
the other handlers will still be invoked.  It is not discernible whether
a shared interrupt was asserted by a single device or by multiple devices,
so all handlers need to be called.

Thanks,

Lukas

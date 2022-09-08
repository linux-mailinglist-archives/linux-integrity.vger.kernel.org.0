Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5365B13FE
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Sep 2022 07:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIHFXH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Sep 2022 01:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiIHFXG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Sep 2022 01:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757AC1655;
        Wed,  7 Sep 2022 22:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E129261AA9;
        Thu,  8 Sep 2022 05:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12F0C433C1;
        Thu,  8 Sep 2022 05:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662614584;
        bh=SgYV8YgFSca0cWdtkHTBPwtsnwvrNOzmuu9r5QTID2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgD0LbNRs1V+eSL4xF1howywVgSAYf9nJgi4of/DN97o2cyssBwxeSr06qV9SPmDl
         d+szMgjWGJ9mzgeCbKCK3bWjxczd8S9FL/92jWuH8AbxwEJdv6D6sIJQDnCEV7Ivxt
         j+nKx6fKtuXHHR4pAumwUgSX6lVVD9AqHi3hX/0thLy/SKQtcVrFFGcgma15oRzwGd
         MDN+hCEPvtfCnLslXp1mQ5fbY4ynQ2jcEEHeTgDxaYmtIKhufrck258MoSlGh6csdM
         KRyxxiltZdBFXpMb/Axb14s7zNzqNAt4Qbw4VKykp1XSM1VU4tBCv11qy3buJ8TTmf
         dM+x4bnhOunbQ==
Date:   Thu, 8 Sep 2022 08:22:58 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>, Hao Wu <hao.wu@rubrik.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: Re: [PATCH v2 01/10] tpm: Add support for in-kernel resetting of PCRs
Message-ID: <Yxl8Mq9x0JzaZwOz@kernel.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
 <Ywg3JZrWmRjvr/7f@kernel.org>
 <CAE=gft6RuggyTSJXty5EskUcwLFEv4mrC1AL3HY-UgvXQRxvbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft6RuggyTSJXty5EskUcwLFEv4mrC1AL3HY-UgvXQRxvbA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 07, 2022 at 10:02:14AM -0700, Evan Green wrote:
> On Thu, Aug 25, 2022 at 8:00 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Aug 23, 2022 at 03:25:17PM -0700, Evan Green wrote:
> > > From: Matthew Garrett <matthewgarrett@google.com>
> > >
> > > Add an internal command for resetting a PCR. This will be used by the
> > > encrypted hibernation code to set PCR23 to a known value. The
> > > hibernation code will seal the hibernation key with a policy specifying
> > > PCR23 be set to this known value as a mechanism to ensure that the
> > > hibernation key is genuine. But to do this repeatedly, resetting the PCR
> > > is necessary as well.
> > >
> > > From: Matthew Garrett <mjg59@google.com>
> >
> > This is probably here by mistake.
> >
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > >
> >
> > No empty line here.
> >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > ---
> > > Matthew's original version of this patch was at:
> > > https://patchwork.kernel.org/patch/12096487/
> > >
> > > (no changes since v1)
> > >
> > >  drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++++++++++
> > >  drivers/char/tpm/tpm.h           |  2 ++
> > >  drivers/char/tpm/tpm1-cmd.c      | 34 ++++++++++++++++++++++++++++++
> > >  drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++++++++++++++++++
> > >  include/linux/tpm.h              |  7 +++++++
> > >  5 files changed, 107 insertions(+)
> > >
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index 1621ce8187052c..17b8643ee109c2 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -342,6 +342,34 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> > >  }
> > >  EXPORT_SYMBOL_GPL(tpm_pcr_extend);
> > >
> > > +/**
> > > + * tpm_pcr_reset - reset the specified PCR
> > > + * @chip:    a &struct tpm_chip instance, %NULL for the default chip
> > > + * @pcr_idx: the PCR to be reset
> > > + *
> > > + * Return: same as with tpm_transmit_cmd()
> > > + */
> > > +int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
> > > +{
> > > +     int rc;
> > > +
> > > +     chip = tpm_find_get_ops(chip);
> > > +     if (!chip)
> > > +             return -ENODEV;
> > > +
> > > +     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > > +             rc = tpm2_pcr_reset(chip, pcr_idx);
> > > +             goto out;
> > > +     }
> > > +
> > > +     rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");
> > > +
> > > +out:
> > > +     tpm_put_ops(chip);
> >
> >         if (chip->flags & TPM_CHIP_FLAG_TPM2)
> >                 rc = tpm2_pcr_reset(chip, pcr_idx);
> >         else
> >                 rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");
> >
> > Where does this asymmetry come with the parameters?
> 
> Sorry for the delay, I was out last week. I think it's modeled to
> match the tpm1/2_pcr_extend functions, which have this same odd
> asymmetry. Should I change it to have both use the tpm2_pcr_reset()
> prototype?
> -Evan

Yeah, I think it'd be a good idea.

BR, Jarkko

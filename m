Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0538F50A530
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Apr 2022 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiDUQ1U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Apr 2022 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiDUQRw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Apr 2022 12:17:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F07667;
        Thu, 21 Apr 2022 09:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27A40B826D1;
        Thu, 21 Apr 2022 16:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BA5C385A1;
        Thu, 21 Apr 2022 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650557698;
        bh=ObbyMeoCn2LGfnvNQoDbe2Hrh+qjeznyCeUp6gdYWKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5D0IJ+60MGceny05FXAdUMn26Dp3bNMshnUHl0SBhZMF1Q2K0NpL4maAYVqeLaUH
         SJrMZkSONSb9M/aSoHCwb/UUkGyEOXL57126BDPLHZlgT9cN9G8tPmfw3TOL6D5dvw
         PSt7EC3rkV/SlSZ5+ipGFKwdOE8454aTIlxZyg3/122R03AbUG8ry1Za6K+YOg6vUF
         BVJ4CCV8NwLs4ORvgoUblBBg3eKPBHiTPmkgweT5R6OFl8iV0R/pr0ZDBTuuNAGSy3
         QXWWvlMHCTncYjf5ZDvw4ghIzmsgPdsVhEDQwQcrTFv6fkW4aGRYmNdnfJSme3fUve
         KnH0P54LJPLUQ==
Date:   Thu, 21 Apr 2022 19:13:43 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jes Klinke <jbk@google.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Jes B. Klinke" <jbk@chromium.org>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: cr50: Add new device/vendor ID 0x504a6666
Message-ID: <YmGCt7CiK6kqshYp@kernel.org>
References: <20220419163749.1.Ica39bd8d1494f750a70a668e5929f6e5e63241f2@changeid>
 <c8f5ada2-c5cc-fe1b-bdeb-8b7d134250ee@molgen.mpg.de>
 <CANMTAZRp5GPwrJNO4RY1KpvABgiuOMYEtwm+jdYfX5JRH8FpSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANMTAZRp5GPwrJNO4RY1KpvABgiuOMYEtwm+jdYfX5JRH8FpSA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 21, 2022 at 09:07:21AM -0700, Jes Klinke wrote:
> Dear Paul,
> 
> On Wed, Apr 20, 2022 at 3:52 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >
> > Dear Jes,
> >
> >
> > Am 20.04.22 um 01:37 schrieb Jes B. Klinke:
> > > Accept one additional numerical value of DID:VID for next generation
> > > Google TPM with new firmware, to be used in future Chromebooks.
> > >
> > > The TPM with the new firmware has the code name TI50, and is going to
> > > use the same interfaces.
> > >
> > > Signed-off-by: Jes B. Klinke <jbk@chromium.org>
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >
> > >   drivers/char/tpm/tpm_tis_i2c_cr50.c | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > index f6c0affbb4567..4ddb8ff3a8569 100644
> > > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > @@ -31,6 +31,7 @@
> > >   #define TPM_CR50_TIMEOUT_SHORT_MS   2               /* Short timeout during transactions */
> > >   #define TPM_CR50_TIMEOUT_NOIRQ_MS   20              /* Timeout for TPM ready without IRQ */
> > >   #define TPM_CR50_I2C_DID_VID                0x00281ae0L     /* Device and vendor ID reg value */
> > > +#define TPM_TI50_I2C_DID_VID         0x504a6666L     /* Device and vendor ID reg value */
> > >   #define TPM_CR50_I2C_MAX_RETRIES    3               /* Max retries due to I2C errors */
> > >   #define TPM_CR50_I2C_RETRY_DELAY_LO 55              /* Min usecs between retries on I2C */
> > >   #define TPM_CR50_I2C_RETRY_DELAY_HI 65              /* Max usecs between retries on I2C */
> > > @@ -742,15 +743,15 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
> > >       }
> > >
> > >       vendor = le32_to_cpup((__le32 *)buf);
> > > -     if (vendor != TPM_CR50_I2C_DID_VID) {
> > > +     if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
> > >               dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> > >               tpm_cr50_release_locality(chip, true);
> > >               return -ENODEV;
> > >       }
> > >
> > > -     dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > > +     dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > > +              vendor == TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
> > >                client->addr, client->irq, vendor >> 16);
> > > -
> >
> > Remove this blank line wasn’t needed, I gues.
> 
> You are right, I should probably have left the blank line untouched.
> It does not hurt the readability of the code much to remove it,
> though.

I don't mind removing it.

> 
> > >       return tpm_chip_register(chip);
> > >   }
> > >
> >
> > Thank for addressing the other comments, and congratulations on getting
> > your first commit into the Linux kernel.
> 
> When I think about it, I did propose a kernel patch in 2002, to
> introduce /proc/sys/kernel/core_pattern, so this is my second patch.
> All the mailing lists, and formal review process this time seemed
> daunting at first, though, so thank you for guiding me through the
> process.

It gets easier over time when your patch count increases.

Compared to many Github projects, I find actually contributing to kernel
easier than many of those, because form is so rigid, but this of course
happens over time. I.e. over time you can estimate a lot how likely is
patch get to be accepted.

Also it is good to remember that kernel maintainers might sound a bit
impolite, not because they want to be, but when you review dozens of
patches in a day, you have to be somewhat mechanic how you response,
and simply do not have time to be "verbosely polite".

> Regards
> Jes

BR, Jarkko

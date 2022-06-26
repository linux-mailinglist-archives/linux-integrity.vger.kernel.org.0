Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990DE55AF47
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jun 2022 07:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiFZFTp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jun 2022 01:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiFZFTo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jun 2022 01:19:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58C8120A2;
        Sat, 25 Jun 2022 22:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27B4FCE0B69;
        Sun, 26 Jun 2022 05:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D268EC3411D;
        Sun, 26 Jun 2022 05:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656220780;
        bh=yr0i4ViqFKUS+bKRECGetMKIohDWSv3X9Hrw1N7C1Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kukJwx/UfRW8RTBuOQQhcBV5GyXa0omMB5JlV2PYoSg+dVyRz3Mw08HTL2Skb61SH
         rROLX6cVDIWlZrVNt2wr/FTCiWL7hwt0wYvam5ikUmi0Ex3q10IUpbVmchiOZYlW1j
         kGj9mirjRIl2FwxPJANHUNckvwk9I0Icj1E77Ow+pybRnANVIlHAFFPGKgX/MZioua
         aHEg5yZtNFVzbiZoBcA+I4c45iOx5VV/LEjGBxjaV+SV2/uF5YxzgNKhkc/ykGliwi
         eiswUQ+Q6yYLdMkqBeIDCbtovACjaTEZO0ZRQL/qRkJKZjDoXQ+omZqljaEY2t93Tn
         W/FIVnDsLYD3A==
Date:   Sun, 26 Jun 2022 08:19:36 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     LinoSanfilippo@gmx.de, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 10/10] tpm, tpm_tis: Enable interrupt test
Message-ID: <YrfsP3/Da6+3dpbg@kernel.org>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-11-LinoSanfilippo@gmx.de>
 <YqokW/cNLrrsZ2ib@iki.fi>
 <75124ab23f2c845d8f683d7e3123de3ccdb07ad0.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75124ab23f2c845d8f683d7e3123de3ccdb07ad0.camel@mniewoehner.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 16, 2022 at 03:04:30PM +0200, Michael Niewöhner wrote:
> On Wed, 2022-06-15 at 21:26 +0300, Jarkko Sakkinen wrote:
> > On Fri, Jun 10, 2022 at 01:08:46PM +0200, LinoSanfilippo@gmx.de wrote:
> > > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > > 
> > > The test for interrupts in tpm_tis_send() is skipped if the flag
> > > TPM_CHIP_FLAG_IRQ is not set. Since the current code never sets the flag
> > > initially the test is never executed.
> > > 
> > > Fix this by setting the flag in tpm_tis_gen_interrupt() right after
> > > interrupts have been enabled.
> > > 
> > > Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > > ---
> > >  drivers/char/tpm/tpm_tis_core.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > > b/drivers/char/tpm/tpm_tis_core.c
> > > index e5edf745fb23..be229c173f10 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -774,11 +774,16 @@ static int tpm_tis_gen_interrupt(struct tpm_chip
> > > *chip)
> > >         if (ret < 0)
> > >                 return ret;
> > >  
> > > +       chip->flags |= TPM_CHIP_FLAG_IRQ;
> > > +
> > >         if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > >                 ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> > >         else
> > >                 ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
> > > desc, 0);
> > >  
> > > +       if (ret)
> > > +               chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> > > +
> > >         release_locality(chip, 0);
> > >  
> > >         return ret;
> > > -- 
> > > 2.36.1
> > > 
> > 
> > James, do you have a chance to test this on your side? Thanks.
> > 
> > BR, Jarkko
> 
> Tested-by: Michael Niewöhner <linux@mniewoehner.de>

Thank you.

BR, Jarkko

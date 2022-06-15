Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F296A54D3FC
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 23:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiFOVzO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiFOVzN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 17:55:13 -0400
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A237C3587F;
        Wed, 15 Jun 2022 14:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1655330094; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CKvoztOljuknIFBKSeem8IkvDo9RD2xKXZDj2C7I7vBPzCH4fqnAbLwblTBKUj/m+zGA8mWRCaqmsc1UG2MHPxNLGyYxMr2vDFwVOmKV54M3vwjxso6/P4nEScedPcWz1McEmrBJiJVQOd1HSzlmPa02XvkJpPQxdPafxYx9vk0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1655330094; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=aJJwsD70Ns0x7M5O0VL7TTcu4LfnesfafLmWP9UWs38=; 
        b=FnGboAsQPLdV7Y0SJsgoFQmD5/CK87GSKom+bbSJ98EoaSI7XyFjjngw0/zfDzUiGu3TnANHctwoJYf8/MXWN6UnW04hER3Qtf4HZF7DDk2NdaUI3c8TIqs7+faUdM/ud7QLNtd6YB1kRNEAG4Ng4Fq4Xf/nfpvAwTFTel7x5nw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 1655330093198200.5141202854353; Wed, 15 Jun 2022 14:54:53 -0700 (PDT)
Message-ID: <c610a318258198f72a53541c551c0c595a205329.camel@mniewoehner.de>
Subject: Re: [PATCH v5 10/10] tpm, tpm_tis: Enable interrupt test
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>, LinoSanfilippo@gmx.de,
        James.Bottomley@hansenpartnership.com,
        twawrzynczak <twawrzynczak@chromium.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
In-Reply-To: <YqokW/cNLrrsZ2ib@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
         <20220610110846.8307-11-LinoSanfilippo@gmx.de> <YqokW/cNLrrsZ2ib@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 15 Jun 2022 23:54:49 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.42.2 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-06-15 at 21:26 +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 10, 2022 at 01:08:46PM +0200, LinoSanfilippo@gmx.de wrote:
> > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > 
> > The test for interrupts in tpm_tis_send() is skipped if the flag
> > TPM_CHIP_FLAG_IRQ is not set. Since the current code never sets the flag
> > initially the test is never executed.
> > 
> > Fix this by setting the flag in tpm_tis_gen_interrupt() right after
> > interrupts have been enabled.
> > 
> > Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > b/drivers/char/tpm/tpm_tis_core.c
> > index e5edf745fb23..be229c173f10 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -774,11 +774,16 @@ static int tpm_tis_gen_interrupt(struct tpm_chip
> > *chip)
> >         if (ret < 0)
> >                 return ret;
> >  
> > +       chip->flags |= TPM_CHIP_FLAG_IRQ;
> > +
> >         if (chip->flags & TPM_CHIP_FLAG_TPM2)
> >                 ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> >         else
> >                 ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
> > desc, 0);
> >  
> > +       if (ret)
> > +               chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> > +
> >         release_locality(chip, 0);
> >  
> >         return ret;
> > -- 
> > 2.36.1
> > 
> 
> James, do you have a chance to test this on your side? Thanks.
> 
> BR, Jarkko

Hi guys,

for me this series causes boot problems - somehow feels like an interrupt
storm...
Not sure yet, which commit is causing that. I'll do more testing tomorrow.
@Tim could you test on any of your devices, please?

BR
Michael


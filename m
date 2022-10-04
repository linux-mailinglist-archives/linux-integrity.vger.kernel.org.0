Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355BF5F4C71
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Oct 2022 01:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJDXKk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 19:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJDXKj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 19:10:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7553D05;
        Tue,  4 Oct 2022 16:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71AB3CE1182;
        Tue,  4 Oct 2022 23:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CFBC433D6;
        Tue,  4 Oct 2022 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664925027;
        bh=hhVyPVNxICY3QnI17khN1y8MB4RxEmgFT/OeSB9sZuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNSjwr9xCFAvcrksEXYm5Jq4T9E+j7ZLZlKSosHjzoyPAhtZejJDD5MPuxSSDjaLL
         40Vswv7D/duHO43aiSygsNwVN6IE9M5LNEiocOqIrYiFg2Y1T7J7pJYX2Ox2VVWbWq
         /aePKw5NdfhrXTiDfztRXCxt8E44jntwcQuXhiqNGNUUYIfYDs2fD87/cTWChTt7/t
         uUWIo7GykT8FpRun+gltmonRu9GM/+amguVy5bPT9/x2+KleARfCIecMuj36zSUkmL
         VmjMHiamc1L3uX2RbjKQeJ1avCb1dz7NKDlBIvU5zHzPLuLvW3bD79lP7OwFcxTGpP
         X3Bd8IIwKadmg==
Date:   Wed, 5 Oct 2022 02:10:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, Peter Huewe <peterhuewe@gmx.de>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Subject: Re: [PATCH v2 3/3] tpm: tis-i2c: Add more compatible strings
Message-ID: <Yzy9X1QgtVQL+OAe@kernel.org>
References: <20220928043957.2636877-1-joel@jms.id.au>
 <20220928043957.2636877-4-joel@jms.id.au>
 <Yzdj+tRONyNFnPOw@kernel.org>
 <CAL_Jsq+nVQ6_RbjygeEfPYAC2p_KBdqtRdfsaukoWFG_FjRy5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+nVQ6_RbjygeEfPYAC2p_KBdqtRdfsaukoWFG_FjRy5g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 04, 2022 at 04:20:56PM -0500, Rob Herring wrote:
> On Fri, Sep 30, 2022 at 4:47 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Sep 28, 2022 at 02:09:57PM +0930, Joel Stanley wrote:
> > > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> > >
> > > https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
> > >
> > > Add a compatible string for it, and the generic compatible.
> > >
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > >  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> > > index 0692510dfcab..4af27b7ec5b1 100644
> > > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > > @@ -368,6 +368,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> > >  #ifdef CONFIG_OF
> > >  static const struct of_device_id of_tis_i2c_match[] = {
> > >       { .compatible = "infineon,slb9673", },
> > > +     { .compatible = "nuvoton,npct75x", },
> > > +     { .compatible = "tcg,tpm-tis-i2c", },
> > >       {}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> > > --
> > > 2.35.1
> > >
> >
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > IMHO could be picked to the same tree with DT changes instead
> > of my tree.
> 
> It's supposed to be the other way around. DT bindings go with drivers
> via subsystem tree. I don't take drivers.
> 
> But it seems this first needs some coordination with this[1] series.
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20220930165116.13329-1-Alexander.Steffen@infineon.com/

WFM, I can pick it (once the issues are fixed).

BR, Jarkko

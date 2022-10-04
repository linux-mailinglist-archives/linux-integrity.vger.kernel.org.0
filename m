Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE14C5F4AD4
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Oct 2022 23:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJDVVN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJDVVM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 17:21:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0DE6C757;
        Tue,  4 Oct 2022 14:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D5B5B81BD8;
        Tue,  4 Oct 2022 21:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38364C43140;
        Tue,  4 Oct 2022 21:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664918468;
        bh=4PADhtWgjN9IWH1wUFidwhE+LAxRwo4V8XjKOp/BcZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TwavmA3DDTWODMACEzyp2X6AP9peZAtmJ8+j7/PVi4LTEU/MARP3Qang4K5MK6djf
         mVP6clHjPfiuXLYTLb0vbWQf5UCJTp3Ykgc01CMV7YFuEo81+s2U65snek84l5naxC
         PeEAm4CK0ubZW6VgI0LjTAucUaC61Ycv3SSXRX89xJepM32MjPhP426zXXkxRLXuro
         ZVEba1t1z8EubRdlgfD8FM7kU/dZAoujSO9u/pUa6cGF4TCqopEQ1ikD0Pik4wXC9R
         iSAS+5nLnotZIzCkpRKudL6hk2zrAtR8y6UVIaOa7xZOsD94XVLO1ZQzaBF88YpLao
         gS6j4HcLLm0SQ==
Received: by mail-vs1-f45.google.com with SMTP id q9so3211335vsp.1;
        Tue, 04 Oct 2022 14:21:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf21IzGh63VzrXM+fHpKXBR8y59O60V1g5Fjqlbk6uegoVUKgY4A
        mJ7S+gwtQHlO7zImo4lS7OSV46xZY5pBd7nwrg==
X-Google-Smtp-Source: AMsMyM4V+2VIVX49gJJBSr8PdFLnAbZHuLFlxXOoAAa7vMN7aCgboMOOuRBKvYzpsgwUNadfrqK4I+MpJ44X1YdV3DY=
X-Received: by 2002:a67:c088:0:b0:39b:1bb3:bdd1 with SMTP id
 x8-20020a67c088000000b0039b1bb3bdd1mr11318073vsi.85.1664918467102; Tue, 04
 Oct 2022 14:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220928043957.2636877-1-joel@jms.id.au> <20220928043957.2636877-4-joel@jms.id.au>
 <Yzdj+tRONyNFnPOw@kernel.org>
In-Reply-To: <Yzdj+tRONyNFnPOw@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 4 Oct 2022 16:20:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nVQ6_RbjygeEfPYAC2p_KBdqtRdfsaukoWFG_FjRy5g@mail.gmail.com>
Message-ID: <CAL_Jsq+nVQ6_RbjygeEfPYAC2p_KBdqtRdfsaukoWFG_FjRy5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: tis-i2c: Add more compatible strings
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, Peter Huewe <peterhuewe@gmx.de>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 30, 2022 at 4:47 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Sep 28, 2022 at 02:09:57PM +0930, Joel Stanley wrote:
> > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> >
> > https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
> >
> > Add a compatible string for it, and the generic compatible.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> > index 0692510dfcab..4af27b7ec5b1 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > @@ -368,6 +368,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> >  #ifdef CONFIG_OF
> >  static const struct of_device_id of_tis_i2c_match[] = {
> >       { .compatible = "infineon,slb9673", },
> > +     { .compatible = "nuvoton,npct75x", },
> > +     { .compatible = "tcg,tpm-tis-i2c", },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> > --
> > 2.35.1
> >
>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> IMHO could be picked to the same tree with DT changes instead
> of my tree.

It's supposed to be the other way around. DT bindings go with drivers
via subsystem tree. I don't take drivers.

But it seems this first needs some coordination with this[1] series.

Rob

[1] https://lore.kernel.org/all/20220930165116.13329-1-Alexander.Steffen@infineon.com/

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B879614A80
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 13:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiKAMR4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 08:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiKAMRz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 08:17:55 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC57C15823;
        Tue,  1 Nov 2022 05:17:53 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13bd2aea61bso16635809fac.0;
        Tue, 01 Nov 2022 05:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYqgLepprELDiBt0SNNc/bgpZRWrpt9s8DEH9qpQ9LM=;
        b=7pzQNkZdzmVhAq8HKT33Tb8OZyBVCtawbO7V66fcZPcM90ItFEe9plAn6kQzV57/jY
         xsxfUJp2yjwFwQLrVpqIx3uKK6pRy2XK8HMRUX9ABlh/9gAB9bdIZX89tvFeqcUhjGem
         t4Uqr6xPzA/Vj9qqCfynkTo8tp2SKniHiPV0VEnnSsStXhbpq+Tir6zw3zARyE3VFdFV
         K8hvQyH+H91fAgeOHPXcQtgxREtYKInJQy0kt7e0fizbOBK6mW3C74bkrpJSyt7B4a8E
         8541FhDzTpZou45G2+zMxTDdCGJ/viIUH0jfN6SN2vzdwaM3ekI2Y7Dzry+bLJk0y6CH
         yLBQ==
X-Gm-Message-State: ACrzQf1yxfaCCbPAioMyVakNRgvhSgKoSjsq3WgCkDiBqJwAzB9SEz1W
        eJTFGD8m+jaQb9XqsTeK1w==
X-Google-Smtp-Source: AMsMyM4j25ly5cBT4h9rphbyUj9JTYAW8+60r5+kuPO9AONos6btilQKESI22qxdpOCfGSvsIxqDVQ==
X-Received: by 2002:a05:6870:e609:b0:137:de59:4526 with SMTP id q9-20020a056870e60900b00137de594526mr10587685oag.0.1667305072871;
        Tue, 01 Nov 2022 05:17:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bh23-20020a056808181700b003547a3401e6sm3313869oib.43.2022.11.01.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:17:52 -0700 (PDT)
Received: (nullmailer pid 935514 invoked by uid 1000);
        Tue, 01 Nov 2022 12:17:54 -0000
Date:   Tue, 1 Nov 2022 07:17:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     devicetree@vger.kernel.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, Johannes.Holland@infineon.com,
        benoit.houyere@st.com, amirmizi6@gmail.com, peter@pjd.dev
Subject: Re: [PATCH 1/7] dt-bindings: tpm: Introduce trivial-tpms.yaml
Message-ID: <20221101121754.GB912931-robh@kernel.org>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
 <20220930165116.13329-2-Alexander.Steffen@infineon.com>
 <CAL_Jsq+fCE3xTAUWYJo9keNJT_-oSgpNsFJUXcXCH57Uug3B=g@mail.gmail.com>
 <50da1beb-ee08-568f-a27c-9cad5f30996e@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50da1beb-ee08-568f-a27c-9cad5f30996e@infineon.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 04, 2022 at 07:41:36PM +0200, Alexander Steffen wrote:
> On 01.10.22 00:15, Rob Herring wrote:
> > On Fri, Sep 30, 2022 at 12:03 PM Alexander Steffen
> > <Alexander.Steffen@infineon.com> wrote:
> > > 
> > > Most TPM devices are very similar and only need a few common properties
> > > to describe them. However, they may use more properties than other
> > > trivial I2C or SPI devices, e.g. powered-while-suspended. Therefore,
> > > move them to their own trivial-tpms.yaml.
> > > 
> > > Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> > > ---
> > >   .../bindings/security/tpm/trivial-tpms.yaml   | 54 +++++++++++++++++++
> > >   .../devicetree/bindings/trivial-devices.yaml  | 16 ------
> > >   2 files changed, 54 insertions(+), 16 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
> > > new file mode 100644
> > > index 000000000000..fadd4ca96554
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
> > > @@ -0,0 +1,54 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/security/tpm/trivial-tpms.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Trivial TPM devices that have simple device tree bindings
> > > +
> > > +maintainers:
> > > +  - linux-integrity@vger.kernel.org
> > > +
> > > +description: |
> > > +  This is a list of trivial TPM devices that share the same properties and
> > > +  therefore have simple device tree bindings.
> > > +
> > > +  If a device needs more specific bindings, such as properties to
> > > +  describe some aspect of it, there needs to be a specific binding
> > > +  document for it just like any other devices.
> > > +
> > > +properties:
> > > +  reg:
> > > +    maxItems: 1
> > 
> > blank line
> > 
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency: true
> > 
> > The SPI based devices need to reference spi-peripheral-props.yaml. So
> > I think these are going to need to be split up by bus some.
> > 
> > > +
> > > +  compatible:
> > 
> > compatible goes first by convention.
> 
> I had copied all three from trivial-devices.yaml ;-)
> 
> The style fixes are easy. But do you really think I should split
> trivial-tpms.yaml into i2c-tpms.yaml, spi-tpms.yaml, etc.? After all,
> trivial-devices.yaml also contains a mix of I2C and SPI devices.

Well, you can leave them mixed. It just means that SPI bus properties 
would be allowed in I2C devices. That's okay, but if we can avoid it we 
should.

> Also, what about devices like "google,cr50", that support both I2C and SPI?
> Can they appear in two YAML files at the same time?

No, it can't. It can be a single schema for both, but perhaps a separate 
schema doc from the rest.

> 
> > > +    contains:
> > 
> > 'contains' can not be used here. That allows any other compatible
> > strings to be present. It's got to be exact lists of what are valid
> > combinations.
> 
> So what exactly are valid combinations then? If I look at what is in use, I
> find three possible combinations:
> 
> arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi: compatible =
> "tcg,tpm_tis-spi"
> arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts: compatible =
> "infineon,slb9670", "tcg,tpm_tis-spi";
> arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts: compatible =
> "infineon,slb9670";
> 
> It is either a generic identifier or a specific device or both. Is it
> correct to allow all three variants? If so, how to specify that as YAML,
> ideally without duplicating any of the identifiers?

At a minimum you need an 'items' entry for each length of compatible 
entries and generally an entry for each fallback. So you will have to 
have some duplication.

In cases like imx8mq-kontron-pitx-imx8m.dts, the dts should be fixed 
adding "tcg,tpm_tis-spi". If all the users were just "infineon,slb9670", 
then we'd leave it. So define the schema with what matches existing 
users, but fix users when inconsistent. 

Rob

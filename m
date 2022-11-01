Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C44F614A43
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 13:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKAMDW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 08:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAMDV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 08:03:21 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D8E08B;
        Tue,  1 Nov 2022 05:03:19 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso16492545fac.13;
        Tue, 01 Nov 2022 05:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhzQNOPvl6X943zdq8K2kPPZSqJ9b1ARfOQeezzkcS8=;
        b=7Ku5bJF7yr5gor775iQpvAvJZnMwykmVzefFhAAamTyKN5/mVDGnMK104WytTdGnO0
         Qp6+uIJME710DNzR3J73DRruCMRkc8uPvJOJmLkIchFlg8M8w2qPc8ARdtF7EllieWup
         qApO37pdv371+9IcxZRmPDHIzZqrSilhqJlYL7MQeTeli0597xMPSPn7/et+8YNedNIE
         Xa1FLu0MTs6zHAVfteN61m17L1A7fIC8yOgaI35cHP+ESRYvycgbcDL0HZAlni9EJEPO
         Cbk1AMzHcaX44zFO1bNwEMsTtxIWnqNxZpYNrRx55oIMc5Xa33MomuthpqOtUFfOtY9n
         m47Q==
X-Gm-Message-State: ACrzQf1RAwqgjYibUPEittk281ywG5rFnDTpse9K5YL0+Ohxg3PQqPDn
        HdQOcAYLGMMp5rWkk1Amfg==
X-Google-Smtp-Source: AMsMyM6vK+wLXDu1mS4IkUNtfZNGZwFJKmpPHwJJxg5nVBaAoweYROze34+Ub5uMJBr/iE6/yZAC+Q==
X-Received: by 2002:a05:6870:e40d:b0:13d:2f1c:b6e2 with SMTP id n13-20020a056870e40d00b0013d2f1cb6e2mr2615833oag.182.1667304198556;
        Tue, 01 Nov 2022 05:03:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 25-20020aca1019000000b0035956747d07sm3300520oiq.17.2022.11.01.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:03:18 -0700 (PDT)
Received: (nullmailer pid 917340 invoked by uid 1000);
        Tue, 01 Nov 2022 12:03:19 -0000
Date:   Tue, 1 Nov 2022 07:03:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     peter@pjd.dev, amirmizi6@gmail.com, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, Johannes.Holland@infineon.com,
        benoit.houyere@st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: tpm: Merge existing trivial TPMs to YAML
Message-ID: <20221101120319.GA912931-robh@kernel.org>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
 <20220930165116.13329-5-Alexander.Steffen@infineon.com>
 <166457526212.1112376.3928552824383328065.robh@kernel.org>
 <ceacd00d-54ef-2d78-1902-59818464526e@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceacd00d-54ef-2d78-1902-59818464526e@infineon.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 04, 2022 at 07:38:00PM +0200, Alexander Steffen wrote:
> On 01.10.22 00:05, Rob Herring wrote:
> > On Fri, 30 Sep 2022 18:51:13 +0200, Alexander Steffen wrote:
> > > Several of the existing text files describe trivial TPMs, that fit
> > > perfectly into the new trivial-tpms.yaml. Move them there.
> > > 
> > > Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> > > ---
> > >   .../bindings/security/tpm/google,cr50.txt     | 19 ----------
> > >   .../bindings/security/tpm/tpm-i2c.txt         | 26 --------------
> > >   .../bindings/security/tpm/tpm_tis_mmio.txt    | 25 -------------
> > >   .../bindings/security/tpm/tpm_tis_spi.txt     | 23 ------------
> > >   .../bindings/security/tpm/trivial-tpms.yaml   | 36 +++++++++++++++++++
> > >   5 files changed, 36 insertions(+), 93 deletions(-)
> > >   delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> > >   delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
> > >   delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> > >   delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dts:20.11-21: Warning (reg_format): /example-0/tpm@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dts:42.11-24: Warning (reg_format): /example-1/tpm@57:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> > Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> > Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> > Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> > Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> 
> Any idea what is wrong here with reg_format? I just copied the existing
> examples, so something was broken there before.

The default bus is 1 address cell and 1 size cell. If you need something 
different, like I2C or SPI, you need to define the bus node in the 
example. This is explained in example-schema.yaml.

Rob

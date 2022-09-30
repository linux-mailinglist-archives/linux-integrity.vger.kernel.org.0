Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5F5F15B9
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 00:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiI3WGB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 18:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiI3WFv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 18:05:51 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E776959;
        Fri, 30 Sep 2022 15:05:49 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id o64so6051233oib.12;
        Fri, 30 Sep 2022 15:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LZM1wmWc8bSjrCIQo1xKsVynrpi3FYOLnvvxC0dlsng=;
        b=BAT08SxxfIVVs0kBsHc2vjcLH/RqbewN43lSq9l20WALXucc1y8PrADaGaSdGzlVg3
         Jm5fJbz+5jAE07r03ygYRHFjUtwi0KyH5grRzgNUbTnNM/zUw5hFsX0b7NK99EpXIk7J
         LWOKq5t6AbQzx0rtSFdoyXEJCgvQpVpkztysDadRR4lGYLprCOwpH7uKM6DL5qTSpwcQ
         4xFduPucaB6QNrKFu3Nax7g2vMUEjtYyKn9fVRKcdyTjSnQ0ZuVrLMZO8WrHhpXY2BFn
         7KixohDMMviJvILh8XqtZexswHhWeyhUmgPZ/Nh0UudPd3Z4Y4WDokYfuquGGo6nR3RT
         9M7w==
X-Gm-Message-State: ACrzQf1nbH5sUxD/H1qBKRJYY26SsOG/It088GDFNNKP3iA3zhHWPS+Y
        IpDdw7oogPElH7jjIfIRkw==
X-Google-Smtp-Source: AMsMyM5GNayxmuhvrl7o8dL2pxAN0tW7B0BJ2oi5mYZZltd0cOyNhGzEyh101OOg9ytUcIcN19v0aA==
X-Received: by 2002:a05:6808:21a3:b0:350:cca1:9f40 with SMTP id be35-20020a05680821a300b00350cca19f40mr123959oib.205.1664575548627;
        Fri, 30 Sep 2022 15:05:48 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t15-20020a056870e74f00b0011f00b027bdsm995652oak.45.2022.09.30.15.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:05:47 -0700 (PDT)
Received: (nullmailer pid 1129751 invoked by uid 1000);
        Fri, 30 Sep 2022 22:05:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     peter@pjd.dev, amirmizi6@gmail.com, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, robh+dt@kernel.org,
        Johannes.Holland@infineon.com, benoit.houyere@st.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220930165116.13329-5-Alexander.Steffen@infineon.com>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com> <20220930165116.13329-5-Alexander.Steffen@infineon.com>
Message-Id: <166457526212.1112376.3928552824383328065.robh@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: tpm: Merge existing trivial TPMs to YAML
Date:   Fri, 30 Sep 2022 17:05:43 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 30 Sep 2022 18:51:13 +0200, Alexander Steffen wrote:
> Several of the existing text files describe trivial TPMs, that fit
> perfectly into the new trivial-tpms.yaml. Move them there.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  .../bindings/security/tpm/google,cr50.txt     | 19 ----------
>  .../bindings/security/tpm/tpm-i2c.txt         | 26 --------------
>  .../bindings/security/tpm/tpm_tis_mmio.txt    | 25 -------------
>  .../bindings/security/tpm/tpm_tis_spi.txt     | 23 ------------
>  .../bindings/security/tpm/trivial-tpms.yaml   | 36 +++++++++++++++++++
>  5 files changed, 36 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dts:20.11-21: Warning (reg_format): /example-0/tpm@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dts:42.11-24: Warning (reg_format): /example-1/tpm@57:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


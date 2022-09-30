Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417A85F15CB
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 00:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiI3WJY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 18:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiI3WJX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 18:09:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C215A73F;
        Fri, 30 Sep 2022 15:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C1E1B82A4E;
        Fri, 30 Sep 2022 22:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527E5C43140;
        Fri, 30 Sep 2022 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664575757;
        bh=63soWqTR6TvcJSos5GJwRTTe5ZcKkQt3ikeagWQB57Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G/MPo0rus1FpffyW+m7Rpfc76pJMhjj5T5KddgNWpskbrhZ3Lc/Zx92sMXG86AAmu
         6ksggBsCAgQgHHR0XDwk5rije18BnFSrZGUvGZKTcC4bPnWVikwIELyxPtFOQ7rCpK
         8yPEUAwjQ5ytWgMq8F6braa3v4oe46qYZ7eVE8OBWp0gdwF0Ul+GLeimlj/cj9lit2
         OkKN3pqAW2t2n309MHUlhvZ4vRK8Gczm1LTjU7r/Ai6bAOGzV1/m3dLx2FMp0YS7gg
         r6C+04GKl7lkLBaUQ78uy6J7iKKbOWFuvHVvDDV+It5yjOOmxCoWLnSvFGwwIMhRmo
         IaHOLPyV5E7ug==
Received: by mail-ua1-f50.google.com with SMTP id bu4so2244532uab.6;
        Fri, 30 Sep 2022 15:09:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf2q6aMTDyqftNSXRU9S4tX6iN/JjxlL1/rFPRUwoU1X079JniBW
        htHhbMRAcTMBbWeA0UucKtcI3VK8jeflCaccVA==
X-Google-Smtp-Source: AMsMyM7tEmCxqzTWD5dOJO1qpW2k4CPdwRS/ymZKMp2DO0hsI0jOAclWSbsCVNL+LQWrYiyZ7Kf1JRPQxSjvd3tcHM0=
X-Received: by 2002:ab0:70c8:0:b0:39f:7528:6289 with SMTP id
 r8-20020ab070c8000000b0039f75286289mr5662617ual.36.1664575756279; Fri, 30 Sep
 2022 15:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
In-Reply-To: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Sep 2022 17:09:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLTsV+Ukh9GhJ0guR0rqSUSY2E-Zn2XQLB28Ph2=gjaBg@mail.gmail.com>
Message-ID: <CAL_JsqLTsV+Ukh9GhJ0guR0rqSUSY2E-Zn2XQLB28Ph2=gjaBg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Clean up TPM compatibles
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Joel Stanley <joel@jms.id.au>
Cc:     devicetree@vger.kernel.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, Johannes.Holland@infineon.com,
        benoit.houyere@st.com, amirmizi6@gmail.com, peter@pjd.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+Joel

On Fri, Sep 30, 2022 at 12:03 PM Alexander Steffen
<Alexander.Steffen@infineon.com> wrote:
>
> Not all TPM compatibles were documented correctly so far. Some were not
> documented at all, others missed some properties, most of them did not use the
> latest YAML format. But by design most TPMs are very similar, so this allows to
> document them in a single trivial-tpms.yaml, similar to how
> trivial-devices.yaml documents simple I2C and SPI devices. This fixes all the
> documentation issues and ensures that dtbs_check can be used in the future to
> detect incorrect configurations automatically.
>
> Alexander Steffen (7):
>   dt-bindings: tpm: Introduce trivial-tpms.yaml
>   dt-bindings: tpm: Improve documentation of compatibles
>   dt-bindings: tpm: Add previously undocumented properties
>   dt-bindings: tpm: Merge existing trivial TPMs to YAML
>   dt-bindings: tpm: Document previously undocumented compatibles
>   dt-bindings: tpm: Add fallbacks for all TCG-compliant TPM variants
>   tpm: Add missing compatibles to drivers
>
>  .../bindings/security/tpm/google,cr50.txt     |  19 ---
>  .../bindings/security/tpm/tpm-i2c.txt         |  26 ----
>  .../bindings/security/tpm/tpm_tis_mmio.txt    |  25 ----
>  .../bindings/security/tpm/tpm_tis_spi.txt     |  23 ----
>  .../bindings/security/tpm/trivial-tpms.yaml   | 118 ++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  16 ---
>  drivers/char/tpm/tpm_tis_i2c.c                |   2 +
>  drivers/char/tpm/tpm_tis_spi_main.c           |   1 +
>  8 files changed, 121 insertions(+), 109 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml

Thanks, but please coordinate your work with this[1].

Rob

[1] https://lore.kernel.org/all/20220928043957.2636877-1-joel@jms.id.au/

>

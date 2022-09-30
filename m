Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B931E5F15EE
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 00:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiI3WPg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiI3WPc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 18:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D0C80F1;
        Fri, 30 Sep 2022 15:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2AAA62559;
        Fri, 30 Sep 2022 22:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A51AC433D7;
        Fri, 30 Sep 2022 22:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664576130;
        bh=57JhPEovtQmrlTwVes1KD37xwQn/uGueG4TbqkKX2xY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oqGOsUS0twLE2GPU3X5yW73EzlR9BNHtGxDL8NhEYglltpQIW5ZjJ5dVO2do2hj1m
         C644gCLxfbtntvKTSI38Dx0iCir17dOWSbKp7TlBrLZ2aJwFOQ5duRyOv+4eyp9ToQ
         SvGzHz8bXriRRxDNDuK7WigJwneYGTIN84ubB4LNm6Q7Lb90F9tMEwxvphj5dE70qK
         AaB0MQZIHcNALjNH/AEqmRMIdL2nwo9N5zae9Z8U6hH13duZna6on5zjUhQ/RvNzb4
         vBcva1ViO8blSpmCgl3mavSiXB5c4r7cqneTP5qxP2a4JT+IMM8j5A+s0oZArIjPEC
         B31qOo2LNiQsA==
Received: by mail-vs1-f46.google.com with SMTP id 63so6230556vse.2;
        Fri, 30 Sep 2022 15:15:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf31Kmb0O7gMEfqH0/9SxKNPVSub17x7qRVu71q3WJPlP6HJhhmQ
        BZ3U4bc+vOu++bi4UNnDuv3lqBDU47Q6h2Y4qw==
X-Google-Smtp-Source: AMsMyM4FY0Cf5aN+DfuK3wr50AytydaFutqPUQ8xeCqRm4m+OBUR6QHcRSPH+D4hfoo/VfSfCzv83W8vjiRfqQ9Lp8A=
X-Received: by 2002:a67:c18a:0:b0:398:4c72:cafb with SMTP id
 h10-20020a67c18a000000b003984c72cafbmr5128925vsj.53.1664576129143; Fri, 30
 Sep 2022 15:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com> <20220930165116.13329-2-Alexander.Steffen@infineon.com>
In-Reply-To: <20220930165116.13329-2-Alexander.Steffen@infineon.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Sep 2022 17:15:18 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+fCE3xTAUWYJo9keNJT_-oSgpNsFJUXcXCH57Uug3B=g@mail.gmail.com>
Message-ID: <CAL_Jsq+fCE3xTAUWYJo9keNJT_-oSgpNsFJUXcXCH57Uug3B=g@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: tpm: Introduce trivial-tpms.yaml
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     devicetree@vger.kernel.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, Johannes.Holland@infineon.com,
        benoit.houyere@st.com, amirmizi6@gmail.com, peter@pjd.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 30, 2022 at 12:03 PM Alexander Steffen
<Alexander.Steffen@infineon.com> wrote:
>
> Most TPM devices are very similar and only need a few common properties
> to describe them. However, they may use more properties than other
> trivial I2C or SPI devices, e.g. powered-while-suspended. Therefore,
> move them to their own trivial-tpms.yaml.
>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  .../bindings/security/tpm/trivial-tpms.yaml   | 54 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  | 16 ------
>  2 files changed, 54 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/trivia=
l-tpms.yaml
>
> diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.=
yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
> new file mode 100644
> index 000000000000..fadd4ca96554
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/trivial-tpms.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Trivial TPM devices that have simple device tree bindings
> +
> +maintainers:
> +  - linux-integrity@vger.kernel.org
> +
> +description: |
> +  This is a list of trivial TPM devices that share the same properties a=
nd
> +  therefore have simple device tree bindings.
> +
> +  If a device needs more specific bindings, such as properties to
> +  describe some aspect of it, there needs to be a specific binding
> +  document for it just like any other devices.
> +
> +properties:
> +  reg:
> +    maxItems: 1

blank line

> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency: true

The SPI based devices need to reference spi-peripheral-props.yaml. So
I think these are going to need to be split up by bus some.

> +
> +  compatible:

compatible goes first by convention.

> +    contains:

'contains' can not be used here. That allows any other compatible
strings to be present. It's got to be exact lists of what are valid
combinations.

> +      enum:
> +          # i2c trusted platform module (TPM)
> +        - atmel,at97sc3204t
> +          # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
> +        - infineon,slb9635tt
> +          # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> +        - infineon,slb9645tt
> +          # Infineon SLB9673 I2C TPM 2.0
> +        - infineon,slb9673
> +          # i2c trusted platform module (TPM)
> +        - nuvoton,npct501
> +          # i2c trusted platform module (TPM2)
> +        - nuvoton,npct601
> +          # Socionext SynQuacer TPM MMIO module
> +        - socionext,synquacer-tpm-mmio
> +          # i2c trusted platform module (TPM)
> +        - winbond,wpct301
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +...
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 61746755c107..1cc7f82c0822 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -47,8 +47,6 @@ properties:
>            - ams,iaq-core
>              # i2c serial eeprom (24cxx)
>            - at,24c08
> -            # i2c trusted platform module (TPM)
> -          - atmel,at97sc3204t
>              # ATSHA204 - i2c h/w symmetric crypto module
>            - atmel,atsha204
>              # ATSHA204A - i2c h/w symmetric crypto module
> @@ -135,12 +133,6 @@ properties:
>            - infineon,ir38164
>              # Infineon IR38263 Voltage Regulator
>            - infineon,ir38263
> -            # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz=
)
> -          - infineon,slb9635tt
> -            # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> -          - infineon,slb9645tt
> -            # Infineon SLB9673 I2C TPM 2.0
> -          - infineon,slb9673
>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
>              # Infineon Multi-phase Digital VR Controller xdpe11280
> @@ -289,10 +281,6 @@ properties:
>            - national,lm85
>              # I2C =C2=B10.33=C2=B0C Accurate, 12-Bit + Sign Temperature =
Sensor and Thermal Window Comparator
>            - national,lm92
> -            # i2c trusted platform module (TPM)
> -          - nuvoton,npct501
> -            # i2c trusted platform module (TPM2)
> -          - nuvoton,npct601
>              # Nuvoton Temperature Sensor
>            - nuvoton,w83773g
>              # OKI ML86V7667 video decoder
> @@ -327,8 +315,6 @@ properties:
>            - silabs,si7020
>              # Skyworks SKY81452: Six-Channel White LED Driver with Touch=
 Panel Bias Supply
>            - skyworks,sky81452
> -            # Socionext SynQuacer TPM MMIO module
> -          - socionext,synquacer-tpm-mmio
>              # SparkFun Qwiic Joystick (COM-15168) with i2c interface
>            - sparkfun,qwiic-joystick
>              # i2c serial eeprom (24cxx)
> @@ -383,8 +369,6 @@ properties:
>            - winbond,w83793
>              # Vicor Corporation Digital Supervisor
>            - vicor,pli1209bc
> -            # i2c trusted platform module (TPM)
> -          - winbond,wpct301
>
>  required:
>    - compatible
> --
> 2.25.1
>

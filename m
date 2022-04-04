Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8D14F1AC8
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Apr 2022 23:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379228AbiDDVS7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379024AbiDDQUe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 12:20:34 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D2112E;
        Mon,  4 Apr 2022 09:18:36 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so7581519otj.1;
        Mon, 04 Apr 2022 09:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hu9KSkDZSHDARPuS6OeF/SFHVgom3OphqHB/ovTTyyc=;
        b=rEaGG6jwUE28L+dcEtV9mHLkGqBquyalA5Iixe7C4WljBSp4w6f1Q8eZrpDQcriDK1
         kvBv5is/3GH7VYZpWSTfu+kfBwAYICqp2RxKsEWXw7allgtizzeaUFRQPjhTWJr/9I0e
         ipybAk2l62P8//XVnNXv5WeriMtWocQLxNiXqglX+PYCLmhyq6zl3DQaJeDXePBi3gEQ
         8U1Kpk7VT02nrws1YvE9g14/R7xvMjRYb3hPVgNGAWzbgbCnKTWmgDQo48heZlzGDag0
         GaiS3sObAuaFhruhi354WvRY6xUWSaUY7RzY+UQlo2G9e5YcCrJtlAnPC6baHpDlmpBJ
         6UOA==
X-Gm-Message-State: AOAM53106+EtfBtGYQ16Qb52+1j4scUrrIzMyXex6omqvqWtZ7WIYTTo
        4Qle0MRXdMSAxqFM++5Tl6LWwy0dIw==
X-Google-Smtp-Source: ABdhPJzlbcqlUcevY+LJogN60SKhl43Gre7Qq49OUTHTWjhy5AnY9jLygJLT1/DvKJka+infgFVneA==
X-Received: by 2002:a05:6830:1605:b0:5c9:4fde:ba63 with SMTP id g5-20020a056830160500b005c94fdeba63mr114325otr.84.1649089112766;
        Mon, 04 Apr 2022 09:18:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d12-20020a056871040c00b000d9eed0f8fdsm4334114oag.14.2022.04.04.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:18:32 -0700 (PDT)
Received: (nullmailer pid 1453992 invoked by uid 1000);
        Mon, 04 Apr 2022 16:18:31 -0000
Date:   Mon, 4 Apr 2022 11:18:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amirmizi6@gmail.com
Subject: Re: [PATCH 4/4] tpm: Add YAML schema for the TPM TIS I2C options
Message-ID: <YksaVw74Eotowyse@robh.at.kernel.org>
References: <20220404081835.495-1-johannes.holland@infineon.com>
 <20220404081835.495-4-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404081835.495-4-johannes.holland@infineon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 04, 2022 at 10:18:35AM +0200, Johannes Holland wrote:
> Add a YAML schema to support device tree bindings for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.

Bindings are for devices. A protocol layer does not make a device.

> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

We already have a binding for I2C TPM. That one should be converted.

> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> new file mode 100644
> index 000000000000..7948867ff3f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C PTP based TPM Device Tree Bindings
> +
> +maintainers:
> +  - Johannes Holland <johannes.holland@infineon.com>
> +
> +description:
> +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          # Infineon's Trusted Platform Module (TPM) (SLB9673)
> +          - infineon,slb9673
> +          # Nuvoton's Trusted Platform Module (TPM) (NPCT75x)
> +          - nuvoton,npct75x

I see this is already used, but in general wildcards should not be used 
in device compatibles.

> +      - const: tcg,tpm-tis-i2c

Pretty sure I killed this off when originally reviewing the TPM I2C 
binding.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      tpm@2e {
> +        compatible = "infineon,slb9673", "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> +        reg = <0x2e>;
> +      };
> +    };
> +...
> -- 
> 2.31.1.windows.1
> 
> 

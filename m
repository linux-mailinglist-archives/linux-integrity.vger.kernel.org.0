Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D95B7826
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 19:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiIMRjl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 13:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiIMRjS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 13:39:18 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64F0A6C1E;
        Tue, 13 Sep 2022 09:31:24 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-12803ac8113so33554215fac.8;
        Tue, 13 Sep 2022 09:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eN4Bm2YNr1OhBwgvWHkqVE6CvGxcgSaMgt/c8EArC4Y=;
        b=TKm+DJIBBbY95gcmHzcC29zIPC+qCIoTR1pcR4hjNjOQ+VJmilFqsnhk6xmfz6XU08
         jqA0sRZApReCi8VObRluTG6FfoFlyXh7rxFQZYFLWAX7y0hOSHDlTjIoDHHmkaKfhywy
         JMhDK5kJ1k/YZIV4cZNh3IXifFWk6Vg1KjqHTSpSYtn9gjPtbC7Ec7/ix9kKzq760jNX
         05/fF0YuwB2SkiAWpk9IuLqGg8DZxBcAL12g3JKPt2UHA6V0s6/l3TbMRdzhULLx/cFz
         8wK4RXk6R9bhDc7o3srAIANKCTwdYnW5V+IVXTGcDhAqKclNBpRzfjlfBFEI98e6oTx8
         uF8w==
X-Gm-Message-State: ACgBeo1wRRo8o38MjgnvqXiqs6UddbIRjMbilLB/DdZFsB+UsN9TeJod
        JGH6N/A3Rd06gKm4WlL6HQ==
X-Google-Smtp-Source: AA6agR64pHlJID3fpnHnMTPp4HrGN4ImeREXRRvOMrwTsIQQ56ZQHBorRhNB0BTFZchYa+YiTTl0mg==
X-Received: by 2002:a05:6808:1246:b0:34d:8c6d:b189 with SMTP id o6-20020a056808124600b0034d8c6db189mr71076oiv.208.1663086683777;
        Tue, 13 Sep 2022 09:31:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o20-20020a9d6d14000000b00636d6571ff7sm6159453otp.70.2022.09.13.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:31:23 -0700 (PDT)
Received: (nullmailer pid 3856678 invoked by uid 1000);
        Tue, 13 Sep 2022 16:31:22 -0000
Date:   Tue, 13 Sep 2022 11:31:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, eajames@linux.ibm.com
Subject: Re: [PATCH 1/2] dt-bindings: tpm: Add schema for TIS I2C devices
Message-ID: <20220913163122.GA3809735-robh@kernel.org>
References: <20220913091025.1768882-1-joel@jms.id.au>
 <20220913091025.1768882-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913091025.1768882-2-joel@jms.id.au>
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

On Tue, Sep 13, 2022 at 06:40:23PM +0930, Joel Stanley wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
> 

Not really v1. And there was v19 that I already reviewed...

> Add a YAML schema to support device tree bindings for the generic I2C

s/YAML/DT/

> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
> 
> This includes descriptions for the Nuvoton and Infineon devices.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> new file mode 100644
> index 000000000000..fb7b747ff2a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C PTP based TPM Device Tree Bindings

s/Device Tree Bindings/Devices/

> +
> +maintainers:
> +  - Johannes Holland <johannes.holland@infineon.com>
> +
> +description:
> +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
> +
> +properties:
> +  $nodename:
> +    pattern: "^tpm(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    oneOf:
> +      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
> +        items:
> +          - const: infineon,slb9673

You need to remove from trivial-devices.yaml. A revert of [1] perhaps.

> +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
> +        items:
> +          - const: nuvoton,npct75x
> +          - const: tcg,tpm-tis-i2c
> +      - const: tcg,tpm-tis-i2c
> +  reg:
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
> +        compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> +        reg = <0x2e>;
> +      };
> +    };
> +...
> -- 
> 2.35.1
> 
> 

[1] https://lore.kernel.org/all/20220608173113.9232-2-Alexander.Steffen@infineon.com/

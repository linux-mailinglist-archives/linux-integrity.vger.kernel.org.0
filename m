Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBD1AABC6
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2020 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506402AbgDOPVC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 11:21:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37385 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgDOPVA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 11:21:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so3901211oij.4;
        Wed, 15 Apr 2020 08:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1BfqGTsRG/XiRfj9IrPOvmGGbY0WhRE/e/njJVbckvY=;
        b=nTTxldL/ABQjXu8h9JcdjFe58Tes9e7BP2Vw/Shhgv7pPg0G1/EI42/HTEPa5f5tee
         /XunlSBdHshn5HxnHomNl2LLUrVeUyhoOHvKG+19apTaOD9CJSRd6Z3Kk1ixhXXBscVB
         3cgOhyvUimx2daeRpB/DXgLXmB1CMCFCOP+Y/bonZzcTgzl6HEIk3+ZhfW+wIEjdCbM5
         my4WN4M57EQQCEEGqO23WTnV02FPpjcEFN/kq5jNOvYT1zO3qS6+qb/l0kxZHIvkjzNf
         ZyBxGaZGoipAyCeD5Z36hAvvG3ZKwNp01OnxBPh0PSyi3L9pWchb+XjK2UVNYleGv9dt
         ZIjQ==
X-Gm-Message-State: AGi0PuZ8CnMYxM2hYSZsfpH0yK/DcUG4mrij5fRTS20am2mzyBHpQbeF
        qnt1cHplWjKhtbKob9cNtA==
X-Google-Smtp-Source: APiQypJR6hUytgfto/sijH40XT6ONP45zrE8EFcxOW+Q+9Qc/j3M0QXAmAu6+xJRDcVihpLynYMw6w==
X-Received: by 2002:aca:c145:: with SMTP id r66mr18690858oif.90.1586964058634;
        Wed, 15 Apr 2020 08:20:58 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k132sm6477456oih.9.2020.04.15.08.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:20:57 -0700 (PDT)
Received: (nullmailer pid 9564 invoked by uid 1000);
        Wed, 15 Apr 2020 15:20:56 -0000
Date:   Wed, 15 Apr 2020 10:20:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v6 6/7] dt-bindings: tpm: Add YAML schema for TPM TIS I2C
 options
Message-ID: <20200415152056.GA30547@bogus>
References: <20200407162044.168890-1-amirmizi6@gmail.com>
 <20200407162044.168890-7-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407162044.168890-7-amirmizi6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 07, 2020 at 07:20:43PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c
> PTP based physical layer.
> 
> This patch adds the documentation for corresponding device tree bindings of
> I2C based Physical TPM.
> Refer to the 'I2C Interface Definition' section in
> 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
> for specification.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> new file mode 100644
> index 0000000..13d7c2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C PTP based TPM Device Tree Bindings
> +
> +maintainers:
> +  - Amir Mizinski <amirmizi6@gmail.com>
> +
> +description:
> +  Device Tree Bindings for I2C based Trusted Platform Module(TPM).
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: tcg,tpm-tis-i2c

This is not sufficient. I assume you are testing on some specific TPM 
chip.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt:
> +    maxItems: 1
> +
> +  crc-checksum:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      CRC checksum enable.

Why would you not want CRC? Some chips support and some don't? If so, 
the compatible for the chip should imply that.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      tpm-tis-i2c@2e {

tpm@2e

> +        compatible = "tcg,tpm-tis-i2c";
> +        reg = <0x2e>;
> +        crc-checksum;
> +      };
> +    };
> +...
> -- 
> 2.7.4
> 

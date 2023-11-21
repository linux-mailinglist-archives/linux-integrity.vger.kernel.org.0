Return-Path: <linux-integrity+bounces-148-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980D87F32DC
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 16:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94631C21AB9
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4B58135;
	Tue, 21 Nov 2023 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC867D45;
	Tue, 21 Nov 2023 07:56:35 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35b03e9c08eso7623845ab.1;
        Tue, 21 Nov 2023 07:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582195; x=1701186995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/ZFrhubPQ2bB2jHL69rP+ZIvxObAmZiGrmSV+P9FPY=;
        b=BSLQO38jxGO0QzQaRrObq5vdTIfHwofC/47GvmN3fT0vohdr8386MmTP2ee6BaqbSf
         80jJ30vuuYWjbhBUhthe3pg3s3SFs2MBftRl1Ta0G6+KbC6B+sRC7B4OcIB+PNhHLs46
         RtVU0+ZAJAYDVpx+zkMitHeGA/8A1IPBNOKyGJglSv9o8kKaOTuw1i3pAAmtVoPv8gmk
         ZcH5B5tU9EzqRSOzCPuWK7X0LIcqlzNvT0LsHrozg1CzecX85HJh7EoA122MZdKcL6J9
         2aIeM90JGZsig8y4KEq7lHdo1TCCQlk8UTTSgg6TdxvfwrhBzDUFBfphUJqIT7t+gEPi
         vDrQ==
X-Gm-Message-State: AOJu0Yz0c3OtF8HWHVdyedfyJ5BGkO1lqWUW8nYomoEHrvZfcSK2D3bi
	MG7q15Vjd22aDM3LSk5g5Q==
X-Google-Smtp-Source: AGHT+IEpSJyKlmrCu5jbBpbHnpFFfFOnT7tTiX8pjydX97OMhg6NLP90Ox0t5t9d33v7VzQZ7x4jaQ==
X-Received: by 2002:a92:d785:0:b0:359:417b:50de with SMTP id d5-20020a92d785000000b00359417b50demr5122619iln.15.1700582194870;
        Tue, 21 Nov 2023 07:56:34 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id cb9-20020a0566381b0900b0046467305620sm2611533jab.156.2023.11.21.07.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:56:34 -0800 (PST)
Received: (nullmailer pid 1870678 invoked by uid 1000);
	Tue, 21 Nov 2023 15:56:32 -0000
Date: Tue, 21 Nov 2023 08:56:32 -0700
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 1/3] dt-bindings: tpm: Consolidate TCG TIS bindings
Message-ID: <20231121155632.GB1845293-robh@kernel.org>
References: <cover.1700555862.git.lukas@wunner.de>
 <e83a43a67c96b4f2614f029666209cb408da8678.1700555862.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e83a43a67c96b4f2614f029666209cb408da8678.1700555862.git.lukas@wunner.de>

On Tue, Nov 21, 2023 at 10:48:41AM +0100, Lukas Wunner wrote:
> A significant number of Trusted Platform Modules conform to the "TIS"
> specification published by the Trusted Computing Group ("TCG PC Client
> Specific TPM Interface Specification").  These chips typically use an
> SPI, I²C or LPC bus as transport (via MMIO in the latter case).  Some
> of them even support multiple of those buses (selectable through a
> config strap) or the same chip is available in multiple SKUs, each with
> a different bus interface.
> 
> The devicetree bindings for these TPMs have not been converted to DT
> schema yet and are spread out across 3 generic files and 3 chip-specific
> files.  A few TPM compatible strings were added to trivial-devices.yaml
> even though additional properties are documented in the plaintext
> bindings.

Thanks for doing this. Looks pretty good.

> 
> Consolidate the devicetree bindings into 3 files, one per bus.
> 
> Move common properties to a separate tpm-common.yaml.
> 
> Document compatible strings which are supported by the TPM TIS driver
> but were neglected to be added to the devicetree bindings.
> 
> Document the memory-region property recently introduced by commit
> 1e2714bb83fc ("tpm: Add reserved memory event log").
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .../bindings/security/tpm/google,cr50.txt     |  19 ----
>  .../bindings/security/tpm/st33zp24-i2c.txt    |  34 ------
>  .../bindings/security/tpm/st33zp24-spi.txt    |  32 ------
>  .../bindings/security/tpm/tpm-i2c.txt         |  26 -----
>  .../bindings/security/tpm/tpm_tis_mmio.txt    |  25 ----
>  .../bindings/security/tpm/tpm_tis_spi.txt     |  23 ----
>  .../bindings/tpm/tcg,tpm-tis-i2c.yaml         | 107 ++++++++++++++++++
>  .../bindings/tpm/tcg,tpm-tis-mmio.yaml        |  50 ++++++++
>  .../bindings/tpm/tcg,tpm_tis-spi.yaml         |  88 ++++++++++++++
>  .../devicetree/bindings/tpm/tpm-common.yaml   |  56 +++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  16 ---
>  11 files changed, 301 insertions(+), 175 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tpm-common.yaml


> diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> new file mode 100644
> index 000000000000..2f95916046a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I²C-attached Trusted Platform Module conforming to TCG TIS specification
> +
> +maintainers:
> +  - Lukas Wunner <lukas@wunner.de>
> +
> +description: |
> +  The Trusted Computing Group (TCG) has defined a multi-vendor standard
> +  for accessing a TPM chip.  It can be transported over various buses,
> +  one of them being I²C.  The standard is named:
> +  TCG PC Client Specific TPM Interface Specification (TIS)
> +  https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - atmel,at97sc3204t
> +          - google,cr50 # H1 Secure Microcontroller running Cr50 firmware
> +          - infineon,slb9635tt
> +          - infineon,slb9645tt
> +          - infineon,slb9673
> +          - infineon,tpm_i2c_infineon
> +          - nuvoton,npct501
> +          - nuvoton,npct601
> +          - st,st33zp24-i2c
> +          - winbond,wpct301
> +      - const: tcg,tpm-tis-i2c
> +
> +  reg:
> +    description: address of TPM on the I²C bus
> +
> +  clock-frequency:
> +    description: clock frequency used to access TPM on the I²C bus
> +
> +allOf:
> +  - $ref: tpm-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: at97sc3201
> +    then:
> +      properties:
> +        $nodename:
> +          pattern: "^tpm$"

Devices on I2C bus have a unit address.


> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: infineon,slb9635tt
> +    then:
> +      properties:
> +        clock-frequency:
> +          maximum: 100000
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: infineon,slb9645tt
> +    then:
> +      properties:
> +        clock-frequency:
> +          maximum: 400000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tpm@57 {
> +            label = "tpm";
> +            compatible = "nuvoton,npct601", "tcg,tpm-tis-i2c";
> +            reg = <0x57>;
> +            linux,sml-base = <0x7f 0xfd450000>;
> +            linux,sml-size = <0x10000>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tpm@13 {
> +            reg = <0x13>;
> +            compatible = "st,st33zp24-i2c", "tcg,tpm-tis-i2c";
> +            clock-frequency = <400000>;
> +            interrupt-parent = <&gpio5>;
> +            interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
> +            lpcpd-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
> new file mode 100644
> index 000000000000..ce578cf22079
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-mmio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MMIO-accessed Trusted Platform Module conforming to TCG TIS specification
> +
> +maintainers:
> +  - Lukas Wunner <lukas@wunner.de>
> +
> +description: |
> +  The Trusted Computing Group (TCG) has defined a multi-vendor standard
> +  for accessing a TPM chip.  It can be transported over various buses,
> +  one of them being LPC (via MMIO).  The standard is named:
> +  TCG PC Client Specific TPM Interface Specification (TIS)
> +  https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - at97sc3201
> +          - atmel,at97sc3204
> +          - nuvoton,npct650
> +          - socionext,synquacer-tpm-mmio
> +      - const: tcg,tpm-tis-mmio
> +
> +  reg:
> +    description:
> +      location and length of the MMIO registers, length should be
> +      at least 0x5000 bytes
> +
> +allOf:
> +  - $ref: tpm-common.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    tpm@90000 {
> +        compatible = "atmel,at97sc3204", "tcg,tpm-tis-mmio";
> +        reg = <0x90000 0x5000>;
> +        interrupt-parent = <&EIC0>;
> +        interrupts = <1 2>;
> +    };
> diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
> new file mode 100644
> index 000000000000..2415839eda7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI-attached Trusted Platform Module conforming to TCG TIS specification
> +
> +maintainers:
> +  - Lukas Wunner <lukas@wunner.de>
> +
> +description: |
> +  The Trusted Computing Group (TCG) has defined a multi-vendor standard
> +  for accessing a TPM chip.  It can be transported over various buses,
> +  one of them being SPI.  The standard is named:
> +  TCG PC Client Specific TPM Interface Specification (TIS)
> +  https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - google,cr50 # H1 Secure Microcontroller running Cr50 firmware
> +          - infineon,slb9670
> +          - st,st33htpm-spi
> +          - st,st33zp24-spi
> +      - const: tcg,tpm_tis-spi
> +
> +allOf:
> +  - $ref: tpm-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,st33zp24-spi
> +    then:
> +      properties:
> +        spi-max-frequency:
> +          maximum: 10000000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tpm@0 {
> +            reg = <0>;
> +            compatible = "google,cr50", "tcg,tpm_tis-spi";
> +            spi-max-frequency = <800000>;
> +        };
> +    };
> +
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tpm@0 {
> +            reg = <0>;
> +            compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +            spi-max-frequency = <10000000>;
> +        };
> +    };

Just a different compatible string and frequency doesn't really justify 
an example.

> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tpm@0 {
> +            reg = <0>;
> +            compatible = "st,st33zp24-spi", "tcg,tpm_tis-spi";
> +            spi-max-frequency = <10000000>;
> +            interrupt-parent = <&gpio5>;
> +            interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
> +            lpcpd-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> new file mode 100644
> index 000000000000..03569b74a318
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/tpm/tpm-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Trusted Platform Module common properties
> +
> +maintainers:
> +  - Lukas Wunner <lukas@wunner.de>
> +
> +properties:
> +  interrupts:
> +    description: indicates command completion
> +    maxItems: 1
> +
> +  label:
> +    description: human readable string describing the device, e.g. "tpm"
> +
> +  oneOf:

This will be an error because 'oneOf' here is a DT property name.

> +    - memory-region:
> +        description: reserved memory allocated for firmware event log
> +        maxItems: 1
> +    - allOf:
> +        - linux,sml-base:
> +            description:
> +              base address of reserved memory allocated for firmware event log
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            minItems: 2
> +            maxItems: 2

You can just define this as a uint64 instead. The source encoding 
doesn't matter.

> +        - linux,sml-size:
> +            description:
> +              size of reserved memory allocated for firmware event log
> +            $ref: /schemas/types.yaml#/definitions/uint32

What you need here is just define these properties and then add this:

dependentRequired:
  linux,sml-base: ['linux,sml-size']
  linux,sml-size: ['linux,sml-base']

dependentSchemas:
  memory-region:
    properties:
      linux,sml-base: false
  linux,sml-base:
    properties:
      memory-region: false

> +
> +  powered-while-suspended:
> +    description:
> +      present when the TPM is left powered on between suspend and resume
> +      (makes the suspend/resume callbacks do nothing)

Needs a type (type: boolean).

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,st33zp24
> +    then:
> +      properties:
> +        lpcpd-gpios:
> +          description:
> +            Output GPIO pin used for ST33ZP24 power management of D1/D2 state.
> +            If set, power must be present when the platform is going into
> +            sleep/hibernate mode.
> +          maxItems: 1
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index c3190f2a168a..29aed5ddba6b 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -49,8 +49,6 @@ properties:
>            - ams,iaq-core
>              # i2c serial eeprom (24cxx)
>            - at,24c08
> -            # i2c trusted platform module (TPM)
> -          - atmel,at97sc3204t
>              # ATSHA204 - i2c h/w symmetric crypto module
>            - atmel,atsha204
>              # ATSHA204A - i2c h/w symmetric crypto module
> @@ -145,12 +143,6 @@ properties:
>            - infineon,ir38263
>              # Infineon IRPS5401 Voltage Regulator (PMIC)
>            - infineon,irps5401
> -            # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
> -          - infineon,slb9635tt
> -            # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> -          - infineon,slb9645tt
> -            # Infineon SLB9673 I2C TPM 2.0
> -          - infineon,slb9673
>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
>              # Infineon Multi-phase Digital VR Controller xdpe11280
> @@ -301,10 +293,6 @@ properties:
>            - national,lm85
>              # I2C ±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator
>            - national,lm92
> -            # i2c trusted platform module (TPM)
> -          - nuvoton,npct501
> -            # i2c trusted platform module (TPM2)
> -          - nuvoton,npct601
>              # Nuvoton Temperature Sensor
>            - nuvoton,w83773g
>              # OKI ML86V7667 video decoder
> @@ -349,8 +337,6 @@ properties:
>            - silabs,si7020
>              # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
>            - skyworks,sky81452
> -            # Socionext SynQuacer TPM MMIO module
> -          - socionext,synquacer-tpm-mmio
>              # SparkFun Qwiic Joystick (COM-15168) with i2c interface
>            - sparkfun,qwiic-joystick
>              # i2c serial eeprom (24cxx)
> @@ -405,8 +391,6 @@ properties:
>            - winbond,w83793
>              # Vicor Corporation Digital Supervisor
>            - vicor,pli1209bc
> -            # i2c trusted platform module (TPM)
> -          - winbond,wpct301
>  
>  required:
>    - compatible
> -- 
> 2.40.1
> 


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2D5F48C0
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Oct 2022 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJDRlz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 13:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJDRlq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 13:41:46 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F9647E5;
        Tue,  4 Oct 2022 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664905301; x=1696441301;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=i/H069w+EpVpiJpHJKQ5NkpcZjMQHzDzJiqz3fZXvOw=;
  b=AXjy+cp50wVT5NOwB1BiEBZYl3UhVbTvwOhcA86UamJ6HZTaTggxyzjV
   5daeDUZuukPa4dTO5tf/rgGsgpU3QzG2ew8HwgNXC2wZEaf5T4ogmk/Hn
   CpkXdVTCCO09rfpX/IDYNHdQ4qwrWNkbl0jOjUH8O46PjeFoqHbPOe/gF
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="320203677"
X-IronPort-AV: E=Sophos;i="5.95,158,1661810400"; 
   d="scan'208";a="320203677"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 19:41:38 +0200
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Tue,  4 Oct 2022 19:41:37 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 19:41:37 +0200
Received: from [10.165.68.85] (10.165.68.85) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 19:41:36 +0200
Message-ID: <50da1beb-ee08-568f-a27c-9cad5f30996e@infineon.com>
Date:   Tue, 4 Oct 2022 19:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH 1/7] dt-bindings: tpm: Introduce trivial-tpms.yaml
To:     Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>, <Johannes.Holland@infineon.com>,
        <benoit.houyere@st.com>, <amirmizi6@gmail.com>, <peter@pjd.dev>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
 <20220930165116.13329-2-Alexander.Steffen@infineon.com>
 <CAL_Jsq+fCE3xTAUWYJo9keNJT_-oSgpNsFJUXcXCH57Uug3B=g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAL_Jsq+fCE3xTAUWYJo9keNJT_-oSgpNsFJUXcXCH57Uug3B=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.165.68.85]
X-ClientProxiedBy: MUCSE820.infineon.com (172.23.29.46) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 01.10.22 00:15, Rob Herring wrote:
> On Fri, Sep 30, 2022 at 12:03 PM Alexander Steffen
> <Alexander.Steffen@infineon.com> wrote:
>>
>> Most TPM devices are very similar and only need a few common properties
>> to describe them. However, they may use more properties than other
>> trivial I2C or SPI devices, e.g. powered-while-suspended. Therefore,
>> move them to their own trivial-tpms.yaml.
>>
>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>> ---
>>   .../bindings/security/tpm/trivial-tpms.yaml   | 54 +++++++++++++++++++
>>   .../devicetree/bindings/trivial-devices.yaml  | 16 ------
>>   2 files changed, 54 insertions(+), 16 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
>> new file mode 100644
>> index 000000000000..fadd4ca96554
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/security/tpm/trivial-tpms.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Trivial TPM devices that have simple device tree bindings
>> +
>> +maintainers:
>> +  - linux-integrity@vger.kernel.org
>> +
>> +description: |
>> +  This is a list of trivial TPM devices that share the same properties and
>> +  therefore have simple device tree bindings.
>> +
>> +  If a device needs more specific bindings, such as properties to
>> +  describe some aspect of it, there needs to be a specific binding
>> +  document for it just like any other devices.
>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
> 
> blank line
> 
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency: true
> 
> The SPI based devices need to reference spi-peripheral-props.yaml. So
> I think these are going to need to be split up by bus some.
> 
>> +
>> +  compatible:
> 
> compatible goes first by convention.

I had copied all three from trivial-devices.yaml ;-)

The style fixes are easy. But do you really think I should split 
trivial-tpms.yaml into i2c-tpms.yaml, spi-tpms.yaml, etc.? After all, 
trivial-devices.yaml also contains a mix of I2C and SPI devices.

Also, what about devices like "google,cr50", that support both I2C and 
SPI? Can they appear in two YAML files at the same time?

>> +    contains:
> 
> 'contains' can not be used here. That allows any other compatible
> strings to be present. It's got to be exact lists of what are valid
> combinations.

So what exactly are valid combinations then? If I look at what is in 
use, I find three possible combinations:

arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi: compatible = 
"tcg,tpm_tis-spi"
arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts: compatible = 
"infineon,slb9670", "tcg,tpm_tis-spi";
arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts: compatible 
= "infineon,slb9670";

It is either a generic identifier or a specific device or both. Is it 
correct to allow all three variants? If so, how to specify that as YAML, 
ideally without duplicating any of the identifiers?

>> +      enum:
>> +          # i2c trusted platform module (TPM)
>> +        - atmel,at97sc3204t
>> +          # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
>> +        - infineon,slb9635tt
>> +          # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
>> +        - infineon,slb9645tt
>> +          # Infineon SLB9673 I2C TPM 2.0
>> +        - infineon,slb9673
>> +          # i2c trusted platform module (TPM)
>> +        - nuvoton,npct501
>> +          # i2c trusted platform module (TPM2)
>> +        - nuvoton,npct601
>> +          # Socionext SynQuacer TPM MMIO module
>> +        - socionext,synquacer-tpm-mmio
>> +          # i2c trusted platform module (TPM)
>> +        - winbond,wpct301
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +...
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 61746755c107..1cc7f82c0822 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -47,8 +47,6 @@ properties:
>>             - ams,iaq-core
>>               # i2c serial eeprom (24cxx)
>>             - at,24c08
>> -            # i2c trusted platform module (TPM)
>> -          - atmel,at97sc3204t
>>               # ATSHA204 - i2c h/w symmetric crypto module
>>             - atmel,atsha204
>>               # ATSHA204A - i2c h/w symmetric crypto module
>> @@ -135,12 +133,6 @@ properties:
>>             - infineon,ir38164
>>               # Infineon IR38263 Voltage Regulator
>>             - infineon,ir38263
>> -            # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
>> -          - infineon,slb9635tt
>> -            # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
>> -          - infineon,slb9645tt
>> -            # Infineon SLB9673 I2C TPM 2.0
>> -          - infineon,slb9673
>>               # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>>             - infineon,tlv493d-a1b6
>>               # Infineon Multi-phase Digital VR Controller xdpe11280
>> @@ -289,10 +281,6 @@ properties:
>>             - national,lm85
>>               # I2C ±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator
>>             - national,lm92
>> -            # i2c trusted platform module (TPM)
>> -          - nuvoton,npct501
>> -            # i2c trusted platform module (TPM2)
>> -          - nuvoton,npct601
>>               # Nuvoton Temperature Sensor
>>             - nuvoton,w83773g
>>               # OKI ML86V7667 video decoder
>> @@ -327,8 +315,6 @@ properties:
>>             - silabs,si7020
>>               # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
>>             - skyworks,sky81452
>> -            # Socionext SynQuacer TPM MMIO module
>> -          - socionext,synquacer-tpm-mmio
>>               # SparkFun Qwiic Joystick (COM-15168) with i2c interface
>>             - sparkfun,qwiic-joystick
>>               # i2c serial eeprom (24cxx)
>> @@ -383,8 +369,6 @@ properties:
>>             - winbond,w83793
>>               # Vicor Corporation Digital Supervisor
>>             - vicor,pli1209bc
>> -            # i2c trusted platform module (TPM)
>> -          - winbond,wpct301
>>
>>   required:
>>     - compatible
>> --
>> 2.25.1
>>

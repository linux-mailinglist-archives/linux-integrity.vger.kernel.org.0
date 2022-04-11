Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00F24FBAF1
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Apr 2022 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245270AbiDKLdU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Apr 2022 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbiDKLdS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Apr 2022 07:33:18 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0CC4578F;
        Mon, 11 Apr 2022 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1649676665; x=1681212665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gugPxkZRoxMXAphUXKAPVO6SK72+rb+7kZN6teQ7Gwk=;
  b=Zkyhyzv4p1U84NEwsOQa5GX3OVm2asMwuLEcjLxx5ii2FYAoIXFNqC5i
   O5mZ88DoNUO8+EZu87C8Bb9CtFnKgUOlPDEJhziNfONk7JCJ0KCgjaKfA
   i9cWHEjyA7oA4qngy3lPxzghCpc3WCLJthXqPLV25MvVlhlQxoR/GcJiL
   U=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="289851380"
X-IronPort-AV: E=Sophos;i="5.90,251,1643670000"; 
   d="scan'208";a="289851380"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 13:30:55 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 11 Apr 2022 13:30:54 +0200 (CEST)
Received: from [10.160.241.183] (172.23.8.247) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 13:30:54 +0200
Message-ID: <52cfa5fc-9fc5-dee4-6d53-70d241510269@infineon.com>
Date:   Mon, 11 Apr 2022 13:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] tpm: Add YAML schema for the TPM TIS I2C options
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <amirmizi6@gmail.com>
References: <20220404081835.495-1-johannes.holland@infineon.com>
 <20220404081835.495-4-johannes.holland@infineon.com>
 <YksaVw74Eotowyse@robh.at.kernel.org>
From:   Johannes Holland <johannes.holland@infineon.com>
In-Reply-To: <YksaVw74Eotowyse@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE816.infineon.com (172.23.29.42) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 04.04.2022 18:18, Rob Herring wrote:
> On Mon, Apr 04, 2022 at 10:18:35AM +0200, Johannes Holland wrote:
>> Add a YAML schema to support device tree bindings for the generic I2C
>> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
>> Specification for TPM 2.0 v1.04 Revision 14.
>
> Bindings are for devices. A protocol layer does not make a device.

Agreed. I will change this in my next patch.

>
>>
>> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
>> ---
>>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 48 +++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>
> We already have a binding for I2C TPM. That one should be converted.

Will do. There are two required properties which are in fact not needed
by any I2C driver. If that is ok with you, I would like to turn them
optional.

- linux,sml-base
- linux,sml-size

>>>
>> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>> new file mode 100644
>> index 000000000000..7948867ff3f7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: I2C PTP based TPM Device Tree Bindings
>> +
>> +maintainers:
>> +  - Johannes Holland <johannes.holland@infineon.com>
>> +
>> +description:
>> +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          # Infineon's Trusted Platform Module (TPM) (SLB9673)
>> +          - infineon,slb9673
>> +          # Nuvoton's Trusted Platform Module (TPM) (NPCT75x)
>> +          - nuvoton,npct75x
>
> I see this is already used, but in general wildcards should not be used
> in device compatibles.

Ok, I took this over from a previous patch. Since I am not familiar with
Nuvoton products, so I am going to remove this for now.

>
>> +      - const: tcg,tpm-tis-i2c
>
> Pretty sure I killed this off when originally reviewing the TPM I2C
> binding.
>

Sorry, I did not see any discussion related to this.

IMHO, the TPM is a open standard device. That should allow for plug
and play, regardless of the manufacturer. For SPI, we also have
tcg,tpm_tis-spi. However, if you want it removed, I can do that.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupt:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      tpm@2e {
>> +        compatible = "infineon,slb9673", "nuvoton,npct75x", "tcg,tpm-tis-i2c";
>> +        reg = <0x2e>;
>> +      };
>> +    };
>> +...
>> --
>> 2.31.1.windows.1
>>
>>

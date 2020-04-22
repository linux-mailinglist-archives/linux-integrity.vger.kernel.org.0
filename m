Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54F1B39C9
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2020 10:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgDVIP7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Apr 2020 04:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgDVIP7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Apr 2020 04:15:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4EC03C1A6;
        Wed, 22 Apr 2020 01:15:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so1273013wrx.4;
        Wed, 22 Apr 2020 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=W1bwVVy/NtLxRgnoJUy2zNxPLp+Z6h7qsHb9WOhUubo=;
        b=fEMC7jx1CLTOOK/5ySAQ9yyKtT2HbPV/yROeiAslCfHYmhzFoSmSvICfSP3N7z1/0C
         G5VAOfKlIm0cds8bHhPXuAd4v33j8AtQTNB6NmCrU8a+x1KsGlmRxbwxWB8itzYZm5bG
         6aO73LwdXbKtwIc4wJAwZHXC0jdGniNHJHJhYXvk84wOdG3RvGNDKQdry/v8CmCkFHgU
         PZQscstx/0LQJb3YnDiAQkcTTeisPBwvLaLTz6nxTOvRuCG7DP4JCd+Go0N2EZGELaXr
         H+f9hSZkviBHK/hB8uVVYgOblQNbX3HLgl3YQ36ocrKBf//ISRi5bwdulF8NQ+zJiueo
         kd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W1bwVVy/NtLxRgnoJUy2zNxPLp+Z6h7qsHb9WOhUubo=;
        b=AwovcF7OD+PP1vPA/BVkhmDB9bjgvXpW6HOGBXCeBjwBUfmvIV26gECyRLM4/62HRb
         5cgWgx/rerKPmXpmG5ieperfL0V3TyH+tJZn6fDCjloO4TK57R5bCRplgO9iRAOahefV
         D2S5+pro0xOMavIa9HvaZsQM15dI1k+HrxCzIRrsP9nuPCP3ZIMimLeWVeM1z8M5eWdB
         PNbSPK0D0BbNfRMLtUxL2PTEof4roFbI+Ns4zbsyaJBnwxkDkvnLQUoNN8T7keLGSGWA
         bVr4kHpFMOiztVeGk+PRBdXRVRstNYiq4JgHAv+tOtvx7ECtAq9cB8SXsJe92tmVdJkE
         0xXg==
X-Gm-Message-State: AGi0PubIkizTG1qAQqQWaBte5OxUo/arllrkctDQGqzVzWw31pxIMpAD
        wjn91uxVAYeHghZub/bxDFnuoOwpVq4=
X-Google-Smtp-Source: APiQypLNP3FKxLdejyFGmo/PZCFB4G9yydsMN1CISrxGbgYnQpBB7EGeKZnnv9vuQkhjVUwPsH/F/Q==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr26964145wrs.22.1587543357363;
        Wed, 22 Apr 2020 01:15:57 -0700 (PDT)
Received: from [192.168.43.138] ([37.142.175.196])
        by smtp.gmail.com with ESMTPSA id e5sm7154063wru.92.2020.04.22.01.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 01:15:56 -0700 (PDT)
Subject: Re: [PATCH v6 6/7] dt-bindings: tpm: Add YAML schema for TPM TIS I2C
 options
To:     Rob Herring <robh@kernel.org>
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
References: <20200407162044.168890-1-amirmizi6@gmail.com>
 <20200407162044.168890-7-amirmizi6@gmail.com> <20200415152056.GA30547@bogus>
From:   Amir Mizinski <amirmizi6@gmail.com>
Message-ID: <5142cad6-7d22-bc80-a743-e3c75f7a237b@gmail.com>
Date:   Wed, 22 Apr 2020 08:15:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415152056.GA30547@bogus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2020-04-15 15:20, Rob Herring wrote:
> On Tue, Apr 07, 2020 at 07:20:43PM +0300, amirmizi6@gmail.com wrote:
>> From: Amir Mizinski <amirmizi6@gmail.com>
>>
>> Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c
>> PTP based physical layer.
>>
>> This patch adds the documentation for corresponding device tree bindings of
>> I2C based Physical TPM.
>> Refer to the 'I2C Interface Definition' section in
>> 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
>> for specification.
>>
>> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
>> ---
>>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 47 ++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>> new file mode 100644
>> index 0000000..13d7c2c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: I2C PTP based TPM Device Tree Bindings
>> +
>> +maintainers:
>> +  - Amir Mizinski <amirmizi6@gmail.com>
>> +
>> +description:
>> +  Device Tree Bindings for I2C based Trusted Platform Module(TPM).
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>> +      const: tcg,tpm-tis-i2c
>
> This is not sufficient. I assume you are testing on some specific TPM
> chip.
>

I am, but this implementation follows the "TCG PC client Device Driver Design Principles for TPM 2.0"
It's not meant solely for out chip.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupt:
>> +    maxItems: 1
>> +
>> +  crc-checksum:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      CRC checksum enable.
>
> Why would you not want CRC? Some chips support and some don't? If so,
> the compatible for the chip should imply that.
>

There's an Enable/Disable CRC option in the TPM chip, not all vendors
use this by default.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      tpm-tis-i2c@2e {
>
> tpm@2e
>

I understand why i should remove "i2c", but i think it should be "tpm_tis@2e".
Respectively with "tpm_tis_spi.txt" and "tpm_tis_mmio.txt".

>> +        compatible = "tcg,tpm-tis-i2c";
>> +        reg = <0x2e>;
>> +        crc-checksum;
>> +      };
>> +    };
>> +...
>> --
>> 2.7.4
>>

Thank you for your feedback.
Best regards,
Amir Mizinski


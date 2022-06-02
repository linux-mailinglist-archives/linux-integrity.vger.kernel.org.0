Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E553BBA3
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jun 2022 17:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiFBPeN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jun 2022 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiFBPeM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jun 2022 11:34:12 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10CB6336;
        Thu,  2 Jun 2022 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654184052; x=1685720052;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NaptGli6AOoeUXxpOL2sqin3JfkzCT2Gc/mijZZ4Gfw=;
  b=fNvt1mJkvPC+GOTWDcr6ah+ZiwEsGNpTM+RlOGsUBUfIlzExUT+Rucvh
   D4cYiGbs87+E+rf7eYHNRGoQHb+ohmUr6rekMXUgmAezNZzqhjjwfoyh7
   eHsUpaong4I+nZmef8co0Ia+ZdwFXNggdgeITi7Fy4j8mPZetJG/UGpyG
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="299394977"
X-IronPort-AV: E=Sophos;i="5.91,271,1647298800"; 
   d="scan'208";a="299394977"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 17:34:09 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Thu,  2 Jun 2022 17:34:08 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 2 Jun 2022
 17:34:08 +0200
Received: from [10.165.68.85] (10.165.68.85) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 2 Jun 2022
 17:34:07 +0200
Message-ID: <aa5a8e73-b9b4-38e7-4f85-2bf309a346e0@infineon.com>
Date:   Thu, 2 Jun 2022 17:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/3] dt-bindings: trivial-devices: Add two I2C TPM
 devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
References: <20220525165849.7789-1-Alexander.Steffen@infineon.com>
 <20220525165849.7789-2-Alexander.Steffen@infineon.com>
 <8c4941a1-e047-1352-32ba-8595cd0143f0@linaro.org>
 <20220602134848.GA2178372-robh@kernel.org>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <20220602134848.GA2178372-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.165.68.85]
X-ClientProxiedBy: MUCSE807.infineon.com (172.23.29.33) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 02.06.22 15:48, Rob Herring wrote:
> On Thu, May 26, 2022 at 02:29:56PM +0200, Krzysztof Kozlowski wrote:
>> On 25/05/2022 18:58, Alexander Steffen wrote:
>>> Both are supported by the upcoming tpm_tis_i2c driver.
>>>
>>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>>> ---
>>>   Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> index 550a2e5c9e05..dc52822331dd 100644
>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> @@ -135,6 +135,8 @@ properties:
>>>             - infineon,slb9635tt
>>>               # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
>>>             - infineon,slb9645tt
>>> +            # Infineon SLB9673 I2C TPM 2.0
>>> +          - infineon,slb9673
>>>               # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>>>             - infineon,tlv493d-a1b6
>>>               # Infineon Multi-phase Digital VR Controller xdpe11280
>>> @@ -323,6 +325,8 @@ properties:
>>>             - st,24c256
>>>               # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
>>>             - taos,tsl2550
>>> +            # TCG TIS-compliant TPM with I2C interface
>>> +          - tcg,tpm_tis-i2c
>>
>> One flavor uses tpm-tis, another tpm_tis... I guess it is too late to
>> make it consistent, but let's stick to the one more reasonable, so:
>> "tpm-tis-i2c".
> 
> Neither should be used except perhaps as a fallback.

That is the intention, yes.

> Does 'TCG TIS-compliant TPM' encompass every property of a device? Power
> supplies, resets, interrupts, quirks, etc.?

In an ideal world, yes. In practice, of course implementations do have 
bugs that might require different workarounds. By selecting 
tcg,tpm-tis-i2c instead of anything more specific, you promise that the 
device is fully compliant to the TCG specification and does not require 
any such workarounds.

Alexander

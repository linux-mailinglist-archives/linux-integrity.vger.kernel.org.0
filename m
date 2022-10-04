Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328945F48C9
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Oct 2022 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJDRnZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJDRnU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 13:43:20 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C95A88D;
        Tue,  4 Oct 2022 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664905397; x=1696441397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WQP0E43uW/qE9I9p3SXtZSUDWWkKKHLlrTpf0C4DQMk=;
  b=WCQXz5vFj46G0jS+Ap3eualUgz6Otw8L83N37b4PE3MnKIsWo3Rnvm/B
   30lNvyMkK1ulwJwKHwMIn6IafNwFwfMEkoOBe7h9gqPCet3GcUmEAdyxM
   BbYUEPFqaub+jZOx/rWhAXSght5ltsWL69E1cDagKybV5lmhY7wKrInRx
   4=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="320203812"
X-IronPort-AV: E=Sophos;i="5.95,158,1661810400"; 
   d="scan'208";a="320203812"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 19:43:05 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Tue,  4 Oct 2022 19:43:02 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 19:43:02 +0200
Received: from [10.165.68.85] (10.165.68.85) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 19:43:02 +0200
Message-ID: <f0711dfe-89b8-d572-3581-b8629339d2e1@infineon.com>
Date:   Tue, 4 Oct 2022 19:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/7] dt-bindings: tpm: Add previously undocumented
 properties
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>, <Johannes.Holland@infineon.com>,
        <benoit.houyere@st.com>, <amirmizi6@gmail.com>, <peter@pjd.dev>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
 <20220930165116.13329-4-Alexander.Steffen@infineon.com>
 <CAL_Jsq+W=GdjdUhL4cxm6q7+YZ_Q0mizY5WLQvY3NHZVY+mFmA@mail.gmail.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <CAL_Jsq+W=GdjdUhL4cxm6q7+YZ_Q0mizY5WLQvY3NHZVY+mFmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 01.10.22 00:20, Rob Herring wrote:
> On Fri, Sep 30, 2022 at 12:02 PM Alexander Steffen
> <Alexander.Steffen@infineon.com> wrote:
>>
>> TPM devices may use some more properties than previously allowed by
>> trivial-devices.yaml. Document those in trivial-tpms.yaml.
>>
>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>> ---
>>   .../bindings/security/tpm/trivial-tpms.yaml      | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
> 
> Adding these here means we would need to duplicate them for any device
> with its own schema file. You need a common TPM property schema which
> the specific TPM device schemas can reference.

Good point, I'll create one.

>>
>> diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
>> index 2092341c6491..a9e2dd17b1ca 100644
>> --- a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
>> +++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
>> @@ -25,6 +25,22 @@ properties:
>>
>>     spi-max-frequency: true
>>
>> +  linux,sml-base:
>> +    $ref: /schemas/types.yaml#/definitions/uint64
>> +    description: |
>> +      64-bit base address of the reserved memory allocated for the firmware
>> +      event log
>> +
>> +  linux,sml-size:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: size of the memory allocated for the firmware event log
>> +
>> +  powered-while-suspended:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: |
>> +      Present when the TPM is left powered on between suspend and resume
>> +      (makes the suspend/resume callbacks do nothing).
>> +
>>     compatible:
>>       contains:
>>         enum:
>> --
>> 2.25.1
>>

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394E35F48AD
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Oct 2022 19:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJDRiy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJDRiW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 13:38:22 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8961EAFE;
        Tue,  4 Oct 2022 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664905084; x=1696441084;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=72aXgA624YeyJDYHSnM3qn5UPXihWf0Q70KOZ50mMoM=;
  b=U/kTifpWWfiVflwhImaLdGSjBwWUXWyO926Mw/q6KMZ1M2VT3KzCdbNx
   XH+MCGxOMEbncTKAe+hvJrZqBA7jFiy3Jwu3CH/BX744tsFFLdtWXCZ30
   PpXNjYdI79RDgOcHY3rFHISJeALKH84wC9MwpLKMLbYY3robXUoxA8kp8
   Q=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="143926153"
X-IronPort-AV: E=Sophos;i="5.95,158,1661810400"; 
   d="scan'208";a="143926153"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 19:38:02 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Tue,  4 Oct 2022 19:38:01 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 19:38:01 +0200
Received: from [10.165.68.85] (10.165.68.85) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 19:38:00 +0200
Message-ID: <ceacd00d-54ef-2d78-1902-59818464526e@infineon.com>
Date:   Tue, 4 Oct 2022 19:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH 4/7] dt-bindings: tpm: Merge existing trivial TPMs to YAML
To:     Rob Herring <robh@kernel.org>
CC:     <peter@pjd.dev>, <amirmizi6@gmail.com>, <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>, <robh+dt@kernel.org>,
        <Johannes.Holland@infineon.com>, <benoit.houyere@st.com>,
        <devicetree@vger.kernel.org>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
 <20220930165116.13329-5-Alexander.Steffen@infineon.com>
 <166457526212.1112376.3928552824383328065.robh@kernel.org>
Content-Language: en-US
In-Reply-To: <166457526212.1112376.3928552824383328065.robh@kernel.org>
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

On 01.10.22 00:05, Rob Herring wrote:
> On Fri, 30 Sep 2022 18:51:13 +0200, Alexander Steffen wrote:
>> Several of the existing text files describe trivial TPMs, that fit
>> perfectly into the new trivial-tpms.yaml. Move them there.
>>
>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>> ---
>>   .../bindings/security/tpm/google,cr50.txt     | 19 ----------
>>   .../bindings/security/tpm/tpm-i2c.txt         | 26 --------------
>>   .../bindings/security/tpm/tpm_tis_mmio.txt    | 25 -------------
>>   .../bindings/security/tpm/tpm_tis_spi.txt     | 23 ------------
>>   .../bindings/security/tpm/trivial-tpms.yaml   | 36 +++++++++++++++++++
>>   5 files changed, 36 insertions(+), 93 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
>>   delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>>   delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
>>   delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dts:20.11-21: Warning (reg_format): /example-0/tpm@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dts:42.11-24: Warning (reg_format): /example-1/tpm@57:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/security/tpm/trivial-tpms.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

Any idea what is wrong here with reg_format? I just copied the existing 
examples, so something was broken there before.

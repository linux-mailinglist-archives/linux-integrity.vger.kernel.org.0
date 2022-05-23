Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798BA530BC8
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiEWIzv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiEWIzu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 04:55:50 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB510CB;
        Mon, 23 May 2022 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1653296149; x=1684832149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pOGhokVmPswThiXe6z2Pzw7Gc9iJysqhiWv2XuLpcSY=;
  b=aAirLfyjJ3AFeOl7FEKd8xHh6uNAMhPatkXv73zTfLYSq7VByCSETsqf
   tcYFK6pVupcfyfO+2EwvOo927VuUnhUgENJwNn2iLsrtKBL+WD1h4rYsk
   86Jih7110Vbkwy2j4XcyBaYJyKSH9BWbkoicl3aGxNS5OOAI+IBUn5rWS
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="180078284"
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="180078284"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:55:46 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 23 May 2022 10:55:46 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 23 May
 2022 10:55:46 +0200
Received: from [10.165.68.85] (10.165.68.85) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 23 May
 2022 10:55:46 +0200
Message-ID: <8f0d2098-8c7f-2347-3004-bf3e422de3a3@infineon.com>
Date:   Mon, 23 May 2022 10:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
References: <20220520172422.4309-1-Alexander.Steffen@infineon.com>
 <20220520172422.4309-2-Alexander.Steffen@infineon.com>
 <02596f22-3d19-8872-75fd-2a8f563c8270@linaro.org>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <02596f22-3d19-8872-75fd-2a8f563c8270@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.165.68.85]
X-ClientProxiedBy: MUCSE820.infineon.com (172.23.29.46) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 22.05.22 10:30, Krzysztof Kozlowski wrote:
> On 20/05/2022 19:24, Alexander Steffen wrote:
>>
>> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id of_tis_i2c_match[] = {
>> +     { .compatible = "infineon,slb9673", },
>> +     { .compatible = "tcg,tpm_tis-i2c", },
> 
> Please run checkpatch on your patches. You add undocumented compatibles.

Sorry, the old infrastructure I had to do that automatically is not in 
place at the moment, so it slipped through.

> Without bindings, new compatibles and properties cannot be accepted, so NAK.

Could you be more specific as to what the correct solution is here? 
Usually, I'd just look at what the existing code does, but that is a 
little messy:



* socionext,synquacer-tpm-mmio is documented only in 
Documentation/devicetree/bindings/trivial-devices.yaml

* nuvoton,npct601 is documented in trivial-devices.yaml and is also 
mentioned in Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt

* nuvoton,npct650 is only mentioned in tpm-i2c.txt, but appears nowhere 
in the code

* infineon,tpm_i2c_infineon appears only in tpm_i2c_infineon.c, but is 
documented nowhere

* tpm_tis_spi_main.c has all its compatibles documented in 
tpm_tis_spi.txt, except google,cr50, which is documented in 
google,cr50.txt, even though it has the same properties

* tpm_tis_i2c_cr50.c uses the exact same google,cr50, even though that 
is explicitly documented as a device "on SPI Bus" and lists 
spi-max-frequency as one of its required properties, which does not make 
any sense for an I2C device

* According to the feedback in 
https://patchwork.kernel.org/project/linux-integrity/patch/20220404081835.495-4-johannes.holland@infineon.com/#24801807, 
the text format, that is currently used everywhere in 
Documentation/devicetree/bindings/security/tpm/, is deprecated anyway 
and should be replaced by YAML



So would you be okay with just adding the compatibles from tpm_tis_i2c.c 
to trivial-devices.yaml, so that checkpatch does not complain anymore, 
and leave the cleanup of the mess above for later?



Kind regards

Alexander

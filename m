Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48E3531476
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiEWQK2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiEWQK1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 12:10:27 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7AF6473C;
        Mon, 23 May 2022 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1653322225; x=1684858225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ys+ww2y4QlKOYHGmCP1IrTb7mc9uzAUXfcxwMWEz4q4=;
  b=Id9j+l8tN/7MCJXParHy8Ze0srdyBtTdQaqJmIER9X0URu0wxzU3y7el
   RJf3clcr8XlYndr05CUEWSp0ZNFBHPq7nnrAyw8Hz0FPyjUiXJHIYj9fa
   QkYtSm9FUG2zq8Geyd3qbuwzHI2fQKosO9vaNncbjFr+USyy/vd6Ux1YY
   Y=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="180193235"
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="180193235"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 18:10:22 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 23 May 2022 18:10:22 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 23 May
 2022 18:10:22 +0200
Received: from [10.165.68.85] (172.23.8.247) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 23 May
 2022 18:10:21 +0200
Message-ID: <9e509abb-b33a-1c33-c62e-7f9e799546b1@infineon.com>
Date:   Mon, 23 May 2022 18:10:03 +0200
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
 <8f0d2098-8c7f-2347-3004-bf3e422de3a3@infineon.com>
 <d4ab965c-d193-3b4b-9b88-95b8b2b40f80@linaro.org>
 <9d9e04e9-463a-bd43-b116-a9488f6e154e@linaro.org>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <9d9e04e9-463a-bd43-b116-a9488f6e154e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE823.infineon.com (172.23.29.54) To
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

On 23.05.22 11:44, Krzysztof Kozlowski wrote:
> On 23/05/2022 11:32, Krzysztof Kozlowski wrote:
>> On 23/05/2022 10:55, Alexander Steffen wrote:
>>> On 22.05.22 10:30, Krzysztof Kozlowski wrote:
>>>> Without bindings, new compatibles and properties cannot be accepted, so NAK.
>>>
>>> Could you be more specific as to what the correct solution is here?
>>> Usually, I'd just look at what the existing code does, but that is a
>>> little messy:
>>>
>>>
>>>
>>> * socionext,synquacer-tpm-mmio is documented only in
>>> Documentation/devicetree/bindings/trivial-devices.yaml
>>>
>>> * nuvoton,npct601 is documented in trivial-devices.yaml and is also
>>> mentioned in Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>>>
>>> * nuvoton,npct650 is only mentioned in tpm-i2c.txt, but appears nowhere
>>> in the code
>>>
>>> * infineon,tpm_i2c_infineon appears only in tpm_i2c_infineon.c, but is
>>> documented nowhere
>>>
>>> * tpm_tis_spi_main.c has all its compatibles documented in
>>> tpm_tis_spi.txt, except google,cr50, which is documented in
>>> google,cr50.txt, even though it has the same properties
>>>
>>> * tpm_tis_i2c_cr50.c uses the exact same google,cr50, even though that
>>> is explicitly documented as a device "on SPI Bus" and lists
>>> spi-max-frequency as one of its required properties, which does not make
>>> any sense for an I2C device
>>>
>>> * According to the feedback in
>>> https://patchwork.kernel.org/project/linux-integrity/patch/20220404081835.495-4-johannes.holland@infineon.com/#24801807,
>>> the text format, that is currently used everywhere in
>>> Documentation/devicetree/bindings/security/tpm/, is deprecated anyway
>>> and should be replaced by YAML
>>>
>>>
>>>
>>> So would you be okay with just adding the compatibles from tpm_tis_i2c.c
>>> to trivial-devices.yaml, so that checkpatch does not complain anymore,
>>> and leave the cleanup of the mess above for later?
> 
> To trivial-devices you should add only bindings of really trivial
> devices, which do not have any other properties, even when the bindings
> are finished. This means you describe fully the hardware and still have
> only reg+compatible.
> 
> If this device fits such case - no other hardware properties than reg -
> then, feel free to document it in trivial-devices. However I am not sure
> that TPM devices are that trivial... For example tpm-i2c.txt defines
> also interrupts and label.
> 
> If the device is not trivial, it should be documented in bindings,
> either dedicated or some existing ones.

Ok, let's see whether I understood that correctly:



I think, in general, TPMs are trivial devices: They sit on the I2C or 
SPI bus waiting for commands, but don't do much else. They might have 
TPM-specific properties, like whether they implement the 1.2 or 2.0 
command set, but we don't encode those in the device tree, since the 
driver tries to detect the available functionality dynamically (which 
makes sense, since some TPMs can be upgraded from 1.2 to 2.0, so that is 
not a static property of the device). Other properties, such as the 
maximum SPI frequency, are not TPM-specific, but apply to every SPI 
device and might be limited by either the SPI device itself or the SPI 
controller (or the user, wishing to run at lower frequencies, for 
whatever reason).



Looking at the code, there are some TPM-specific properties in use 
though: There is the powered-while-suspended flag, which only the TPM 
driver looks at (in drivers/char/tpm/eventlog/of.c). It is not specific 
to a single TPM (a single compatible string), but can be set for all the 
TPMs. Also, the linux,sml-* properties might be TPM-specific, though 
they get set in arch/powerpc/kernel/prom_init.c to communicate some 
information to the TPM driver. And there is lpcpd-gpios, which is only 
used by st33zp24.



Now the purpose of trivial-devices.yaml is to specify a schema of valid 
device definitions. It only allows the properties reg, interrupts and 
spi-max-frequency in addition to the compatible strings. So, strictly 
speaking, none of the TPMs should be listed there, since all the TPMs 
can, in theory, use the powered-while-suspended flag, which is not 
allowed by the schema. With other properties the schema does not seem to 
be too strict, since it applies to both I2C and SPI devices, but allows 
the spi-max-frequency property, even though that does not make sense for 
I2C devices.



So the correct solution could be this: Replace all the text files in 
Documentation/devicetree/bindings/security/tpm/ with a single 
trivial-tpms.yaml (similar to trivial-devices.yaml) and also move all 
the TPMs from trivial-devices.yaml there. This allows to properly 
document the powered-while-suspended flag and other generic TPM 
properties. st33zp24 should get its own YAML, to document lpcpd-gpios, 
that is only used by this driver. I'm not quite sure what to do with 
ibmvtpm.txt, since that seems to document several properties, that are 
not referenced in the TPM driver at all but instead get used by some 
scsi driver (e.g. ibm,loc-code), so I'd probably ignore it for now. What 
do you think?



As for tpm_tis_i2c, if there are no other objections to its current 
state, I'd add its compatible strings to trivial-devices.yaml for now, 
then do the cleanup as described above later. It does not make the code 
more wrong, since trivial-devices.yaml already contains some TPM 
devices, that are very similar to what tpm_tis_i2c now supports (i.e. 
that also don't have special properties), but allows for more time to do 
the cleanup properly, without holding up tpm_tis_i2c.



Kind regards

Alexander

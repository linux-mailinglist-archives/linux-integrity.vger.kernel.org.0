Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1951FD40
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiEIMvu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 08:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiEIMvq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 08:51:46 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05D2A1FD8;
        Mon,  9 May 2022 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1652100473; x=1683636473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGC/Jxk5wtyvy6vNWf7S1XzQjNkoQDadcKmWQ7WC7VI=;
  b=RKpEqJL4ppYlyrGP7SBlhas7PCUK7Yop7K6+OQLUaYGATNFnYko5f1Bl
   2Gxie6YCQwGeaDK7WOmGi4L8q+H8Y0GfYgStIP3byac5h/ETIcE6z6/WO
   IOeWNPhCEgcRhu41GYruey32yHbpbrBdTNjbgIY39zSln2xp+M9/XK+Rt
   4=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="119780255"
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="119780255"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:47:51 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Mon,  9 May 2022 14:47:50 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 14:47:49 +0200
Received: from smaha-lin-dev01.agb.infineon.com (172.23.8.247) by
 MUCSE818.infineon.com (172.23.29.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 14:47:49 +0200
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
To:     <jarkko@kernel.org>
CC:     <Marten.Lindahl@axis.com>, <jgg@ziepe.ca>,
        <johannes.holland@infineon.com>, <jsnitsel@redhat.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martenli@axis.com>, <nayna@linux.vnet.ibm.com>,
        <peterhuewe@gmx.de>, <stefan.mahnke-hartmann@infineon.com>
Subject: Re: [PATCH 2/2] tpm: Add Field Upgrade mode support for Infineon TPM2 modules
Date:   Mon, 9 May 2022 14:50:18 +0200
Message-ID: <20220509125018.246093-1-stefan.mahnke-hartmann@infineon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YnbL9LwDkY+MHdkK@iki.fi>
References: <YnbL9LwDkY+MHdkK@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE824.infineon.com (172.23.29.55) To
 MUCSE818.infineon.com (172.23.29.44)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 07.05.22 21:43, Jarkko Sakkinen wrote:
> On Fri, May 06, 2022 at 02:31:48PM +0200, Stefan Mahnke-Hartmann wrote:
>> TPM2_GetCapability with a capability that has the property type value
>> of TPM_PT_TOTAL_COMMANDS returns a zero length list, when an Infineon
>> TPM2 is in Field Upgrade mode.
>> Since an Infineon TPM2.0 in Field Upgrade mode returns RC_SUCCESS on
>> TPM2_Startup, the Field Upgrade mode has to be detected by
>> TPM2_GetCapability.
>>
>> Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
>> ---
>>  drivers/char/tpm/tpm2-cmd.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index e62a644ce26b..659130e2936e 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -746,6 +746,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>>  	}
>>  
>>  	rc = tpm2_get_cc_attrs_tbl(chip);
>> +	/*
>> +	 * Infineon TPM in Field Upgrade mode will return no data for the number
>> +	 * of supported commands.
>> +	 */
>> +	if (rc == -ENODATA)
>> +		rc = TPM2_RC_UPGRADE;
>
> Injecting hardware error codes like this is not considered a great idea.

Resetting the error code was to avoid code duplication, while following the
same rationale as Mårten's patch. I can also add the -ENODATA to the if clause
below or duplicate the code block (similar to Mårten's). Do you have a better
suggestion?

>
>>  
>>  out:
>>  	if (rc == TPM2_RC_UPGRADE) {
>> -- 
>> 2.25.1
>>
>
> BR, Jarkko


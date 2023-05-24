Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F070F182
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbjEXIyU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 04:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjEXIyT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 04:54:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2D97;
        Wed, 24 May 2023 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684918458; x=1716454458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mIPqB3dS2BljD1xI/lGZZsZ1WRQyw61gfkD4Ji8kZZc=;
  b=FQ7SEIFX+CLlRUzszhJsU8KMgy5IYLgaiE3iMEDIA0Wj5sWooLFEovu+
   mLy0mO3oAcZ4prxIGmIGJVaT2WiQ+NRlHOUCUQPAvMDxmkmiA8QXwH8rL
   3hS2zVN4J0lvHoiuEgp1umjcszA72w/Ond9muPD3jPmoCQFs/UqRsmv/R
   ZV7BGWoqTOwC3ITrMRlyRxGXxqiDuIS74xnoV1GdaiSrANJM39r8ORpF5
   rHm1zzSZ5mwbxNB8h6xhRK/U7TVvRsxKYNqfp3B6a+SQWXJsq5WF4jMqD
   EGw5NT3V3IbFLsOC9CvJ3AIFxImseWkmZ/t5qB2cH2nNFb3r6hS95t0lB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342965558"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="342965558"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 01:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="737213677"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="737213677"
Received: from mhakkine-mobl4.ger.corp.intel.com (HELO [10.252.53.214]) ([10.252.53.214])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 01:54:16 -0700
Message-ID: <9bb5c5cd-e9e7-5390-7bd7-fac882aaa0d0@linux.intel.com>
Date:   Wed, 24 May 2023 11:55:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] tpm: tpm_tis: Narrow the AAEON DMI quirk to UPX-i11 only
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, jsnitsel@redhat.com
References: <20230524055815.10165-1-peter.ujfalusi@linux.intel.com>
 <a1030692-e80f-a785-2e90-238d5f00a181@molgen.mpg.de>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <a1030692-e80f-a785-2e90-238d5f00a181@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Paul,

On 24/05/2023 11:43, Paul Menzel wrote:
> Dear Peter,
> 
> 
> Thank you for your patch.
> 
> Am 24.05.23 um 07:58 schrieb Peter Ujfalusi:
>> The original patch which added the quirk would apply to all AAEON
>> machines,
>> which might or might not be valid.
>>
>> The issue was discovered on UPX-i11 (TigerLake), it is not known if the
>> i12 (AlderLake) version is affected.
>> UP2 (ApolloLake) does not even have TMP module (no TPM drivers probing
> 
> s/TMP/TPM/

I will fix it in v2.

> 
>> and confirmed by dmidecode).
> 
> Another nit, the official spelling of the SOC names is with a space, for
> example, Tiger Lake [1].

I will correct this and the ADL, APL spelling also.

> 
>> Let's make the quirk to be applicable for UPX-i11 (UPX-TGL01) only.
>>
>> Fixes: 95a9359ee22f ("tpm: tpm_tis: Disable interrupts for AEON UPX-i11")
>> Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> ---
>> Hi Jarkko,
>>
>> the patch is generated on top of your
>> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git :
>> irq-storm
>>
>> Regards,
>> Peter
>>
>>   drivers/char/tpm/tpm_tis.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
>> index 7db3593941ea..4357d4ba8f9e 100644
>> --- a/drivers/char/tpm/tpm_tis.c
>> +++ b/drivers/char/tpm/tpm_tis.c
>> @@ -143,6 +143,7 @@ static const struct dmi_system_id
>> tpm_tis_dmi_table[] = {
>>           .ident = "UPX-TGL",
>>           .matches = {
>>               DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
>> +            DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
>>           },
>>       },
>>       {}
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

And I will pick your tag as well to v2,

Thank you for the review and comments!

-- 
Péter

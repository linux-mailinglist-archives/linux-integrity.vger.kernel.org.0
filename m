Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7FD70896E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 May 2023 22:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjERUX2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 May 2023 16:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjERUX1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 May 2023 16:23:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A817130;
        Thu, 18 May 2023 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684441406; x=1715977406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ybjj05zy7xSUH4PUjMHoDZVpWTZZESgAwZFWIP9wSvg=;
  b=Yg8sf6/MLUrt7o7pn8t4iHx/QaJThJNO3csYy/J67K0iw19dIXh3lAdl
   5UfsgFCRWFek4Y3G3wI1RnRwbCwVkn92IS1tl/iHaSEkk6LrMlp+SfhVl
   8VaE0zLU+tfNtYdKvXHfIO7csf2DWbzLdkhJMpe+aFXElz/0WkpZaH45x
   i9lQSYO/l9xQDHC32y0tMFGqUeLdQOqfPwi/vGLu5CypkNgcsJaC+fmps
   sh4B1Q3Le6D6sfgLpT+ThLo0UPGbdqZEfmiX90+cKn1HjwHYu2eVplneZ
   t2d3yDnQiFvoSmwROr91x4dRqG3xr03yvkjDWEouykofiy5YOs0hnaaTU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355402892"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="355402892"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 13:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="652801626"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="652801626"
Received: from ibanaga-mobl.ger.corp.intel.com (HELO [10.252.50.207]) ([10.252.50.207])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 13:23:22 -0700
Message-ID: <432df3cf-da16-1f2a-02dc-e2c371c1f29c@linux.intel.com>
Date:   Thu, 18 May 2023 23:24:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON
 UPX-i11
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com
References: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
 <ohdpul6hax5bj5hhsnpt7i3ejbttivufmoolzunbhipexjkczi@meg3zx2yqkc7>
 <CSPMQ03V3G7G.EBWKDRE4B0XY@suppilovahvero>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <CSPMQ03V3G7G.EBWKDRE4B0XY@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 18/05/2023 21:53, Jarkko Sakkinen wrote:
> On Thu May 18, 2023 at 9:50 PM EEST, Jerry Snitselaar wrote:
>> On Wed, May 17, 2023 at 03:29:31PM +0300, Peter Ujfalusi wrote:
>>> The interrupts initially works on the device but they will stop arriving
>>> after about 200 interrupts.
>>>
>>> On system reboot/shutdown this will cause a long wait (120000 jiffies).
>>>
>>> The interrupts on this device got enabled by commit
>>> e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
>>>
>>> Prior to this point the interrupts were not enabled on this machine.
>>>
>>> Complements: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>> ---
>>> Hi,
>>>
>>> This patch applies on top of mainline since 6.4-rc1 takes about 2 minutes to
>>> reboot on this machine, linux-next have
>>> e7d3e5c4b1dd tpm/tpm_tis: Disable interrupts for more Lenovo devices
>>>
>>> I'm not sure if I shouold send this on top of next or mainline is fine, please
>>> let me know the preferred way to get this to 6.4.
>>>
>>> Regards,
>>> Peter
>>>
>>>  drivers/char/tpm/tpm_tis.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
>>> index 7af389806643..aad682c2ab21 100644
>>> --- a/drivers/char/tpm/tpm_tis.c
>>> +++ b/drivers/char/tpm/tpm_tis.c
>>> @@ -122,6 +122,13 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>>>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
>>>  		},
>>>  	},
>>> +	{
>>> +		.callback = tpm_tis_disable_irq,
>>> +		.ident = "UPX-TGL",
>>
>> Is this the product version returned by dmidecode? If yes,
>> then the entry could be made more specific by adding a
>> DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"), and only disable
>> for this device instead of any system that matches the vendor
>> AAEON.

The version is used to differentiate the revisions of the UPX-i11
boards, and this issue present in all revisions.

> I can squash this to the commit I pushed (it is not yet mirrored
> to linux-next), if I get the dmidecode info.

System Information
        Manufacturer: AAEON
        Product Name: UPX-TGL01
        Version: V1.0
        Serial Number: Default string
        UUID: a300091d-fb1c-ce1c-1d30-0007328efc11
        Wake-up Type: Power Switch
        SKU Number: Default string
        Family: Default string

I have used this description as it it is used for SOF, probably
DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
should be added?

Oh, yes, the product name match should be there, we have TigerLake
specific matching, so SOF is looking for AAEON device with TGL.

Sorry for missing this.

> 
> BR, Jarkko

-- 
Péter

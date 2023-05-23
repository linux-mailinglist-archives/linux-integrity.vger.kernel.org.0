Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34970D88F
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjEWJNo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjEWJNm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 05:13:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4539294;
        Tue, 23 May 2023 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684833214; x=1716369214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tG8tyz16iPziryCvAdBKNZ60+DgIUiN6eZydjnc0lAM=;
  b=mA1I47F3RtHCEZ8laY3U3UoVCnQgG1UWLk2ichTMD8VQfaazD7L3gIJ2
   FQGcOUCDU40v1ZdozpoNOT7MfNy3X2XEioTW2QfnZuVCrFWSbI0aQRMUK
   v95ZPK62p1i8bqrzvFoqR/hjN3hbebP92lCG/fNfz7Khym0fkB1DFTuEl
   truRh+ZpJc0rBoPdjayifGcuq0bATjOsDNVWntdCKP8sSsl40n8lc5Kf9
   lftqcuoBqZE09SPPUdT3KT7WWKUU9bjgNLTUN9IQO7aMtu7ARdoxE1QPy
   1KI0Rrz/2J+hrr9iC0OVvumcBzW6e8h/TOpJ0akmDUrVlgLyHyNEKEdSm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350692717"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="350692717"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="816047490"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="816047490"
Received: from nmkenne1-mobl2.ger.corp.intel.com (HELO [10.252.53.154]) ([10.252.53.154])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:13:29 -0700
Message-ID: <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
Date:   Tue, 23 May 2023 12:14:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
 <20230523074443.GA21236@wunner.de>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230523074443.GA21236@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 23/05/2023 10:44, Lukas Wunner wrote:
> On Tue, May 23, 2023 at 09:48:23AM +0300, Péter Ujfalusi wrote:
>> On 22/05/2023 17:31, Lino Sanfilippo wrote:
> [...]
>> This looked promising, however it looks like the UPX-i11 needs the DMI
>> quirk.
> 
> Why is that?  Is there a fundamental problem with the patch or is it
> a specific issue with that device?

The flood is not detected (if there is a flood at all), interrupt stops
working after about 200 interrupts - in the latest boot at 118th.
I can check this later, likely tomorrow.

>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>> @@ -752,6 +752,55 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>>>  	return status == TPM_STS_COMMAND_READY;
>>>  }
>>>  
>>> +static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
>>> +{
>>> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>> +	int intmask = 0;
>>> +
>>> +	dev_err(&chip->dev, HW_ERR
>>> +		"TPM interrupt storm detected, polling instead\n");
>>
>> Should this be dev_warn or even dev_info level?
> 
> The corresponding message emitted in tpm_tis_core_init() for
> an interrupt that's *never* asserted uses dev_err(), so using
> dev_err() here as well serves consistency:
> 
> 	dev_err(&chip->dev, FW_BUG
> 		"TPM interrupt not working, polling instead\n");
> 
> That way the same severity is used both for the never asserted and
> the never deasserted interrupt case.

Oh, OK.
Is there anything the user can do to have a ERROR less boot?

> 
>>> +	if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
>>> +		tpm_tis_handle_irq_storm(chip);
>>
>> Will the kernel step in and disbale the IRQ before we would have
>> detected the storm?
> 
> No.  The detection of spurious interrupts in note_interrupt()
> hinges on handlers returning IRQ_NONE.  And this patch makes
> tis_int_handler() always return IRQ_HANDLED, thus pretending
> success to genirq code.

True, thanks!

> 
>>>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
>>>  	tpm_tis_relinquish_locality(chip, 0);
>>>  	if (rc < 0)
>>> -		return IRQ_NONE;
>>> +		goto unhandled;
>>
>> This is more like an error than just unhandled IRQ. Yes, it was ignored,
>> probably because it is common?
> 
> The interrupt may be shared and then it's not an error.

but this is tpm_tis_write32() failing, no? If it is shared interrupt and
we return IRQ_HANDLED unconditionally then I think the core will think
that the interrupt was for this device and it was handled.

-- 
Péter

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251EC70D47F
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjEWHGv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 03:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjEWHGv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 03:06:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96A1118;
        Tue, 23 May 2023 00:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684825592; x=1716361592;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=fR8HB2n9ezHVRM9B2hodfzVRG1PK2D+2ABIDICohet0=;
  b=O5/qU42yvHctTfsTe19J5VVx0FZqmd1SL8jFbtqFoekXS6KVcOSQ3oQW
   LroCBsKAQAPP15OLJ1dVfug62j4EF11oa1yjTwqmPKxxYp5ZaHS26WcUT
   7gN3zcchDrZ3coxOJHisx12Dx4HKfDsvth24NgzBP576Gzm62W4I/4BmJ
   mbP1GPq6e2aPwjZotGQxJ1A1CppLxoMHmIdrQvvJ2T3AEMK63il1jf9JF
   3jvxmjnSLV/rX//oP7ejNmHLmLzCDOIQwOXvFMuDBsP0KF7cX2x7NP1hO
   5WWCKz6FHG55S2j08YF+NRyLDahzXpWQy2PvQiVDlRHULRZjWfit+aCBU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="353181834"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="353181834"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 00:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697946091"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="697946091"
Received: from nmkenne1-mobl2.ger.corp.intel.com (HELO [10.252.53.154]) ([10.252.53.154])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 00:06:28 -0700
Message-ID: <058e2e0f-70b4-a506-3ada-2578b99e9163@linux.intel.com>
Date:   Tue, 23 May 2023 10:07:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
In-Reply-To: <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
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



On 23/05/2023 09:48, Péter Ujfalusi wrote:
>>  static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>> @@ -804,6 +857,15 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>>  		chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>>  }
>>  
>> +static void tpm_tis_free_irq_func(struct work_struct *work)
>> +{
>> +	struct tpm_tis_data *priv = container_of(work, typeof(*priv), free_irq_work);
>> +	struct tpm_chip *chip = priv->chip;
>> +
>> +	devm_free_irq(chip->dev.parent, priv->irq, chip);
>> +	priv->irq = 0;
> 
> Should disable_interrupts() be called instead (with the locality
> request/relinquish)?
> 
> Is there a chance of a race or is a race matters?

Nevermind this comment, it is good.

-- 
Péter

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5445C5521B3
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jun 2022 17:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiFTP5g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jun 2022 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiFTP5f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jun 2022 11:57:35 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5812F1DA5F;
        Mon, 20 Jun 2022 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1655740655; x=1687276655;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=K+H7Adg+FLJFWop8Zu77ezGAoHaOLh8NVnvvfeYqE24=;
  b=bq90l67wimizzMMCMF77t/epfkOo33v7Oge9zQ4LRXAsDP5h+Tm+0tSU
   Ehcp/FkKLhQu5yy7OLB8WvEm8S1pJs1eMnsjGDxdSaRvtEvVA1RWU2PDD
   UWQEkmETMEWkglDELJVQyVGalhEnk1KgrwffZHu3OTWQiSRWqFSR7Udcw
   s=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="301927446"
X-IronPort-AV: E=Sophos;i="5.92,207,1650924000"; 
   d="scan'208";a="301927446"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 17:57:33 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 20 Jun 2022 17:57:32 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 20 Jun
 2022 17:57:32 +0200
Received: from [10.165.68.86] (10.165.68.86) by MUCSE818.infineon.com
 (172.23.29.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 20 Jun
 2022 17:57:31 +0200
Message-ID: <058f32a4-58f4-6748-92cd-ce21b27e02fb@infineon.com>
Date:   Mon, 20 Jun 2022 17:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: <stefan.mahnke-hartmann@infineon.com>
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
CC:     Johannes Holland <johannes.holland@infineon.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <stefan.mahnke-hartmann@infineon.com>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
 <YnvTSqRgYkWu0qgp@kernel.org>
 <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
 <YoKPxMLuWWK2al9F@kernel.org>
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Organization: Infineon Technologies AG
In-Reply-To: <YoKPxMLuWWK2al9F@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.165.68.86]
X-ClientProxiedBy: MUCSE807.infineon.com (172.23.29.33) To
 MUCSE818.infineon.com (172.23.29.44)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 16.05.22 19:54, Jarkko Sakkinen wrote:
> On Thu, May 12, 2022 at 08:21:17AM -0400, Mimi Zohar wrote:
>> On Wed, 2022-05-11 at 18:16 +0300, Jarkko Sakkinen wrote:
>>> On Tue, May 10, 2022 at 01:29:03PM +0200, Johannes Holland wrote:
>>>> To comply with protocol requirements, minimum polling times must often
>>>> be adhered to. Therefore, a macro like tpm_msleep() should sleep at
>>>> least the given amount of time (not up to the given period). Have
>>>> tpm_msleep() sleep at least the given number of milliseconds.
>>>>
>>>> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
>>>> ---
>>>>  drivers/char/tpm/tpm.h | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>>> index 2163c6ee0d36..0971b55fffe3 100644
>>>> --- a/drivers/char/tpm/tpm.h
>>>> +++ b/drivers/char/tpm/tpm.h
>>>> @@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
>>>>  
>>>>  static inline void tpm_msleep(unsigned int delay_msec)
>>>>  {
>>>> -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
>>>> -		     delay_msec * 1000);
>>>> +	usleep_range(delay_msec * 1000, (delay_msec * 1000)
>>>> +		     + TPM_TIMEOUT_RANGE_US);
>>>>  };
>>>>  
>>>>  int tpm_chip_start(struct tpm_chip *chip);
>>>> -- 
>>>> 2.34.1
>>>>
>>> For this I would really like to hear a 2nd opinion from Nayna and Mimi.
>> This patch reverts commit 5ef924d9e2e8 ("tpm: use tpm_msleep() value as
>> max delay").    Are you experiencing TPM issues that require it?
>>
>> thanks,
>>
>> Mimi
> Yeah, there's no data to support making anything.  Without a live
> system having issues with this, I guess this quite definitive NAK.
>
> BR, Jarkko
>
Either way, a static range is not perfect. So I would suggest,to have the
values (TPM_TIMEOUT_RANGE_US, TPM_TIMEOUT_POLL) settable, to give the
possibility to adjust the polling timing vendor specific. Furthermore,
increasing the polling delay as a function of time would limit the number
of attempts, especially for long-running commands.

BR, Stefan

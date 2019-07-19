Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871DA6E1FD
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2019 09:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfGSHxE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jul 2019 03:53:04 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:36958 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGSHxD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jul 2019 03:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563522783; x=1595058783;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BaotlTA2NBlahqpI/xNk06ZF6EFXlbFvxNxlEaOYv3I=;
  b=NW2E7/KonPKdZsSDPM33Wz4QMWO7DOULATBPHoEU/phjfznjhqUDbZJC
   oBtmhSo0RM5gilzTllt38jW0p4Zg+ize4Z7S7hdnMOWFECby+BbkD6iyq
   RF10yda0Q/HG+Jx5+S6J7Kz4dxeb3HSwWLQcQZsfc2aHRWmhTMlCbODeS
   0=;
IronPort-SDR: EUrGX2wWKQ/jsD6QaFjItLlZXsyjMiAkXIokJaWNBTIxi/WlDsd9ysNzfZVQyKpxqFtQXyuIgI
 pdgn8Pzz+TqzY/bQe209+GR87Pc9YaUtFdfRW1Yao71VIBYsh+UMwfGynHzvwHRM+J+Ej3kcsN
 n/wn7sAjBykMZmFmlhXbgKJkVcTFv1rb2dLyqnh9yMXcjVmgnYTPeAOZOhvCu+u7oFeLdFb1KV
 omnpG0K8fJtDP1hRM9yDrlrbxTHa/StY5xZFn18mI2ARNgZfSjH9UAR0Vx80lrvZVKeUB2hKBe
 9Ww=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9322"; a="128311121"
X-IronPort-AV: E=Sophos;i="5.64,281,1559512800"; 
   d="scan'208";a="128311121"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 09:53:02 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 19 Jul 2019 09:53:01 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Fri, 19
 Jul 2019 09:53:01 +0200
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Stephen Boyd <swboyd@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
CC:     Andrey Pronin <apronin@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
 <5d2f955d.1c69fb81.35877.7018@mx.google.com>
 <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com>
 <5d30b649.1c69fb81.f440e.9a0a@mx.google.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <1bb8d417-3199-7aff-ad60-b25464502cb3@infineon.com>
Date:   Fri, 19 Jul 2019 09:53:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d30b649.1c69fb81.f440e.9a0a@mx.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE706.infineon.com (172.23.7.80) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 18.07.2019 20:11, Stephen Boyd wrote:
> Quoting Alexander Steffen (2019-07-18 09:47:22)
>> On 17.07.2019 23:38, Stephen Boyd wrote:
>>> Quoting Stephen Boyd (2019-07-17 12:57:34)
>>>> Quoting Alexander Steffen (2019-07-17 05:00:06)
>>>>>
>>>>> Can't the code be shared more explicitly, e.g. by cr50_spi wrapping
>>>>> tpm_tis_spi, so that it can intercept the calls, execute the additional
>>>>> actions (like waking up the device), but then let tpm_tis_spi do the
>>>>> common work?
>>>>>
>>>>
>>>> I suppose the read{16,32} and write32 functions could be reused. I'm not
>>>> sure how great it will be if we combine these two drivers, but I can
>>>> give it a try today and see how it looks.
>>>>
>>>
>>> Here's the patch. I haven't tested it besides compile testing.
> 
> The code seems to work but I haven't done any extensive testing besides
> making sure that the TPM responds to pcr reads and some commands like
> reading random numbers.
> 
>>
>> Thanks for providing this. Makes it much easier to see what the actual
>> differences between the devices are.
>>
>> Do we have a general policy on how to support devices that are very
>> similar but need special handling in some places? Not duplicating the
>> whole driver just to change a few things definitely seems like an
>> improvement (and has already been done in the past, as with
>> TPM_TIS_ITPM_WORKAROUND). But should all the code just be added to
>> tpm_tis_spi.c? Or is there some way to keep a clearer separation,
>> especially when (in the future) we have multiple devices that all have
>> their own set of deviations from the spec?
>>
> 
> If you have any ideas on how to do it please let me know. At this point,
> I'd prefer if the maintainers could provide direction on what they want.

Sure, I'd expect Jarkko will say something once he's back from vacation.

Alexander

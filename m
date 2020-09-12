Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177B6267894
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgILHhN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 03:37:13 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:55609 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbgILHhM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 03:37:12 -0400
Received: from [192.168.0.2] (ip5f5af00b.dynamic.kabel-deutschland.de [95.90.240.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C4AF0206462B7;
        Sat, 12 Sep 2020 09:37:09 +0200 (CEST)
Subject: Re: [Bug Report] Kernel 4.14+ TPM Driver Bug for Atmel TPM Chip
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Hao Wu <hao.wu@rubrik.com>, linux-integrity@vger.kernel.org,
        Hamza Attak <hamza@hpe.com>
References: <9173F912-F682-44CC-8408-565A6C675749@rubrik.com>
 <20200911041800.GA541925@kroah.com>
 <5518aa6e-a10f-9e07-e885-2ab43a0906e9@linux.ibm.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d9fc244f-f8ac-64cf-2b8f-0b13685fe6be@molgen.mpg.de>
Date:   Sat, 12 Sep 2020 09:37:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5518aa6e-a10f-9e07-e885-2ab43a0906e9@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Ken,


Any reason you stripped the CC list? Adding back Hao Wu and adding the 
patch author.

Am 11.09.20 um 21:35 schrieb Ken Goldman:
> On 9/11/2020 12:18 AM, Greg KH wrote:
>> Thus the TPM get queried more frequently than before, which is likely 
>> the root cause of the atmel chip crash. We fix it by bumping up the 
>> TPM_TIMEOUT to 15ms.
>>
>>
>> Rubrik Patch
>> ```
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 72d3ce4..9b8f3f8 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -49,7 +49,15 @@ enum tpm_const {
>>   };
>>
>>   enum tpm_timeout {
>> -       TPM_TIMEOUT = 5,        /* msecs */
>> +       TPM_TIMEOUT = 15,       /* msecs */
>>          TPM_TIMEOUT_RETRY = 100, /* msecs */
>>          TPM_TIMEOUT_RANGE_US = 300      /* usecs */
>>   };
>> ```
>> With the patch, the atmel TPM chip crash is fixed.
>>
>> Proposal
>> We want the kernel upstream to adopt the fix or have a better fix for 
>> the atmel chip while not bring performance regression for other TPM 
>> chips. We understand 
>> that https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3
>> was intended to shorten the TPM
> 
> Is this the poll time, which was reduced at one point?  If so ...

The commit summary is: tpm: replace msleep() with  usleep_range() in TPM 
1.2/2.0 generic drivers.

> Be careful about making this a global change.  It could reduce the TPM 
> performance by 3x. We don't want to affect all TPMs to fix a bug in an 
> old TPM 1.2 chip from one vendor.

Linux has a no regression policy, so the performance penalty wouldn’t 
matter. Unfortunately, the regression was only noticed several years 
after being introduced in Linux v4.14-rc2.

Hao, I wouldn’t expect a longer timeout causing the TPM to be queried 
less frequently, but I do not know the code well.


Kind regards,

Paul

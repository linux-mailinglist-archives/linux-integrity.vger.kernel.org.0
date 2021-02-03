Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4718030E16A
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhBCRsi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 12:48:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53822 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBCRsf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 12:48:35 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 60A2620B7192;
        Wed,  3 Feb 2021 09:47:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60A2620B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612374474;
        bh=ccdnldXd7ffStD/bkTdf0JjvxcE1PixsU1LgmFGE+AQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ajqWrUw9CR8dAwPmXY6LCKNUEia6bR5EjopHsReroJkEk/G8oj/LNYo6yVlhZHRPT
         gifIXM2rLnviz18/bU47RYoODn6g6eAz/ehhd+XdLDkL4/Db9ETaET7WsCMd4Jm0IR
         qbpqJGZRQppoEWCB6hHj8+tqyW4Ca58BYHrUL/GM=
Subject: Re: [PATCH 1/2] ima: Free IMA measurement buffer on error
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, gregkh@linuxfoundation.org,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210121173003.18324-1-nramas@linux.microsoft.com>
 <87eeic1u6b.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <918ff442-2a0d-0e5b-4e95-c47dafc11382@linux.microsoft.com>
Date:   Wed, 3 Feb 2021 09:47:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87eeic1u6b.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/22/21 2:30 PM, Thiago Jung Bauermann wrote:
> 
> Hi Lakshmi,
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> IMA allocates kernel virtual memory to carry forward the measurement
>> list, from the current kernel to the next kernel on kexec system call,
>> in ima_add_kexec_buffer() function.  In error code paths this memory
>> is not freed resulting in memory leak.
>>
>> Free the memory allocated for the IMA measurement list in
>> the error code paths in ima_add_kexec_buffer() function.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
>> ---
>>   security/integrity/ima/ima_kexec.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 121de3e04af2..212145008a01 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -119,12 +119,14 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	ret = kexec_add_buffer(&kbuf);
>>   	if (ret) {
>>   		pr_err("Error passing over kexec measurement buffer.\n");
>> +		vfree(kexec_buffer);
>>   		return;
>>   	}
> 
> This is a good catch.

Thanks.

> 
>>   
>>   	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
>>   	if (ret) {
>>   		pr_err("Error passing over kexec measurement buffer.\n");
>> +		vfree(kexec_buffer);
>>   		return;
>>   	}
> 
> But this would cause problems, because the buffer is still there in the
> kimage and would cause kimage_load_segment() to access invalid memory.
> 
> There's no function to undo a kexec_add_buffer() to avoid this problem,
> so I'd suggest just accepting the leak in this case. Fortunately, the
> current implementations of arch_ima_add_kexec_buffer() are very simple
> and cannot fail, so this is a theoretical problem.
> 

Agreed. I'll post a new patch with the above change removed.

thanks,
  -lakshmi


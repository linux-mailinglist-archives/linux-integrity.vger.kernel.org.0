Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E548B751165
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jul 2023 21:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjGLTjk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jul 2023 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGLTjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jul 2023 15:39:40 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E90C31FC7
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jul 2023 12:39:38 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3BF5221C44E3;
        Wed, 12 Jul 2023 12:39:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BF5221C44E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689190778;
        bh=ejHvuhi9pcpP1A/ico7WTH2llnMHDBUFt6eYXEXSrZs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g63x7OksBugGZW5IoHkQL3n4Ssn/2rVIAZ/cAJBR01rYWK4kXZ8dr2krMs1EdBAjl
         ENUOIzrBM6iCrWAmBwXFBkcV+N0mNwaLSfWxtk03LatROQ3XWaR8hPTu9f19CIg6PV
         a7FCHvo9RWisJWYrr9zSsjGSaZ7iGn/o7He8pPec=
Message-ID: <105faa02-4008-5143-0ee3-8417e1411e54@linux.microsoft.com>
Date:   Wed, 12 Jul 2023 12:39:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 03/10] ima: allocate buffer at kexec load to hold ima
 measurements
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        "Eric W . Biederman" <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-4-tusharsu@linux.microsoft.com>
 <273cea4f-9c82-e5ca-20e4-1db30d83393e@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <273cea4f-9c82-e5ca-20e4-1db30d83393e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/11/23 13:16, Stefan Berger wrote:
>
>
> On 7/3/23 17:57, Tushar Sugandhi wrote:
>> The IMA subsystem needs a dedicated mechanism to reserve extra memory 
>> for
>> measurements added between the kexec 'load' and kexec 'execute'.
>>
>> Update ima_add_kexec_buffer to allocate a buffer of a sufficient size
>> taking ima binary runtime measurements size, size of ima_kexec_hdr, and
>> IMA_KEXEC_EXTRA_SIZE into account.  Adjust the kexec_segment_size to 
>> align
>> to the PAGE_SIZE.  Call ima_allocate_buf_at_kexec_load() to allocate the
>> buffer.
>>
>> This patch assumes the extra space defined (IMA_KEXEC_EXTRA_SIZE) is
>> sufficient to handle the additional measurements.  This should be as per
>> the system requirements and based on the number of additional 
>> measurements
>> expected during the window from kexec 'load' to kexec 'execute'.
>
> This could be the most problematic part if the 'execute' happens much 
> later
> than the 'load' with lots of measurement activity in between. I am 
> wondering
> whether not doing anything at 'load' time and doing the whole work at 
> 'execute' time
Technically I don't want to do anything at kexec 'load' time.
But as I said elsewhere in this series, I am under impression that 
segment allocation
must happen at kexec 'load' time.


But if that understanding is wrong - then we can move the entire logic 
to kexec 'execute' time.

I am currently trying to validate if moving the logic to kexec 'execute' 
works.
> wouldn't be the right thing to do ?
>
> Otherwise, if we wanted the work to be split as you suggest, could you
> - krealloc the src_pages (now in kimage_map_segment) to add space for 
> a few more pages needed for the additional measurements
> - add those few more pages to src_pages
> - vunmap the previous mapping
> - vmap the extended src_pages array
> - update ima_kexec_file.buf with the diff between the new and old 
> vmap'ed addresses
> - append to the existing log
>
> This presumably would help resolve this potential issue.
Thanks for the detailed thoughts.
I will investigate if this approach is needed, based on my comment above.
If it is needed and feasible, I will incorporate it in the next iteration.

Thanks again.

~Tushar

>
> The src_pages is currently not kfree'd -- may be a memory leak.
>
> Regards,
>    Stefan
>
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h       |  2 ++
>>   security/integrity/ima/ima_kexec.c | 21 ++++++++++-----------
>>   2 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c29db699c996..2ffda9449b9b 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -43,6 +43,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, 
>> TPM_PCR10 = 10 };
>>     #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks 
>> : 0)
>>   +#define IMA_KEXEC_EXTRA_SIZE (16 * PAGE_SIZE)
>> +
>>   /* current content of the policy */
>>   extern int ima_policy_flag;
>>   diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 858b67689701..7deb8df31485 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -188,31 +188,30 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       /* use more understandable variable names than defined in kbuf */
>>       void *kexec_buffer = NULL;
>>       size_t kexec_buffer_size;
>> -    size_t kexec_segment_size;
>>       int ret;
>>         /*
>> -     * Reserve an extra half page of memory for additional measurements
>> -     * added during the kexec load.
>> +     * Reserve extra memory for measurements added in the window from
>> +     * kexec 'load' to kexec 'execute'.
>>        */
>> -    binary_runtime_size = ima_get_binary_runtime_size();
>> +    binary_runtime_size = ima_get_binary_runtime_size() +
>> +                  sizeof(struct ima_kexec_hdr) +
>> +                  IMA_KEXEC_EXTRA_SIZE;
>> +
>>       if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>>           kexec_segment_size = ULONG_MAX;
>>       else
>> -        kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
>> -                       PAGE_SIZE / 2, PAGE_SIZE);
>> +        kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
>> +
>>       if ((kexec_segment_size == ULONG_MAX) ||
>>           ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>>           pr_err("Binary measurement list too large.\n");
>>           return;
>>       }
>>   -    ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>> -                  kexec_segment_size);
>> -    if (!kexec_buffer) {
>> -        pr_err("Not enough memory for the kexec measurement 
>> buffer.\n");
>> +    ret = ima_allocate_buf_at_kexec_load();
>> +    if (ret < 0)
>>           return;
>> -    }
>>         kbuf.buffer = kexec_buffer;
>>       kbuf.bufsz = kexec_buffer_size;

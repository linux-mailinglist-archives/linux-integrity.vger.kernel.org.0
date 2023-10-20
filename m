Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7647D170C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 22:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjJTUda (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJTUd3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 16:33:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44F06C0
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 13:33:27 -0700 (PDT)
Received: from [192.168.86.69] (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 31AB820B74C0;
        Fri, 20 Oct 2023 13:33:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31AB820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697834006;
        bh=5lwU68ggTpUd5Qazc3xwkaQiQeOdLttE6W0CAK60Opo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uw1kKEqnN37zRIpncu4lwRIdRueUZYkLp77nUFbjbvzJr97szt6cv1Sdwv4lsDKlY
         YsC9ELPDr1/XEENEtLLAltrNFNgb6K7ZEUJRt/o+zJXTHNOIS7+yBW8OBMQPLlYk1z
         zTieTV4KjJDtoseVTX1TGqHV+kmDXZcE1EYHNjRE=
Message-ID: <9b227c0a-ddb3-b1c3-4ed0-e3e740db7788@linux.microsoft.com>
Date:   Fri, 20 Oct 2023 13:33:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
 <2c06f9c5-6f3a-b163-20ca-24178d7cba4e@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <2c06f9c5-6f3a-b163-20ca-24178d7cba4e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks a lot Stefan for reviewing this series.
Really appreciate it.

On 10/12/23 17:28, Stefan Berger wrote:
> 
> On 10/5/23 14:25, Tushar Sugandhi wrote:
>> IMA allocates memory and dumps the measurement during kexec soft reboot
>> as a single function call ima_dump_measurement_list().  It gets called
>> during kexec 'load' operation.  It results in the IMA measurements
>> between the window of kexec 'load' and 'execute' getting dropped when the
>> system boots into the new Kernel.  One of the kexec requirements is the
>> segment size cannot change between the 'load' and the 'execute'.
>> Therefore, to address this problem, ima_dump_measurement_list() needs
>> to be refactored to allocate the memory at kexec 'load', and dump the
>> measurements at kexec 'execute'.  The function that allocates the memory
>> should handle the scenario where the kexec load is called multiple times.
>>
>> Refactor ima_dump_measurement_list() to move the memory allocation part
>> to a separate function ima_alloc_kexec_buf() to allocate buffer of size
>> 'kexec_segment_size' at kexec 'load'.  Make the local variables in
>> function ima_dump_measurement_list() global, so that they can be accessed
>> from ima_alloc_kexec_buf().  Make necessary changes to the function
>> ima_add_kexec_buffer() to call the above two functions.
>>
>> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
>>   1 file changed, 93 insertions(+), 33 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 419dc405c831..307e07991865 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,61 +15,114 @@
>>   #include "ima.h"
>>   #ifdef CONFIG_IMA_KEXEC
>> +struct seq_file ima_kexec_file;
>> +struct ima_kexec_hdr ima_khdr;
> 
> Since you are only populating the buffer at kexec 'execute' time, you 
> should be able to move this header into the function where it is needed.
> 
Yup, ima_khdr doesn't need to be static. Will fix.
> 
>> +
>> +void ima_clear_kexec_file(void)
>> +{
>> +    vfree(ima_kexec_file.buf);
> I would pass the ima_kexec_file onto this function here as a parameter 
> rather than accessing the file-static variable. I find this better to 
> read once you look at ima_clear_kexec_file() further below and wonder 
> why it doesn't take a parameter.
Agreed. This will make the code more readable.

>> +    ima_kexec_file.buf = NULL;
>> +    ima_kexec_file.size = 0;
>> +    ima_kexec_file.read_pos = 0;
>> +    ima_kexec_file.count = 0;
>> +}
>> +
>> +static int ima_alloc_kexec_buf(size_t kexec_segment_size)
> 
> Call it segment size to avoid the later kexec_segment_size static 
> variable in this file.
> 
> 
Will do.
>> +{
>> +    if ((kexec_segment_size == 0) ||
>> +        (kexec_segment_size == ULONG_MAX) ||
>> +        ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
> 
> These tests are already done before ima_alloca_kexec_buf() is called. 
> Also, kexec_segment_size cannot be 0.
> 
> 
I was being extra cautious here. If ima_alloc_kexec_buf() gets called
from some other place, then this check would be handy. Being said that,
maybe this function is a better place to have this check. I will see
what I can do here to simplify things. Thanks for the feedback.

>> +        pr_err("%s: Invalid segment size for kexec: %zu\n",
>> +            __func__, kexec_segment_size);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /*
>> +     * If kexec load was called before, clear the existing buffer
>> +     * before allocating a new one
>> +     */
>> +    if (ima_kexec_file.buf)
>> +        ima_clear_kexec_file();
>> +
> 
> ima_clear_file(&ima_kexec_file);
> 
> 
Agreed. Will do.

>> +    /* segment size can't change between kexec load and execute */
>> +    ima_kexec_file.buf = vmalloc(kexec_segment_size);
>> +    if (!ima_kexec_file.buf) {
>> +        pr_err("%s: No memory for ima kexec measurement buffer\n",
>> +            __func__);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    ima_kexec_file.size = kexec_segment_size;
>> +    ima_kexec_file.read_pos = 0;
>> +    ima_kexec_file.count = sizeof(ima_khdr);    /* reserved space */
>> +
>> +    memset(&ima_khdr, 0, sizeof(ima_khdr));
>> +    ima_khdr.version = 1;
> 
> Move this into ima_dump_measurement_list() since it's only used there 
> once and getting rid of this file-static variable is a plus.
> 
> 
Yes. This will get rid of an extra static variable.

>> +
>> +    return 0;
>> +}
>> +
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, 
>> void **buffer,
>>                        unsigned long segment_size)
>>   {
>>       struct ima_queue_entry *qe;
>> -    struct seq_file file;
>> -    struct ima_kexec_hdr khdr;
> Don't remove it from here.
Agreed. khdr doesn't need to be static.

>>       int ret = 0;
>> -    /* segment size can't change between kexec load and execute */
>> -    file.buf = vmalloc(segment_size);
>> -    if (!file.buf) {
>> -        ret = -ENOMEM;
>> -        goto out;
>> +    if (!ima_kexec_file.buf) {
>> +        pr_err("%s: Kexec file buf not allocated\n",
>> +            __func__);
>> +        return -EINVAL;
>>       }
>> -    file.size = segment_size;
>> -    file.read_pos = 0;
>> -    file.count = sizeof(khdr);    /* reserved space */
>> +    /*
>> +     * Ensure the kexec buffer is large enough to hold ima_khdr
>> +     */
>> +    if (ima_kexec_file.size < sizeof(ima_khdr)) {
>> +        pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
>> +            __func__);
>> +        ima_clear_kexec_file();
>> +        return -ENOMEM;
>> +    }
>> -    memset(&khdr, 0, sizeof(khdr));
>> -    khdr.version = 1;
>> +    /*
>> +     * If we reach here, then there is enough memory
>> +     * of size kexec_segment_size in ima_kexec_file.buf
>> +     * to copy at least partial IMA log.
>> +     * Make best effort to copy as many IMA measurements
>> +     * as possible.
> You can reformat these comments to (at least) 80 columns.
> 
Sure thing.
>> +     */
>>       list_for_each_entry_rcu(qe, &ima_measurements, later) {
>> -        if (file.count < file.size) {
>> -            khdr.count++;
>> -            ima_measurements_show(&file, qe);
>> +        if (ima_kexec_file.count < ima_kexec_file.size) {
>> +            ima_khdr.count++;
>> +            ima_measurements_show(&ima_kexec_file, qe);
>>           } else {
>> -            ret = -EINVAL;
>> +            ret = EFBIG;
> 
> Hm, you are not looking for EFBIG after calling this function and the 
> overrun could actually also happen in the ima_measurement_show() above 
> and go unreported if this is the last element.
> 
> if (ima_kexec_file.count < ima_kexec_file.size) {
>      ima_khdr.count++;
>      ima_measurements_show(&ima_kexec_file, qe);
> }
> 
> if (ima_kexec_file.count >= ima_kexec_file.size) {
>      /* leave ret = 0; caller doesn't need to worry about undersized 
> buffer */
>      pr_err("%s: IMA log file is too big for Kexec buf\n",
>          __func__);
>      break;
> }
> 
This makes it more clean. Thanks. Will do.

~Tushar

>> +            pr_err("%s: IMA log file is too big for Kexec buf\n",
>> +                __func__);
>>               break;
>>           }
>>       }
>> -    if (ret < 0)
>> -        goto out;
>> -
>>       /*
>>        * fill in reserved space with some buffer details
>>        * (eg. version, buffer size, number of measurements)
>>        */
>> -    khdr.buffer_size = file.count;
>> +    ima_khdr.buffer_size = ima_kexec_file.count;
>>       if (ima_canonical_fmt) {
>> -        khdr.version = cpu_to_le16(khdr.version);
>> -        khdr.count = cpu_to_le64(khdr.count);
>> -        khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>> +        ima_khdr.version = cpu_to_le16(ima_khdr.version);
>> +        ima_khdr.count = cpu_to_le64(ima_khdr.count);
>> +        ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
>>       }
>> -    memcpy(file.buf, &khdr, sizeof(khdr));
>> +    memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
>>       print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
>> -                 file.buf, file.count < 100 ? file.count : 100,
>> +                 ima_kexec_file.buf, ima_kexec_file.count < 100 ?
>> +                 ima_kexec_file.count : 100,
>>                    true);
>> -    *buffer_size = file.count;
>> -    *buffer = file.buf;
>> -out:
>> -    if (ret == -EINVAL)
>> -        vfree(file.buf);
>> +    *buffer_size = ima_kexec_file.count;
>> +    *buffer = ima_kexec_file.buf;
>> +
>>       return ret;
>>   }
>> @@ -108,13 +161,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>>           return;
>>       }
>> -    ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>> -                  kexec_segment_size);
>> -    if (!kexec_buffer) {
>> +    ret = ima_alloc_kexec_buf(kexec_segment_size);
>> +    if (ret < 0) {
>>           pr_err("Not enough memory for the kexec measurement 
>> buffer.\n");
>>           return;
>>       }
>> +    ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>> +                    kexec_segment_size);
>> +    if (ret < 0) {
>> +        pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
>> +               __func__, ret);
>> +        return;
>> +    }
>> +
>>       kbuf.buffer = kexec_buffer;
>>       kbuf.bufsz = kexec_buffer_size;
>>       kbuf.memsz = kexec_segment_size;

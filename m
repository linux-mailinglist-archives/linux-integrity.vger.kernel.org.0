Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9667D171D
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 22:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJTUfO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJTUfO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 16:35:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20270D65
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 13:35:11 -0700 (PDT)
Received: from [192.168.86.69] (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 852CB20B74C1;
        Fri, 20 Oct 2023 13:35:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 852CB20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697834110;
        bh=X1zR+HC7ncwpNj+9ZQ1uJqVmCCvRjlUMsQzSqXgVEAk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cD1Cmw+XENd2safTq7ATAUhmR0dM0I8F2KlEOIOhNpHz1u4ca74EqZScjdTt80DGl
         NUO13eAvPKw/cf0UfNF7vfn/fyHWWz2byluPTVlVMZ1ytssnWKP241GSPY2gNKiPgz
         3BjN2/1lCpME3g1S3xVQTLFg1ruoSFvneTclU+G4=
Message-ID: <de034114-1bac-8727-afba-8711d163def7@linux.microsoft.com>
Date:   Fri, 20 Oct 2023 13:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/7] ima: move ima_dump_measurement_list call from
 kexec load to execute
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-3-tusharsu@linux.microsoft.com>
 <0c5ce35f-cb45-400e-4485-fac724f6b760@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <0c5ce35f-cb45-400e-4485-fac724f6b760@linux.ibm.com>
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



On 10/12/23 17:28, Stefan Berger wrote:
> 
> On 10/5/23 14:25, Tushar Sugandhi wrote:
>> In the current IMA implementation, ima_dump_measurement_list() is called
>> during the kexec 'load' operation.  This can result in loss of IMA
>> measurements taken between the 'load' and 'execute' phases when the
>> system goes through Kexec soft reboot to a new Kernel.  The call to the
>> function ima_dump_measurement_list() needs to be moved out of the
>> function ima_add_kexec_buffer() and needs to be called during the kexec
>> 'execute' operation.
>>
>> Implement a function ima_update_kexec_buffer() that is called during
>> kexec 'execute', allowing IMA to update the measurement list with the
>> events between kexec 'load' and 'execute'.  Move the
>> ima_dump_measurement_list() call from ima_add_kexec_buffer() to
>> ima_update_kexec_buffer().  Make ima_kexec_buffer and kexec_segment_size
>> variables global, so that they can be accessed during both kexec 'load'
>> and 'execute'.  Add functions ima_measurements_suspend() and
>> ima_measurements_resume() to set and reset the 'suspend_ima_measurements'
>> variable respectively, to suspend/resume IMA measurements.  Use
>> the existing 'ima_extend_list_mutex' to ensure that the operations are
>> thread-safe.  These function calls will help maintaining the integrity
>> of the IMA log while it is being copied to the new Kernel's buffer.
>> Add a reboot notifier_block 'update_buffer_nb' to ensure
>> the function ima_update_kexec_buffer() gets called during kexec
>> soft-reboot.
>>
>> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h       |  2 ++
>>   security/integrity/ima/ima_kexec.c | 58 +++++++++++++++++++++++++-----
>>   security/integrity/ima/ima_queue.c | 18 ++++++++++
>>   3 files changed, 69 insertions(+), 9 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c29db699c996..49a6047dd8eb 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -161,6 +161,8 @@ bool ima_template_has_modsig(const struct 
>> ima_template_desc *ima_template);
>>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>>   int ima_measurements_show(struct seq_file *m, void *v);
>> +void ima_measurements_suspend(void);
>> +void ima_measurements_resume(void);
>>   unsigned long ima_get_binary_runtime_size(void);
>>   int ima_init_template(void);
>>   void ima_init_template_list(void);
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 307e07991865..2c11bbe6efef 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #ifdef CONFIG_IMA_KEXEC
>>   struct seq_file ima_kexec_file;
>>   struct ima_kexec_hdr ima_khdr;
>> +static void *ima_kexec_buffer;
>> +static size_t kexec_segment_size;
>>   void ima_clear_kexec_file(void)
>>   {
>> @@ -142,7 +144,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       /* use more understandable variable names than defined in kbuf */
>>       void *kexec_buffer = NULL;
>>       size_t kexec_buffer_size;
>> -    size_t kexec_segment_size;
>>       int ret;
>>       /*
>> @@ -167,14 +168,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>>           return;
>>       }
>> -    ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>> -                    kexec_segment_size);
>> -    if (ret < 0) {
>> -        pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
>> -               __func__, ret);
>> -        return;
>> -    }
>> -
>>       kbuf.buffer = kexec_buffer;
>>       kbuf.bufsz = kexec_buffer_size;
>>       kbuf.memsz = kexec_segment_size;
>> @@ -192,6 +185,53 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       pr_debug("kexec measurement buffer for the loaded kernel at 
>> 0x%lx.\n",
>>            kbuf.mem);
>>   }
>> +
>> +/*
>> + * Called during kexec execute so that IMA can update the measurement 
>> list.
>> + */
>> +static int ima_update_kexec_buffer(struct notifier_block *self,
>> +                   unsigned long action, void *data)
>> +{
>> +    void *buf = NULL;
>> +    size_t buf_size;
>> +    bool resume = false;
>> +    int ret;
>> +
>> +    if (!kexec_in_progress) {
>> +        pr_info("%s: No kexec in progress.\n", __func__);
>> +        return NOTIFY_OK;
>> +    }
>> +
>> +    if (!ima_kexec_buffer) {
>> +        pr_err("%s: Kexec buffer not set.\n", __func__);
>> +        return NOTIFY_OK;
>> +    }
>> +
>> +    ima_measurements_suspend();
>> +
>> +    buf_size = ima_get_binary_runtime_size();
> There doesn't seem to be a need to call this function and pass in the 
> binary runtime size into the dump function. You should be able to remove 
> it.
Oh. This was an oversight.
This line is removed in patch 7/7.  It should have been removed here
itself.
Thanks for catching it. Will fix.
>> +    ret = ima_dump_measurement_list(&buf_size, &buf,
>> +                    kexec_segment_size);
>> +
>> +    if (!buf || ret < 0) {
> I don't think this function can (or should) ever return ret >= 0 with 
> buf == NULL.
I will simplify this check. Thanks.

~Tushar
>> +        pr_err("%s: Dump measurements failed. Error:%d\n",
>> +               __func__, ret);
>> +        resume = true;
>> +        goto out;
>> +    }
>> +    memcpy(ima_kexec_buffer, buf, buf_size);
>> +out:
>> +    ima_kexec_buffer = NULL;
>> +
>> +    if (resume)
>> +        ima_measurements_resume();
>> +
>> +    return NOTIFY_OK;
>> +}
>> +struct notifier_block update_buffer_nb = {
>> +    .notifier_call = ima_update_kexec_buffer,
>> +};
>> +
>>   #endif /* IMA_KEXEC */
>>   /*
>> diff --git a/security/integrity/ima/ima_queue.c 
>> b/security/integrity/ima/ima_queue.c
>> index 532da87ce519..9e7d1196006e 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -44,6 +44,11 @@ struct ima_h_table ima_htable = {
>>    */
>>   static DEFINE_MUTEX(ima_extend_list_mutex);
>> +/*
>> + * Used internally by the kernel to suspend-resume ima measurements.
>> + */
>> +static atomic_t suspend_ima_measurements;
>> +
>>   /* lookup up the digest value in the hash table, and return the 
>> entry */
>>   static struct ima_queue_entry *ima_lookup_digest_entry(u8 
>> *digest_value,
>>                                  int pcr)
>> @@ -147,6 +152,19 @@ static int ima_pcr_extend(struct tpm_digest 
>> *digests_arg, int pcr)
>>           pr_err("Error Communicating to TPM chip, result: %d\n", 
>> result);
>>       return result;
>>   }
>> +void ima_measurements_suspend(void)
>> +{
>> +    mutex_lock(&ima_extend_list_mutex);
>> +    atomic_set(&suspend_ima_measurements, 1);
>> +    mutex_unlock(&ima_extend_list_mutex);
>> +}
>> +
>> +void ima_measurements_resume(void)
>> +{
>> +    mutex_lock(&ima_extend_list_mutex);
>> +    atomic_set(&suspend_ima_measurements, 0);
>> +    mutex_unlock(&ima_extend_list_mutex);
>> +}
>>   /*
>>    * Add template entry to the measurement list and hash table, and

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3E7D1730
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 22:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjJTUk6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjJTUk6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 16:40:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89CB3E8
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 13:40:54 -0700 (PDT)
Received: from [192.168.86.69] (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id B838120B74C3;
        Fri, 20 Oct 2023 13:40:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B838120B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697834454;
        bh=Fjvqj0mR9iPDcKJM5SwXgcrUK9PszPvcdOUjUMyGwjA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ku1pFCo8LR0Kbedb27GJ3UESz5JnWBNTcOsyFinhkkbCaWAUnZVVhM67vgEhgQoR0
         2gsEJYV3Dq53sbClXMlF+y1qzXqKx+inc54CgrnEzlmp3MNS/kaO8l+97P/vgez7B9
         WWBaa9Ekm+IYX/ZQX22cFZWS+JLd2UU8EWecWur8=
Message-ID: <01919978-183e-75dc-0060-123a036937be@linux.microsoft.com>
Date:   Fri, 20 Oct 2023 13:40:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 7/7] ima: record log size at kexec load and execute
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-8-tusharsu@linux.microsoft.com>
 <50477765-05f3-9fc6-4e85-cd822d212d95@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <50477765-05f3-9fc6-4e85-cd822d212d95@linux.ibm.com>
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



On 10/12/23 17:27, Stefan Berger wrote:
> 
> On 10/5/23 14:26, Tushar Sugandhi wrote:
>> The window between kexec 'load' and 'execute' could be arbitrarily long.
>> Even with the large chunk of memory allocated at kexec 'load', it may
>> run out which would result in missing events in IMA log after the system
>> soft reboots to the new Kernel.  This would result in IMA measurements
>> getting out of sync with the TPM PCR quotes which would result in remote
>> attestation failing for that system.  There is currently no way for the
>> new Kernel to know if the IMA log TPM PCR quote out of sync problem is
>> because of the missing measurements during kexec.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured at kexec 'load' and 'execute' respectively.
>>
>> IMA measures 'boot_aggregate' as the first event when the system boots -
>> either cold boot or kexec soft boot.  In case when the system goes
>> through multiple soft reboots, the number of 'boot_aggregate' events in
>> IMA log corresponds to total number of boots (cold boot plus multiple
>> kexec soft reboots).  With this change, there would be additional
>> 'kexec_load' and 'kexec_execute' events in between the two
>> 'boot_aggregate' events.  In rare cases, when the system runs out of
>> memory during kexec soft reboot, 'kexec_execute' won't be copied since
>> its one of the very last event measured just before kexec soft reboot.
>> The absence of the event 'kexec_execute' in between the two
>> boot_aggregate' events would signal the attestation service that the IMA
>> log on the system is out of sync with TPM PCR quotes and the system needs
>> to be cold booted for the remote attestation to succeed again.
>>
>>
>> @@ -198,6 +208,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   static int ima_update_kexec_buffer(struct notifier_block *self,
>>                      unsigned long action, void *data)
>>   {
>> +    char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>>       void *buf = NULL;
>>       size_t buf_size;
>>       bool resume = false;
>> @@ -213,9 +224,31 @@ static int ima_update_kexec_buffer(struct 
>> notifier_block *self,
>>           return NOTIFY_OK;
>>       }
>> +    buf_size = ima_get_binary_runtime_size();
>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +          "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
>> +          kexec_segment_size, buf_size);
>> +
>> +    /*
>> +     * This is one of the very last events measured by IMA before kexec
>> +     * soft rebooting into the new Kernal.
>> +     * This event can be used as a marker after the system soft reboots
>> +     * to the new Kernel to check if there was sufficient memory 
>> allocated
>> +     * at kexec 'load' to capture the events measured between the window
>> +     * of kexec 'load' and 'execute'.
>> +     * This event needs to be present in the IMA log, in between the two
>> +     * 'boot_aggregate' events that are logged for the previous boot and
>> +     * the current soft reboot. If it is not present after the system 
>> soft
>> +     * reboots into the new Kernel, it would mean the IMA log is not
>> +     * consistent with the TPM PCR quotes, and the system needs to be
>> +     * cold-booted for the attestation to succeed again.
>> +     */
>> +    ima_measure_critical_data("ima_kexec", "kexec_execute",
>> +                  ima_kexec_event, strlen(ima_kexec_event),
>> +                  false, NULL, 0);
>> +
>>       ima_measurements_suspend();
>> -    buf_size = ima_get_binary_runtime_size();
> 
> This should be removed earlier, in 2/7.
> 
> 
> 
Agreed. Will do.

~Tushar

>>       ret = ima_dump_measurement_list(&buf_size, &buf,
>>                       kexec_segment_size);

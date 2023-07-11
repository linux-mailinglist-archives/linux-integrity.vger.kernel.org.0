Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8180874F809
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 20:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjGKSbr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjGKSbq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 14:31:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3009E10F0
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 11:31:45 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6A19E21C3A8D;
        Tue, 11 Jul 2023 11:31:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A19E21C3A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689100304;
        bh=/3mT8gr5WtW/jVqLDpzEl/U4ejE+qHGCh69ueIswO50=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qb89EVopFMR0fhNlyZay9qydXxrRE/BDnXPVwqMiblR5zQKnHOW/Jo94szR/Kfjtt
         PFgI8/5U59EQn/FIzcKlc6MDCos5enJJ4X8LXJiJTRBzL+kBLmIfYtpyho6Cw0PlD8
         vyvxMUyW6zkFO23kBa6qG539rOvqYdEiY1YNpw4k=
Message-ID: <b43a443a-7884-c8ef-dff2-5563069937aa@linux.microsoft.com>
Date:   Tue, 11 Jul 2023 11:31:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 03/10] ima: allocate buffer at kexec load to hold ima
 measurements
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-4-tusharsu@linux.microsoft.com>
 <ef2f8f1f9ab806e010cac02aab1b64fa51ce4c2c.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <ef2f8f1f9ab806e010cac02aab1b64fa51ce4c2c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adding Eric to cc.

On 7/7/23 06:01, Mimi Zohar wrote:
> Hi Tushar,
>
> The function to "ima: allocate buffer at kexec load to hold ima
> measurements" already exists.  Please update the Subject line to
> indicate increasing the IMA kexec buffer size.
>
> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
>> The IMA subsystem needs a dedicated mechanism to reserve extra memory for
>> measurements added between the kexec 'load' and kexec 'execute'.
> What is a "dedicated mechanism?".  Either start the sentence with
> "reserve ..." or completely remove it.
>
Will do.
>> Update ima_add_kexec_buffer to allocate a buffer of a sufficient size
>> taking ima binary runtime measurements size, size of ima_kexec_hdr, and
>> IMA_KEXEC_EXTRA_SIZE into account.  Adjust the kexec_segment_size to align
>> to the PAGE_SIZE.  Call ima_allocate_buf_at_kexec_load() to allocate the
>> buffer.
> The size of the ima_kexec_hdr kind of gets lost in the amount of
> additional memory being allocated, but sure it's a nice clean up.
Thanks. :)
>> This patch assumes the extra space defined (IMA_KEXEC_EXTRA_SIZE) is
>> sufficient to handle the additional measurements.  This should be as per
>> the system requirements and based on the number of additional measurements
>> expected during the window from kexec 'load' to kexec 'execute'.
> Should the extra amount of memory be hard coded?
>
You are right.  As you suggested below, defining the extra amount in
Kconfig is a cleaner approach.

>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h       |  2 ++
>>   security/integrity/ima/ima_kexec.c | 21 ++++++++++-----------
>>   2 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c29db699c996..2ffda9449b9b 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -43,6 +43,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>>   
>>   #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
>>   
>> +#define IMA_KEXEC_EXTRA_SIZE (16 * PAGE_SIZE)
>>
> Not all IMA policies require extra memory.  Define and use a new IMA
> Kconfig to set the amount of extra memory.
Sure.  Will do.
>>   /* current content of the policy */
>>   extern int ima_policy_flag;
>>   
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 858b67689701..7deb8df31485 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -188,31 +188,30 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	/* use more understandable variable names than defined in kbuf */
>>   	void *kexec_buffer = NULL;
>>   	size_t kexec_buffer_size;
>> -	size_t kexec_segment_size;
>>   	int ret;
>>   
>>   	/*
>> -	 * Reserve an extra half page of memory for additional measurements
>> -	 * added during the kexec load.
>> +	 * Reserve extra memory for measurements added in the window from
>> +	 * kexec 'load' to kexec 'execute'.
>>   	 */
>> -	binary_runtime_size = ima_get_binary_runtime_size();
>> +	binary_runtime_size = ima_get_binary_runtime_size() +
>> +			      sizeof(struct ima_kexec_hdr) +
>> +			      IMA_KEXEC_EXTRA_SIZE;
>> +
>>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>>   		kexec_segment_size = ULONG_MAX;
>>   	else
>> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
>> -					   PAGE_SIZE / 2, PAGE_SIZE);
>> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
>> +
>>   	if ((kexec_segment_size == ULONG_MAX) ||
>>   	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>>   		pr_err("Binary measurement list too large.\n");
>>   		return;
>>   	}
>>   
>> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>> -				  kexec_segment_size);
> Removing the call to ima_dump_measurement_list here is not bisect safe.
Agreed.  Will take care of this based on if we end up using just
ima_dump_measurement_list(), or combination of
ima_allocate_buf_at_kexec_load() and ima_populate_buf_at_kexec_execute().

~Tushar
>> -	if (!kexec_buffer) {
>> -		pr_err("Not enough memory for the kexec measurement buffer.\n");
>> +	ret = ima_allocate_buf_at_kexec_load();
>> +	if (ret < 0)
>>   		return;
>> -	}
>>   
>>   	kbuf.buffer = kexec_buffer;
>>   	kbuf.bufsz = kexec_buffer_size;

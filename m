Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A5B76F5EC
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 01:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjHCXCU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 19:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHCXCM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 19:02:12 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87D0E30F6
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 16:01:59 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 81566207F5B2;
        Thu,  3 Aug 2023 16:01:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81566207F5B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691103717;
        bh=wb6/cOS27R9v5HDFW3pHzcqDeGWkZFwt7EZjsyRl/e0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U/nq6a2qhFgN7h4+2VQuJZSP9VtGTW0X9pwv0aUHGVncstNdE+B5ieWOhlRjS7dRp
         P74i9eJ8Yt9E6FW9G43056xCM30Hg5lXxipc1rqgs8HM7LTMs9Y5elz4BC3XHwtcJj
         HetADTR+jYH1MtqnrYy4zn9bVPzYdTFIpRHuU7hQ=
Message-ID: <b9a77076-d6ac-a1ec-5e75-ab066dfade69@linux.microsoft.com>
Date:   Thu, 3 Aug 2023 16:01:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] ima: implement functionality to measure TPM update
 counter
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-5-tusharsu@linux.microsoft.com>
 <a2d9af7f54f364da9aeaef3dc6e03b7412957c23.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <a2d9af7f54f364da9aeaef3dc6e03b7412957c23.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Thanks for the review Mimi.

On 8/3/23 14:42, Mimi Zohar wrote:
> On Tue, 2023-08-01 at 11:19 -0700, Tushar Sugandhi wrote:
>> Currently TPM update counter is not available external to the system,
>> for instance, a remote attestation service.  It is a problem because
>> the service cannot easily determine if the IMA log entries are missing.
>> The IMA functionality needs to be extended to measure the TPM update
>> counter from various subsystems in Linux kernel to help detect if
>> the IMA log entries are missing.
>>
>> Implement a function, 'ima_measure_update_counter()' which would retrieve
>> the TPM update counter using the previously defined function
>> 'ima_tpm_get_update_counter()'.  Format it as a string with the value
>> "update_counter=<N>;", and measure it using the function
>> 'ima_measure_critical_data()'.
>>
>> The function takes an event name as input, and the update counter value
>> is measured as part of this event.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Explicit TPM2 quote commands do not return the quoted PCR values or the
> pcrCounter value.  Define and include a new IMA measurement record
> containing the pcrCounter, other TPM info, and IMA info in the IMA
> measurement list to help simplify detecting a trimmed/truncated
> measurement list.
Sounds good.
>> ---
>>   include/linux/ima.h               |  1 +
>>   security/integrity/ima/ima.h      |  1 +
>>   security/integrity/ima/ima_main.c | 28 ++++++++++++++++++++++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 86b57757c7b1..f15f3a6a4c72 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -40,6 +40,7 @@ extern int ima_measure_critical_data(const char *event_label,
>>   				     const char *event_name,
>>   				     const void *buf, size_t buf_len,
>>   				     bool hash, u8 *digest, size_t digest_len);
>> +int ima_measure_update_counter(const char *event_name);
>>   
>>   #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>>   extern void ima_appraise_parse_cmdline(void);
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 4acd0e5a830f..5484bd362237 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -168,6 +168,7 @@ int __init ima_init_digests(void);
>>   int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>>   			  void *lsm_data);
>>   int ima_tpm_get_update_counter(u32 *cpu_update_counter);
>> +int ima_measure_update_counter(const char *event_name);
>>   
>>   /*
>>    * used to protect h_table and sha_table
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index d66a0a36415e..1bcd45cc5a6a 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -1071,6 +1071,34 @@ int ima_measure_critical_data(const char *event_label,
>>   }
>>   EXPORT_SYMBOL_GPL(ima_measure_critical_data);
>>   
>> +#define IMA_TPM_UPDATE_CTR_BUF_SIZE 128
>> +int ima_measure_update_counter(const char *event_name)
>> +{
>> +	int result;
>> +	u32 update_counter = 0;
>> +	char buf[IMA_TPM_UPDATE_CTR_BUF_SIZE];
>> +	int buf_len;
>> +
>> +	if (!event_name)
>> +		return -ENOPARAM;
>> +
>> +	result = ima_tpm_get_update_counter(&update_counter);
>> +
>> +	if (result != 0)
>> +		return result;
>> +
>> +	scnprintf(buf, IMA_TPM_UPDATE_CTR_BUF_SIZE, "update_counter=%u;",
>> +			  update_counter);
>> +
>> +	buf_len = strlen(buf);
>> +
>> +	result = ima_measure_critical_data("tpm_pcr_update_counter", event_name,
>> +				  buf, buf_len, false, NULL, 0);
>>
> The new record should contain everything needed to verify the
> pcrCounter.  For example, each IMA measurement record updates the
> pcrCounter for each TPM bank enabled.  So the number of enabled TPM
> banks and number of IMA measurements should also be included in this
> record.
Agreed. That should be valuable information.
How does the below format look like for the buf above?

version=<N>.<N>.<N>;num_enabled_pcr_banks=<N>;pcrUpdateCounter=<N>;num_ima_measurements=<N>;

>
> Perhaps include a version number as well, so that if we ever want to
> include other information, we could.
By version number, do you mean kernel_version, or a new version
number specific to this record? Or something else?

~Tushar
> Mimi
>
>
>> +
>> +	return result;
>> +}
>> +EXPORT_SYMBOL_GPL(ima_measure_update_counter);
>> +
>>   static int __init init_ima(void)
>>   {
>>   	int error;


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0976F62B
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 01:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjHCXe7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 19:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHCXe6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 19:34:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F1F43A80
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 16:34:57 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id C6098207F5B1;
        Thu,  3 Aug 2023 16:34:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6098207F5B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691105697;
        bh=L8yrCktR1bInfqFj8yOAiQus2L1BtlSzyz1/mAjoTyI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sTQbB6oC/uYAco2S/dtzv26Klf8dFhBBWQwL9wfYoMhbBie1PciAnjj2E66O/TXXb
         Jd0VzJCTzZYfEmZ43Ba/QRWvhGhfp7wNi84sYFKaTEOvb7j/a6g5OD6bVVHVXATTKs
         EXCp+Hgs6nVDcNjR2J23clcbrtrElcQcGpFor57s=
Message-ID: <da91b56a-83c8-d12e-71f8-887b6701f021@linux.microsoft.com>
Date:   Thu, 3 Aug 2023 16:34:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] ima: measure TPM update counter at ima_init
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-6-tusharsu@linux.microsoft.com>
 <223d5c5a655fec263895c991550e4291d1bbd4c9.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <223d5c5a655fec263895c991550e4291d1bbd4c9.camel@linux.ibm.com>
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



On 8/3/23 15:15, Mimi Zohar wrote:
> On Tue, 2023-08-01 at 11:19 -0700, Tushar Sugandhi wrote:
>> IMA log entries can be lost due to a variety of causes, such as code bugs
>> or error conditions, leading to a mismatch between TPM PCRs and
>> the IMA log.  Measuring TPM PCR update counter during ima_init would
>> provide a baseline counter for the number of times the TPM PCRs are
>> updated.  The remote attestation service can compare this baseline
>> counter with a subsequent measured one (e.g., post-kexec soft-boot) to
>> identify if there are any lost IMA log events.
>>
>> Measure the TPM update counter at ima init.
> No need for separate patches for one line changes like this.  Either
> merge patches 5/6 and 6/6 or all three 4/6, 5/6, 6/6 together.
>
Sounds good.
I will merge 4/6, 5/6, 6/6 together.
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_init.c | 3 +++
>>   security/integrity/ima/ima_main.c | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
>> index 63979aefc95f..9bb18d6c2fd6 100644
>> --- a/security/integrity/ima/ima_init.c
>> +++ b/security/integrity/ima/ima_init.c
>> @@ -154,5 +154,8 @@ int __init ima_init(void)
>>   				  UTS_RELEASE, strlen(UTS_RELEASE), false,
>>   				  NULL, 0);
>>   
>> +	/* Measures TPM update counter at ima_init */
>> +	ima_measure_update_counter("ima_init_tpm_update_counter");
>> +
> With "ima_policy=critical_data" on the boot command line, the IMA
> measurement list record looks like:
>
> 6e190cc643ff0b718485966a0300473baedface735 ima_init_tpm_update_counter 7570646174655f636f756e7465723d3330383b
>
> Please change the "ima_init_tpm_update_counter" to something shorter
> and the hex encoded ascii string and pcr counter to something readable.
I believe you are seeing the above line in ascill_runtime_measurements log.

The ascii logging format is consistent with other event data for 
critical_data event e.g. kernel_version.
10 8f449175bbf88bc55fc1127466628c39a3957d15 ima-buf 
sha1:4acab4fbb08db663b7b7b4528e8729187d726782 kernel_version 
362e332e302d7263332b
10 f10678b63c4b2529339dff02282e63d9c6bb0385 ima-buf 
sha1:d8c187524412f74a961f2051a9529c009e700337 
ima_init_tpm_update_counter 7570646174655f636f756e7465723d3133303b

Entries in the binary runtime measurements look readable to me.

ima_init_tpm_update_counter update_counter=130;
...
kexec_load_tpm_update_counte rupdate_counter=133;

Please let me know if you still want me to change the format.

> Perhaps name this critical-data "tpm" and "tpm-info", similar to the
 From patch 4/6:
+    result = ima_measure_critical_data("tpm_pcr_update_counter", 
event_name,
+                  buf, buf_len, false, NULL, 0);

The critical_data event_label value is currently set to 
"tpm_pcr_update_counter".
I can rename event_label to "tpm-info", so that the admins can filter the
event in IMA policy based on the label if needed.

As you know, event_label doesn't appear in IMA log, it can appear in IMA 
policy.
Whereas event_name appears in IMA log.

I was thinking of using event_name to identify when was the info captured.
(e.g. ima_init, kexec_load, or at some other event in future).

We can either do
(a)
event_label = "tpm-info" event_name = "tpm-info-ima-init" | 
"tpm-info-kexec-load" | ...

-or-

(b)
event_label = "tpm" event_name = "tpm-info"
and event_data to describe the where/when this info was captured.
e.g.
version=<N>.<N>.<N>;num_enabled_pcr_banks=<N>;pcrUpdateCounter=<N>;num_ima_measurements=<N>;event=kexec_load;

Let me know if you would prefer option (a) or (b) or something else.


> SELinux "selinux" and "selinux-state".  Then again, if this is TPM
> critical-data we should rethink what other info should be included.
As you suggested in Patch 4/6, I will add version, number of enabled pcr 
banks,
pcrUpdateCounter, and num_ima_measurements. I think we should include 
the TPM
version as well (1 v/s 2).

Please let me know if you think of any other attribute to record.

>>   	return rc;
>>   }
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 1bcd45cc5a6a..93357c245e82 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -1035,6 +1035,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>>   				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
>>   				   NULL, false, NULL, 0);
>>   	fdput(f);
>> +
>>   }
>>   
>>   /**
> Unnecessary change.
>
oops. Thanks for catching. Will fix.


~Tushar


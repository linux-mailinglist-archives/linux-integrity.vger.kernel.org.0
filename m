Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8728E76F4C9
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Aug 2023 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjHCVqS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 17:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjHCVqH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 17:46:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA69949D7
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 14:45:55 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id DF743207F5B0;
        Thu,  3 Aug 2023 14:45:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF743207F5B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691099155;
        bh=Q93SQ4X36h4pxUsa2NsSJNmaob4FBf2vL7NYb6qtqSc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dCDONyaJyOloSA+RTOU6wtthiVkOEmUwPw/DrzjiEoS/mQ+J/egXeHc18/Yp5HAXT
         1PH3wEozgKjtt4jOtv8ChIg2FN4PCX9jPULsriIHyM4+MRAcMZ54Lb9Rx+WtB5x8cO
         7WQyi9ZYTMGgvHZWsNPyrlm3s3ZCr8U3DjqMgJ1c=
Message-ID: <65bc533d-8775-579b-aae7-7ae0a936bf7e@linux.microsoft.com>
Date:   Thu, 3 Aug 2023 14:45:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] Measuring TPM update counter in IMA
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, ebiederm@xmission.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <dbfb545b-9399-d505-6739-c2940930ef48@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <dbfb545b-9399-d505-6739-c2940930ef48@linux.ibm.com>
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

Thanks Stefan for reviewing this series. Appreciate it.

Re-sending this email. I accidentally had some HTML content, the email
bounced back from integrity mailing list.

On 8/3/23 06:37, Stefan Berger wrote:
>
>
> On 8/1/23 14:19, Tushar Sugandhi wrote:
>> Entries in IMA log may be lost due to code bugs, certain error 
>> conditions
>
> I hope we don't have such bugs. And I guess the most critical ones 
> would be
> between logging and PCR extensions
I hope so too, but in general, it’s hard to prove a negative.
That’s why this patch series. :)
>
>
>> being met etc. This can result in TPM PCRs getting out of sync with the
>> IMA log.  One such example is events between kexec 'load' and kexec
>> 'execute' getting lost from the IMA log when the system soft-boots into
>> the new Kernel using kexec[1].  The remote attestation service does not
>
> Though this particular condition I thought would go away with your 
> kexec series.
Currently the events in-between kexec ‘load’ and ‘execute’ are always
lost – because IMA log is captured at ‘load’.  My kexec series addresses
this scenario. But as you said, there is always a possibility that the
events will still be lost during kexec because of error conditions, OOM
etc.
>
> The other conditions would be an out-of-memory or TPM failure. The OOM 
> would
> probably be more critical since something that was supposed to be logged
> couldn't be logged and now you cannot show this anymore and presumably 
> not even
> an error condition could be logged.
>
Precisely. As you can see in patch 5 of this series, I am logging the
counter at ima_init (ima_init_tpm_update_counter).  So we will get the
baseline counter at the system boot, where memory pressure is hopefully
low.  Even if we are not able to log the counter later due to OOM, this
baseline counter along with the number of events in the IMA log should
help detect if IMA log is missing events.
> https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_queue.c#L179 
>
>
>> have any information if the PCR mismatch with IMA log is because of loss
>> of entries in the IMA log or something else.  TPM 2.0 provides an update
>> counter which is incremented each time a PCR is updated [2]. 
>> Measuring the
>> TPM PCR update counter in IMA subsystem will help the remote attestation
>> service to validate if there are any missing entries in the IMA log, 
>> when
>
>
>
>> the system goes through certain important state changes (e.g. kexec soft
>> boot, IMA log snapshotting etc.)
>>
>> This patch series provides the required functionality to measure the
>> update counter through IMA subsystem by -
>>   - introducing a function to retrieve PCR update counter in the TPM
>>     subsystem.
>>   - IMA functionality to acquire the update counter from the TPM 
>> subsystem.
>>   - Measuring the update counter at system boot and at kexec Kernel
>>     load.
>
> Then the bugs you mentioned above that may happen between system boot 
> and kexec
> load are still going to confuse anyone looking at the log and quote. I 
> don't
> think you should mention them. I thought you would provide a way to sync
I used the kexec load-execute bug as an example to demonstrate the value of
measuring update counter.  There could be other examples which I am not
aware of.  As we discussed above, even when I fix the kexec bug – there is
still a possibility that events may go missing in error/OOM cases.

I can remove the kexec example if it is causing confusion.
Please let me know.
> up on every step...
I don’t fully understand what you mean by “provide a way to sync up
on every step”.  Could you please elaborate?
>
> Also, I thought you had a variable in your kexec series that would 
> prevent all further
> logging and measuring once the log had been marshalled during kexec 
> 'exec' stage
> and this wasn't necessary.
>
No, the variable suspend_ima_measurements[1] suspends the measurements
while copying the kexec buffer during kexec execute to ensure consistency
of the IMA measurements.  It doesn’t prevent all future logging. The
variable is reset and the IMA measurements resume when the system boots
into the new Kernel image.

[1] 
https://patchwork.kernel.org/project/linux-integrity/patch/20230703215709.1195644-10-tusharsu@linux.microsoft.com/

~Tushar
>    Stefan
>
>>
>>
>> This patch series would be a prerequisite for the next version of kexec
>> load/execute series[1] and the future IMA log snapshotting patch series.
>>
>> [1] 
>> https://lore.kernel.org/all/20230703215709.1195644-1-tusharsu@linux.microsoft.com/
>>      ima: measure events between kexec load and execute
>>
>> [2] 
>> https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
>>      Section 22.4.2, Page 206.
>>
>> Tushar Sugandhi (6):
>>    tpm: implement TPM2 function to get update counter
>>    tpm: provide functionality to get update counter
>>    ima: get TPM update counter
>>    ima: implement functionality to measure TPM update counter
>>    ima: measure TPM update counter at ima_init
>>    kexec: measure TPM update counter in ima log at kexec load
>>
>>   drivers/char/tpm/tpm-interface.c   | 28 +++++++++++++++++
>>   drivers/char/tpm/tpm.h             |  3 ++
>>   drivers/char/tpm/tpm2-cmd.c        | 48 ++++++++++++++++++++++++++++++
>>   include/linux/ima.h                |  1 +
>>   include/linux/tpm.h                |  8 +++++
>>   kernel/kexec_file.c                |  3 ++
>>   security/integrity/ima/ima.h       |  2 ++
>>   security/integrity/ima/ima_init.c  |  3 ++
>>   security/integrity/ima/ima_main.c  | 29 ++++++++++++++++++
>>   security/integrity/ima/ima_queue.c | 16 ++++++++++
>>   10 files changed, 141 insertions(+)
>>


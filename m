Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2526674F788
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjGKRvU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 13:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKRvR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 13:51:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5163E77
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 10:51:12 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id DEF3821C3A89;
        Tue, 11 Jul 2023 10:51:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEF3821C3A89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689097872;
        bh=efVTT0pRm4hRibHf/ZjkE6gdHUiHxMuVjy7rK43v89k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=swg4ZOfsgUpu6PUkNfx/Wct1dXjwpkizTjXuYLxjj2xRexzVusKmJ+6WPS0HA9uLG
         btanXo/jWx0tOO3EdTc6BPhnwJ9Ss1BoJe2wkG1YSJh0AdDwOnjlS7+nuWzgkanHyp
         86BO7whzBRwZPGPyocyBVDzhP72NW+Lri6dLwSOw=
Message-ID: <2d6fbdea-592c-1c30-753e-801b68ece0fe@linux.microsoft.com>
Date:   Tue, 11 Jul 2023 10:51:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/10] ima: measure events between kexec load and execute
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        ebiederm@xmission.com
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <37d03d69a89c344089b4e9d6e5b7b685f1c62cda.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <37d03d69a89c344089b4e9d6e5b7b685f1c62cda.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks for reviewing this series Mimi. Appreciate it.

Adding Eric to cc.

On 7/7/23 08:55, Mimi Zohar wrote:
> On Mon, 2023-07-03 at 14:56 -0700, Tushar Sugandhi wrote:
>> The current Kernel behavior is IMA measurements snapshot is taken at
>> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
>> over to the new Kernel after kexec 'execute'.
>>
>> Some devices can be configured to call kexec 'load' first, and followed
>> by kexec 'execute' after some time. (as opposed to calling 'load' and
>> 'execute' in one single kexec command).  In such scenario, if new IMA
>> measurements are added between kexec 'load' and kexec 'execute', the
>> TPM PCRs are extended with the IMA events between 'load' and 'execute';
>> but those IMA events are not carried over to the new kernel after kexec
>> soft reboot.  This results in mismatch between TPM PCR quotes and the
>> actual IMA measurements list after the device boots into the new kexec
>> image.  This mismatch results in the remote attestation failing for that
>> device.
>>
>> This patch series proposes a solution to solve this problem by allocating
>> the necessary buffer at kexec 'load' time, and populating the buffer
>> with the IMA measurements at kexec 'execute' time.
> Thanks, Tushar.   Depending on the IMA policy, the above problem
> statement is correct, but not all policies are affected by it.  It's
> also unclear why so much needs to change.  Instead of copying the
> measurement list at kexec 'load',  using the existing method and simply
> copying them at kexec 'exec' would suffice.
My understanding is the buffer must be allocated at kexec ‘load’ time.
The segment size cannot change between kexec ‘load’ and kexec ‘execute’.
Not sure if this is a technical limitation of IMA, or KEXEC.

Could you/someone from kexec side let me know?

If my current understanding is not correct, then I agree, simply copying
the measurements at kexec ‘execute’ using ima_dump_measurement_list should
suffice.

>
> Also as mentioned in comment on 3/10, the ordering of this patch set is
> not bisect safe.  If the same method of copying the measurement list
> was used, changing from copying at  kexec 'load'  to kexec 'exec' could
> be done in the same patch.
>
> Mimi
Ok. Based on my above response, if there is no such technical limitation
to allocate and copy at kexec ‘execute’ – I will simply move the call
to ima_dump_measurement_list from kexec 'load' to 'exec'.
And that can be done inthe same patch as you mentioned.

~Tushar
>
>> The solution includes:
>>   - addition of new functionality to allocate a buffer to hold IMA
>>     measurements at kexec 'load',
>>
>>   - ima functionality to suspend and resume measurements as needed during
>>     buffer copy at kexec 'execute',
>>
>>   - ima functionality for mapping the measurement list from the current
>>     Kernel to the subsequent one,
>>
>>   - necessary changes to the kexec_file_load syscall, enabling it to call
>>     the ima functions
>>
>>   - registering a reboot notifier which gets called during kexec 'execute',
>>
>>   - and removal of deprecated functions.
>>
>> The modifications proposed in this series ensure the integrity of the ima
>> measurements is preserved across kexec soft reboots, thus significantly
>> improving the security of the Kernel post kexec soft reboots.
>>
>> There were previous attempts to fix this issue [1], [2], [3].  But they
>> were not merged into the mainline Kernel.
>>
>> We took inspiration from the past work [1] and [2] while working on this
>> patch series.
>>
>> References:
>> -----------
>>
>> [1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
>> https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/
>>
>> [2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
>> https://lkml.org/lkml/2016/8/16/577
>>
>> [3] [PATCH 1/6] kexec_file: Add buffer hand-over support
>> https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/
>>
>> Tushar Sugandhi (10):
>>    ima: implement function to allocate buffer at kexec load
>>    ima: implement function to populate buffer at kexec execute
>>    ima: allocate buffer at kexec load to hold ima measurements
>>    ima: implement functions to suspend and resume measurements
>>    kexec: implement functions to map and unmap segment to kimage
>>    ima: update buffer at kexec execute with ima measurements
>>    ima: remove function ima_dump_measurement_list
>>    ima: implement and register a reboot notifier function to update kexec
>>      buffer
>>    ima: suspend measurements while the kexec buffer is being copied
>>    kexec: update kexec_file_load syscall to call ima_kexec_post_load
>>
>>   include/linux/ima.h                |   3 +
>>   include/linux/kexec.h              |  13 ++
>>   kernel/kexec_core.c                |  72 +++++++++-
>>   kernel/kexec_file.c                |   7 +
>>   kernel/kexec_internal.h            |   1 +
>>   security/integrity/ima/ima.h       |   4 +
>>   security/integrity/ima/ima_kexec.c | 211 +++++++++++++++++++++++------
>>   security/integrity/ima/ima_queue.c |  32 +++++
>>   8 files changed, 295 insertions(+), 48 deletions(-)
>>

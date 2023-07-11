Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8353774F78A
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 19:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjGKRwv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKRwu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 13:52:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 459C810C7
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 10:52:49 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 89C1721C3A93;
        Tue, 11 Jul 2023 10:52:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89C1721C3A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689097968;
        bh=bOmcrci2HPoHYlVwUho2VMxL4ObRHZgvgIPwuP8X0us=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AW3iqNSdPgtLp+qzLHJHsXJj4x5wJL1wmLc6wLQ7/znIVB9pjRy5pXLjwj2WQDyBC
         ayNfYd/ArcxsQv7XfRee5CVQ5y8D3WZPoYIHN5sdzX+kx6SY4hRVtbbpGKLgljCQ3x
         THVEHs4xiXnJnlRpCBU+rlpCDh2J8tVbcOATq1h8=
Message-ID: <565e0301-3a8b-0543-5ace-22a1484b67a4@linux.microsoft.com>
Date:   Tue, 11 Jul 2023 10:52:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/10] ima: measure events between kexec load and execute
Content-Language: en-US
To:     Dave Young <dyoung@redhat.com>
Cc:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <CALu+AoSyhnw0Cz06Mmqh+7FcLUF1q0txY1qbWLxkHO8OD5---Q@mail.gmail.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CALu+AoSyhnw0Cz06Mmqh+7FcLUF1q0txY1qbWLxkHO8OD5---Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Thanks Dave for taking a look at this.

I will keep Eric looped in on the next versions of this
patch series.

~Tushar

On 7/7/23 01:18, Dave Young wrote:
> [Add Eric in cc]
>
> On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
> <tusharsu@linux.microsoft.com> wrote:
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
>>
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
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>

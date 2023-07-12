Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A975113F
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jul 2023 21:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjGLTa3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jul 2023 15:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGLTa2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jul 2023 15:30:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88B35B7
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jul 2023 12:30:25 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id CAAA921C44E5;
        Wed, 12 Jul 2023 12:30:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAAA921C44E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689190225;
        bh=Yu+xJdcstGuYIdFXmY3aIzZrTs0/bPtsUuWd7EMLaVc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BDT+i0Qpl4arWVvlIM+98p/Wb2mlz6qlnfQBR0ByVk19cIGp/JMPGPSdueCTS0f1R
         5zor+uh4a6KF9Qh8SMWGaIObVDf+aKkd2kf53BTpWDnNaNGRQQRoqRvMt8Ei1WEGFo
         jdCPbvHM1oTehF/9BxOxsfHjayVP1pCtJKd2ZpPw=
Message-ID: <85dc6104-0d15-c31b-b36f-5345480d01e6@linux.microsoft.com>
Date:   Wed, 12 Jul 2023 12:30:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/10] kexec: update kexec_file_load syscall to call
 ima_kexec_post_load
Content-Language: en-US
To:     RuiRui Yang <ruyang@redhat.com>
Cc:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-11-tusharsu@linux.microsoft.com>
 <CALu+AoQC101fcbJjLdJHD7QtqeXzt5uOZDgNYvob0U_NGyaqCQ@mail.gmail.com>
 <b4047d8d-2c7c-e357-1c1f-cc55978fd963@linux.microsoft.com>
 <CALu+AoSWcEU7PfHvejYAuFWMEO6uGEWPnJMXuW2kNG-MUshFsw@mail.gmail.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CALu+AoSWcEU7PfHvejYAuFWMEO6uGEWPnJMXuW2kNG-MUshFsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/11/23 18:28, RuiRui Yang wrote:
> On Wed, 12 Jul 2023 at 03:15, Tushar Sugandhi
> <tusharsu@linux.microsoft.com> wrote:
>>
>> On 7/7/23 01:20, RuiRui Yang wrote:
>>> On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
>>> <tusharsu@linux.microsoft.com> wrote:
>>>> The kexec_file_load syscall is used to load a new kernel for kexec.
>>>> The syscall needs to update its function to call ima_kexec_post_load, which
>>>> was implemented in a previous patch.  ima_kexec_post_load takes care of
>>>> mapping the measurement list for the next kernel and registering a reboot
>>>> notifier if it's not already registered.
>>>>
>>>> Modify the kexec_file_load syscall to call ima_kexec_post_load after the
>>>> image has been loaded and prepared for kexec.  This ensures that the IMA
>>>> measurement list will be available to the next kernel after a kexec reboot.
>>>> This also ensures the measurements taken in the window between kexec load
>>>> and execute are captured and passed to the next kernel.
>>>>
>>>> Declare the kimage_file_post_load function in the kernel/kexec_internal.h,
>>>> so it can be properly used in the syscall.
>>>>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> ---
>>>>    kernel/kexec_file.c     | 7 +++++++
>>>>    kernel/kexec_internal.h | 1 +
>>>>    2 files changed, 8 insertions(+)
>>>>
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index f989f5f1933b..efe28e77280c 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
>>>>    }
>>>>    #endif
>>>>
>>>> +void kimage_file_post_load(struct kimage *image)
>>>> +{
>>>> +       ima_kexec_post_load(image);
>>>> +}
>>>> +
>>>>    /*
>>>>     * In file mode list of segments is prepared by kernel. Copy relevant
>>>>     * data from user space, do error checking, prepare segment list
>>>> @@ -399,6 +404,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>>>
>>>>           kimage_terminate(image);
>>>>
>>>> +       kimage_file_post_load(image);
>>> I think it should be only done for the reboot case,  please just
>>> exclude the kdump case here..
>>>
>> Thanks for the feedback RuiRui.  Appreciate it.
>>
>> Conceptually I agree with you that this needs to be done only for reboot.
>> I need to figure out how to do it implementation wise.
>>
>> If you can give me pointers/suggestions, that would help.
> Hi Tushar,
>
> You can check the flags argument in the function
> if (flags & KEXEC_FILE_ON_CRASH) is true then this is a kdump kernel
> loading, just skip the kimage_file_post_load in that case?
Great.  Thanks for the pointer.  Will do.
~Tushar
>> ~Tushar
>>>> +
>>>>           ret = machine_kexec_post_load(image);
>>>>           if (ret)
>>>>                   goto out;
>>>> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
>>>> index 74da1409cd14..98dd5fcafaf0 100644
>>>> --- a/kernel/kexec_internal.h
>>>> +++ b/kernel/kexec_internal.h
>>>> @@ -30,6 +30,7 @@ static inline void kexec_unlock(void)
>>>>
>>>>    #ifdef CONFIG_KEXEC_FILE
>>>>    #include <linux/purgatory.h>
>>>> +void kimage_file_post_load(struct kimage *image);
>>>>    void kimage_file_post_load_cleanup(struct kimage *image);
>>>>    extern char kexec_purgatory[];
>>>>    extern size_t kexec_purgatory_size;
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>>>

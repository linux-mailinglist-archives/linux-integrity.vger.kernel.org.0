Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC803B7870
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhF2TRM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 15:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233670AbhF2TRM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 15:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624994083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiKQQo0wX8VaWrqnv1DezbfWpj7gVAQd/qs1xr9p/Jk=;
        b=Tcd5YO4PZ6vxf/dYvEVMZMSc7oq1lllqRVObb+3IKzQkcOVz6GtjlkeodK3QQVyul/Qv7P
        Y99FHtvINxOaaIBm17wZSsShdEsUofALAvke2xeMqUjTb2hP9+6+ebgvBBN758Y/V8nW6f
        y6Cn9KclEBBZi3kCXhRpypsExxU86SE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-86ajVynsMDqVLR3C7YPu9w-1; Tue, 29 Jun 2021 15:14:42 -0400
X-MC-Unique: 86ajVynsMDqVLR3C7YPu9w-1
Received: by mail-ed1-f72.google.com with SMTP id z5-20020a05640235c5b0290393974bcf7eso11973661edc.2
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 12:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HiKQQo0wX8VaWrqnv1DezbfWpj7gVAQd/qs1xr9p/Jk=;
        b=Q6ijuvKfSefUzJubDvQS+QtjnXezHz50xxUaJyySsuVL9qI5mqn+peQAQkpBxttnJz
         mB7n38Boxswr0x5RQJSlEdxJL9Qg+kj3IgRklfGf+CfriIkVNaP0z99F78VuUBEkhbUf
         9im9RY6Dr2dPXu7NErekVdwcqvtwwE48VNVSCIZsKDbXG6OMiw60ufw1lsUfoJG76YUw
         5Ih9xm/lSzz+vJszQuS3VWXEbclSJf1ZvLOKuyFq/oTSpHpmNytOPD9tIasT1htjEVLx
         m9dWkGPhRBbeOKuP0Yo7Ag+x30KQfPfx8mm0TU/CZ3gVX+hNRgUWQifdca29F0YSqgvD
         8uwA==
X-Gm-Message-State: AOAM532gboOLP/Cl+vN/eBWEo3m2YdO4EltpqWXOI/tJwVe0QaLwBqSZ
        JaQtmO7EmawVTmqvtWYJN0RxLuuhNYF448W9S6uLi4A3dvoBq8/rRWlsN9qzow4EH6NMwbIkXp/
        kFFW+nWD/zx6UVtgRDVvsHwnbvEH5
X-Received: by 2002:a50:ff02:: with SMTP id a2mr29649816edu.12.1624994080913;
        Tue, 29 Jun 2021 12:14:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAKKzIRDTrsJP/CWoYuos5usES5+NyLBPSW+UAyhpktbwmlFCF9T3ehOk+D2TQv4jL/VxoLg==
X-Received: by 2002:a50:ff02:: with SMTP id a2mr29649804edu.12.1624994080741;
        Tue, 29 Jun 2021 12:14:40 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id v13sm12276545edl.47.2021.06.29.12.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 12:14:40 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel
 backtraces]
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
 <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
 <20210623134054.45gjj2wbgz7jpjmy@kernel.org>
 <90ed51b4-66d4-fb10-ca8e-d99532028fab@redhat.com>
 <20210629180445.oind62rsktevm45q@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b4398c5b-38dc-d511-ea29-0847bfca60b4@redhat.com>
Date:   Tue, 29 Jun 2021 21:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629180445.oind62rsktevm45q@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 6/29/21 8:04 PM, Jarkko Sakkinen wrote:
> On Wed, Jun 23, 2021 at 03:54:59PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 6/23/21 3:40 PM, Jarkko Sakkinen wrote:
>>> On Mon, Jun 21, 2021 at 02:04:52PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 6/14/21 3:33 PM, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 6/1/21 6:04 PM, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
>>>>>>>> Interestingly enough the first backtrace is also happening on a:
>>>>>>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
>>>>>>>>
>>>>>>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
>>>>>>>> all reports are about the XPS 13 9310. I wonder if there is an
>>>>>>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
>>>>>>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
>>>>>>>
>>>>>>> This is helpful for sure that these all are happening on matching hardware.
>>>>>>
>>>>>> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
>>>>>> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
>>>>>>
>>>>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
>>>>>>
>>>>>> 2. Backtrace starting with a call to tpm_dev_async_work:
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
>>>>>> (note this one is not easily reproducible)
>>>>>>
>>>>>> 3. Backtrace starting with a call to rng_dev_read:
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>>>>>
>>>>>> 3. is the new one. All bugs linked above are public, all 3 backtraces
>>>>>> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
>>>>>> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
>>>>>
>>>>> Quick status update, I've got a response from a XPS 13 9310 user in:
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>>>>
>>>>> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
>>>>> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
>>>>> (I expected this because all the bug-reports started when the interrupt
>>>>> code got fixed/re-enabled a while ago).
>>>>
>>>> One more status update.
>>>>
>>>> - A new 4th variant of the backtrace has been spotted, where the problem hits
>>>> when called from probe() -> tpm2_auto_startup -> tpm2_do_selftest, see:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1958381
>>>>
>>>> - So far all reports with kernel >= 5.12.6 have been on a Dell XPS 13 9310
>>>> models. But the new variant is happening on a Dell XPS 15 9500 and the
>>>> backtrace starting at ima_add_boot_aggregate is also being reported on
>>>> a Dell XPS 15 9500 (as well as on the XPS 13 9310).
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>
>>> OK, I'll have to query if I could borrow that laptop from someone. It's
>>> fairly common laptop, i.e. might be possible.
>>
>> In the mean time I've also got a report that this variant of the backtrace:
>>
>> 1. Backtrace starting with a call to ima_add_boot_aggregate
>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
>>
>> Is also still happening with recent 5.12.y kernels on
>> Dell Precision 7750 laptops. Both the Precision 7750 and the XPS 9500 use
>> 10th gen comet lake processors (i7-10750H), where as the XPS 9310 is using
>> an icelake processor. So the common denominator seems to be that they are
>> all 2020 Dell laptop models using the latest Intel CPUs.
>>
>> FYI the complete list of models on which some of the 4 backtrace variants
>> are still seen on recent 5.12.y kernels is now:
>>
>> Dell XPS 13 9310
>> Dell XPS 15 9500
>> Dell Precision 7750
>>
>> Regards,
>>
>> Hans
> 
> Does "tpm_tis.interrupts=0" uniformly workaround the issue?

I unfortunately have not gotten much replies to my request to test with
tpm_tis.interrupts=0, but for those people who have bothered to test
(2 reporters IIRC) using tpm_tis.interrupts=0 does avoid the issue.

Regards,

Hans


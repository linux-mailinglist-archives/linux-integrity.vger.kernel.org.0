Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EAE3AE8B4
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jun 2021 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFUMHP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Jun 2021 08:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230384AbhFUMHK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jun 2021 08:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624277095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vMXMECgTKv1EbT36un6SrUYbpKxvMVTqXwbPXrabIio=;
        b=dAL5u+lzz/X+sVdm79AOo7L8WcpgArHt3IbAl3V8sCrnrHLTpjXMLqRl/QiPqWZl+r2C3P
        DQIpwP+KL+CHtVvBAcnU7sA7KAqsUiJd2ASAmZ5zbKMRePCAnB/dA5OuqbO2Ur0JPAM2Qu
        s+XV4DUSoWnTvrKcVfb2dZpaiiEpBiI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-XwvkN0HkOJC39-mOI794vQ-1; Mon, 21 Jun 2021 08:04:54 -0400
X-MC-Unique: XwvkN0HkOJC39-mOI794vQ-1
Received: by mail-ej1-f70.google.com with SMTP id p20-20020a1709064994b02903cd421d7803so6258591eju.22
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jun 2021 05:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMXMECgTKv1EbT36un6SrUYbpKxvMVTqXwbPXrabIio=;
        b=GKkvoQPbeUQ+sIRkvxWKewsjKjxJsstDIyuNVeRYai/sssq01mFZy55IAD4KDq7znG
         6ZxateHopDeyivdDK5eNdW6F1XgUTSRoiqsJ+K0WTnOvRUQFDZ1dFoxrHUEk57IJxDVZ
         nqeYiK+xaCEKquR04kpMM/A7kjrkxj/hglgt/+OyUqu6MuutYchjv+J66lmuDg/r9cFI
         2sXybv1tYamhQohZCE+spIJdOxhYBeOUw+SDM9U2ojmZ/om6HGRjDYj2TkfHQx1jXZDz
         CEbfLarVPixYLPt0envcbTTHrJ2LaXE+NhPCgP7JbJDwSMrkZoGidIVeVvU/mJxA+u4X
         dPJA==
X-Gm-Message-State: AOAM533eF8OlQrcB26SjJEgJFWZoU2QwP7TzKw8zlD0Q8NEC8F22K0A6
        0qXM8Kz7HBFvqiX/nR72ACqzcmWuUdVddakFstQYXHC5rJzMXH57Lzo4eK+vn4kutcfwc6wVZSh
        NfTjpAO1dli2/ANDqS8m1W6Qdu+Ay
X-Received: by 2002:a17:906:b754:: with SMTP id fx20mr23327854ejb.201.1624277093305;
        Mon, 21 Jun 2021 05:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoXN1ojDw1HeXuzGcLSr2saYA+u+fYeQAfNNamLyk/rmMT8xy/nmT/H8o24jMb/OVHghwr4A==
X-Received: by 2002:a17:906:b754:: with SMTP id fx20mr23327832ejb.201.1624277093102;
        Mon, 21 Jun 2021 05:04:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i18sm2372804edc.7.2021.06.21.05.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:04:52 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
 <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
 <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
Message-ID: <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
Date:   Mon, 21 Jun 2021 14:04:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 6/14/21 3:33 PM, Hans de Goede wrote:
> Hi,
> 
> On 6/1/21 6:04 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
>>>> Interestingly enough the first backtrace is also happening on a:
>>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
>>>>
>>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
>>>> all reports are about the XPS 13 9310. I wonder if there is an
>>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
>>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
>>>
>>> This is helpful for sure that these all are happening on matching hardware.
>>
>> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
>> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
>>
>> 1. Backtrace starting with a call to ima_add_boot_aggregate
>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
>>
>> 2. Backtrace starting with a call to tpm_dev_async_work:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
>> (note this one is not easily reproducible)
>>
>> 3. Backtrace starting with a call to rng_dev_read:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>
>> 3. is the new one. All bugs linked above are public, all 3 backtraces
>> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
>> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
> 
> Quick status update, I've got a response from a XPS 13 9310 user in:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> 
> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
> (I expected this because all the bug-reports started when the interrupt
> code got fixed/re-enabled a while ago).

One more status update.

- A new 4th variant of the backtrace has been spotted, where the problem hits
when called from probe() -> tpm2_auto_startup -> tpm2_do_selftest, see:
https://bugzilla.redhat.com/show_bug.cgi?id=1958381

- So far all reports with kernel >= 5.12.6 have been on a Dell XPS 13 9310
models. But the new variant is happening on a Dell XPS 15 9500 and the
backtrace starting at ima_add_boot_aggregate is also being reported on
a Dell XPS 15 9500 (as well as on the XPS 13 9310).

Regards,

Hans



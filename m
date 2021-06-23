Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD4E3B1BA9
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Jun 2021 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFWN5Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Jun 2021 09:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230263AbhFWN5X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jun 2021 09:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624456505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTKC2qb/WgDFbqxokX/iGGUWt0xysgHmWGserYruli8=;
        b=EbUuWzPT6gyP5eEsw3yaU1D66EYO9UC0yW7cUFu4R8Bm7Mn4G4KuX4VqHtexJHpTwo3BcE
        B26Ox1NschopCirUogXmhx6q8rrCSYXzlqbqnF68/su3mOSznUIeTVfq0LkH48PiYlxqAD
        +Djf8T37B95gUHEMppBi2uI7H3H6eh8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-Hz6miqelMry3DoocgZERBg-1; Wed, 23 Jun 2021 09:55:01 -0400
X-MC-Unique: Hz6miqelMry3DoocgZERBg-1
Received: by mail-ej1-f71.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso1007530ejn.10
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jun 2021 06:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gTKC2qb/WgDFbqxokX/iGGUWt0xysgHmWGserYruli8=;
        b=GGX8U/tdRFJWdqfnNY/Fdx98xB0ht8WaFfUv3hPv1dVneZINIAbKR5OT2yC35X5slW
         x1rPMNZJzSdk6EQtSCT+JS98Xuji++bcjIt3Vt0pTAphwVco1nK+mUQrnVU4eIV7PtVB
         l1pfQTUH+R1fN8GLV66TiiK2dW4t8l5eHFfF5biF1n3WkrZVGphNioVPbk8jOzH9NH+k
         wJP54DGa5ywfk+2SrBW8cCvqQaAw1ctsXAFIyXPU0eCVyRggEEDbWRM688QZIFVNw7Z6
         kqhUNWzqzwUv9Lt7RO4ruItizDQMtwy6wPCJ5DZG2dV5g4pJOSAxkjD2N823yTbEvflJ
         tCkQ==
X-Gm-Message-State: AOAM531bgfrJspUb5MvIFFw+Ey7hxCq72u/Pdlo+Wato4Ka3L79ZVbOd
        g/pG2V76R+H7wDaD+heNTNHLJnedIIZhuIsZ4VK5USVqECa99Uv9fH7dqCxCFnguGqQmfBIKg40
        dPTxmF4JFCPQC7rS1PgSevdhLs6Ou
X-Received: by 2002:a17:906:3c42:: with SMTP id i2mr127411ejg.39.1624456500420;
        Wed, 23 Jun 2021 06:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTQxYRU3goWlKHmGhrvNi8aBPK9IDcNtzOi1bAOHoO+ryRCJgiBXsOijXYTCgoa97fhgtMeQ==
X-Received: by 2002:a17:906:3c42:: with SMTP id i2mr127397ejg.39.1624456500258;
        Wed, 23 Jun 2021 06:55:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d23sm52322eds.96.2021.06.23.06.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 06:54:59 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
 <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
 <20210623134054.45gjj2wbgz7jpjmy@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <90ed51b4-66d4-fb10-ca8e-d99532028fab@redhat.com>
Date:   Wed, 23 Jun 2021 15:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210623134054.45gjj2wbgz7jpjmy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 6/23/21 3:40 PM, Jarkko Sakkinen wrote:
> On Mon, Jun 21, 2021 at 02:04:52PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 6/14/21 3:33 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 6/1/21 6:04 PM, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
>>>>>> Interestingly enough the first backtrace is also happening on a:
>>>>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
>>>>>>
>>>>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
>>>>>> all reports are about the XPS 13 9310. I wonder if there is an
>>>>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
>>>>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
>>>>>
>>>>> This is helpful for sure that these all are happening on matching hardware.
>>>>
>>>> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
>>>> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
>>>>
>>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
>>>>
>>>> 2. Backtrace starting with a call to tpm_dev_async_work:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
>>>> (note this one is not easily reproducible)
>>>>
>>>> 3. Backtrace starting with a call to rng_dev_read:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>>>
>>>> 3. is the new one. All bugs linked above are public, all 3 backtraces
>>>> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
>>>> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
>>>
>>> Quick status update, I've got a response from a XPS 13 9310 user in:
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
>>>
>>> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
>>> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
>>> (I expected this because all the bug-reports started when the interrupt
>>> code got fixed/re-enabled a while ago).
>>
>> One more status update.
>>
>> - A new 4th variant of the backtrace has been spotted, where the problem hits
>> when called from probe() -> tpm2_auto_startup -> tpm2_do_selftest, see:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1958381
>>
>> - So far all reports with kernel >= 5.12.6 have been on a Dell XPS 13 9310
>> models. But the new variant is happening on a Dell XPS 15 9500 and the
>> backtrace starting at ima_add_boot_aggregate is also being reported on
>> a Dell XPS 15 9500 (as well as on the XPS 13 9310).
>>
>> Regards,
>>
>> Hans
> 
> OK, I'll have to query if I could borrow that laptop from someone. It's
> fairly common laptop, i.e. might be possible.

In the mean time I've also got a report that this variant of the backtrace:

1. Backtrace starting with a call to ima_add_boot_aggregate
https://bugzilla.redhat.com/show_bug.cgi?id=1963712

Is also still happening with recent 5.12.y kernels on
Dell Precision 7750 laptops. Both the Precision 7750 and the XPS 9500 use
10th gen comet lake processors (i7-10750H), where as the XPS 9310 is using
an icelake processor. So the common denominator seems to be that they are
all 2020 Dell laptop models using the latest Intel CPUs.

FYI the complete list of models on which some of the 4 backtrace variants
are still seen on recent 5.12.y kernels is now:

Dell XPS 13 9310
Dell XPS 15 9500
Dell Precision 7750

Regards,

Hans


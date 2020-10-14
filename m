Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC3728E2BC
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 17:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgJNPDS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 11:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbgJNPDR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 11:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602687795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fn4NjpcSWEQF8D1FGUViD+uc0UbBqUgMHiaWZYLHP1s=;
        b=HoJNhqmAOFKLO6bwdCnPN/02nYusg/a51SEw0JoSnI601u3qOyY9U4ntEbs7HPjmqk2vtn
        UD/EHQuGfnyVWPehVuculPFCTkeZ+1tvyw19CSEBGrgwMJBfLtjgVpAF9I5RwAC1pCHg60
        hdMSL0c7CVgT2q+/AdApVYFHDmcghLg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-6FS6jECnNz6P09gGThaNWg-1; Wed, 14 Oct 2020 11:03:13 -0400
X-MC-Unique: 6FS6jECnNz6P09gGThaNWg-1
Received: by mail-ed1-f72.google.com with SMTP id t4so1314351edv.7
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2020 08:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fn4NjpcSWEQF8D1FGUViD+uc0UbBqUgMHiaWZYLHP1s=;
        b=nO2SxkD9JK5YDCtyThDwv7pQmWVCbwcQOloO7SnANP3QSzWLqFBuUrnMxbdtIMd8hu
         Nq6iZ61zD6syrdHXhs6gVlX4FQcT0q34FZv9QJNi8flpI2C0e52ad+Lxn/VBhUdAweUM
         4xp7cn7nE0emoYeoaGIg5vOhBeV/uZYUVU0e+vETQJJBSHYC9ssl7qwQMhSA8gly63fo
         L43QTjqtJetCHy6Keps8aTUoeX1XE/vut9pOlqc05OpkMq4zre/GNs2eEOEaHI0Bsv9V
         8swhwvqD6/gX6TiYvW7MQ+O2YF3Ab00TsX6LTFM9WgB4I3ak9QfLf1R9Z0Zw7ObZeTu6
         7p5A==
X-Gm-Message-State: AOAM530Zlxhq//JbqBJudZcjqC2mLYjAbsxFIB+A7lVESpHwtlbmfxDG
        nC4DWVqrotb2BSkHpuxjT0ptnrVy3eISyRXrEr03XKkK6pz+O9GYrfCd405i5yS2NLVIIyh5ggj
        fbAtiN75G/OXNC3SPkVJxr22HwnSL
X-Received: by 2002:a17:906:4d10:: with SMTP id r16mr6101820eju.68.1602687791387;
        Wed, 14 Oct 2020 08:03:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuClzqyyr5qLhq11A4WXem4rjBtrXkEx2gOE7n120ScBrCcZOQSCcn7JvzXcvXSsjWOTcJLQ==
X-Received: by 2002:a17:906:4d10:: with SMTP id r16mr6101790eju.68.1602687791140;
        Wed, 14 Oct 2020 08:03:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id de16sm1797220edb.23.2020.10.14.08.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 08:03:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <e6930fa6df318ee2f51e13f6402d264fedb5d9ab.camel@HansenPartnership.com>
 <87lfgaf6ww.fsf@jsnitsel.users.ipa.redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5f9ead56-78ff-e8b4-d646-654c9a08c519@redhat.com>
Date:   Wed, 14 Oct 2020 17:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87lfgaf6ww.fsf@jsnitsel.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 10/13/20 6:05 PM, Jerry Snitselaar wrote:
> 
> James Bottomley @ 2020-10-13 08:24 MST:
> 
>> On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
>>> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
>>>
>>>> On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
>>>>> The current state of the TIS TPM is that interrupts have been
>>>>> globally disabled by various changes.  The problems we got
>>>>> reported the last time they were enabled was interrupt
>>>>> storms.  With my own TIS TPM, I've found that this is caused
>>>>> because my TPM doesn't do legacy cycles, The TIS spec (chapter
>>>>> 6.1 "Locality Usage Per Register") requires any TIS TPM without
>>>>> legacy cycles not to act on any write to an interrupt register
>>>>> unless the locality is enabled.  This means if an interrupt fires
>>>>> after we relinquish the locality, the TPM_EOI in the interrupt
>>>>> routine is ineffective meaning the same interrupt triggers over
>>>>> and over again.  This problem also means we can have trouble
>>>>> setting up interrupts on TIS TPMs because the current init
>>>>> code does the setup before the locality is claimed for the first
>>>>> time.
>>>>>
>>>>> James
>>>>
>>>> You should consider expanding the audience.
>>
>> Well, most people interested in testing this sort of thing are already
>> on the integrity list.
>>
>>>>   Jerry, once you have some bandwidth (no rush, does not land before
>>>> rc2), it would be great that if you could try this. I'm emphasizing
>>>> this just because of the intersection. I think it would also make
>>>> senset to get tested-by from Nayna.
>>>
>>> I will run some tests on some other systems I have access to. As
>>> noted in the other email I did a quick test with a t490s with an
>>> older bios that exhibits the problem originally reported when
>>> Stefan's patch enabled interrupts.
>>
>> Well, it means there's still some other problem.  I was hoping that
>> because the rainbow pass system originally exhibited the same symptoms
>> (interrupt storm) fixing it would also fix the t490 and the ineffective
>> EOI bug looked like a great candidate for being the root cause.
>>
> 
> Adding Hans to the list.
> 
> IIUC in the t490s case the problem lies with the hardware itself. Hans,
> is that correct?

More or less. AFAIK / have been told by Lenovo it is an issue with the
configuration of the inerrupt-type of the GPIO pin used for the IRQ,
which is a firmware issue which could be fixed by a BIOS update
(the pin is setup as a direct-irq pin for the APIC, so the OS has no
control of the IRQ type since with APIC irqs this is all supposed to
be setup properly before hand).

But it is a model specific issue, if we denylist IRQ usage on this
Lenovo model (and probably a few others) then we should be able to
restore the IRQ code to normal functionality for all other device
models which declare an IRQ in their resource tables.

Regards,

Hans


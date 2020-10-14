Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44AD28E502
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 19:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgJNRFA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 13:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbgJNRE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 13:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602695097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tij/aJsHRzoNX4uV1Y97136rXTzUTP98a7QnKMO3Shs=;
        b=RM5kHuMPigVaKpjNvAqGpq9hCc9mNTSEuFIecI1psSx+3JYjqnWl/iYZozLQ6H0q1KONP3
        ekcl2TahuYuN3qpxl42y6tp2JfYmyFauzADHSExNeLhHZVWJ+7CkxY4JM+h2gidDTXCN+8
        lhtJMRxMGxol/mZibZaxDFOCqIwdCRM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-O1IPNBWzO9isOZnHfk3P9g-1; Wed, 14 Oct 2020 13:04:56 -0400
X-MC-Unique: O1IPNBWzO9isOZnHfk3P9g-1
Received: by mail-ot1-f69.google.com with SMTP id t66so57933otb.0
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2020 10:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Tij/aJsHRzoNX4uV1Y97136rXTzUTP98a7QnKMO3Shs=;
        b=nQs7onzvBfIzpWVP6AIQn0FvRBtbpzmvgS0ORRqlrQgTQ5jusQKIAx9RqVWwA/TQWa
         6dZ2EzbpuDlh8VUY3sNxrHt80/zZPA5wd2wfaBAbqT8yIvNEiSchLvvxPVImWjFRi066
         q6Ymr3o+kF0iIEvDMzFieJk4Yv7eB94+Mkk3iefHvdlVy8p25palkGDLXM9LCAaQ8sB3
         AwwBGhY1BObK4utwPWUsNYWmT5+ahADqRmVJ9c+tJlx1qMaYoIHpzKPh61AMd3ceJPIA
         eJIffZ3dUu/16raKjywWIVO8TpF1F8ceMnyGBHMf6vZLfIVQKxzy5ZccHklVGMtYlJqa
         doOA==
X-Gm-Message-State: AOAM53315Fl/rBEeue8xEVvile9ax4uXRhdWeuBCvzm7ULBQeGB8aNnf
        fJrmdCCsA/2UEGwu/6kPE0iuNqgq/vHILafejWYQdN/twD0UE0f/rL1L2FTScbyTzvphbxe2fjO
        3oPJ/59zfRdYbLYukjfRD/+kJmMoo
X-Received: by 2002:a4a:e14e:: with SMTP id p14mr144747oot.17.1602695095357;
        Wed, 14 Oct 2020 10:04:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXJ+UJMf1+iERlkDs1N4U7d/rcNjddkeieO4SgkBtzbGpn7AyvC4CU/UOZINV/bErlAHpynA==
X-Received: by 2002:a4a:e14e:: with SMTP id p14mr144727oot.17.1602695095049;
        Wed, 14 Oct 2020 10:04:55 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id f70sm1407381otf.32.2020.10.14.10.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 10:04:54 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <e6930fa6df318ee2f51e13f6402d264fedb5d9ab.camel@HansenPartnership.com>
 <87lfgaf6ww.fsf@jsnitsel.users.ipa.redhat.com>
 <5f9ead56-78ff-e8b4-d646-654c9a08c519@redhat.com>
 <82a5c6e4a9f7fe037f12cd2eba7512bd8b04f21a.camel@HansenPartnership.com>
 <cd221dae-1c37-76d9-8ba2-1e4ceb528292@redhat.com>
 <87ft6gg41b.fsf@jsnitsel.users.ipa.redhat.com>
 <2553a8f3-6a71-7b05-52ab-8c346e2cb6ec@redhat.com>
 <87d01kg2sv.fsf@jsnitsel.users.ipa.redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        "Peter Huewe" <peterhuewe@gmx.de>, Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
In-reply-to: <87d01kg2sv.fsf@jsnitsel.users.ipa.redhat.com>
Date:   Wed, 14 Oct 2020 10:04:52 -0700
Message-ID: <87a6wog2mj.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jerry Snitselaar @ 2020-10-14 10:01 MST:

> Hans de Goede @ 2020-10-14 09:46 MST:
>
>> Hi,
>>
>> On 10/14/20 6:34 PM, Jerry Snitselaar wrote:
>>> Hans de Goede @ 2020-10-14 09:04 MST:
>>> 
>>>> Hi,
>>>>
>>>> On 10/14/20 5:23 PM, James Bottomley wrote:
>>>>> On Wed, 2020-10-14 at 17:03 +0200, Hans de Goede wrote:
>>>>>> On 10/13/20 6:05 PM, Jerry Snitselaar wrote:
>>>>>>> James Bottomley @ 2020-10-13 08:24 MST:
>>>>>>>> On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
>>>>>>>>> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
>>>>> [...]
>>>>>>>>>>     Jerry, once you have some bandwidth (no rush, does not land
>>>>>>>>>> before rc2), it would be great that if you could try this.
>>>>>>>>>> I'm emphasizing this just because of the intersection. I
>>>>>>>>>> think it would also make senset to get tested-by from Nayna.
>>>>>>>>>
>>>>>>>>> I will run some tests on some other systems I have access to.
>>>>>>>>> As noted in the other email I did a quick test with a t490s
>>>>>>>>> with an older bios that exhibits the problem originally
>>>>>>>>> reported when Stefan's patch enabled interrupts.
>>>>>>>>
>>>>>>>> Well, it means there's still some other problem.  I was hoping
>>>>>>>> that because the rainbow pass system originally exhibited the
>>>>>>>> same symptoms (interrupt storm) fixing it would also fix the t490
>>>>>>>> and the ineffective EOI bug looked like a great candidate for
>>>>>>>> being the root cause.
>>>>>>>>
>>>>>>>
>>>>>>> Adding Hans to the list.
>>>>>>>
>>>>>>> IIUC in the t490s case the problem lies with the hardware itself.
>>>>>>> Hans, is that correct?
>>>>>>
>>>>>> More or less. AFAIK / have been told by Lenovo it is an issue with
>>>>>> the configuration of the inerrupt-type of the GPIO pin used for the
>>>>>> IRQ, which is a firmware issue which could be fixed by a BIOS update
>>>>>> (the pin is setup as a direct-irq pin for the APIC, so the OS has no
>>>>>> control of the IRQ type since with APIC irqs this is all supposed to
>>>>>> be setup properly before hand).
>>>>>>
>>>>>> But it is a model specific issue, if we denylist IRQ usage on this
>>>>>> Lenovo model (and probably a few others) then we should be able to
>>>>>> restore the IRQ code to normal functionality for all other device
>>>>>> models which declare an IRQ in their resource tables.
>>>>> I can do that with a quirk, but how do I identify the device?  TPM
>>>>> manufacturer and version? or do I have to use something like the ACPI
>>>>> bios version?
>>>>
>>>> I'm not sure if the TPM ids are unique to one model/series of laptops.
>>>>
>>>> So my idea for this was to match on DMI strings, specifically
>>>> use a DMI match on the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION
>>>> strings (normally one would use DMI_PRODUCT_NAME but for Lenovo
>>>> devices the string which you expect to be in DMI_PRODUCT_NAME
>>>> is actually in DMI_PRODUCT_VERSION).
>>>>
>>>> You can easily get the strings for your device by doing:
>>>>
>>>> cat /sys/class/dmi/id/sys_vendor
>>>> cat /sys/class/dmi/id/product_version
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>> Plus use dmi_get_date(DMI_BIOS_DATE,...) to check
>>> if the bios is older than the fixed bios? Has Lenovo
>>> released the fixed bios?
>>
>> Maybe, the fixed BIOS-es which I have seen (for the X1C8,
>> broken BIOS was a pre-production BIOS) "fixed" this by
>> no longer listing an IRQ in the ACPI resources for the TPM.
>>
>> Which means that the new BIOS still being on the deny list
>> does not matter since the IRQ support won't work anyways as
>> we no longer get an IRQ assigned.
>>
>> So I don't think this is necessary and it will just complicate
>> things unnecessarily. This whole saga has already taken way
>> too long to fix. So IMHO the simplest fix where we just deny
>> list the broken models independent of BIOS versions and move
>> on seems best.
>>
>> Regards,
>>
>> Hans
>
> Yea, probably just best to disable for the model and be done
> with it.
>
> Regards,
> Jerry

# cat /sys/class/dmi/id/sys_vendor
LENOVO
# cat /sys/class/dmi/id/product_version
ThinkPad T490s


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF62828E4F7
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgJNRBO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 13:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730119AbgJNRBO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 13:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602694872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwvslIeWwZZPr76VE96lGYxEy2r3Hw5Y6jXKqMgEXVM=;
        b=gq8hfgeZJlw7VmHUgE3/Zg+vn48NgbtKMF8mVWGZyt+1b9iM58+XSuXU5qeYJonA0jyN0G
        jvG1eZCay7y3kNNa9/F+1ctKo8SkSoXp3kdymZx/Fm7iaR0BgRD+2wEy3VijNqn/7h4txn
        ebf5saHDu/cpO3puctHVunUi11D9NjQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-LVqaTaxSM-OBS-qzJaBuJw-1; Wed, 14 Oct 2020 13:01:09 -0400
X-MC-Unique: LVqaTaxSM-OBS-qzJaBuJw-1
Received: by mail-oo1-f71.google.com with SMTP id k26so35922oop.21
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2020 10:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PwvslIeWwZZPr76VE96lGYxEy2r3Hw5Y6jXKqMgEXVM=;
        b=NYXLQHRGQtqwIF5NOC++xkBDuE444BVWkfVuQL/l7xyUq4DVHzpZ+/QlrIAyon8+qR
         xCDVyvtdjyoIeJtx7MZMPRaczyvwUVmiRCl+GqXpANprflgcLnE3RsYw4osCLKbE7uFx
         AJbZac3TcCbU9AiZWuel7GfDFSO41KuU6pZapK1AEYuhW6T4oF4R7uDkjhGNOAjm3+b+
         KPHpvirSXdKr9LB18P/GGDW5SK1X7H4rGKyjmYB6CGPVsTzEar56CgKEXxBISV6tYMLI
         tApAkQLFpmBxFqesXMJZlXxmbbq0YZwIEfFPFPwfhwcDZvC837dnTiM40EvlkAOSaBi8
         mJIw==
X-Gm-Message-State: AOAM5306ZwOIPlP25PbrBtLELIJvJ0owmNrlE862fTMevtO9NacM6Hkm
        XWZJs3TXSb1f/a+rwmbVkVLOFhmErEzHzSGWfrQK3tE1xBDZFfi1kGpaCiqjhtqqQ02I7ga/JDH
        +vRE8MS6xT3g5Eaps4/RR7uA5BQTW
X-Received: by 2002:aca:53c8:: with SMTP id h191mr161166oib.173.1602694868255;
        Wed, 14 Oct 2020 10:01:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9deWxpaw1tkkcQ+UIV1Dx8aZzuabalBqJPFU0PFRznzYfDBCGGc9odAZjoUy68WieAl8+hg==
X-Received: by 2002:aca:53c8:: with SMTP id h191mr161134oib.173.1602694867839;
        Wed, 14 Oct 2020 10:01:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p8sm74250oot.29.2020.10.14.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 10:01:06 -0700 (PDT)
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
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
In-reply-to: <2553a8f3-6a71-7b05-52ab-8c346e2cb6ec@redhat.com>
Date:   Wed, 14 Oct 2020 10:01:04 -0700
Message-ID: <87d01kg2sv.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hans de Goede @ 2020-10-14 09:46 MST:

> Hi,
>
> On 10/14/20 6:34 PM, Jerry Snitselaar wrote:
>> Hans de Goede @ 2020-10-14 09:04 MST:
>> 
>>> Hi,
>>>
>>> On 10/14/20 5:23 PM, James Bottomley wrote:
>>>> On Wed, 2020-10-14 at 17:03 +0200, Hans de Goede wrote:
>>>>> On 10/13/20 6:05 PM, Jerry Snitselaar wrote:
>>>>>> James Bottomley @ 2020-10-13 08:24 MST:
>>>>>>> On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
>>>>>>>> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
>>>> [...]
>>>>>>>>>     Jerry, once you have some bandwidth (no rush, does not land
>>>>>>>>> before rc2), it would be great that if you could try this.
>>>>>>>>> I'm emphasizing this just because of the intersection. I
>>>>>>>>> think it would also make senset to get tested-by from Nayna.
>>>>>>>>
>>>>>>>> I will run some tests on some other systems I have access to.
>>>>>>>> As noted in the other email I did a quick test with a t490s
>>>>>>>> with an older bios that exhibits the problem originally
>>>>>>>> reported when Stefan's patch enabled interrupts.
>>>>>>>
>>>>>>> Well, it means there's still some other problem.  I was hoping
>>>>>>> that because the rainbow pass system originally exhibited the
>>>>>>> same symptoms (interrupt storm) fixing it would also fix the t490
>>>>>>> and the ineffective EOI bug looked like a great candidate for
>>>>>>> being the root cause.
>>>>>>>
>>>>>>
>>>>>> Adding Hans to the list.
>>>>>>
>>>>>> IIUC in the t490s case the problem lies with the hardware itself.
>>>>>> Hans, is that correct?
>>>>>
>>>>> More or less. AFAIK / have been told by Lenovo it is an issue with
>>>>> the configuration of the inerrupt-type of the GPIO pin used for the
>>>>> IRQ, which is a firmware issue which could be fixed by a BIOS update
>>>>> (the pin is setup as a direct-irq pin for the APIC, so the OS has no
>>>>> control of the IRQ type since with APIC irqs this is all supposed to
>>>>> be setup properly before hand).
>>>>>
>>>>> But it is a model specific issue, if we denylist IRQ usage on this
>>>>> Lenovo model (and probably a few others) then we should be able to
>>>>> restore the IRQ code to normal functionality for all other device
>>>>> models which declare an IRQ in their resource tables.
>>>> I can do that with a quirk, but how do I identify the device?  TPM
>>>> manufacturer and version? or do I have to use something like the ACPI
>>>> bios version?
>>>
>>> I'm not sure if the TPM ids are unique to one model/series of laptops.
>>>
>>> So my idea for this was to match on DMI strings, specifically
>>> use a DMI match on the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION
>>> strings (normally one would use DMI_PRODUCT_NAME but for Lenovo
>>> devices the string which you expect to be in DMI_PRODUCT_NAME
>>> is actually in DMI_PRODUCT_VERSION).
>>>
>>> You can easily get the strings for your device by doing:
>>>
>>> cat /sys/class/dmi/id/sys_vendor
>>> cat /sys/class/dmi/id/product_version
>>>
>>> Regards,
>>>
>>> Hans
>> Plus use dmi_get_date(DMI_BIOS_DATE,...) to check
>> if the bios is older than the fixed bios? Has Lenovo
>> released the fixed bios?
>
> Maybe, the fixed BIOS-es which I have seen (for the X1C8,
> broken BIOS was a pre-production BIOS) "fixed" this by
> no longer listing an IRQ in the ACPI resources for the TPM.
>
> Which means that the new BIOS still being on the deny list
> does not matter since the IRQ support won't work anyways as
> we no longer get an IRQ assigned.
>
> So I don't think this is necessary and it will just complicate
> things unnecessarily. This whole saga has already taken way
> too long to fix. So IMHO the simplest fix where we just deny
> list the broken models independent of BIOS versions and move
> on seems best.
>
> Regards,
>
> Hans

Yea, probably just best to disable for the model and be done
with it.

Regards,
Jerry


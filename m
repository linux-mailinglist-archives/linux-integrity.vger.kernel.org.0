Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DBC28E491
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgJNQed (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 12:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731138AbgJNQec (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 12:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602693270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbtQ2FYGbUz/+BEIDtu6W1K/eqpCITtFParTBk0vHy0=;
        b=NsR4/EYn34soxz2plfXEuMkmMMhswp8/vi85Xw/LX2hSz7NjvfM5H11v5Q/ch1CrD7ZpNf
        avbOkQS1Q51hIrUTAhwenGWSuQGrxM453Pyv9E9QCXrNc+owDqMvefiR9Inwgdlkem1H9b
        k7XjalNWC0XIGPHsVxC+MFVej9cNsds=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-HF9Iaf20PFafskACw21fGA-1; Wed, 14 Oct 2020 12:34:29 -0400
X-MC-Unique: HF9Iaf20PFafskACw21fGA-1
Received: by mail-ot1-f71.google.com with SMTP id v7so2186ots.19
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2020 09:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xbtQ2FYGbUz/+BEIDtu6W1K/eqpCITtFParTBk0vHy0=;
        b=nxje9Z4NTW+m6ZVURkr8o86ZrFKX26K1enijCo+w5zibi0RXTXjc52HbHJ87RWU1ap
         V+/jiYcAjKxFbxGZCGpb12/QtcUzDsJccAFQtaXq+N5Pv5j4tNH8pHQGqCQ07ItGT+zG
         pmBL1gAW32kZMO6wsvZFcHLKE/zgsV030siZDy/j97Sl9peW5aMOt9wnETnG6vFcQL88
         QgdUJAyFoW64/HrA4XpKVis/t7eT+HdggbIT1hYmaX+O3tkSqyS9Kwx1Xgamj9wvJQpH
         psy1vkV7nmFUNAEQg8rFt3XwECeghR+K/g74lRRnxkqlME+LOeyM8eHgKYnhZtI64jm/
         9iwA==
X-Gm-Message-State: AOAM531RYAqDyozuBg5zPt8ufLiUpWgjJnA4WAt8ml8QjjQ9ely2SXJn
        wkuKCet95FI8KdcUr7NNryuOUQBCWqo3hIcvetQWDLDvhwadgO+TmkelYTLz4a1y0rIWNQ+LQTK
        uiGoTIOPHIxXJV4a0kxaSG4UPdDwL
X-Received: by 2002:a9d:3626:: with SMTP id w35mr4363282otb.206.1602693267879;
        Wed, 14 Oct 2020 09:34:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRI0q/8Zr/ZHrkPiMavgXi84TEgPo6Ndc+eRzuHUoZySFq4B847KaoEnFzk2pSwFnx10EIHA==
X-Received: by 2002:a9d:3626:: with SMTP id w35mr4363259otb.206.1602693267605;
        Wed, 14 Oct 2020 09:34:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 91sm1365225ott.55.2020.10.14.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 09:34:26 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <e6930fa6df318ee2f51e13f6402d264fedb5d9ab.camel@HansenPartnership.com>
 <87lfgaf6ww.fsf@jsnitsel.users.ipa.redhat.com>
 <5f9ead56-78ff-e8b4-d646-654c9a08c519@redhat.com>
 <82a5c6e4a9f7fe037f12cd2eba7512bd8b04f21a.camel@HansenPartnership.com>
 <cd221dae-1c37-76d9-8ba2-1e4ceb528292@redhat.com>
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
In-reply-to: <cd221dae-1c37-76d9-8ba2-1e4ceb528292@redhat.com>
Date:   Wed, 14 Oct 2020 09:34:24 -0700
Message-ID: <87ft6gg41b.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hans de Goede @ 2020-10-14 09:04 MST:

> Hi,
>
> On 10/14/20 5:23 PM, James Bottomley wrote:
>> On Wed, 2020-10-14 at 17:03 +0200, Hans de Goede wrote:
>>> On 10/13/20 6:05 PM, Jerry Snitselaar wrote:
>>>> James Bottomley @ 2020-10-13 08:24 MST:
>>>>> On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
>>>>>> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
>> [...]
>>>>>>>    Jerry, once you have some bandwidth (no rush, does not land
>>>>>>> before rc2), it would be great that if you could try this.
>>>>>>> I'm emphasizing this just because of the intersection. I
>>>>>>> think it would also make senset to get tested-by from Nayna.
>>>>>>
>>>>>> I will run some tests on some other systems I have access to.
>>>>>> As noted in the other email I did a quick test with a t490s
>>>>>> with an older bios that exhibits the problem originally
>>>>>> reported when Stefan's patch enabled interrupts.
>>>>>
>>>>> Well, it means there's still some other problem.  I was hoping
>>>>> that because the rainbow pass system originally exhibited the
>>>>> same symptoms (interrupt storm) fixing it would also fix the t490
>>>>> and the ineffective EOI bug looked like a great candidate for
>>>>> being the root cause.
>>>>>
>>>>
>>>> Adding Hans to the list.
>>>>
>>>> IIUC in the t490s case the problem lies with the hardware itself.
>>>> Hans, is that correct?
>>>
>>> More or less. AFAIK / have been told by Lenovo it is an issue with
>>> the configuration of the inerrupt-type of the GPIO pin used for the
>>> IRQ, which is a firmware issue which could be fixed by a BIOS update
>>> (the pin is setup as a direct-irq pin for the APIC, so the OS has no
>>> control of the IRQ type since with APIC irqs this is all supposed to
>>> be setup properly before hand).
>>>
>>> But it is a model specific issue, if we denylist IRQ usage on this
>>> Lenovo model (and probably a few others) then we should be able to
>>> restore the IRQ code to normal functionality for all other device
>>> models which declare an IRQ in their resource tables.
>> I can do that with a quirk, but how do I identify the device?  TPM
>> manufacturer and version? or do I have to use something like the ACPI
>> bios version?
>
> I'm not sure if the TPM ids are unique to one model/series of laptops.
>
> So my idea for this was to match on DMI strings, specifically
> use a DMI match on the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION
> strings (normally one would use DMI_PRODUCT_NAME but for Lenovo
> devices the string which you expect to be in DMI_PRODUCT_NAME
> is actually in DMI_PRODUCT_VERSION).
>
> You can easily get the strings for your device by doing:
>
> cat /sys/class/dmi/id/sys_vendor
> cat /sys/class/dmi/id/product_version
>
> Regards,
>
> Hans

Plus use dmi_get_date(DMI_BIOS_DATE,...) to check
if the bios is older than the fixed bios? Has Lenovo
released the fixed bios?


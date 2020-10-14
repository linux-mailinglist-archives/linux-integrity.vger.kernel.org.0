Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B223128E3F0
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgJNQEb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 12:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728035AbgJNQEa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 12:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602691469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKKEIxLiwYAld7BBNbAA11NBtGXWfzuJ/DUfWaXfBRY=;
        b=i1aeW9ltsf14nAp5ieKE/jDNIqa6NW/lyM3CyOflvLgQv1K52OMSLtmnPMYOoDf8hYq4H/
        Oar9+s53wjeSJJtZVWbpV6GhmSJks+ymngZSjtHgzFWjzXB3mVVNlceEZ6RUhsmumys8Hk
        DY5TAUGsWNt5mFGxgoYplBhYMRQ4enY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-N2qL4LZ6NzGBM3rgT6OmRQ-1; Wed, 14 Oct 2020 12:04:27 -0400
X-MC-Unique: N2qL4LZ6NzGBM3rgT6OmRQ-1
Received: by mail-ed1-f70.google.com with SMTP id h6so40991edt.12
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2020 09:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gKKEIxLiwYAld7BBNbAA11NBtGXWfzuJ/DUfWaXfBRY=;
        b=s23INaZDb3hC+8Hvxm0yX6bekO5ViPZpwAWuGQSPNIbT5vPu3v9JxRCQdNkYIb7dj+
         9cCqJnkRBRmWF+icSvbr5VcumJUKLqmqkVUxVxirf4hMS6XnniF1wtODIuvQvDi3oX6s
         Gz3u4sjOE5vUZeE7lec7q7iNgbk964GsH2V43vfTYI9MkWZSIbaavPBYRRG//rlb3qqy
         oKSGhhgxsYjbUsyE35b3Xzst3dbfe2pcHZoKFe6cVgNhWlMQRKeLqjk9w/BjlJOGt4Ac
         2nIelAhRNTIvS3rPmaE6Ex+qhePlGt2xOG57IblfGS3enRMXVvl371neV9rnru/mUxrH
         wjCA==
X-Gm-Message-State: AOAM533XERtqD4NdtZ8qbxEkWCJq0oLMRXjeMiamAU/DHusccuTTvuIt
        8UmbuWLDJVerFATrqJ//9JZRZE32ofz8RaD3esVqDPCRj6zEXl0jQ5/BMiA5pOQShOJEhrWbd8q
        Nd2hlaKNulG1slRSxSciRrJnoGOix
X-Received: by 2002:a17:906:1a11:: with SMTP id i17mr5898310ejf.381.1602691466008;
        Wed, 14 Oct 2020 09:04:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycQIyk02DIGmuMauMBecXUDtAAkmwPUwfe/KNQ/5DhAEyOy5RIVTpwbc/FO4Eykp1po4dxIQ==
X-Received: by 2002:a17:906:1a11:: with SMTP id i17mr5898291ejf.381.1602691465749;
        Wed, 14 Oct 2020 09:04:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i5sm1960264ejs.121.2020.10.14.09.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 09:04:25 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
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
 <5f9ead56-78ff-e8b4-d646-654c9a08c519@redhat.com>
 <82a5c6e4a9f7fe037f12cd2eba7512bd8b04f21a.camel@HansenPartnership.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cd221dae-1c37-76d9-8ba2-1e4ceb528292@redhat.com>
Date:   Wed, 14 Oct 2020 18:04:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <82a5c6e4a9f7fe037f12cd2eba7512bd8b04f21a.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 10/14/20 5:23 PM, James Bottomley wrote:
> On Wed, 2020-10-14 at 17:03 +0200, Hans de Goede wrote:
>> On 10/13/20 6:05 PM, Jerry Snitselaar wrote:
>>> James Bottomley @ 2020-10-13 08:24 MST:
>>>> On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
>>>>> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
> [...]
>>>>>>    Jerry, once you have some bandwidth (no rush, does not land
>>>>>> before rc2), it would be great that if you could try this.
>>>>>> I'm emphasizing this just because of the intersection. I
>>>>>> think it would also make senset to get tested-by from Nayna.
>>>>>
>>>>> I will run some tests on some other systems I have access to.
>>>>> As noted in the other email I did a quick test with a t490s
>>>>> with an older bios that exhibits the problem originally
>>>>> reported when Stefan's patch enabled interrupts.
>>>>
>>>> Well, it means there's still some other problem.  I was hoping
>>>> that because the rainbow pass system originally exhibited the
>>>> same symptoms (interrupt storm) fixing it would also fix the t490
>>>> and the ineffective EOI bug looked like a great candidate for
>>>> being the root cause.
>>>>
>>>
>>> Adding Hans to the list.
>>>
>>> IIUC in the t490s case the problem lies with the hardware itself.
>>> Hans, is that correct?
>>
>> More or less. AFAIK / have been told by Lenovo it is an issue with
>> the configuration of the inerrupt-type of the GPIO pin used for the
>> IRQ, which is a firmware issue which could be fixed by a BIOS update
>> (the pin is setup as a direct-irq pin for the APIC, so the OS has no
>> control of the IRQ type since with APIC irqs this is all supposed to
>> be setup properly before hand).
>>
>> But it is a model specific issue, if we denylist IRQ usage on this
>> Lenovo model (and probably a few others) then we should be able to
>> restore the IRQ code to normal functionality for all other device
>> models which declare an IRQ in their resource tables.
> 
> I can do that with a quirk, but how do I identify the device?  TPM
> manufacturer and version? or do I have to use something like the ACPI
> bios version?

I'm not sure if the TPM ids are unique to one model/series of laptops.

So my idea for this was to match on DMI strings, specifically
use a DMI match on the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION
strings (normally one would use DMI_PRODUCT_NAME but for Lenovo
devices the string which you expect to be in DMI_PRODUCT_NAME
is actually in DMI_PRODUCT_VERSION).

You can easily get the strings for your device by doing:

cat /sys/class/dmi/id/sys_vendor
cat /sys/class/dmi/id/product_version

Regards,

Hans


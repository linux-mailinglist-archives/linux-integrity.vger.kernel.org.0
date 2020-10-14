Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB57228E826
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 22:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgJNU6N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 16:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbgJNU6N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 16:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602709091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F5+PFcmVoL75SYi8XqJc0S+StVnlko2S7Ctn7DERUvQ=;
        b=ZNNr9j3FLhTip5HPGSgCZNYhFM789wtxD38FCK1q1NKSr35EwNrKtWKxDtx2PLEyIErcPo
        eUnYtGVBoqkJa1Ilmi+2v2cUYI6yZd6PF6ET73MPTR8izreXVBTkESQLrV2X9To0x3a5YX
        rj6bj3f9vX8HLANHxNn1mDAMA5I7kL0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-atSu3cgOOA2SrDtDGxZ1bw-1; Wed, 14 Oct 2020 16:58:09 -0400
X-MC-Unique: atSu3cgOOA2SrDtDGxZ1bw-1
Received: by mail-pj1-f72.google.com with SMTP id d21so265242pjw.0
        for <linux-integrity@vger.kernel.org>; Wed, 14 Oct 2020 13:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=F5+PFcmVoL75SYi8XqJc0S+StVnlko2S7Ctn7DERUvQ=;
        b=s5fGx0Z0q1wPb6s1tSGjpg0vauKg+HoxBHPf5U84Q4I+F6LQxCygSQdu/p3pomtUTS
         ZxpJGJTMaspFGD5WYuMMOJpuhSQ51moR5TDz05DlOM/tWClKgH5YU90pww0kyiOqEF2t
         r1MLi/uTAlcFJqBOeaNtXXSwinAfHtns/SCeF7K2MNNSF0PBu1Nz6dZVA3dzQGemjmoL
         GmR5m7Lv3vrwKa37ZXJdLPbPvRgRIZnjlO0Uu/5zgMtAht+j54jJabRu5aG1NMa4LFwW
         UnuC0pXiEH2ppfdKzIkelj4hFxYD7DeHZVId/z6hXiE2wuBj9YPCEftjGnvBxuQ6Te3l
         bIjg==
X-Gm-Message-State: AOAM532/UvjPUOPl+mlwsnPlEJUoHOML0LoJdCb3rsAb8oJxJB53c0q9
        HmjXArSyImtLoM78hfIPOqGcsNv9Az0PIXAf4S4mS/9g6Llqp4fdB2s8QnWfCqW19ZUtyVRt7+g
        wZIYMa+E65hx+ue5nrhQBcNszbhb4
X-Received: by 2002:a17:902:267:b029:d3:8b4f:54d6 with SMTP id 94-20020a1709020267b02900d38b4f54d6mr839121plc.39.1602709088709;
        Wed, 14 Oct 2020 13:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkzCD417MIfDROQXoXhZ+9hkSYEacB9udA8ng25Mv7hRvQGRp3Sza+kJ8htTdwVTq16Da3qA==
X-Received: by 2002:a17:902:267:b029:d3:8b4f:54d6 with SMTP id 94-20020a1709020267b02900d38b4f54d6mr839097plc.39.1602709088375;
        Wed, 14 Oct 2020 13:58:08 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i2sm441527pjk.12.2020.10.14.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 13:58:07 -0700 (PDT)
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
Date:   Wed, 14 Oct 2020 13:58:04 -0700
Message-ID: <87sgagv82r.fsf@jsnitsel.users.ipa.redhat.com>
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

This worked for me:

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 0b214963539d..abe674d1de6d 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/kernel.h>
+#include <linux/dmi.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"

@@ -63,6 +64,26 @@ module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
 #endif

+static int tpm_tis_disable_irq(const struct dmi_system_id *d)
+{
+       pr_notice("tpm_tis: %s detected: disabling interrupts.\n", d->ident);
+       interrupts = false;
+
+       return 0;
+}
+
+static const struct dmi_system_id tpm_tis_dmi_table[] = {
+       {
+               .callback = tpm_tis_disable_irq,
+               .ident = "ThinkPad T490s",
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                       DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
+               },
+       },
+       {}
+};
+
 #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
 static int has_hid(struct acpi_device *dev, const char *hid)
 {
@@ -192,6 +213,8 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
        int irq = -1;
        int rc;

+       dmi_check_system(tpm_tis_dmi_table);
+
        rc = check_acpi_tpm2(dev);
        if (rc)
                return rc;


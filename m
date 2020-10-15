Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3828F8DD
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgJOSs1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 14:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgJOSs0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 14:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602787704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cTUyz1qobTwbt+eCfOuN8CzafpEghJzufGGu8NroTTA=;
        b=J8wvnqKUxWmNpPH+YkUa0W2GfKV5IAXqmfiU9PZBHZNbJBnlIQOKIgXSqHygF0Uinpk/Tc
        4/+nLyIOj6p4hbF1e6PkgyhrmGiWZ++ZnvFECgErg2MJs/e6jWa6kB+Hn1Fnc6FnE2J3wM
        oepS6IAa5zpwNZKxfWTlx+iPeGtHZMI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-FKbU5ji1NFKytI_3TzHDhA-1; Thu, 15 Oct 2020 14:48:21 -0400
X-MC-Unique: FKbU5ji1NFKytI_3TzHDhA-1
Received: by mail-oo1-f70.google.com with SMTP id g9so1684094ooq.17
        for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2020 11:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=cTUyz1qobTwbt+eCfOuN8CzafpEghJzufGGu8NroTTA=;
        b=e0cD52sRgv6AUdQPGU40kvBptIs0kAUnDEUHGQgmsskyznqAshLDaPE6tpMYRDWKUw
         ED7xgYn1LuFVXJnXUIrZ7OhkQoOnNLKpJt+r9P//n2rQNU4BZbEIgFwLYbdMXItH+LaL
         c02MZJyOze8zbFYVmU6v32neFSxqjDFOEk1iUxlQO7mnjRQk7HlPiHgW+PG6l93pnI3t
         jtU12Ht6zf6qx2ZpsEJpsKQBkFm61MMuFkva5D4x4Ak2QQCoBRpfxh8e6Sgk4qh4Pk/W
         zEpwENxJknfG+UY9taAy7KBYD9O7QfSAxLestTkJIb36KHMMWJ1Xp9uVsojic/eB08C7
         iZ3w==
X-Gm-Message-State: AOAM531Mo4lCDAaBHeKXXXIp2lUjospMyNwPDmznp884DP1DLESBJ1gA
        v5ugxgPGbg+3nCNalZFJ7nKPZR9bggQZtLqcsNO/+uO7lSW9khY93571ymdFN9Y4nIkTsYj/TWA
        N8Rzfgl0WogsvSUvH/NM2JV4VxTtk
X-Received: by 2002:aca:abce:: with SMTP id u197mr113291oie.135.1602787700591;
        Thu, 15 Oct 2020 11:48:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMSM5tY4HAaM2R8csWZ6cep7u5ALHU4Ph01WLZeV5kdxIfv0gwMGDkp+UJiOXZ4wInUhIMag==
X-Received: by 2002:aca:abce:: with SMTP id u197mr113278oie.135.1602787700293;
        Thu, 15 Oct 2020 11:48:20 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p21sm13758oto.21.2020.10.15.11.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:48:19 -0700 (PDT)
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
 <87sgagv82r.fsf@jsnitsel.users.ipa.redhat.com>
 <c16b45762ccc824b7a4d3aa5340a978c42d4ee6c.camel@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
In-reply-to: <c16b45762ccc824b7a4d3aa5340a978c42d4ee6c.camel@HansenPartnership.com>
Date:   Thu, 15 Oct 2020 11:48:17 -0700
Message-ID: <87mu0nba1a.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-15 08:36 MST:

> On Wed, 2020-10-14 at 13:58 -0700, Jerry Snitselaar wrote:
>> Hans de Goede @ 2020-10-14 09:46 MST:
>> 
>> > Hi,
>> > 
>> > On 10/14/20 6:34 PM, Jerry Snitselaar wrote:
>> > > Hans de Goede @ 2020-10-14 09:04 MST:
>> > > 
>> > > > Hi,
>> > > > 
>> > > > On 10/14/20 5:23 PM, James Bottomley wrote:
>> > > > > On Wed, 2020-10-14 at 17:03 +0200, Hans de Goede wrote:
>> > > > > > On 10/13/20 6:05 PM, Jerry Snitselaar wrote:
>> > > > > > > James Bottomley @ 2020-10-13 08:24 MST:
>> > > > > > > > On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar
>> > > > > > > > wrote:
>> > > > > > > > > Jarkko Sakkinen @ 2020-10-12 18:17 MST:
>> > > > > [...]
>> > > > > > > > > >     Jerry, once you have some bandwidth (no rush,
>> > > > > > > > > > does not land
>> > > > > > > > > > before rc2), it would be great that if you could
>> > > > > > > > > > try this.
>> > > > > > > > > > I'm emphasizing this just because of the
>> > > > > > > > > > intersection. I
>> > > > > > > > > > think it would also make senset to get tested-by
>> > > > > > > > > > from Nayna.
>> > > > > > > > > 
>> > > > > > > > > I will run some tests on some other systems I have
>> > > > > > > > > access to.
>> > > > > > > > > As noted in the other email I did a quick test with a
>> > > > > > > > > t490s
>> > > > > > > > > with an older bios that exhibits the problem
>> > > > > > > > > originally
>> > > > > > > > > reported when Stefan's patch enabled interrupts.
>> > > > > > > > 
>> > > > > > > > Well, it means there's still some other problem.  I was
>> > > > > > > > hoping
>> > > > > > > > that because the rainbow pass system originally
>> > > > > > > > exhibited the
>> > > > > > > > same symptoms (interrupt storm) fixing it would also
>> > > > > > > > fix the t490
>> > > > > > > > and the ineffective EOI bug looked like a great
>> > > > > > > > candidate for
>> > > > > > > > being the root cause.
>> > > > > > > > 
>> > > > > > > 
>> > > > > > > Adding Hans to the list.
>> > > > > > > 
>> > > > > > > IIUC in the t490s case the problem lies with the hardware
>> > > > > > > itself.
>> > > > > > > Hans, is that correct?
>> > > > > > 
>> > > > > > More or less. AFAIK / have been told by Lenovo it is an
>> > > > > > issue with
>> > > > > > the configuration of the inerrupt-type of the GPIO pin used
>> > > > > > for the
>> > > > > > IRQ, which is a firmware issue which could be fixed by a
>> > > > > > BIOS update
>> > > > > > (the pin is setup as a direct-irq pin for the APIC, so the
>> > > > > > OS has no
>> > > > > > control of the IRQ type since with APIC irqs this is all
>> > > > > > supposed to
>> > > > > > be setup properly before hand).
>> > > > > > 
>> > > > > > But it is a model specific issue, if we denylist IRQ usage
>> > > > > > on this
>> > > > > > Lenovo model (and probably a few others) then we should be
>> > > > > > able to
>> > > > > > restore the IRQ code to normal functionality for all other
>> > > > > > device
>> > > > > > models which declare an IRQ in their resource tables.
>> > > > > I can do that with a quirk, but how do I identify the
>> > > > > device?  TPM
>> > > > > manufacturer and version? or do I have to use something like
>> > > > > the ACPI
>> > > > > bios version?
>> > > > 
>> > > > I'm not sure if the TPM ids are unique to one model/series of
>> > > > laptops.
>> > > > 
>> > > > So my idea for this was to match on DMI strings, specifically
>> > > > use a DMI match on the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION
>> > > > strings (normally one would use DMI_PRODUCT_NAME but for Lenovo
>> > > > devices the string which you expect to be in DMI_PRODUCT_NAME
>> > > > is actually in DMI_PRODUCT_VERSION).
>> > > > 
>> > > > You can easily get the strings for your device by doing:
>> > > > 
>> > > > cat /sys/class/dmi/id/sys_vendor
>> > > > cat /sys/class/dmi/id/product_version
>> > > > 
>> > > > Regards,
>> > > > 
>> > > > Hans
>> > > Plus use dmi_get_date(DMI_BIOS_DATE,...) to check
>> > > if the bios is older than the fixed bios? Has Lenovo
>> > > released the fixed bios?
>> > 
>> > Maybe, the fixed BIOS-es which I have seen (for the X1C8,
>> > broken BIOS was a pre-production BIOS) "fixed" this by
>> > no longer listing an IRQ in the ACPI resources for the TPM.
>> > 
>> > Which means that the new BIOS still being on the deny list
>> > does not matter since the IRQ support won't work anyways as
>> > we no longer get an IRQ assigned.
>> > 
>> > So I don't think this is necessary and it will just complicate
>> > things unnecessarily. This whole saga has already taken way
>> > too long to fix. So IMHO the simplest fix where we just deny
>> > list the broken models independent of BIOS versions and move
>> > on seems best.
>> > 
>> > Regards,
>> > 
>> > Hans
>> 
>> This worked for me:
>> 
>> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
>> index 0b214963539d..abe674d1de6d 100644
>> --- a/drivers/char/tpm/tpm_tis.c
>> +++ b/drivers/char/tpm/tpm_tis.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/kernel.h>
>> +#include <linux/dmi.h>
>>  #include "tpm.h"
>>  #include "tpm_tis_core.h"
>> 
>> @@ -63,6 +64,26 @@ module_param(force, bool, 0444);
>>  MODULE_PARM_DESC(force, "Force device probe rather than using ACPI
>> entry");
>>  #endif
>> 
>> +static int tpm_tis_disable_irq(const struct dmi_system_id *d)
>> +{
>> +       pr_notice("tpm_tis: %s detected: disabling interrupts.\n", d-
>> >ident);
>> +       interrupts = false;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct dmi_system_id tpm_tis_dmi_table[] = {
>> +       {
>> +               .callback = tpm_tis_disable_irq,
>> +               .ident = "ThinkPad T490s",
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad
>> T490s"),
>> +               },
>> +       },
>> +       {}
>> +};
>> +
>>  #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
>>  static int has_hid(struct acpi_device *dev, const char *hid)
>>  {
>> @@ -192,6 +213,8 @@ static int tpm_tis_init(struct device *dev,
>> struct tpm_info *tpm_info)
>>         int irq = -1;
>>         int rc;
>> 
>> +       dmi_check_system(tpm_tis_dmi_table);
>> +
>>         rc = check_acpi_tpm2(dev);
>>         if (rc)
>>                 return rc;
>
> This looks OK to me with the caveat that anyone on one of these systems
> has no way to enable interrupts again if they think they have a fixed
> bios.  What about making interrupts a tristate with the default value
> -1?  Then in the dmi check, if we see -1 we set it to 0 but if we see 1
> (the user has specified interrupts=1 on the module insert line) we
> leave it?
>
> James

like this?

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 0b214963539d..10c46cb26c5a 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/kernel.h>
+#include <linux/dmi.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"

@@ -49,8 +50,8 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
        return container_of(data, struct tpm_tis_tcg_phy, priv);
 }

-static bool interrupts = true;
-module_param(interrupts, bool, 0444);
+static int interrupts = -1;
+module_param(interrupts, int, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");

 static bool itpm;
@@ -63,6 +64,27 @@ module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
 #endif

+static int tpm_tis_disable_irq(const struct dmi_system_id *d)
+{
+       pr_notice("tpm_tis: %s detected: disabling interrupts.\n", d->ident);
+       if (interrupts == -1)
+               interrupts = 0;
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
@@ -192,6 +214,8 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
        int irq = -1;
        int rc;

+       dmi_check_system(tpm_tis_dmi_table);
+
        rc = check_acpi_tpm2(dev);
        if (rc)
                return rc;


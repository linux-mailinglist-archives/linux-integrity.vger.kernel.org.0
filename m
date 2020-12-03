Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8096E2CCF01
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Dec 2020 07:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgLCGNO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Dec 2020 01:13:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbgLCGNO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Dec 2020 01:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606975906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQAIwUXcjB6wRQDWsdNxzY57+rR1rUDwSyGL8e4Dwkk=;
        b=D7ITBoLxDYax+cOxJvHJq1W6KsX2MEVdu7wAj4k10+W4ZE0Knv2ruwyRJmfgNd7DWiZn+J
        EzmBKE796wlYkmpwwwMDvNKr6AEXYpDa0fOHK5itROPBoDmEqeRpMEx6XRUd12cVWFEXwE
        YXMhS2eNz1pamtJuGTOxIEUUTC1cvIk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-w-M7OGB-M-WpSZ8XSShWrA-1; Thu, 03 Dec 2020 01:11:45 -0500
X-MC-Unique: w-M7OGB-M-WpSZ8XSShWrA-1
Received: by mail-il1-f200.google.com with SMTP id f2so839556ils.6
        for <linux-integrity@vger.kernel.org>; Wed, 02 Dec 2020 22:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=aQAIwUXcjB6wRQDWsdNxzY57+rR1rUDwSyGL8e4Dwkk=;
        b=bct3WZ41Keq6CJvWOxBbCRVPkFGT8MQOHjQWXZuRIzoA73cWjrItnbRMDXHQB7lH16
         UwKWP0B4fklJCe8z5j6uVrU2LE+ahauxm9VRFD3whl7rQprlbLW9sAQo2HRRS7eoVMhl
         IGbn3k4vXdfWTmAPZTfabpxPnFD6TALcVc3fNBRkI/zSFEHaZnUwrtUdfLHPrZ6RkUod
         EvbNuVw0S61qjPu4f1GVBnzzlXl+omf/WI0OasystD/JmfZpSwk4az5TwOk272ro1od8
         QQDfqAWDljpD3QojON/gZoR2bzf/ODDhbgsDZiaTGgHHdVW/0FfEllWXKC6dLaf5Ks8p
         cCaA==
X-Gm-Message-State: AOAM530WZUjh8v8t/E0yZ2YcRcxs7vjTeNv4w+C3a8SWJbwXAC1kqAvm
        TRLfsljnIsP9SJk+9ThbuRZVXaAs73wLu6aBl/ppATdECQ7EgLG8AmlkITNDtnelihbuVQySrSo
        oliYY/JuaEwYFOANN5Y16QxQbRcHt
X-Received: by 2002:a05:6e02:17c6:: with SMTP id z6mr1755066ilu.268.1606975904494;
        Wed, 02 Dec 2020 22:11:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfQwzuQLoGkGlqTPjaAXyXzL9mzgDCwzUEDkteFg6B5Iu3hPMsOeU6EeldHeDRRte1HSRI+Q==
X-Received: by 2002:a05:6e02:17c6:: with SMTP id z6mr1755047ilu.268.1606975904245;
        Wed, 02 Dec 2020 22:11:44 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e18sm120051ilm.77.2020.12.02.22.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:11:43 -0800 (PST)
References: <20201130232338.106892-1-jsnitsel@redhat.com>
 <20201201025807.162241-1-jsnitsel@redhat.com> <87czzujjg1.fsf@redhat.com>
 <878sahmh5w.fsf@redhat.com> <20201202164931.GA91318@kernel.org>
 <87sg8noixh.fsf@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] tpm_tis: Disable interrupts if interrupt storm detected
In-reply-to: <87sg8noixh.fsf@redhat.com>
Date:   Wed, 02 Dec 2020 23:11:41 -0700
Message-ID: <87lfefe7vm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jerry Snitselaar @ 2020-12-02 17:02 MST:

> Jarkko Sakkinen @ 2020-12-02 09:49 MST:
>
>> On Tue, Dec 01, 2020 at 12:59:23PM -0700, Jerry Snitselaar wrote:
>>> 
>>> Jerry Snitselaar @ 2020-11-30 20:26 MST:
>>> 
>>> > Jerry Snitselaar @ 2020-11-30 19:58 MST:
>>> >
>>> >> When enabling the interrupt code for the tpm_tis driver we have
>>> >> noticed some systems have a bios issue causing an interrupt storm to
>>> >> occur. The issue isn't limited to a single tpm or system manufacturer
>>> >> so keeping a denylist of systems with the issue isn't optimal. Instead
>>> >> try to detect the problem occurring, disable interrupts, and revert to
>>> >> polling when it happens.
>>> >>
>>> >> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>> >> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>> >> Cc: Peter Huewe <peterhuewe@gmx.de>
>>> >> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>>> >> Cc: Matthew Garrett <mjg59@google.com>
>>> >> Cc: Hans de Goede <hdegoede@redhat.com>
>>> >> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>> >> ---
>>> >> v2: drop tpm_tis specific workqueue and use just system_wq
>>> >>
>>> >> drivers/char/tpm/tpm_tis_core.c | 27 +++++++++++++++++++++++++++
>>> >>  drivers/char/tpm/tpm_tis_core.h |  2 ++
>>> >>  2 files changed, 29 insertions(+)
>>> >>
>>> >> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>>> >> index 23b60583928b..72cc8a5a152c 100644
>>> >> --- a/drivers/char/tpm/tpm_tis_core.c
>>> >> +++ b/drivers/char/tpm/tpm_tis_core.c
>>> >> @@ -24,6 +24,8 @@
>>> >>  #include <linux/wait.h>
>>> >>  #include <linux/acpi.h>
>>> >>  #include <linux/freezer.h>
>>> >> +#include <linux/workqueue.h>
>>> >> +#include <linux/kernel_stat.h>
>>> >>  #include "tpm.h"
>>> >>  #include "tpm_tis_core.h"
>>> >>  
>>> >> @@ -745,9 +747,23 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>> >>  {
>>> >>  	struct tpm_chip *chip = dev_id;
>>> >>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>> >> +	static bool check_storm = true;
>>> >> +	static unsigned int check_start;
>>> >>  	u32 interrupt;
>>> >>  	int i, rc;
>>> >>  
>>> >> +	if (unlikely(check_storm)) {
>>> >> +		if (!check_start) {
>>> >> +			check_start = jiffies_to_msecs(jiffies);
>>> >> +		} else if ((kstat_irqs(priv->irq) > 1000) &&
>>> >> +			   (jiffies_to_msecs(jiffies) - check_start < 500)) {
>>> >> +			check_storm = false;
>>> >> +			schedule_work(&priv->storm_work);
>>> >> +		} else if (jiffies_to_msecs(jiffies) - check_start >= 500) {
>>> >> +			check_storm = false;
>>> >> +		}
>>> >> +	}
>>> >> +
>>> >>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>> >>  	if (rc < 0)
>>> >>  		return IRQ_NONE;
>>> >> @@ -987,6 +1003,14 @@ static const struct tpm_class_ops tpm_tis = {
>>> >>  	.clk_enable = tpm_tis_clkrun_enable,
>>> >>  };
>>> >>  
>>> >> +static void tpm_tis_storm_work(struct work_struct *work)
>>> >> +{
>>> >> +	struct tpm_tis_data *priv = container_of(work, struct tpm_tis_data, storm_work);
>>> >> +
>>> >> +	disable_interrupts(priv->chip);
>>> >> +	dev_warn(&priv->chip->dev, "Interrupt storm detected, using polling.\n");
>>> >> +}
>>> >> +
>>> >>  int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>> >>  		      const struct tpm_tis_phy_ops *phy_ops,
>>> >>  		      acpi_handle acpi_dev_handle)
>>> >> @@ -1003,6 +1027,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>> >>  	if (IS_ERR(chip))
>>> >>  		return PTR_ERR(chip);
>>> >>  
>>> >> +	priv->chip = chip;
>>> >> +	INIT_WORK(&priv->storm_work, tpm_tis_storm_work);
>>> >> +
>>> >>  #ifdef CONFIG_ACPI
>>> >>  	chip->acpi_dev_handle = acpi_dev_handle;
>>> >>  #endif
>>> >> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>>> >> index edeb5dc61c95..5630f294dc0c 100644
>>> >> --- a/drivers/char/tpm/tpm_tis_core.h
>>> >> +++ b/drivers/char/tpm/tpm_tis_core.h
>>> >> @@ -95,6 +95,8 @@ struct tpm_tis_data {
>>> >>  	u16 clkrun_enabled;
>>> >>  	wait_queue_head_t int_queue;
>>> >>  	wait_queue_head_t read_queue;
>>> >> +	struct work_struct storm_work;
>>> >> +	struct tpm_chip *chip;
>>> >>  	const struct tpm_tis_phy_ops *phy_ops;
>>> >>  	unsigned short rng_quality;
>>> >>  };
>>> >
>>> > I've tested this with the Intel platform that has an Infineon chip that
>>> > I found the other week. It works, but isn't the complete fix. With this
>>> > on top of James' patchset I sometimes see the message "Lost Interrupt
>>> > waiting for TPM stat", so I guess there needs to be a check in
>>> > wait_for_tpm_stat and request_locality to see if interrupts were
>>> > disabled when the wait_event_interruptible_timeout call times out.
>>> 
>>> As kernel test robot pointed out. kstat_irqs isn't visible when tpm_tis
>>> builds as a module. It looks like it is only called by kstat_irq_usrs,
>>> and that is only by the fs/proc code. I have a patch to export it, but
>>> the i915 driver open codes their own version instead of using it. Is
>>> there any reason not to export it?
>>
>> If you add a patch that exports it, then for coherency it'd be better to
>> also patch i915 driver. Jani?
>>
>> /Jarkko
>
> It looks like this might not solve all cases. I'm having Lenovo test
> another build to make sure I gave them the right code, but they reported
> with the L490 that the system hangs right when it is initializing
> tpm_tis. I'm working on getting a build on the T490s I have to try there
> as well. With the Intel system it spits out that it detects the
> interrupt storm, and continues on its way.

The interrupt storm detection code works on the T490s. I'm not sure what
is going on with the L490. I will see if I can get access to one.

Jerry


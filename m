Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3D2CACEA
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 21:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404424AbgLAUA4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 15:00:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404421AbgLAUAz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 15:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606852767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G9sp3R9tf8dt5XOtnWwBkrzI+r6TYZwd5QycIhToDrU=;
        b=M2BnGBmuQmbFzOCCNFsK3rhVWfOaBuxqZsKhi209QeIoYg9OcqR4PH3bmmNG5o7BWIU/Kp
        shEfClEdhUFbmZ24ja+IqyZkSVnu1oFifDZsr6F3JvrOi6Y6XVoqWwsGL552JlI2ImUrh9
        5BodJrXAwxt24FAZrppV9oGriC/BG8I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-eLQRG06wMLqKYdInC5VnAQ-1; Tue, 01 Dec 2020 14:59:26 -0500
X-MC-Unique: eLQRG06wMLqKYdInC5VnAQ-1
Received: by mail-qk1-f198.google.com with SMTP id u67so2264990qkd.6
        for <linux-integrity@vger.kernel.org>; Tue, 01 Dec 2020 11:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=G9sp3R9tf8dt5XOtnWwBkrzI+r6TYZwd5QycIhToDrU=;
        b=eg4daDegqv5I92XmgeB4O70SOI7rF/tRalDpf/SpLL4Sy6fG7xMsLRPHKN8hGFpmfD
         IyRFcmLUYpCv5J5voITySlVZ0dhOn0NHMtHPlDc62TDsCb231Iq3ns7Pmf1XQjqiwL4u
         5LyGAvtgHmahsmqNS+3IJkWYmf507Y4OJdI+HYTfY7Y3HFWXnBBzZ4psDRzxdzCM/s4/
         woEf00sxE9elpMesiFWhaIWtEOasNoZNjP9xDXcxty0B2xhCyh0K9i4Y1tWRFfzjq8pw
         g0c/qGTcWohAH92M6mDMERR8fpP5xPJkFs2po6f1WHVwO+2atIo/TD5+wKlbmbTBxGUy
         1xPg==
X-Gm-Message-State: AOAM533Vakb+6NvOkUwMD1nNuZ80lIspNQL5Ok6tpIP3N1A/8UMbJqBb
        PsdsYtUQWZy/XBvfA4AecmZGvFHgc62JBj91f8HI2kUXORri+Pyg24QzPXFXXZDWVJMBWLckcWJ
        fcSQzSOapPdlrn7HdG7gclb3s42OV
X-Received: by 2002:ac8:524d:: with SMTP id y13mr4617142qtn.319.1606852765954;
        Tue, 01 Dec 2020 11:59:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwK7kRfRFSwZNABSwui3VBp0sV2pKB5Lqj1f9VFfGjgAhwdSFLX+gljPD86diPL/wfjVctngA==
X-Received: by 2002:ac8:524d:: with SMTP id y13mr4617125qtn.319.1606852765771;
        Tue, 01 Dec 2020 11:59:25 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y35sm765505qty.58.2020.12.01.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:59:25 -0800 (PST)
References: <20201130232338.106892-1-jsnitsel@redhat.com>
 <20201201025807.162241-1-jsnitsel@redhat.com> <87czzujjg1.fsf@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] tpm_tis: Disable interrupts if interrupt storm detected
In-reply-to: <87czzujjg1.fsf@redhat.com>
Date:   Tue, 01 Dec 2020 12:59:23 -0700
Message-ID: <878sahmh5w.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jerry Snitselaar @ 2020-11-30 20:26 MST:

> Jerry Snitselaar @ 2020-11-30 19:58 MST:
>
>> When enabling the interrupt code for the tpm_tis driver we have
>> noticed some systems have a bios issue causing an interrupt storm to
>> occur. The issue isn't limited to a single tpm or system manufacturer
>> so keeping a denylist of systems with the issue isn't optimal. Instead
>> try to detect the problem occurring, disable interrupts, and revert to
>> polling when it happens.
>>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Peter Huewe <peterhuewe@gmx.de>
>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Cc: Matthew Garrett <mjg59@google.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> ---
>> v2: drop tpm_tis specific workqueue and use just system_wq
>>
>> drivers/char/tpm/tpm_tis_core.c | 27 +++++++++++++++++++++++++++
>>  drivers/char/tpm/tpm_tis_core.h |  2 ++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 23b60583928b..72cc8a5a152c 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -24,6 +24,8 @@
>>  #include <linux/wait.h>
>>  #include <linux/acpi.h>
>>  #include <linux/freezer.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/kernel_stat.h>
>>  #include "tpm.h"
>>  #include "tpm_tis_core.h"
>>  
>> @@ -745,9 +747,23 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>  {
>>  	struct tpm_chip *chip = dev_id;
>>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +	static bool check_storm = true;
>> +	static unsigned int check_start;
>>  	u32 interrupt;
>>  	int i, rc;
>>  
>> +	if (unlikely(check_storm)) {
>> +		if (!check_start) {
>> +			check_start = jiffies_to_msecs(jiffies);
>> +		} else if ((kstat_irqs(priv->irq) > 1000) &&
>> +			   (jiffies_to_msecs(jiffies) - check_start < 500)) {
>> +			check_storm = false;
>> +			schedule_work(&priv->storm_work);
>> +		} else if (jiffies_to_msecs(jiffies) - check_start >= 500) {
>> +			check_storm = false;
>> +		}
>> +	}
>> +
>>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>  	if (rc < 0)
>>  		return IRQ_NONE;
>> @@ -987,6 +1003,14 @@ static const struct tpm_class_ops tpm_tis = {
>>  	.clk_enable = tpm_tis_clkrun_enable,
>>  };
>>  
>> +static void tpm_tis_storm_work(struct work_struct *work)
>> +{
>> +	struct tpm_tis_data *priv = container_of(work, struct tpm_tis_data, storm_work);
>> +
>> +	disable_interrupts(priv->chip);
>> +	dev_warn(&priv->chip->dev, "Interrupt storm detected, using polling.\n");
>> +}
>> +
>>  int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>  		      const struct tpm_tis_phy_ops *phy_ops,
>>  		      acpi_handle acpi_dev_handle)
>> @@ -1003,6 +1027,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>  	if (IS_ERR(chip))
>>  		return PTR_ERR(chip);
>>  
>> +	priv->chip = chip;
>> +	INIT_WORK(&priv->storm_work, tpm_tis_storm_work);
>> +
>>  #ifdef CONFIG_ACPI
>>  	chip->acpi_dev_handle = acpi_dev_handle;
>>  #endif
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>> index edeb5dc61c95..5630f294dc0c 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -95,6 +95,8 @@ struct tpm_tis_data {
>>  	u16 clkrun_enabled;
>>  	wait_queue_head_t int_queue;
>>  	wait_queue_head_t read_queue;
>> +	struct work_struct storm_work;
>> +	struct tpm_chip *chip;
>>  	const struct tpm_tis_phy_ops *phy_ops;
>>  	unsigned short rng_quality;
>>  };
>
> I've tested this with the Intel platform that has an Infineon chip that
> I found the other week. It works, but isn't the complete fix. With this
> on top of James' patchset I sometimes see the message "Lost Interrupt
> waiting for TPM stat", so I guess there needs to be a check in
> wait_for_tpm_stat and request_locality to see if interrupts were
> disabled when the wait_event_interruptible_timeout call times out.

As kernel test robot pointed out. kstat_irqs isn't visible when tpm_tis
builds as a module. It looks like it is only called by kstat_irq_usrs,
and that is only by the fs/proc code. I have a patch to export it, but
the i915 driver open codes their own version instead of using it. Is
there any reason not to export it?


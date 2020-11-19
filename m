Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95792B8BBB
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Nov 2020 07:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgKSGg3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Nov 2020 01:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgKSGg2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Nov 2020 01:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605767786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iMc/gvKwqM4AzkZ+P2n75WcftR/IHFubAtNec01gIhI=;
        b=EHw+1sN2O8+cZm7aNpgOxl9dYpwIThVDKDwVzDeasCVGnmflRZcErgjAopiruR3F6lMgzq
        Wiqf6mb6u/ISL1xmMdJOzIsv3nxOxCUQi7Ha1qGfsmvhnPoyVFpF0o9TO1SISeEBvnIE9o
        GjyCsV3yLA7KQXw3HNmm/rJVLBPa6lM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-nnU-nGOZPJ-aGjiLCOtsZw-1; Thu, 19 Nov 2020 01:36:24 -0500
X-MC-Unique: nnU-nGOZPJ-aGjiLCOtsZw-1
Received: by mail-il1-f197.google.com with SMTP id p17so4180624ilb.5
        for <linux-integrity@vger.kernel.org>; Wed, 18 Nov 2020 22:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=iMc/gvKwqM4AzkZ+P2n75WcftR/IHFubAtNec01gIhI=;
        b=hzaUG0I11kdAir0UTTFR9L7stqshlDHzpP5f8s00coFHsu19XaeD9ZJucCfck6kN/L
         C/l9qEkc1md0wDq9BqA5cie786eezNStJgztCz9i+vdjyBRrKu8EodwgGlqHHypNnPAX
         cMVrem/UtbPUnLQxmel/UitFPDNPrZnBsikPhSEx3ywVKsbZiAo7BpMXn4NfYuxdaFDj
         M5X3iqxPNFbfhoiOdA5X77/di5tmv/urOOu4WKsn0auS71mLtxFsuRWQLq7aROG0GeB1
         JrREAJytQqzGWsgfMfvxrV+FPEDpgC9B0Ngktf8BG1QW+pUJP2c07blUbKRcMwJGI/7U
         zuWg==
X-Gm-Message-State: AOAM532HeEiJtIzHhPb9Wxe9RW32AG0ympV1olGaA+Rg17BL1BK9ymXG
        DfzUa1z5mR6r5CdH9PCRF59PL4qBdQaW+SjBOT3+IRoBNQfp70sl0PqeFMPZ1WdagCbbT5RY4o6
        7c7uH3uQ7HrnNeFV1u3N+On5abumb
X-Received: by 2002:a92:dd91:: with SMTP id g17mr17780376iln.12.1605767783261;
        Wed, 18 Nov 2020 22:36:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUlv74DqDRPtC8qPdQ8fwEPR18nkvA8Itzpp4H34wf7FxcIXXI77Cz6yyypbD4U5uD+lQqLA==
X-Received: by 2002:a92:dd91:: with SMTP id g17mr17780357iln.12.1605767782910;
        Wed, 18 Nov 2020 22:36:22 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b4sm16931032ile.13.2020.11.18.22.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 22:36:22 -0800 (PST)
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
In-reply-to: <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
Date:   Wed, 18 Nov 2020 23:36:20 -0700
Message-ID: <87d009c0pn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Matthew Garrett @ 2020-10-15 15:39 MST:

> On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>
>> There is a misconfiguration in the bios of the gpio pin used for the
>> interrupt in the T490s. When interrupts are enabled in the tpm_tis
>> driver code this results in an interrupt storm. This was initially
>> reported when we attempted to enable the interrupt code in the tpm_tis
>> driver, which previously wasn't setting a flag to enable it. Due to
>> the reports of the interrupt storm that code was reverted and we went back
>> to polling instead of using interrupts. Now that we know the T490s problem
>> is a firmware issue, add code to check if the system is a T490s and
>> disable interrupts if that is the case. This will allow us to enable
>> interrupts for everyone else. If the user has a fixed bios they can
>> force the enabling of interrupts with tpm_tis.interrupts=1 on the
>> kernel command line.
>
> I think an implication of this is that systems haven't been
> well-tested with interrupts enabled. In general when we've found a
> firmware issue in one place it ends up happening elsewhere as well, so
> it wouldn't surprise me if there are other machines that will also be
> unhappy with interrupts enabled. Would it be possible to automatically
> detect this case (eg, if we get more than a certain number of
> interrupts in a certain timeframe immediately after enabling the
> interrupt) and automatically fall back to polling in that case? It
> would also mean that users with fixed firmware wouldn't need to pass a
> parameter.

I believe Matthew is correct here. I found another system today
with completely different vendor for both the system and the tpm chip.
In addition another Lenovo model, the L490, has the issue.

This initial attempt at a solution like Matthew suggested works on
the system I found today, but I imagine it is all sorts of wrong.
In the 2 systems where I've seen it, there are about 100000 interrupts
in around 1.5 seconds, and then the irq code shuts down the interrupt
because they aren't being handled.


diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 49ae09ac604f..478e9d02a3fa 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -27,6 +27,11 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"

+static unsigned int time_start = 0;
+static bool storm_check = true;
+static bool storm_killed = false;
+static u32 irqs_fired = 0;
+
 static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);

 static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8 mask)
@@ -464,25 +469,31 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
        return rc;
 }

-static void disable_interrupts(struct tpm_chip *chip)
+static void __disable_interrupts(struct tpm_chip *chip)
 {
        struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
        u32 intmask;
        int rc;

-       if (priv->irq == 0)
-               return;
-
        rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
        if (rc < 0)
                intmask = 0;

        intmask &= ~TPM_GLOBAL_INT_ENABLE;
        rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
+}
+
+static void disable_interrupts(struct tpm_chip *chip)
+{
+       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

+       if (priv->irq == 0)
+               return;
+
+       __disable_interrupts(chip);
        devm_free_irq(chip->dev.parent, priv->irq, chip);
        priv->irq = 0;
-       chip->flags &= ~TPM_CHIP_FLAG_IRQ;
 }

 /*
@@ -528,6 +539,12 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
        int rc, irq;
        struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

+       if (unlikely(storm_killed)) {
+               devm_free_irq(chip->dev.parent, priv->irq, chip);
+               priv->irq = 0;
+               storm_killed = false;
+       }
+
        if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
                return tpm_tis_send_main(chip, buf, len);

@@ -748,6 +765,21 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
        u32 interrupt;
        int i, rc;

+       if (storm_check) {
+               irqs_fired++;
+
+               if (!time_start) {
+                       time_start = jiffies_to_msecs(jiffies);
+               } else if ((irqs_fired > 1000) && (jiffies_to_msecs(jiffies) - jiffies < 500)) {
+                       __disable_interrupts(chip);
+                       storm_check = false;
+                       storm_killed = true;
+                       return IRQ_HANDLED;
+               } else if ((jiffies_to_msecs(jiffies) - time_start > 500) && (irqs_fired < 1000)) {
+                       storm_check = false;
+               }
+       }
+
        rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
        if (rc < 0)
                return IRQ_NONE;


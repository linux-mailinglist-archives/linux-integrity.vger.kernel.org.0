Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB4727B90D
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 02:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgI2Awp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 20:52:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37824 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbgI2Awp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 20:52:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 137688EE17F;
        Mon, 28 Sep 2020 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601340765;
        bh=XWjGsmip3sDbI8MMtkRp4A/MsuNAJppBo7b1QqZicAc=;
        h=Subject:From:To:Cc:Date:From;
        b=ZN+6vzCUNLyBlicnD3N4rOhpJ2kt3ZtKqQRAL10hNqSTuc77xN7K+1niKh4Z96Ytd
         5hv0oLQpGLNADbxTBdsHkiY2gK1OX+5oH7LJrUjktRYx+8RURowpjVeZbMdE2xmic/
         Tv0ZiNkYjvHh2PjAyGLNjXgmfLifupRhXZFPS2bA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3pWp_xZMl1f6; Mon, 28 Sep 2020 17:52:44 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 764698EE0F5;
        Mon, 28 Sep 2020 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601340764;
        bh=XWjGsmip3sDbI8MMtkRp4A/MsuNAJppBo7b1QqZicAc=;
        h=Subject:From:To:Cc:Date:From;
        b=Gfa1f+WxbblihxJlySgVWLiO1ww2D37dnn4KDcjyORQkTyFykH8OJL4rvmZFgG0LC
         Oij9+tSKIg9f0MQZ1pKzskQCvCBvQW/4654SGlnT5i9lACdHK/wzGNHXhrwXZzIx74
         k0bNnIlhMQ6b0lou08UWhbvQA5z9wm8/CrUZ5Jrc=
Message-ID: <ea07fe04f61fe1ad19060f600ec219679c7bae2d.camel@HansenPartnership.com>
Subject: More interrupt problems with TIS TPM
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Mon, 28 Sep 2020 17:52:43 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I've got hold of an infineon TIS TPM which actually has a working
interrupt.  I find even with the other fix I still need the patch below
to get the interrupt to fire because without it nothing ever sets
TPM_CHIP_FLAG_IRQ which means the interrupt test code is never
executed.

Finally with all this probing fixed, I'm seeing interrupt storms.  The
way this TPM seems to work is that if you allow it to send command
ready interrupts, it will send them any time it can accept a command. 
The problem is if you clear the interrupt and it can accept a command,
it will send another command ready interrupt ... hence the storm since
the TPM is pretty much always in the command ready state.  The only way
to mitigate this seems to be *only* to enable the command ready
interrupt when you're preparing to wait for the TPM to become ready. 
i.e. these interrupts have to be treated as one shot enable, so the
interrupt routine has to mask the command ready interrupt before doing
a TPM_EOI in our way of doing things.  There seems to be support for
this in the TIS spec around line 1135 where it advises us to keep all
interrupts masked until polling says we have to wait for a particular
state.

James

---

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 6b884badabe7..1578d158416c 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -804,6 +810,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 		return rc;
 
 	priv->irq_tested = false;
+	chip->flags |= TPM_CHIP_FLAG_IRQ;
 
 	/* Generate an interrupt by having the core call through to
 	 * tpm_tis_send



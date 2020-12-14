Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05932DA300
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Dec 2020 23:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408538AbgLNWIP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Dec 2020 17:08:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407337AbgLNWIJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 17:08:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607983641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ezHI9l+kJyPz4+IkqA521Mgz1A8PCaMz8TXfpyP64k=;
        b=UiJoE4S0xruu3/jLQl/qA/h5S0bz7LoBe1+ugyZIDHt4vy2GVHBfu52GZmhLLal8fYJMyQ
        ZcdHgi4uiTyPmZ3rYEYWzil+PpzNXieycFM8g43OmCT5XyPR6M0l3zE6CaXKrwF0w0slCp
        kjVI9UE6+O1MfWLDYlfWVW2hM8TqKbB/o3Knpu00Z0/1DtPeQpJf+Wbujb85R0lytB4gzC
        ncPHT+9Ykbv8aTNKRBmRpG8523CBRJ4UMd8XuTJhCqeI2tQVL/o5Tn9okl/6IQma7brWpS
        0jRoU63vtczjXRfJR2mwGY9W8CV+5YIC42OJWldCbqEJL11ah14/ZDm3nOc53Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607983641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ezHI9l+kJyPz4+IkqA521Mgz1A8PCaMz8TXfpyP64k=;
        b=C9tDNKj6P4rWLP8vR0PshIs3AFHMuif15+6Y8+sX/i1Y8X4bDFfCzUQBGm3RJxiitXjRJW
        Ufxy/ZpEFlSEAoCw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH V2] tpm: Remove tpm_dev_wq_lock
In-Reply-To: <20190211105835.16851-1-bigeasy@linutronix.de>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
Date:   Mon, 14 Dec 2020 23:07:21 +0100
Message-ID: <87ft48doti.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Never used since it was added.

Fixes: 9e1b74a63f776 ("tpm: add support for nonblocking operation")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Philip Tricca <philip.b.tricca@intel.com>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
V2: Reworded the change log so the !&!%#$ dispute over the formatting
    is not longer in the way of getting this triviality done.
---
 drivers/char/tpm/tpm-dev-common.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -20,7 +20,6 @@
 #include "tpm-dev.h"
 
 static struct workqueue_struct *tpm_dev_wq;
-static DEFINE_MUTEX(tpm_dev_wq_lock);
 
 static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 				u8 *buf, size_t bufsiz)

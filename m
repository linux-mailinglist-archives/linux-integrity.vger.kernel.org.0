Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34B279CD6
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Sep 2020 00:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgIZW5W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 26 Sep 2020 18:57:22 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57444 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbgIZW5W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Sep 2020 18:57:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E49618EE0E0;
        Sat, 26 Sep 2020 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601161040;
        bh=i8hTUBXpDaxqM7Lsq+NMarJvfhVDjG3+wNCUwa2kvcs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YZbrZzO/BO4ObPaC64tSwiK8sussaMg0oTSAA3TPKdZ1AbNtBUtF4JSZZqj8sK1/r
         Sypy6WvauGcgeDZca8qNa7c9A67nxKsLWu/6bHxkYFl0poGg9LVNx4//hyos168+aA
         jKTsMoaEQl7TX4hrTie4QOzprr6YHTGWUlVXW3lI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FNpCvGgXin2B; Sat, 26 Sep 2020 15:57:20 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 463C28EE064;
        Sat, 26 Sep 2020 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601161040;
        bh=i8hTUBXpDaxqM7Lsq+NMarJvfhVDjG3+wNCUwa2kvcs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YZbrZzO/BO4ObPaC64tSwiK8sussaMg0oTSAA3TPKdZ1AbNtBUtF4JSZZqj8sK1/r
         Sypy6WvauGcgeDZca8qNa7c9A67nxKsLWu/6bHxkYFl0poGg9LVNx4//hyos168+aA
         jKTsMoaEQl7TX4hrTie4QOzprr6YHTGWUlVXW3lI=
Message-ID: <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hao Wu <hao.wu@rubrik.com>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, hamza@hpe.com,
        james.l.morris@oracle.com, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com
Cc:     linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, seungyeop.han@rubrik.com,
        shrihari.kalkar@rubrik.com, anish.jhaveri@rubrik.com
Date:   Sat, 26 Sep 2020 15:57:17 -0700
In-Reply-To: <20200926223150.109645-1-hao.wu@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-09-26 at 15:31 -0700, Hao Wu wrote:
> Since kernel 4.14, we fixed the TPM sleep logic
> from msleep to usleep_range, so that the TPM
> sleeps exactly with TPM_TIMEOUT (=5ms) afterward.
> Before that fix, msleep(5) actually sleeps for
> around 15ms.
> The fix is 
> https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3
> 
> That fix uncovered that the TPM_TIMEOUT was not properly
> set previously. We recently found the TPM driver in kernel 4.14+
> (including 5.9-rc4) crashes Atmel TPM chips with
> too frequent TPM queries.

I've seen this with my nuvoton too ... although it seems to be because
my chip is somewhat experimental (SW upgrade from 1.2 to 2.0).  The
problem with your patch is it reintroduces the massive delays that
msleep has ... that's why usleep was used.  The patch I use locally to
fix this keeps usleep, can you try it (attached).

James

---

From d40a8c7691a72de28ea66a78bd177db36a79710a Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 11 Jul 2018 10:11:14 -0700
Subject: [PATCH] tpm.h: increase poll timings to fix tpm_tis regression

tpm_tis regressed recently to the point where the TPM being driven by
it falls off the bus and cannot be contacted after some hours of use.
This is the failure trace:

jejb@jarvis:~> dmesg|grep tpm
[    3.282605] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[14566.626614] tpm tpm0: Operation Timed out
[14566.626621] tpm tpm0: tpm2_load_context: failed with a system error -62
[14568.626607] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14570.626605] tpm tpm0: tpm2_load_context: failed with a system error -62
[14572.626526] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14577.710441] tpm tpm0: tpm_try_transmit: tpm_send: error -62
...

The problem is caused by a change that caused us to poke the TPM far
more often to see if it's ready.  Apparently something about the bus
its on and the TPM means that it crashes or falls off the bus if you
poke it too often and once this happens, only a reboot will recover
it.

The fix I've come up with is to adjust the timings so the TPM no
longer falls of the bus.  Obviously, this fix works for my Nuvoton
NPCT6xxx but that's the only TPM I've tested it with.

Fixes: 424eaf910c32 tpm: reduce polling time to usecs for even finer granularity
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..e4f4b98418ab 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -41,8 +41,8 @@ enum tpm_timeout {
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
 	TPM_TIMEOUT_POLL = 1,	/* msecs */
-	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
-	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
+	TPM_TIMEOUT_USECS_MIN = 750,      /* usecs */
+	TPM_TIMEOUT_USECS_MAX = 1000,      /* usecs */
 };
 
 /* TPM addresses */
-- 
2.26.2



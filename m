Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B7279CCA
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Sep 2020 00:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIZWcV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 26 Sep 2020 18:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIZWcV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Sep 2020 18:32:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31EDC0613CE
        for <linux-integrity@vger.kernel.org>; Sat, 26 Sep 2020 15:32:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so6181696pfd.3
        for <linux-integrity@vger.kernel.org>; Sat, 26 Sep 2020 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J6tNT3uw125JzT6C4+ngOV9dl7SQLchtpCDexA2VKMY=;
        b=MS22mUGfAAK6pfyglEoCVKgPcBK2ZBDkB8tv3jek7ZByA2cLmCqDjpXAZ1ec9q40vL
         48ZL2bWDpsuJpfI3rDIb4mvyf+g/8IckCoQnBJDnVd32fRzJAUhwZfQJLepk2t3QybLb
         9/6diYsVaBRRttuJPYQwDkQHXgoSmceJNNG4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J6tNT3uw125JzT6C4+ngOV9dl7SQLchtpCDexA2VKMY=;
        b=OVKejScsbybsVXgKlh+513txDYRwEGWdq5Wbmj8cEo0eER/OPqgU3TUXc29es95aZU
         By88APT7wW4D16MkKaw0FkvsOCPtjZFnOyyvPUoFpBvamoPa0lcE9TbG0dPD1iJ0eAog
         Cp/seCEaIsEqFOWS6WyiNSGDU5+nC2hoRfJH1D51kzDL33rCgfhTlYlen8p/EZ6tb5bT
         Og3UVEjQBqqrJtz27gcJsGj9Eh7wwG3LTst8zWkTGyqv6Jhk3h6da9PUXNBJYIhGgG6D
         T4r3sTnWL5DJDDxPD7LZn9WU/H/Pc6qnecGQVPX0am4TjAPSIca6aCq1cImXJczxbx29
         oqXQ==
X-Gm-Message-State: AOAM532dzNAxWzk02RYsHu1XEIA9KAyNcMCf/IEC3Z9A8KOS3yLhKgqa
        gc/WINvi6laPPIHbL4SKBVGZeg==
X-Google-Smtp-Source: ABdhPJx/vDDKwfVFuYXV5NIJZDaKRuWBOJP0j6yeLG/Mg6tP44OXCzCivad6MH4x/MC1keRfOdHQ+g==
X-Received: by 2002:a63:1016:: with SMTP id f22mr3959324pgl.226.1601159540247;
        Sat, 26 Sep 2020 15:32:20 -0700 (PDT)
Received: from hao-wu-dev01.colo.rubrik.com ([4.7.92.14])
        by smtp.gmail.com with ESMTPSA id g1sm2497473pjl.21.2020.09.26.15.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 15:32:19 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, hamza@hpe.com,
        james.l.morris@oracle.com, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com
Cc:     linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, seungyeop.han@rubrik.com,
        shrihari.kalkar@rubrik.com, anish.jhaveri@rubrik.com,
        hao.wu@rubrik.com
Subject: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Date:   Sat, 26 Sep 2020 15:31:50 -0700
Message-Id: <20200926223150.109645-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since kernel 4.14, we fixed the TPM sleep logic
from msleep to usleep_range, so that the TPM
sleeps exactly with TPM_TIMEOUT (=5ms) afterward.
Before that fix, msleep(5) actually sleeps for
around 15ms.
The fix is https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3

That fix uncovered that the TPM_TIMEOUT was not properly
set previously. We recently found the TPM driver in kernel 4.14+
(including 5.9-rc4) crashes Atmel TPM chips with
too frequent TPM queries.

The TPM crash signature is
```
$ tpm_sealdata -z
Tspi_Key_LoadKey failed: 0x00001087 - layer=tddl, code=0087 (135), I/O error

$ sudo dmesg | grep tpm0
[59154.665549] tpm tpm0: tpm_try_transmit: send(): error -62
[59154.809532] tpm tpm0: tpm_try_transmit: send(): error -62
```

From the error code "-62", it looks similar to another bug
https://patchwork.kernel.org/patch/10520247/
where the "TPM_TIMEOUT_USECS_MAX" and "TPM_TIMEOUT_USEC_MIN"
is too small, which causes TPM get queried too frequently,
and thus crashes.

We finally found the root cause is related to
the sleep timeout used in `wait_for_tpm_stat`

In the 4.16, commit
https://github.com/torvalds/linux/commit/cf151a9a44d52a63332e8e926234574fe5a5d784
uses `TPM_POLL_SLEEP` instead of TPM_TIMEOUT for `wait_for_tpm_stat`
and set `TPM_POLL_SLEEP` (1ms).

Since 4.18 commits
https://github.com/torvalds/linux/commit/59f5a6b07f6434efac0057dc2f303a96b871811b
https://github.com/torvalds/linux/commit/424eaf910c329ab06ad03a527ef45dcf6a328f00
further reduced the timeout in wait_for_tpm_stat to less than 1ms.

Our patch here defines a `TPM_TIMEOUT_WAIT_STAT` (15ms) just for
`wait_for_tpm_stat the` to fix the crash in Atmel chips,
but not introduce unnecessary performance regression
in other workflows.
15ms is the actual timeout TPM chips use before the 4.14 fix
from msleep to usleep_range. Thus fixed the crash.

Exploring smaller `TPM_TIMEOUT_WAIT_STAT` should be a separate
thing to revisit later. This patch meant to fix the regression
introduced since 4.14

Test Plan:
- Run fixed kernel on system with Atmel TPM chips
  and ensure crash does not happen
- Run fixed kernel on system with other TPM chips
  (IFX / WEC / STM) ensure not breakages from tpm-tool

Signed-off-by: Hao Wu <hao.wu@rubrik.com>
---
 drivers/char/tpm/tpm.h          | 1 +
 drivers/char/tpm/tpm_tis_core.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..899097ae9756 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -41,6 +41,7 @@ enum tpm_timeout {
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
 	TPM_TIMEOUT_POLL = 1,	/* msecs */
+	TPM_TIMEOUT_WAIT_STAT = 15,      /* msecs */
 	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
 	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
 };
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 65ab1b027949..8aa5eef10c28 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -80,8 +80,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			usleep_range(TPM_TIMEOUT_USECS_MIN,
-				     TPM_TIMEOUT_USECS_MAX);
+			tpm_msleep(TPM_TIMEOUT_WAIT_STAT);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
-- 
2.17.1


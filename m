Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B362226849D
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Sep 2020 08:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgINGN4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Sep 2020 02:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgINGNz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Sep 2020 02:13:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BAFC06174A
        for <linux-integrity@vger.kernel.org>; Sun, 13 Sep 2020 23:13:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s65so9618890pgb.0
        for <linux-integrity@vger.kernel.org>; Sun, 13 Sep 2020 23:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ts2/KYjGvoH71lmxRtKYqzhJYo8cxqWFvYczzWrM/qs=;
        b=LmVZBq3GIIjHn4bPjmdxVn0TdEuhLuDw+q6yniUoCq+1k1LPxrTalbyyIvnVUE6teV
         Q2RbPz+Jbg2hcgv66KohTqFzljvd3NCzmFVZ6AVc6fxu9smj703b2T3f62rLTuS4Z+AA
         x+sem75BQZktrefxsjqMx2VeOQrIvXOr8qJWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ts2/KYjGvoH71lmxRtKYqzhJYo8cxqWFvYczzWrM/qs=;
        b=OiMdcq3GL0hLc693jJVXI3Cugy58vLvaJ2o6NsOa3liDRwqUo5mV8aKtupgoVoMsL1
         Jq+MaDkHpD/tY8kranSwHikE9EdpDrxsTTmrtm69uUFsdWH948K8fJG3XSHMZIdDO8zU
         YnGNZXPJs735+6thzDD4F5TByq0TkRjy7nntNqtLUbk3E34FEMpgnnBFrQzmLSXAyMm/
         2Qv/XEF0Lb7w8m1iNWwZjdVtvtZwmy37FBpoGLV7L3LaKpOV/NCsqoqhDrHK3ODo4C7+
         kfaIk8S7OS9fR2q2N5KIxJLo9mfg24TP+Z0+bEUCZMcB6KjPYUkid7+NcBnaFSHY2t+o
         ZRqg==
X-Gm-Message-State: AOAM531QIXbI7FtLA7dWvgnMSoqyJGz10f/9Jyl2dOpHMZ3g1IQm7iuc
        rpbi9Mp1seio3r8P+joN/3JRiQ==
X-Google-Smtp-Source: ABdhPJzHCBFjaxUoAOneco/S1vxFi3HH2GdHqSADAw8hYN4aKx0EG38kDUXAp1SsfsXO9DDXk2KSIA==
X-Received: by 2002:a17:902:834b:: with SMTP id z11mr12658622pln.48.1600064033834;
        Sun, 13 Sep 2020 23:13:53 -0700 (PDT)
Received: from hao-wu-dev01.colo.rubrik.com ([4.7.92.14])
        by smtp.gmail.com with ESMTPSA id fz22sm7800305pjb.46.2020.09.13.23.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 23:13:53 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, hamza@hpe.com,
        james.l.morris@oracle.com
Cc:     linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, seungyeop.han@rubrik.com,
        shrihari.kalkar@rubrik.com, hao.wu@rubrik.com,
        anish.jhaveri@rubrik.com
Subject: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Date:   Sun, 13 Sep 2020 23:13:43 -0700
Message-Id: <20200914061343.79018-1-hao.wu@rubrik.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
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

This patch fix the TPM_TIMEOUT to 15ms which was
the actual timeout TPM chips use before the fix
from msleep to usleep_range. Thus fixed the crash.

Test Plan:
- Run fixed kernel on system with Atmel TPM chips
  and ensure crash does not happen
- Run fixed kernel on system with other TPM chips
  (IFX / WEC / STM) ensure not breakages from tpm-tool
---
 drivers/char/tpm/tpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..73259ac0a997 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -37,7 +37,7 @@
 #define TPM_RETRY		50
 
 enum tpm_timeout {
-	TPM_TIMEOUT = 5,	/* msecs */
+	TPM_TIMEOUT = 15,	/* msecs */
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
 	TPM_TIMEOUT_POLL = 1,	/* msecs */
-- 
2.17.1


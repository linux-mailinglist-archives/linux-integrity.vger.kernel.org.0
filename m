Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECC447830E
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Dec 2021 03:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhLQCSU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 21:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhLQCSU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 21:18:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE96C061574
        for <linux-integrity@vger.kernel.org>; Thu, 16 Dec 2021 18:18:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso1999641ybl.7
        for <linux-integrity@vger.kernel.org>; Thu, 16 Dec 2021 18:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pR+fjBVeHG+Dz5BWpaT9e03Wce0EIRy1MQ2NNyLJbHA=;
        b=fbBiF4or7qS7Z6ZEnhelyPWq7ciS54XuEki/bsr1s3zu7JSoMHwX2dJMNwdRwKPcy+
         D+cgumSnvyI6bJ3dOo12zLL+oNZP6OkPTLBRP4ruzO0mO93t2KhocL3ha4GX13CrKAOL
         hHbELr2ac/wWSCywQYE6xkiEyb6ECrL6k6oS0OQ8BxtR9f0pryKfSo3O0F3rRggafAiP
         2sSUsj7kO5+UJRokE4w8ydsWNn23hax4FCVMEcdc/tTr7iLsrq93DRX+FpMWnZOUD3tb
         OoX8kVnQ+w8b1H7I5Y/MAlHu53y/6Nu3MHUZHtavnBxtpCVjsOXHjlDQAk/i/ARDBUJk
         nUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pR+fjBVeHG+Dz5BWpaT9e03Wce0EIRy1MQ2NNyLJbHA=;
        b=dzQarDDxQ0fo37njvw/mzBeGkKOQzBgrsqqHZb1y545ADAvGJ8JCFRNpz4RkV30Ad7
         ASMKmkENfH+R0TJ4RwbXlqV80/xWw9h8HsJ2svFsgk5chR1uBh/ygq9WzMBiP57GkKkx
         /hrPWbbIPG784HuzDxRKVUA+2mYzUF0K+rNY1Q4FrEJPxg/4Bg37G88Hj3zq+uKwR/OQ
         XC7EZSK3Un5qUrbuJImVc5LHPxXBKfXxSHnOP4V9Tg2cCEgg36yg259pbWXWyswUe6af
         KVRdnQ41Qy3R/j1UYp5ckuHXO5RD3UEixnwUueAOKMBI8IRfW3pjuWBfynnqQmUu1Hj+
         VsuQ==
X-Gm-Message-State: AOAM532CoE79oMKF4UcYCfuT/gFZ1L2hKUTc3vUJFjhj4iLd3gzLaFGz
        B+J35amd6yZipcNj6EQ5IBaYOzyj4A==
X-Google-Smtp-Source: ABdhPJyI65wYsFsZsazdtJWtk2ZwdrYbfZjCAODHe/2Qn4zJDVaFqUkU/WCE8Sq/+Dorh6R073GRNX5QZw==
X-Received: from yaelt.nyc.corp.google.com ([2620:0:1003:415:7c73:1d86:25c1:77e5])
 (user=yaelt job=sendgmr) by 2002:a25:9849:: with SMTP id k9mr1414250ybo.728.1639707498968;
 Thu, 16 Dec 2021 18:18:18 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:17:26 -0500
Message-Id: <20211217021726.2487455-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] syscalls/keyctl09: test encrypted keys.
From:   Yael Tiomkin <yaelt@google.com>
To:     ltp@lists.linux.it
Cc:     zohar@linux.ibm.com, pvorel@suse.cz,
        linux-integrity@vger.kernel.org, Yael Tiomkin <yaelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Test that encrypted keys can be instantiated using
both user-provided decrypted data
(https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
or kernel-generated numbers.

Signed-off-by: Yael Tiomkin <yaelt@google.com>
---
 testcases/kernel/syscalls/keyctl/keyctl09.c | 50 +++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl09.c

diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
new file mode 100644
index 000000000..4589ef367
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Google, Inc.
+ */
+
+/*
+ * Description: This tests that encrypted keys can be instantiated using
+ * user-provided decrypted data (plaintext), and separately, using
+ * kernel-generated key material.
+ */
+
+#include <errno.h>
+#include <stdint.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static void do_test(void)
+{
+	key_serial_t masterkey;
+	key_serial_t encryptedkey1;
+	key_serial_t encryptedkey2;
+	char buffer[128];
+
+	masterkey = add_key("user", "user:masterkey", "foo", 3, KEY_SPEC_PROCESS_KEYRING);
+	if (masterkey == -1)
+		tst_brk(TBROK | TERRNO, "Failed to add user key");
+
+	encryptedkey1 = add_key("encrypted", "ltptestkey1", "new enc32 user:masterkey 32 plaintext12345678901234567890123", 60, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey1 == -1)
+		tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted key using payload decrypted data");
+
+	TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for encryptedkey1");
+
+	encryptedkey2 = add_key("encrypted", "ltptestkey2", "new enc32 user:masterkey 32", 27, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey2 == -1)
+		tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted key using kernel-generated key material");
+
+	TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for encryptedkey2");
+
+	tst_res(TPASS, "Encrypted keys were successfully instantiated and read");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.34.1.173.g76aa8bc2d0-goog


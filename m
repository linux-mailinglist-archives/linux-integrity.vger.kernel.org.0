Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A147B869
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 03:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhLUChZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Dec 2021 21:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhLUChZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Dec 2021 21:37:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03950C061574
        for <linux-integrity@vger.kernel.org>; Mon, 20 Dec 2021 18:37:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so23316632ybe.8
        for <linux-integrity@vger.kernel.org>; Mon, 20 Dec 2021 18:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cl5LTremNZzk8DR5nFJSWNIEB1OQKaewgz61mNa7uYs=;
        b=mFnOCx31n+FWdMhmRMMNn6AeXkMxwJufIyuuaK5YDWvro61mkrmldbdxK1ssfvaxxj
         D1iw9UX6jF0LuvvPIKfbyrhe6DW+l3VajtYSXwlHPYKC250QbZ/VKggp4h6kQzjjk13E
         0hPdNN0k/Nxen/HCF0y0V5ls0+I3G8MBKQgp1dPDDhqJC8otEVIYZdGR01XW48gPFX3w
         auRrTjK98iQRWMDQJtHR+U7h8y0Pkf4m9iCNegIKbLA8BzV0LTxH8Ac8IIfd1GARrYMt
         R8OBb1cMSrX14dfA/UEuJKd4Tj1x7RL+lWDkGb2YV8fn3Itq0QNz2saEzujdJXjC5Fn9
         FoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cl5LTremNZzk8DR5nFJSWNIEB1OQKaewgz61mNa7uYs=;
        b=g+jhpDpu9TPsPGL4FUqa0sqM8glR/3SjBRsM8rcUxPOFM5+HT8hSEtm9CKga4OJdeP
         alF+44zvnVpxzyTFwn5V/Zmer/K2wm/S6xRhjlH3Vn/tcc1sfFwG3fh1P9KlNR7HO3qm
         TNWmwbsqMd0MnRflimW6SjmT6KsuIMVdv2i4G7UI1UpSR0HL8odywJ4u1MJbBeKoaGwr
         TZloKS3DX5PcOGT3dvYt6yVTfEF+dShj05WZ/WsTtAZ4fE4L+ns0XgTOip+mjmFjv+QF
         VXNaSir7EVow9WUH6HkwisJ/kIsnrt8iKus8kheDjmEy2RE4DIxS/XmMx/4AwgR51Oph
         tQRg==
X-Gm-Message-State: AOAM530N9884xFFaDjBW0enTDqWxLiJHbxr14pB28NSNvn4Dglm3yZN+
        teh/6FspIw6HwpnsatwNb8z0UivTbw==
X-Google-Smtp-Source: ABdhPJxWVp+XQ48P6kBCzEmgwkN96raX6pZnynRYdFqfqo0vcZ72FuBTxda6pC0XhA6ieMcFPZwRDtY+Kw==
X-Received: from yaelt.nyc.corp.google.com ([2620:0:1003:415:6895:67ef:fc6:e479])
 (user=yaelt job=sendgmr) by 2002:a25:a427:: with SMTP id f36mr1536706ybi.245.1640054244243;
 Mon, 20 Dec 2021 18:37:24 -0800 (PST)
Date:   Mon, 20 Dec 2021 21:37:21 -0500
Message-Id: <20211221023721.129689-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2] syscalls/keyctl09: test encrypted keys.
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

Notes:
    v -> v2: added key revocation and made styling changes.

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl09.c | 58 +++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bcf3d56c9..ccea1ddbd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -643,6 +643,7 @@ keyctl05 keyctl05
 keyctl06 keyctl06
 keyctl07 keyctl07
 keyctl08 keyctl08
+keyctl09 keyctl09
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 3544ac79c..f9948c176 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -6,3 +6,4 @@
 /keyctl06
 /keyctl07
 /keyctl08
+/keyctl09
diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
new file mode 100644
index 000000000..507cd5628
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Google, Inc.
+ */
+
+/*\
+ * [Description]
+ * Test that encrypted keys can be instantiated using user-provided decrypted
+ * data (plaintext), and separately, using kernel-generated key material.
+ */
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+#define ENCRYPTED_KEY_1_PAYLOAD	"new enc32 user:masterkey 32 plaintext12345678901234567890123"
+#define ENCRYPTED_KEY_2_PAYLOAD	"new enc32 user:masterkey 32"
+
+static void do_test(void)
+{
+	key_serial_t masterkey;
+	key_serial_t encryptedkey1;
+	key_serial_t encryptedkey2;
+	char buffer[128];
+
+	masterkey = add_key("user", "user:masterkey", "foo", 3,
+			    KEY_SPEC_PROCESS_KEYRING);
+	if (masterkey == -1)
+		tst_brk(TBROK | TERRNO, "Failed to add user key");
+
+	encryptedkey1 = add_key("encrypted", "ltptestkey1", ENCRYPTED_KEY_1_PAYLOAD,
+				60, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey1 == -1)
+		tst_brk(TFAIL, "Failed to instantiate encrypted key using payload decrypted data");
+
+	TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
+	if (TST_RET < 0)
+		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey1");
+
+	encryptedkey2 = add_key("encrypted", "ltptestkey2", ENCRYPTED_KEY_2_PAYLOAD,
+				27, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey2 == -1)
+		tst_brk(TFAIL,
+			"Failed to instantiate encrypted key using kernel-generated key material");
+
+	TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
+	if (TST_RET < 0)
+		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey2");
+
+	tst_res(TPASS, "Encrypted keys were successfully instantiated and read");
+
+	keyctl(KEYCTL_REVOKE, encryptedkey1);
+	keyctl(KEYCTL_REVOKE, encryptedkey2);
+	keyctl(KEYCTL_REVOKE, masterkey);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.34.1.307.g9b7440fafd-goog


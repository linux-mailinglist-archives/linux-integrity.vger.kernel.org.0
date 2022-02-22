Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0EE4C00FD
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Feb 2022 19:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiBVSLW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Feb 2022 13:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiBVSLV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Feb 2022 13:11:21 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC81172E4F
        for <linux-integrity@vger.kernel.org>; Tue, 22 Feb 2022 10:10:56 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso149415067b3.19
        for <linux-integrity@vger.kernel.org>; Tue, 22 Feb 2022 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=I13G/NGnXK2R+yMCHPeUw1HIDrFT/dYlk/r65ZQP80k=;
        b=AFW4G5Vozy99N1QGPrwAymuPpido6XEARzIXCKz2GBhuRaDW2bCkbmtAp5yP0HAsFL
         ZQNt5WtaAEVGXac3sMhrHuksQDDS2tbW46vD8wygGUpwDMX6EBGio12uB4/5+SzW++V1
         vPOMl0vCo+7vl5BiuZ5KCn07XN80pND6kNnnC1q+CDVwRszhN1Wt32w0u5EGKoCmRsa4
         HGcGwRakPog2QwpHrfkL0H5jl+c/4+ydcURg/fz58lejnl+N7njwX3k0oY+jlGlT+IpI
         NG3oWvd+tcYKxnsyH9hLyf0JFVG4WKyvwTPVnsXGtevb35lKA1hRftjp+QebLJtTSLk9
         IYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=I13G/NGnXK2R+yMCHPeUw1HIDrFT/dYlk/r65ZQP80k=;
        b=D6UgrYkgrcmhCcZjXZqTi8E4aQeYlyvWWLQSqKgtu1KdEgEVicIojEVk4u2uS0n1xX
         jW3C8No7UshmE9X2WpkwH6BaUyPfWLOenalsa4+5nq9bHvbaQt0ppEOcIRbq1DQLVpea
         3OnGvB/3aP6Vu0l0VqFjTjQA8mLzsjRRnUIctUX/MoYLc0rP0X7fVgbF+Y/iqQ+ZIGUR
         0jCD1e1cbh7LdU5gI8aBL5IJIk7EST9y5syrDIJH3Jwa8nDrOzeLlLqIP2TrWoQUYWYX
         B/o+NS6ZrDdbBVT0h883riNx83Ci3o/gCw2/CzT80FtU6GhFYJqHF6AC3h0sYqOVT8IP
         bAqw==
X-Gm-Message-State: AOAM533TfBYYUJ/BlVLNF60e5vBEVOpwNZV+uVxkN7KYVUM42DvQ1FcZ
        Ri4LZ5pQuguAdiD7CizUnnBV5fXCoA==
X-Google-Smtp-Source: ABdhPJysP0JS7CSF/8hrjD15N4FHwwa7jB6FWJNu6UWctDUQyU201t8H935zFfUUhiRYi+IZNQdQqx7BEw==
X-Received: from yaelt.nyc.corp.google.com ([2620:0:1003:415:7f1a:cf67:32ef:c972])
 (user=yaelt job=sendgmr) by 2002:a5b:7c6:0:b0:60b:a0ce:19b with SMTP id
 t6-20020a5b07c6000000b0060ba0ce019bmr23928108ybq.407.1645553455362; Tue, 22
 Feb 2022 10:10:55 -0800 (PST)
Date:   Tue, 22 Feb 2022 13:10:34 -0500
Message-Id: <20220222181034.1005633-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3] syscalls/keyctl09: test encrypted keys with provided
 decrypted data.
From:   Yael Tzur <yaelt@google.com>
To:     ltp@lists.linux.it
Cc:     zohar@linux.ibm.com, pvorel@suse.cz,
        linux-integrity@vger.kernel.org, Yael Tzur <yaelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Test that encrypted keys can be instantiated using hex-ascii
encoded user-provided decrypted data.
(https://lore.kernel.org/lkml/20220215141953.1557009-1-yaelt@google.com/).

Signed-off-by: Yael Tzur <yaelt@google.com>
---

Notes:
    v -> v2: added key revocation and made styling changes.
    
    v2 -> v3: updated per latest kernel patch version.

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl09.c | 55 +++++++++++++++++++++
 3 files changed, 57 insertions(+)
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
index 000000000..5d90a6a8d
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Google, Inc.
+ */
+
+/*\
+ * [Description]
+ * Test that encrypted keys can be instantiated using user-provided decrypted
+ * data that is hex-ascii encoded.
+ */
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+#define ENCRYPTED_KEY_1_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaa"
+#define ENCRYPTED_KEY_2_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123"
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
+				60, KEY_SPEC_PROCESS_KEYRING);
+	if (encryptedkey2 != -1)
+		tst_brk(TFAIL, "Instantiation of encrypted key using non hex-encoded decrypted data unexpectedly succeeded");
+
+	tst_res(TPASS, "Encrypted keys were instantiated with decrypted data as expected");
+
+	keyctl(KEYCTL_CLEAR, KEY_SPEC_PROCESS_KEYRING);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_DECRYPTED_DATA=y",
+		NULL
+	}
+};
-- 
2.35.1.473.g83b2b277ed-goog


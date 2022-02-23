Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6FB4C1CD7
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiBWUIf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 15:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbiBWUI0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 15:08:26 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3694C7A7
        for <linux-integrity@vger.kernel.org>; Wed, 23 Feb 2022 12:07:57 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d6994a6942so1041067b3.17
        for <linux-integrity@vger.kernel.org>; Wed, 23 Feb 2022 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AgH7G9qMhJjeNsK8pjjl8l2MFRb6uv/e5h3RVBpFjcM=;
        b=lEvoTqPckwkesDmoXXT2GU4qtC9d2HvwvztmcK6sCsocVzbXr1YMGxD6/mvWS1AT8n
         vrAj3qUZyCWQtRz+GH6DCGKDjzKqWWCr514C7f1glIUX1IMwosvkkc3zLLIhRNV6QBFP
         bW5xTzchMMN272yNx+6+qqYkJZ1+9q2C9v9YZWE6dRmh0tHRUfq7Hjq0aFlS8eLOf/fG
         FptCf0nuWlZdwAHvPaZdPXkvCHkhyYOT6pqwP+OXD02DS48QYGRJKUIiHaOIbT4Jo3j+
         s8V8U6fykVUYTktsP6M9ZSPjodnr43ATUTNXP/97MHKdVcr0OsBIWtcfjT/aJt4yDVmU
         SWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AgH7G9qMhJjeNsK8pjjl8l2MFRb6uv/e5h3RVBpFjcM=;
        b=zgADJeimWC7wQ22wJ1VqrhGwQp8bKHtvX4FXjCX24DXrsmEd/0DeInsp53TIsSBJqM
         WAAQKLTYPN6TqX4tbT1RZPKwzvjdlBufSIZYOwHy877gys5vUDTWS4g7WLU3E6IdDJTC
         4AAr6LB9nO8fRoIfPoVYsl7zANfn8Y6de1DoGDlpEaKXBAl7+AlhaF7qafHvtRmv2kW3
         6iBYnLG1cP2rKXnv1SQo6xX6bFy4gP0cpcPaHzagOkEnYjQYUKQeyQymJ5KA6KuFAiOF
         Ai9cq1ZOQHL1GcFhRrz/awjWGatQpK2/HX4ifQ3CdAF59CVEVCw/RyRV2NxDRsVzV4Sh
         yJLw==
X-Gm-Message-State: AOAM532YLIor3gFn1ZWV95OqxRlG5COIh8wTOXoWIlbjFcUkIUuAqmHM
        M7+QdojIuqJubnuloHXly34i6vauew==
X-Google-Smtp-Source: ABdhPJzAzVL/jgyTyMBdgt10LBLSTNS2DA2lnFUL+O5dsWAxDcT8sK2SlRfFIRynAKemi0S1vNd4CagGZA==
X-Received: from yaelt.nyc.corp.google.com ([2620:0:1003:415:fdfb:5043:291f:63ca])
 (user=yaelt job=sendgmr) by 2002:a81:2450:0:b0:2d6:aee8:f0d5 with SMTP id
 k77-20020a812450000000b002d6aee8f0d5mr1248279ywk.81.1645646877043; Wed, 23
 Feb 2022 12:07:57 -0800 (PST)
Date:   Wed, 23 Feb 2022 15:07:31 -0500
Message-Id: <20220223200731.1859670-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v4] syscalls/keyctl09: test encrypted keys with provided
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
    
    v3 -> v4: made styling changes.

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl09.c | 53 +++++++++++++++++++++
 3 files changed, 55 insertions(+)
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
index 000000000..71fc2f2a9
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -0,0 +1,53 @@
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
+#define ENCRYPTED_KEY_VALID_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaa"
+#define ENCRYPTED_KEY_INVALID_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123"
+
+static void do_test(void)
+{
+	char buffer[128];
+
+	TST_EXP_POSITIVE(add_key("user", "user:masterkey", "foo", 3,
+			    KEY_SPEC_PROCESS_KEYRING));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_POSITIVE(add_key("encrypted", "ltptestkey1",
+			    ENCRYPTED_KEY_VALID_PAYLOAD,
+			    60, KEY_SPEC_PROCESS_KEYRING));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_POSITIVE(keyctl(KEYCTL_READ, TST_RET, buffer, sizeof(buffer)));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_FAIL2(add_key("encrypted", "ltptestkey2",
+			    ENCRYPTED_KEY_INVALID_PAYLOAD, 60,
+			    KEY_SPEC_PROCESS_KEYRING), EINVAL);
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


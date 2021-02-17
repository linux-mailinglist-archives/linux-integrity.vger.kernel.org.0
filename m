Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89FD31D400
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Feb 2021 03:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBQCri (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 21:47:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36648 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBQCrh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 21:47:37 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 17A9020B6C40;
        Tue, 16 Feb 2021 18:46:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17A9020B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613530017;
        bh=H4JU2qfCVJxVHktsTAY9vCsE+wqf20ThHInRYdpff+A=;
        h=From:To:Cc:Subject:Date:From;
        b=LWKsHCNKSuiuyASRHpZrX7B/JemnJRpWs4OCB+BFRuKZ9ra9AHnwZldoQxBpwpSSR
         caJcqBszTOWsE3BI0Lcqrn7RBf3XfmaXzIw4IL89I6ifrC8+CaUa3FJVFa6JWyfOap
         D/KioGHUqcBxG1dLSTDQUI+FK6sM1wmMtW2QrQDE=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] IMA: support for duplicate data measurement
Date:   Tue, 16 Feb 2021 18:46:49 -0800
Message-Id: <20210217024649.23405-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA does not measure duplicate data since TPM extend is a very expensive
operation.  However, in some cases, the measurement of duplicate data
is necessary to accurately determine the current state of the system.
Eg, SELinux state changing from 'audit', to 'enforcing', and back to
'audit' again.  In this example, currently, IMA will not measure the
last state change to 'audit'.  This limits the ability of attestation
services to accurately determine the current state of the measurements 
on the system.

Update ima_add_template_entry() to support measurement of duplicate
data, driven by a Kconfig option - IMA_DISABLE_HTABLE.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
Change Log v2:
 - Incorporated feedback from Mimi on v1.
 - The fix is not just applicable to measurement of critical data,
   it now applies to other buffers and file data as well.
 - the fix is driven by a Kconfig option IMA_DISABLE_HTABLE, rather
   than a IMA policy condition - allow_dup.

 security/integrity/ima/Kconfig     | 7 +++++++
 security/integrity/ima/ima_queue.c | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 12e9250c1bec..057c20b46587 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -334,3 +334,10 @@ config IMA_SECURE_AND_OR_TRUSTED_BOOT
        help
           This option is selected by architectures to enable secure and/or
           trusted boot based on IMA runtime policies.
+
+config IMA_DISABLE_HTABLE
+	bool "disable htable to allow measurement of duplicate data"
+	depends on IMA
+	default n
+	help
+	   This option disables htable to allow measurement of duplicate data.
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index c096ef8945c7..532da87ce519 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -168,7 +168,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	int result = 0, tpmresult = 0;
 
 	mutex_lock(&ima_extend_list_mutex);
-	if (!violation) {
+	if (!violation && !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
 		if (ima_lookup_digest_entry(digest, entry->pcr)) {
 			audit_cause = "hash_exists";
 			result = -EEXIST;
@@ -176,7 +176,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		}
 	}
 
-	result = ima_add_digest_entry(entry, 1);
+	result = ima_add_digest_entry(entry,
+				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
 	if (result < 0) {
 		audit_cause = "ENOMEM";
 		audit_info = 0;
-- 
2.17.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700D331F381
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 02:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBSBBe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 20:01:34 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33454 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBSBBd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 20:01:33 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id AD43D20B6C40;
        Thu, 18 Feb 2021 17:00:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD43D20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613696452;
        bh=VSKfsGKaNp2Nzzv3zZO3rFJoPhGfwklUdZdX8IsxSiw=;
        h=From:To:Cc:Subject:Date:From;
        b=VIuRXNLyG6SZEWqNFcypmGcWZBg9LIC+uDcXekXYUYhx4yTTsB6m0PgfgmnZjShII
         Cq+S3pU039f/43ucLkOdNAHSEHpagFKh6cRaRzEId+5kAMsn4Te9/p3+oHBjtSfFxa
         vJV+s4SPm4SuaX1PJfRchy44Je01UWxo/bq/sSsI=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] IMA: support for duplicate measurement records
Date:   Thu, 18 Feb 2021 17:00:45 -0800
Message-Id: <20210219010045.5509-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA does not include duplicate file, buffer, or critical data
measurement records since TPM extend is a very expensive
operation.  However, in some cases, the measurement of duplicate
records is necessary to accurately determine the current state of the
system.  For instance - the file, buffer, or critical data measurement
record may change from some value 'val#1', to 'val#2', and then back
to 'val#1'.  Currently, IMA will not measure the last change to 'val#1',
since the hash of 'val#1' for the given record is already present in the
measurement log.  This limits the ability of the attestation service to
accurately determine the current state of the system, because it would
be interpreted as the system having 'val#2' for the given record.

Update ima_add_template_entry() to support measurement of duplicate
records, driven by a Kconfig option - IMA_DISABLE_HTABLE.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
Change Log v3:
 - Incorporated feedback from Mimi on v2.
 - Updated patch title and description to make it generic.
 - Changed config description word 'data' to 'records'.
 - Tested use cases for boot param "ima_policy=tcb".

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
index 12e9250c1bec..d0ceada99243 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -334,3 +334,10 @@ config IMA_SECURE_AND_OR_TRUSTED_BOOT
        help
           This option is selected by architectures to enable secure and/or
           trusted boot based on IMA runtime policies.
+
+config IMA_DISABLE_HTABLE
+	bool "Disable htable to allow measurement of duplicate records"
+	depends on IMA
+	default n
+	help
+	   This option disables htable to allow measurement of duplicate records.
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


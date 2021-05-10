Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08C379770
	for <lists+linux-integrity@lfdr.de>; Mon, 10 May 2021 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhEJTKy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 15:10:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51466 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhEJTKx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 15:10:53 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id B23F520B7178;
        Mon, 10 May 2021 12:09:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B23F520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620673788;
        bh=1oQQMwGQg2uKxJ4eZAGjdrgzZTTEUgAfc+6z1nJWyuA=;
        h=From:To:Cc:Subject:Date:From;
        b=M/GbmKsX2cqpZQaOEfj5qMvxuT7ppdEM3TFroKU4zrXZg7Y0zxkfifVbNbbrdynjX
         aLAFOK9uTWwD1JjQg+YjMXw1CItzKPbidhSbgI/VN330180p5QwRd5mOejIqj23buZ
         wI1rIYxVKOo9iD+kFoXwclV8JUxHOz6you+AKUMw=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, pvorel@suse.cz
Subject: [PATCH v4] IMA: support for duplicate measurement records
Date:   Mon, 10 May 2021 12:09:39 -0700
Message-Id: <20210510190939.28279-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA measures contents of a given file/buffer/critical-data record,
and properly re-measures it on change.  However, IMA does not measure
the duplicate value for a given record, since TPM extend is a very
expensive operation.  For example, if the record changes from value
'v#1' to 'v#2', and then back to 'v#1', IMA will not measure and log
the last change to 'v#1', since the hash of 'v#1' for that record is
already present in the IMA htable.  This limits the ability of an
external attestation service to accurately determine the current state
of the system.  The service would incorrectly conclude that the latest
value of the given record on the system is 'v#2', and act accordingly.

Define and use a new Kconfig option IMA_DISABLE_HTABLE to permit
duplicate records in the IMA measurement list.

In addition to the duplicate measurement records described above,
other duplicate file measurement records may be included in the log,
when CONFIG_IMA_DISABLE_HTABLE=y.
For example,
    - i_version is not enabled,
    - i_generation changed,
    - an inode is evicted from dcache etc.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
Change Log v4:
 - Incorporated feedback from Mimi on patch description.
 - Tested more use cases for i_version, i_generation, and dcache.

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


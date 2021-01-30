Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A05530943B
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 11:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhA3KRH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 05:17:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59518 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhA3A4Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 19:56:16 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7588820B6C42;
        Fri, 29 Jan 2021 16:45:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7588820B6C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611967530;
        bh=xbUSoVcgOIGV7nfEfL10khfV1qEza6GJY81X5AvCiwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILnocgY7vnbLuWCwn0yo3qf+tvgh4ErmEk3bVs5Pjb1+zOR41okvFUPXNjGYqPJVT
         ilWm5N+SZQCFVVU4cbDLD705tpEdAcFNuWtcBBm1nNM/fiJn2BRy2zw3VwiGsoQG6+
         VjGeJN4LX1xkHjx630eRjaGGeVKLuHaPk0qkxnWU=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 3/3] IMA: add support to measure duplicate buffer for critical data hook
Date:   Fri, 29 Jan 2021 16:45:19 -0800
Message-Id: <20210130004519.25106-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() and the underlying functions do not use the
policy condition to measure duplicate buffer entries for integrity
critical data.

Update process_buffer_measurement(), ima_add_template_entry(), and
ima_store_template() to use the policy condition to decide if a
duplicate buffer entry for integrity critical data should be measured.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h       | 4 ++--
 security/integrity/ima/ima_api.c   | 9 +++++----
 security/integrity/ima/ima_init.c  | 2 +-
 security/integrity/ima/ima_main.c  | 5 +++--
 security/integrity/ima/ima_queue.c | 5 +++--
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 59324173497f..b06732560949 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -139,7 +139,7 @@ int ima_init(void);
 int ima_fs_init(void);
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
-			   const unsigned char *filename);
+			   const unsigned char *filename, bool allow_dup);
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
 int ima_calc_buffer_hash(const void *buf, loff_t len,
 			 struct ima_digest_data *hash);
@@ -278,7 +278,7 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_desc *template_desc);
 int ima_store_template(struct ima_template_entry *entry, int violation,
 		       struct inode *inode,
-		       const unsigned char *filename, int pcr);
+		       const unsigned char *filename, int pcr, bool allow_dup);
 void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index d273373e6be9..f84369f9905e 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -101,7 +101,7 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
  */
 int ima_store_template(struct ima_template_entry *entry,
 		       int violation, struct inode *inode,
-		       const unsigned char *filename, int pcr)
+		       const unsigned char *filename, int pcr, bool allow_dup)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "hashing_error";
@@ -119,7 +119,8 @@ int ima_store_template(struct ima_template_entry *entry,
 		}
 	}
 	entry->pcr = pcr;
-	result = ima_add_template_entry(entry, violation, op, inode, filename);
+	result = ima_add_template_entry(entry, violation, op, inode, filename,
+					allow_dup);
 	return result;
 }
 
@@ -152,7 +153,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		goto err_out;
 	}
 	result = ima_store_template(entry, violation, inode,
-				    filename, CONFIG_IMA_MEASURE_PCR_IDX);
+				    filename, CONFIG_IMA_MEASURE_PCR_IDX, false);
 	if (result < 0)
 		ima_free_template_entry(entry);
 err_out:
@@ -330,7 +331,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 		return;
 	}
 
-	result = ima_store_template(entry, violation, inode, filename, pcr);
+	result = ima_store_template(entry, violation, inode, filename, pcr, false);
 	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
 		iint->flags |= IMA_MEASURED;
 		iint->measured_pcrs |= (0x1 << pcr);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 6e8742916d1d..d0a79d7b8d89 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -88,7 +88,7 @@ static int __init ima_add_boot_aggregate(void)
 
 	result = ima_store_template(entry, violation, NULL,
 				    boot_aggregate_name,
-				    CONFIG_IMA_MEASURE_PCR_IDX);
+				    CONFIG_IMA_MEASURE_PCR_IDX, false);
 	if (result < 0) {
 		ima_free_template_entry(entry);
 		audit_cause = "store_entry";
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2774139845b6..ff6d15d7594c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -843,6 +843,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	int digest_hash_len = hash_digest_size[ima_hash_algo];
 	int violation = 0;
 	int action = 0;
+	bool allow_dup = false;
 	u32 secid;
 
 	if (!ima_policy_flag)
@@ -865,7 +866,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
-					&pcr, &template, func_data, NULL);
+					&pcr, &template, func_data, &allow_dup);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
@@ -903,7 +904,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		goto out;
 	}
 
-	ret = ima_store_template(entry, violation, NULL, event_data.buf, pcr);
+	ret = ima_store_template(entry, violation, NULL, event_data.buf, pcr, allow_dup);
 	if (ret < 0) {
 		audit_cause = "store_entry";
 		ima_free_template_entry(entry);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index c096ef8945c7..fbf359495fa8 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -158,7 +158,7 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
  */
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
-			   const unsigned char *filename)
+			   const unsigned char *filename, bool allow_dup)
 {
 	u8 *digest = entry->digests[ima_hash_algo_idx].digest;
 	struct tpm_digest *digests_arg = entry->digests;
@@ -169,7 +169,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 
 	mutex_lock(&ima_extend_list_mutex);
 	if (!violation) {
-		if (ima_lookup_digest_entry(digest, entry->pcr)) {
+		if (!allow_dup &&
+		    ima_lookup_digest_entry(digest, entry->pcr)) {
 			audit_cause = "hash_exists";
 			result = -EEXIST;
 			goto out;
-- 
2.17.1


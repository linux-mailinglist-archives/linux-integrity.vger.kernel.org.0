Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03788422B65
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Oct 2021 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhJEOq2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Oct 2021 10:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233705AbhJEOq1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Oct 2021 10:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633445077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=owomiQWBjFqVN/1h5qKnae+4dILP2FUxvTBYXZd3+kM=;
        b=JIn9fN1uA6dHStkwva3dChtZAWqxI8O76mZZydIs65IenUzwYqNt7NMEXPLVFHsjuHUyEF
        TtR4vJdDB5spfxGFZ7XPVCyj27zTH6XPxAFs7ss5twGcyob4W8jf4+A6tfQ/XQfjjTRmaj
        Xh0GJ0sSo068PwW23yqM9pv/ftp7ZCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-pq5Spzy1MG-KFEFa87f5xw-1; Tue, 05 Oct 2021 10:44:35 -0400
X-MC-Unique: pq5Spzy1MG-KFEFa87f5xw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDAF483DBC1
        for <linux-integrity@vger.kernel.org>; Tue,  5 Oct 2021 14:44:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.194.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 338835D9D5;
        Tue,  5 Oct 2021 14:44:32 +0000 (UTC)
From:   Daiki Ueno <dueno@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Daiki Ueno <dueno@redhat.com>
Subject: [PATCH] IMA: make runtime measurement list pollable
Date:   Tue,  5 Oct 2021 16:44:14 +0200
Message-Id: <20211005144414.64547-1-dueno@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA runtime measurement list exposed on securityfs is currently
not pollable, so applications that incrementally verify the
measurements have to monitor the file periodically.  This patch makes
it possible to poll the file in a similar fashion to the sysfs files,
i.e., POLLPRI will be signalled on any changes to the list.

Signed-off-by: Daiki Ueno <dueno@redhat.com>
---
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_fs.c    | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_queue.c |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..a7070a74a7ff 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -180,6 +180,8 @@ struct ima_h_table {
 };
 extern struct ima_h_table ima_htable;
 
+extern wait_queue_head_t ima_htable_wait;
+
 static inline unsigned int ima_hash_key(u8 *digest)
 {
 	/* there is no point in taking a hash of part of a digest */
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3d8e9d5db5aa..f8741784217d 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/poll.h>
 
 #include "ima.h"
 
@@ -198,11 +199,31 @@ static int ima_measurements_open(struct inode *inode, struct file *file)
 	return seq_open(file, &ima_measurments_seqops);
 }
 
+static __poll_t ima_measurements_poll(struct file *file, poll_table *wait)
+{
+	struct seq_file *seq = file->private_data;
+	/* always allow reading */
+	__poll_t mask = EPOLLIN | EPOLLRDNORM;
+	int event;
+
+	poll_wait(file, &ima_htable_wait, wait);
+
+	event = atomic_long_read(&ima_htable.len);
+
+	if (seq->poll_event != event) {
+		seq->poll_event = event;
+		mask |= EPOLLERR | EPOLLPRI;
+	}
+
+	return mask;
+}
+
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = seq_release,
+	.poll = ima_measurements_poll,
 };
 
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
@@ -269,6 +290,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = seq_release,
+	.poll = ima_measurements_poll,
 };
 
 static ssize_t ima_read_policy(char *path)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..375325dfe449 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -38,6 +38,9 @@ struct ima_h_table ima_htable = {
 	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
+/* wait queue for polling changes in ima_htable */
+DECLARE_WAIT_QUEUE_HEAD(ima_htable_wait);
+
 /* mutex protects atomicity of extending measurement list
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
@@ -119,6 +122,9 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
 		     binary_runtime_size + size : ULONG_MAX;
 	}
+
+	wake_up_interruptible(&ima_htable_wait);
+
 	return 0;
 }
 
-- 
2.31.1


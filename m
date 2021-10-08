Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA84264F0
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Oct 2021 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhJHG4J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 02:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229819AbhJHG4J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 02:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633676053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9o0i+CtQOkStX/HHAzFeiOalFaKNnmYBOJl9qvmnp8=;
        b=VCEV46wukduNw9NhlxTndJle5QQuXb4aTWFycuKt2sPaRaziK9zvbTNU6mfE7YtRzB+QeP
        EoPUJhUAGqJ5uC81ruR5TlkauQg6InN+2mRgU9EggiEKC7DtaWDoTs2AXCSbX7Qw0ChP1x
        SEevgLK0qh5SAmiVaQfnX7T9p0WHwKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-1R2DAcc0Md2QWzLl6eMMjw-1; Fri, 08 Oct 2021 02:54:12 -0400
X-MC-Unique: 1R2DAcc0Md2QWzLl6eMMjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60321801AA7
        for <linux-integrity@vger.kernel.org>; Fri,  8 Oct 2021 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 537D810016FE;
        Fri,  8 Oct 2021 06:54:10 +0000 (UTC)
From:   Daiki Ueno <dueno@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Daiki Ueno <dueno@redhat.com>
Subject: [PATCH v2] IMA: make runtime measurement list pollable
Date:   Fri,  8 Oct 2021 08:53:13 +0200
Message-Id: <20211008065312.13987-1-dueno@redhat.com>
In-Reply-To: <20211005144414.64547-1-dueno@redhat.com>
References: <20211005144414.64547-1-dueno@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently it's not possible to efficiently monitor changes to the IMA
runtime measurement list with poll().  While ascii_runtime_measurement
file is pollable with POLLIN, it returns immediately even if there is
no change to the list, and thus cannot be used as a wait condition in
a loop.

This patch makes it possible to poll the file in a similar fashion to
the sysfs files: POLLIN is still always signalled, while POLLPRI will
also be signalled on actual changes made to the list.

Signed-off-by: Daiki Ueno <dueno@redhat.com>
---
v2: moved wake_up_interruptible() call after PCR extend and expanded
the patch description to cover the use-case, suggested by Mimi.
---
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_fs.c    | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_queue.c |  8 +++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

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
index 532da87ce519..de4941909a93 100644
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
@@ -119,6 +122,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
 		     binary_runtime_size + size : ULONG_MAX;
 	}
+
 	return 0;
 }
 
@@ -193,9 +197,11 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			 tpmresult);
 		audit_cause = tpm_audit_cause;
 		audit_info = 0;
-	}
+	} else
+		wake_up_interruptible(&ima_htable_wait);
 out:
 	mutex_unlock(&ima_extend_list_mutex);
+
 	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
 			    op, audit_cause, result, audit_info);
 	return result;
-- 
2.31.1


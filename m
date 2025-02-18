Return-Path: <linux-integrity+bounces-4884-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E056FA3AC24
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 23:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B871897FC0
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA51DE3A3;
	Tue, 18 Feb 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wtmj4HpV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53F61D6DB1;
	Tue, 18 Feb 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919312; cv=none; b=f5zKEdCWVbau1ilrvJxmKAGzw8CIifx09CZlDOlOxUmGe6neV5gz34mjbCoK185+fZVaXLgOM46Dz/D63ovh3qmKL0vHNQDYMuv3FZDo5n1tvULc19ffS/1ECB7AKVK87aJ+U5zXgY9q3h2PGiQoKzmjD47qONHU6M2xT5XxXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919312; c=relaxed/simple;
	bh=i51jmnpUzadYffVRw4XHe2KhlV+JUdZA1n9I/IDPocw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCsP/0xvU31r3b8lrK/FtlQkxFBt1cNvtAUJUnxri/ZwM+Eq3zWS2lYzNbrwJ4mH1TQv/ZlS9iEz6ik/kCuM+ztJqzSjnQanz2zU++mOxJGf8q8fmaRuKYNvVt5FXUhk+wmkMEmiVq8ze6Pzn9O26A9R9+hFLdUC5MYveovSThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wtmj4HpV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5A95820376F0;
	Tue, 18 Feb 2025 14:55:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A95820376F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739919310;
	bh=XopabJcN99JlAds47ms8/GbZn7vwPhIDL8SD4IqyxXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wtmj4HpViSHS7mZc0ZgJaELavwL5pFBVsHrvtnYs+ib8EZh6HLPDRIsO9tF/KBQRu
	 1d7ToFPlQLcw7hIUpcr7l2Lr+1NnLL/hi3oC/f9TBWXh6B1d3zbtXceQjC/xW4LCy0
	 0lEFSOW698VkUhm5mN5OaQ7JfdZNDQ2pcNMZJEnQ=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v8 4/7] ima: kexec: define functions to copy IMA log at soft boot
Date: Tue, 18 Feb 2025 14:54:59 -0800
Message-Id: <20250218225502.747963-5-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218225502.747963-1-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IMA log is copied to the new Kernel during kexec 'load' using 
ima_dump_measurement_list().  The log copy at kexec 'load' may result in
loss of IMA measurements during kexec soft reboot.  It needs to be copied
over during kexec 'execute'.  Setup the needed infrastructure to move the
IMA log copy from kexec 'load' to 'execute'. 

Define a new IMA hook ima_update_kexec_buffer() as a stub function.
It will be used to call ima_dump_measurement_list() during kexec 
'execute'.   

Implement ima_kexec_post_load() function to be invoked after the new 
Kernel image has been loaded for kexec. ima_kexec_post_load() maps the 
IMA buffer to a segment in the newly loaded Kernel.  It also registers 
the reboot notifier_block to trigger ima_update_kexec_buffer() at 
exec 'execute'.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 include/linux/ima.h                |  3 ++
 security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0bae61a15b60..8e29cb4e6a01 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_kexec_post_load(struct kimage *image);
+#else
+static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
 
 #else
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 704676fa6615..0fa65f91414b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,10 +12,14 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
+#include <asm/page.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
 static struct seq_file ima_kexec_file;
+static void *ima_kexec_buffer;
+static bool ima_kexec_update_registered;
 
 static void ima_reset_kexec_file(struct seq_file *sf)
 {
@@ -183,6 +187,48 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
 }
+
+/*
+ * Called during kexec execute so that IMA can update the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	return NOTIFY_OK;
+}
+
+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+};
+
+/*
+ * Create a mapping for the source pages that contain the IMA buffer
+ * so we can update it later.
+ */
+void ima_kexec_post_load(struct kimage *image)
+{
+	if (ima_kexec_buffer) {
+		kimage_unmap_segment(ima_kexec_buffer);
+		ima_kexec_buffer = NULL;
+	}
+
+	if (!image->ima_buffer_addr)
+		return;
+
+	ima_kexec_buffer = kimage_map_segment(image,
+					      image->ima_buffer_addr,
+					      image->ima_buffer_size);
+	if (!ima_kexec_buffer) {
+		pr_err("Could not map measurements buffer.\n");
+		return;
+	}
+
+	if (!ima_kexec_update_registered) {
+		register_reboot_notifier(&update_buffer_nb);
+		ima_kexec_update_registered = true;
+	}
+}
+
 #endif /* IMA_KEXEC */
 
 /*
-- 
2.25.1



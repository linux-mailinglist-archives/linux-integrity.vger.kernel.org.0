Return-Path: <linux-integrity+bounces-6407-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598B3AD4E42
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 10:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FB317DDE3
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5220923A566;
	Wed, 11 Jun 2025 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHSsLX5j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D714900B
	for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630354; cv=none; b=AecjApEc/mZe5l8HEBTk6znJbcMOHN5hp3ummLu5LcuXlKxaEP4wMMaD3LKcL2iqxcMOqDOpvpC8yz0LSDdiQdqZs2+TqgfRr6niqIRl4hfmHZ/bLU/6vZ5OIrLqj//kyhxVWQmV8R0NpwX0EH2QJuGrHW7ZAXuL7v59V0f5u0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630354; c=relaxed/simple;
	bh=/M1JwAKzlPUjoWCOB0zQr/w6AnetB2nAkdySB98E0/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=trEKM01Zy8jLSyBpgkl22oSfLB6L1OyMgGvoO0yCzCUIof+kbwqaWjwwOtS/1Pc/C5ODmBcW9thgx8KBtCaSsmNlzfy/Acx+JlMyfVG+OSAwXg+r43P53YeRvrQfogWsEmZixT3W2iKhk+P3SbNEM/DlNob3sBUGlhPNSGH4v4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHSsLX5j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749630351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KmDlhRl+3FWQEZoPrLJDhKHflCyw66NN2sT0bbeSs9s=;
	b=PHSsLX5jZplVSQngU8rCaJ8uiEsvFJ5FB70ZMp0ThNV9Bd989gI+zM9kPzDgCX/LcBmXJF
	HWWlgv5ZO2YJisqFwNGxeYLRziNH68jFIM02qefbxrN8oEDeKLs2/ZqAFnV6vr6T6+r6KC
	i0EEh1Mcus8LNqxZ49rkTXWTiR4sefA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-saj7WCcbNCKoo5SvrkaQjQ-1; Wed,
 11 Jun 2025 04:25:48 -0400
X-MC-Unique: saj7WCcbNCKoo5SvrkaQjQ-1
X-Mimecast-MFC-AGG-ID: saj7WCcbNCKoo5SvrkaQjQ_1749630347
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 551211956088;
	Wed, 11 Jun 2025 08:25:46 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.181])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F88630001B1;
	Wed, 11 Jun 2025 08:25:39 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com,
	coxu@redhat.com,
	piliu@redhat.com,
	pmenzel@molgen.mpg.de,
	chenste@linux.microsoft.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] ima: add a knob ima= to make IMA be able to be disabled
Date: Wed, 11 Jun 2025 16:25:35 +0800
Message-ID: <20250611082535.127759-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
extra memory. It would be very helpful to allow IMA to be disabled for
kdump kernel.

Hence add a knob ima=on|off here to allow turning IMA off in kdump
kernel if needed.

Note that this IMA disabling is only limited to kdump kernel, please don't
abuse it in other kernel and thus serious consequences are caused.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
- Improve patch log and doc description;
- Make slight adjustment in code; 
These are all made according to Mimi's great suggestions. 

 .../admin-guide/kernel-parameters.txt         |  5 ++++
 security/integrity/ima/ima_main.c             | 26 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b3d62f4c370a..1de67b9c20b4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2214,6 +2214,11 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	ima=		[IMA] Enable or disable IMA
+			Format: { "off" | "on" }
+			Default: "on"
+			Note that this is only limited to kdump kernel.
+
 	indirect_target_selection= [X86,Intel] Mitigation control for Indirect
 			Target Selection(ITS) bug in Intel CPUs. Updated
 			microcode is also required for a fix in IBPB.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f99ab1a3b0f0..c38f3881d72f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/iversion.h>
 #include <linux/evm.h>
+#include <linux/crash_dump.h>
 
 #include "ima.h"
 
@@ -38,11 +39,30 @@ int ima_appraise;
 
 int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
+static int ima_disabled __ro_after_init;
 
 static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
 };
 
+static int __init ima_setup(char *str)
+{
+	if (!is_kdump_kernel()) {
+		pr_info("Warning: ima setup option only permitted in kdump");
+		return 1;
+	}
+
+	if (strncmp(str, "off", 3) == 0)
+		ima_disabled = 1;
+	else if (strncmp(str, "on", 2) == 0)
+		ima_disabled = 0;
+	else
+		pr_err("Invalid ima setup option: \"%s\" , please specify ima=on|off.", str);
+
+	return 1;
+}
+__setup("ima=", ima_setup);
+
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -1186,6 +1206,12 @@ static int __init init_ima(void)
 {
 	int error;
 
+	/*Note that turning IMA off is only limited to kdump kernel.*/
+	if (ima_disabled && is_kdump_kernel()) {
+		pr_info("IMA functionality is disabled");
+		return 0;
+	}
+
 	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
-- 
2.41.0



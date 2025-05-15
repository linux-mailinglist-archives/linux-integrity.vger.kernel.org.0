Return-Path: <linux-integrity+bounces-6241-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83673AB92DB
	for <lists+linux-integrity@lfdr.de>; Fri, 16 May 2025 01:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5860F1BC6436
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469728C001;
	Thu, 15 May 2025 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4WhinOa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5B25A2B4
	for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747352413; cv=none; b=i3e4lDLyy/S5A3YONhzFxHCF39fA9t7is0vlouu2+UkkZcYEgpmSCYa3prmL0WyomY0fK41Wj9/5lFPD8yyQNHSr24gBvpJ8LqX7ZwppAjqQOT6L0WUSR5TJPi++V2Fc5ilVhVZvsC0cPG3NrZ2w2i/qDG4osxnEzpMdSSuQVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747352413; c=relaxed/simple;
	bh=ERVX+s959A0yRGyUyhcMw61Csm98b355tffxJ6/0IpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Hifwxf/a+E0jfeXrSJJ5sThd6frsnyv60onSf/HWiDrAG83HWELrgV2X9e76KBAyyKZFI4zCig4sDdW16Ic13FQMl0KNIpBMTLp1q4+tCLfsIMQpKQIu51rg+OAfRERmWIzaruRMRGL5HiQMAIgLoiPdA05vYBhiMv3gk//zGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4WhinOa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747352408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sN0gqNKdHiRnqR9zRSmok5U8Kkvw2pyyyB0AjUU42/8=;
	b=N4WhinOaPA+7I6PShSk1tQdLtUDfoeA260sCMp8V143UFIXFqD1NF49x7Jm7+AkP74SjFM
	XSv+6QzAmovJyc2zq5ob2K+KyRpHmyZUF6tDCgl+OxlAAN6diUZ7sLkZY/6TR/juTS+owy
	W46xCnD8hVZKSdW7BAjNhHGCaMcYP4Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-cuv60woJM1SaI0J3R63OZw-1; Thu,
 15 May 2025 19:40:05 -0400
X-MC-Unique: cuv60woJM1SaI0J3R63OZw-1
X-Mimecast-MFC-AGG-ID: cuv60woJM1SaI0J3R63OZw_1747352403
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F41C6180087F;
	Thu, 15 May 2025 23:40:02 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBD7830075D8;
	Thu, 15 May 2025 23:39:57 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com,
	pmenzel@molgen.mpg.de,
	coxu@redhat.com,
	ruyang@redhat.com,
	chenste@linux.microsoft.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Date: Fri, 16 May 2025 07:39:53 +0800
Message-ID: <20250515233953.14685-1-bhe@redhat.com>
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

And Coiby also mentioned that for kdump kernel incorrect ima-policy loaded
by systemd could cause kdump kernel hang, and it's possible the booting
process may be stopped by a strict, albeit syntax-correct policy and users
can't log into the system to fix the policy. In these cases, allowing to
disable IMA is very helpful too for kdump kernel.

Hence add a knob ima=on|off here to allow people to disable IMA in kdump
kenrel if needed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++++
 security/integrity/ima/ima_main.c             | 22 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d9fd26b95b34..762fb6ddcc24 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2202,6 +2202,11 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	ima=		[IMA] Enable or disable IMA
+			Format: { "off" | "on" }
+			Default: "on"
+			Note that this is only useful for kdump kernel.
+
 	init=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /sbin/init as init
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f3e7ac513db3..07af5c6af138 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/iversion.h>
 #include <linux/evm.h>
+#include <linux/crash_dump.h>
 
 #include "ima.h"
 
@@ -38,11 +39,27 @@ int ima_appraise;
 
 int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
+static int ima_disabled;
 
 static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
 };
 
+static int __init ima_setup(char *str)
+{
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
+
+
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -1184,6 +1201,11 @@ static int __init init_ima(void)
 {
 	int error;
 
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



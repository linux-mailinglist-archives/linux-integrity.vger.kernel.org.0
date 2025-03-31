Return-Path: <linux-integrity+bounces-5516-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFD7A75EC6
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 08:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7811167813
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4C83596F;
	Mon, 31 Mar 2025 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8OL4BLh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212F610C
	for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401788; cv=none; b=DxigsCSiZAeBo7XvoCwI3uZiHX1IA9Zizokn6Wr/JXFYIOF30OPVfoiqRx/DnVdq8aRVEveotDj54Twp6Azx6HA/L/m/0Udsd8db32XvACfj6dEpaNFNjHl77jnIGQvt+Xy+k8p5WrIsgw9FV9VFgv32AJTZWxi27KMynakj7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401788; c=relaxed/simple;
	bh=RdgOw7RZa9gXdblflqpZZJQPCk3QeZYy46i1q1jt3rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=jOk3Rx/i8+acVYeaVmiRFoT9hM8zXTixswzREf16Z8oa2ZbIKHbVJ3m6OrtttN3CNzW5Qila+aKAiaEJ9DJdJjCJ1O0JA6zLEIrjYcXf4wwBp3OqhGMwBIuXsJy1uUjnS4eF6eLlORYPYGeZCfjOjDLrzZ8+1oGfKC3ujW1u8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8OL4BLh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743401785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zT6uGNEasqGnc6bFrOg7/6G3oblOCVQuVcAM35oaSBU=;
	b=i8OL4BLhu1Nu4mYo7u+DUJ6+GV3DcCx2jYUIGBhhAVmg917awKIKUH4jUqiWaV8K+w9ixk
	AExaIiHkGqQYhNr/fOYF6q95MIKIbivld28xmBArUmsxNNes0PlIjXMyCcoUIZeD1E68jt
	IOqSiErF5bUpb+7hMjYPGvouFXwvWHE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-JExHtgYcP2--jqcDmDAWbQ-1; Mon,
 31 Mar 2025 02:16:19 -0400
X-MC-Unique: JExHtgYcP2--jqcDmDAWbQ-1
X-Mimecast-MFC-AGG-ID: JExHtgYcP2--jqcDmDAWbQ_1743401778
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48510195609F;
	Mon, 31 Mar 2025 06:16:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58DB61808867;
	Mon, 31 Mar 2025 06:16:14 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: zohar@linux.ibm.com
Cc: linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Date: Mon, 31 Mar 2025 14:16:11 +0800
Message-ID: <20250331061611.253919-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

It doesn't make sense to run IMA functionality in kdump kernel, and that
will cost extra memory. It would be great to allow IMA to be disabled on
purpose, e.g for kdump kernel.

Hence add a knob here to allow people to disable IMA if needed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 28b8b0db6f9b..5d677d1389fe 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -38,11 +38,27 @@ int ima_appraise;
 
 int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
+static int ima_disabled = 0;
 
 static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
 };
 
+static int __init ima_setup(char *str)
+{
+	if (strncmp(str, "off", 3) == 0)
+                ima_disabled = 1;
+        else if (strncmp(str, "on", 2) == 0)
+                ima_disabled = 0;
+        else
+                pr_err("invalid ima setup option: \"%s\" ", str);
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
@@ -1176,6 +1192,11 @@ static int __init init_ima(void)
 {
 	int error;
 
+	if (ima_disabled) {
+		pr_info("IMA functionality is disabled on purpose!");
+		return 0;
+	}
+
 	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
-- 
2.41.0



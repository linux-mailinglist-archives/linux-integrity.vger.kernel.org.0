Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204C625E213
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 21:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgIDTl3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 15:41:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26765 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728020AbgIDTl0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 15:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599248485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPCP2biH+LQKhFnXIrAGByYYznE/N+VoqKCeeQjbOnA=;
        b=BRmc6DafUENQaiDwDC/ebWd8qTqZmRGFoelsF3vAdYjwKH4AHli5FEproqDA4ue8flJQFt
        o5PoHW/9Gk8TzilaJ8MCbw3Q5JUYZ0MmXNHJGvIe2f/16TdrqFb0weYo8q8vWYMqhGU4Vi
        Rjt8oSLw/ilUp5nYS2L5ovxqIvlXAYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-Spg73A2LOoG49vCwZQfE0w-1; Fri, 04 Sep 2020 15:41:24 -0400
X-MC-Unique: Spg73A2LOoG49vCwZQfE0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3138801AB8;
        Fri,  4 Sep 2020 19:41:22 +0000 (UTC)
Received: from localhost (ovpn-116-173.gru2.redhat.com [10.97.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BC2C5D9CC;
        Fri,  4 Sep 2020 19:41:19 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 3/4] ima: limit secure boot feedback scope for appraise
Date:   Fri,  4 Sep 2020 16:40:59 -0300
Message-Id: <20200904194100.761848-4-bmeneg@redhat.com>
In-Reply-To: <20200904194100.761848-1-bmeneg@redhat.com>
References: <20200904194100.761848-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Only prompt the unknown/invalid appraisal option if secureboot is enabled and
if the current state differentiates from the original one.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
Changelog:
v2: 
- update commit message (Mimi)
- work with a temporary var instead of directly with ima_appraise (Mimi)

 security/integrity/ima/ima_appraise.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 2193b51c2743..d17808245592 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -19,22 +19,29 @@
 static int __init default_appraise_setup(char *str)
 {
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
-	if (arch_ima_get_secureboot()) {
-		pr_info("Secure boot enabled: ignoring ima_appraise=%s boot parameter option",
-			str);
-		return 1;
-	}
+	bool sb_state = arch_ima_get_secureboot();
+	int appraisal_state = ima_appraise;
 
 	if (strncmp(str, "off", 3) == 0)
-		ima_appraise = 0;
+		appraisal_state = 0;
 	else if (strncmp(str, "log", 3) == 0)
-		ima_appraise = IMA_APPRAISE_LOG;
+		appraisal_state = IMA_APPRAISE_LOG;
 	else if (strncmp(str, "fix", 3) == 0)
-		ima_appraise = IMA_APPRAISE_FIX;
+		appraisal_state = IMA_APPRAISE_FIX;
 	else if (strncmp(str, "enforce", 7) == 0)
-		ima_appraise = IMA_APPRAISE_ENFORCE;
+		appraisal_state = IMA_APPRAISE_ENFORCE;
 	else
 		pr_err("invalid \"%s\" appraise option", str);
+
+	/* If appraisal state was changed, but secure boot is enabled,
+	 * keep its default */
+	if (sb_state) {
+		if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
+			pr_info("Secure boot enabled: ignoring ima_appraise=%s option",
+				str);
+		else
+			ima_appraise = appraisal_state;
+	}
 #endif
 	return 1;
 }
-- 
2.26.2


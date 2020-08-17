Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917EA24792C
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHQVw7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:52:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48016 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728562AbgHQVw6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597701177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lHy2PkWS9dUrHVTyx2t6UBWcHeRAbRKALepRMGwjdE=;
        b=ijChbYfENjFWwUf//UExnLWJus1RujwALN7Vm2PmtMBi2/4Muh+IYYifuTneJgKe/sRdaX
        H3FaFkEsVQWO7lvwRCUHF/pOf+k74G9wqdFUfV5Pda4JX6F5kt7J/+VvJNua4ZKsXVwxZ/
        4ykMZ6BBfi1Ak9PePVClt5k11u/Ntv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-4WTCbgEBNXiHiPbpZehrWw-1; Mon, 17 Aug 2020 17:52:54 -0400
X-MC-Unique: 4WTCbgEBNXiHiPbpZehrWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 145091007B00;
        Mon, 17 Aug 2020 21:52:53 +0000 (UTC)
Received: from localhost (ovpn-116-138.gru2.redhat.com [10.97.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1750784BB;
        Mon, 17 Aug 2020 21:52:49 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 3/4] ima: limit secure boot feedback scope for appraise
Date:   Mon, 17 Aug 2020 18:52:32 -0300
Message-Id: <20200817215233.95319-4-bmeneg@redhat.com>
In-Reply-To: <20200817215233.95319-1-bmeneg@redhat.com>
References: <20200817215233.95319-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of print to kmsg any ima_appraise= option passed by the user in case
of secure boot being enabled, first check if the state was really changed
from its original "enforce" state, otherwise don't print anything.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 2193b51c2743..000df14f198a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -19,11 +19,7 @@
 static int __init default_appraise_setup(char *str)
 {
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
-	if (arch_ima_get_secureboot()) {
-		pr_info("Secure boot enabled: ignoring ima_appraise=%s boot parameter option",
-			str);
-		return 1;
-	}
+	bool sb_state = arch_ima_get_secureboot();
 
 	if (strncmp(str, "off", 3) == 0)
 		ima_appraise = 0;
@@ -35,6 +31,16 @@ static int __init default_appraise_setup(char *str)
 		ima_appraise = IMA_APPRAISE_ENFORCE;
 	else
 		pr_err("invalid \"%s\" appraise option", str);
+
+	/* If appraisal state was changed, but secure boot is enabled,
+	 * reset it to enforced */
+	if (sb_state) {
+		if (!is_ima_appraise_enabled()) {
+			pr_info("Secure boot enabled: ignoring ima_appraise=%s option",
+				str);
+			ima_appraise = IMA_APPRAISE_ENFORCE;
+		}
+	}
 #endif
 	return 1;
 }
-- 
2.26.2


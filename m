Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF71480EC3
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Dec 2021 03:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbhL2CDQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Dec 2021 21:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238311AbhL2CDO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Dec 2021 21:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640743393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jjo6Ob6hJrXlH4BR+sKFz80O6IEjl7bd1wCCkIVR998=;
        b=gEXyKL3hbS3aqoVB+Eq//xMK/2Q0/jNlpx6CAsRf6x459TZMJ4wVYkAEJTX9Gpg2tqk1ud
        yLR1/Px3L0620fMonY6PyGfWnnGNTg27EsIB27Xv05Lpblg0f06VsuXeYt/6e+Wluik4j+
        gFF6vdnqAcm2MhkejEqS6TGPnrKXvYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-b5SdRnOGONWmiDSyyToCww-1; Tue, 28 Dec 2021 21:03:10 -0500
X-MC-Unique: b5SdRnOGONWmiDSyyToCww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77894801B2F;
        Wed, 29 Dec 2021 02:03:09 +0000 (UTC)
Received: from localhost (unknown [10.22.16.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABDD761082;
        Wed, 29 Dec 2021 02:03:05 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v4] ima: silence measurement list hexdump during kexec
Date:   Tue, 28 Dec 2021 23:03:03 -0300
Message-Id: <20211229020303.357610-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Direclty calling print_hex_dump() dumps the IMA measurement list on soft
resets (kexec) straight to the syslog (kmsg/dmesg) without considering the
DEBUG flag or the dynamic debug state, causing the output to be always
printed, including during boot time.

Since this output is only valid for IMA debugging, but not necessary on
normal kexec operation, print_hex_dump_debug() adheres to the pr_debug()
behavior: the dump is only printed to syslog when DEBUG is defined or when
explicitly requested by the user through dynamic debugging.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
Changelog:
- v3: 
  - after more in depth testing it was defined that v1 and v2 solution
	matches with the expected behavior instead of the one proposed on v3.
  - clarify/simplify the patch description.
- v2: guard call with #ifdef instead of using print_hex_dump_debug, which
  would not completely solve the case.
- v1: update commit log with more information.

 security/integrity/ima/ima_kexec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f799cc278a9a..13753136f03f 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -61,9 +61,9 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	}
 	memcpy(file.buf, &khdr, sizeof(khdr));
 
-	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
-			16, 1, file.buf,
-			file.count < 100 ? file.count : 100, true);
+	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
+			     file.buf, file.count < 100 ? file.count : 100,
+			     true);
 
 	*buffer_size = file.count;
 	*buffer = file.buf;
-- 
2.33.1


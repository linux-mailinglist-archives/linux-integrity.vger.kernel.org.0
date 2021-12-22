Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6347D78A
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 20:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbhLVTQl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 14:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345140AbhLVTQi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 14:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640200593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oBXYBJqXC5x++uqbwSfIJ2fpJnl6ko1ZlQWQiKD9HK0=;
        b=RS5/vWKWONi3HBNpBJgT5vP4Lj7kTAvQj/OmkVrwyEQkRytbasdMpYGOLod6oTyPS7PXSx
        Gi2PNHftFszo+t+7Vg6RICR2pkmdMdM3f/v4SQRqfB/sgPQCc3G7wroXYye3Z42froMgSF
        AF8mewlTOWksQcs8UGfOY+08VjCYvgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-SBMaDYKzPiWUDvX_Ir1ccA-1; Wed, 22 Dec 2021 14:16:30 -0500
X-MC-Unique: SBMaDYKzPiWUDvX_Ir1ccA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14B781023F4D;
        Wed, 22 Dec 2021 19:16:29 +0000 (UTC)
Received: from localhost (unknown [10.22.32.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97A0F29997;
        Wed, 22 Dec 2021 19:16:28 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH] ima: silence measurement list hexdump during kexec
Date:   Wed, 22 Dec 2021 16:16:23 -0300
Message-Id: <20211222191623.376174-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The measurement list is dumped during a soft reset (kexec) through the call
to "print_hex_dump(KERN_DEBUG, ...)", which ignores the DEBUG build flag.
Instead, use "print_hex_dump_debug(...)", honoring the build flag.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
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


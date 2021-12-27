Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDC47FDEE
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Dec 2021 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhL0OwQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Dec 2021 09:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237206AbhL0OwP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Dec 2021 09:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640616734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2d3YO/T+1hrO0P2pg1+EL5Fo12veVx2soinEZ6FLQNA=;
        b=NpOLc8v2D2XROHJpSKrKaUfPwv65vJQ8hDc8aejfqOjVuAjPtRHZl6iE8ywnMkIpjj24Il
        cnuMghaP4NesL+tSe0tT+JbpdOKE72glIGLVN4ZQPTq7arCVWzvf3nLn9fdFICVp6sDWOQ
        OQ+icrOsrX6CRZR9BJs4Bs9vhBLBdv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-c3s1wR-9Na2Incrgr1b8Jw-1; Mon, 27 Dec 2021 09:52:12 -0500
X-MC-Unique: c3s1wR-9Na2Incrgr1b8Jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE0C11927801;
        Mon, 27 Dec 2021 14:52:11 +0000 (UTC)
Received: from localhost (unknown [10.22.8.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A25F85891;
        Mon, 27 Dec 2021 14:52:08 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v3] ima: silence measurement list hexdump during kexec
Date:   Mon, 27 Dec 2021 11:52:03 -0300
Message-Id: <20211227145203.88857-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The measurement list is being dumped during soft resets (kexec) through the
call to print_hex_dump(KERN_DEBUG, ...) without considering the DEBUG
compilation flag. With that, to avoid dumping this information to the system
log whenever a soft reset happens during boot process, since the default
console loglevel is generally set to 7 (debug) during boot, guard the call
to print_hex_dump() with #ifdef for the DEBUG cflag.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
Changelog:
- v2: guard call with #ifdef instead of using print_hex_dump_debug, which
  would not completely solve the case.
- v1: update commit log with more information.

 security/integrity/ima/ima_kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f799cc278a9a..2d6db5fbda41 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -61,9 +61,11 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	}
 	memcpy(file.buf, &khdr, sizeof(khdr));
 
+#if defined(DEBUG)
 	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
 			16, 1, file.buf,
 			file.count < 100 ? file.count : 100, true);
+#endif
 
 	*buffer_size = file.count;
 	*buffer = file.buf;
-- 
2.33.1


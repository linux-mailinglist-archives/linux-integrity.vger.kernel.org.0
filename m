Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F109147EF0F
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Dec 2021 14:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhLXNPS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Dec 2021 08:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230463AbhLXNPS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Dec 2021 08:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640351717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bSBbFObSF6NSlYBI3036I9BjBCai076hQD38oa+F+RQ=;
        b=Ij46DTUwr0oqhV+BqqMx0MhEUVw1ssGKrBNAwvzONZjtxrbes+vEVas6Thue/JPpiGED+i
        O6w+oGEy0IpuU4am/2mNnOwfahqargPYk8wnhrMLEca6tkKFnf0KydbdP0SX8wFyR4qdeq
        byQOI/MwQCdbHuODytKm327TTPhAGy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-eftAnkLuMl2UJYiGq2hPYw-1; Fri, 24 Dec 2021 08:15:16 -0500
X-MC-Unique: eftAnkLuMl2UJYiGq2hPYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7306381CCB4;
        Fri, 24 Dec 2021 13:15:15 +0000 (UTC)
Received: from localhost (unknown [10.22.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C61DE710;
        Fri, 24 Dec 2021 13:14:59 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2] ima: silence measurement list hexdump during kexec
Date:   Fri, 24 Dec 2021 10:14:54 -0300
Message-Id: <20211224131454.45577-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The measurement list is dumped during a soft reset (kexec) through the call
to print_hex_dump(KERN_DEBUG, ...), printing to the system log ignoring both
DEBUG build flag and CONFIG_DYNAMIC_DEBUG option.

To honor the above conditions the macro print_hex_dump_debug() should be
used instead, thus depending on the enabled option/flag the output is given
by a different function call or even silenced.

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


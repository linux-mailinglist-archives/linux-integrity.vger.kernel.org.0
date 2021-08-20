Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBC3F3724
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Aug 2021 01:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhHTXA6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 19:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhHTXA5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 19:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629500418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBlsrnqm4BBzTDCdw5cRtOm9lKtoFQJP+fvYzimsn+8=;
        b=WRNogUs671EnSgGZ8vmVQg0EWjlq/O3qUfVaPyEfcnfkFFDajdb5RvHEEgl4TLCYA7rFIx
        uIvHgEv+/pClbKkoCd7B7kn0o3o79KgtyMxb7zpyl51LdNmzfgi9hQdt4V7qX+ORrJNBc0
        wJZMA0JeSkqlzmlOZkAm9n8ts7EPPZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-XVyF1k6CMG69UYLmHZ6Mqg-1; Fri, 20 Aug 2021 19:00:17 -0400
X-MC-Unique: XVyF1k6CMG69UYLmHZ6Mqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44177760C1;
        Fri, 20 Aug 2021 23:00:16 +0000 (UTC)
Received: from localhost (unknown [10.22.33.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9E175C1BB;
        Fri, 20 Aug 2021 23:00:15 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v4 ima-evm-utils 2/2] make SHA-256 the default hash algorithm
Date:   Fri, 20 Aug 2021 20:00:01 -0300
Message-Id: <20210820230001.102249-3-bmeneg@redhat.com>
In-Reply-To: <20210820230001.102249-1-bmeneg@redhat.com>
References: <20210820230001.102249-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The SHA-1 algorithm is considered a weak hash algorithm and there has been
some movement within certain distros to drop its support completely or at
least drop it from the default behavior. ima-evm-utils uses it as the
default algorithm in case the user doesn't explicitly ask for another
through the --with-default-hash configuration time option or --hashalgo/-a
runtime option. With that, make SHA-256 the default hash algorithm instead.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 m4/default-hash-algo.m4 | 2 +-
 src/imaevm.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/m4/default-hash-algo.m4 b/m4/default-hash-algo.m4
index a0b98e645fb1..f23bbf7ab3f8 100644
--- a/m4/default-hash-algo.m4
+++ b/m4/default-hash-algo.m4
@@ -7,7 +7,7 @@ AC_DEFUN([AX_DEFAULT_HASH_ALGO], [
 	AC_ARG_WITH([default_hash],
 		AS_HELP_STRING([--with-default-hash=ALGORITHM], [specifies the default hash algorithm to be used]),
 		[HASH_ALGO=$withval],
-		[HASH_ALGO=sha1])
+		[HASH_ALGO=sha256])
 
 	AC_CHECK_FILE([$CRYPTO_FILE],
 		[HAVE_CRYPTO_FILE=yes],
diff --git a/src/imaevm.h b/src/imaevm.h
index cc3dfd2e9163..ba7b23907669 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -75,7 +75,7 @@
 #define log_errno(fmt, args...)		do_log(LOG_ERR, fmt ": errno: %s (%d)\n", ##args, strerror(errno), errno)
 
 #ifndef DEFAULT_HASH_ALGO
-#define DEFAULT_HASH_ALGO "sha1"
+#define DEFAULT_HASH_ALGO "sha256"
 #endif
 
 #define	DATA_SIZE	4096
-- 
2.31.1


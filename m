Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DCA3F36A5
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Aug 2021 00:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhHTWuP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 18:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231482AbhHTWuP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 18:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629499776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4krz9bUzXGDrZH6tfZQ8txIg8FMaYQ7XS2ZHtH0XWcw=;
        b=QzF6tfR3n7qfq5ruJqqa1feWxORVV4Sz+nNrcb5tvLvvbuLp+JIblMaKOzIVGmVTziUxuQ
        Op3iMFdN7Df/ob3s6HVRx7vbn+pSOkk/d4lGpWS9sXH0Vl+agenou9+ewrt8KW1jv2s7HR
        XdmBEtuE3/29Z+n/84Dp4qbOQcCXuBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-UNXcLTMjPU-mocSzNW4imw-1; Fri, 20 Aug 2021 18:49:35 -0400
X-MC-Unique: UNXcLTMjPU-mocSzNW4imw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79CBD824F8C;
        Fri, 20 Aug 2021 22:49:34 +0000 (UTC)
Received: from localhost (unknown [10.22.33.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96F6E5D6B1;
        Fri, 20 Aug 2021 22:49:30 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v3 ima-evm-utils 2/2] make SHA-256 the default hash algorithm
Date:   Fri, 20 Aug 2021 19:49:17 -0300
Message-Id: <20210820224917.101053-3-bmeneg@redhat.com>
In-Reply-To: <20210820224917.101053-1-bmeneg@redhat.com>
References: <20210820224917.101053-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index 14be44731ba6..eeb21751f6be 100644
--- a/m4/default-hash-algo.m4
+++ b/m4/default-hash-algo.m4
@@ -9,7 +9,7 @@ AC_DEFUN([AX_DEFAULT_HASH_ALGO], [
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


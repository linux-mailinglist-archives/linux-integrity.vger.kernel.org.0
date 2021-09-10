Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E48407175
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Sep 2021 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhIJSsf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Sep 2021 14:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231932AbhIJSse (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Sep 2021 14:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631299642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V52c2PH38OndfG+MLqkkMGZ4Hcc5ilgezUhK4fpL5CI=;
        b=Ho+c3NmSE+x85WM9AGlWUrPYaQeav29tDeg6aOZQbzujP2anCIocfP9AslzSjESKq5tPI0
        bVboaKKCNTYQ4lsgonrhUBuYufpGLh6y4rHo+5oGfLah3lns7uuHsfEqDnQQWn+8jD4P0I
        2EgBwWjiVXBUerw82cwYv2Ri28X78J4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-DR33u-E4Prele3jcWXT0rQ-1; Fri, 10 Sep 2021 14:47:19 -0400
X-MC-Unique: DR33u-E4Prele3jcWXT0rQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4EAE84A5E5;
        Fri, 10 Sep 2021 18:47:18 +0000 (UTC)
Received: from localhost (unknown [10.22.33.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC31C5D9C6;
        Fri, 10 Sep 2021 18:47:14 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v7 ima-evm-utils 2/2] make SHA-256 the default hash algorithm
Date:   Fri, 10 Sep 2021 15:47:01 -0300
Message-Id: <20210910184701.386163-3-bmeneg@redhat.com>
In-Reply-To: <20210910184701.386163-1-bmeneg@redhat.com>
References: <20210910184701.386163-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index b6164a57d11f..92390fd43b6e 100644
--- a/m4/default-hash-algo.m4
+++ b/m4/default-hash-algo.m4
@@ -9,7 +9,7 @@ AC_DEFUN([AX_DEFAULT_HASH_ALGO], [
 	AC_ARG_WITH([default_hash],
 		AS_HELP_STRING([--with-default-hash=ALGORITHM], [specifies the default hash algorithm to be used]),
 		[HASH_ALGO=$withval],
-		[HASH_ALGO=sha1])
+		[HASH_ALGO=sha256])
 
 	AC_PROG_SED()
 	HASH_ALGO="$(echo $HASH_ALGO | $SED 's/\(.*\)/\L\1\E/')"
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


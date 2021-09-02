Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C333FF41A
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Sep 2021 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbhIBTZo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Sep 2021 15:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347257AbhIBTZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Sep 2021 15:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630610683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+vfEheyufEKzuoB0N1ohTKdx0XMhjs9HaUZlt00S8o=;
        b=OijGj0lDJqV8qyoHjirVNMjFtgOD5v2BGk6TQ6AJQt4fzbK7Y/rf5evM4gZUTXJUp10xBL
        eiTY3h0iW8P0yi6U5xofE778tOvGeQZB1rVfN+UN2Nr85ffqpfw3c75hsVzu2eLlFVLM/1
        yrNF0mwHenp1BJaBQNB/j/0dgVZeEhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-28H0U5XANNCY92Sr7C17iQ-1; Thu, 02 Sep 2021 15:24:42 -0400
X-MC-Unique: 28H0U5XANNCY92Sr7C17iQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55C0C6D4E0;
        Thu,  2 Sep 2021 19:24:41 +0000 (UTC)
Received: from localhost (unknown [10.22.8.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1E2E6A91F;
        Thu,  2 Sep 2021 19:24:40 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v5 ima-evm-utils 2/2] make SHA-256 the default hash algorithm
Date:   Thu,  2 Sep 2021 16:24:27 -0300
Message-Id: <20210902192427.314337-3-bmeneg@redhat.com>
In-Reply-To: <20210902192427.314337-1-bmeneg@redhat.com>
References: <20210902192427.314337-1-bmeneg@redhat.com>
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
index 9a8b2ff34cfc..70d00b007fa1 100644
--- a/m4/default-hash-algo.m4
+++ b/m4/default-hash-algo.m4
@@ -9,7 +9,7 @@ AC_DEFUN([AX_DEFAULT_HASH_ALGO], [
 	AC_ARG_WITH([default_hash],
 		AS_HELP_STRING([--with-default-hash=ALGORITHM], [specifies the default hash algorithm to be used]),
 		[HASH_ALGO=$withval],
-		[HASH_ALGO=sha1])
+		[HASH_ALGO=sha256])
 
 	AC_CHECK_HEADER([$HASH_INFO_HEADER],
 		[HAVE_HASH_INFO_HEADER=yes],
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


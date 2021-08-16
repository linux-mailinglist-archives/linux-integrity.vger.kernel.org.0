Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849AD3EDE84
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhHPUUp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 16:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231203AbhHPUUo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 16:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629145212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7uZX44pKRv8e3bPpdaLNw6OUWI/3CPhaMaXg3VlWRLA=;
        b=eQ4jDk/vQywWHC6UIwO2nncbxtRR3Xx3ZTEl85itRCKJ07XUaOHgSsVXBEpuz4Bfnkqe6w
        QJmv/jTvWLqL+fjA6pZRy5feelXk0XG+lv7o6xZjsSscCPiKRE5Ahxdke/nQ1QGHlz0oz4
        nCBp5d7qGnhN9DxJt2xgFX13s+bRi/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-7A1dt8F2OziuGYE48A8inA-1; Mon, 16 Aug 2021 16:20:10 -0400
X-MC-Unique: 7A1dt8F2OziuGYE48A8inA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC5F91082921;
        Mon, 16 Aug 2021 20:20:09 +0000 (UTC)
Received: from localhost (unknown [10.22.8.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D74961095;
        Mon, 16 Aug 2021 20:20:01 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, kgold@linux.ibm.com,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH] libimaevm: make SHA-256 the default hash algorithm
Date:   Mon, 16 Aug 2021 17:19:59 -0300
Message-Id: <20210816201959.73218-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The SHA-1 algorithm is considered a weak hash algorithm and there has been
some movement within certain distros to drop its support completely or at
least drop it from the default behavior. ima-evm-utils uses it as the
default algorithm in case the user doesn't explicitly ask for another
through the --hashalgo/-a option. With that, make SHA-256 the default hash
algorithm instead.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 README          | 2 +-
 src/evmctl.c    | 2 +-
 src/libimaevm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 87cd3b5cd7da..0dc02f551673 100644
--- a/README
+++ b/README
@@ -41,7 +41,7 @@ COMMANDS
 OPTIONS
 -------
 
-  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512
+  -a, --hashalgo     sha1, sha224, sha256 (default), sha384, sha512
   -s, --imasig       make IMA signature
   -d, --imahash      make IMA hash
   -f, --sigfile      store IMA signature in .sig file instead of xattr
diff --git a/src/evmctl.c b/src/evmctl.c
index a8065bbe124a..e0e55bc0b122 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2496,7 +2496,7 @@ static void usage(void)
 
 	printf(
 		"\n"
-		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512, streebog256, streebog512\n"
+		"  -a, --hashalgo     sha1, sha224, sha256 (default), sha384, sha512, streebog256, streebog512\n"
 		"  -s, --imasig       make IMA signature\n"
 		"  -d, --imahash      make IMA hash\n"
 		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 8e9615796153..f6c72b878d88 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -88,7 +88,7 @@ static const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
 struct libimaevm_params imaevm_params = {
 	.verbose = LOG_INFO,
 	.x509 = 1,
-	.hash_algo = "sha1",
+	.hash_algo = "sha256",
 };
 
 static void __attribute__ ((constructor)) libinit(void);
-- 
2.31.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984EA3FF419
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Sep 2021 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243515AbhIBTZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Sep 2021 15:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347254AbhIBTZl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Sep 2021 15:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630610681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZI6zAqLGzo12DKCeI7bsT7JAgHm68VuY7rOZKsX5F4=;
        b=EkU6FTk/1ABgxzoAny5TQQJ9GWD1JTJgwdJiJyo9LvyzbIz4KE25ByUeq2Y+7m7GtSY4Pl
        0XaAHr50TXUp4aOF+gLMsbWMUbLk2AtMjF0BLVL4tk/xGPx8F1Olg1DBuVrk3wY+dcOSk0
        eqWQRwHtxYb2wXiI2fQqvn9mNA6YXhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-f9Y3zRhLNKWckLAuVJCLgA-1; Thu, 02 Sep 2021 15:24:40 -0400
X-MC-Unique: f9Y3zRhLNKWckLAuVJCLgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9918B107ACC7;
        Thu,  2 Sep 2021 19:24:39 +0000 (UTC)
Received: from localhost (unknown [10.22.8.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D2865D6B1;
        Thu,  2 Sep 2021 19:24:35 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v5 ima-evm-utils 1/2] set default hash algorithm in configuration time
Date:   Thu,  2 Sep 2021 16:24:26 -0300
Message-Id: <20210902192427.314337-2-bmeneg@redhat.com>
In-Reply-To: <20210902192427.314337-1-bmeneg@redhat.com>
References: <20210902192427.314337-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The default hash algorithm for evmctl is today hardcoded in the libimaevm.c
file. To facilitate package maintainers across different distributions to
set their own default hash algorithm this, patch adds the
--with-default-hash=<algo> option to the configuration script.

The chosen algorithm will then be checked by its available in the kernel,
otherwise IMA won't be able to verify files hashed by the user. For that,
the kernel header hash_info.h used as the source of supported hashes. In
case the hash_info.h header is not present, the configuration script warns
about it, but uses whatever the user specified in the option.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 README                  |  2 +-
 configure.ac            |  2 ++
 m4/default-hash-algo.m4 | 34 ++++++++++++++++++++++++++++++++++
 src/evmctl.c            |  4 ++--
 src/imaevm.h            |  4 ++++
 src/libimaevm.c         |  2 +-
 6 files changed, 44 insertions(+), 4 deletions(-)
 create mode 100644 m4/default-hash-algo.m4

diff --git a/README b/README
index 87cd3b5cd7da..4e35826cd982 100644
--- a/README
+++ b/README
@@ -41,7 +41,7 @@ COMMANDS
 OPTIONS
 -------
 
-  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512
+  -a, --hashalgo     sha1, sha224, sha256, sha384, sha512
   -s, --imasig       make IMA signature
   -d, --imahash      make IMA hash
   -f, --sigfile      store IMA signature in .sig file instead of xattr
diff --git a/configure.ac b/configure.ac
index a2d91b3db202..aff6fdfb26b4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,6 +62,7 @@ else
 fi
 
 EVMCTL_MANPAGE_DOCBOOK_XSL
+AX_DEFAULT_HASH_ALGO([$KERNEL_HEADERS])
 
 # for gcov
 #CFLAGS="$CFLAGS -Wall -fprofile-arcs -ftest-coverage"
@@ -81,6 +82,7 @@ echo
 echo
 echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
+echo	"   default-hash: $HASH_ALGO"
 echo	"   openssl-conf: $enable_openssl_conf"
 echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
 echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
diff --git a/m4/default-hash-algo.m4 b/m4/default-hash-algo.m4
new file mode 100644
index 000000000000..9a8b2ff34cfc
--- /dev/null
+++ b/m4/default-hash-algo.m4
@@ -0,0 +1,34 @@
+dnl Copyright (c) 2021 Bruno Meneguele <bmeneg@redhat.com>
+dnl Check hash algorithm availability in the kernel
+dnl
+dnl $1 - $KERNEL_HEADERS
+
+AC_DEFUN([AX_DEFAULT_HASH_ALGO], [
+	HASH_INFO_HEADER="$1/include/uapi/linux/hash_info.h"
+
+	AC_ARG_WITH([default_hash],
+		AS_HELP_STRING([--with-default-hash=ALGORITHM], [specifies the default hash algorithm to be used]),
+		[HASH_ALGO=$withval],
+		[HASH_ALGO=sha1])
+
+	AC_CHECK_HEADER([$HASH_INFO_HEADER],
+		[HAVE_HASH_INFO_HEADER=yes],
+		[AC_MSG_WARN([$HASH_INFO_HEADER not found.])])
+
+	if test "x$HAVE_HASH_INFO_HEADER" = "x"; then
+		AC_MSG_RESULT([using $HASH_ALGO algorithm as default hash algorith])
+		AC_DEFINE_UNQUOTED(DEFAULT_HASH_ALGO, "$HASH_ALGO", [Define default hash algorithm])
+	else
+		AC_PROG_SED()
+		AC_PROG_GREP()
+		$SED -n 's/HASH_ALGO_\(.*\),/\L\1\E/p' $HASH_INFO_HEADER | $GREP -w -i $HASH_ALGO > /dev/null
+		have_hash=$?
+
+		if test $have_hash -ne 0; then
+			AC_MSG_ERROR([$HASH_ALGO algorithm specified, but not provided by the kernel], 1)
+		else
+			AC_MSG_NOTICE([using $HASH_ALGO as default hash algorithm])
+			AC_DEFINE_UNQUOTED(DEFAULT_HASH_ALGO, "$HASH_ALGO", [Define default hash algorithm])
+		fi
+	fi
+])
diff --git a/src/evmctl.c b/src/evmctl.c
index c999589943aa..d9385a225e88 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2500,7 +2500,7 @@ static void usage(void)
 
 	printf(
 		"\n"
-		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512, streebog256, streebog512\n"
+		"  -a, --hashalgo     sha1, sha224, sha256, sha384, sha512, streebog256, streebog512 (default: %s)\n"
 		"  -s, --imasig       make IMA signature\n"
 		"  -d, --imahash      make IMA hash\n"
 		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
@@ -2534,7 +2534,7 @@ static void usage(void)
 		"      --ignore-violations ignore ToMToU measurement violations\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
-		"\n");
+		"\n", DEFAULT_HASH_ALGO);
 }
 
 struct command cmds[] = {
diff --git a/src/imaevm.h b/src/imaevm.h
index 491f136c105f..cc3dfd2e9163 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -74,6 +74,10 @@
 #define log_err(fmt, args...)		do_log(LOG_ERR, fmt, ##args)
 #define log_errno(fmt, args...)		do_log(LOG_ERR, fmt ": errno: %s (%d)\n", ##args, strerror(errno), errno)
 
+#ifndef DEFAULT_HASH_ALGO
+#define DEFAULT_HASH_ALGO "sha1"
+#endif
+
 #define	DATA_SIZE	4096
 #define SHA1_HASH_LEN   20
 
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 8e9615796153..2555e58a873b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -88,7 +88,7 @@ static const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
 struct libimaevm_params imaevm_params = {
 	.verbose = LOG_INFO,
 	.x509 = 1,
-	.hash_algo = "sha1",
+	.hash_algo = DEFAULT_HASH_ALGO,
 };
 
 static void __attribute__ ((constructor)) libinit(void);
-- 
2.31.1


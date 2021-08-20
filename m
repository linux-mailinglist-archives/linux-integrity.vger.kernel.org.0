Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C623F36A4
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Aug 2021 00:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhHTWuK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 18:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231482AbhHTWuK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 18:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629499771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krNVjqnLz26JYYE3QLybwAQYCW2Jx4q0QbF9I2ar7ns=;
        b=WQ0EIZf+UqmPyNy9tpW8/58SskLRUTHK9BrM82HsHtoopXN6IB5CmWI3HjDqcYZZolukuo
        daq47tFSi82bYCQLDCfFDoHs1WaDpsn/uSiGdY6i5xiomHRg0AFRWDYyQ1ZeoLyLcG2KA0
        xPDJKZsxB3tLOmuHMtCzKrcW9tpXbuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-JhZOLKkDMcicGylNgT08UQ-1; Fri, 20 Aug 2021 18:49:30 -0400
X-MC-Unique: JhZOLKkDMcicGylNgT08UQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 375B51008060;
        Fri, 20 Aug 2021 22:49:29 +0000 (UTC)
Received: from localhost (unknown [10.22.33.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CEB41017CE6;
        Fri, 20 Aug 2021 22:49:25 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v3 ima-evm-utils 1/2] set default hash algorithm in configuration time
Date:   Fri, 20 Aug 2021 19:49:16 -0300
Message-Id: <20210820224917.101053-2-bmeneg@redhat.com>
In-Reply-To: <20210820224917.101053-1-bmeneg@redhat.com>
References: <20210820224917.101053-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The default hash algorithm for evmctl is today hardcoded at libimaevm.c
file. To facilitate different distributions and users to set their own
default hash algorithm this patch adds the --with-default-hash=<algo> option
to the configuration script.

The algorithm chosen by the user will then be checked if is available in the
kernel, otherwise IMA won't be able to verify files hashed by the user. For
that, the file exposed by the kernel crypto API (/proc/crypto) is filtered
by an AWK script in order to check the algorithm's name and the module
providing it. Initally, only "module: kernel" is accepted, following IMA's
CONFIG_CRYPTO_SHA1/SHA256 dependency.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 README                  |  2 +-
 configure.ac            |  1 +
 m4/default-hash-algo.m4 | 48 +++++++++++++++++++++++++++++++++++++++++
 src/evmctl.c            |  4 ++--
 src/imaevm.h            |  4 ++++
 src/libimaevm.c         |  2 +-
 6 files changed, 57 insertions(+), 4 deletions(-)
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
index a2d91b3db202..1c45f7f757ea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,6 +62,7 @@ else
 fi
 
 EVMCTL_MANPAGE_DOCBOOK_XSL
+AX_DEFAULT_HASH_ALGO
 
 # for gcov
 #CFLAGS="$CFLAGS -Wall -fprofile-arcs -ftest-coverage"
diff --git a/m4/default-hash-algo.m4 b/m4/default-hash-algo.m4
new file mode 100644
index 000000000000..14be44731ba6
--- /dev/null
+++ b/m4/default-hash-algo.m4
@@ -0,0 +1,48 @@
+dnl Copyright (c) 2021 Bruno Meneguele <bmeneg@redhat.com>
+dnl Check hash algorithm availability in the kernel
+dnl
+dnl $1 = hash algorithm passed through --with-default-hash=<algo>
+
+AC_DEFUN([AX_DEFAULT_HASH_ALGO], [
+	CRYPTO_FILE="/proc/crypto"
+
+	AC_ARG_WITH([default_hash],
+		AS_HELP_STRING([--with-default-hash=ALGORITHM], [specifies the default hash algorithm to be used]),
+		[HASH_ALGO=$withval],
+		[HASH_ALGO=sha1])
+
+	AC_CHECK_FILE([$CRYPTO_FILE],
+		[HAVE_CRYPTO_FILE=yes],
+		[AC_MSG_WARN([$CRYPTO_FILE file not found.])])
+
+	if test "x$HAVE_CRYPTO_FILE" = "x"; then
+		AC_MSG_RESULT([using $HASH_ALGO algorithm as default hash algorith])
+		AC_DEFINE_UNQUOTED(DEFAULT_HASH_ALGO, "$HASH_ALGO", [Define default hash algorithm])
+	else
+		awk_script=$(cat <<-'EOF'
+			/^$/ { have_name = 0 }
+			/^name.*/ {
+				if ($3 == hashalgo) {
+					have_name = 1
+				}
+			}
+			/^module.*/ {
+				if (have_name && $3 == "kernel") {
+					exit 1
+				}
+			}
+		EOF
+		)
+
+		AC_PROG_AWK()
+		$AWK -v hashalgo=$HASH_ALGO '$awk_script' $CRYPTO_FILE &>/dev/null
+		have_hash=$?
+
+		if test "x$have_hash" = "x"; then
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


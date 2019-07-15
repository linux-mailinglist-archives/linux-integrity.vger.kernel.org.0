Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBBE69C54
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfGOUGS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 16:06:18 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58456 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfGOUGS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 16:06:18 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2122B72CA65;
        Mon, 15 Jul 2019 23:06:15 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 859B44A4A29;
        Mon, 15 Jul 2019 23:06:14 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 4/5] ima-evm-utils: Fix file2bin stat and fopen relations
Date:   Mon, 15 Jul 2019 23:05:52 +0300
Message-Id: <20190715200553.22403-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190715200553.22403-1-vt@altlinux.org>
References: <20190715200553.22403-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Check stat(2) return value, use fstat(2) to avoid race between
stat() and fopen(), remove now unused get_filesize().

Fixes: CID 229889.
---
 src/evmctl.c    | 26 +++++++++++++++++++++-----
 src/imaevm.h    |  1 -
 src/libimaevm.c |  8 --------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index f15056b..61808d2 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -175,9 +175,10 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
 static unsigned char *file2bin(const char *file, const char *ext, int *size)
 {
 	FILE *fp;
-	int len;
+	size_t len;
 	unsigned char *data;
 	char name[strlen(file) + (ext ? strlen(ext) : 0) + 2];
+	struct stat stats;
 
 	if (ext)
 		sprintf(name, "%s.%s", file, ext);
@@ -186,18 +187,33 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 
 	log_info("Reading to %s\n", name);
 
-	len = get_filesize(name);
 	fp = fopen(name, "r");
 	if (!fp) {
 		log_err("Failed to open: %s\n", name);
 		return NULL;
 	}
+	if (fstat(fileno(fp), &stats) == -1) {
+		log_err("Failed to fstat: %s (%s)\n", name, strerror(errno));
+		fclose(fp);
+		return NULL;
+	}
+	len = stats.st_size;
+
 	data = malloc(len);
-	if (!fread(data, len, 1, fp))
-		len = 0;
+	if (!data) {
+		log_err("Failed to malloc %zu bytes: %s\n", len, name);
+		fclose(fp);
+		return NULL;
+	}
+	if (fread(data, len, 1, fp) != len) {
+		log_err("Failed to fread %zu bytes: %s\n", len, name);
+		fclose(fp);
+		free(data);
+		return NULL;
+	}
 	fclose(fp);
 
-	*size = len;
+	*size = (int)len;
 	return data;
 }
 
diff --git a/src/imaevm.h b/src/imaevm.h
index dc81a3a..36050f4 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -211,7 +211,6 @@ extern struct libevm_params params;
 
 void do_dump(FILE *fp, const void *ptr, int len, bool cr);
 void dump(const void *ptr, int len);
-int get_filesize(const char *filename);
 int ima_calc_hash(const char *file, uint8_t *hash);
 int get_hash_algo(const char *algo);
 RSA *read_pub_key(const char *keyfile, int x509);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index f8ab812..1562aaf 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -116,14 +116,6 @@ const char *get_hash_algo_by_id(int algo)
 	return "unknown";
 }
 
-int get_filesize(const char *filename)
-{
-	struct stat stats;
-	/*  Need to know the file length */
-	stat(filename, &stats);
-	return (int)stats.st_size;
-}
-
 static inline off_t get_fdsize(int fd)
 {
 	struct stat stats;
-- 
2.11.0


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C2467635
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 23:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfGLV2u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 17:28:50 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:32884 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGLV2u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 17:28:50 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F216472CCDC;
        Sat, 13 Jul 2019 00:28:47 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id CB8174A4AE8;
        Sat, 13 Jul 2019 00:28:47 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 5/5] ima-evm-utils: Add more error checking in add_file_hash
Date:   Sat, 13 Jul 2019 00:28:33 +0300
Message-Id: <20190712212833.29280-5-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190712212833.29280-1-vt@altlinux.org>
References: <20190712212833.29280-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Check return value of fstat(2) in add_file_hash() and remove
now unused get_fdsize().
---
 src/libimaevm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 1562aaf..ae487f9 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -116,20 +116,13 @@ const char *get_hash_algo_by_id(int algo)
 	return "unknown";
 }
 
-static inline off_t get_fdsize(int fd)
-{
-	struct stat stats;
-	/*  Need to know the file length */
-	fstat(fd, &stats);
-	return stats.st_size;
-}
-
 static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
 {
 	uint8_t *data;
 	int err = -1, bs = DATA_SIZE;
 	off_t size, len;
 	FILE *fp;
+	struct stat stats;
 
 	fp = fopen(file, "r");
 	if (!fp) {
@@ -143,7 +136,12 @@ static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
 		goto out;
 	}
 
-	for (size = get_fdsize(fileno(fp)); size; size -= len) {
+	if (fstat(fileno(fp), &stats) == -1) {
+		log_err("Failed to fstat: %s (%s)\n", file, strerror(errno));
+		goto out;
+	}
+
+	for (size = stats.st_size; size; size -= len) {
 		len = MIN(size, bs);
 		if (!fread(data, len, 1, fp)) {
 			if (ferror(fp)) {
-- 
2.11.0


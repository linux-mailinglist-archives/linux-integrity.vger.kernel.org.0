Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369CD67631
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 23:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfGLV2m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 17:28:42 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60988 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGLV2m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 17:28:42 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2632972CC64;
        Sat, 13 Jul 2019 00:28:40 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id CCD754A4AE8;
        Sat, 13 Jul 2019 00:28:39 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 1/5] ima-evm-utils: Fix null dereference from file2bin to memcpy
Date:   Sat, 13 Jul 2019 00:28:29 +0300
Message-Id: <20190712212833.29280-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

file2bin() may return NULL, which is set to tmp, which is passed to
memcpy. Add explicit check for it. CID 229904.
---
 src/evmctl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index a6d07c9..39bc3d9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -821,7 +821,15 @@ static int verify_ima(const char *file)
 	if (sigfile) {
 		void *tmp = file2bin(file, "sig", &len);
 
-		assert(len <= sizeof(sig));
+		if (!tmp) {
+			log_err("Failed reading: %s\n", file);
+			return -1;
+		}
+		if (len > sizeof(sig)) {
+			log_err("File is too big: %s\n", file);
+			free(tmp);
+			return -1;
+		}
 		memcpy(sig, tmp, len);
 		free(tmp);
 	} else {
-- 
2.11.0


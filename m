Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4769C50
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfGOUGB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 16:06:01 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58194 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbfGOUGB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 16:06:01 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B7E7A72CA65;
        Mon, 15 Jul 2019 23:05:59 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 94BA64A4A29;
        Mon, 15 Jul 2019 23:05:59 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/5] ima-evm-utils: Fix null dereference from file2bin to memcpy
Date:   Mon, 15 Jul 2019 23:05:49 +0300
Message-Id: <20190715200553.22403-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

file2bin() may return NULL, which is set to tmp, which is passed to
memcpy. Add explicit check for it.

Fixes: CID 229904.
---
 src/evmctl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index a6d07c9..d6e0b2c 100644
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
+			log_err("Signature file is too big: %s\n", file);
+			free(tmp);
+			return -1;
+		}
 		memcpy(sig, tmp, len);
 		free(tmp);
 	} else {
-- 
2.11.0


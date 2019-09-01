Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0BA4B15
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Sep 2019 20:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfIASUR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Sep 2019 14:20:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48186 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfIASUQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Sep 2019 14:20:16 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BA64D72CC6C;
        Sun,  1 Sep 2019 21:20:14 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 2B1534A4AF6;
        Sun,  1 Sep 2019 21:20:13 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Fix possible DIR leak in find
Date:   Sun,  1 Sep 2019 21:20:09 +0300
Message-Id: <20190901182009.9117-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DIR is not closed if chdir errors occur.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 53711f4..b65139b 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1344,6 +1344,7 @@ static int find(const char *path, int dts, find_cb_t func)
 
 	if (fchdir(dirfd(dir))) {
 		log_err("Failed to chdir %s\n", path);
+		closedir(dir);
 		return -1;
 	}
 
@@ -1359,6 +1360,7 @@ static int find(const char *path, int dts, find_cb_t func)
 
 	if (chdir("..")) {
 		log_err("Failed to chdir: %s\n", path);
+		closedir(dir);
 		return -1;
 	}
 
-- 
2.11.0


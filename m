Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A025C5CA3B
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2019 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGBIAn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Jul 2019 04:00:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56901 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfGBIAn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jul 2019 04:00:43 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hiDiU-00040z-JW; Tue, 02 Jul 2019 10:00:42 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hiDiT-0005ta-SW; Tue, 02 Jul 2019 10:00:41 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] ima: fix freeing ongoing ahash_request
Date:   Tue,  2 Jul 2019 10:00:41 +0200
Message-Id: <20190702080041.22075-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702080041.22075-1-s.hauer@pengutronix.de>
References: <20190702080041.22075-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

integrity_kernel_read() can fail in which case we forward to call
ahash_request_free() on a currently running request. We have to wait
for its completion before we can free the request.

This was observed by interrupting a "find / -type f -xdev -print0 | xargs -0
cat 1>/dev/null" with ctrl-c on an IMA enabled filesystem.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 security/integrity/ima/ima_crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7532b062be59..73044fc6a952 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -271,6 +271,11 @@ static int ima_calc_file_hash_atfm(struct file *file,
 		if (rc != rbuf_len) {
 			if (rc >= 0)
 				rc = -EINVAL;
+			/*
+			 * Forward current rc, do not overwrite with return value
+			 * from ahash_wait()
+			 */
+			ahash_wait(ahash_rc, &wait);
 			goto out3;
 		}
 
-- 
2.20.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47098595D3
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2019 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfF1IOw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jun 2019 04:14:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfF1IOw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jun 2019 04:14:52 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hgm1z-0005cE-72; Fri, 28 Jun 2019 10:14:51 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hgm1y-0005wa-H0; Fri, 28 Jun 2019 10:14:50 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ima: fix freeing ongoing ahash_request
Date:   Fri, 28 Jun 2019 10:14:49 +0200
Message-Id: <20190628081449.22515-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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
 security/integrity/ima/ima_crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 16a4f45863b1..6a60bdb322b1 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -271,8 +271,10 @@ static int ima_calc_file_hash_atfm(struct file *file,
 		rbuf_len = min_t(loff_t, i_size - offset, rbuf_size[active]);
 		rc = integrity_kernel_read(file, offset, rbuf[active],
 					   rbuf_len);
-		if (rc != rbuf_len)
+		if (rc != rbuf_len) {
+			ahash_wait(ahash_rc, &wait);
 			goto out3;
+		}
 
 		if (rbuf[1] && offset) {
 			/* Using two buffers, and it is not the first
-- 
2.20.1


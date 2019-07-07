Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7674761895
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 01:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfGGXtQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jul 2019 19:49:16 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43248 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfGGXtQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 19:49:16 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1DE0572CC6C;
        Mon,  8 Jul 2019 02:49:14 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8C1EF4A4AE8;
        Mon,  8 Jul 2019 02:49:13 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 4/5] ima-evm-utils: Allow multiple files in ima_verify
Date:   Mon,  8 Jul 2019 02:48:36 +0300
Message-Id: <20190707234837.4866-5-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190707234837.4866-1-vt@altlinux.org>
References: <20190707234837.4866-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This allows testing multiple verify in a row, similar to ima_measurement.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index fac593a..7ce2022 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -850,9 +850,11 @@ static int cmd_verify_ima(struct command *cmd)
 		return -1;
 	}
 
-	err = verify_ima(file);
-	if (!err && params.verbose >= LOG_INFO)
-		log_info("%s: verification is OK\n", file);
+	do {
+		err = verify_ima(file);
+		if (!err && params.verbose >= LOG_INFO)
+			log_info("%s: verification is OK\n", file);
+	} while ((file = g_argv[optind++]));
 	return err;
 }
 
-- 
2.11.0


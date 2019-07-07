Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2161894
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 01:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfGGXtL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jul 2019 19:49:11 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43172 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfGGXtL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 19:49:11 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C56F372CC6C;
        Mon,  8 Jul 2019 02:49:09 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8215C4A4AE8;
        Mon,  8 Jul 2019 02:49:09 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 3/5] ima-evm-utils: Preload public keys for ima_verify
Date:   Mon,  8 Jul 2019 02:48:35 +0300
Message-Id: <20190707234837.4866-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190707234837.4866-1-vt@altlinux.org>
References: <20190707234837.4866-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This allows testing verify_hash_v2() with multiple public keys.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4e0a831..fac593a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -840,6 +840,9 @@ static int cmd_verify_ima(struct command *cmd)
 	char *file = g_argv[optind++];
 	int err;
 
+	if (params.keyfile)
+		init_public_keys(params.keyfile);
+
 	errno = 0;
 	if (!file) {
 		log_err("Parameters missing\n");
-- 
2.11.0


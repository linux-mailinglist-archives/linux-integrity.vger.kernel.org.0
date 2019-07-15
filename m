Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216A869C53
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfGOUGM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 16:06:12 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58400 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfGOUGL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 16:06:11 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2A5D672CA65;
        Mon, 15 Jul 2019 23:06:10 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0ECB54A4A29;
        Mon, 15 Jul 2019 23:06:10 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 3/5] ima-evm-utils: Fix memory leak in get_password
Date:   Mon, 15 Jul 2019 23:05:51 +0300
Message-Id: <20190715200553.22403-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190715200553.22403-1-vt@altlinux.org>
References: <20190715200553.22403-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Free allocated password buffer when returning NULL.

Fixes: CID 229894 (partially).
---
 src/evmctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 04dc546..f15056b 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1841,6 +1841,7 @@ static char *get_password(void)
 
 	if (tcsetattr(fileno(stdin), TCSANOW, &tmp_flags) != 0) {
 		perror("tcsetattr");
+		free(password);
 		return NULL;
 	}
 
@@ -1850,6 +1851,7 @@ static char *get_password(void)
 	/* restore terminal */
 	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
 		perror("tcsetattr");
+		free(password);
 		return NULL;
 	}
 
-- 
2.11.0


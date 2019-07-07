Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B002961893
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 01:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfGGXtH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jul 2019 19:49:07 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43116 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfGGXtH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 19:49:07 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5708972CC6C;
        Mon,  8 Jul 2019 02:49:05 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 169AE4A4AE8;
        Mon,  8 Jul 2019 02:49:05 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 2/5] ima-evm-utils: Fix memory leak in init_public_keys
Date:   Mon,  8 Jul 2019 02:48:34 +0300
Message-Id: <20190707234837.4866-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190707234837.4866-1-vt@altlinux.org>
References: <20190707234837.4866-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

strdup'ed string should be freed. Found with ASan.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index fe1962b..b556276 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -421,11 +421,12 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
 void init_public_keys(const char *keyfiles)
 {
 	struct public_key_entry *entry;
-	char *tmp_keyfiles;
+	char *tmp_keyfiles, *keyfiles_free;
 	char *keyfile;
 	int i = 1;
 
 	tmp_keyfiles = strdup(keyfiles);
+	keyfiles_free = tmp_keyfiles;
 
 	while ((keyfile = strsep(&tmp_keyfiles, ", \t")) != NULL) {
 		if (!keyfile)
@@ -452,6 +453,7 @@ void init_public_keys(const char *keyfiles)
 		entry->next = public_keys;
 		public_keys = entry;
 	}
+	free(keyfiles_free);
 }
 
 /*
-- 
2.11.0


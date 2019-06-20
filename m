Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E3D4C7EC
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 09:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfFTHNl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jun 2019 03:13:41 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40196 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTHNl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jun 2019 03:13:41 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 82F2C72CC64;
        Thu, 20 Jun 2019 10:13:39 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 681E94A4A29;
        Thu, 20 Jun 2019 10:13:39 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v6 05/11] ima-evm-utils: Start converting find_keyid to EVP_PKEY API
Date:   Thu, 20 Jun 2019 10:12:58 +0300
Message-Id: <20190620071304.24495-6-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190620071304.24495-1-vt@altlinux.org>
References: <20190620071304.24495-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

New find_keyid_pkey() accepts EVP_PKEY. Old find_keyid() calls
find_keyid_pkey(), but still return RSA key.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 707b2e9..ae18005 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -452,11 +452,11 @@ struct public_key_entry {
 	struct public_key_entry *next;
 	uint32_t keyid;
 	char name[9];
-	RSA *key;
+	EVP_PKEY *key;
 };
 static struct public_key_entry *public_keys = NULL;
 
-static RSA *find_keyid(uint32_t keyid)
+static EVP_PKEY *find_keyid_pkey(uint32_t keyid)
 {
 	struct public_key_entry *entry;
 
@@ -467,6 +467,22 @@ static RSA *find_keyid(uint32_t keyid)
 	return NULL;
 }
 
+static RSA *find_keyid(uint32_t keyid)
+{
+	EVP_PKEY *pkey;
+	RSA *key;
+
+	pkey = find_keyid_pkey(keyid);
+	if (!pkey)
+		return NULL;
+	key = EVP_PKEY_get0_RSA(pkey);
+	if (!key) {
+		log_err("find_keyid: unsupported key type\n");
+		return NULL;
+	}
+	return key;
+}
+
 void init_public_keys(const char *keyfiles)
 {
 	struct public_key_entry *entry;
@@ -489,13 +505,13 @@ void init_public_keys(const char *keyfiles)
 			break;
 		}
 
-		entry->key = read_pub_key(keyfile, 1);
+		entry->key = read_pub_pkey(keyfile, 1);
 		if (!entry->key) {
 			free(entry);
 			continue;
 		}
 
-		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
+		calc_pkeyid_v2(&entry->keyid, entry->name, entry->key);
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
 		entry->next = public_keys;
-- 
2.11.0


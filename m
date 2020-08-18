Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB26248AE5
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHRP5v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:57:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727931AbgHRPq5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:46:57 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4CFA21D71B243D763320;
        Tue, 18 Aug 2020 16:46:56 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:46:54 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:46:57 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 24/30] keys: Include key domain tag in the iterative search
Date:   Tue, 18 Aug 2020 17:42:24 +0200
Message-ID: <20200818154230.14016-15-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
References: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Add domain tag to the key_match_data. If set, check domain tag in the
default match function and asymmetric keys match functions.

This will allow to use the key domain tag in the search criteria for
the iterative search, not only for the direct lookup that is based on
the index key.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 crypto/asymmetric_keys/asymmetric_type.c | 20 ++++++++++++++++----
 include/linux/key-type.h                 |  1 +
 security/keys/keyring.c                  | 10 +++++++++-
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 33e77d846caa..177429bc5c7b 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -249,9 +249,15 @@ static bool asymmetric_key_cmp(const struct key *key,
 {
 	const struct asymmetric_key_ids *kids = asymmetric_key_ids(key);
 	const struct asymmetric_key_id *match_id = match_data->preparsed;
+	bool match;
 
-	return asymmetric_match_key_ids(kids, match_id,
-					asymmetric_key_id_same);
+	match = asymmetric_match_key_ids(kids, match_id,
+					 asymmetric_key_id_same);
+
+	if (match_data->domain_tag)
+		match &= key->index_key.domain_tag == match_data->domain_tag;
+
+	return match;
 }
 
 /*
@@ -262,9 +268,15 @@ static bool asymmetric_key_cmp_partial(const struct key *key,
 {
 	const struct asymmetric_key_ids *kids = asymmetric_key_ids(key);
 	const struct asymmetric_key_id *match_id = match_data->preparsed;
+	bool match;
+
+	match = asymmetric_match_key_ids(kids, match_id,
+					 asymmetric_key_id_partial);
+
+	if (match_data->domain_tag)
+		match &= key->index_key.domain_tag == match_data->domain_tag;
 
-	return asymmetric_match_key_ids(kids, match_id,
-					asymmetric_key_id_partial);
+	return match;
 }
 
 /*
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 2ab2d6d6aeab..c8ea26ab242c 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -55,6 +55,7 @@ struct key_match_data {
 	unsigned	lookup_type;	/* Type of lookup for this search. */
 #define KEYRING_SEARCH_LOOKUP_DIRECT	0x0000	/* Direct lookup by description. */
 #define KEYRING_SEARCH_LOOKUP_ITERATE	0x0001	/* Iterative search. */
+	struct key_tag  *domain_tag;    /* Key domain tag */
 };
 
 /*
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 12583241ff63..7e45e534035f 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -565,7 +565,13 @@ int restrict_link_reject(struct key *keyring,
 bool key_default_cmp(const struct key *key,
 		     const struct key_match_data *match_data)
 {
-	return strcmp(key->description, match_data->raw_data) == 0;
+	bool match;
+
+	match = strcmp(key->description, match_data->raw_data) == 0;
+	if (match_data->domain_tag)
+		match &= key->index_key.domain_tag == match_data->domain_tag;
+
+	return match;
 }
 
 /*
@@ -957,6 +963,8 @@ key_ref_t keyring_search_tag(key_ref_t keyring,
 
 	if (recurse)
 		ctx.flags |= KEYRING_SEARCH_RECURSE;
+	if (domain_tag)
+		ctx.match_data.domain_tag = domain_tag;
 	if (type->match_preparse) {
 		ret = type->match_preparse(&ctx.match_data);
 		if (ret < 0)
-- 
2.20.1


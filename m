Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C4F36755B
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 00:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbhDUWxN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 18:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhDUWxM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 18:53:12 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75860C06174A;
        Wed, 21 Apr 2021 15:52:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 383E8128017B;
        Wed, 21 Apr 2021 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619045558;
        bh=65pamZPNVatXTCiWrNHPd8mAhwMvTJEFQ1K830XlC7A=;
        h=Message-ID:Subject:From:To:Date:From;
        b=c80xcgH6ARPu7HkHLebeNzNL0vyA6szp57Xl3H1GnrqMumPaJ+8PogU93LS68cJ/R
         jeURXg7nysGSYhhuPyohaG/Yh9fVe0Ft6SstuHqwzM47gxdlgHhPNlVhKok+aWKttU
         av7VlK4AVzDWxubPT4PQ4OZHVx18+UXiACiZStfs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id StQDnBVK16O5; Wed, 21 Apr 2021 15:52:38 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C72EF1280165;
        Wed, 21 Apr 2021 15:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619045558;
        bh=65pamZPNVatXTCiWrNHPd8mAhwMvTJEFQ1K830XlC7A=;
        h=Message-ID:Subject:From:To:Date:From;
        b=c80xcgH6ARPu7HkHLebeNzNL0vyA6szp57Xl3H1GnrqMumPaJ+8PogU93LS68cJ/R
         jeURXg7nysGSYhhuPyohaG/Yh9fVe0Ft6SstuHqwzM47gxdlgHhPNlVhKok+aWKttU
         av7VlK4AVzDWxubPT4PQ4OZHVx18+UXiACiZStfs=
Message-ID: <c1b82b603a28934cc45b9dc486688c306aab644e.camel@HansenPartnership.com>
Subject: [PATCH] KEYS: trusted: fix TPM trusted keys for generic framework
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     jarkko@kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 21 Apr 2021 15:52:37 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The generic framework patch broke the current TPM trusted keys because
it doesn't correctly remove the values consumed by the generic parser
before passing them on to the implementation specific parser.  Fix
this by having the generic parser return the string minus the consumed
tokens.

Additionally, there may be no tokens left for the implementation
specific parser, so make it handle the NULL case correctly and finally
fix a TPM 1.2 specific check for no keyhandle.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 security/keys/trusted-keys/trusted_core.c | 24 +++++++++++------------
 security/keys/trusted-keys/trusted_tpm1.c |  5 ++++-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 90774793f0b1..d5c891d8d353 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -62,7 +62,7 @@ static const match_table_t key_tokens = {
  *
  * On success returns 0, otherwise -EINVAL.
  */
-static int datablob_parse(char *datablob, struct trusted_key_payload *p)
+static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 {
 	substring_t args[MAX_OPT_ARGS];
 	long keylen;
@@ -71,14 +71,14 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p)
 	char *c;
 
 	/* main command */
-	c = strsep(&datablob, " \t");
+	c = strsep(datablob, " \t");
 	if (!c)
 		return -EINVAL;
 	key_cmd = match_token(c, key_tokens, args);
 	switch (key_cmd) {
 	case Opt_new:
 		/* first argument is key size */
-		c = strsep(&datablob, " \t");
+		c = strsep(datablob, " \t");
 		if (!c)
 			return -EINVAL;
 		ret = kstrtol(c, 10, &keylen);
@@ -89,7 +89,7 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p)
 		break;
 	case Opt_load:
 		/* first argument is sealed blob */
-		c = strsep(&datablob, " \t");
+		c = strsep(datablob, " \t");
 		if (!c)
 			return -EINVAL;
 		p->blob_len = strlen(c) / 2;
@@ -140,7 +140,7 @@ static int trusted_instantiate(struct key *key,
 {
 	struct trusted_key_payload *payload = NULL;
 	size_t datalen = prep->datalen;
-	char *datablob;
+	char *datablob, *orig_datablob;
 	int ret = 0;
 	int key_cmd;
 	size_t key_len;
@@ -148,7 +148,7 @@ static int trusted_instantiate(struct key *key,
 	if (datalen <= 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	orig_datablob = datablob = kmalloc(datalen + 1, GFP_KERNEL);
 	if (!datablob)
 		return -ENOMEM;
 	memcpy(datablob, prep->data, datalen);
@@ -160,7 +160,7 @@ static int trusted_instantiate(struct key *key,
 		goto out;
 	}
 
-	key_cmd = datablob_parse(datablob, payload);
+	key_cmd = datablob_parse(&datablob, payload);
 	if (key_cmd < 0) {
 		ret = key_cmd;
 		goto out;
@@ -196,7 +196,7 @@ static int trusted_instantiate(struct key *key,
 		ret = -EINVAL;
 	}
 out:
-	kfree_sensitive(datablob);
+	kfree_sensitive(orig_datablob);
 	if (!ret)
 		rcu_assign_keypointer(key, payload);
 	else
@@ -220,7 +220,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	struct trusted_key_payload *p;
 	struct trusted_key_payload *new_p;
 	size_t datalen = prep->datalen;
-	char *datablob;
+	char *datablob, *orig_datablob;
 	int ret = 0;
 
 	if (key_is_negative(key))
@@ -231,7 +231,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	if (datalen <= 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
-	datablob = kmalloc(datalen + 1, GFP_KERNEL);
+	orig_datablob = datablob = kmalloc(datalen + 1, GFP_KERNEL);
 	if (!datablob)
 		return -ENOMEM;
 
@@ -243,7 +243,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 
 	memcpy(datablob, prep->data, datalen);
 	datablob[datalen] = '\0';
-	ret = datablob_parse(datablob, new_p);
+	ret = datablob_parse(&datablob, new_p);
 	if (ret != Opt_update) {
 		ret = -EINVAL;
 		kfree_sensitive(new_p);
@@ -267,7 +267,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	rcu_assign_keypointer(key, new_p);
 	call_rcu(&p->rcu, trusted_rcu_free);
 out:
-	kfree_sensitive(datablob);
+	kfree_sensitive(orig_datablob);
 	return ret;
 }
 
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 798dc7820084..469394550801 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -747,6 +747,9 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 
 	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
 
+	if (!c)
+		return 0;
+
 	while ((p = strsep(&c, " \t"))) {
 		if (*p == '\0' || *p == ' ' || *p == '\t')
 			continue;
@@ -944,7 +947,7 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	dump_options(options);
 
-	if (!options->keyhandle) {
+	if (!options->keyhandle && !tpm2) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.26.2



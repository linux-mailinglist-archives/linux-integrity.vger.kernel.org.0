Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159E6369D17
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Apr 2021 01:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbhDWXFO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Apr 2021 19:05:14 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:39416 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243236AbhDWXFF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Apr 2021 19:05:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CCCC912805E0;
        Fri, 23 Apr 2021 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619219067;
        bh=EvcwOC67P8i6xhWNY2Fy8D2fKnBdoTZv+6sSfbs3CrQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=d00lOxF65Lf0SpGPeD5wW/xQZ+FPHDvpGsRyBYDY33wHl5DwPc8WKv6OHywnwao0e
         ZU5wiWvXFaEoJYs9mO9OAWMoKzZsgF9YViRODnBRM/cXbK3sB+cW5aP608vHAs+Bup
         D+zDlQE67u3+uKesK5gjnx3TAV7ouckwAk6OAHSs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O5SHQ4Iy6raj; Fri, 23 Apr 2021 16:04:27 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 51C3212805D3;
        Fri, 23 Apr 2021 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619219067;
        bh=EvcwOC67P8i6xhWNY2Fy8D2fKnBdoTZv+6sSfbs3CrQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=d00lOxF65Lf0SpGPeD5wW/xQZ+FPHDvpGsRyBYDY33wHl5DwPc8WKv6OHywnwao0e
         ZU5wiWvXFaEoJYs9mO9OAWMoKzZsgF9YViRODnBRM/cXbK3sB+cW5aP608vHAs+Bup
         D+zDlQE67u3+uKesK5gjnx3TAV7ouckwAk6OAHSs=
Message-ID: <52f4810fbcdb3a118b7126e2497ae384016c9004.camel@HansenPartnership.com>
Subject: [GIT PULL] TPM DEVICE DRIVER updates for v5.13 (updated)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        dhowells@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Date:   Fri, 23 Apr 2021 16:04:26 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix a regression in the TPM trusted keys caused by the generic rework
to add ARM TEE based trusted keys.  Without this fix, the TPM trusted
key subsystem fails to add or load any keys.

This is an incremental update to Jarkko's previous pull request (which
contains the regression):

https://lore.kernel.org/linux-integrity/YHb06P4IOGV7eoiJ@kernel.org/

So if you could pull both in succession to minimize the bisection
problem, I'd be grateful (it's only a functional regression not a
compile one so the bisection problem would only impact someone
bisecting trusted keys).

There's also a minor conflict caused by the previous urgent fix I sent,
but the resolution is obvious.

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/tpmdd.git queue

The short changelog is:

James Bottomley (1):
      KEYS: trusted: fix TPM trusted keys for generic framework

And the diffstat:

 security/keys/trusted-keys/trusted_core.c | 24 ++++++++++++------------
 security/keys/trusted-keys/trusted_tpm1.c |  5 ++++-
 2 files changed, 16 insertions(+), 13 deletions(-)

With full diff below.

James

---

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


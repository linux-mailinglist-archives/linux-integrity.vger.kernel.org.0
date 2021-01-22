Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B3C2FFEA4
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Jan 2021 09:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbhAVIrj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Jan 2021 03:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbhAVIov (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jan 2021 03:44:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F7C0613D6
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jan 2021 00:44:08 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l2s2s-00061d-GP; Fri, 22 Jan 2021 09:43:54 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l2s2r-0006HR-PH; Fri, 22 Jan 2021 09:43:53 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [PATCH 2/2] dm crypt: support using trusted keys
Date:   Fri, 22 Jan 2021 09:43:21 +0100
Message-Id: <20210122084321.24012-2-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122084321.24012-1-a.fatoum@pengutronix.de>
References: <20210122084321.24012-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 27f5411a718c ("dm crypt: support using encrypted keys") extended
dm-crypt to allow use of "encrypted" keys along with "user" and "logon".

Along the same lines, teach dm-crypt to support "trusted" keys as well.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
Unsure on whether target_type::version is something authors increment or
maintainers fix up. I can respin if needed.

Cc: Jan Lübbe <jlu@pengutronix.de>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 .../admin-guide/device-mapper/dm-crypt.rst    |  2 +-
 drivers/md/Kconfig                            |  1 +
 drivers/md/dm-crypt.c                         | 23 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documentation/admin-guide/device-mapper/dm-crypt.rst
index 1a6753b76dbb..aa2d04d95df6 100644
--- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
+++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
@@ -67,7 +67,7 @@ Parameters::
     the value passed in <key_size>.
 
 <key_type>
-    Either 'logon', 'user' or 'encrypted' kernel key type.
+    Either 'logon', 'user', 'encrypted' or 'trusted' kernel key type.
 
 <key_description>
     The kernel keyring key description crypt target should look for
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 9e44c09f6410..f2014385d48b 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -270,6 +270,7 @@ config DM_CRYPT
 	tristate "Crypt target support"
 	depends on BLK_DEV_DM
 	depends on (ENCRYPTED_KEYS || ENCRYPTED_KEYS=n)
+	depends on (TRUSTED_KEYS || TRUSTED_KEYS=n)
 	select CRYPTO
 	select CRYPTO_CBC
 	select CRYPTO_ESSIV
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 7eeb9248eda5..6c7c687e546c 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -37,6 +37,7 @@
 #include <linux/key-type.h>
 #include <keys/user-type.h>
 #include <keys/encrypted-type.h>
+#include <keys/trusted-type.h>
 
 #include <linux/device-mapper.h>
 
@@ -2452,6 +2453,22 @@ static int set_key_encrypted(struct crypt_config *cc, struct key *key)
 	return 0;
 }
 
+static int set_key_trusted(struct crypt_config *cc, struct key *key)
+{
+	const struct trusted_key_payload *tkp;
+
+	tkp = key->payload.data[0];
+	if (!tkp)
+		return -EKEYREVOKED;
+
+	if (cc->key_size != tkp->key_len)
+		return -EINVAL;
+
+	memcpy(cc->key, tkp->key, cc->key_size);
+
+	return 0;
+}
+
 static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string)
 {
 	char *new_key_string, *key_desc;
@@ -2484,6 +2501,10 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 		   !strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
 		type = &key_type_encrypted;
 		set_key = set_key_encrypted;
+	} else if (IS_ENABLED(CONFIG_TRUSTED_KEYS) &&
+	           !strncmp(key_string, "trusted:", key_desc - key_string + 1)) {
+		type = &key_type_trusted;
+		set_key = set_key_trusted;
 	} else {
 		return -EINVAL;
 	}
@@ -3555,7 +3576,7 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 static struct target_type crypt_target = {
 	.name   = "crypt",
-	.version = {1, 22, 0},
+	.version = {1, 23, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
-- 
2.30.0


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031A135CA98
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Apr 2021 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbhDLQB3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Apr 2021 12:01:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48242 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhDLQB2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Apr 2021 12:01:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lVyzm-00066Z-2w; Mon, 12 Apr 2021 16:01:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] KEYS: trusted: Fix missing null return from kzalloc call
Date:   Mon, 12 Apr 2021 17:01:01 +0100
Message-Id: <20210412160101.1627882-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The kzalloc call can return null with the GFP_KERNEL flag so
add a null check and exit via a new error exit label. Use the
same exit error label for another error path too.

Addresses-Coverity: ("Dereference null return value")
Fixes: 830027e2cb55 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/keys/trusted-keys/trusted_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index ec3a066a4b42..90774793f0b1 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -116,11 +116,13 @@ static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
 
 	ret = key_payload_reserve(key, sizeof(*p));
 	if (ret < 0)
-		return p;
+		goto err;
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		goto err;
 
 	p->migratable = migratable;
-
+err:
 	return p;
 }
 
-- 
2.30.2


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2451B3D4
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 02:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiEDX5u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 19:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359450AbiEDXZK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 19:25:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759224DF4A
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 16:21:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a11so2306728pff.1
        for <linux-integrity@vger.kernel.org>; Wed, 04 May 2022 16:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yhdb5Bb/HPOT7rt6ZFl1SIPi2sOZMgAuPW9HJM+UwR0=;
        b=Lk4xT28VP//2/ipug2hDVNsFxT9ZIxqyDHb0zfUWgwzqxrDXikdUEYcZVll3q4j94i
         ztdggJgt0+wJWipyAMzuue+sqAj5cr1iqrjXU6TY0KlGJi2k7/sLjz4SzJeD6C1FqUri
         Vuh+XJBEfDQcKfui50SG/RlDJ8yjXNcYwrQew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yhdb5Bb/HPOT7rt6ZFl1SIPi2sOZMgAuPW9HJM+UwR0=;
        b=3kQ7218pjjXkx9iBUv0CVdm0BVtvJrBblWzux6zO6Y5XXZM5k3a3+PItph2nueMyDX
         37QH5fZe1yggKkhycEAIqtp9X2ChfFvzZlA62N8KPe7Ps485TkaU6cY27wNo7ytSbO26
         zqJKH9blHJhBo7tL5BM3HjMlAuVOHOYmJzv7XmnIy7HPFsm380EDnINxCZ5gdwEN7fBm
         yPKatDLnFnkahpJsrw4IeQqIajtUP8hSPh6VYOOrwKZ4QRRNqTxleMgD1Y4msjYNHLd2
         No8ql8lq5XWCcKrCgz1a9J1wEZESpFdw7LWcVljK+q+5V+qD9CKkYUHn/rv95qUmCh1v
         v8VA==
X-Gm-Message-State: AOAM533NFj+hyTDJRWM5MetL9ezGj4/MzDgun7xcte6nu81EhKJifEv4
        hLSxFHeglSQ6cFh2+r3f51MrJQ==
X-Google-Smtp-Source: ABdhPJw5P1NIDRBbT4jMlDGJLeiA/MnnIE6iVTPAa0LCmNhzVLp/2G2suU9nzhm2DtywpArEruqEYA==
X-Received: by 2002:a62:ce82:0:b0:50d:512f:7b76 with SMTP id y124-20020a62ce82000000b0050d512f7b76mr23214566pfg.79.1651706491900;
        Wed, 04 May 2022 16:21:31 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902f78c00b0015e8d4eb2d6sm1901pln.288.2022.05.04.16.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:21:31 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 03/10] security: keys: trusted: Parse out individual components of the key blob
Date:   Wed,  4 May 2022 16:20:55 -0700
Message-Id: <20220504161439.3.Id409e0cf397bd98b76df6eb60ff16454679dd23d@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220504232102.469959-1-evgreen@chromium.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Matthew Garrett <matthewgarrett@google.com>

Performing any sort of state validation of a sealed TPM blob requires
being able to access the individual members in the response. Parse the
blob sufficiently to be able to stash pointers to each member, along
with the length.

From: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>

Signed-off-by: Evan Green <evgreen@chromium.org>
---
Matthew's original version of this patch is at:
https://patchwork.kernel.org/patch/12096489/

 include/keys/trusted-type.h               |  8 +++
 security/keys/trusted-keys/trusted_tpm2.c | 67 ++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index d89fa2579ac056..8a793ae1ad9f70 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -22,15 +22,23 @@
 #define MAX_BLOB_SIZE			512
 #define MAX_PCRINFO_SIZE		64
 #define MAX_DIGEST_SIZE			64
+#define MAX_CREATION_DATA		412
+#define MAX_TK				76
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
 	unsigned int key_len;
 	unsigned int blob_len;
+	unsigned int creation_len;
+	unsigned int creation_hash_len;
+	unsigned int tk_len;
 	unsigned char migratable;
 	unsigned char old_format;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
+	unsigned char *creation;
+	unsigned char *creation_hash;
+	unsigned char *tk;
 };
 
 struct trusted_key_options {
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0165da386289c3..296a00f872ba40 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -215,6 +215,63 @@ static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
 		tpm_buf_append(buf, hmac, hmac_len);
 }
 
+static int tpm2_unpack_blob(struct trusted_key_payload *payload)
+{
+	int tmp, offset;
+
+	/* Find the length of the private data */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[0]);
+	offset = tmp + 2;
+	if (offset > payload->blob_len)
+		return -EFAULT;
+
+	/* Find the length of the public data */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[offset]);
+	offset += tmp + 2;
+	if (offset > payload->blob_len)
+		return -EFAULT;
+
+	/* Find the length of the creation data and store it */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[offset]);
+	if (tmp > MAX_CREATION_DATA)
+		return -E2BIG;
+
+	if ((offset + tmp + 2) > payload->blob_len)
+		return -EFAULT;
+
+	payload->creation = &payload->blob[offset + 2];
+	payload->creation_len = tmp;
+	offset += tmp + 2;
+
+	/* Find the length of the creation hash and store it */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[offset]);
+	if (tmp > MAX_DIGEST_SIZE)
+		return -E2BIG;
+
+	if ((offset + tmp + 2) > payload->blob_len)
+		return -EFAULT;
+
+	payload->creation_hash = &payload->blob[offset + 2];
+	payload->creation_hash_len = tmp;
+	offset += tmp + 2;
+
+	/*
+	 * Store the creation ticket. TPMT_TK_CREATION is two bytes of tag,
+	 * four bytes of handle, and then the digest length and digest data
+	 */
+	tmp = be16_to_cpup((__be16 *) &payload->blob[offset + 6]);
+	if (tmp > MAX_TK)
+		return -E2BIG;
+
+	if ((offset + tmp + 8) > payload->blob_len)
+		return -EFAULT;
+
+	payload->tk = &payload->blob[offset];
+	payload->tk_len = tmp + 8;
+
+	return 0;
+}
+
 /**
  * tpm2_seal_trusted() - seal the payload of a trusted key
  *
@@ -229,6 +286,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_options *options)
 {
 	int blob_len = 0;
+	unsigned int offset;
 	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
@@ -317,15 +375,17 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		rc = -E2BIG;
 		goto out;
 	}
-	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
+	offset = TPM_HEADER_SIZE + 4;
+	if (tpm_buf_length(&buf) < offset + blob_len) {
 		rc = -EFAULT;
 		goto out;
 	}
 
 	blob_len = tpm2_key_encode(payload, options,
-				   &buf.data[TPM_HEADER_SIZE + 4],
+				   &buf.data[offset],
 				   blob_len);
 
+	rc = tpm2_unpack_blob(payload);
 out:
 	tpm_buf_destroy(&buf);
 
@@ -431,7 +491,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
+	else
+		goto out;
 
+	rc = tpm2_unpack_blob(payload);
 out:
 	if (blob != payload->blob)
 		kfree(blob);
-- 
2.31.0


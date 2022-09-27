Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F695ECA10
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiI0QvO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiI0QuP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 12:50:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3555FDF8
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:50:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm5so9574060plb.13
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Y5IIjhYcp6pllpBstUKppAn5vOER8d/5NeFiMFC+AZ4=;
        b=KtOFCJo06CDDr+BAxpO/ygHq6cEPoZynIvZgbfM1UHBzDuHQUJ5CbEi4ZoiG9svTxR
         pKrL9ectGlvt8OIUq4guOEuCs5QSQsuOcd71aO/aHyyn3G+JRcxLp4QddwkV6WaeekXJ
         p/dLQjZ0L0skPBXMyfxZMM9L8/y7cz6FrOn3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y5IIjhYcp6pllpBstUKppAn5vOER8d/5NeFiMFC+AZ4=;
        b=0nDX5XxOKy0A39QBVprsjcBBGYkWe6HsSEWI5cL121g++vqdzOg3JBSfkpUH5A/uXC
         qCag3tYIJ3GXMC+Cw1iyj8cHRTxSeBnglC8IgLF6w8NVJYad+rtDj8iHbcLcBVIK3sAI
         yAeS2vrTIf0o+zGFvnai9xmbSAH1sjPif0qBWzoK37fPqcqaD3K8UBB/j0Y3xj9DHHRa
         duYNaD3U8/xWbAIrY0Oqd89817+FfSgfu8GPramFkeNtre9tFqLOWW6vPjOgBI+qR7Q6
         cR3uQzMxyq4rnnR88wx1N4qoYPaW2MlcmrY4nqj88fpQhxSegkDY7jf9qo2LdrepRsko
         TuHg==
X-Gm-Message-State: ACrzQf2hlhnda6QBeJ3EnnzlQBBdQJmesvPmKlMvNQfvLwdRwy64Pv0U
        hnAoYvidaztZ3B9BxGIZp7PHuLi8BOLjRUUAApA=
X-Google-Smtp-Source: AMsMyM4ctE5xgYsg5LsKG4IlQynNCZ/9CXt4peHvCFJnISdc8MiKkgtgmmifk2yFFB9mBJnY2OBKVA==
X-Received: by 2002:a17:90a:1096:b0:202:c5a9:bf1e with SMTP id c22-20020a17090a109600b00202c5a9bf1emr5669884pja.3.1664297411430;
        Tue, 27 Sep 2022 09:50:11 -0700 (PDT)
Received: from evgreen-glaptop.lan ([73.231.74.141])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b00434272fe870sm1753509pgd.88.2022.09.27.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:50:10 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        dlunev@google.com, jarkko@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Ben Boeckel <me@benboeckel.net>, rjw@rjwysocki.net,
        corbet@lwn.net, linux-pm@vger.kernel.org, zohar@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 06/11] security: keys: trusted: Verify creation data
Date:   Tue, 27 Sep 2022 09:49:17 -0700
Message-Id: <20220927094559.v3.6.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220927164922.3383711-1-evgreen@chromium.org>
References: <20220927164922.3383711-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If a loaded key contains creation data, ask the TPM to verify that
creation data. This allows users like encrypted hibernate to know that
the loaded and parsed creation data has not been tampered with.

Suggested-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>

---
Source material for this change is at:
https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/

Changes in v3:
 - Changed funky tag to suggested-by (Kees). Matthew, holler if you want
   something different.

Changes in v2:
 - Adjust hash len by 2 due to new ASN.1 storage, and add underflow
   check.

 include/linux/tpm.h                       |  1 +
 security/keys/trusted-keys/trusted_tpm2.c | 77 ++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8320cbac6f4009..438f8bc0a50582 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -224,6 +224,7 @@ enum tpm2_command_codes {
 	TPM2_CC_SELF_TEST	        = 0x0143,
 	TPM2_CC_STARTUP		        = 0x0144,
 	TPM2_CC_SHUTDOWN	        = 0x0145,
+	TPM2_CC_CERTIFYCREATION	        = 0x014A,
 	TPM2_CC_NV_READ                 = 0x014E,
 	TPM2_CC_CREATE		        = 0x0153,
 	TPM2_CC_LOAD		        = 0x0157,
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index a7ad83bc0e5396..c76a1b5a2e8471 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -703,6 +703,74 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	return rc;
 }
 
+/**
+ * tpm2_certify_creation() - execute a TPM2_CertifyCreation command
+ *
+ * @chip: TPM chip to use
+ * @payload: the key data in clear and encrypted form
+ * @blob_handle: the loaded TPM handle of the key
+ *
+ * Return: 0 on success
+ *         -EINVAL on tpm error status
+ *         < 0 error from tpm_send or tpm_buf_init
+ */
+static int tpm2_certify_creation(struct tpm_chip *chip,
+				 struct trusted_key_payload *payload,
+				 u32 blob_handle)
+{
+	struct tpm_header *head;
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CERTIFYCREATION);
+	if (rc)
+		return rc;
+
+	/* Use TPM_RH_NULL for signHandle */
+	tpm_buf_append_u32(&buf, 0x40000007);
+
+	/* Object handle */
+	tpm_buf_append_u32(&buf, blob_handle);
+
+	/* Auth */
+	tpm_buf_append_u32(&buf, 9);
+	tpm_buf_append_u32(&buf, TPM2_RS_PW);
+	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u8(&buf, 0);
+	tpm_buf_append_u16(&buf, 0);
+
+	/* Qualifying data */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* Creation data hash */
+	if (payload->creation_hash_len < 2) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	tpm_buf_append_u16(&buf, payload->creation_hash_len - 2);
+	tpm_buf_append(&buf, payload->creation_hash + 2,
+		       payload->creation_hash_len - 2);
+
+	/* signature scheme */
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+
+	/* creation ticket */
+	tpm_buf_append(&buf, payload->tk, payload->tk_len);
+
+	rc = tpm_transmit_cmd(chip, &buf, 6, "certifying creation data");
+	if (rc)
+		goto out;
+
+	head = (struct tpm_header *)buf.data;
+
+	if (be32_to_cpu(head->return_code) != TPM2_RC_SUCCESS)
+		rc = -EINVAL;
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
 /**
  * tpm2_unseal_trusted() - unseal the payload of a trusted key
  *
@@ -728,8 +796,15 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
-	tpm2_flush_context(chip, blob_handle);
+	if (rc)
+		goto flush;
+
+	if (payload->creation_len)
+		rc = tpm2_certify_creation(chip, payload, blob_handle);
 
+
+flush:
+	tpm2_flush_context(chip, blob_handle);
 out:
 	tpm_put_ops(chip);
 
-- 
2.31.0


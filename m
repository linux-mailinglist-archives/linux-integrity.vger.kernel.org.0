Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384C562656B
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Nov 2022 00:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiKKXUT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Nov 2022 18:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiKKXT4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Nov 2022 18:19:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06D83386
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k7so5376609pll.6
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT6eX+hZD0ZTySUyAECYTCle2DEgzv1f+QjqPC3Dddk=;
        b=U2W25pAvqdkdkWLcokZmO7l4t8Bw+tkvFOixYVuwcikCJOh84eIQEtmWeKRV3H67Cl
         kkxJiMOaisdceUpyytoKvTfzcHeG1zNMnbI8yauLRuL0bHiOYiKgs6QRKMPhmj7br+cC
         RfbQaXDPPOrgB0ad6d6z+NtpYbMorkvaHf22o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT6eX+hZD0ZTySUyAECYTCle2DEgzv1f+QjqPC3Dddk=;
        b=WWO8QMpFFcyL9XCxXWAERRoVE7vJyU8VgimUg+THr7OBX57iJExhhIC871VzkJBG4z
         MJku0kllTZ0yT5iwVXBkwKbfVGJmI8YQCuqaKMipWgip/wat4LET3RxZ3fjQ/55wxLq3
         Mdlk4Lyzfo+O88VSLlPESqD8NMPkPx3LkgZDpyfXSQgsMHDNd1L4VFeReHmpv/X7GacS
         wQ+A2tA2IoEEF2FnJRNyCxyPtJmsRwPXH8y1P9i5A2gi3r+tb5C4RmGW/wkLZIeLnFCz
         GgDSpOnb5bMRby0Rzmp5XbUuYb7cp9hu3ipoFZ/kUMCZXtL4Bc2lAYNT8fiO/lG0MiY8
         jd0w==
X-Gm-Message-State: ANoB5plJm3CJVCe1+N0s0JbNEnch6aFCD99/52syk4qIqIRRqFyQHsrm
        30nUjyycbg3N6s6BFkVP9vuAGw==
X-Google-Smtp-Source: AA0mqf4p+IlUyIKh3j0vUMhqyQotcP0Ad7fK3S6VQzoCBIJimaKlPbs9tjtuMVYQHk1nqchFwy1AhQ==
X-Received: by 2002:a17:902:9b97:b0:186:5f71:7939 with SMTP id y23-20020a1709029b9700b001865f717939mr4244136plp.162.1668208791108;
        Fri, 11 Nov 2022 15:19:51 -0800 (PST)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056da2ad6503sm2106900pfx.39.2022.11.11.15.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:19:50 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v5 06/11] security: keys: trusted: Verify creation data
Date:   Fri, 11 Nov 2022 15:16:31 -0800
Message-Id: <20221111151451.v5.6.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221111231636.3748636-1-evgreen@chromium.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Kees Cook <keescook@chromium.org>

---
Source material for this change is at:
https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/

(no changes since v3)

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
index 70134e6551745f..9c2ee3e30ffa5d 100644
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
index 3d84c3d41bdee1..402933f8c99ede 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -730,6 +730,74 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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
@@ -755,8 +823,15 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
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
2.38.1.431.g37b22c650d-goog


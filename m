Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B37AD8F8
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfIIM0M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:26:12 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48464 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfIIM0M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:26:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C0E118EE180;
        Mon,  9 Sep 2019 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031971;
        bh=csl1p+iOrNhw06A6Hxg92JmKgHQMEZhIYZe+hrtc18U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fzIwv1ElyC0z8uaUCLPUDw3DiyKXbrMx/W1AlH1DM52zdRgyRsWHDgW4b+r3XnWWV
         +0MiHA3zHE5qswwbJ4HztKcIVCjZ9T6on9OmtnuxZthG7tAXSRSOi6MK2i5nMUaMh3
         +UscWp4xv5/kwOK5ZH8pRrkF5mR4ZacBAaz69BKk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1ghtuE34fWcP; Mon,  9 Sep 2019 05:26:10 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8DC748EE105;
        Mon,  9 Sep 2019 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031969;
        bh=csl1p+iOrNhw06A6Hxg92JmKgHQMEZhIYZe+hrtc18U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r8iAdH/uuN5R9O2OwVB+IusHfUN7fLQSc5fTmNGPAj6BboX/T2qTU+PC9PYhzJanK
         rtptSgYH4UDSgnd+j/JLBuzlmrLY7tP2s4/ilDJFcT3CMUXouY/n7ix/bRxvgZgMTe
         5v5QlDSJCbenxUzttXlUSk4Du/wcDVMEN9chQeCM=
Message-ID: <1568031965.6613.41.camel@HansenPartnership.com>
Subject: [PATCH v6 12/12] tpm2-sessions: NOT FOR COMMITTING add sessions
 testing
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:26:05 +0100
In-Reply-To: <1568031408.6613.29.camel@HansenPartnership.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This runs through a preset sequence using sessions to demonstrate that
the session handling code functions.  It does both HMAC, encryption
and decryption by testing an encrypted sealing operation with
authority and proving that the same sealed data comes back again via
an HMAC and response encryption.  It also does policy unsealing which
mimics the more complex of the trusted key scenarios.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v3: add policy unseal testing with two sessions
v6: move to new null seed framework
---
 drivers/char/tpm/Makefile             |   2 +
 drivers/char/tpm/tpm-chip.c           |   1 +
 drivers/char/tpm/tpm.h                |   1 +
 drivers/char/tpm/tpm2-cmd.c           |   7 +
 drivers/char/tpm/tpm2-sessions-test.c | 795 ++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.c      |   1 +
 drivers/char/tpm/tpm2-sessions.h      |   3 +-
 7 files changed, 809 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/tpm/tpm2-sessions-test.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 8f9e58317048..f6577c9e3138 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -35,3 +35,5 @@ obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
 obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
 obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
+
+obj-m +=  tpm2-sessions-test.o
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 4838c6a9f0f2..5dda37047a71 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -252,6 +252,7 @@ struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
 		return NULL;
 	return chip;
 }
+EXPORT_SYMBOL(tpm_find_get_ops);
 
 /**
  * tpm_dev_release() - free chip memory and the device number
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index c88eee6376e4..06f63874e833 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -117,6 +117,7 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_POLICY_COMMAND_CODE	= 0x16c,
 	TPM2_CC_READ_PUBLIC		= 0x0173,
 	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 2c798f18282f..d4bbe19170d1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -222,6 +222,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 	tpm_buf_destroy(&buf);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm2_pcr_read);
 
 /**
  * tpm2_pcr_extend() - extend a PCR value
@@ -269,6 +270,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm2_pcr_extend);
 
 struct tpm2_get_random_out {
 	__be16 size;
@@ -353,6 +355,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	tpm_buf_destroy(&buf);
 	return err;
 }
+EXPORT_SYMBOL_GPL(tpm2_get_random);
 
 /**
  * tpm2_flush_context() - execute a TPM2_FlushContext command
@@ -376,6 +379,7 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
 	tpm_buf_destroy(&buf);
 }
+EXPORT_SYMBOL_GPL(tpm2_flush_context);
 
 /**
  * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
@@ -406,6 +410,7 @@ void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
 	if (hmac && hmac_len)
 		tpm_buf_append(buf, hmac, hmac_len);
 }
+EXPORT_SYMBOL_GPL(tpm2_buf_append_auth);
 
 /**
  * tpm2_seal_trusted() - seal the payload of a trusted key
@@ -532,6 +537,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm2_seal_trusted);
 
 /**
  * tpm2_load_cmd() - execute a TPM2_Load command
@@ -715,6 +721,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	tpm2_flush_context(chip, blob_handle);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm2_unseal_trusted);
 
 struct tpm2_get_cap_out {
 	u8 more_data;
diff --git a/drivers/char/tpm/tpm2-sessions-test.c b/drivers/char/tpm/tpm2-sessions-test.c
new file mode 100644
index 000000000000..834811ab3466
--- /dev/null
+++ b/drivers/char/tpm/tpm2-sessions-test.c
@@ -0,0 +1,795 @@
+/* run a set of tests of the sessions code */
+#include "tpm.h"
+#include "tpm2-sessions.h"
+
+#include <linux/random.h>
+
+#include <asm/unaligned.h>
+
+#include <crypto/aes.h>
+#include <crypto/hash.h>
+
+#include <keys/trusted-type.h>
+
+/* simple policy: command code must be TPM2_CC_UNSEAL */
+static u8 policy[] = {
+	0xe6, 0x13, 0x13, 0x70, 0x76, 0x52, 0x4b, 0xde,
+	0x48, 0x75, 0x33, 0x86, 0x58, 0x84, 0xe9, 0x73,
+	0x2e, 0xbe, 0xe3, 0xaa, 0xcb, 0x09, 0x5d, 0x94,
+	0xa6, 0xde, 0x49, 0x2e, 0xc0, 0x6c, 0x46, 0xfa,
+};
+
+static struct crypto_shash *sha256_hash;
+
+static int parse_create_primary(struct tpm_chip *chip, u8 *data, u32 *nullkey)
+{
+	struct tpm_header *head = (struct tpm_header *)data;
+	u16 len;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val, parm_len;
+	const u8 *resp, *tmp;
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+
+	data += TPM_HEADER_SIZE;
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	resp = data;
+	*nullkey = tpm_get_inc_u32(&resp);
+	parm_len = tpm_get_inc_u32(&resp);
+	if (parm_len + 8 > tot_len)
+		return -EINVAL;
+	len = tpm_get_inc_u16(&resp);
+	tmp = resp;
+	/* now we have the public area, compute the name of the object */
+	desc->tfm = sha256_hash;
+	put_unaligned_be16(TPM_ALG_SHA256, chip->tpmkeyname);
+	crypto_shash_init(desc);
+	crypto_shash_update(desc, resp, len);
+	crypto_shash_final(desc, chip->tpmkeyname + 2);
+	/* validate the public key */
+	val = tpm_get_inc_u16(&tmp);
+	/* key type (must be what we asked for) */
+	if (val != TPM_ALG_ECC)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* name algorithm */
+	if (val != TPM_ALG_SHA256)
+		return -EINVAL;
+	val = tpm_get_inc_u32(&tmp);
+	/* object properties */
+	if (val != (TPM2_OA_NO_DA |
+		    TPM2_OA_FIXED_TPM |
+		    TPM2_OA_FIXED_PARENT |
+		    TPM2_OA_SENSITIVE_DATA_ORIGIN |
+		    TPM2_OA_USER_WITH_AUTH |
+		    TPM2_OA_DECRYPT |
+		    TPM2_OA_RESTRICTED))
+		return -EINVAL;
+	/* auth policy (empty) */
+	val = tpm_get_inc_u16(&tmp);
+	if (val != 0)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric key parameters */
+	if (val != TPM_ALG_AES)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric key length */
+	if (val != AES_KEYSIZE_128 * 8)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric encryption scheme */
+	if (val != TPM_ALG_CFB)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* signing scheme */
+	if (val != TPM_ALG_NULL)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* ECC Curve */
+	if (val != TPM2_ECC_NIST_P256)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* KDF Scheme */
+	if (val != TPM_ALG_NULL)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* x point */
+	if (val != 32)
+		return -EINVAL;
+	memcpy(chip->ec_point_x, tmp, val);
+	tmp += val;
+	val = tpm_get_inc_u16(&tmp);
+	if (val != 32)
+		return -EINVAL;
+	memcpy(chip->ec_point_y, tmp, val);
+	tmp += val;
+	resp += len;
+	/* should have exactly consumed the tpm2b public structure */
+	if (tmp != resp)
+		return -EINVAL;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/* creation data (skip) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/* creation digest (must be sha256) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (len != SHA256_DIGEST_SIZE || resp - data > parm_len)
+		return -EINVAL;
+	/* TPMT_TK_CREATION follows */
+	/* tag, must be TPM_ST_CREATION (0x8021) */
+	val = tpm_get_inc_u16(&resp);
+	if (val != TPM2_ST_CREATION || resp - data > parm_len)
+		return -EINVAL;
+	/* hierarchy (must be NULL) */
+	val = tpm_get_inc_u32(&resp);
+	if (val != TPM2_RH_NULL || resp - data > parm_len)
+		return -EINVAL;
+	/* the ticket digest HMAC (might not be sha256) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/*
+	 * finally we have the name, which is a sha256 digest plus a 2
+	 * byte algorithm type
+	 */
+	len = tpm_get_inc_u16(&resp);
+	if (resp + len - data != parm_len + 8)
+		return -EINVAL;
+	if (len != SHA256_DIGEST_SIZE + 2)
+		return -EINVAL;
+
+	if (memcmp(chip->tpmkeyname, resp, SHA256_DIGEST_SIZE + 2) != 0) {
+		printk("TPM NULL Seed name comparison failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy, u32 *handle)
+{
+	int rc;
+	struct tpm_buf buf;
+	struct tpm_buf template;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
+	if (rc)
+		return rc;
+
+	rc = tpm_buf_init_2b(&template);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		return rc;
+	}
+
+	/*
+	 * create the template.  Note: in order for userspace to
+	 * verify the security of the system, it will have to create
+	 * and certify this NULL primary, meaning all the template
+	 * parameters will have to be identical, so conform exactly to
+	 * the TCG TPM v2.0 Provisioning Guidance for the SRK ECC
+	 * key
+	 */
+
+	/* key type */
+	tpm_buf_append_u16(&template, TPM_ALG_ECC);
+	/* name algorithm */
+	tpm_buf_append_u16(&template, TPM_ALG_SHA256);
+	/* object properties */
+	tpm_buf_append_u32(&template, TPM2_OA_NO_DA |
+			   TPM2_OA_FIXED_TPM |
+			   TPM2_OA_FIXED_PARENT |
+			   TPM2_OA_SENSITIVE_DATA_ORIGIN |
+			   TPM2_OA_USER_WITH_AUTH |
+			   TPM2_OA_DECRYPT |
+			   TPM2_OA_RESTRICTED);
+	/* sauth policy (empty) */
+	tpm_buf_append_u16(&template, 0);
+
+	/* BEGIN parameters: key specific; for ECC*/
+	/* symmetric algorithm */
+	tpm_buf_append_u16(&template, TPM_ALG_AES);
+	/* bits for symmetric algorithm */
+	tpm_buf_append_u16(&template, 128);
+	/* algorithm mode (must be CFB) */
+	tpm_buf_append_u16(&template, TPM_ALG_CFB);
+	/* scheme (NULL means any scheme) */
+	tpm_buf_append_u16(&template, TPM_ALG_NULL);
+	/* ECC Curve ID */
+	tpm_buf_append_u16(&template, TPM2_ECC_NIST_P256);
+	/* KDF Scheme */
+	tpm_buf_append_u16(&template, TPM_ALG_NULL);
+	/* unique: key specific; for ECC it is two points */
+	tpm_buf_append_u16(&template, 0);
+	tpm_buf_append_u16(&template, 0);
+	/* END parameters */
+
+	/* primary handle */
+	tpm_buf_append_u32(&buf, hierarchy);
+	/* simple authorization for empty auth */
+	tpm2_buf_append_auth(&buf, TPM2_RS_PW, NULL, 0, 0, NULL, 0);
+	/* sensitive create size is 4 for two empty buffers */
+	tpm_buf_append_u16(&buf, 4);
+	/* sensitive create auth data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* sensitive create sensitive data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* the public template */
+	tpm_buf_append_2b(&buf, &template);
+	tpm_buf_destroy(&template);
+	/* outside info (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* creation PCR (none) */
+	tpm_buf_append_u32(&buf, 0);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0,
+			      "attempting to create NULL primary");
+
+	if (rc == TPM2_RC_SUCCESS)
+		rc = parse_create_primary(chip, buf.data, handle);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
+static u32 get_policy(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	u8 nonce[SHA256_DIGEST_SIZE];
+	u32 h;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS);
+	if (rc)
+		return 0;
+
+	/* salt key */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+	/* bind key */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+	/* zero nonce */
+	memset(nonce, 0, sizeof(nonce));
+	tpm_buf_append_u16(&buf, sizeof(nonce));
+	tpm_buf_append(&buf, nonce, sizeof(nonce));
+	/* encrypted salt (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* session type (HMAC, audit or policy) */
+	tpm_buf_append_u8(&buf, TPM2_SE_POLICY);
+	/* symmetric encryption parameters */
+	/* symmetric algorithm */
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+
+	/* hash algorithm for session */
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "start policy session");
+
+	h = get_unaligned_be32(&buf.data[TPM_HEADER_SIZE]);
+
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS,
+		      TPM2_CC_POLICY_COMMAND_CODE);
+	tpm_buf_append_u32(&buf, h);
+	tpm_buf_append_u32(&buf, TPM2_CC_UNSEAL);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "start policy session");
+
+	tpm_buf_destroy(&buf);
+
+	dev_info(&chip->dev, "got policy session %08x\n", h);
+
+	return h;
+}
+
+int tpm2_sessions_test(void)
+{
+	struct tpm2_auth *auth;
+	struct tpm_buf buf, b1;
+	struct tpm_buf t2b;
+	struct tpm_chip *chip;
+	int rc;
+	char payload[MIN_KEY_SIZE+3];
+	char *password = "Passw0Rd";
+	const u8 *p;
+	u32 h, ps;
+	u8 name[34];
+	u16 len;
+	int ret = -EINVAL;
+	u32 nullkey = 0;
+	struct trusted_key_payload tkp;
+	struct trusted_key_options tko;
+	struct tpm_digest digest, extend[3];
+	u16 digest_len;
+	int i;
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+
+	chip = tpm_find_get_ops(NULL);
+	if (!chip)
+		return -ENODEV;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
+		return -ENODEV;
+
+	sha256_hash = crypto_alloc_shash("sha256", 0, 0);
+
+	/* precursor: get a session */
+	rc = tpm2_start_auth_session(chip, &auth);
+
+	dev_info(&chip->dev, "TPM: start auth session returned %d\n", rc);
+
+	if (rc)
+		return -ENODEV;
+
+	/* first test: get random bytes from TPM */
+	dev_info(&chip->dev, "test 1: TPM random number generator\n");
+	rc = tpm2_get_random(chip, payload, sizeof(payload));
+	if (rc != sizeof(payload)) {
+		dev_err(&chip->dev, "tpm2_get_random failed: %d\n", rc);
+		goto out;
+	}
+	dev_info(&chip->dev, "test 1: PASS\n");
+
+	/*
+	 * second test, seal random data protecting sensitive by
+	 * encryption and also doing response encryption (not
+	 * necessary) The encrypted payload has two components: an
+	 * authorization password which must be presented on useal and
+	 * the actual data (the random payload)
+	 */
+	dev_info(&chip->dev, "test2: seal data and check tpm unsealing functions\n");
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey);
+
+	if (rc != TPM2_RC_SUCCESS) {
+		dev_err(&chip->dev, "tpm2_create_primary failed: %d\n", rc);
+		goto out;
+	}
+
+	dev_info(&chip->dev, "NULL KEY at %08x\n", nullkey);
+
+	tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	tpm_buf_append_name(&buf, auth, nullkey, chip->tpmkeyname);
+	/* close the session here, get a new one for next seal op */
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_DECRYPT
+				    | TPM2_SA_ENCRYPT, NULL, 0);
+	/* sensitive */
+	tpm_buf_init_2b(&t2b);
+	/* the authorization */
+	tpm_buf_append_u16(&t2b, strlen(password));
+	tpm_buf_append(&t2b, password, strlen(password));
+	/* the payload */
+	tpm_buf_append_u16(&t2b, sizeof(payload) + 1);
+	tpm_buf_append(&t2b, payload, sizeof(payload));
+	/* the migrateable flag used by the TPM sealing functions */
+	tpm_buf_append_u8(&t2b, 0);
+	tpm_buf_append_2b(&buf, &t2b);
+	/* the public */
+	/* type */
+	tpm_buf_append_u16(&t2b, TPM_ALG_KEYEDHASH);
+	/* name hash */
+	tpm_buf_append_u16(&t2b, TPM_ALG_SHA256);
+	/* object properties */
+	tpm_buf_append_u32(&t2b, TPM2_OA_USER_WITH_AUTH | TPM2_OA_NO_DA);
+	/* auth policy (empty) */
+	tpm_buf_append_u16(&t2b, 0);
+	/* keyed hash parameters (we're null for a non-HMAC data blob) */
+	tpm_buf_append_u16(&t2b, TPM_ALG_NULL);
+	/* unique */
+	tpm_buf_append_u16(&t2b, 0);
+	tpm_buf_append_2b(&buf, &t2b);
+	/* outside info (also empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* creation PCR (empty) */
+	tpm_buf_append_u32(&buf, 0);
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+	dev_info(&chip->dev, "TPM: sealing response returned %d\n", rc);
+	if (rc)
+		goto out;
+
+	/*
+	 * now load the sealed object (we need the pub and priv parts
+	 * returned from prior command
+	 */
+	memset(&tkp, 0, sizeof(tkp));
+	memset(&tko, 0, sizeof(tko));
+
+	p = &buf.data[TPM_HEADER_SIZE];
+
+	tkp.blob_len = tpm_get_inc_u32(&p);
+	memcpy(tkp.blob, p, tkp.blob_len);
+	tko.keyhandle = nullkey;
+	strcpy(tko.blobauth, password);
+
+	rc = tpm2_unseal_trusted(chip, &tkp, &tko);
+	if (rc) {
+		dev_err(&chip->dev, "tpm2_unseal_trusted[password] returned %d\n", rc);
+		goto out;
+	}
+
+	if (tkp.key_len != sizeof(payload)) {
+		dev_err(&chip->dev, "tpm2_unseal_trusted[password] wrong unseal payload size %d != %ld",
+			tkp.key_len, sizeof(payload));
+		goto out;
+	}
+	if (memcmp(payload, tkp.key, tkp.key_len) != 0) {
+		dev_err(&chip->dev, "tpm2_unseal_trusted[password] Payload DID NOT compare correctly\n");
+		goto out;
+	}
+	dev_info(&chip->dev, "tpm2_unseal_trusted[password] returned correct data\n"
+		 "test2: PASS\n");
+
+	/*
+	 * third test, seal random data protecting sensitive by
+	 * encryption and also doing response encryption (not
+	 * necessary) The encrypted payload has two components: an
+	 * authorization password which must be presented on useal and
+	 * the actual data (the random payload)
+	 *
+	 * For this test use a policy to release the data testing that
+	 * we can have two sessions
+	 */
+
+	dev_info(&chip->dev, "test 3: seal to policy and test unseal\n");
+	rc = tpm2_get_random(chip, payload, sizeof(payload));
+	if (rc != sizeof(payload)) {
+		dev_err(&chip->dev, "tpm2_get_random failed: %d\n", rc);
+		goto out;
+	}
+
+	/* auth session should be closed, so get a new one */
+	rc = tpm2_start_auth_session(chip, &auth);
+	if (rc) {
+		dev_err(&chip->dev, "new auth session failed: %d\n", rc);
+		goto out;
+	}
+
+	tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	tpm_buf_append_name(&buf, auth, nullkey, chip->tpmkeyname);
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_DECRYPT
+				    | TPM2_SA_ENCRYPT
+				    | TPM2_SA_CONTINUE_SESSION, NULL, 0);
+	/* sensitive */
+	tpm_buf_init_2b(&t2b);
+	/* the authorization */
+	tpm_buf_append_u16(&t2b, 0);
+	/* the payload */
+	tpm_buf_append_u16(&t2b, sizeof(payload) + 1);
+	tpm_buf_append(&t2b, payload, sizeof(payload));
+	/* extra byte for migratability flag */
+	tpm_buf_append_u8(&t2b, 0);
+	tpm_buf_append_2b(&buf, &t2b);
+	/* the public */
+	/* type */
+	tpm_buf_append_u16(&t2b, TPM_ALG_KEYEDHASH);
+	/* name hash */
+	tpm_buf_append_u16(&t2b, TPM_ALG_SHA256);
+	/* object properties */
+	tpm_buf_append_u32(&t2b, TPM2_OA_NO_DA);
+	/* auth policy (specific to command code) */
+	tpm_buf_append_u16(&t2b, sizeof(policy));
+	tpm_buf_append(&t2b, policy, sizeof(policy));
+	/* keyed hash parameters (we're null for a non-HMAC data blob) */
+	tpm_buf_append_u16(&t2b, TPM_ALG_NULL);
+	/* unique */
+	tpm_buf_append_u16(&t2b, 0);
+	tpm_buf_append_2b(&buf, &t2b);
+	/* outside info (also empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* creation PCR (empty) */
+	tpm_buf_append_u32(&buf, 0);
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &buf, 4, "policy sealing data");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+	dev_info(&chip->dev, "policy sealing response returned %d\n", rc);
+	if (rc)
+		goto out;
+
+	/*
+	 * now load the sealed object (we need the pub and priv parts
+	 * returned from prior command
+	 */
+	memset(&tkp, 0, sizeof(tkp));
+	memset(&tko, 0, sizeof(tko));
+
+	p = &buf.data[TPM_HEADER_SIZE];
+
+	/* now get a policy session */
+	ps = get_policy(chip);
+
+	tkp.blob_len = tpm_get_inc_u32(&p);
+	memcpy(tkp.blob, p, tkp.blob_len);
+	tko.keyhandle = nullkey;
+	tko.policyhandle = ps;
+
+	rc = tpm2_unseal_trusted(chip, &tkp, &tko);
+	if (rc) {
+		dev_err(&chip->dev, "tpm2_unseal_trusted[policy] returned %d\n", rc);
+		tpm2_flush_context(chip, ps);
+		goto out;
+	}
+
+	if (tkp.key_len != sizeof(payload)) {
+		dev_err(&chip->dev, "tpm2_unseal_trusted[policy] wrong unseal payload size %d != %ld",
+			tkp.key_len, sizeof(payload));
+		goto out;
+	}
+	if (memcmp(payload, tkp.key, tkp.key_len) != 0) {
+		dev_err(&chip->dev, "tpm2_unseal_trusted[policy] Payload DID NOT compare correctly\n");
+		goto out;
+	}
+	dev_info(&chip->dev, "tpm2_unseal_trusted[policy] returned correct data\n"
+		 "test3: PASS\n");
+
+	/*
+	 * test4: get the TPM routines to seal to a password and then
+	 * do a manual unseal
+	 */
+
+	dev_info(&chip->dev, "test4: seal using tpm2-cmd[password] and unseal manually\n");
+
+	memset(&tkp, 0, sizeof(tkp));
+	memset(&tko, 0, sizeof(tko));
+
+	tko.keyhandle = nullkey;
+	tko.hash = HASH_ALGO_SHA256;
+	tkp.key_len = sizeof(payload);
+	memcpy(tkp.key, payload, tkp.key_len);
+	strcpy(tko.blobauth, password);
+
+	rc = tpm2_seal_trusted(chip, &tkp, &tko);
+	if (rc) {
+		dev_err(&chip->dev, "tpm2_seal_trusted returned error: %d\n ", rc);
+		goto out;
+	}
+
+	/*
+	 * now load the sealed object (we need the pub and priv parts
+	 * returned from prior command.  The blob from
+	 * tpm2_seal_trusted is the entire return from the create, so
+	 * only append the private and public parts
+	 */
+	p = tkp.blob;
+	/* private len */
+	len = tpm_get_inc_u16(&p);
+	p += len;
+	/* add public len */
+	len += tpm_get_inc_u16(&p);
+	/* add 4 for the two length values */
+	len += 4;
+
+	tpm_buf_init(&b1, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	/* parent */
+	tpm_buf_append_name(&b1, auth, nullkey, chip->tpmkeyname);
+	tpm_buf_append_hmac_session(&b1, auth, TPM2_SA_CONTINUE_SESSION,
+				    NULL, 0);
+
+	tpm_buf_append(&b1, tkp.blob, len);
+
+	tpm_buf_fill_hmac_session(&b1, auth);
+	rc = tpm_transmit_cmd(chip, &b1, 4, "loading seal");
+	rc = tpm_buf_check_hmac_response(&b1, auth, rc);
+	dev_info(&chip->dev, "TPM: load response returned %d\n", rc);
+	if (rc)
+		goto out;
+	p = &b1.data[TPM_HEADER_SIZE];
+	h = tpm_get_inc_u32(&p);
+	dev_info(&chip->dev, "sealed data loaded at %08x\n", h);
+	/* skip over parameter size */
+	p += 4;
+	len = tpm_get_inc_u16(&p);
+	if (len != sizeof(name)) {
+		dev_err(&chip->dev, "Wrong name size %d\n", len);
+		goto out;
+	}
+	memcpy(name, p, len);
+	tpm_buf_destroy(&b1);
+	tpm_buf_destroy(&buf);
+
+	/*
+	 * now unseal the data using the authority in a HMAC and
+	 * protecting the returned unseal by encryption
+	 */
+	tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	tpm_buf_append_name(&buf, auth, h, name);
+	tpm_buf_append_hmac_session(&buf, auth,
+				    TPM2_SA_ENCRYPT | TPM2_SA_CONTINUE_SESSION,
+				    password, strlen(password));
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &buf, 4, "unseal");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+	tpm2_flush_context(chip, h);
+	dev_info(&chip->dev, "unseal returns %d\n", rc);
+	if (rc)
+		goto out;
+	p = &buf.data[TPM_HEADER_SIZE + 4];
+	len = tpm_get_inc_u16(&p);
+	if (len != sizeof(payload) + 1) {
+		dev_err(&chip->dev, "wrong unseal payload size %d != %ld",
+			len, sizeof(payload) + 1);
+		goto out;
+	}
+	if (memcmp(payload, p, sizeof(payload)) != 0) {
+		dev_err(&chip->dev, "Payload DID NOT compare correctly\n");
+		goto out;
+	}
+
+	dev_info(&chip->dev, "test4: PASS\n");
+
+	/*
+	 * test5: get the TPM routines to seal to a policy and then
+	 * do a manual unseal
+	 */
+
+	dev_info(&chip->dev, "test5: seal using tpm2-cmd[policy] and unseal manually\n");
+
+	memset(&tkp, 0, sizeof(tkp));
+	memset(&tko, 0, sizeof(tko));
+
+	tko.keyhandle = nullkey;
+	tko.hash = HASH_ALGO_SHA256;
+	tkp.key_len = sizeof(payload);
+	memcpy(tkp.key, payload, tkp.key_len);
+	tko.policydigest_len = sizeof(policy);
+	memcpy(tko.policydigest, policy, tko.policydigest_len);
+
+	rc = tpm2_seal_trusted(chip, &tkp, &tko);
+	if (rc) {
+		dev_err(&chip->dev, "tpm2_seal_trusted returned error: %d\n ", rc);
+		goto out;
+	}
+
+	ps = get_policy(chip);
+	/*
+	 * now load the sealed object (we need the pub and priv parts
+	 * returned from prior command.  The blob from
+	 * tpm2_seal_trusted is the entire return from the create, so
+	 * only append the private and public parts
+	 */
+	p = tkp.blob;
+	/* private len */
+	len = tpm_get_inc_u16(&p);
+	p += len;
+	/* add public len */
+	len += tpm_get_inc_u16(&p);
+	/* add 4 for the two length values */
+	len += 4;
+
+	tpm_buf_init(&b1, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	/* parent */
+	tpm_buf_append_name(&b1, auth, nullkey, chip->tpmkeyname);
+	tpm_buf_append_hmac_session(&b1, auth, TPM2_SA_CONTINUE_SESSION,
+				    NULL, 0);
+
+	tpm_buf_append(&b1, tkp.blob, len);
+
+	tpm_buf_fill_hmac_session(&b1, auth);
+	rc = tpm_transmit_cmd(chip, &b1, 4, "loading seal");
+	rc = tpm_buf_check_hmac_response(&b1, auth, rc);
+	dev_info(&chip->dev, "TPM: load response returned %d\n", rc);
+	if (rc) {
+		tpm2_flush_context(chip, ps);
+		goto out;
+	}
+	p = &b1.data[TPM_HEADER_SIZE];
+	h = tpm_get_inc_u32(&p);
+	dev_info(&chip->dev, "sealed data loaded at %08x\n", h);
+	/* skip over parameter size */
+	p += 4;
+	len = tpm_get_inc_u16(&p);
+	if (len != sizeof(name)) {
+		dev_err(&chip->dev, "Wrong name size %d\n", len);
+		goto out;
+	}
+	memcpy(name, p, len);
+	tpm_buf_destroy(&b1);
+	tpm_buf_destroy(&buf);
+
+	/*
+	 * now unseal the data using the authority in a HMAC and
+	 * protecting the returned unseal by encryption
+	 */
+	tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	tpm_buf_append_name(&buf, auth, h, name);
+	tpm2_buf_append_auth(&buf, ps, NULL, 0, 0, NULL, 0);
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_ENCRYPT,
+				    NULL, 0);
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &buf, 4, "unseal");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+	tpm2_flush_context(chip, h);
+	dev_info(&chip->dev, "unseal returns %d\n", rc);
+	if (rc)
+		goto out;
+	p = &buf.data[TPM_HEADER_SIZE + 4];
+	len = tpm_get_inc_u16(&p);
+	if (len != sizeof(payload) + 1) {
+		dev_err(&chip->dev, "wrong unseal payload size %d != %ld",
+			len, sizeof(payload) + 1);
+		goto out;
+	}
+	if (memcmp(payload, p, sizeof(payload)) != 0) {
+		dev_err(&chip->dev, "Payload DID NOT compare correctly\n");
+		goto out;
+	}
+
+	dev_info(&chip->dev, "test5: PASS");
+
+	/*
+	 * test6: extend PCR 16 with a random value and verify it
+	 * comes back correctly
+	 */
+
+	dev_info(&chip->dev, "test6: extend PCR 16");
+
+	digest.alg_id = TPM_ALG_SHA256;
+
+	rc = tpm2_pcr_read(chip, 16, &digest, &digest_len);
+	if (rc) {
+		dev_err(&chip->dev, "tpm2_pcr_read returns error: %d\n", rc);
+		goto out;
+	}
+	if (digest_len != SHA256_DIGEST_SIZE) {
+		dev_err(&chip->dev, "wrong digest size %d!=%d\n", digest_len,
+			SHA256_DIGEST_SIZE);
+		goto out;
+	}
+
+	for (i = 0; i < chip->nr_allocated_banks; i++) {
+		rc = tpm2_get_random(chip, extend[i].digest, SHA256_DIGEST_SIZE);
+		if (rc != SHA256_DIGEST_SIZE) {
+			dev_err(&chip->dev, "tpm2_get_random failed: %d\n", rc);
+			goto out;
+		}
+		extend[i].alg_id = chip->allocated_banks[i].alg_id;
+	}
+	rc = tpm2_pcr_extend(chip, 16, extend);
+	if (rc) {
+		dev_err(&chip->dev, "tpm2_pcr_extend failed: %d\n", rc);
+		goto out;
+	}
+
+	desc->tfm = sha256_hash;
+	crypto_shash_init(desc);
+	crypto_shash_update(desc, digest.digest, SHA256_DIGEST_SIZE);
+	crypto_shash_update(desc, extend[0].digest, SHA256_DIGEST_SIZE);
+	crypto_shash_final(desc, digest.digest);
+
+	extend[0].alg_id = TPM_ALG_SHA256;
+	rc = tpm2_pcr_read(chip, 16, &extend[0], &digest_len);
+	if (rc) {
+		dev_err(&chip->dev, "tpm2_pcr_read returns error: %d\n", rc);
+		goto out;
+	}
+	if (digest_len != SHA256_DIGEST_SIZE) {
+		dev_err(&chip->dev, "wrong digest size %d!=%d\n", digest_len,
+			SHA256_DIGEST_SIZE);
+		goto out;
+	}
+
+	if (memcmp(digest.digest, extend[0].digest, SHA256_DIGEST_SIZE) != 0) {
+		dev_err(&chip->dev, "Extend digest comparison failed\n");
+		goto out;
+	}
+
+	dev_info(&chip->dev, "All tests passed\n");
+	ret = 0;
+
+ out:
+	tpm2_flush_context(chip, nullkey);
+
+	tpm_put_ops(chip);
+
+	return ret;
+}
+
+module_init(tpm2_sessions_test);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 7307f061e5df..8f50ad88c5ab 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -865,6 +865,7 @@ static int parse_start_auth_session(struct tpm2_auth *auth, const u8 *data)
  * tpm2_start_auth_session - create a HMAC authentication session with the TPM
  * @chip: the TPM chip structure to create the session with
  * @authp: A pointer to an opaque tpm2_auth structure to be allocated
+ * @key: A pointer to return the NULL key or NULL if key should be flushed
  *
  * This function loads the NULL seed from its saved context and starts
  * an authentication session on the null seed, allocates a tpm2_auth
diff --git a/drivers/char/tpm/tpm2-sessions.h b/drivers/char/tpm/tpm2-sessions.h
index ec245731edaf..23d62446dd71 100644
--- a/drivers/char/tpm/tpm2-sessions.h
+++ b/drivers/char/tpm/tpm2-sessions.h
@@ -45,7 +45,8 @@ void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
 
 #ifdef CONFIG_TPM_BUS_SECURITY
 
-int tpm2_start_auth_session(struct tpm_chip *chip, struct tpm2_auth **authp);
+int tpm2_start_auth_session(struct tpm_chip *chip,
+			    struct tpm2_auth **authp);
 void tpm_buf_append_name(struct tpm_buf *buf, struct tpm2_auth *auth,
 			 u32 handle, u8 *name);
 void tpm_buf_append_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth,
-- 
2.16.4


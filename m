Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35EB3A7047
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 22:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhFNU0Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 16:26:24 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:59390 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhFNU0W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 16:26:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id E7ABA18190E47;
        Mon, 14 Jun 2021 22:16:37 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cl3Eqv11IA66; Mon, 14 Jun 2021 22:16:36 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qged8d8IHPVl; Mon, 14 Jun 2021 22:16:36 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     keyrings@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Bottomley <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/3] KEYS: trusted: Introduce support for NXP DCP-based trusted keys
Date:   Mon, 14 Jun 2021 22:16:19 +0200
Message-Id: <20210614201620.30451-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210614201620.30451-1-richard@nod.at>
References: <20210614201620.30451-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DCP (Data Co-Processor) is the little brother of NXP's CAAM IP.

Beside of accelerated crypto operations, it also offers support for
hardware-bound keys. Using this feature it is possible to implement a blo=
b
mechanism just like CAAM offers. Unlike on CAAM, constructing and
parsing the blob has to happen in software.

We chose the following format for the blob:
/*
 * struct dcp_blob_fmt - DCP BLOB format.
 *
 * @fmt_version: Format version, currently being %1
 * @blob_key: Random AES 128 key which is used to encrypt @payload,
 *            @blob_key itself is encrypted with OTP or UNIQUE device key=
 in
 *            AES-128-ECB mode by DCP.
 * @nonce: Random nonce used for @payload encryption.
 * @payload_len: Length of the plain text @payload.
 * @payload: The payload itself, encrypted using AES-128-GCM and @blob_ke=
y,
 *           GCM auth tag of size AES_BLOCK_SIZE is attached at the end o=
f it.
 *
 * The total size of a DCP BLOB is sizeof(struct dcp_blob_fmt) + @payload=
_len +
 * AES_BLOCK_SIZE.
 */
struct dcp_blob_fmt {
	__u8 fmt_version;
	__u8 blob_key[AES_KEYSIZE_128];
	__u8 nonce[AES_KEYSIZE_128];
	__le32 payload_len;
	__u8 payload[0];
} __packed;

@payload is the key provided by trusted_key_ops->seal().

By default the UNIQUE device key is used, it is also possible to use
the OTP key. While the UNIQUE device key should be unique it is not
entirely clear whether this is the case due to unclear documentation.
If someone wants to be sure they can burn their own unique key
into the OTP fuse and set the use_otp_key module parameter.

Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: David Howells <dhowells@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: keyrings@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Co-developed-by: David Gstir <david@sigma-star.at>
Signed-off-by: David Gstir <david@sigma-star.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 .../admin-guide/kernel-parameters.txt         |   1 +
 MAINTAINERS                                   |   9 +
 include/keys/trusted_dcp.h                    |  13 +
 security/keys/trusted-keys/Makefile           |   1 +
 security/keys/trusted-keys/trusted_core.c     |   6 +-
 security/keys/trusted-keys/trusted_dcp.c      | 325 ++++++++++++++++++
 6 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 include/keys/trusted_dcp.h
 create mode 100644 security/keys/trusted-keys/trusted_dcp.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index cb89dbdedc46..d8b2aa94a566 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5639,6 +5639,7 @@
 			sources:
 			- "tpm"
 			- "tee"
+			- "dcp"
 			If not specified then it defaults to iterating through
 			the trust source list starting with TPM and assigns the
 			first trust source as a backend which is initialized
diff --git a/MAINTAINERS b/MAINTAINERS
index b706dd20ff2b..779cac00827c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10099,6 +10099,15 @@ F:	include/keys/trusted-type.h
 F:	include/keys/trusted_tpm.h
 F:	security/keys/trusted-keys/
=20
+KEYS-TRUSTED-DCP
+M:	David Gstir <david@sigma-star.at>
+M:	Richard Weinberger <richard@nod.at>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	include/keys/trusted_dcp.h
+F:	security/keys/trusted-keys/trusted_dcp.c
+
 KEYS-TRUSTED-TEE
 M:	Sumit Garg <sumit.garg@linaro.org>
 L:	linux-integrity@vger.kernel.org
diff --git a/include/keys/trusted_dcp.h b/include/keys/trusted_dcp.h
new file mode 100644
index 000000000000..7b2a1275c527
--- /dev/null
+++ b/include/keys/trusted_dcp.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 sigma star gmbh
+ * Authors: David Gstir <david@sigma-star.at>
+ *          Richard Weinberger <richard@sigma-star.at>
+ */
+
+#ifndef TRUSTED_DCP_H
+#define TRUSTED_DCP_H
+
+extern struct trusted_key_ops dcp_trusted_key_ops;
+
+#endif
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-=
keys/Makefile
index feb8b6c3cc79..992b591692dc 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -12,3 +12,4 @@ trusted-y +=3D trusted_tpm2.o
 trusted-y +=3D tpm2key.asn1.o
=20
 trusted-$(CONFIG_TEE) +=3D trusted_tee.o
+trusted-$(CONFIG_CRYPTO_DEV_MXS_DCP) +=3D trusted_dcp.o
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
index d5c891d8d353..66b631ffe876 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -8,6 +8,7 @@
=20
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
+#include <keys/trusted_dcp.h>
 #include <keys/trusted_tee.h>
 #include <keys/trusted_tpm.h>
 #include <linux/capability.h>
@@ -24,7 +25,7 @@
=20
 static char *trusted_key_source;
 module_param_named(source, trusted_key_source, charp, 0);
-MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
+MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or dcp)")=
;
=20
 static const struct trusted_key_source trusted_key_sources[] =3D {
 #if defined(CONFIG_TCG_TPM)
@@ -33,6 +34,9 @@ static const struct trusted_key_source trusted_key_sour=
ces[] =3D {
 #if defined(CONFIG_TEE)
 	{ "tee", &trusted_key_tee_ops },
 #endif
+#if defined(CONFIG_CRYPTO_DEV_MXS_DCP)
+	{ "dcp", &dcp_trusted_key_ops },
+#endif
 };
=20
 DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->i=
nit);
diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/tru=
sted-keys/trusted_dcp.c
new file mode 100644
index 000000000000..02db5dc261c7
--- /dev/null
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 sigma star gmbh
+ * Authors: David Gstir <david@sigma-star.at>
+ *          Richard Weinberger <richard@sigma-star.at>
+ */
+
+#include <crypto/aead.h>
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/gcm.h>
+#include <crypto/skcipher.h>
+#include <keys/trusted-type.h>
+#include <linux/key-type.h>
+#include <linux/module.h>
+#include <linux/mxs-dcp.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+
+#define DCP_BLOB_VERSION 1
+#define DCP_BLOB_AUTHLEN 16
+
+/**
+ * struct dcp_blob_fmt - DCP BLOB format.
+ *
+ * @fmt_version: Format version, currently being %1.
+ * @blob_key: Random AES 128 key which is used to encrypt @payload,
+ *            @blob_key itself is encrypted with OTP or UNIQUE device ke=
y in
+ *            AES-128-ECB mode by DCP.
+ * @nonce: Random nonce used for @payload encryption.
+ * @payload_len: Length of the plain text @payload.
+ * @payload: The payload itself, encrypted using AES-128-GCM and @blob_k=
ey,
+ *           GCM auth tag of size DCP_BLOB_AUTHLEN is attached at the en=
d of it.
+ *
+ * The total size of a DCP BLOB is sizeof(struct dcp_blob_fmt) + @payloa=
d_len +
+ * DCP_BLOB_AUTHLEN.
+ */
+struct dcp_blob_fmt {
+	__u8 fmt_version;
+	__u8 blob_key[AES_KEYSIZE_128];
+	__u8 nonce[AES_KEYSIZE_128];
+	__le32 payload_len;
+	__u8 payload[0];
+} __packed;
+
+static bool use_otp_key;
+module_param_named(dcp_use_otp_key, use_otp_key, bool, 0);
+MODULE_PARM_DESC(dcp_use_otp_key, "Use OTP instead of UNIQUE key for sea=
ling");
+
+static bool skip_zk_test;
+module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
+MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are z=
ero'ed");
+
+static unsigned int calc_blob_len(unsigned int payload_len)
+{
+	return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
+}
+
+static int do_dcp_crypto(u8 *in, u8 *out, bool is_encrypt)
+{
+	int res =3D 0;
+	struct skcipher_request *req =3D NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	struct scatterlist src_sg, dst_sg;
+	struct crypto_skcipher *tfm;
+	u8 paes_key[DCP_PAES_KEYSIZE];
+
+	if (!use_otp_key)
+		paes_key[0] =3D DCP_PAES_KEY_UNIQUE;
+	else
+		paes_key[0] =3D DCP_PAES_KEY_OTP;
+
+	tfm =3D crypto_alloc_skcipher("ecb-paes-dcp", CRYPTO_ALG_INTERNAL,
+				    CRYPTO_ALG_INTERNAL);
+	if (IS_ERR(tfm)) {
+		res =3D PTR_ERR(tfm);
+		pr_err("Unable to request DCP pAES-ECB cipher: %i\n", res);
+		tfm =3D NULL;
+		goto out;
+	}
+
+	req =3D skcipher_request_alloc(tfm, GFP_NOFS);
+	if (!req) {
+		res =3D -ENOMEM;
+		goto out;
+	}
+
+	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &wait);
+	res =3D crypto_skcipher_setkey(tfm, paes_key, sizeof(paes_key));
+	if (res < 0)
+		goto out;
+
+	sg_init_one(&src_sg, in, AES_KEYSIZE_128);
+	sg_init_one(&dst_sg, out, AES_KEYSIZE_128);
+	skcipher_request_set_crypt(req, &src_sg, &dst_sg, AES_KEYSIZE_128,
+				   NULL);
+
+	if (is_encrypt)
+		res =3D crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
+	else
+		res =3D crypto_wait_req(crypto_skcipher_decrypt(req), &wait);
+
+out:
+	skcipher_request_free(req);
+	crypto_free_skcipher(tfm);
+
+	return res;
+}
+
+static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonc=
e,
+			  bool is_encrypt)
+{
+	struct aead_request *aead_req =3D NULL;
+	struct scatterlist src_sg, dst_sg;
+	struct crypto_aead *aead;
+	int ret;
+
+	aead =3D crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(aead)) {
+		ret =3D PTR_ERR(aead);
+		pr_err("Unable to request AES-GCM cipher: %i\n", ret);
+		goto out;
+	}
+
+	ret =3D crypto_aead_setauthsize(aead, DCP_BLOB_AUTHLEN);
+	if (ret < 0) {
+		pr_err("Can't set crypto auth tag len: %d\n", ret);
+		goto free_aead;
+	}
+
+	aead_req =3D aead_request_alloc(aead, GFP_KERNEL);
+	if (!aead_req) {
+		ret =3D -ENOMEM;
+		goto free_aead;
+	}
+
+	sg_init_one(&src_sg, in, len);
+	if (is_encrypt) {
+		/*
+		 * If we encrypt our buffer has extra space for the auth tag.
+		 */
+		sg_init_one(&dst_sg, out, len + DCP_BLOB_AUTHLEN);
+	} else {
+		sg_init_one(&dst_sg, out, len);
+	}
+
+	aead_request_set_crypt(aead_req, &src_sg, &dst_sg, len, nonce);
+	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL,
+				  NULL);
+	aead_request_set_ad(aead_req, 0);
+
+	if (crypto_aead_setkey(aead, key, AES_KEYSIZE_128)) {
+		pr_err("Can't set crypto AEAD key\n");
+		ret =3D -EINVAL;
+		goto free_req;
+	}
+
+	if (is_encrypt)
+		ret =3D crypto_aead_encrypt(aead_req);
+	else
+		ret =3D crypto_aead_decrypt(aead_req);
+
+free_req:
+	aead_request_free(aead_req);
+free_aead:
+	crypto_free_aead(aead);
+out:
+	return ret;
+}
+
+static int decrypt_blob_key(u8 *key)
+{
+	return do_dcp_crypto(key, key, false);
+}
+
+static int encrypt_blob_key(u8 *key)
+{
+	return do_dcp_crypto(key, key, true);
+}
+
+static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablo=
b)
+{
+	struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
+	int blen, ret;
+
+	blen =3D calc_blob_len(p->key_len);
+	if (blen > MAX_BLOB_SIZE) {
+		ret =3D -E2BIG;
+		goto out;
+	}
+
+	b->fmt_version =3D DCP_BLOB_VERSION;
+	get_random_bytes(b->nonce, AES_KEYSIZE_128);
+	get_random_bytes(b->blob_key, AES_KEYSIZE_128);
+
+	ret =3D do_aead_crypto(p->key, b->payload, p->key_len, b->blob_key,
+			     b->nonce, true);
+	if (ret) {
+		pr_err("Unable to encrypt blob payload: %i\n", ret);
+		goto out;
+	}
+
+	ret =3D encrypt_blob_key(b->blob_key);
+	if (ret) {
+		pr_err("Unable to encrypt blob key: %i\n", ret);
+		goto out;
+	}
+
+	b->payload_len =3D cpu_to_le32(p->key_len);
+	p->blob_len =3D blen;
+	ret =3D 0;
+out:
+	return ret;
+}
+
+static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datab=
lob)
+{
+	struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
+	int blen, ret;
+
+	if (b->fmt_version !=3D DCP_BLOB_VERSION) {
+		pr_err("DCP blob has bad version: %i, expected %i\n",
+		       b->fmt_version, DCP_BLOB_VERSION);
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	p->key_len =3D le32_to_cpu(b->payload_len);
+	blen =3D calc_blob_len(p->key_len);
+	if (blen !=3D p->blob_len) {
+		pr_err("DCP blob has bad length: %i !=3D %i\n", blen,
+		       p->blob_len);
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D decrypt_blob_key(b->blob_key);
+	if (ret) {
+		pr_err("Unable to decrypt blob key: %i\n", ret);
+		goto out;
+	}
+
+	ret =3D do_aead_crypto(b->payload, p->key, p->key_len + DCP_BLOB_AUTHLE=
N,
+			     b->blob_key, b->nonce, false);
+	if (ret) {
+		pr_err("Unwrap of DCP payload failed: %i\n", ret);
+		goto out;
+	}
+
+	ret =3D 0;
+out:
+	return ret;
+}
+
+static int trusted_dcp_get_random(unsigned char *key, size_t key_len)
+{
+	get_random_bytes(key, key_len);
+
+	return key_len;
+}
+
+static int test_for_zero_key(void)
+{
+	static const u8 bad[] =3D {0x9a, 0xda, 0xe0, 0x54, 0xf6, 0x3d, 0xfa, 0x=
ff,
+				 0x5e, 0xa1, 0x8e, 0x45, 0xed, 0xf6, 0xea, 0x6f};
+	void *buf =3D NULL;
+	int ret =3D 0;
+
+	if (skip_zk_test)
+		goto out;
+
+	buf =3D kmalloc(AES_BLOCK_SIZE, GFP_KERNEL);
+	if (!buf) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	memset(buf, 0x55, AES_BLOCK_SIZE);
+
+	ret =3D do_dcp_crypto(buf, buf, true);
+	if (ret)
+		goto out;
+
+	if (memcmp(buf, bad, AES_BLOCK_SIZE) =3D=3D 0) {
+		pr_err("Device neither in secure nor trusted mode!\n");
+		ret =3D -EINVAL;
+	}
+out:
+	kfree(buf);
+	return ret;
+}
+
+static int trusted_dcp_init(void)
+{
+	int ret;
+
+	if (use_otp_key)
+		pr_info("Using DCP OTP key\n");
+
+	ret =3D test_for_zero_key();
+	if (ret) {
+		pr_err("Test for zero'ed keys failed: %i\n", ret);
+
+		return -EINVAL;
+	}
+
+	return register_key_type(&key_type_trusted);
+}
+
+static void trusted_dcp_exit(void)
+{
+	unregister_key_type(&key_type_trusted);
+}
+
+struct trusted_key_ops dcp_trusted_key_ops =3D {
+	.exit =3D trusted_dcp_exit,
+	.init =3D trusted_dcp_init,
+	.seal =3D trusted_dcp_seal,
+	.unseal =3D trusted_dcp_unseal,
+	.get_random =3D trusted_dcp_get_random,
+	.migratable =3D 0,
+};
--=20
2.26.2


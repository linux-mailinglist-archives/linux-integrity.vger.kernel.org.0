Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B2E3A703F
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhFNU0W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 16:26:22 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:59380 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhFNU0W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 16:26:22 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2021 16:26:18 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 7C89818190E4A;
        Mon, 14 Jun 2021 22:16:38 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EytU5U21JfDt; Mon, 14 Jun 2021 22:16:37 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Yxr3TtJK9DNP; Mon, 14 Jun 2021 22:16:37 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     keyrings@vger.kernel.org
Cc:     David Gstir <david@sigma-star.at>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
        Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 3/3] doc: trusted-encrypted: add DCP as new trust source
Date:   Mon, 14 Jun 2021 22:16:20 +0200
Message-Id: <20210614201620.30451-4-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210614201620.30451-1-richard@nod.at>
References: <20210614201620.30451-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: David Gstir <david@sigma-star.at>

Update the documentation for trusted and encrypted KEYS with DCP as new
trust source:

- Describe security properties of DCP trust source
- Describe key usage
- Document blob format

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
Co-developed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: David Gstir <david@sigma-star.at>
---
 .../security/keys/trusted-encrypted.rst       | 84 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Document=
ation/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..e8413122e4bc 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -35,6 +35,11 @@ safe.
          Rooted to Hardware Unique Key (HUK) which is generally burnt in=
 on-chip
          fuses and is accessible to TEE only.
=20
+     (3) DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs=
)
+
+         Rooted to a one-time programmable key (OTP) that is generally b=
urnt in
+         the on-chip fuses and is accessbile to the DCP encryption engin=
e only.
+
   *  Execution isolation
=20
      (1) TPM
@@ -46,6 +51,12 @@ safe.
          Customizable set of operations running in isolated execution
          environment verified via Secure/Trusted boot process.
=20
+     (3) DCP
+
+         Fixed set of cryptographic operations running in isolated execu=
tion
+         environment. Only basic blob key encryption is executed there.
+         The actual key sealing/unsealing is done on main processor/kern=
el space.
+
   * Optional binding to platform integrity state
=20
      (1) TPM
@@ -63,6 +74,11 @@ safe.
          Relies on Secure/Trusted boot process for platform integrity. I=
t can
          be extended with TEE based measured boot process.
=20
+     (3) DCP
+
+         Relies on Secure/Trusted boot process (called HAB by vendor) fo=
r
+         platform integrity.
+
   *  Interfaces and APIs
=20
      (1) TPM
@@ -74,10 +90,14 @@ safe.
          TEEs have well-documented, standardized client interface and AP=
Is. For
          more details refer to ``Documentation/staging/tee.rst``.
=20
+     (3) DCP
+
+         Vendor-specific API that is implemented as part of the DCP cryp=
to driver in
+         ``drivers/crypto/mxs-dcp.c``.
=20
   *  Threat model
=20
-     The strength and appropriateness of a particular TPM or TEE for a g=
iven
+     The strength and appropriateness of a particular TPM, TEE or DCP fo=
r a given
      purpose must be assessed when using them to protect security-releva=
nt data.
=20
=20
@@ -103,6 +123,14 @@ access control policy within the trust source.
      from platform specific hardware RNG or a software based Fortuna CSP=
RNG
      which can be seeded via multiple entropy sources.
=20
+  * DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs)
+
+     The DCP hardware device itself does not provide a dedicated RNG int=
erface,
+     so the kernel default RNG is used. SoCs with DCP like the i.MX6ULL =
do have
+     a dedicated hardware RNG that is independent from DCP which can be =
enabled
+     to back the kernel RNG.
+
+
 Encrypted Keys
 --------------
=20
@@ -188,6 +216,19 @@ Usage::
 specific to TEE device implementation.  The key length for new keys is a=
lways
 in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
=20
+Trusted Keys usage: DCP
+-----------------------
+
+Usage::
+
+    keyctl add trusted name "new keylen" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+"keyctl print" returns an ASCII hex copy of the sealed key, which is in =
format
+specific to this DCP key-blob implementation.  The key length for new ke=
ys is
+always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
 Encrypted Keys usage
 --------------------
=20
@@ -370,3 +411,44 @@ string length.
 privkey is the binary representation of TPM2B_PUBLIC excluding the
 initial TPM2B header which can be reconstructed from the ASN.1 octed
 string length.
+
+DCP Blob Format
+---------------
+
+The Data Co-Processor (DCP) provides hardware-bound AES keys using its
+AES encryption engine only. It does not provide direct key sealing/unsea=
ling.
+To make DCP hardware encryption keys usable as trust source, we define
+our own custom format that uses a hardware-bound key to secure the seali=
ng
+key stored in the key blob.
+
+Whenever a new tusted key using DCP is generated, we generate a random 1=
28-bit
+blob encryption key (BEK) and 128-bit nonce. The BEK and nonce are used =
to
+encrypt the trusted key payload using AES-128-GCM.
+
+The BEK itself is encrypted using the hardware-bound key using the DCP's=
 AES
+encryption engine with AES-128-ECB. The encrypted BEK, generated nonce,
+BEK-encrypted payload and authentication tag make up the blob format tog=
ether
+with a version number, payload length and authentication tag::
+
+    /*
+     * struct dcp_blob_fmt - DCP BLOB format.
+     *
+     * @fmt_version: Format version, currently being %1
+     * @blob_key: Random AES 128 key which is used to encrypt @payload,
+     *            @blob_key itself is encrypted with OTP or UNIQUE devic=
e key in
+     *            AES-128-ECB mode by DCP.
+     * @nonce: Random nonce used for @payload encryption.
+     * @payload_len: Length of the plain text @payload.
+     * @payload: The payload itself, encrypted using AES-128-GCM and @bl=
ob_key,
+     *           GCM auth tag of size AES_BLOCK_SIZE is attached at the =
end of it.
+     *
+     * The total size of a DCP BLOB is sizeof(struct dcp_blob_fmt) + @pa=
yload_len +
+     * AES_BLOCK_SIZE.
+     */
+    struct dcp_blob_fmt {
+            __u8 fmt_version;
+            __u8 blob_key[AES_KEYSIZE_128];
+            __u8 nonce[AES_KEYSIZE_128];
+            __le32 payload_len;
+            __u8 payload[0];
+    } __packed;
--=20
2.26.2


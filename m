Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664DA4B6EBD
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Feb 2022 15:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbiBOOUS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Feb 2022 09:20:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiBOOUR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Feb 2022 09:20:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE7CC8F8C
        for <linux-integrity@vger.kernel.org>; Tue, 15 Feb 2022 06:20:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7-20020a255607000000b00621afc793b8so20259685ybb.1
        for <linux-integrity@vger.kernel.org>; Tue, 15 Feb 2022 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=GUpyRZejn9Pwp27JxxD0pUffrRYlyMDKoKZilOQs1zg=;
        b=ZT3OQfsZ54iVJEPKmgnr6hFCGXDZyAiFXDqjcgogSLta37V38o2S575RNzSUmFaYlQ
         sBcNLxR0aousgBT7pc3TimkUjD7hG0UxRA+ol/5xFlFPc9A44J2+cwpB5isbrElaADWg
         ByLLlcew3BUlw28GvalAoynFSY691tLCRPhJS44fdgw/GgNgksCzfvnRLd8hgCBNXyYj
         QRziQIOlDb0mwfus4ltBYK1+uIRCUMDizFQqNkHeRs4I6MIkMvRGLgfai//StkfUZCGN
         HrHjzFKmZFXD6mgE909pV+QiuO0WbjAuUvyoYKTF+F7vsye5L4YSOXSbWfYBWSQJcjbm
         wHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=GUpyRZejn9Pwp27JxxD0pUffrRYlyMDKoKZilOQs1zg=;
        b=fNtg9pgoIeC6Jc/r2apfKAlCpNyRzDcKCga6RVqumNQWKfGT9oQyft4ariKUJuI/Gh
         YkrKrisMG1mu8osaT13Plt06XiPQEbbtrF1a6ViAYnI3r0BWXZ1QW4mGMZSjUJooEBge
         4mpeAkbhByn/1by571DYbfEkfRNri1QOZzxFCP5dkhOGz/tv6LSxtOs3q0ThTVWcIJgx
         EBwROiu7M8XBKhI/EUssXrPrn2Z1UWUxgpx683k0xXt/2XD0ctz88XnlYdp67TsahSjj
         25tAffgDOZ26p0mRCA4X3Dd0Opd+zBAaUDpsqupJ2HVJq7I+AjkVgQadYwOEkcBKQYOS
         F8ag==
X-Gm-Message-State: AOAM532TAAp5tdQLU4jC1LdrhqMetV0K0ej5bZqvo6wlJ+1UtqHWVA4X
        SKhfgVegDZ3zDBTZ2w31OscCLVx8NYQ8XwI5ocyBlS508m7bllOmWb1rE+jgo7gSzsL1SLYD5P8
        hQEAFAkEHqKf2TxN4ZYA8whWLtbHP4nLhZqqFzyNDddkgUrzQD+XAKX/zgt2HgvUpFDiL+wM=
X-Google-Smtp-Source: ABdhPJzcCCkgAq2s1mmwNW6OZq/24SwP0p0I0cyzx87weaxppuFpiwOk92W7HltKnDkACdBa+pjsXQVyQQ==
X-Received: from yaelt.nyc.corp.google.com ([2620:0:1003:415:4733:5913:aeb8:dca6])
 (user=yaelt job=sendgmr) by 2002:a81:4417:: with SMTP id r23mr3907750ywa.443.1644934805301;
 Tue, 15 Feb 2022 06:20:05 -0800 (PST)
Date:   Tue, 15 Feb 2022 09:19:53 -0500
Message-Id: <20220215141953.1557009-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v5] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
From:   Yael Tzur <yaelt@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        corbet@lwn.net, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, Yael Tzur <yaelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For availability and performance reasons master keys often need to be
released outside of a Key Management Service (KMS) to clients. It
would be beneficial to provide a mechanism where the
wrapping/unwrapping of data encryption keys (DEKs) is not dependent
on a remote call at runtime yet security is not (or only minimally)
compromised. Master keys could be securely stored in the Kernel and
be used to wrap/unwrap keys from Userspace.

The encrypted.c class supports instantiation of encrypted keys with
either an already-encrypted key material, or by generating new key
material based on random numbers. This patch defines a new datablob
format: [<format>] <master-key name> <decrypted data length>
<decrypted data> that allows to inject and encrypt user-provided
decrypted data. The decrypted data must be hex-ascii encoded.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Yael Tzur <yaelt@google.com>
---

Notes:
    v -> v2: fixed compilation error.
   =20
    v2 -> v3: modified documentation.
   =20
    v3 -> v4: modified commit message.
   =20
    v4 -> v5: added config option to enable feature, and modified input val=
idation.

 .../security/keys/trusted-encrypted.rst       | 25 +++++--
 security/keys/Kconfig                         | 19 +++--
 security/keys/encrypted-keys/encrypted.c      | 72 ++++++++++++++-----
 3 files changed, 87 insertions(+), 29 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentat=
ion/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..f614dad7de12 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -107,12 +107,13 @@ Encrypted Keys
 --------------
=20
 Encrypted keys do not depend on a trust source, and are faster, as they us=
e AES
-for encryption/decryption. New keys are created from kernel-generated rand=
om
-numbers, and are encrypted/decrypted using a specified =E2=80=98master=E2=
=80=99 key. The
-=E2=80=98master=E2=80=99 key can either be a trusted-key or user-key type.=
 The main disadvantage
-of encrypted keys is that if they are not rooted in a trusted key, they ar=
e only
-as secure as the user key encrypting them. The master user key should ther=
efore
-be loaded in as secure a way as possible, preferably early in boot.
+for encryption/decryption. New keys are created either from kernel-generat=
ed
+random numbers or user-provided decrypted data, and are encrypted/decrypte=
d
+using a specified =E2=80=98master=E2=80=99 key. The =E2=80=98master=E2=80=
=99 key can either be a trusted-key or
+user-key type. The main disadvantage of encrypted keys is that if they are=
 not
+rooted in a trusted key, they are only as secure as the user key encryptin=
g
+them. The master user key should therefore be loaded in as secure a way as
+possible, preferably early in boot.
=20
=20
 Usage
@@ -199,6 +200,8 @@ Usage::
=20
     keyctl add encrypted name "new [format] key-type:master-key-name keyle=
n"
         ring
+    keyctl add encrypted name "new [format] key-type:master-key-name keyle=
n
+        decrypted-data" ring
     keyctl add encrypted name "load hex_blob" ring
     keyctl update keyid "update key-type:master-key-name"
=20
@@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
     82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564=
e0
     24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
=20
+Instantiate an encrypted key "evm" using user-provided decrypted data::
+
+    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypted=
_data.blob`" @u
+    794890253
+
+    $ keyctl print 794890253
+    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b38=
2d
+    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e02=
47
+    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
+
 Other uses for trusted and encrypted keys, such as for disk and file encry=
ption
 are anticipated.  In particular the new format 'ecryptfs' has been defined
 in order to use encrypted keys to mount an eCryptfs filesystem.  More deta=
ils
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 969122c7b92f..0e30b361e1c1 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -98,10 +98,21 @@ config ENCRYPTED_KEYS
 	select CRYPTO_RNG
 	help
 	  This option provides support for create/encrypting/decrypting keys
-	  in the kernel.  Encrypted keys are kernel generated random numbers,
-	  which are encrypted/decrypted with a 'master' symmetric key. The
-	  'master' key can be either a trusted-key or user-key type.
-	  Userspace only ever sees/stores encrypted blobs.
+	  in the kernel.  Encrypted keys are instantiated using kernel
+	  generated random numbers or provided decrypted data, and are
+	  encrypted/decrypted with a 'master' symmetric key. The 'master'
+	  key can be either a trusted-key or user-key type. Only encrypted
+	  blobs are ever output to Userspace.
+
+	  If you are unsure as to whether this is required, answer N.
+
+config USER_DECRYPTED_DATA
+	bool "Allow encrypted keys with user decrypted data"
+	depends on ENCRYPTED_KEYS
+	help
+	  This option provides support for instantiating encrypted keys using
+	  user-provided decrypted data.  The decrypted data must be hex-ascii
+	  encoded.
=20
 	  If you are unsure as to whether this is required, answer N.
=20
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encry=
pted-keys/encrypted.c
index 87432b35d771..ebfb8129fb92 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -78,6 +78,11 @@ static const match_table_t key_tokens =3D {
 	{Opt_err, NULL}
 };
=20
+static bool user_decrypted_data =3D IS_ENABLED(CONFIG_USER_DECRYPTED_DATA)=
;
+module_param(user_decrypted_data, bool, 0);
+MODULE_PARM_DESC(user_decrypted_data,
+	"Allow instantiation of encrypted keys using provided decrypted data");
+
 static int aes_get_sizes(void)
 {
 	struct crypto_skcipher *tfm;
@@ -158,7 +163,7 @@ static int valid_master_desc(const char *new_desc, cons=
t char *orig_desc)
  * datablob_parse - parse the keyctl data
  *
  * datablob format:
- * new [<format>] <master-key name> <decrypted data length>
+ * new [<format>] <master-key name> <decrypted data length> [<decrypted da=
ta>]
  * load [<format>] <master-key name> <decrypted data length>
  *     <encrypted iv + data>
  * update <new-master-key name>
@@ -170,7 +175,7 @@ static int valid_master_desc(const char *new_desc, cons=
t char *orig_desc)
  */
 static int datablob_parse(char *datablob, const char **format,
 			  char **master_desc, char **decrypted_datalen,
-			  char **hex_encoded_iv)
+			  char **hex_encoded_iv, char **decrypted_data)
 {
 	substring_t args[MAX_OPT_ARGS];
 	int ret =3D -EINVAL;
@@ -231,6 +236,7 @@ static int datablob_parse(char *datablob, const char **=
format,
 				"when called from .update method\n", keyword);
 			break;
 		}
+		*decrypted_data =3D strsep(&datablob, " \t");
 		ret =3D 0;
 		break;
 	case Opt_load:
@@ -595,7 +601,8 @@ static int derived_key_decrypt(struct encrypted_key_pay=
load *epayload,
 static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 							 const char *format,
 							 const char *master_desc,
-							 const char *datalen)
+							 const char *datalen,
+							 const char *decrypted_data)
 {
 	struct encrypted_key_payload *epayload =3D NULL;
 	unsigned short datablob_len;
@@ -604,6 +611,7 @@ static struct encrypted_key_payload *encrypted_key_allo=
c(struct key *key,
 	unsigned int encrypted_datalen;
 	unsigned int format_len;
 	long dlen;
+	int i;
 	int ret;
=20
 	ret =3D kstrtol(datalen, 10, &dlen);
@@ -613,6 +620,24 @@ static struct encrypted_key_payload *encrypted_key_all=
oc(struct key *key,
 	format_len =3D (!format) ? strlen(key_format_default) : strlen(format);
 	decrypted_datalen =3D dlen;
 	payload_datalen =3D decrypted_datalen;
+
+	if (decrypted_data) {
+		if (!user_decrypted_data) {
+			pr_err("encrypted key: instantiation of keys using provided decrypted d=
ata is disabled since CONFIG_USER_DECRYPTED_DATA is set to false\n");
+			return ERR_PTR(-EINVAL);
+		}
+		if (strlen(decrypted_data) !=3D decrypted_datalen) {
+			pr_err("encrypted key: decrypted data provided does not match decrypted=
 data length provided\n");
+			return ERR_PTR(-EINVAL);
+		}
+		for (i =3D 0; i < strlen(decrypted_data); i++) {
+			if (!isxdigit(decrypted_data[i])) {
+				pr_err("encrypted key: decrypted data provided must contain only hexad=
ecimal characters\n");
+				return ERR_PTR(-EINVAL);
+			}
+		}
+	}
+
 	if (format) {
 		if (!strcmp(format, key_format_ecryptfs)) {
 			if (dlen !=3D ECRYPTFS_MAX_KEY_BYTES) {
@@ -740,13 +766,14 @@ static void __ekey_init(struct encrypted_key_payload =
*epayload,
 /*
  * encrypted_init - initialize an encrypted key
  *
- * For a new key, use a random number for both the iv and data
- * itself.  For an old key, decrypt the hex encoded data.
+ * For a new key, use either a random number or user-provided decrypted da=
ta in
+ * case it is provided. A random number is used for the iv in both cases. =
For
+ * an old key, decrypt the hex encoded data.
  */
 static int encrypted_init(struct encrypted_key_payload *epayload,
 			  const char *key_desc, const char *format,
 			  const char *master_desc, const char *datalen,
-			  const char *hex_encoded_iv)
+			  const char *hex_encoded_iv, const char *decrypted_data)
 {
 	int ret =3D 0;
=20
@@ -760,21 +787,26 @@ static int encrypted_init(struct encrypted_key_payloa=
d *epayload,
 	}
=20
 	__ekey_init(epayload, format, master_desc, datalen);
-	if (!hex_encoded_iv) {
-		get_random_bytes(epayload->iv, ivsize);
-
-		get_random_bytes(epayload->decrypted_data,
-				 epayload->decrypted_datalen);
-	} else
+	if (hex_encoded_iv) {
 		ret =3D encrypted_key_decrypt(epayload, format, hex_encoded_iv);
+	} else if (decrypted_data) {
+		get_random_bytes(epayload->iv, ivsize);
+		memcpy(epayload->decrypted_data, decrypted_data,
+				   epayload->decrypted_datalen);
+	} else {
+		get_random_bytes(epayload->iv, ivsize);
+		get_random_bytes(epayload->decrypted_data, epayload->decrypted_datalen);
+	}
 	return ret;
 }
=20
 /*
  * encrypted_instantiate - instantiate an encrypted key
  *
- * Decrypt an existing encrypted datablob or create a new encrypted key
- * based on a kernel random number.
+ * Instantiates the key:
+ * - by decrypting an existing encrypted datablob, or
+ * - by creating a new encrypted key based on a kernel random number, or
+ * - using provided decrypted data.
  *
  * On success, return 0. Otherwise return errno.
  */
@@ -787,6 +819,7 @@ static int encrypted_instantiate(struct key *key,
 	char *master_desc =3D NULL;
 	char *decrypted_datalen =3D NULL;
 	char *hex_encoded_iv =3D NULL;
+	char *decrypted_data =3D NULL;
 	size_t datalen =3D prep->datalen;
 	int ret;
=20
@@ -799,18 +832,18 @@ static int encrypted_instantiate(struct key *key,
 	datablob[datalen] =3D 0;
 	memcpy(datablob, prep->data, datalen);
 	ret =3D datablob_parse(datablob, &format, &master_desc,
-			     &decrypted_datalen, &hex_encoded_iv);
+			     &decrypted_datalen, &hex_encoded_iv, &decrypted_data);
 	if (ret < 0)
 		goto out;
=20
 	epayload =3D encrypted_key_alloc(key, format, master_desc,
-				       decrypted_datalen);
+				       decrypted_datalen, decrypted_data);
 	if (IS_ERR(epayload)) {
 		ret =3D PTR_ERR(epayload);
 		goto out;
 	}
 	ret =3D encrypted_init(epayload, key->description, format, master_desc,
-			     decrypted_datalen, hex_encoded_iv);
+			     decrypted_datalen, hex_encoded_iv, decrypted_data);
 	if (ret < 0) {
 		kfree_sensitive(epayload);
 		goto out;
@@ -860,7 +893,7 @@ static int encrypted_update(struct key *key, struct key=
_preparsed_payload *prep)
=20
 	buf[datalen] =3D 0;
 	memcpy(buf, prep->data, datalen);
-	ret =3D datablob_parse(buf, &format, &new_master_desc, NULL, NULL);
+	ret =3D datablob_parse(buf, &format, &new_master_desc, NULL, NULL, NULL);
 	if (ret < 0)
 		goto out;
=20
@@ -869,7 +902,7 @@ static int encrypted_update(struct key *key, struct key=
_preparsed_payload *prep)
 		goto out;
=20
 	new_epayload =3D encrypted_key_alloc(key, epayload->format,
-					   new_master_desc, epayload->datalen);
+					   new_master_desc, epayload->datalen, NULL);
 	if (IS_ERR(new_epayload)) {
 		ret =3D PTR_ERR(new_epayload);
 		goto out;
--=20
2.35.1.265.g69c8d7142f-goog


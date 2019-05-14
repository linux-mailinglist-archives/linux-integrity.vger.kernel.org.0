Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FC51CDB8
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfENROZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 13:14:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60304 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfENROY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 13:14:24 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id C56E120110B6;
        Tue, 14 May 2019 10:14:22 -0700 (PDT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Subject: [PATCH 2/2] public key: IMA signer logging: Add a new template
 ima-sigkey to store/read the public, key of ima signature signer
Message-ID: <3f2717db-62b5-7f6a-561d-3265e05a51ec@linux.microsoft.com>
Date:   Tue, 14 May 2019 10:14:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA signer log (created using ima-sig template) contains
the IMA signature of the file. The IMA signature includes
the key identifier of the key that was used to generate
the IMA signature.

Outside the client machine this key id is not sufficient to
uniquely determine which key the IMA signature corresponds to.
Providing the public key of the signer in the IMA log would allow,
for example, an attestation service to uniquely and securely verify
if the key used to generate the IMA signature is a valid and
trusted one, and that the key has not been revoked or expired.

To attest that the system files loaded on the client were signed
by valid and trusted keys, an attestation service would just have
to maintain a list of valid public keys. Using the data in the IMA log
the service can attest the system files loaded on the client machine.

This patch set depends on another patch
([PATCH 1/2] public key: IMA signer logging: Add support for querying
public key from a given key) that includes a new interface
method namely query_public_key in asymmetric_key_subtype interface.
query_public_key method returns the public key part of the given key.

IMA will verify the IMA signature of the file, invoke the above method
to query the public key of the IMA signature signer and add that to
the IMA signer log.

Defined a new template namely ima-sigkey to store\read
the public key of the IMA signature signer. This template
extends the existing template ima-sig.

Added integrity_get_signer_key that returns the public key
of the IMA signature signer by calling the newly added method
asymmetric_signer_public_key in digsig_asymmetric.c.

Added ima_eventsigkey_init to initialize the data for
ima-sigkey template and ima_show_template_sigkey to display
the ima-sigkey template data.

Signed-off-by: Lakshmi <nramas@microsoft.com>
---
  .../admin-guide/kernel-parameters.txt         |  2 +-
  Documentation/security/IMA-templates.rst      |  5 +-
  security/integrity/digsig.c                   | 54 +++++++++++++++++--
  security/integrity/digsig_asymmetric.c        | 44 +++++++++++++++
  security/integrity/ima/Kconfig                |  3 ++
  security/integrity/ima/ima_template.c         |  3 ++
  security/integrity/ima/ima_template_lib.c     | 43 +++++++++++++++
  security/integrity/ima/ima_template_lib.h     |  4 ++
  security/integrity/integrity.h                | 29 +++++++++-
  9 files changed, 180 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt 
b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..d51375caadce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1632,7 +1632,7 @@

  	ima_template=	[IMA]
  			Select one of defined IMA measurements template formats.
-			Formats: { "ima" | "ima-ng" | "ima-sig" }
+            Formats: { "ima" | "ima-ng" | "ima-sig" | "ima-sigkey" }
  			Default: "ima-ng"

  	ima_template_fmt=
diff --git a/Documentation/security/IMA-templates.rst 
b/Documentation/security/IMA-templates.rst
index 2cd0e273cc9a..3082e0f73313 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -70,14 +70,15 @@ descriptors by adding their identifier to the format 
string
     prefix is shown only if the hash algorithm is not SHA1 or MD5);
   - 'n-ng': the name of the event, without size limitations;
   - 'sig': the file signature.
+ - 'sigkey': public key corresponding to the file signature


  Below, there is the list of defined template descriptors:

   - "ima": its format is ``d|n``;
   - "ima-ng" (default): its format is ``d-ng|n-ng``;
- - "ima-sig": its format is ``d-ng|n-ng|sig``.
-
+ - "ima-sig": its format is ``d-ng|n-ng|sig``;
+ - "ima-sigkey": its format is ``d-ng|n-ng|sig|sigkey``.


  Use
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e19c2eb72c51..a680f1f77054 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -43,6 +43,54 @@ static const char * const 
keyring_name[INTEGRITY_KEYRING_MAX] = {
  #define restrict_link_to_ima restrict_link_by_builtin_trusted
  #endif

+int integrity_digsig_version(const char *sig, int siglen)
+{
+    if (siglen < 2)
+        return -EINVAL;
+
+    /* Second byte in the signature contains the version */
+    return sig[1];
+}
+
+int integrity_get_signer_key(const unsigned int id,
+            const char *sig, int siglen,
+            void **signer_key, u32 *signer_keylen)
+{
+    int ret = 0;
+
+    if (id >= INTEGRITY_KEYRING_MAX || siglen < 2 ||
+        signer_key == NULL || signer_keylen == NULL)
+        return -EINVAL;
+
+    if (!keyring[id])
+        return -EOPNOTSUPP;
+
+    switch (integrity_digsig_version(sig, siglen)) {
+    case INTEGRITY_SIGNATURE_VERSION_1: {
+
+        /* Currently not supporting extracting signer key
+         * information for v1 digital signature.
+         */
+        *signer_key = NULL;
+        *signer_keylen = 0;
+        ret = -EOPNOTSUPP;
+        break;
+    }
+
+    case INTEGRITY_SIGNATURE_VERSION_2: {
+        ret = asymmetric_signer_public_key(keyring[id],
+                    sig, siglen,
+                    signer_key, signer_keylen);
+        break;
+    }
+
+    default:
+        ret = -EOPNOTSUPP;
+    }
+
+    return ret;
+}
+
  int integrity_digsig_verify(const unsigned int id, const char *sig, 
int siglen,
  			    const char *digest, int digestlen)
  {
@@ -60,12 +108,12 @@ int integrity_digsig_verify(const unsigned int id, 
const char *sig, int siglen,
  		}
  	}

-	switch (sig[1]) {
-	case 1:
+    switch (integrity_digsig_version(sig, siglen)) {
+    case INTEGRITY_SIGNATURE_VERSION_1:
  		/* v1 API expect signature without xattr type */
  		return digsig_verify(keyring[id], sig + 1, siglen - 1,
  				     digest, digestlen);
-	case 2:
+    case INTEGRITY_SIGNATURE_VERSION_2:
  		return asymmetric_verify(keyring[id], sig, siglen,
  					 digest, digestlen);
  	}
diff --git a/security/integrity/digsig_asymmetric.c 
b/security/integrity/digsig_asymmetric.c
index d775e03fbbcc..4073338e16e1 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -13,6 +13,7 @@
  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

  #include <linux/err.h>
+#include <linux/slab.h>
  #include <linux/ratelimit.h>
  #include <linux/key-type.h>
  #include <crypto/public_key.h>
@@ -117,6 +118,49 @@ int asymmetric_verify(struct key *keyring, const 
char *sig,
  	return ret;
  }

+int asymmetric_signer_public_key(struct key *keyring, const char *sig,
+              int siglen, void **signer_key, u32 *signer_keylen)
+{
+    struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
+    struct key *key;
+    const struct public_key *pk;
+    int ret = -ENOMEM;
+
+    if (signer_key == NULL || signer_keylen == NULL)
+        return -EINVAL;
+
+    if (siglen <= sizeof(*hdr))
+        return -EBADMSG;
+
+    siglen -= sizeof(*hdr);
+
+    if (siglen != be16_to_cpu(hdr->sig_size))
+        return -EBADMSG;
+
+    if (hdr->hash_algo >= HASH_ALGO__LAST)
+        return -ENOPKG;
+
+    key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
+    if (IS_ERR(key))
+        return PTR_ERR(key);
+
+    pk = query_public_key(key);
+    if ((pk != NULL) && (pk->keylen > 0)) {
+        *signer_key = kzalloc(pk->keylen, GFP_KERNEL);
+        if (*signer_key != NULL) {
+            memcpy(*signer_key, pk->key, pk->keylen);
+            *signer_keylen = pk->keylen;
+            ret = 0;
+        } else
+            ret = -ENOMEM;
+    } else
+        ret = -EOPNOTSUPP;
+
+    key_put(key);
+    pr_debug("%s() = %d\n", __func__, ret);
+    return ret;
+}
+
  /**
   * integrity_kernel_module_request - prevent crypto-pkcs1pad(rsa,*) 
requests
   * @kmod_name: kernel module name
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a18f8c6d13b5..1a0bd266e869 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -77,6 +77,8 @@ choice
  		bool "ima-ng (default)"
  	config IMA_SIG_TEMPLATE
  		bool "ima-sig"
+	config IMA_SIGKEY_TEMPLATE
+		bool "ima-sigkey"
  endchoice

  config IMA_DEFAULT_TEMPLATE
@@ -85,6 +87,7 @@ config IMA_DEFAULT_TEMPLATE
  	default "ima" if IMA_TEMPLATE
  	default "ima-ng" if IMA_NG_TEMPLATE
  	default "ima-sig" if IMA_SIG_TEMPLATE
+	default "ima-sigkey" if IMA_SIGKEY_TEMPLATE

  choice
  	prompt "Default integrity hash algorithm"
diff --git a/security/integrity/ima/ima_template.c 
b/security/integrity/ima/ima_template.c
index b631b8bc7624..4a92d80df96f 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
  	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
  	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
  	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
+    {.name = "ima-sigkey", .fmt = "d-ng|n-ng|sig|sigkey"},
  	{.name = "", .fmt = ""},	/* placeholder for a custom format */
  };

@@ -43,6 +44,8 @@ static const struct ima_template_field 
supported_fields[] = {
  	 .field_show = ima_show_template_string},
  	{.field_id = "sig", .field_init = ima_eventsig_init,
  	 .field_show = ima_show_template_sig},
+    {.field_id = "sigkey", .field_init = ima_eventsigkey_init,
+     .field_show = ima_show_template_sigkey},
  };
  #define MAX_TEMPLATE_NAME_LEN 15

diff --git a/security/integrity/ima/ima_template_lib.c 
b/security/integrity/ima/ima_template_lib.c
index 513b457ae900..c134567c982c 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -162,6 +162,12 @@ void ima_show_template_sig(struct seq_file *m, enum 
ima_show_type show,
  	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
  }

+void ima_show_template_sigkey(struct seq_file *m, enum ima_show_type show,
+               struct ima_field_data *field_data)
+{
+    ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
+}
+
  /**
   * ima_parse_buf() - Parses lengths and data from an input buffer
   * @bufstartp:       Buffer start address.
@@ -389,3 +395,40 @@ int ima_eventsig_init(struct ima_event_data 
*event_data,
  	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
  					     DATA_FMT_HEX, field_data);
  }
+
+/*
+ *  ima_eventsigkey_init - include the public key corresponding
+ *  to the file signature as part of the template data.
+ */
+int ima_eventsigkey_init(struct ima_event_data *event_data,
+            struct ima_field_data *field_data)
+{
+    struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
+    void *signer_key = NULL;
+    u32 signer_keylen = 0;
+    int ret;
+
+    if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
+        return 0;
+
+    ret = integrity_get_signer_key(INTEGRITY_KEYRING_IMA,
+                    (const char *)event_data->xattr_value,
+                    event_data->xattr_len,
+                    &signer_key,
+                    &signer_keylen);
+    if (ret & IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+        ret = integrity_get_signer_key(INTEGRITY_KEYRING_PLATFORM,
+                    (const char *)event_data->xattr_value,
+                    event_data->xattr_len,
+                    &signer_key,
+                    &signer_keylen);
+    }
+
+    if (!ret && (signer_keylen > 0) && (signer_key != NULL)) {
+        ret = ima_write_template_field_data(signer_key, signer_keylen,
+                        DATA_FMT_HEX, field_data);
+        kfree(signer_key);
+    }
+
+    return 0;
+}
diff --git a/security/integrity/ima/ima_template_lib.h 
b/security/integrity/ima/ima_template_lib.h
index 6a3d8b831deb..db3328d0146b 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -29,6 +29,8 @@ void ima_show_template_string(struct seq_file *m, enum 
ima_show_type show,
  			      struct ima_field_data *field_data);
  void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
  			   struct ima_field_data *field_data);
+void ima_show_template_sigkey(struct seq_file *m, enum ima_show_type show,
+               struct ima_field_data *field_data);
  int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
  		  int maxfields, struct ima_field_data *fields, int *curfields,
  		  unsigned long *len_mask, int enforce_mask, char *bufname);
@@ -42,4 +44,6 @@ int ima_eventname_ng_init(struct ima_event_data 
*event_data,
  			  struct ima_field_data *field_data);
  int ima_eventsig_init(struct ima_event_data *event_data,
  		      struct ima_field_data *field_data);
+int ima_eventsigkey_init(struct ima_event_data *event_data,
+              struct ima_field_data *field_data);
  #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7de59f44cba3..bd1bbd8d6b8e 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -144,19 +144,38 @@ int integrity_kernel_read(struct file *file, 
loff_t offset,
  #define INTEGRITY_KEYRING_PLATFORM	2
  #define INTEGRITY_KEYRING_MAX		3

+/* Digital signature version number */
+#define INTEGRITY_SIGNATURE_VERSION_1 1
+#define INTEGRITY_SIGNATURE_VERSION_2 2
+
  extern struct dentry *integrity_dir;

  #ifdef CONFIG_INTEGRITY_SIGNATURE

+int integrity_digsig_version(const char *sig, int siglen);
  int integrity_digsig_verify(const unsigned int id, const char *sig, 
int siglen,
  			    const char *digest, int digestlen);
-
+int integrity_get_signer_key(const unsigned int id,
+            const char *sig, int siglen,
+            void **signer_key, u32 *signer_keylen);
  int __init integrity_init_keyring(const unsigned int id);
  int __init integrity_load_x509(const unsigned int id, const char *path);
  int __init integrity_load_cert(const unsigned int id, const char *source,
  			       const void *data, size_t len, key_perm_t perm);
  #else

+static inline int integrity_digsig_version(const char *sig, int siglen)
+{
+    return -EOPNOTSUPP;
+}
+
+static inline int integrity_get_signer_key(const unsigned int id,
+            const char *sig, int siglen,
+            void **signer_key, u32 *signer_keylen)
+{
+    return -EOPNOTSUPP;
+}
+
  static inline int integrity_digsig_verify(const unsigned int id,
  					  const char *sig, int siglen,
  					  const char *digest, int digestlen)
@@ -181,12 +200,20 @@ static inline int __init integrity_load_cert(const 
unsigned int id,
  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
  int asymmetric_verify(struct key *keyring, const char *sig,
  		      int siglen, const char *data, int datalen);
+int asymmetric_signer_public_key(struct key *keyring, const char *sig,
+              int siglen, void **signer_key, u32 *signer_keylen);
  #else
  static inline int asymmetric_verify(struct key *keyring, const char *sig,
  				    int siglen, const char *data, int datalen)
  {
  	return -EOPNOTSUPP;
  }
+static inline int asymmetric_signer_public_key(struct key *keyring,
+                const char *sig, int siglen,
+                void **signer_key, u32 *signer_keylen)
+{
+    return -EOPNOTSUPP;
+}
  #endif

  #ifdef CONFIG_IMA_LOAD_X509
-- 
2.17.1

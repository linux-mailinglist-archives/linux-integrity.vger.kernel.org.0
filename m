Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC53100EDA
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2019 23:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKRWi1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 17:38:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50934 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKRWi1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 17:38:27 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6D5892007688;
        Mon, 18 Nov 2019 14:38:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D5892007688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574116704;
        bh=fleP7H4TM/CO+V9CRZztMejEC6XI/JMf1nj1H2WYGLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kb0jPBfPcZb8XgsJleEwwmUAA6f/8ofEB4l5HpzD0FHkfBkiSS9Z5GnEKkq0ZBhjc
         5w4wtov61Rd3zMiyo66oiudgovxhg5Z/UtvzjrwcZxRR3dzNWsgvfNbuj2NM5YvNRw
         RDDuJl23fuLuYq6VWM1bKMsCMYTn1Ynq2xWRL6+w=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v8 4/5] IMA: Add support to limit measuring keys
Date:   Mon, 18 Nov 2019 14:38:17 -0800
Message-Id: <20191118223818.3353-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118223818.3353-1-nramas@linux.microsoft.com>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Limit measuring keys to those keys being loaded onto a given set of
keyrings only.

This patch defines a new IMA policy option namely "keyrings=" that
can be used to specify a set of keyrings. If this option is specified
in the policy for "measure func=KEY_CHECK" then only the keys
loaded onto a keyring given in the "keyrings=" option are measured.

Added a new parameter namely "keyring" (name of the keyring) to
process_buffer_measurement(). The keyring name is passed to
ima_get_action() to determine the required action.
ima_match_rules() is updated to check keyring in the policy, if
specified, for KEY_CHECK function.

The following example illustrates how key measurement can be verified.

Sample IMA Policy entry to measure keys
(Added in the file /etc/ima/ima-policy):
measure func=KEY_CHECK keyrings=.ima|.evm|.blacklist template=ima-buf

Build the kernel with this patch set applied and reboot to that kernel.

Ensure the IMA policy is applied:

root@nramas:/home/nramas# cat /sys/kernel/security/ima/policy
measure func=KEY_CHECK keyrings=.ima|.evm|.blacklist template=ima-buf

View the initial IMA measurement log:

root@nramas:/home/nramas# cat /sys/kernel/security/ima/ascii_runtime_measurements
10 67ec... ima-ng sha1:b5466c508583f0e633df83aa58fc7c5b67ccf667 boot_aggregate

Now, add a certificate in DER format (for example, x509_ima.der) to
the .ima keyring:

root@nramas:/home/nramas# keyctl show %:.ima
Keyring
 547515640 ---lswrv      0     0  keyring: .ima

root@nramas:/home/nramas# evmctl import x509_ima.der 547515640

root@nramas:/home/nramas# keyctl show %:.ima
Keyring
 547515640 ---lswrv      0     0  keyring: .ima
 809678766 --als--v      0     0   \_ asymmetric: hostname: whoami signing key: 052dd247dc3c36...

View the updated IMA measurement log:

root@nramas:/home/nramas# cat /sys/kernel/security/ima/ascii_runtime_measurements
10 67ec... ima-ng sha1:b5466c508583f0e633df83aa58fc7c5b67ccf667 boot_aggregate
10 3adf... ima-buf sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b .ima 30818902818100ee96b264072a42888f78a2f9b8198467a3ad97d126f3d1cc1c24d23e7185cc743b04d4a54254ca16e1e11ed4450deb98b1f7bb4288424570fabcfc6d5aa93a2a14fa2b7835ac877cfea761e5ff414c6ee274eff26f8bd6c484312e56619299acf0dbd224b87c3883b66a9393d21af8962458663b0ac1706c63773cd50e8236270203010001
root@nramas:/home/nramas#

The public key of x509_ima.der certificate and the key's SHA-256 hash
are included in the IMA log.

For example, in the above IMA log entry the public key is the following:

30818902818100ee96b264072a42888f78a2f9b8198467a3ad97d126f3d1cc1c24d23e7185cc743b04d4a54254ca16e1e11ed4450deb98b1f7bb4288424570fabcfc6d5aa93a2a14fa2b7835ac877cfea761e5ff414c6ee274eff26f8bd6c484312e56619299acf0dbd224b87c3883b66a9393d21af8962458663b0ac1706c63773cd50e8236270203010001

sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b

root@nramas:/home/nramas# cat /sys/kernel/security/ima/ascii_runtime_measurements |
                          grep " .ima" | cut -d' ' -f 6 | xxd -r -p | sha256sum
27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b
root@nramas:/home/nramas#

SHA-256 hash in the IMA log and the above output should match.

Now run the following "openssl" command to display
various fields of x509_ima.der certificate:

Verify the "Modulus" and the "Exponent" with that
in the public key data in the IMA log entry.
Note that the "Modulus" in the IMA log entry follows
the RSA Header (For example, 308189028181)
The "Exponent" is the last 3 hex numbers in the IMA log
(For example, 0x01 0x00 0x01)

root@nramas:/home/nramas# openssl x509 -in x509_ima.der -inform der -noout -text
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            5b:e0:23:4f:f3:ad:f0:50:34:9b:33:b8:94:65:a6:aa:b6:e3:39:f7
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: O = hostname, CN = whoami signing key, emailAddress = whoami@hostname
        Validity
            Not Before: Aug 22 02:29:02 2019 GMT
            Not After : Aug 21 02:29:02 2020 GMT
        Subject: O = hostname, CN = whoami signing key, emailAddress = whoami@hostname
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (1024 bit)
                Modulus:
                    00:ee:96:b2:64:07:2a:42:88:8f:78:a2:f9:b8:19:
                    84:67:a3:ad:97:d1:26:f3:d1:cc:1c:24:d2:3e:71:
                    85:cc:74:3b:04:d4:a5:42:54:ca:16:e1:e1:1e:d4:
                    45:0d:eb:98:b1:f7:bb:42:88:42:45:70:fa:bc:fc:
                    6d:5a:a9:3a:2a:14:fa:2b:78:35:ac:87:7c:fe:a7:
                    61:e5:ff:41:4c:6e:e2:74:ef:f2:6f:8b:d6:c4:84:
                    31:2e:56:61:92:99:ac:f0:db:d2:24:b8:7c:38:83:
                    b6:6a:93:93:d2:1a:f8:96:24:58:66:3b:0a:c1:70:
                    6c:63:77:3c:d5:0e:82:36:27
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Key Usage: 
                Digital Signature
            X509v3 Subject Key Identifier: 
                05:2D:D2:47:DC:3C:36:D6:D6:06:75:FE:7A:E8:69:79:0B:E5:61:71
            X509v3 Authority Key Identifier: 
                keyid:E3:67:10:F0:83:4C:97:3E:D9:4A:18:6F:BC:D2:23:75:B4:5E:24:54

    Signature Algorithm: sha256WithRSAEncryption
         b1:2f:ae:ff:1e:0e:39:0c:fd:5e:b7:14:0a:f3:b7:a6:53:cb:
         49:c6:ab:0a:23:be:24:c0:35:33:1d:76:00:c8:f7:58:f9:df:
         7f:df:c5:ee:b6:fe:c3:58:59:20:3e:ca:0e:4f:01:f9:a7:9a:
         58:be:63:09:47:cb:95:9a:52:d3:f2:de:96:f2:10:d4:92:47:
         c3:3a:62:26:dc:2a:52:ee:54:10:69:ed:3c:62:1f:87:67:fd:
         36:a0:61:e9:a6:1a:db:5d:1d:d3:44:99:d9:9a:1c:e6:ba:a4:
         96:b4:f5:e2:26:8b:fc:52:c3:ee:a4:a6:b7:b5:18:1f:08:52:
         4a:ee
root@nramas:/home/nramas#

An ima-sig entry for a kernel module, say, kheaders.ko
from the IMA log entry is given below:

10 0c98... ima-sig
sha256:3bc6ed4f0b4d6e31bc1dbc9ef844605abc7afdc6d81a57d77a1ec9407997c40
2 /usr/lib/modules/5.4.0-rc3+/kernel/kernel/kheaders.ko
03020BE561710100abcde...

In the above 0BE56171 is the Key ID of the key used to verify
the IMA signature. This Key ID is the last 4 hex digits of
the subject key identifier displayed in openssl output
for the certificate x509_ima.der (Which is the IMA certificate
used to sign the kernel module).

X509v3 Subject Key Identifier:
   05:2D:D2:47:DC:3C:36:D6:D6:06:75:FE:7A:E8:69:79:0B:E5:61:71

The ima-modsig entry for the same kernel module is:

10 82aa... ima-modsig
sha256:3bc6ed4f0b4d6e31bc1dbc9ef844605abc7afdc6d81a57d77a1ec9407997c40
2 /usr/lib/modules/5.4.0rc3+/kernel/kernel/kheaders.ko  
sha256:77fa889b35a05338ec52e51591c1b89d4c8d1c99a21251d7c22b1a8642a6bad3
30818902818100ee96b264072a42888f78a2f9b8198467a3ad97d126f3d1cc1c24d23e7185cc743b04d4a54254ca16e1e11ed4450deb98b1f7bb4288424570fabcfc6d5aa93a2a14fa2b7835ac877cfea761e5ff414c6ee274eff26f8bd6c484312e56619299acf0dbd224b87c3883b66a9393d21af8962458663b0ac1706c63773cd50e8236270203010001

If the kernel module was signed by x509_ima.der certificate then
the public key entry in the ima-modsig should match the public key
for the key measurement for x509_ima.der.

The above can be used to correlate the key measurement IMA entry,
ima-sig and ima-modsig entries using the same key.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: James Morris <jamorris@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy         | 10 ++-
 security/integrity/ima/ima.h                 |  8 ++-
 security/integrity/ima/ima_api.c             |  8 ++-
 security/integrity/ima/ima_appraise.c        |  4 +-
 security/integrity/ima/ima_asymmetric_keys.c |  8 ++-
 security/integrity/ima/ima_main.c            |  9 +--
 security/integrity/ima/ima_policy.c          | 67 ++++++++++++++++++--
 7 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 3823c27894c5..5a941ed20fa3 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -25,7 +25,7 @@ Description:
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
-				[appraise_flag=]
+				[appraise_flag=] [keyrings=]
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
@@ -42,6 +42,9 @@ Description:
 			appraise_flag:= [check_blacklist]
 			Currently, blacklist check is only for files signed with appended
 			signature.
+			keyrings:= list of keyrings
+			(eg, .builtin_trusted_keys|.ima). Only valid
+			when action is "measure" and func is KEY_CHECK.
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
@@ -118,3 +121,8 @@ Description:
 
 			measure func=KEY_CHECK
 
+		Example of measure rule using KEY_CHECK to only measure
+		keys added to .builtin_trusted_keys or .ima keyring:
+
+			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
+
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index fe6c698617bd..f06238e41a7c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -208,7 +208,8 @@ struct modsig;
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc);
+		   struct ima_template_desc **template_desc,
+		   const char *keyring);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -220,7 +221,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr);
+				int pcr, const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
@@ -235,7 +236,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
-		     struct ima_template_desc **template_desc);
+		     struct ima_template_desc **template_desc,
+		     const char *keyring);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 610759fe63b8..f6bc00914aa5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -169,12 +169,13 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
  * @template_desc: pointer filled in if matched measure policy sets template=
+ * @keyring: keyring name used to determine the action
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE
+ *	| KEXEC_CMDLINE | KEY_CHECK
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
@@ -183,14 +184,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc)
+		   struct ima_template_desc **template_desc,
+		   const char *keyring)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc);
+				template_desc, keyring);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 300c8d2943c5..a9649b04b9f1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -55,7 +55,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 
 	security_task_getsecid(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL);
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
@@ -330,7 +330,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr);
+						   pcr, NULL);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index f6884641a622..8c692eb08a0a 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -45,7 +45,13 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 * parameter to process_buffer_measurement() and is set
 	 * in the "eventname" field in ima_event_data for
 	 * the key measurement IMA event.
+	 *
+	 * The name of the keyring is also passed in the "keyring"
+	 * parameter to process_buffer_measurement() to check
+	 * if the IMA policy is configured to measure a key linked
+	 * to the given keyring.
 	 */
 	process_buffer_measurement(pk->key, pk->keylen,
-				   keyring->description, KEY_CHECK, 0);
+				   keyring->description, KEY_CHECK, 0,
+				   keyring->description);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..6d0bf241ebf8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -215,7 +215,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
-				&template_desc);
+				&template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -632,12 +632,13 @@ int ima_load_data(enum kernel_load_data_id id)
  * @eventname: event name to be used for the buffer entry.
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
+ * @keyring: keyring name to determine the action to be performed
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr)
+				int pcr, const char *keyring)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -665,7 +666,7 @@ void process_buffer_measurement(const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(NULL, current_cred(), secid, 0, func,
-					&pcr, &template);
+					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
@@ -718,7 +719,7 @@ void ima_kexec_cmdline(const void *buf, int size)
 {
 	if (buf && size != 0)
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   KEXEC_CMDLINE, 0);
+					   KEXEC_CMDLINE, 0, NULL);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1525a28fd705..d9400585fcda 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -79,6 +79,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	char *keyrings; /* Measure keys added to these keyrings */
 	struct ima_template_desc *template;
 };
 
@@ -356,6 +357,55 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_OK;
 }
 
+/**
+ * ima_match_keyring - determine whether the keyring matches the measure rule
+ * @rule: a pointer to a rule
+ * @keyring: name of the keyring to match against the measure rule
+ *
+ * If the measure action for KEY_CHECK does not specify keyrings=
+ * option then return true (Measure all keys).
+ * Else, return true if the given keyring name is present in
+ * the keyrings= option. False, otherwise.
+ */
+static bool ima_match_keyring(struct ima_rule_entry *rule,
+			      const char *keyring)
+{
+	const char *p;
+
+	/* If "keyrings=" is not specified all keys are measured. */
+	if (!rule->keyrings)
+		return true;
+
+	if (!keyring)
+		return false;
+
+	/*
+	 * "keyrings=" is specified in the policy in the format below:
+	 *   keyrings=.builtin_trusted_keys|.ima|.evm
+	 *
+	 * Each keyring name in the option is separated by a '|' and
+	 * the last keyring name is null terminated.
+	 *
+	 * The given keyring is considered matched only if
+	 * the whole keyring name matched a keyring name specified
+	 * in the "keyrings=" option.
+	 */
+	p = strstr(rule->keyrings, keyring);
+	if (p) {
+		/*
+		 * Found a substring match. Check if the character
+		 * at the end of the keyring name is | (keyring name
+		 * separator) or is the terminating null character.
+		 * If yes, we have a whole string match.
+		 */
+		p += strlen(keyring);
+		if (*p == '|' || *p == '\0')
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * ima_match_rules - determine whether an inode matches the measure rule.
  * @rule: a pointer to a rule
@@ -364,18 +414,23 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  * @secid: the secid of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @keyring: keyring name to check in policy for KEY_CHECK func
  *
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			    const struct cred *cred, u32 secid,
-			    enum ima_hooks func, int mask)
+			    enum ima_hooks func, int mask,
+			    const char *keyring)
 {
 	int i;
 
 	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
-		if ((rule->flags & IMA_FUNC) && (rule->func == func))
+		if ((rule->flags & IMA_FUNC) && (rule->func == func)) {
+			if (func == KEY_CHECK)
+				return ima_match_keyring(rule, keyring);
 			return true;
+		}
 		return false;
 	}
 	if ((rule->flags & IMA_FUNC) &&
@@ -479,6 +534,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
+ * @keyring: the keyring name, if given, to be used to check in the policy.
+ *           keyring can be NULL if func is anything other than KEY_CHECK.
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -489,7 +546,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
-		     struct ima_template_desc **template_desc)
+		     struct ima_template_desc **template_desc,
+		     const char *keyring)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -503,7 +561,8 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
+		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
+				     keyring))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
-- 
2.17.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A173ED006
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhHPILk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 04:11:40 -0400
Received: from mail-vi1eur05on2111.outbound.protection.outlook.com ([40.107.21.111]:26208
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234704AbhHPILj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 04:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fL41Pnz8yw+LUv5MnZ9+srW9PVx7ks9l7LRNlGldk2wzdmLm6E+ivDI218d1nXQxokNeIp3PYd2i0Bb/YC+hkjGFc6F1892lNHf2GdCPw04JxO5YA49CGIubYWEv/JZexIubxsnWZpeFtp2rdfEpVDdHN/ygUzZje/wCi7jfi6GQcLXTpAIq5eTvjneyyB2LKIYmTc+mdzCGuwb7wbOCUGEBW0LGlMYCWWf0aKFe50m0k8C48ovBHEzetBGLtkYnmDUdru8cMSBoNa2sLZw1htt+7/cg4jKq27oVks7ZLq3L/+nMHV+GOM5AUYxATbmlhXeFQSuUHQdQnA2BNNe5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmZZhlsKUy93m5WtPgq/nUZ4Rosq2q0dDgKN6fYOsFc=;
 b=OqBzKLRaRpVqe2pgZMWNI3y7uYpRi7nO8aTOqU8RBCoKJGJHkk0n4/avWjl3+9FbdwV+wq+L0Ag3iTeHq36RlQplEvsCB+KYyUYM1ONroFt/pFaBLpyHnNxpf46PzXJ4JMF6i+wPWaLQXVE1DpIlOd0ITLD+tp9G7hSo6pg0pMVZBB7BNUn/rh6u6/pMuUaFwsjcN0iAJJu+d4yXAxKaqbLM5w0D1TJdJbedUXvgqnfu3xldQx8kSA49sg4yNHtgMG7RX3g6kjv8iQemlPxbW6VTFQBx1JW+qi8Dd5g26xagai+OkpGDvybTZfjoMLRYoJHJKvEwwg2vlz2soVjC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmZZhlsKUy93m5WtPgq/nUZ4Rosq2q0dDgKN6fYOsFc=;
 b=QqH++PQ5Ry2ZH5fo912LHV3mq9tm6GIevBi7uURJb+rnyxg7ACGDd4OquegVBtQ4M1cCVKQXDGDnwQrQDlPvoTWGuXH8JRtZYdCU8GfLeBM+OcHkr96P5RJ+RcwDN2Cn3MrWaaKLSeNqJMUL6xewmkQZnY8Ym72cCHN3KiUcsYw=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4516.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 08:11:01 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 08:11:01 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v8 5/6] IMA: introduce a new policy option func=SETXATTR_CHECK
Thread-Topic: [PATCH v8 5/6] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Index: AQHXknZAR6uR7Q5bV0CCsygEkBMiMA==
Date:   Mon, 16 Aug 2021 08:11:01 +0000
Message-ID: <20210816081056.24530-6-Simon.THOBY@viveris.fr>
References: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
In-Reply-To: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8d06bf1-ec98-4eac-1df1-08d9608d62ea
x-ms-traffictypediagnostic: AM9PR09MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB4516C0A7AE5AFC229F3D8DCA94FD9@AM9PR09MB4516.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/xi4/ejcATSULFokcJuwu5gy4lGI0FlZL5v3rHhRqYiYfiZQTuRQD9MscCx0qYHFrDKVNs7qNzwx4Xx4EQK9Ak5du28R8MuKs6Cyb7AYI6ZDUP+sbhWCLuml1g99bRinMSS/WRas6Hrr4fW1DvcpM694LbWoH4Bmyi2O+3AzHDY4SeQJrd597QzPAEpmHzreaKPCNK3NNjtAlZASgOfSVqHe8GFEkfhEhqsUi8bMv+LHmZ4LqAH4kO0bcyh9Qtr2zcBkQGOmssSauIG4rdyYh7DUye1cVbQrjXzw5qdEArWR+xLIaJyk6ciOfDGrWtSJ5usBnAjY/iblPvoQUCwk/IbPmsEYhZkfOA1l65xrm4f5THr0/duoSzr33EX4JsT4XcMSfkcbrvXJYgg53+HnZ66I4k7Zdswnq370GhL10/n4wW2hhn9SUwNOiUP7Z7r1sUN469l8CSLtO16v9FljprlVLN6Q85/4SlY0sxEhbqKy/oGQ1eMtAEr8JGSfkrJjmtqeSimEenpFvOFtF/Yd/Y+zrYb2zFqOEUjOVuIfBrxENbFXIQ9cJ9K4m8V3sjEL6RsUDiGJsWKOQiBlP0kmShlXgkoMlr1guY0UVdGJJX0iLp332xN6ZdBPg3C6GEn2YUx+lDRCl/4LvvvaRBOcSSbNszsQxMwulPV3SBo7EmkeLnBYqFCScG2Rp6RTvsx+wxRij/xXJbnPLrropwY/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(71200400001)(6636002)(2616005)(122000001)(83380400001)(6486002)(36756003)(38100700002)(66446008)(8936002)(4326008)(110136005)(26005)(66946007)(1076003)(2906002)(5660300002)(508600001)(6506007)(8676002)(54906003)(186003)(38070700005)(86362001)(66556008)(316002)(76116006)(91956017)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2eAWJ+Cd1/slWw6tcZ6OqIhm8fYndNPr+iTaStr99m3clXNp8FReUut7E7?=
 =?iso-8859-1?Q?Kdrk9fnKSVwQOnSArhlcZKnM0Kv0RVZTUkCL3ajqy7AXbMwTBRVhKSmNdC?=
 =?iso-8859-1?Q?2c1KlMQoS4/RcWW4yxAgd+jPJGAIOryuqgZJ5V7rgVG4o4S/fk+tqMWW30?=
 =?iso-8859-1?Q?1j9gTAyO9p9LycFQbL/jnNaPZIGAVDZdjX36QNOGTRv+1hVrNa0AGTLja2?=
 =?iso-8859-1?Q?CsXJ9KcjMbtL0xAhBgUkaB4YCfvj61Si42NeBt+z67hlw+L4ujPQV6AI3G?=
 =?iso-8859-1?Q?S8QWn0NRkKDukejKHJ29W8CmUHjb6hLZXxfCIdy2w0tfSpIbpKy9Vig5gU?=
 =?iso-8859-1?Q?tlVcnVofe4fZgi7JqECF4p1Qf7aZRANVd3n710hgue/L4aXok8d351ykqg?=
 =?iso-8859-1?Q?a1v0t8Og5H+1Nby6BzuOj2KLyNG6RP8hdTn+zUDrcLXtejdaOlxXUH3/hB?=
 =?iso-8859-1?Q?OvwfI+db5rikNcxvfMhMb3Xs4d8CqwNAu3Gm2XpAUia9Y+yxuxd+q1eKWS?=
 =?iso-8859-1?Q?RI9ynRcoNnnJUlvkYC5YgblUT7tfkISC/jZu/AN1b0CIVBAo/djQov7BM9?=
 =?iso-8859-1?Q?6x3XZn6+PhUkLX+ouffni9N60GvUBf3WzGBFboDAdpOq+9BGLkVJD5EiLb?=
 =?iso-8859-1?Q?xjb+3oTzPLrEDCicSZL3pejXnWw0XCsyxyTkpQrNlZNqeFydSwlQUq3OnZ?=
 =?iso-8859-1?Q?EDyokZZAU87xaUpGEDaFb97hqHf14FAwKhJE4svXhri6bP0PYvwfX4c728?=
 =?iso-8859-1?Q?vjT+zXBMZimYSi79yPjyVdmFsEEIfAFSumesOq3vWDug5R7DSRP8t7vst1?=
 =?iso-8859-1?Q?rdPTy6iE3BTFE9NhlPY6g5vnaHaMjZ8ndSdcLokgWL4p9Og2qmtX66ndTE?=
 =?iso-8859-1?Q?8ukq0WUnB0Yniawt5RfD4dzPYhyz9OTpPFANjwuOZB23CcovVBn2m6LTBU?=
 =?iso-8859-1?Q?d4OOkmpCby4dNTI/mwi06loEJtngWIL658pgkRK7sm0wtXfKq9znIA9mip?=
 =?iso-8859-1?Q?EPjbrhVJmmVf3cS3Ke3eowNKMb25w7uvDpqNoWUlH2QsgHHKiLt6VctX2n?=
 =?iso-8859-1?Q?hKpBTmKOcuJSZ25rGauf4OH1B1xKlSCKxODXzAeKudX/1j1E+yiSVuSQ/9?=
 =?iso-8859-1?Q?yLGCt2Hdr87VRKNS4jQ11205vcXpcoAOqGZCeT7Ro11qPAjy5JpETS15js?=
 =?iso-8859-1?Q?+VNTQZOOhGUR05+T9zfzYXa5AZLo1lbxqQdiUrAeAveGy5ThWsVC+NMnGt?=
 =?iso-8859-1?Q?93cu24Z3q6ybi4Qa0Lbk52ZiQnRCCbte9Pcp4dMZZaai3klhQzC9A1lGhJ?=
 =?iso-8859-1?Q?DM5kJqsPMfx9CRjc0INm/2jNRLhYUVBE9YTG6WBcDP2A2foPU2OZIP0t8/?=
 =?iso-8859-1?Q?NWF00aC1kY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d06bf1-ec98-4eac-1df1-08d9608d62ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 08:11:01.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mydSAZEuipi9/ukztaVEXqkdaFBE/WLZ2i6azO9H3JcN1iZxEsM1geAchtLyTuP0v1JcTli0xZ5PScQEN5T/BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4516
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

While users can restrict the accepted hash algorithms for the
security.ima xattr file signature when appraising said file, users
cannot restrict the algorithms that can be set on that attribute:
any algorithm built in the kernel is accepted on a write.

Define a new value for the ima policy option 'func' that restricts
globally the hash algorithms accepted when writing the security.ima
xattr.

When a policy contains a rule of the form
	appraise func=3DSETXATTR_CHECK appraise_algos=3Dsha256,sha384,sha512
only values corresponding to one of these three digest algorithms
will be accepted for writing the security.ima xattr.
Attempting to write the attribute using another algorithm (or "free-form"
data) will be denied with an audit log message.
In the absence of such a policy rule, the default is still to only
accept hash algorithms built in the kernel (with all the limitations
that entails).

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
---
 Documentation/ABI/testing/ima_policy  |  9 +++-
 security/integrity/ima/ima.h          |  6 ++-
 security/integrity/ima/ima_appraise.c | 29 ++++++++--
 security/integrity/ima/ima_main.c     |  2 +-
 security/integrity/ima/ima_policy.c   | 76 +++++++++++++++++++++++----
 5 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testi=
ng/ima_policy
index b0e3d278e799..5c2798534950 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -30,9 +30,10 @@ Description:
 				[appraise_flag=3D] [appraise_algos=3D] [keyrings=3D]
 		  base:
 			func:=3D [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK=
]
-			        [FIRMWARE_CHECK]
+				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
+				[SETXATTR_CHECK]
 			mask:=3D [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:=3D hex value
@@ -138,3 +139,9 @@ Description:
 		keys added to .builtin_trusted_keys or .ima keyring:
=20
 			measure func=3DKEY_CHECK keyrings=3D.builtin_trusted_keys|.ima
+
+		Example of the special SETXATTR_CHECK appraise rule, that
+		restricts the hash algorithms allowed when writing to the
+		security.ima xattr of a file:
+
+			appraise func=3DSETXATTR_CHECK appraise_algos=3Dsha256,sha384,sha512
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index bcaf818fb647..be965a8715e4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -46,6 +46,9 @@ enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8, TPM_PCR10=
 =3D 10 };
 /* current content of the policy */
 extern int ima_policy_flag;
=20
+/* bitset of digests algorithms allowed in the setxattr hook */
+extern atomic_t ima_setxattr_allowed_hash_algorithms;
+
 /* set during initialization */
 extern int ima_hash_algo __ro_after_init;
 extern int ima_sha1_idx __ro_after_init;
@@ -198,6 +201,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(KEXEC_CMDLINE, kexec_cmdline)		\
 	hook(KEY_CHECK, key)				\
 	hook(CRITICAL_DATA, critical_data)		\
+	hook(SETXATTR_CHECK, setxattr_check)		\
 	hook(MAX_CHECK, none)
=20
 #define __ima_hook_enumify(ENUM, str)	ENUM,
@@ -288,7 +292,7 @@ int ima_match_policy(struct user_namespace *mnt_userns,=
 struct inode *inode,
 		     const char *func_data, unsigned int *allowed_algos);
 void ima_init_policy(void);
 void ima_update_policy(void);
-void ima_update_policy_flag(void);
+void ima_update_policy_flags(void);
 ssize_t ima_parse_add_rule(char *);
 void ima_delete_rules(void);
 int ima_check_policy(void);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index e2edef8a9185..8f1eb7ef041e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -595,12 +595,32 @@ static int validate_hash_algo(struct dentry *dentry,
 {
 	char *path =3D NULL, *pathbuf =3D NULL;
 	enum hash_algo xattr_hash_algo;
+	const char *errmsg =3D "unavailable-hash-algorithm";
+	unsigned int allowed_hashes;
=20
 	xattr_hash_algo =3D ima_get_hash_algo(xattr_value, xattr_value_len);
=20
-	if (likely(xattr_hash_algo =3D=3D ima_hash_algo ||
-		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
-		return 0;
+	allowed_hashes =3D atomic_read(&ima_setxattr_allowed_hash_algorithms);
+
+	if (allowed_hashes) {
+		/* success if the algorithm is allowed in the ima policy */
+		if (allowed_hashes & (1U << xattr_hash_algo))
+			return 0;
+
+		/*
+		 * We use a different audit message when the hash algorithm
+		 * is denied by a policy rule, instead of not being built
+		 * in the kernel image
+		 */
+		errmsg =3D "denied-hash-algorithm";
+	} else {
+		if (likely(xattr_hash_algo =3D=3D ima_hash_algo))
+			return 0;
+
+		/* allow any xattr using an algorithm built in the kernel */
+		if (crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0))
+			return 0;
+	}
=20
 	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!pathbuf)
@@ -609,8 +629,7 @@ static int validate_hash_algo(struct dentry *dentry,
 	path =3D dentry_path(dentry, pathbuf, PATH_MAX);
=20
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
-			    "set_data", "unavailable-hash-algorithm",
-			    -EACCES, 0);
+			    "set_data", errmsg, -EACCES, 0);
=20
 	kfree(pathbuf);
=20
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index af6367ba34ee..a734f7d5292c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1051,7 +1051,7 @@ static int __init init_ima(void)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
=20
 	if (!error)
-		ima_update_policy_flag();
+		ima_update_policy_flags();
=20
 	return error;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index cb86da0e562b..9eaa509f487a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -53,6 +53,8 @@ int ima_policy_flag;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
=20
+atomic_t ima_setxattr_allowed_hash_algorithms;
+
 #define MAX_LSM_RULES 6
 enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
 	LSM_SUBJ_USER, LSM_SUBJ_ROLE, LSM_SUBJ_TYPE
@@ -720,24 +722,57 @@ int ima_match_policy(struct user_namespace *mnt_usern=
s, struct inode *inode,
 	return action;
 }
=20
-/*
- * Initialize the ima_policy_flag variable based on the currently
- * loaded policy.  Based on this flag, the decision to short circuit
- * out of a function or not call the function in the first place
- * can be made earlier.
+/**
+ * ima_update_policy_flags() - Update global IMA variables
+ *
+ * Update ima_policy_flag and ima_setxattr_allowed_hash_algorithms
+ * based on the currently loaded policy.
+ *
+ * With ima_policy_flag, the decision to short circuit out of a function
+ * or not call the function in the first place can be made earlier.
+ *
+ * With ima_setxattr_allowed_hash_algorithms, the policy can restrict the
+ * set of hash algorithms accepted when updating the security.ima xattr of
+ * a file.
+ *
+ * Context: called after a policy update and at system initialization.
  */
-void ima_update_policy_flag(void)
+void ima_update_policy_flags(void)
 {
 	struct ima_rule_entry *entry;
+	int new_policy_flag =3D 0;
=20
+	rcu_read_lock();
 	list_for_each_entry(entry, ima_rules, list) {
+		/*
+		 * SETXATTR_CHECK rules do not implement a full policy check
+		 * because rule checking would probably have an important
+		 * performance impact on setxattr(). As a consequence, only one
+		 * SETXATTR_CHECK can be active at a given time.
+		 * Because we want to preserve that property, we set out to use
+		 * atomic_cmpxchg. Either:
+		 * - the atomic was non-zero: a setxattr hash policy is
+		 *   already enforced, we do nothing
+		 * - the atomic was zero: no setxattr policy was set, enable
+		 *   the setxattr hash policy
+		 */
+		if (entry->func =3D=3D SETXATTR_CHECK) {
+			atomic_cmpxchg(&ima_setxattr_allowed_hash_algorithms,
+				       0, entry->allowed_algos);
+			/* SETXATTR_CHECK doesn't impact ima_policy_flag */
+			continue;
+		}
+
 		if (entry->action & IMA_DO_MASK)
-			ima_policy_flag |=3D entry->action;
+			new_policy_flag |=3D entry->action;
 	}
+	rcu_read_unlock();
=20
 	ima_appraise |=3D (build_ima_appraise | temp_ima_appraise);
 	if (!ima_appraise)
-		ima_policy_flag &=3D ~IMA_APPRAISE;
+		new_policy_flag &=3D ~IMA_APPRAISE;
+
+	ima_policy_flag =3D new_policy_flag;
 }
=20
 static int ima_appraise_flag(enum ima_hooks func)
@@ -903,7 +938,9 @@ void __init ima_init_policy(void)
 			  ARRAY_SIZE(critical_data_rules),
 			  IMA_DEFAULT_POLICY);
=20
-	ima_update_policy_flag();
+	atomic_set(&ima_setxattr_allowed_hash_algorithms, 0);
+
+	ima_update_policy_flags();
 }
=20
 /* Make sure we have a valid policy, at least containing some rules. */
@@ -943,7 +980,7 @@ void ima_update_policy(void)
 		 */
 		kfree(arch_policy_entry);
 	}
-	ima_update_policy_flag();
+	ima_update_policy_flags();
=20
 	/* Custom IMA policy has been loaded */
 	ima_process_queued_keys();
@@ -1176,6 +1213,23 @@ static bool ima_validate_rule(struct ima_rule_entry =
*entry)
 		if (ima_rule_contains_lsm_cond(entry))
 			return false;
=20
+		break;
+	case SETXATTR_CHECK:
+		/* any action other than APPRAISE is unsupported */
+		if (entry->action !=3D APPRAISE)
+			return false;
+
+		/* SETXATTR_CHECK requires an appraise_algos parameter */
+		if (!(entry->flags & IMA_VALIDATE_ALGOS))
+			return false;
+
+		/*
+		 * full policies are not supported, they would have too
+		 * much of a performance impact
+		 */
+		if (entry->flags & ~(IMA_FUNC | IMA_VALIDATE_ALGOS))
+			return false;
+
 		break;
 	default:
 		return false;
@@ -1332,6 +1386,8 @@ static int ima_parse_rule(char *rule, struct ima_rule=
_entry *entry)
 				entry->func =3D KEY_CHECK;
 			else if (strcmp(args[0].from, "CRITICAL_DATA") =3D=3D 0)
 				entry->func =3D CRITICAL_DATA;
+			else if (strcmp(args[0].from, "SETXATTR_CHECK") =3D=3D 0)
+				entry->func =3D SETXATTR_CHECK;
 			else
 				result =3D -EINVAL;
 			if (!result)
--=20
2.31.1

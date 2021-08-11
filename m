Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981F83E8F97
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 13:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhHKLlQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 07:41:16 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com ([40.107.21.118]:48096
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237329AbhHKLlP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 07:41:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqeszoubc8SScdAO0swz8RO2ucoqVm03Uo0v/UPLHDRyV/j9gZPrtSEUo/gi5QCyXh7ggrK47BajOMrgF/QiMmVMEqZvx3C/zBseIRgczj41MZgwGF2CUHz7fa7pGCIk8XTFHrQolGRt1q2ZWgrO6gQHgn8HQr9fcowlX/9WJxDWod9t51Wmmod7A4KM569OfS3NI5FUAQ1eqD+mZFYWv2dx91QXok1lq7zyoIdoGL6x1z2eH8oANworek1gdpmW5YVJ6HMjU8SUUSWCaszfRiWDWQwBj4xT6lJYaCu2bq/1K9RV4pH+Sm++5DGrf9dQ4lpgwaSRxvjeAuLdubmTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0LZw0Hi/UynLOwEK9h4F5tn7N3l2J+lpdgVXoOSR7A=;
 b=bpGCA/LhtmuWk3nH25ZzpE+4eVgvFcYES3cvFoXm0WjiNgC57gM2SPnL9D6E01RBjtaEoVrmTzVD4QJFSeJv7MQ6WZdThz8IMiTurX0csLKQle3TU5IuGL24y+/zRWw3iyZwW9gMpnYKoLeTbNcr1XX3ujTBSpzrpATZINs2bZTMoDrJ62WgiG7Lo+1zl10wj6As47kti88+an6dHSY63y+zA3jzdK4SvsYPfb3JfwP3klHS6aBLJdtsgwq1m1lcKEJFYAWjD8PufkVg0qpKgmzksERZscYlMSadq6IbTm0wG23cQiHOjoZm7N9KDpvoOrXYv/Nq63+JgAjyLN6AyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0LZw0Hi/UynLOwEK9h4F5tn7N3l2J+lpdgVXoOSR7A=;
 b=4muxMkWLrY2hsYw+bh1OYIei7+9hM4CbravMG6TCarnIUexdwnhsm1Liee+C/mz/HR+h1VWK4Su0PXEpvmEQIqgsIDf5SM4yHhHFFUAGGAyfij5Xs5b8DpytMmLWGrS2rNJdXBAZfMndhyPJsA78aJu27FVL8eTvt5TZxJtimPM=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5105.eurprd09.prod.outlook.com
 (2603:10a6:20b:30a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 11:40:47 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 11:40:47 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v7 5/5] IMA: introduce a new policy option func=SETXATTR_CHECK
Thread-Topic: [PATCH v7 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Index: AQHXjqW6NJ4vY9L9DkKk5Zam0ToeFg==
Date:   Wed, 11 Aug 2021 11:40:47 +0000
Message-ID: <20210811114037.201887-6-simon.thoby@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
In-Reply-To: <20210811114037.201887-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99e671a9-a5cd-45da-69ff-08d95cbcdcde
x-ms-traffictypediagnostic: AM9PR09MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB510578B6AE758E545E299A9894F89@AM9PR09MB5105.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hoQFWlVKvPLooS6dlV7uh1PP2W5rDs/SL9IBC2xOhK7qPj0Xu4hv5dtjcQW+e1CJK9gSRaCtj3aMSRVWeEMKsZ6A++EpE9AU6rfh1LWgVFHa4lJnrsn4511ECq+IirLMlQknENhuWyD68VQTsYjdIJURujLPFq7JaiMJND0GAn7WHpSUovzEDDX/uQ1LkVc0S69Tfl0wB3VUkhQLi6AvX5HWRoUEsBe6vnYG8rMa1gSHKqx+etFGiVdMXTV6xds18/JTVsRvgrP7CXDF3o1FDjtKVbx+V24ohnloD1oj8pptFXjTDYyc4bwblD3NPwW4ZpXoIkwEfuA9qXIvXKOLBMWW/Hw8rDSnB5kcOuApef6IVvRq+HziEmoE+64XKFX9wRybzjbC7UHDridJXNOyBYXisKz8YcRzWH5Pezo1JypSsNcwWJQjDxfvY+jACTcMpr/p1FOp7lp4WOuZuL53SsYhL6c14zed9eCnVnY/EmuTjgggkFTq2rCfLBu2rV6beDQRu34TA5ldgFBwESznI/1SQUUY7ALdxpStQ2AJe6sMu84eFL67Pzn6qjELCSNfBQzxFPJYit6aAigS7TxGv0tzvDwsd2NM5B82ZXgU+h+se1SKYMv9dBSfF/t6AAUWi4RzYpaulXTKM6Nxuk1HaRNJDnvbY9/B7wGFCaKWH5h1jG0OVV9dAZUc5hnXkoj7t4Cd0adSrSJadLHNQrEAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(136003)(366004)(376002)(2616005)(5660300002)(36756003)(54906003)(76116006)(6512007)(186003)(316002)(8676002)(6636002)(6506007)(91956017)(64756008)(8936002)(66556008)(110136005)(66476007)(122000001)(4326008)(38100700002)(66446008)(66946007)(1076003)(2906002)(83380400001)(6486002)(38070700005)(71200400001)(478600001)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4DUV1swmNNkzvkkERXc7cTKboirpRlJG7UvhKWm9NNq9dRC5qgNU99k38r?=
 =?iso-8859-1?Q?3ChIAOOMFx4iMLWig8Ef3lPrJbfKKDClqTuNJdAUNpboCEYJj5hWJfJUu6?=
 =?iso-8859-1?Q?bPEI83tJnO0I5h4xN0m1hYWjF+UnxBO/+8Qx5pt2VoeNWyaYZeHI8YxR8h?=
 =?iso-8859-1?Q?+YZQn2A7N8BBCoUQqgFxJnnD/NIkSDZxKCgw0WR9tBmSmhffJig5pFh4HQ?=
 =?iso-8859-1?Q?y43Kd29ShJlkXBDL5A2XV8Kdrw8F/XZn0AP25bUP8mYhi8O3dLNTUMoCT+?=
 =?iso-8859-1?Q?s0ih5a4ovrSo/MFI0HR7KsBOSz0JmWAs10afSfwXNJ4VB26T57zOIDal+L?=
 =?iso-8859-1?Q?K6uRc+aNLfMRll6xWRCVbObjbSTzGhtRoxZ1n42ludp8UE1Hu2mzmDGnxy?=
 =?iso-8859-1?Q?lrIBCmHfwZa33cyPfOIN5GX80I3iiI6MkEeI5SawnIFslHKQoNGowJW/bb?=
 =?iso-8859-1?Q?D2LVvfIv/VBDFDb4/aO4eQClm1K2Ek2eMclZpJ31t2b+W/qKcn8J0HpE4z?=
 =?iso-8859-1?Q?FA2Ptc5Nyj6mxvIlYFHMdMx8qqGgKuHGwVhMQWfD0Hj9k9zo0badAh2hX2?=
 =?iso-8859-1?Q?87ctZ3GTRnynh0XiDcqO6UwBjMYdc7zkLuT7oPfojRJOxF8JVa58o7sqCa?=
 =?iso-8859-1?Q?KpQwooiP4lLsfvDpvvK8yAoR6oHTbA3znNjjMvOSR5OFvR/PxSA55ebbLP?=
 =?iso-8859-1?Q?C3F0Rsmi5qPL5baspQJansno0p15ysMgqfoF3sEU05dVBBa4jBgCX+hDt/?=
 =?iso-8859-1?Q?cHuCEyN0orlz6vr7t9jkE55kC1l9WY9lkdAm8Was1hYQ34xD/zKhSlFcgc?=
 =?iso-8859-1?Q?TCPRL6WJFUHJL+ducsxb/rtGw1H8yy/tkBrVtLF/NyM2V3I6rC3SaScDXX?=
 =?iso-8859-1?Q?fyONpYDihSQj4BNt9CnE+fV3/Yo7tFQfQDWZENGD62cPGP4LwUdU93XXqO?=
 =?iso-8859-1?Q?DBTBSg1ILDK5Iqjm77sIXpnHfMRSBd0syuN+8OsoY0wZc06NfI/Gq7crqF?=
 =?iso-8859-1?Q?3FxC0D6eOwY9iyO+sNYgedNYuw2b9NgsurSq0UeZvAsf6HVtrVj+34Q5AF?=
 =?iso-8859-1?Q?FSGBTzRjLw7bJ8qsPo8JOdxKKn458HF6edA4Ov356OeRJjKHN/quFcOcDM?=
 =?iso-8859-1?Q?IHKq+H5TUdJBilZvKexAqTCQY1DxBYJrtmPX7d4zPcGWUQrhRW+qOOEMjV?=
 =?iso-8859-1?Q?4DHiaYVX7r4kr/Uj92I3uRkLHbspDpgodjHGkqoZmUiF6TUDnvareskI4j?=
 =?iso-8859-1?Q?uYb764qfqk3lVwVuS0Pr99Xx2j7uHBD4gXowhhpi8iSqZTHp7dKoQFpRNl?=
 =?iso-8859-1?Q?USnmmgNaKHGvWB9i/Wpd9SHpZxwnPUGwwa1h+nrFlXtYlfOfe9xy1NDJPe?=
 =?iso-8859-1?Q?FP8g8CmtBF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e671a9-a5cd-45da-69ff-08d95cbcdcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:40:47.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzi/LJ7oHecls8q0VoBqeaxX9ufL7k2dN3ZZtSO2eeV/8UsVS6KA+Ly4d//0MzjJ6Bg+BhEKT1NXhKSe6RRfJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5105
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
Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
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

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD63D8EE0
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 15:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhG1NVa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 09:21:30 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com ([40.107.0.100]:63456
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233315AbhG1NVa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 09:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXbHJ/rwt1YYj4JJCYxRjhzm8Fmh4LuZA8S7NjOmIMqqBhayi0dNBIoj3779GS9V5dvAUxTpiG5gedBQNDe5kpz1USkxx+z2fZq6ll6bvnt85QC9Z+30RhuWlHzypfbdVaN6y25Btl5NXL8yc0uEAEtQbSzvzngySf5Lbzduqxm8kN4i0nLOBVfZJZMB+SvrC9atzcjrccHOpO0IsdB5m12FAfelvemG6pEendpgsJhY852/EQFrD6W72mSYpttSvzNIg2+Cl5hWblGcrtp/A7pGux3i7zGPGqT6Yg6p2Od3nL/9zlBiX9qWnUxuyE8YRDioEG7kTzhYpNGgU/oi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIEE0jIG2N9rZbiv1JHnnyTC38p4XV5eyMkAhIZHtGc=;
 b=hBOpPqqoyLs1IHwDEZcd2OWYQBoGIdlyanfz27vudPuJCnlPmSaDH2TUJCIbhaG0+PaXRQqfwAluiCTp6WlIAmL/oI8Fznnj5IoEMoHBQ9Blq+WsBIgQH1vvRosPB2JDClXkBx4xk0WRKdqs+sFpRQ2odGgq/AuF5bM6810L+L2bEXrIjASPdmpzMM1Ql9V4LVpQ2IFp6kiYn9mDrW3Sb1T/o49KIAmSEA6vzeKa6BE+07H78YzE/67B6bBmF2r9RzNdu0/ykn1H4KUAk6f6DIzKERH69V8wXNLh9S467VaRDdIk55G/zfJvhxBLsB5sBL2QMtPoMnhCDYkcqdGfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIEE0jIG2N9rZbiv1JHnnyTC38p4XV5eyMkAhIZHtGc=;
 b=kLmmIdv3r7DjqkazlGqr3ceiQTfp8g29sugjlA8Dq5SgTTRrRtx++P0nw/czEt17hxebGhTu+yVkWWG1LbvTND0TdHdeWW8t4aa/Ngq7cXjk/MWQJzlWz9xKiV0yaXq1m4cPdAd+z/1bKd+04OVT0qSR2Fahcb92VprsPDooOWM=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3361.eurprd09.prod.outlook.com
 (2603:10a6:208:170::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 13:21:25 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 13:21:25 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v5 5/5] IMA: introduce a new policy option func=SETXATTR_CHECK
Thread-Topic: [PATCH v5 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Index: AQHXg7N3E9MODKwTS0SH7kSeFFCcAQ==
Date:   Wed, 28 Jul 2021 13:21:25 +0000
Message-ID: <20210728132112.258606-6-simon.thoby@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
In-Reply-To: <20210728132112.258606-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5b92824-e831-4bbd-7744-08d951ca99ed
x-ms-traffictypediagnostic: AM0PR09MB3361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB3361232BD1716FB868E28C0C94EA9@AM0PR09MB3361.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iYvGZg97po1cwXZ74Pees7p/wJBg5XC1zjVrGm0Rw7G+BnFTTghQfaaZELQ93d/2xbfisXhIUOEWNAjZ/JqfiElCmU3WGzFLoC3DpqEyvguFBtYmPHVcwy56e+Z75jU8fcYR7xIbbdYgUa4h/icc1nEfun37TDLA5M2Jnlo6jiLYcbHzgG0MkqcZQGogOzTNxzj1LmMEPoAAxm8TEl/JVEa85e+ts79PzDWfhf1E249zlT04300i13Bh9as/n8botOKqkdP5612rdmbJGvLBeU7WJ00vj/QZn+SxO5WxfdWp3ApmvBsTvo7g0dPBCILRrcNMD6N9GCcb+JKTGHoJpToWEm7EJMOsk7rwIDlCPYyl5WlVTio4Fwbu1lu2UgILLKnUW8axh/JUpWQtnHt6tXL4fN2o+ZAtwuJYAo+GVjnujt1fTlL6fGwdZir0itzns6LaJfNF4eC5RZ9QTw+wYnzg962YZWSZe1aNcjv418T/VCy+tDPi3y9jALzkdlKuSZq+6lCZM2iNkrYmQxVo7uD0TEH/V77wV8KWibbCup0OIGDcEqR6GxfPDtH+cpIfEyrfX40Iiwsnu69ciPZ+4CuBYBg9hYd5twQaJMIBz8CXOCZLzfadM1nZFJUHkxD/NjL9pektxZ3gZMFxfcnvQ++CE1Zdp9GpP6KbXW6EZbqMlCmKxuaALlLckuVfPaH9J66acQQtJGCgubFd4MrAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(8676002)(6512007)(8936002)(6486002)(110136005)(76116006)(186003)(71200400001)(66446008)(26005)(91956017)(83380400001)(6506007)(64756008)(478600001)(66946007)(66476007)(66556008)(38100700002)(316002)(122000001)(86362001)(1076003)(4326008)(2906002)(5660300002)(6636002)(107886003)(38070700005)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xNu4rh0R7mZv4J5oe/dm91tTYgUHpDog0wwzhcNXTD+qV9oPoNojp+GKQA?=
 =?iso-8859-1?Q?P7+bKST+mFbx1bDJbDYOk2HEIs1/V8ZTxaEoHaRYTj8I2fuwAtMpiO04NN?=
 =?iso-8859-1?Q?4rkqYkE1mn/igHBqAsrWCTlrgNhp14Iv5dz4X9uwqKP23FbQJK+0JEB2+y?=
 =?iso-8859-1?Q?IIihY+MFNN23OxNR9Q9uPq8PLcJD6LPt+NuXpom7n/3l4R015im4Bfw7Jx?=
 =?iso-8859-1?Q?CrktDIDG9Hs8/ksowPG3vRaNFzcY3QIPxEPGChQm2SeYsAPYhgVGFDnM3X?=
 =?iso-8859-1?Q?GvpL21DOAhi1S4FSbUnRJQF5QaBfB+4+1+muV4lZP8ig6f1mNZpyRHm+5B?=
 =?iso-8859-1?Q?fDCFyd0MVpMQHyLzlcl7xZi04RS045OfBT6hlwrbeZvy2hjtD2ezaAl4EB?=
 =?iso-8859-1?Q?Unp9850u3fNmvtRfp0Fz31bLCEIC3Y0OAH2A9deALbmRPmUJr/Nd3uiGQE?=
 =?iso-8859-1?Q?gIlSQnccjWuOMRqDVVrxkT+PD0qCTuLP8ayvFdIB06HpTQsfBEG23ggrZX?=
 =?iso-8859-1?Q?Sn+ULfLNJ2R62Cgx3urhVWhKETOYLi8+8dXtgj5FICZN/xDyw/H9CuMyqM?=
 =?iso-8859-1?Q?WNszbUFYV5eOZT8r98fO3jYQ3+sohmsj/vRChdTzRSzKnWQ2aXxIUQINNS?=
 =?iso-8859-1?Q?5L6k1BDbiwOs5XcXiPAPSMOMIdAryW2Ca6xYCKP8Jw/hR1eAa2CCCAYZUu?=
 =?iso-8859-1?Q?az7KtNAcUtDDOXMYG7Irsx7C7GcKxwmig7pQ+mPyUU9Ko87V5+jGCI83ev?=
 =?iso-8859-1?Q?BEI0T0VrmpcNQS3KpqgS5e+Q2dn8orYjE4lyb2xXmLewnI+4Xk6eM60Y7T?=
 =?iso-8859-1?Q?vYMTdSHJHVqhyMAxN5Yep9elCMk52kzgoqw7QT9YswCx2xQy4WUzVsCz5N?=
 =?iso-8859-1?Q?3cuZh1+13tg1UlU7pbvo2Up+hOLAU01U6PMMnRqjw1LSVuuFgymTQAureE?=
 =?iso-8859-1?Q?DTy5EOx7XZz1jH6c8gaLnObbQ0jC8ceklUT28KYijmdLPWuJ2b2KFzJ7aL?=
 =?iso-8859-1?Q?hAvwk5OQ46xBtCoWIo58CwhvLKAndTDsXpww07t/sd/133cPb4StWLzzFZ?=
 =?iso-8859-1?Q?zpXzJ2UWqhICJcC2mo2EI56StY2tGMtD/PZlBa82jjejQunIRGKmdw279S?=
 =?iso-8859-1?Q?NfvL985ji/ghC+VMdCvwWiccjN9MS2I7omlk+FjU+8TIT2WjjWkalYRS4G?=
 =?iso-8859-1?Q?V7RqSoE6Pc8NFgb9LOV800ig5et5ogaMZvHorr/K0IWrSM72QY5S0zNBB1?=
 =?iso-8859-1?Q?IeTHnwZfJ7mnIkkUO5E4fMt7cWUuFkIUjBOpMeUIl61n9tyndPv/Flh69W?=
 =?iso-8859-1?Q?p7R9MniEdN6ppnhCR4FCslCWx5oto6mT3GGGy82DDbBes/CpWlBlCERE9s?=
 =?iso-8859-1?Q?JiOV+qQvQG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b92824-e831-4bbd-7744-08d951ca99ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 13:21:25.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8m8WgijTwClqYDNeyX+Mc3Z+CqV8Oj2AQ4ZuAvoyrNTVVe2dbjD6Nik85vL5I5JzvzIVPEfDlo6KmzCtiuCEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3361
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
	appraise func=3DSETXATTR_CHECK appraise_hash=3Dsha256,sha384,sha512
only values corresponding to one of these three digest algorithms
will be accepted for writing the security.ima xattr.
Attempting to write the attribute using another algorithm (or "free-form"
data) will be denied with an audit log message.
In the absence of such a policy rule, the default is still to only
accept hash algorithms built in the kernel (with all the limitations
that entails).

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 Documentation/ABI/testing/ima_policy  |  9 ++++-
 security/integrity/ima/ima.h          |  4 ++
 security/integrity/ima/ima_appraise.c | 31 ++++++++++++---
 security/integrity/ima/ima_policy.c   | 57 +++++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testi=
ng/ima_policy
index aeb622698047..537be0e1720e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -30,9 +30,10 @@ Description:
 				[appraise_flag=3D] [appraise_hash=3D] [keyrings=3D]
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
+			appraise func=3DSETXATTR_CHECK appraise_hash=3Dsha256,sha384,sha512
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7ef1b214d358..aeb3bf30c0f9 100644
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
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index 12d406b5ab35..c4a43c84da5f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -596,13 +596,33 @@ static int validate_hash_algo(struct dentry *dentry,
 {
 	char *path =3D NULL, *pathbuf =3D NULL;
 	enum hash_algo xattr_hash_algo;
+	const char *errmsg =3D "unavailable-hash-algorithm";
+	unsigned int allowed_hashes;
=20
 	xattr_hash_algo =3D ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_=
value,
 					    xattr_value_len);
=20
-	if (likely(xattr_hash_algo =3D=3D ima_hash_algo ||
-		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
-		return 0;
+	allowed_hashes =3D atomic_read(&ima_setxattr_allowed_hash_algorithms);
+
+	if (allowed_hashes) {
+		/* success if the algorithm is whitelisted in the ima policy */
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
 	if (pathbuf) {
@@ -610,11 +630,10 @@ static int validate_hash_algo(struct dentry *dentry,
=20
 		/*
 		 * disallow xattr writes with algorithms disabled in the
-		 * kernel configuration
+		 * kernel configuration or denied by policy
 		 */
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
-				    path, "collect_data",
-				    "unavailable-hash-algorithm",
+				    path, "collect_data", errmsg,
 				    -EACCES, 0);
=20
 		kfree(pathbuf);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index f944c3e7f340..4e2410b826e2 100644
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
@@ -903,6 +905,8 @@ void __init ima_init_policy(void)
 			  ARRAY_SIZE(critical_data_rules),
 			  IMA_DEFAULT_POLICY);
=20
+	atomic_xchg(&ima_setxattr_allowed_hash_algorithms, 0);
+
 	ima_update_policy_flag();
 }
=20
@@ -914,6 +918,42 @@ int ima_check_policy(void)
 	return 0;
 }
=20
+/** update_allowed_hash_algorithms - update the hash algorithms allowed
+ * for setxattr writes
+ *
+ * Update the atomic variable holding the set of allowed hash algorithms
+ * that can be used to update the security.ima xattr of a file.
+ *
+ * Context: called when updating the IMA policy.
+ *
+ * SETXATTR_CHECK rules do not implement a full policy check because of
+ * the performance impact performing rules checking on setxattr() would
+ * have. The consequence is that only one SETXATTR_CHECK can be active at
+ * a time.
+ */
+static void update_allowed_hash_algorithms(void)
+{
+	struct ima_rule_entry *entry;
+
+	/*
+	 * We scan in reverse order because only the last entry with the
+	 * 'func=3DSETXATTR_CHECK' apply: this allows runtime upgrades of the
+	 * digest algorithm policy, unlike the other IMA rules that are
+	 * usually append-only. Old rules will still be present in the
+	 * ruleset, but inactive.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_reverse(entry, ima_rules, list) {
+		if (entry->func !=3D SETXATTR_CHECK)
+			continue;
+
+		atomic_xchg(&ima_setxattr_allowed_hash_algorithms,
+			    entry->allowed_hashes);
+		break;
+	}
+	rcu_read_unlock();
+}
+
 /**
  * ima_update_policy - update default_rules with new measure rules
  *
@@ -931,6 +971,7 @@ void ima_update_policy(void)
=20
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
=20
+
 	if (ima_rules !=3D policy) {
 		ima_policy_flag =3D 0;
 		ima_rules =3D policy;
@@ -944,6 +985,7 @@ void ima_update_policy(void)
 		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
+	update_allowed_hash_algorithms();
=20
 	/* Custom IMA policy has been loaded */
 	ima_process_queued_keys();
@@ -1176,6 +1218,19 @@ static bool ima_validate_rule(struct ima_rule_entry =
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
+		/*
+		 * full policies are not supported, they would have too
+		 * much of a performance impact
+		 */
+		if (entry->flags & ~(IMA_FUNC | IMA_VALIDATE_HASH))
+			return false;
+
 		break;
 	default:
 		return false;
@@ -1332,6 +1387,8 @@ static int ima_parse_rule(char *rule, struct ima_rule=
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

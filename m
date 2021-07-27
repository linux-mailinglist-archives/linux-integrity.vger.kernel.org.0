Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC63D7B03
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhG0Qdq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 12:33:46 -0400
Received: from mail-eopbgr150132.outbound.protection.outlook.com ([40.107.15.132]:37894
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhG0Qdo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 12:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdrRa9BYU43RhQQ9nQeUn1fQla5YlngfFlb6uH6bkFcsiTHg4+6KWmAS0+ZBCw3HtwOo5kQ8LDJPWkdxJmApI1/VWrE13ZOpBibMr5Pixly0md3CtzEbnZSqzvnWsTmP3IQecHN2+qlawOgqGRwbgQwoj1dUVQQ3/Zalkfx0SVkDQaUdKxv26jX3SUPAGVhwDWCO5a4RlpH/WwxiE3CJo9NLT4vqFat6MHFMgSNtaPu7bp/8k8qJAvRild/hew7p+JMO38kDGbfOQOkdMDPPaPJWWRUi2AWKdlsZFUR6NANIX9MKf9zFdBwVk6QcZyCllHj6Q/3tLCgXpRikqClhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp7C6+kBZm5WMvvdlyu0+d4XTfHpsF7AuqTlII0lqDQ=;
 b=O1yu6lIf9ZMBueBP9duI8FHq0oNio0DZ2pDEg8Y3bsLLftkLGVMBRHzla6K+0bxa10XY3zU2UuLDGZdOoAoHM41C6U5/fVGPYLf3U+tabS220+ZctzUVWtxUFGKi6fjZepfd+KoI0rY/1mqXhAzAfqshIqJ26csxaYkVxdDJxWgwjvBYYpcfLFCuj8YmQ0AlMbJjqSAjnmBwv+DVqeL6iPByHsW33J9apcq2n6mKtlkpuPzoTj5tooI6caHhLB4cdplg94hyEjrmTtyFUCyMcwjeZt6mK+awrDULdk/L657tQ9nDmJGnaAwx5ifTABKvcvaEnnUiPwgHxvriqeXccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp7C6+kBZm5WMvvdlyu0+d4XTfHpsF7AuqTlII0lqDQ=;
 b=Mrx+uYtO5m+y8YGcDR3ez+X+UgEZWi7fWExwdSfS9sAFapTIjfQ7ph8W6X85jt4UfaquV2DU/aHJiuDDidHtoi4noV1OnTJ+dJjnQHawOBxrrDSrda1Hrzwp12l19JQiZY95Cyxrfyp4OJnB21dBhNZen9evvnImL+7XX2Ffdho=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4243.eurprd09.prod.outlook.com
 (2603:10a6:208:182::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 16:33:40 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 16:33:40 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v4 5/5] IMA: introduce a new policy option func=SETXATTR_CHECK
Thread-Topic: [PATCH v4 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Index: AQHXgwUlkMhVDaMJN0KxxpespO41cA==
Date:   Tue, 27 Jul 2021 16:33:36 +0000
Message-ID: <20210727163330.790010-6-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727163330.790010-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9020f252-3b8e-4f2d-fb6d-08d9511c4a9f
x-ms-traffictypediagnostic: AM0PR09MB4243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4243D285F23E823F27CF3D1C94E99@AM0PR09MB4243.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y9iAYD71bkDg72fSRlcBLAxCnRN4rVgP2rTySzsujlzp1VhbT9JXLmZEglZzKiPpo1cbghHm9poCENrQb1WEX4XLpHKK0xX3zhvUXi1ppd9ZiaiZW/fYM2uF3F4XA3YLjpaOpiyVOFR/+SiTAblDy9L9Puqn4oVZEW1m8PQJHoIrNaFjUiOnVs2z2QGsxqwiNXQBP9CWK9edu0mgYmnVmS/8fnc/ozbjGH43wTtlSpi9OvL6nG1SfTFhzizx8aouBlseHtFzl8n1bdAAh+pswNJ7U73TM4KF3Y9n341GcMaDW54xBeWoTYiayF4l80c9gUc91X4FMcwQrNrs+CEE212byiVEP4zQUb5ir996QozVq2jM58ExIwGMFqiwosbPiR8F7myaGJY7iwZROAdhNpmsmmoq4UjGi5DPX89LQY1ohsn0fW984Lug+JC0ofbEvo4KMg/22TgoOnBIVHlO8+vYbVec5HCDcI3rZ5ThqiKv19av7nB8V83dGRr5lIt6dAsMBf0kTTUZSQ3P5+DloYyZWzD9iIZhJRhkTH4hqhrUVtuJMQNaDVYle5oVTwa8jhEoqKkyHUHj0VsdFImrvygQJgLK14J5gZab5oLDFBWZiNv7pe4y2EYXuir4usChYxIjtXtSzrV5FSgwEAgCW+5/50I1jKu4FRNuTZJVFYNxiwAo0EQ2vq4BvqR4fASS91N7mDdwlB4tvMYUqkzxRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(396003)(346002)(136003)(66446008)(122000001)(66946007)(6666004)(76116006)(36756003)(91956017)(2906002)(38100700002)(26005)(2616005)(186003)(6486002)(86362001)(6506007)(110136005)(4326008)(478600001)(64756008)(66556008)(66476007)(6512007)(71200400001)(1076003)(316002)(5660300002)(6636002)(83380400001)(8936002)(8676002)(107886003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iV8kAnez0cos/k4lGpg3woLqutsRrQQqeDAAdtkmrAvba7X5OaZr9bn09M?=
 =?iso-8859-1?Q?I9OsMnIFfLQueY9qK+qESSTz/IlWQjaaOSuH2Ey9pERhID1u1NqM/iwqGK?=
 =?iso-8859-1?Q?7THhX2N8ott9rsnrWZw6A40/dsi8DtxoEBvulHzEzkHJVN8wZFPDsDtZ9o?=
 =?iso-8859-1?Q?+LVhPEPQf2uUlvVpnFg9w7Jj8AXI2ZWwTNjEWolsUO/RLPzfBWP8P7HKMO?=
 =?iso-8859-1?Q?UU28tFgXFjIjmPlYgOktQR6MAHTHxgKPRRGWszjiRAkgovzdL9Xx82Bzy6?=
 =?iso-8859-1?Q?0vO+268BsfeeQN4OHSVRyIbXCIebnTuuPwJi0D7HVnJWYCEY3PLwMNxqv8?=
 =?iso-8859-1?Q?FWxuggqhbguzNTx0zJTdSpFtaJFoUc84XZh1mEJNIMW+AtredZVh/kcBwB?=
 =?iso-8859-1?Q?7NciFkebtpHz1m20g+13gRN9PS6wyUglurVGEbIDK1Yot0VnLJ8BjK1Mk+?=
 =?iso-8859-1?Q?sqWskdXJGZSHnTXA+ptXp15/aoIJ6zMnGOtYidBXKjXKaSWNRW+1v/iGkh?=
 =?iso-8859-1?Q?WrJmrZclCjrou1DQKK2y8jQULRdYcFIE1MUoZGzj9SW82eUvja1p6AKuwT?=
 =?iso-8859-1?Q?1n39L6lPIos3JIMcm74e65OJzP193C2I9RvacvlF3ZUG+nMPfUi4tFfMO5?=
 =?iso-8859-1?Q?by7QNAIiCemRwmog6Qw/Q8fqir1DK0YNZxwYwJKAnBzBDDk73mVT6cYuIL?=
 =?iso-8859-1?Q?Z2amNN5lOp6dGozfBMqNxq7HGJ9VdrG4kkqluiWtUjnEcBIUvdPKgtESy/?=
 =?iso-8859-1?Q?5VQJscc+Ayb5buHZ+xhTGcNzx55ODRX5JZeKhFfNK9lLDwKa7Jje2BBPGc?=
 =?iso-8859-1?Q?XHMYR6+vwwvC01+j/hPIRSa2fddIKw3/yzXK5J59q/LZKqfge371+B+Gmp?=
 =?iso-8859-1?Q?MH7Z1MX+ZtFn1GoVmBfO+faTBem4x80V8gA0MtBsvREpW6VqYO+XQJmZuY?=
 =?iso-8859-1?Q?TJFSzt53B7Ilzz9jOFVtmkgZNBM7WQipdXQMUPneWKxqeUcKIF52U5/XBq?=
 =?iso-8859-1?Q?8EGEI3tyxN1ZAemYZPBQNEXxqKgwAXdOGKVqm3x/wMfn7TNrf5W+jTS41w?=
 =?iso-8859-1?Q?s1WRVBgKcywQRIIBEYAs4pKBrwFJlCgmDm+L28CoqALiVqqfjxMLhfAdzi?=
 =?iso-8859-1?Q?qVS8LXNOD42V/9W5cUF43dukbZuhHiZReoe7vdczYsly94DZ52q92nNyLz?=
 =?iso-8859-1?Q?XsScbrx8275V5bXqNZpFcV/m5dMoTfyWNo+Jcdi9F5JZgm8g4bl5WUiAAJ?=
 =?iso-8859-1?Q?t147RjvkD+AdB1P+37LZYyafAsJNlabRlUrVlJinEP1dZVEqKcSHEaA2vw?=
 =?iso-8859-1?Q?XPU75CnU74fQ+wwo0I+Hp8qckJCrqeW+Jqe4arnZ7hs8Negq56lMWEN50p?=
 =?iso-8859-1?Q?RkrYWRwNrpwvt/ZCz24T8vx+WKg79yxw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9020f252-3b8e-4f2d-fb6d-08d9511c4a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:33:36.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: br46oYsT0l7wXaarumG+vgVMSXu0oZ5aX/DytI+nFeAxW78c+PsI4X8jPkkcs98xDlSt/6IWaweaAPTAX5r6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4243
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

On policy update, the latest SETXATTR_CHECK rule is the only one
that apply, and other SETXATTR_CHECK rules are deleted.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 Documentation/ABI/testing/ima_policy  |  9 +++-
 security/integrity/ima/ima.h          |  4 ++
 security/integrity/ima/ima_appraise.c | 33 ++++++++++--
 security/integrity/ima/ima_policy.c   | 75 +++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 6 deletions(-)

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
index f751410930a5..b938a053366c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -596,23 +596,46 @@ int ima_setxattr_validate_hash_alg(struct dentry *den=
try,
 {
 	int res =3D -EACCES;
 	char *path =3D NULL, *pathbuf =3D NULL;
+	const char *errmsg =3D "unavailable-hash-algorithm";
 	enum hash_algo dentry_hash;
+	unsigned int allowed_hashes;
=20
 	dentry_hash =3D ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_valu=
e,
 				     xattr_value_len);
=20
-	if (likely(dentry_hash =3D=3D ima_hash_algo
-	    || crypto_has_alg(hash_algo_name[dentry_hash], 0, 0)))
-		return 0;
+	allowed_hashes =3D atomic_read(&ima_setxattr_allowed_hash_algorithms);
+
+	if (allowed_hashes) {
+		/* success if the algorithm is whitelisted in the ima policy */
+		if (allowed_hashes & (1U << dentry_hash))
+			return 0;
+
+		/*
+		 * We use a different audit message when the hash algorithm
+		 * is denied by a policy rule, instead of not being built
+		 * in the kernel image
+		 */
+		errmsg =3D "denied-hash-algorithm";
+	} else {
+		if (likely(dentry_hash =3D=3D ima_hash_algo))
+			return 0;
+
+		/* allow any xattr using an algorithm built in the kernel */
+		if (crypto_has_alg(hash_algo_name[dentry_hash], 0, 0))
+			return 0;
+	}
=20
 	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
 	/* no memory available ? no file path for you */
 	if (pathbuf)
 		path =3D dentry_path(dentry, pathbuf, PATH_MAX);
=20
-	/* disallow xattr writes with algorithms not built in the kernel */
+	/*
+	 * disallow xattr writes with algorithms not built in the kernel or
+	 * denied by policy
+	 */
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
-		path, "collect_data", "unavailable-hash-algorithm", res, 0);
+		path, "collect_data", errmsg, res, 0);
=20
 	kfree(pathbuf);
=20
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index aadd95753229..a74b78e1746e 100644
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
@@ -87,6 +89,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	struct rcu_head rcu;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrin=
gs */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label=
 */
 	struct ima_template_desc *template;
@@ -368,6 +371,13 @@ static void ima_free_rule(struct ima_rule_entry *entry=
)
 	kfree(entry);
 }
=20
+static void ima_free_rule_rcu(struct rcu_head *rcu)
+{
+	struct ima_rule_entry *entry =3D container_of(rcu, struct ima_rule_entry,=
 rcu);
+
+	ima_free_rule(entry);
+}
+
 static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *ent=
ry)
 {
 	struct ima_rule_entry *nentry;
@@ -903,6 +913,8 @@ void __init ima_init_policy(void)
 			  ARRAY_SIZE(critical_data_rules),
 			  IMA_DEFAULT_POLICY);
=20
+	atomic_xchg(&ima_setxattr_allowed_hash_algorithms, 0);
+
 	ima_update_policy_flag();
 }
=20
@@ -914,6 +926,52 @@ int ima_check_policy(void)
 	return 0;
 }
=20
+/** ima_update_setxattr_allowed_hash_algorithms - cleanup SETXATTR_CHECK r=
ules
+ * in the new ruleset
+ * @policy: the list of ima_rules_entry to clean
+ *
+ * Context: called when updating the IMA policy. Delete non-applicable
+ * rules with 'func' set to SETXATTR_CHECK and update the atomic variable
+ * to hold the list of allowed hash algorithms for the security.ima xattr.
+ *
+ * SETXATTR_CHECK rules do not implement a full policy check because of
+ * the performance impact performing rules checking on setxattr() would
+ * have. The consequence is that only one SETXATTR_CHECK can be active at
+ * a time. To prevent confusion, on policy updates, if a new SETXATTR_CHEC=
K
+ * is defined, other SETXATTR_CHECK rules are remove from the ruleset.
+ */
+void ima_update_setxattr_allowed_hash_algorithms(struct list_head *policy)
+{
+	struct ima_rule_entry *entry, *tmp;
+	bool setxattr_check_already_defined =3D false;
+
+	rcu_read_lock();
+	list_for_each_entry_safe_reverse(entry, tmp, policy, list) {
+		if (entry->func !=3D SETXATTR_CHECK)
+			continue;
+
+		if (setxattr_check_already_defined) {
+			/*
+			 * delete old SETXATTR_CHECK entries when a newer
+			 * one already exists
+			 */
+			list_del_rcu(&entry->list);
+			call_rcu(&entry->rcu, ima_free_rule_rcu);
+		} else {
+			/*
+			 * only the last entry with the SETXATTR_CHECK func
+			 * apply: this allows runtime upgrades of the
+			 * digest algorithm policy, unlike the other IMA
+			 * rules
+			 */
+			atomic_xchg(&ima_setxattr_allowed_hash_algorithms,
+				    entry->allowed_hashes);
+			setxattr_check_already_defined =3D true;
+		}
+	}
+	rcu_read_unlock();
+}
+
 /**
  * ima_update_policy - update default_rules with new measure rules
  *
@@ -931,6 +989,8 @@ void ima_update_policy(void)
=20
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
=20
+	ima_update_setxattr_allowed_hash_algorithms(policy);
+
 	if (ima_rules !=3D policy) {
 		ima_policy_flag =3D 0;
 		ima_rules =3D policy;
@@ -1176,6 +1236,19 @@ static bool ima_validate_rule(struct ima_rule_entry =
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
@@ -1333,6 +1406,8 @@ static int ima_parse_rule(char *rule, struct ima_rule=
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

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED7F3DFDDB
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhHDJUf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 05:20:35 -0400
Received: from mail-am6eur05on2111.outbound.protection.outlook.com ([40.107.22.111]:20289
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236980AbhHDJUb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 05:20:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPr9PTgxfYD5nTP9QLWfehsnMWZ7MrVHqQlbhILh+naSj/lSdT6Otv6XLtKKnqlZPZLNORCwT1ccgmTBvxJscAeQewcgW/pN6uZtYc/oX0nhgUfk3vIGdDaUp5y+UUGMtMxrkqjhyerEn8JZ00S/V8tYvPHxavhZruuIOh+leJS0MUPkSwXDPRy1+2XfIvvdcNvU8f0JGNizi1dxaRPPNUerYAI1X7A+JKdVs8dRfQDVgnpz4V0ODh9AU8FVkxoVUDPZii2s2EgERq58e9RVQyaAglK7t+b+2bJmerR4KetWxI4iFiq5paXZLcPz6l6J8zgYLZBYexkM+eVCmgxoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEjRE74kv/LcpvoI+exrxQUh8azQ7Ws1Osuwa6S+TBY=;
 b=Tsf0Hvt1OM5F4FGcJJCoSu7q9ZLb57JufM+2QIVi4eYK482nrn4iUdcBnLKH2heRA/Wfx2c+4RThrGp2++IaXE5HGr3Ocbn4BEFIb/uKQ2qxuKVC/Z4p6zimxE7zBf1V1cLIj+hn2XPWIpm+40EheUg7fu3jSh320c9xHiqxA65n0S9NAx4q4lBwCvgZlg80zFcmH1Mfk2NhLy9G8DIht93CLBRPyNWqGx476hpNY6ncg5xDfUgxZqL6EKuqnN3sUaKMjHaRbpGEcGzBWpE6YAfU0aEXPobPwDbq2j/9TqHQrENNqfZbsCv5yZnS4eImOK+p1TEyX+dcFltud5nagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEjRE74kv/LcpvoI+exrxQUh8azQ7Ws1Osuwa6S+TBY=;
 b=ElgBp1zggLE/WsUd+sY3tH7O7xtV/wgNCrknP5wD1KQ+r8fRjaw34ykgePFz1b3P0ifg6y4BWX4gbpTUGEzDij6Do7pp0NWO1hZNxxwKvYqETZ67SPnToHlcXbhahMMlaFNdy+3HuJ2uUF6uKnQm6DEW9S4hZ9xgJhHo4iM8NQ4=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4244.eurprd09.prod.outlook.com
 (2603:10a6:208:181::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 4 Aug
 2021 09:20:17 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:20:17 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v6 5/5] IMA: introduce a new policy option func=SETXATTR_CHECK
Thread-Topic: [PATCH v6 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Index: AQHXiRHwg3KXjPypcECarCs9Mtbrbw==
Date:   Wed, 4 Aug 2021 09:20:17 +0000
Message-ID: <20210804092010.350372-6-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
In-Reply-To: <20210804092010.350372-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 943f6553-c935-47f4-2fe4-08d957291341
x-ms-traffictypediagnostic: AM0PR09MB4244:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4244B2DEF5019799501BA20594F19@AM0PR09MB4244.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOAkBnvu6IoH0QWOc98dApq17UFlgxj+whWZB7jyAN06sGdYFkUM4FKIA96eVMupPCK4q8kKFwoienmBVlDCDk+oWW/etJhKPvPNbsF2ev0O68XzlF+bSQhtRVSUAB8eR5J4z8B00x93K0aQZXfnPiOGdAbY2f1A2fifV9Oz4RiEQQqF8PgyQ3wNwYOFvDgZ78kTGAS0ce+2MIs3BvRfoFwl5Sp4WITRyQktNUb77GnwvAhNTZIk9r6i4d3yM5Oes06JBN3Frh7rz0XQZWC9h7YI/5TW5RxyQ0rIrAI8KwcIhVmUQ66vF1r6srApyPAh0HS1imRc1WZQtZ/uYcEuptpAQfqvTYUipiQq3GT+bcWuiM3CaY7WRgXDSdF5yi4StNjb4l9lmchSLpnTPenK8U2HBEehtqqUVZPAMd3losJ+oXjjuGu5KiIWV66OTXOu0m1HGbQh71y6iYfB6kks46LHQ9EV7dKQVEr2n4iQKq8MC5RJsfaMYznd8ibb3v8MHGPfIT1HjjrlAFonU82FvhlOgdYYWJ6bs4KB5PIRbMAX4DeW4hE3KKET7aADWa2A9FAd14AG/5RtZeWw8U9E7OVqrT/zCJ25rNsEquDFSzGku3X+XNSDniQ0uUDzaAV9WtraNTY25fos1Qx1MTxhtabnmDOEFdgSriyEhQIJbnBnY79whnLiS75PKG4Ba1rVVLvifSLhY4nZk2s4Nx02xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39840400004)(366004)(86362001)(64756008)(6636002)(38100700002)(6486002)(71200400001)(478600001)(66446008)(110136005)(66556008)(107886003)(66946007)(66476007)(4326008)(38070700005)(316002)(36756003)(2906002)(122000001)(5660300002)(2616005)(186003)(8676002)(8936002)(91956017)(6512007)(76116006)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g49WDSFCnOLKW2yukfSWoyYMiXxcjVKHqZFnP0jwX5ZT4mCNN1c8KqYKy6?=
 =?iso-8859-1?Q?o1pvrO5otrfXkQYfcx9OGlj1weO1ADPRn7b361SA5JwWJWg61r5/FsmUed?=
 =?iso-8859-1?Q?ge05HY8QlOBEgzCFLugDZk/VlivAjimeHdAJs6B59EcGezFSINY57Fqbfx?=
 =?iso-8859-1?Q?iOSZRnWJ99XxpxFgZYSl661rb4QR8WuK3DcYwx3yk81pDvnGup6gnjxPsp?=
 =?iso-8859-1?Q?GRdjiaJtSpZj9Dox1Vv1e9pEvZSHTrxdrj5bi/q5GQD1Hv2NYbc/cKFzSM?=
 =?iso-8859-1?Q?/QHyVO2jOIIsx7UdISfdR+DCfzg+m3DRuYgGYgr7+WWmTbu82Ik9vry1qT?=
 =?iso-8859-1?Q?ra3QT5VjKhbT7A5ZYmH3NBU+vTWTFnHAWZo7TbU2sy/j/labUgVetx+zCS?=
 =?iso-8859-1?Q?IHjnkvKPLlex49i3PZx9lEi0fAfOvzKNzlojor3lTMw+sMm4b0X9b2TTNA?=
 =?iso-8859-1?Q?PN9NpnWqetJzahkfQJHKuVbIb9uTg8fiYd8+g6d209HgU/4mR+j9ZnkbXS?=
 =?iso-8859-1?Q?plnKHqthwNDX3x27hiGhuiNLNY4aaNxfzmmHhImTWS1rK+9mtWtFGjoa7D?=
 =?iso-8859-1?Q?4bh3yOGt13fGlL2xStVpfXvt1FoLG2o5rJKB+NlxN5qdw1pO/vAdC/xnJc?=
 =?iso-8859-1?Q?YeVN7sm7VLT9/AqOiniAxxWsEvV0twsmNIxE6CXsrx/9K9RzK+KtIFau71?=
 =?iso-8859-1?Q?8G5BfE5QgzENF5xFCUvzxeLZaQOlirw/2JyVM1ajvdOaThCUvlaIBMchxe?=
 =?iso-8859-1?Q?fC5aCDWw84D094winDbpFS2HCoSj1wkYn5PclEr7Mi2hJctbC2bUpeioo/?=
 =?iso-8859-1?Q?DYlMha/9OjJ6SRg/QF5Zi3C8Yb6+l5nEIN/zjm50V8EgWOGmmxDW99kGfp?=
 =?iso-8859-1?Q?TeF8IwYOwXhA4NIOrzxQq4AUlphkW2Pzi2zngiNmRomfQWAL/6zebvCuAP?=
 =?iso-8859-1?Q?9LP8SWKRKKbPwgPeOp0EZ+iwq1R3pSwodBWbLhYBhKcu3rOdzBS+Qo+b5A?=
 =?iso-8859-1?Q?BydU7WUM5tTQCZluHf/Bcl9AhJJKKLyHiaHa/96M5uAalmlHNCjN/UHoeT?=
 =?iso-8859-1?Q?hO2WyWFuFp0E9QaF/uSdCcQhCIBkkvIdTg/76k3CC0vdlRUJ4GF1c2tBxj?=
 =?iso-8859-1?Q?tR6vHmPmzoFEHXV27ybbqpjfY7oVsmJFJ/oPK9P63wNrjz2I4t2Y9gf1pj?=
 =?iso-8859-1?Q?KftBTylKaZcYhQ0P5sO5mniaywnTF+NfLuy2GzbLnr4JrLv0joQiIZGq4s?=
 =?iso-8859-1?Q?4mkU43d6AnrXt4OqeUxtr4PntYfcB3bgsWZcg65DSf9oEtEjP5XaZ2MD8b?=
 =?iso-8859-1?Q?YsDFKxq1m5M0c+WPlYqX1WsR2KUvdJADTue3a6BkW3uGrfiw8IqfbiBkD7?=
 =?iso-8859-1?Q?ekWFrrs2yk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943f6553-c935-47f4-2fe4-08d957291341
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:20:17.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwlnGoJqokkT2vO3GBvRn9j/USbcOgCZzq4flapc4wLb4gDSm8Sj3sbBRTEVE3fbZsrSOJ+ElJjEeb17HEuCkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4244
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
 Documentation/ABI/testing/ima_policy  |  9 +++-
 security/integrity/ima/ima.h          |  6 ++-
 security/integrity/ima/ima_appraise.c | 29 ++++++++--
 security/integrity/ima/ima_main.c     |  2 +-
 security/integrity/ima/ima_policy.c   | 76 +++++++++++++++++++++++----
 5 files changed, 104 insertions(+), 18 deletions(-)

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
index 8db0238a0fd6..7f2aa875fd72 100644
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
 		     const char *func_data, unsigned int *allowed_hashes);
 void ima_init_policy(void);
 void ima_update_policy(void);
-void ima_update_policy_flag(void);
+void ima_update_policy_flags(void);
 ssize_t ima_parse_add_rule(char *);
 void ima_delete_rules(void);
 int ima_check_policy(void);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index 9aa0334b8e54..4949aabce36c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -597,12 +597,32 @@ static int validate_hash_algo(struct dentry *dentry,
 	int result =3D 0;
 	char *path =3D NULL, *pathbuf =3D NULL;
 	enum hash_algo xattr_hash_algo;
+	const char *errmsg =3D "unavailable-hash-algorithm";
+	unsigned int allowed_hashes;
=20
 	xattr_hash_algo =3D ima_get_hash_algo(xattr_value, xattr_value_len);
=20
-	if (likely(xattr_hash_algo =3D=3D ima_hash_algo ||
-		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
-		return result;
+	allowed_hashes =3D atomic_read(&ima_setxattr_allowed_hash_algorithms);
+
+	if (allowed_hashes) {
+		/* success if the algorithm is allowed in the ima policy */
+		if (allowed_hashes & (1U << xattr_hash_algo))
+			return result;
+
+		/*
+		 * We use a different audit message when the hash algorithm
+		 * is denied by a policy rule, instead of not being built
+		 * in the kernel image
+		 */
+		errmsg =3D "denied-hash-algorithm";
+	} else {
+		if (likely(xattr_hash_algo =3D=3D ima_hash_algo))
+			return result;
+
+		/* allow any xattr using an algorithm built in the kernel */
+		if (crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0))
+			return result;
+	}
=20
 	result =3D -EACCES;
=20
@@ -613,8 +633,7 @@ static int validate_hash_algo(struct dentry *dentry,
 	path =3D dentry_path(dentry, pathbuf, PATH_MAX);
=20
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
-			    "collect_data", "unavailable-hash-algorithm",
-			    result, 0);
+			    "collect_data", errmsg, result, 0);
=20
 	kfree(pathbuf);
=20
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index 205138e7016d..f6389f0ff81b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1052,7 +1052,7 @@ static int __init init_ima(void)
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
index 831ce0c690ec..c83f7c199610 100644
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
+				       0, entry->allowed_hashes);
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
+		/* SETXATTR_CHECK requires an appraise_hash parameter */
+		if (!(entry->flags & IMA_VALIDATE_HASH))
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

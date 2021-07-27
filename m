Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADC3D7309
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhG0KX5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 06:23:57 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:4837
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236103AbhG0KXu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 06:23:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj3ec3kfYpWvioxyH7afMVCukp5qmQwN6tPScH+W7Pm5viQfr6FfKKuqDca/DbelLXXyFadEJpPT3tMwxkh1vTJxTXH9XcQ1PuQqrqWBTutMSgS5djubUBN5Ylp376i80u2beg4g7xXNZSqexD4Gb2+C0DKjGJIZxjbb8KsHuZ/3AONmLzJezUB1DjAEUwXJfXv7JQInb/CZyxSElA9UCo4ai5izKI5QMXi2TXj3aHJ+sErnyt6uulBWPVEezktwb068LQnw3OvgTVYD26p+P06VGYw5BfjlVqAfKzw8BfZzSYZngPMf+tgL+MPFm3HbSY3j6qf3ROFGywgrVzhHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb5Lr/7cfx+AP9DdPMLK6l9KLrVEVce+h2VOrJNatNY=;
 b=W18Hpuxk7q47lR18OBxhldmuaMJC4560ERPtYoRq/NNiOlmVV9zh5pF0PWwOK7aJkL5KJ9x0WmfE63ERADtrF2BHZZfxNKUSCQGu9OZoTz4s0g8lP6mcgEPW9pTyDGAtIxUj0+iIVcMtRDJ1y9QlOdJnalBAGMtSis2AA4WMkBs2FMVPlzezrGWsseYvxxDa6IEXUMgowVeL1RPLIVZFiJQ4gRaGV0voLmOcDDNzWPPs5fabllYvnCiK7/IsqAncZIrfv2sf1DSkYcy8vMfoBavThMKf01rVW3w5ILfgFjR3U9W2D8NISyJTQy7WYANsWr7CQWMr72XTcBAkwhwf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb5Lr/7cfx+AP9DdPMLK6l9KLrVEVce+h2VOrJNatNY=;
 b=jytj+UjWzLCwaXmjrfriwijaat8mpzn1otn5dmV/89dgPGhZLRVfaf50pHxASGe5+NF+IFh1ZMj6+YQ+VDb3QVMHDqkePEuKohyqq6MKyCgv4W12sKVf5TtwjutD8RwDrbWjbWGMbfjxlhoo8Lt0MMgl9la8ByDFW2SkGUkV73U=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3364.eurprd09.prod.outlook.com
 (2603:10a6:208:16c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 10:23:36 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 10:23:36 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v3 4/4] IMA: introduce a new policy option func=SETXATTR_CHECK
Thread-Topic: [PATCH v3 4/4] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Index: AQHXgtF17k7jwDE+9EK/EDwW15Vn9A==
Date:   Tue, 27 Jul 2021 10:23:36 +0000
Message-ID: <20210727102307.552052-5-simon.thoby@viveris.fr>
References: <20210727102307.552052-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727102307.552052-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e87fe24c-453d-46ec-58ba-08d950e8985b
x-ms-traffictypediagnostic: AM0PR09MB3364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB33643435EDF3A108DF8F521994E99@AM0PR09MB3364.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5Sf8JhbU3IDqPd/HsOus8fTYkD9SokcS+q7lbeDXTQoCV3xIXJ/HnFNC5JOZSnXAzs9IDHNpSvmDwfcViGIEbv8gEPyIDmzykvP2FKcodYnY4ybp7gK4nAG7lMXtwWIht2rsFQLVo9ABLtoMTPPJWzCWy98AbnDWoIfTyCezSwwvyVr4XU9sHfKBLjmkmZ+iJ7npXqhQsIogvHDXRsC/r5GckzMm32bG/VsT8RiVYXyNup+V1ehdgHf94gliln2qvO9ezlmDBgMYjQfekcH09h9ISWH8YYigzSijMPCnJiz+IUW4iuI5n7CYp+xaItTMwvhEoWC2LXhGBrgdt7QEN0j3PsQrWgljRJJkTYFlRXnGAUIxkMa1CM+Z2B1CPk2jgHoXmm24gCbY7E46fntDKV5k2IDSoAKdZTbmv+688rn9WeL3yBxoUBEL/aIFhV5QjLSS3TTDrFqaCNbf2XmMsXDkZBU5vHSpUh4k1a/QwXVAqAByXpqs13XftIUXQX5b72AoUcA59tuMmPgWYSdmiZWBdwupg53yS/xvH8bSAJ2XrzIETngQsaqZUjQSs8WJJSe86cavgWvXZta4xSn4a0lkK//ku9EIuka+vhAjf+aYnCsEgAdKuYLVspfubt9T5YEiSpFbwrylJS9UhpDwni87XMpq3dtjEgqkzCS4wJRZ8oJEPt7xc23VyGu6NAVTTxBUJObaYLbQEGnwR/s7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(6486002)(122000001)(2616005)(6512007)(6506007)(478600001)(8936002)(6636002)(66946007)(2906002)(316002)(91956017)(76116006)(107886003)(8676002)(186003)(66476007)(4326008)(64756008)(38100700002)(86362001)(5660300002)(110136005)(66556008)(66446008)(26005)(83380400001)(36756003)(71200400001)(1076003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BS2l/NYBczInW7PBcS9XJyYwY260l3PNsNAN1jH+EQ15fxCnkKd1v5lrHU?=
 =?iso-8859-1?Q?II+QJY6WEJfmqnTNEGzuYCHH5ImlmEDlbP6sTRW5pJfkRtEeDtoIB2Ip22?=
 =?iso-8859-1?Q?Qxj2GgQ7/gXBiRp8t8hzn3qk5E0dEtW+JdmuTdOCC7RXIHzDvt2zazCriu?=
 =?iso-8859-1?Q?148dNXuPbyVPF94PIxa3AcwuoYRIVJJUEFk1yaFHWJwPpFHozSqMVw2mvG?=
 =?iso-8859-1?Q?At3gLuETkLXsDkg91sk8q2bE5dpvEscOAqCpcsDd0H4ECa8vf7kXGlmTJ/?=
 =?iso-8859-1?Q?qZH/8UnF902kmKxWmzAgqDUeeZ+y1HuGYeSYC2yZJgp5Cltrgmbl5b3hIq?=
 =?iso-8859-1?Q?MSIXPtd6vpM7Io9CmxqZJbXLmcElQV5QMKs3894cXAtMJwNpyFqtEJV+Tu?=
 =?iso-8859-1?Q?ETIqcdG8up9wNaHyK29aFRPR0PuoF6AZOTgxSJM5MNN5MuMKMLN2OKecyI?=
 =?iso-8859-1?Q?LxTqskLrlXwM3eFsDyLCwDLL3SPRI6X103/UmSZw6UdlHREaA9am2y16Jk?=
 =?iso-8859-1?Q?CmAdmejoDmcniARHe1VJvsKN/XK/Utg+wHoznzhnx68oAioH2Rc1BivxrM?=
 =?iso-8859-1?Q?1R2V+pyRdJ2F8bov5tlxEbB4kHetzdcEtDlMkCbQs+QkPvjFpLJTHjt9GC?=
 =?iso-8859-1?Q?EJzfA79gmJeAbSoKeRs1F+hC6Orf1G92UtRwbo83+9r3eB5Zs6jvVOfe0h?=
 =?iso-8859-1?Q?85/vGMKEn+2Z66kWNzT5BNuQWYKgZC1tLVNdnp2KBUHA8K/NN3OzL7xfN8?=
 =?iso-8859-1?Q?+7bYO215fJy64uvF7AROl+91wIWNnPFTB3Gwshxc2HlcQcGpVOrhRHa02t?=
 =?iso-8859-1?Q?C1aS4laFaTaGBmRfAuwZ/QDEm18wZG3jCIFJ4BkZJlMPCG4qfp3nN3ck8d?=
 =?iso-8859-1?Q?pcSONrs+aNlcksCfJiENYlA1JmETFX7A4RNnQY7jHS6DHrScQsD37dss3k?=
 =?iso-8859-1?Q?J35CzxSQqu0StHwrg9DSns9P9tt8/iMmejXV8ICXG0tiGO4plVlTeaD4Kk?=
 =?iso-8859-1?Q?42SjIKyNfxI2vGrXn741GjTaSOVxwZ0dTcHxDF5lO0UvCz48NgzwTNMUpy?=
 =?iso-8859-1?Q?M1viPzEt065BSw06bW/2ZG0lKDg6ixMf/2FLIrCsyY0s3SveeB0RRqmAne?=
 =?iso-8859-1?Q?i0Bn45IwXabxM63eLeODNFf+uHwhe0iEqK6dk1MlSaisKE0leUmimcAlIM?=
 =?iso-8859-1?Q?GK++58Uink1VPgoC3aen5OvWVJ0cgQ5qC8B9R8GrGuGyx1akkxR3jnZRuv?=
 =?iso-8859-1?Q?6V8aOh+SppDXF4M3wlAxrtYdaJS+JZ2EejQ7ChkNK5x/wmfWFwnfi3vn3N?=
 =?iso-8859-1?Q?3byv/QGd6G9+FkaX4hL5YRH7B37u50deDbNhbi9fKpzuSxb4atvoWLCfrU?=
 =?iso-8859-1?Q?gVi8t+m9A1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87fe24c-453d-46ec-58ba-08d950e8985b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 10:23:36.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58ZolPrgeCB+Ct6vdpbx+4QQpa9BbVLsTsRH98I1Tl6PR2zXvo9/zzwrxQ/KoOoWd9vH1RKb2V2kBoED1O6nMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3364
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch defines a new value for the ima policy option 'func'.
That value restricts the hash algorithms accepted when writing the
security.ima xattr.

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
 security/integrity/ima/ima_appraise.c | 28 +++++++++---
 security/integrity/ima/ima_policy.c   | 63 +++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testi=
ng/ima_policy
index 365e4c91719e..c05a21007272 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -30,9 +30,10 @@ Description:
 				[appraise_flag=3D] [keyrings=3D] [appraise_hash=3D]
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
index 6d121819ae9e..81c4259261bf 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -590,14 +590,32 @@ int ima_setxattr_validate_hash_alg(struct dentry *den=
try,
 {
 	int res =3D -EACCES;
 	char *path =3D NULL, *pathbuf =3D NULL;
+	const char* errmsg =3D "unavailable-hash-algorithm";
 	enum hash_algo hash_alg =3D
 		ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_value,
 				  xattr_value_len);
+	unsigned int allowed_hashes =3D atomic_read(
+			&ima_setxattr_allowed_hash_algorithms);
=20
-	/* disallow xattr writes with algorithms not built in the kernel */
-	if (likely(hash_alg =3D=3D ima_hash_algo
-	    || crypto_has_alg(hash_algo_name[hash_alg], 0, 0)))
-		return 0;
+	if (allowed_hashes) {
+		/* success if the algorithm is whitelisted in the ima policy */
+		if (allowed_hashes & (1U << hash_alg))
+			return 0;
+
+		/*
+		 * We use a different audit message when the hash algorithm
+		 * is denied by a policy rule, instead of not being built
+		 * in the kernel image
+		 */
+		errmsg =3D "denied-hash-algorithm";
+	} else {
+		if (likely(hash_alg =3D=3D ima_hash_algo))
+			return 0;
+
+		/* allow any xattr using an algorithm built in the kernel */
+		if (crypto_has_alg(hash_algo_name[hash_alg], 0, 0))
+			return 0;
+	}
=20
 	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
 	/* no memory available ? no file path for you */
@@ -605,7 +623,7 @@ int ima_setxattr_validate_hash_alg(struct dentry *dentr=
y,
 		path =3D dentry_path(dentry, pathbuf, PATH_MAX);
=20
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
-		path, "collect_data", "unavailable-hash-algorithm", res, 0);
+		path, "collect_data", errmsg, res, 0);
=20
 	kfree(pathbuf);
=20
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index a7f110cbbff0..dd5b2b00aa88 100644
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
@@ -915,6 +917,49 @@ int ima_check_policy(void)
 	return 0;
 }
=20
+/** ima_update_setxattr_allowed_hash_algorithms - cleanup SETXATTR_CHECK r=
ules
+ * in the new ruleset
+ *
+ * Called when updating the IMA policy. Delete non-applicable rules with
+ * 'func' set to SETXATTR_CHECK and update the atomic variable to hold
+ * the list of allowed hash algorithms for the security.ima xattr.
+ *
+ * SETXATTR_CHECK rules do not implement a full policy check because of
+ * the performance impact performing rules checking on setxattr() would
+ * have. The consequence is that only one SETXATTR_CHECK can be active at
+ * a time. To prevent confusion, on policy updates, if a new SETXATTR_CHEC=
K
+ * is defined, other SETXATTR_CHECK rules are remove from the ruleset.
+ */
+void ima_update_setxattr_allowed_hash_algorithms(struct list_head *policy)=
 {
+	struct ima_rule_entry *entry, *tmp;
+	bool setxattr_check_already_defined =3D false;
+
+	list_for_each_entry_safe_reverse(entry, tmp, policy, list) {
+		if (entry->func !=3D SETXATTR_CHECK)
+			continue;
+
+		if (setxattr_check_already_defined) {
+			/*
+			 * delete old SETXATTR_CHECK entries when a newer
+			 * one already exists
+			 */
+			list_del(&entry->list);
+			ima_free_rule(entry);
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
+
+}
+
 /**
  * ima_update_policy - update default_rules with new measure rules
  *
@@ -932,9 +977,12 @@ void ima_update_policy(void)
=20
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
=20
+	ima_update_setxattr_allowed_hash_algorithms(policy);
+
 	if (ima_rules !=3D policy) {
 		ima_policy_flag =3D 0;
 		ima_rules =3D policy;
+		atomic_xchg(&ima_setxattr_allowed_hash_algorithms, 0);
=20
 		/*
 		 * IMA architecture specific policy rules are specified
@@ -1176,6 +1224,19 @@ static bool ima_validate_rule(struct ima_rule_entry =
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
@@ -1332,6 +1393,8 @@ static int ima_parse_rule(char *rule, struct ima_rule=
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

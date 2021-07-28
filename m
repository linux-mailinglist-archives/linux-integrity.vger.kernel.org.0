Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F43D8EDF
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhG1NV3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 09:21:29 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com ([40.107.0.120]:63047
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233315AbhG1NV2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 09:21:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVDx/9OElpFu/D+MHo/5+DzyqdGUlP2GdZSWhfLz9+EA0Az2HeCgt+sRKCIwvMaiEybs6UwBSZartrweNm9CQcyWWZHamXXK+h7OTakKM6A3xJ83pOotc+ugn5R7hFehY3Nt/7CHq3ZC+UwxYzxFPKFUVLZg/IL3e2itgbtqFIpTzrdkDnyQgOM1K9XEMSUjJAaULP3g2MUDrZDpkn2iTfesTyHB92H41C9BSLXp7ffKtGV5R+9mbhVEwXG3Mb+WWeT8dp6DlXwQkB9PExcVkuUwXskzaKZ/N4ZgECmQTDUv4MFXNPhNH3Lnd1sGZ6HStewbBMBLWSIOhP2GT4VVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/qr+aRbhTaB51a+71z+o9bFUEn/ZqDGdKIUrLeUoGg=;
 b=dVuutU1S/g4PUO52Gub8gJZ0j5UNUR8scWuqwYzoEVsLi99LcLru53ql2hyGCZTCmK2ogK2Kg3QDKQ495OwnxbQuXUfu2CneIPXYKWeR1Z5884Xw9UIHuHKmelc3+aDdQi8wJ/f87wfqkF/KaqPRj8z4N/H682Pm1tlYI3NflIttKNIWxXlFjtIcBqCe5ImGPj1zhMhuINyfY1eMjBTmKCli0auxVJ184O+vZvTlYtOSN8NoyaEOxoagyCAJvkluHKoSROV5VH1Gmm7rOvbeYJhfwzY28OLjrhqF8aFzcVMsCbqdDrfINkuI/40cCagHMh9BsbaplLAw4qyz4ar8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/qr+aRbhTaB51a+71z+o9bFUEn/ZqDGdKIUrLeUoGg=;
 b=Ervx2T6fnDdcZBtKb85rwtHm4XcXO0YPl4gVe84of+i8tvp2GeTUIA/xEmUuBRsaRYOf2GtVg85EpV1q4ftjNrXwhL1zS68udKYRppf4Hov6jwrBhlTrEtM0efu+bEaAfNBOKH5eAv8wAfVRQUGRKOgRAPzdfZE4TIyF37zkXOA=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3361.eurprd09.prod.outlook.com
 (2603:10a6:208:170::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 13:21:24 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 13:21:24 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v5 3/5] IMA: add support to restrict the hash algorithms used
 for file appraisal
Thread-Topic: [PATCH v5 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
Thread-Index: AQHXg7N2CbRxDcW9W02ASSTdJVlFJw==
Date:   Wed, 28 Jul 2021 13:21:24 +0000
Message-ID: <20210728132112.258606-4-simon.thoby@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
In-Reply-To: <20210728132112.258606-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3015ef8-5c42-44d3-f255-08d951ca9954
x-ms-traffictypediagnostic: AM0PR09MB3361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB33611736B2E8588944DBFF8194EA9@AM0PR09MB3361.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xV7s4U6jDeuaC+bbqmZUrge3GG//GIzJnfI+YUm36jBFFDDZWLxVY/JIPZEeCaRheI3PhIh/7uxijD1FOt6QfDQraBhScJ2kd4NKiqyuScGihwI/hCknymg8Vg1BI2kikRadvXARrThOFtagT/VTEZ+rmMpiMbNqQXP9HCe+escbqBFDp85khQOL7+aT2yvDIGKNEcSW7Ic/VUsuKPVLKQ4Xlu1rcMQeOQ5OHCH8zYOuEVGs1sMYLtaTRB6xqtNphLSYncwTNajTjHcJsUxetfboEC0i0fb2ZJpC93M8V2Y7ENnMj3sqmY6xbMmWte9/F3oElJa1tZ0Vot1tJ6rzsz9Ryv9MOdGouK4qiLZ2XWuBiXurbPYAU6v4VM5v7dV+sJElNGrvSSwgvwts4lRQXj3vWfv6uSrhgfnLC2zBnPbh+5XUDpybNECwZRk8vhEt9tJZ2t94BTQ91XLJw6dXOhKwMXiCCwShY7rShDanPNRe1RSHchyI6qOZo08sobQWQe3djxHScs8zIQ+ZES4Z1qE0WWIw+69nLEoM87RQv/6To2lQ6D5Y2FIyE5jDsMhczLB6LpoCZqfD1IbfqixQS+wHmNdgJ45Q93WGfcaF8ttMylX0OHI+UMx5iF5ZHDurbGmgCDSAxycmXzRoBY+TYfNSGUYhzK+O6+LaeslaaZTBIa6d+4UmjeIVSekUrsluzRbu0QsjISMtnbV2KAWdFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(8676002)(6512007)(8936002)(6486002)(110136005)(76116006)(186003)(71200400001)(66446008)(26005)(91956017)(83380400001)(6506007)(64756008)(478600001)(66946007)(66476007)(66556008)(38100700002)(316002)(122000001)(86362001)(1076003)(4326008)(2906002)(5660300002)(6636002)(107886003)(38070700005)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oSY3IWCB/hNs83BA6deKcrdHl/4W8oaabApGqXDgbj8ADnyYxARfFa/yVI?=
 =?iso-8859-1?Q?lTTq9oPteWVwFLWrXcUhhnUOdpkhdN6JKhF/4onOhhO28IQ9Ebrelc6+WD?=
 =?iso-8859-1?Q?wgiOCd+dVAKUIMyYI5T2Njdm0/OQH751wC26VwWjidMJnlS7lPvMEw69vS?=
 =?iso-8859-1?Q?lbSQFayvKFkSaAIclpJC0hQwLuHKr4Z5D1I4LVqJitYDx7GX3/fmG1cdwL?=
 =?iso-8859-1?Q?3S2EQUJFlhomcoJvTHT32dh4wc8UMUAUS6QY1vnUolYRuu1Ie1d+rXCo9A?=
 =?iso-8859-1?Q?f6f5shMZ6Y4W3U0QU79eeoGIL0nG4KZcTuUY119uvRue4Pp5HocJmoqmhb?=
 =?iso-8859-1?Q?yI50/6A8vLAf9lo81K8i/qSgyli+ghP/WUL/xOCt+XFWoeDGsgRkLNVUiA?=
 =?iso-8859-1?Q?RFdk8foCqYpA63xWtMxGDlW16w9/MzfMl3u6QnjjVidGdzizfoVT/buN56?=
 =?iso-8859-1?Q?tgWbqyctvB9r5ojIliGL1ZXb5m2aYbZ5FqQBmJBZHWq1sZo5mm/HrCBX6V?=
 =?iso-8859-1?Q?vCL8238morc9fVqei16395kHx24AlDimry+SdIOHTvnXhcJOyMop6f0LKf?=
 =?iso-8859-1?Q?9n0TNVuZR3qMY8foPPsstmr4q/6qiEIeTj5/c5jjQCYq9L2EwrlgPbGQNJ?=
 =?iso-8859-1?Q?pnE3dtTAMDVToOO3AOxdda8bmcGY3Bk3IeU7eHHj2efUxO1pSnIbGezdZn?=
 =?iso-8859-1?Q?6w4EROJD6jT5/nt10OIeBLpGJytcfEdYF0xtvaU8kBI8RqQEVSSiQ7NwHH?=
 =?iso-8859-1?Q?kkF9vcKDi+fa4P7ppFuCUjvPlNVqteZKrSmS7xtW01fThYbEwzw97Cbloo?=
 =?iso-8859-1?Q?MzQwGUdVFB8KM70X2z9JWTeEsED29X0Wsm891SnLZUr/sMHxxOpNyP3ANl?=
 =?iso-8859-1?Q?iBZuXXbOLnskYrxmuOxengLidKNbDEJ5Af8N0VgkHTGzuFhv6SVRE3wL6R?=
 =?iso-8859-1?Q?EI5m4GZoDhaJFhm8h6WTNhUhZgxSFDQOoOUnD0MPtT5q9pDvQM3qaISsXM?=
 =?iso-8859-1?Q?4nyajrqKGLr8skIuivM+7w9FUHwLBuXnHUeM+gzFog4En+76nf1wLPuz5o?=
 =?iso-8859-1?Q?htDCI7Sy33S3KWVF/Cyy+HuTB2JWvvOGxzlYFEb8NTbMxgb9oOn+eU1KS1?=
 =?iso-8859-1?Q?NHYmNli+YvdiV8DSW4hjXb1lqAtdMhkvD9BxxGdfCCuWt7UAM36W/kZEtY?=
 =?iso-8859-1?Q?vp/db0RS0AnpS9bFBv1PUb2llwz2ilsvA/6CbNDBz1m65jMN7svYRDSNtV?=
 =?iso-8859-1?Q?YHlXQoHeEj/aHcqFEnsMJ5nQ6AHQUdF+1mG3BNkIp06idNdcm59cHecYS6?=
 =?iso-8859-1?Q?MhpDJAB5lRhUk8N05UzBTNABXDICISEKC7VIfvWARhZmd6FmtCeQB0QrxB?=
 =?iso-8859-1?Q?yoUWFlc08/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3015ef8-5c42-44d3-f255-08d951ca9954
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 13:21:24.5871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUqhV2lnIlUDnm+Ynl9BFybKGTQQlvQsNgMu9tUKBbrxnwb7lt11a+luqCQ0iTLyRJ8BRRbdX+WjPGe99gebjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3361
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel accepts any hash algorithm as a value for the security.ima
xattr. Users may wish to restrict the accepted algorithms to only
support strong cryptographic ones.

Provide the plumbing to restrict the permitted set of hash algorithms
used for verifying file hashes and digest algorithms stored in
security.ima xattr.

This do not apply only to IMA in hash mode, it also works with digital
signatures, in which case it checks that the hash (which was then
signed by the trusted private key) have been generated with one of
the algortihms whitelisted for this specific rule.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h          |  6 +++---
 security/integrity/ima/ima_api.c      |  6 ++++--
 security/integrity/ima/ima_appraise.c |  5 +++--
 security/integrity/ima/ima_main.c     | 17 ++++++++++++++---
 security/integrity/ima/ima_policy.c   | 18 ++++++++++++++++--
 5 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f0e448ed1f9f..7ef1b214d358 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -47,7 +47,7 @@ enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8, TPM_PCR10=
 =3D 10 };
 extern int ima_policy_flag;
=20
 /* set during initialization */
-extern int ima_hash_algo;
+extern int ima_hash_algo __ro_after_init;
 extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
@@ -254,7 +254,7 @@ int ima_get_action(struct user_namespace *mnt_userns, s=
truct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data);
+		   const char *func_data, unsigned int *allowed_hashes);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -285,7 +285,7 @@ int ima_match_policy(struct user_namespace *mnt_userns,=
 struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data);
+		     const char *func_data, unsigned int *allowed_hashes);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_=
api.c
index d8e321cc6936..c91c2c402498 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -172,6 +172,7 @@ void ima_add_violation(struct file *file, const unsigne=
d char *filename,
  * @pcr: pointer filled in if matched measure policy sets pcr=3D
  * @template_desc: pointer filled in if matched measure policy sets templa=
te=3D
  * @func_data: func specific data, may be NULL
+ * @allowed_hashes: whitelist of hash algorithms allowed for the IMA xattr
  *
  * The policy is defined in terms of keypairs:
  *		subj=3D, obj=3D, type=3D, func=3D, mask=3D, fsmagic=3D
@@ -188,14 +189,15 @@ int ima_get_action(struct user_namespace *mnt_userns,=
 struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data)
+		   const char *func_data, unsigned int *allowed_hashes)
 {
 	int flags =3D IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
=20
 	flags &=3D ima_policy_flag;
=20
 	return ima_match_policy(mnt_userns, inode, cred, secid, func, mask,
-				flags, pcr, template_desc, func_data);
+				flags, pcr, template_desc, func_data,
+				allowed_hashes);
 }
=20
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index a5e0d3400bd1..12d406b5ab35 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -77,8 +77,9 @@ int ima_must_appraise(struct user_namespace *mnt_userns, =
struct inode *inode,
 		return 0;
=20
 	security_task_getsecid_subj(current, &secid);
-	return ima_match_policy(mnt_userns, inode, current_cred(), secid, func,
-				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
+	return ima_match_policy(mnt_userns, inode, current_cred(), secid,
+				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
+				NULL, NULL, NULL);
 }
=20
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index 7f2310f29789..85b079c1a19b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -210,6 +210,7 @@ static int process_measurement(struct file *file, const=
 struct cred *cred,
 	int xattr_len =3D 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
+	unsigned int allowed_hashes =3D 0;
=20
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -219,7 +220,8 @@ static int process_measurement(struct file *file, const=
 struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action =3D ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
-				mask, func, &pcr, &template_desc, NULL);
+				mask, func, &pcr, &template_desc, NULL,
+				&allowed_hashes);
 	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHECK) &=
&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -356,6 +358,15 @@ static int process_measurement(struct file *file, cons=
t struct cred *cred,
=20
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
 		rc =3D 0;
+
+	/* Ensure the digest was generated using an allowed algorithm */
+	if (rc =3D=3D 0 && must_appraise && allowed_hashes !=3D 0 &&
+	    (allowed_hashes & (1U << hash_algo)) =3D=3D 0) {
+		rc =3D -EACCES;
+
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
+			pathname, "collect_data", "forbidden-hash-algorithm", rc, 0);
+	}
 out_locked:
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
@@ -433,7 +444,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsig=
ned long prot)
 	inode =3D file_inode(vma->vm_file);
 	action =3D ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL);
+				&pcr, &template, NULL, NULL);
=20
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -882,7 +893,7 @@ void process_buffer_measurement(struct user_namespace *=
mnt_userns,
 		security_task_getsecid_subj(current, &secid);
 		action =3D ima_get_action(mnt_userns, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
-					func_data);
+					func_data, NULL);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index fd5d46e511f1..344b5b0dc1a1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -35,6 +35,7 @@
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
 #define IMA_LABEL	0x0800
+#define IMA_VALIDATE_HASH	0x1000
=20
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -79,6 +80,7 @@ struct ima_rule_entry {
 	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
+	unsigned int allowed_hashes;
 	struct {
 		void *rule;	/* LSM file metadata specific */
 		char *args_p;	/* audit value */
@@ -90,6 +92,14 @@ struct ima_rule_entry {
 	struct ima_template_desc *template;
 };
=20
+/*
+ * sanity check in case the kernels gains more hash algorithms that can
+ * fit in an unsigned int
+ */
+static_assert(
+	8 * sizeof(unsigned int) >=3D HASH_ALGO__LAST,
+	"The bitfield allowed_hashes in ima_rule_entry is too small to contain al=
l the supported hash algorithms, consider using a bigger type");
+
 /*
  * Without LSM specific knowledge, the default policy can only be
  * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
@@ -646,6 +656,7 @@ static int get_subaction(struct ima_rule_entry *rule, e=
num ima_hooks func)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
+ * @allowed_hashes: whitelist of hash algorithms allowed for the IMA xattr
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -658,7 +669,7 @@ int ima_match_policy(struct user_namespace *mnt_userns,=
 struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data)
+		     const char *func_data, unsigned int *allowed_hashes)
 {
 	struct ima_rule_entry *entry;
 	int action =3D 0, actmask =3D flags | (flags << 1);
@@ -684,8 +695,11 @@ int ima_match_policy(struct user_namespace *mnt_userns=
, struct inode *inode,
 			action &=3D ~IMA_HASH;
 			if (ima_fail_unverifiable_sigs)
 				action |=3D IMA_FAIL_UNVERIFIABLE_SIGS;
-		}
=20
+			if (allowed_hashes &&
+			    entry->flags & IMA_VALIDATE_HASH)
+				*allowed_hashes =3D entry->allowed_hashes;
+		}
=20
 		if (entry->action & IMA_DO_MASK)
 			actmask &=3D ~(entry->action | entry->action << 1);
--=20
2.31.1

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B636A3E8F95
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 13:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhHKLlN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 07:41:13 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com ([40.107.21.118]:48096
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237385AbhHKLlN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 07:41:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhz/QnDyWYQKaNs8Y+dArV6OcahgdfI7n5+ONs3+gWAJR3MdIwtgSdYQ3PdbiiVCwantbbuLTrxlg3FRYt/sydw9wYwVqfPMYNZYFJEXQRQWnO09XZywLEfFN/dACvS09GrY6VUFVmy4vVEMpw5PZdjmUcRUHk/GXyCN65Zr8h7LqYglxywXuy3NdfgFaVzPoVhnabP7IXcaPNIKEGwSuEg2FYWEk796uqOcvxj/wui2qEa8aC/xHJMY6zJOrn7q1eJKBgGwqV4Y/wj4RKZXvPQMER1PC7lkh8wx6HAaZT9JfgxmvAYzWkGTL4+Gc7F8HGrn+LzbRGj8WCjoRBSpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME/6TuPITUBlaH8DeMoOx5pGhcIfHht18uWbSKkzAnw=;
 b=LrXixiqC48MbA5mQV4eQM8PHOJHapE/EZr2h9ltXgdeitaLMhCNpiRwYBrkcdmFQGsYUWFcUWqZiTWYAgDoM81reJ7qO33HnX1ij+kVs8267RqJOZCV4XWhFi3DZBn+79iv3QhcZevCRwny8KXhnSosYgsFAXQHyZbT+PM6SUsG0sTvVwqvomUmimj0PGD0VFSkl3OmwxCRhXz5o3c9Z+Keb11tIrUTjabvC2fhZncQZ/DO0et7vSr+cTe7ZjPQlnUymDDCF3j8iYRbD1L63dQpFTuQGmTz5kZ/T1iRzHN2rgWeFP6hbxbCFzBZgZvP3K2xVAr3rEQkSrOtTEGjHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME/6TuPITUBlaH8DeMoOx5pGhcIfHht18uWbSKkzAnw=;
 b=fiXafpvpT7tuXxs4L5Dqua5sEAy23BZN5tPh/bWyZwIbq1dqd4RAEJBpPJkNQLcCsE7UI5/CyxyWsB8vzH9olpmyyegJAOeE7ohoL1+gIRYf5L3E6zaPU9elXQxvZ8VXKW5TWQQRHrj3fttXbfwaX/VUzjcPAaJ1KBp1znBPG4s=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5105.eurprd09.prod.outlook.com
 (2603:10a6:20b:30a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 11:40:46 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 11:40:46 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v7 3/5] IMA: add support to restrict the hash algorithms used
 for file appraisal
Thread-Topic: [PATCH v7 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
Thread-Index: AQHXjqW5ksrjGXMRa0O+r8ytvcGKyA==
Date:   Wed, 11 Aug 2021 11:40:46 +0000
Message-ID: <20210811114037.201887-4-simon.thoby@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
In-Reply-To: <20210811114037.201887-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc970c59-ecc2-4072-4df9-08d95cbcdc31
x-ms-traffictypediagnostic: AM9PR09MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB5105FBD8C756394446362A6A94F89@AM9PR09MB5105.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqUoryAPtE0Pq1ZnGk0e6lfULkYi86jmQpHb3uPSYZiSYe4JRwkocSvi4XTm8rZUVIUrCJJWPE8h1YqdVuUxql4Gb7rJF3YY9RV2CBKReqgy6KcCrHORB/FlXC26T+Rs4u9lCnljSvHGwxLdH6vM+8W7D+c5HjnynTNG9Ekgkr4mYmNUII1EJT3gLiEWRbhzhouWomNRbfCrdGnvbLDB1VtzXAbqz7GA9HiX9j34zNlFxDlpkfRRGLZWX7CpDrmOFMdNREMELlQUcqYKSuex5D3eigMKImeFHyqywDim1zlyV7ShJIFDQ89cHCVIYzkQ3W4wof/+2JpcCpeDotxOUUM5UFnk9VWiXDjNW59tDGDv1W66GwaBvwizPF1vgYPis9LwLW9rOj1qruoCHenZORn0jZuPLKjSuosRWxwcqaSqygYybtqxqVDVEmCg+sqJY5GqCbI6/VxrELaaaM7Cn87wCkdy/OAvooi6TullDH7rh7u5opcUjRFumaVwtaIdnU64sZcWU0/K+3G3GulScLxNySB3IV7IdZtSWhjf0wCsbvgkxTlil6JmDyU3MZjZle0L9hL7Sf49Zx2v9GKWU98al5sly0guj184mczpc+Bl7Htz0M8RBxM07FSSgmBaSFMgADnPhmB/xvbCh62BY7qmFMAXAW68lE6xgxWAzluG3w/yGlS/ad25eiKlYQuHfOXrwzX0xW5prFJJ2wEIBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(136003)(366004)(376002)(2616005)(5660300002)(36756003)(54906003)(76116006)(6512007)(186003)(316002)(8676002)(6636002)(6506007)(91956017)(64756008)(8936002)(66556008)(110136005)(66476007)(122000001)(4326008)(38100700002)(66446008)(66946007)(1076003)(2906002)(83380400001)(6486002)(38070700005)(71200400001)(478600001)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K7JxRTkSo1B+lM4EkqX2gcEQJkycBUYvbwa+DxZcOmvna9vuSMtDO7lXI3?=
 =?iso-8859-1?Q?ffUK1DSYwVNf4TW1RtY2KHUOlh9i+L4aJd8hh4YeLUu+dOBZbrUQSXag0F?=
 =?iso-8859-1?Q?1zmG9EOqhnsTH4lE6spnndKYValS9L/CAkuc0eKfrAjcEhF1Obtw+na6Gn?=
 =?iso-8859-1?Q?1S6bFbm71ZoLnz8sJFUNfXs5nyimpt+uoVJtPn1RItJgFbj7/D5nWALNPd?=
 =?iso-8859-1?Q?DWqpLDtFD/+HJvUHnDJokobCSqzBDL63WGGa5gtUKgVXN40ncNI4Mu/yjt?=
 =?iso-8859-1?Q?WJwGajv8YUYYsfgUc2XvK5RjnkuJ+cjccPD+gvtxD2z250RjTHO/TEf2J3?=
 =?iso-8859-1?Q?QFAJvsuG5FpekQDLd4hB+l00rlgb6XVHPzB6oeJ4KB3oZ8Jx97Okt1V3JW?=
 =?iso-8859-1?Q?X/0p4gFUaJGL4rAxvVOGQoIEUZWievSuVrECCGUP7FUxlGSH7y7aStZVpn?=
 =?iso-8859-1?Q?UMaGvllg5X4Fxu+N0tmoTxN5fFUkrkvYgFRAEQGM3JrpB9OAmDu3Ac2L3c?=
 =?iso-8859-1?Q?QIkedoYNsN0NxoPlwegvO7I/o2M/AGCQtYaMBU52uHLqINLTF4ebBMaNsX?=
 =?iso-8859-1?Q?Xkbe9P8KgyV2GxzBuwCP7L9bgeNE3uf3cgK3ypsY2CM7kqBf/wsIejEmw+?=
 =?iso-8859-1?Q?PotaOzET1aKHr8ztDEcWsClIYfqF1+jFHV9I7GLdsdmcNZyFcvVCoIMuFQ?=
 =?iso-8859-1?Q?sFsWvLu/rP+qRvs44KukO906+vrbeC0GpWtd7O5wILPrSXkKcNfHT6nt4i?=
 =?iso-8859-1?Q?ismUhTb/t0ZfhI+/e6WDRGYyzNEwj9l2oXszCisqrMHyq1VeIOQ307RbBI?=
 =?iso-8859-1?Q?7i24PqRddVxOliUMLNW0NNUsqr+X/Vt65NdEejObuq8JyBT8HfCfD1c8f3?=
 =?iso-8859-1?Q?eDXGVMWAA4x9zthUaksG+aJxbp7wV6CMwUGqvLAGnkxg6iaCiAZ+ryd2iZ?=
 =?iso-8859-1?Q?u8KCCuwtCA/BIjzQ0K3QQmn5ptEPrUEJ/ndaT5jxvYByoC4xO/WgjXBMJ8?=
 =?iso-8859-1?Q?nnQZHiJWNh8wnLq5Nn0iI8pCRzgROcIvU6TkRNzbZpGodFf3uU+ZafjlJQ?=
 =?iso-8859-1?Q?k7O10XbM273bB224TdllEnbUkknxUSd1g7h8rdzDzX52T/HsVlZweXGvOZ?=
 =?iso-8859-1?Q?7Jt0OU0QERSPAm+zmemT+ZrK3VN/OBFyHmSgX10It7RQL24TW9ktUFdwnS?=
 =?iso-8859-1?Q?UzSY51v+vfq5xtFZ4a8T9ItUDaHBGZKwF5ZCbrGKer64pHYZmk88YJ2JA/?=
 =?iso-8859-1?Q?3MKOGpLuvkSPTQyO1i5JUGI1toElHi8wipPC1ZMpUaFLZp/ofhrERwzNdt?=
 =?iso-8859-1?Q?qzW3XXrGzEdNCI8DqPPDxbegrjWHmPC7GTQ5bpmo6vMdpMm3ltXJlq+eWN?=
 =?iso-8859-1?Q?rWg1KFWqTW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc970c59-ecc2-4072-4df9-08d95cbcdc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:40:46.6532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAWBK5QS38YNGj0z9UG+TVyP8jGCae5O9m7laMnEZXVmyqlUw+M/RvsmulXbGKtDwBGfLMpfnUlLktP6lYyYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel accepts any hash algorithm as a value for the security.ima
xattr. Users may wish to restrict the accepted algorithms to only
support strong cryptographic ones.

Provide the plumbing to restrict the permitted set of hash algorithms
used for verifying file hashes and signatures stored in
security.ima xattr.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/ima.h          |  6 +++---
 security/integrity/ima/ima_api.c      |  6 ++++--
 security/integrity/ima/ima_appraise.c |  5 +++--
 security/integrity/ima/ima_main.c     | 18 +++++++++++++++---
 security/integrity/ima/ima_policy.c   | 18 ++++++++++++++++--
 5 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 829478dabeeb..bcaf818fb647 100644
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
+		   const char *func_data, unsigned int *allowed_algos);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -285,7 +285,7 @@ int ima_match_policy(struct user_namespace *mnt_userns,=
 struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data);
+		     const char *func_data, unsigned int *allowed_algos);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_=
api.c
index d8e321cc6936..2c6c3a5228b5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -172,6 +172,7 @@ void ima_add_violation(struct file *file, const unsigne=
d char *filename,
  * @pcr: pointer filled in if matched measure policy sets pcr=3D
  * @template_desc: pointer filled in if matched measure policy sets templa=
te=3D
  * @func_data: func specific data, may be NULL
+ * @allowed_algos: allowlist of hash algorithms for the IMA xattr
  *
  * The policy is defined in terms of keypairs:
  *		subj=3D, obj=3D, type=3D, func=3D, mask=3D, fsmagic=3D
@@ -188,14 +189,15 @@ int ima_get_action(struct user_namespace *mnt_userns,=
 struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data)
+		   const char *func_data, unsigned int *allowed_algos)
 {
 	int flags =3D IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
=20
 	flags &=3D ima_policy_flag;
=20
 	return ima_match_policy(mnt_userns, inode, cred, secid, func, mask,
-				flags, pcr, template_desc, func_data);
+				flags, pcr, template_desc, func_data,
+				allowed_algos);
 }
=20
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index baeb10efbf51..e2edef8a9185 100644
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
index 1cba6beb5a60..af6367ba34ee 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -215,6 +215,7 @@ static int process_measurement(struct file *file, const=
 struct cred *cred,
 	int xattr_len =3D 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
+	unsigned int allowed_algos =3D 0;
=20
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -224,7 +225,8 @@ static int process_measurement(struct file *file, const=
 struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action =3D ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
-				mask, func, &pcr, &template_desc, NULL);
+				mask, func, &pcr, &template_desc, NULL,
+				&allowed_algos);
 	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHECK) &=
&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -361,6 +363,16 @@ static int process_measurement(struct file *file, cons=
t struct cred *cred,
=20
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
 		rc =3D 0;
+
+	/* Ensure the digest was generated using an allowed algorithm */
+	if (rc =3D=3D 0 && must_appraise && allowed_algos !=3D 0 &&
+	    (allowed_algos & (1U << hash_algo)) =3D=3D 0) {
+		rc =3D -EACCES;
+
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
+				    pathname, "collect_data",
+				    "denied-hash-algorithm", rc, 0);
+	}
 out_locked:
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
@@ -438,7 +450,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsig=
ned long prot)
 	inode =3D file_inode(vma->vm_file);
 	action =3D ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL);
+				&pcr, &template, NULL, NULL);
=20
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -896,7 +908,7 @@ int process_buffer_measurement(struct user_namespace *m=
nt_userns,
 		security_task_getsecid_subj(current, &secid);
 		action =3D ima_get_action(mnt_userns, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
-					func_data);
+					func_data, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index fd5d46e511f1..1536e6f5eb22 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -35,6 +35,7 @@
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
 #define IMA_LABEL	0x0800
+#define IMA_VALIDATE_ALGOS	0x1000
=20
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -79,6 +80,7 @@ struct ima_rule_entry {
 	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
+	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
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
+	"The bitfield allowed_algos in ima_rule_entry is too small to contain all=
 the supported hash algorithms, consider using a bigger type");
+
 /*
  * Without LSM specific knowledge, the default policy can only be
  * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
@@ -646,6 +656,7 @@ static int get_subaction(struct ima_rule_entry *rule, e=
num ima_hooks func)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
+ * @allowed_algos: allowlist of hash algorithms for the IMA xattr
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -658,7 +669,7 @@ int ima_match_policy(struct user_namespace *mnt_userns,=
 struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data)
+		     const char *func_data, unsigned int *allowed_algos)
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
+			if (allowed_algos &&
+			    entry->flags & IMA_VALIDATE_ALGOS)
+				*allowed_algos =3D entry->allowed_algos;
+		}
=20
 		if (entry->action & IMA_DO_MASK)
 			actmask &=3D ~(entry->action | entry->action << 1);
--=20
2.31.1

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B883D7305
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhG0KXr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 06:23:47 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:4837
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236103AbhG0KXo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 06:23:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8+IbizIfcTot1wsHrJZzoBt+FUXiTyDJ7xaWgN2tmgDcVM31sRQpcr74U3pQMz1Qb2CIFhFAArx+h9utC+e0L6822eOrpUgvUFUkJ2wj1+UKIGCASZkQhYwgpWe9BHhDfrXhc8IARbJHKPyneX6XaumPyK26xWR0XUWtOf3pxRN42964pf64zqfhgpneUzPIzuJ4jS9zN5H8EcmTmqnizaF4gnvSNPLVDGIZBkkYfrz4+B6BGLy9ZXMgD1zQb304UYZPPdyIw/t9E/meZOv35F5F3ES29ybobG4eBDyUpfXxx0JzoQG8swUMSxmvnZWaibdsxLlnsFmVMSJDQjSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4kjzLtdiNmxKBPhfm+7CGAXdgu+ALzG3Sb4Sb0tuGw=;
 b=bCHtzAouCfUiFchdC8WVjJ7PUql87awZVHj2eNWLrXRa8fLNriuMVRJqguCeptWW2KqCCEqQaiYTkZXQiPQMkiN6jaGy06ggdjbmg0lDDNBn6Pv7o9RX2R7umE1A3ErPuEUbQfFKrOcXRigMyvAw21PUPKaMlrIXHT7ZWBSEf2lpFDKD8ZHlEfhE+qhjphC7aCXadVaYGQSkevb2YndSLB2bals5ClCtpiQFD0EO2KJGSnB1iWu6cB+0TWhsDAztm5b6X4QOGgOD/YgSqPviYTPnew7yz5ZUW1kymtCUfI63AdcMHjmYNk9e7n6f8BJXKHTeXd/P4yxfskBZyrcU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4kjzLtdiNmxKBPhfm+7CGAXdgu+ALzG3Sb4Sb0tuGw=;
 b=CDsKbgQD6RPa1qFFUmWYMAj2FOMST0OT+jWNmLnwrJUDh52hjc4Iq0e84ML2UpQlx+2cy3r11a6Kwaz8aDv65yH5X43KdUzBAjp3mvj0f2mjpKm2Ib09fkS7VmyGRYz5Fi9nsAk3M92kgX9j2SCNud80sW5PEfKbTiJNU8ado+c=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3364.eurprd09.prod.outlook.com
 (2603:10a6:208:16c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 10:23:34 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 10:23:34 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v3 2/4] IMA: add support to restrict the hash algorithms used
 for file appraisal
Thread-Topic: [PATCH v3 2/4] IMA: add support to restrict the hash algorithms
 used for file appraisal
Thread-Index: AQHXgtF0rbMLK9jwKkWzL/HsCKMw1g==
Date:   Tue, 27 Jul 2021 10:23:34 +0000
Message-ID: <20210727102307.552052-3-simon.thoby@viveris.fr>
References: <20210727102307.552052-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727102307.552052-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dee7ac70-b7c8-4666-d869-08d950e896da
x-ms-traffictypediagnostic: AM0PR09MB3364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB3364AA5413472DD6CB395D4E94E99@AM0PR09MB3364.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5IV/6j0QTFLdbHISS0ugVatTt/qDN/R8YFc4VwMqwPtd+VFay3+DngMEUxi8bTzKfwlUStLQDHT4o+AGiYFJwghhc/jmLYQxoP2qz215LNMyoAJHILQ6MbeGIk2laieiJ5joS3fP/8pMeydD/mTKHiazC1D0hDfzTZLA+bFDGvNVujMNMORBg/yjOAmFfmwjtcNhnEz2mMPm/u1p+p4YuEtTY3p883RBUn1yI2+vPKU2MM7eFYz1waaOyF56HX9D1g65uyT2xv9e9wBzLwQcWNMZkT4UUlme0s9ZB3/uL7oMobGwTDK2ty8Zs6/pOvfhRbS2vUQqLXEDiqM9pydPTbNNNdQA6D8+FGa/6IWXVeoJXQUq1C5DuQ6qyjaUFcCjO0xBBuPjtU3I2ERXs79aa0QRswEzlauxaU7UwqRvofV76EjlHYFx1HV8oDYalDHH9OaeCkvpPw9NH5oXldptZxEHvvM9bESqHSM5xRKAjjayIscG+/rX7zYdMG5oQjA61W4l+FOBnBcEXYxp5LLYIVsasngqlipAFlP5O/TJsp5aTLAioMcwD+P+OJ3nb/wKVxvKOWqj/TBe6bO1+1tNvAsZqCU+S9v5I1ON4P3OcHRWfvjRlifQB6SeomhEE0dzAZrETecyBqFKkHTPAGCywX/e8Vpfn2E17k29K5GCNCpzIEgfslcQhsxcADeuCF//XXBbw54X6UGC8EzRO+Hl/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(6486002)(122000001)(2616005)(6512007)(6506007)(478600001)(8936002)(6636002)(66946007)(2906002)(316002)(91956017)(76116006)(107886003)(8676002)(186003)(66476007)(4326008)(64756008)(38100700002)(86362001)(5660300002)(110136005)(66556008)(66446008)(26005)(83380400001)(36756003)(71200400001)(1076003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?whFgfag9RY1Ww44yaFDsTrigzrbYxhjbT7NgqDImwbghvmMXwqM0aEhRl1?=
 =?iso-8859-1?Q?1yf2iD1yId/C4IszzUlSM4aQ7ypg+jNKBO1pBdHV16atpnCoGjX9dAvSmV?=
 =?iso-8859-1?Q?m3NI/n7yaWypoQqkKau3aO6OBDWxhaMwtZqb7yaBVfD2Bu99b+tjayKMC1?=
 =?iso-8859-1?Q?ztY4Rqws25rJ/lZiq1JWZ2OOghlq2cfnBbGxnE/bPto/WLqUplUITES/ja?=
 =?iso-8859-1?Q?wvqOnNWY8AGO2UTSwotc9I6t1ppPcJ0NZ2PuWvBXhYtxyll1Z+YhcRjiY5?=
 =?iso-8859-1?Q?XSw/PVoB7QrZbdxXyLkYYSF1pEU/anPnKvn86+eSCIopdIM9PsCF2LnBEi?=
 =?iso-8859-1?Q?4WuA2TPVSZCmV7LDU3tkzp7kgAipVzVOApU/oEbLs8E7MSWBcBlNkv6mNG?=
 =?iso-8859-1?Q?AfUp12+zBlV1PsX/yb7kNqlWQCtblvVu6T87wR75wRQMNTWKr2UxMQevJH?=
 =?iso-8859-1?Q?bQSpey1Zt832Tewa3ViRsw75H7W1gfFN71nDMQMu9ARumkEZPI+WItXmmV?=
 =?iso-8859-1?Q?EVi9AYTHaA3CPhDl/AG3cz99rGLsxOBi9pDUTVEAM6lEYvBsjOADxq5Wmv?=
 =?iso-8859-1?Q?9JUuIJJmj073/janpoQQwQJRo5m+iJ+xd7V2dci4thdP420XrAQI+rwDOh?=
 =?iso-8859-1?Q?jPXrTGKRC6ywDKQ8/6sPZppdtmntTQ3pT/OkMJPv5mQj1ut0qxtX+V8RSB?=
 =?iso-8859-1?Q?MsR/qeeDAHcJxHSXwG01ofUD+VN0QDXW318hYn15DcYPDztY+6oI4gWk8U?=
 =?iso-8859-1?Q?WaIiIDSBgCkOuew+EtzxENZ89gRWC18EXe+XLK6J5RCFCd3UANFQO15DRM?=
 =?iso-8859-1?Q?w+DeVB/mJ7IpnZvNewT0mBLdTLJFy4Sk6f447AavliLqvM2Ni09APQG/BP?=
 =?iso-8859-1?Q?FPcQoWGmbglGKR3IqvllzaqgPpMjMeDWQDkcdfGoK6exC6nudOCsu3gOWl?=
 =?iso-8859-1?Q?BeqQJnWuR/Fu/komVV1TlJiQ1B9XE556hFRBz08jjZVNflmyATilOnpJgV?=
 =?iso-8859-1?Q?GmELYZdcoofVpPrchDO0293DdqVTZigXtwSlf8YgMFZKb5GbbP0ej19FUB?=
 =?iso-8859-1?Q?LvsdBqzEcniUJP3V3Qc38mGXdQoB2q4SZ3j3JRK6BSxX442lv94bBmpkog?=
 =?iso-8859-1?Q?qc9ezdfgERDJbbuekoJVwZzumLVmeQzBMGxru5E70qMVjWy3KQy67jJ6l6?=
 =?iso-8859-1?Q?nEFqQNHDvEMMatMz+OSaWk2b4gGb1BvmGpJRhaWi5IcRmY+bnGhkRBdW9x?=
 =?iso-8859-1?Q?S8Pq0oYLoutNrgtMy3whS4eEhcs3PdkSJ36j7wYE3ZKAbzu2Z6Hxd7DChE?=
 =?iso-8859-1?Q?n4S6j9ZYjHq7fYZzbdEaZZwxiLYffO8bD/g59eDdzTl3kAe7NLuMrknFJZ?=
 =?iso-8859-1?Q?xeFKEB65Vd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee7ac70-b7c8-4666-d869-08d950e896da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 10:23:34.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pyaUFS2dqDSzPpoTwb/peGKnCSF7DCSdTrbuIHSffoP8sNpsDV9j+yeMNz4vlwKJRGRY/X76NKeykpw3wpM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3364
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch plugs in support for restricting the hash algorithms
accepted for protecting the security.ima xattr when appraising
files.

Each ima policy rule can have a list of allowed hash algorithms,
and a file matching the policy but whose IMA hash is
not explicitly in the list will not pass appraisal.

This do not apply only to IMA in hash mode, it also works with digital
signatures, in which case it checks that the hash (which was then
signed by the trusted private key) have been generated with one of
the algortihms whitelisted for this specific rule.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/ima.h          |  6 +++---
 security/integrity/ima/ima_api.c      |  6 ++++--
 security/integrity/ima/ima_appraise.c |  5 +++--
 security/integrity/ima/ima_main.c     | 22 +++++++++++++++++++---
 security/integrity/ima/ima_policy.c   | 18 ++++++++++++++++--
 5 files changed, 45 insertions(+), 12 deletions(-)

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
index b5b11f5ec90a..6d121819ae9e 100644
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
index 287b90509006..d7289164807e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -210,6 +210,7 @@ static int process_measurement(struct file *file, const=
 struct cred *cred,
 	int xattr_len =3D 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
+	unsigned int appraisal_allowed_hashes =3D 0;
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
+				&appraisal_allowed_hashes);
 	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHECK) &=
&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -327,6 +329,20 @@ static int process_measurement(struct file *file, cons=
t struct cred *cred,
=20
 	hash_algo =3D ima_get_hash_algo(xattr_value, xattr_len);
=20
+	/* Ensure that the digest was generated using an allowed algorithm */
+	if (appraisal_allowed_hashes &&
+	    !(appraisal_allowed_hashes & (1U << hash_algo))) {
+		rc =3D -EACCES;
+
+		if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
+			pathname =3D ima_d_path(&file->f_path, &pathbuf, filename);
+
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
+			pathname, "collect_data", "forbidden-hash-algorithm", rc, 0);
+
+		goto out_locked;
+	}
+
 	rc =3D ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
 	if (rc !=3D 0 && rc !=3D -EBADF && rc !=3D -EINVAL)
 		goto out_locked;
@@ -433,7 +449,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsig=
ned long prot)
 	inode =3D file_inode(vma->vm_file);
 	action =3D ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL);
+				&pcr, &template, NULL, NULL);
=20
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -882,7 +898,7 @@ void process_buffer_measurement(struct user_namespace *=
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

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309BD3CF6C9
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhGTIpU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 04:45:20 -0400
Received: from mail-eopbgr70103.outbound.protection.outlook.com ([40.107.7.103]:9089
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235205AbhGTIos (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 04:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn4urdOElmIeK+PoY5lKhHPe0Z3FQo8+L2aF+IwBsI8oJGB2XdCjtSFyOGvzhiJjRRl9svLLh580hjw+Gj0WFh9S0hRMWIL0FEp2ioQp1ZAfhvB5vKUX7BmaHzptp10UV/xuE/qphdiCcOrbAAUkBbKt7To41zHUK3gWfOoxIi0J4YMegoxDDfEDXyYx8KZUODUhq+glLW93fhoO1xZFElwIaLUxxNjHIJsqv34dNph2esUFaIZrEX2eO1zh10wlcE6HCAbsZTEHrruKu9POUcvNj6nWKPaicXlv24XORWEsdHk7PWuGP3ZPb/fX7e+r1k6+UmCMLnQtBPqjPIkN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1yNLXjOYGezMr61FcnTHb2rxD+aUh3OlyD1xetLrag=;
 b=RERAuRjwYUTC8SO8xN3Ssmcrk8+0pFzmCWR0Hi/0wkclIgRqO9Wy4s7k1Wjb56Gu6uVY9pHDkx+tB1MT2W4f/ydEMBo5qK949gQxsC90u1thWnoBT1stF1J1YPmsyKg5zhob7x95ArPiBmqvp6x9ZPDmAzA3Rj+cQYmqQFz52b0Zek8lRJ9RWWvr+C8ovsbZ+EwvjR0EY+g4WnRRpdd6SM5x1NyWG1YB1jTzdQG9zbHvYn9NWXPtLdfg61lZ4g73ofc+fOgu8uwchRIb8d0TQE+1S6sWfUHbfaxL9aQxKlJTicLkIz3ztpaa9EU7UA4x0coGw5e/P14eUJRA3aP1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1yNLXjOYGezMr61FcnTHb2rxD+aUh3OlyD1xetLrag=;
 b=xKtWvTWp3/ZuMzQ9ySGEoCxTC0y3NKhoHkLS1zVFxqLvDILkE+HFSggzbI5VOvfDD7N9GpzUVQXGsv3qh4R9Ef4TjOw5jOzfc0AGmrrEfS58zTwEIatJpykcGisZld2vOcH7iGKKsrR3a7A+jEKjM5aj4pimPul5K4huUUcl35M=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2370.eurprd09.prod.outlook.com
 (2603:10a6:208:e3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 09:25:25 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73%12]) with mapi id 15.20.4331.034; Tue, 20 Jul
 2021 09:25:25 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v2 3/3] IMA: honor the appraise_hash policy option
Thread-Topic: [PATCH v2 3/3] IMA: honor the appraise_hash policy option
Thread-Index: AQHXfUkre1JTP5gggUCW0teIdj9JZA==
Date:   Tue, 20 Jul 2021 09:25:25 +0000
Message-ID: <20210720092404.120172-4-simon.thoby@viveris.fr>
References: <20210720092404.120172-1-simon.thoby@viveris.fr>
In-Reply-To: <20210720092404.120172-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77425fb9-5be3-4556-0326-08d94b604e8a
x-ms-traffictypediagnostic: AM0PR09MB2370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB2370BCFAB4D531795F8AD62594E29@AM0PR09MB2370.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pto67zNgDIswZwP1A3OEV1tj5G8QqkKPBQqhjfakpyjwcqiuqWAJkLNLPAeRmsx0spFIXrNSYZHuDsNVp+7j3i7rUbyNAs/pK3IqBXTVRVYlnHEnLoINtiaGCYdwD4md8pTcknXkARH+qTkWKcm2pYJvevPqjEnVoR6EMrhNI+Ok+nN5DJJbT0wKnT5TgeXQM2EtSKUH5BojcD6kxPH9EhtvuUaWPrpTKHX65I3R1/hpX2nnvtcskEaiDzoWh0jO81iKM1LtQovzSOh5WqRLAIa4OZ5iUyabFrLbOAgcNvhy9aYt8DrCyQCxABl7VDv8VAkf8wtHVtU57Z5poArSId8rFjjMVVO2q1Z7cm1j6GMPQr+Y9qKcN9gCz9ibb24MHMgoq8xyVt/H44Tng3hXwz4VaULjB7xe3VS7DypQtTsqPjlOjudHsIOxZ4Ei2YsqIzWjfBGH5yFmXqkjJfKZITinumTPojlEh6Xp1mfr5YMXd1w+6CoIAWK5CQCnST1j0ljMcL1wSjResNWno33O+q1yeRknDxU21Z1XJ/6BOvOJFYs1sB6AYqsdTNQCi7gxaSvCcqL3xChAVnjiFEZpK/ZOjQYPZqUTEGGbhOWzOVu1d8JuOoPorDpGe5DgzjqhtMu3F68hr2T2aGOgZlfH1HZT2YgQlAAXbgfUItLUKIqXJwe5dKLsICw9s96Gb4kwI/As8zt7NxoAHeEyzsDsBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39840400004)(346002)(376002)(136003)(6506007)(66476007)(6512007)(64756008)(110136005)(66556008)(107886003)(8936002)(26005)(2906002)(66446008)(36756003)(186003)(316002)(91956017)(6486002)(66946007)(76116006)(478600001)(8676002)(6636002)(5660300002)(4326008)(71200400001)(1076003)(83380400001)(122000001)(2616005)(38100700002)(86362001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D6EFgXnwIGTfcMEsp3aogDAcJr1btvONluNv74XfRWcXy4TqYHgT3ilqzK?=
 =?iso-8859-1?Q?hwAkMByPKLqdqb6IauuSH9cqwxeDXxJuivg8Gr6BusMR+hwCONrztstUnB?=
 =?iso-8859-1?Q?CVV5e2AHJwo3qAnG5ezjyUbNjzotGeVjBn6DTDpdtTZXdfyqCuoW2CNGYq?=
 =?iso-8859-1?Q?Yo3VASIiLBJbengVc3mXuAvhjHSr23ABZYiZSER2kjzurCjV78Gaj14AGl?=
 =?iso-8859-1?Q?kgYUej/P+SZMlS6uvu8shFBD78q+0iqOXC6/OlMHXJkd9Yjzrw5SH2vYJO?=
 =?iso-8859-1?Q?n8cdlrW3gA8n3oNJF5rvAejNBYXX3iZfA5+71INURXUk+M/9YUiUmRrnoH?=
 =?iso-8859-1?Q?OcxSWi6u57VH/PTL+sV1AbA+bHpEb0SEU2uaendrM9Gn7sWVYZhzCX3zWf?=
 =?iso-8859-1?Q?rlqvgkZTwgp+w5aXTneFtX6IZsYCFdyxvx5acLL8sabtRaPXLVfMiWHi5r?=
 =?iso-8859-1?Q?S+vBrdG+9VGaDr5eAdIblsm8pOvmTiSUt3uoqMS57ShxE03BV/unvR5O5/?=
 =?iso-8859-1?Q?zgJyPj9p6evEXuZ0iSYZ9qrQc2bUK4JdM/83RMqxKKAAg8jIKNzaAKPugJ?=
 =?iso-8859-1?Q?RzMuQhojscQFuyu74rHMwTyntIh2eSvgb+G8yeHp9OEddgU74I4HeYxnL1?=
 =?iso-8859-1?Q?3lUIS0ONHPqSJZt9ynkSw9AS9vRlfacPFw+S9DzMmWZuLmJhZI2iy9D/v9?=
 =?iso-8859-1?Q?WIbkE93vGEvQ3li976r0HeHThG1fJ72qgseMLPoADPbfn8udqz4J1hZCaT?=
 =?iso-8859-1?Q?jUD4ldSodnTStu0eHmpvuPedOnRiN13v4pP89Q+P+nfMWdO4xfXp10yfXE?=
 =?iso-8859-1?Q?Z0FBRGCwfbWJPs5GvFpOPV+8ipeSCWLN9z+tNIb1vWGRjdQC/y08iaTbuq?=
 =?iso-8859-1?Q?IVpV7Yo//cU3vdLbEuATgKHW1+a4/991MsTcF9yAERL1isqOUyn414pFah?=
 =?iso-8859-1?Q?/nXc8+4btIMMA8yWfJWrM9ZPh99DN7et+JZnb2IADJR6uwOotjlQHVeH61?=
 =?iso-8859-1?Q?w0v0j313FxP3RtdP6OwxqQO5mlMUAAFRyMA9ImyCiE1SrqQKSbq0IiDebI?=
 =?iso-8859-1?Q?G25277LCOCrT0BTMhsL7uDP5kOwJBtlsN6tPO2l23e//NzRioeJNAEgohx?=
 =?iso-8859-1?Q?kcefAcWO/YkJB0wkFZT+XkpkmrhLncF9YqOIAQwRivr1NHNcYddOM9h+yP?=
 =?iso-8859-1?Q?l2a20yv78KeARS9bJBgo5l3B9xYhUlQzHzdkhr6ju5nFNN/rMbWnIRbwxL?=
 =?iso-8859-1?Q?ba2rdZprsL0WbMKNhjTg/jKFT3fUm/V5f1H3Cbs+l1KoeTqVK/8c0kVgqy?=
 =?iso-8859-1?Q?HS25+wij7lbA0uWIxS9snJSzCinJbOstHCFB4g1c21rk6zK0AfDL+iDLwb?=
 =?iso-8859-1?Q?OIiavylbwP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77425fb9-5be3-4556-0326-08d94b604e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 09:25:25.4947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwwJx+mFlNdQZmbm6ajCuOzyiZ1MOxaXvEihlCbALPUTcIMG2RIFGUfGZHX76qPz4uDjnEaXxIJ3Aniti6FdUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2370
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When a policy rule uses the appraise_hash option, appraisal of a
file referenced by that rule will now fail if the digest algorithm
employed to hash the file was not one of those explicitly listed
in the option. In its absence, any hash algorithm compiled in the
kernel will be accepted.

For example, on a system where SELinux is properly deployed, the rule
  appraise func=3DBPRM_CHECK obj_type=3Diptables_exec_t appraise_hash=3Dsha=
256,sha384
will block the execution of iptables if the xattr security.ima of its
executables were not hashed with either sha256 or sha384.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/ima.h          |  4 ++--
 security/integrity/ima/ima_api.c      |  6 ++++--
 security/integrity/ima/ima_appraise.c |  5 +++--
 security/integrity/ima/ima_main.c     | 22 +++++++++++++++++++---
 security/integrity/ima/ima_policy.c   |  8 ++++++--
 5 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 049748e3fe9b..7ef1b214d358 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
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
index e9a24acf25c6..b0856c4bf515 100644
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
index 1b6c00baa397..260b3b0520cc 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -657,6 +657,7 @@ static int get_subaction(struct ima_rule_entry *rule, e=
num ima_hooks func)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
+ * @allowed_hashes: whitelist of hash algorithms allowed for the IMA xattr
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -669,7 +670,7 @@ int ima_match_policy(struct user_namespace *mnt_userns,=
 struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data)
+		     const char *func_data, unsigned int *allowed_hashes)
 {
 	struct ima_rule_entry *entry;
 	int action =3D 0, actmask =3D flags | (flags << 1);
@@ -695,8 +696,11 @@ int ima_match_policy(struct user_namespace *mnt_userns=
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

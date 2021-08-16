Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238B83ED007
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhHPILl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 04:11:41 -0400
Received: from mail-vi1eur05on2111.outbound.protection.outlook.com ([40.107.21.111]:26208
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234757AbhHPILl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 04:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFV6T4gsZbzSGnLocZGJCmHwghH3HiQrdk3rBBw0dYnF6cmuQGcYyUYG18+0EYRprRONP0FstyPNeMI/qhoXlNJijUvUpaVG5HCQbkcCfzYETM2Pn8POJD1Hmp+wn/o144nYqxLIDosXulwHEwOx1QPeRT4lvUKz6GqnsYy0u2dFd5tewg3nhVJEw+YlwULoVU7RB1RCNY30FTeBvgT2m20Z9icN+K/Mp7AZS6vykQhVdWgzQj2FSJJMCCqT9zTUi4zbKnucC+CQ+Fsht1Kd4yV1rCfYkPBnyUUNKhf6RhqNukXqSb8P4QVBvtlIS1AIkcyDYTr1wmK9/ARldj7u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkLjR1QeU9boeuiN0dgBemRzIK/x6Nu30ebdO2ssKkI=;
 b=CBUtqu2QNoBk9Eef9u5BlmInuErl2fMYfsmZCZU5kQ1wip3JgijQzYoKlHxk3hsArDYgZfznDWbwM9p3+ryq1nCt7QwbN73C4/1kb1L3rCnElONYqfEFsCFU0P3Z38VM7lhWnFyGdqGfQTElM3Ff1B+2hGgsEJCRAIM0jNn7xl7FLo4jJ6tGknifatgTGBq9vrkDsbt1QYkciaqe3rKP9OJDKGntc+Ryu1nY1dHiqz5kNb1+hIUKNMRv/jkTRTB4X52f+HK2XGM/a0otdaBY//Xt8qOqdqjVHuNO2DLJmyIK+Dd2HRhTcEZybXtz5o3fhZObiyX9NByaCVyom45j7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkLjR1QeU9boeuiN0dgBemRzIK/x6Nu30ebdO2ssKkI=;
 b=kacRg1Skjqb/Il2+hvCe2BEIzdEt2QVN1DNv79Q3El/v/Kiv83uF/gLZlW6E7Vk94cAbZkopptn+HoiQgDjSn78NCMmeHEhYbZUwqOLzSqhFir3bwNVAfqBOFIxXOKJeBvQlr0qIaTRkeZnoV5pugLjz5WFrU8nU90XwJ08YuLY=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4516.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 08:11:00 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 08:11:00 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v8 3/6] IMA: add support to restrict the hash algorithms used
 for file appraisal
Thread-Topic: [PATCH v8 3/6] IMA: add support to restrict the hash algorithms
 used for file appraisal
Thread-Index: AQHXknY/oTIS3yHQq0eSpnviPdpvhw==
Date:   Mon, 16 Aug 2021 08:11:00 +0000
Message-ID: <20210816081056.24530-4-Simon.THOBY@viveris.fr>
References: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
In-Reply-To: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca1e9ea1-fede-403b-23da-08d9608d6251
x-ms-traffictypediagnostic: AM9PR09MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB4516A76B6A01D6FA65296A3F94FD9@AM9PR09MB4516.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRbFJ+t2Yn9kgqq+NVBxBu8wMO6KYF7WxJ17ISdGjNra0XRDOWW0o9RSQa0s8s6JN+SKsgsLnv4j7rTrdCesREhKKj+KQJqaJpajEpeHCqEhWM5TfxwrPVWFUTHot/S/xgbpB+XVtq+9S2k7B6nCA+q3L8JVVYebLkswbXUQgHZpRnuGxFzjbA0U48bO+fWIw1/zhrXmFyiCum4UvxPIY5t69gphOVk0WlqvtqnNNYfc3fyFasckTnTegv3uCmWc4LJX6ZpEjsKTkwFWgqF5lCA9HhbVH2y5w4hx0NoimYrwkILTa3halB7QBTyHByuw9eWDlDHUvM1oSShZ2TxFpqOMst9NRcRkdi5vv9z/ExPgUgXHed/n3VNqgi8J1QHOitvi5Y6/8klXZ0QQAcOMBpJvaJBIKvsbTTtWedDa61nD4TTCOGt7rpyvgY1sWG7WD4p5GSsK2zpPqGRn584/FE4a1xpCOsv34eg/dCRtr2ieyzMAprec6RvE1SrufQz5wUDj3qI8OQ3ctXzzDwOyTi0DY8wF+hLLAMHRF9s5eJ6DUrPOzdEpgjpW8hM3tYlqFb5xPViy8q4eqxwR+2h4KdPYByAEuUiAp8WXU0gcyY/kKwpraK3eGPgDhsco6aU+9KKrx66VjvytGE4EQ0+5sLdqB8bewtVsQ/vYvgP/TXmHRZzE9pH2DL9BAjvYYLH81Po1NdQ3QJYIX5atDYHPlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(71200400001)(6636002)(2616005)(122000001)(83380400001)(6486002)(36756003)(38100700002)(66446008)(8936002)(4326008)(110136005)(26005)(66946007)(1076003)(2906002)(5660300002)(508600001)(6506007)(8676002)(54906003)(186003)(38070700005)(86362001)(66556008)(316002)(76116006)(91956017)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rLADGQwpp4XaioRnbJhuZS2fWcLZUiGBBS5MivNJMuVpkP8q+7iTwn6iDe?=
 =?iso-8859-1?Q?FWddrgDZYQMBSZITodg3b3lx+fO+fFnCptgFhW+3J3+K+O0pfbw4kLD+SD?=
 =?iso-8859-1?Q?XXnKSgrK/jLKe06+UDVjIX9S/UL+kmJHqAeN8A9lyViJd6YD5RpqP/jvG3?=
 =?iso-8859-1?Q?Im07COW4Ja8N1gip9HO6TJvZBX3t+Ue/g2H7Px2oL6rNSSOFezaDjEM5jC?=
 =?iso-8859-1?Q?/rMVKjiGyI1ohlV4IW01a6MqLXvZ4ikAAstJsyJAp/qWsNUm04QJ13mMLI?=
 =?iso-8859-1?Q?JXsIL1+QmERRqw4d58ixVTuTvLSxMDz51I/Ygb/GPYVk18qwXRwd8MI//N?=
 =?iso-8859-1?Q?BBEnmQsxmMpS1S61U5rJ5t4iZw9P2HK3Jwtm9OXGh/mrRKm8P33eeSqmAo?=
 =?iso-8859-1?Q?XSDUiJbOkogB9CPbGockZ3HfoWP8OVT9PT3Dn8FuTtukvVTeqhF9ULRieS?=
 =?iso-8859-1?Q?WVa9rTQH8n/87hPtZQD6BWkp35W0Cvbmz0hnLXoXQEXbMudrwNOoQYVZ6y?=
 =?iso-8859-1?Q?Yc16XhO5rVg+yJ6Dp1RbxVNil+TeyzBo0AlCiHSHq1ZypuNOodkGHY+Qun?=
 =?iso-8859-1?Q?9cRe5lK2/uIuaJm9EAUymNlqWr4xio3dRxZ1rXt/vsHxsN2++BeCexYeoz?=
 =?iso-8859-1?Q?dJgI+/0YpvEU/XiJVwoUP9BedkXW0I3o4IEFPl61UuF4ztPcEbqGoA9qgS?=
 =?iso-8859-1?Q?2ureOlTT2Fh9qy69u68OouhaBMDQ2r7DC2crOhIvgP0FQUJeGqRHgmYOOx?=
 =?iso-8859-1?Q?4SeouqDJvxybP9agRskcI5Je69C3wNcCFmMy4uxL2TCZDlFVxJo8f5zc3v?=
 =?iso-8859-1?Q?hc83R1EXDwMGCjSFGrTqGQa2lVF71ykkGijQedd4yZePyRVEikfiOFgYW9?=
 =?iso-8859-1?Q?lZsFqcrrqsfKgGCdNyd3UGpeQ4OztcST4zuGR5Io3wtdWVd6+Nz1pe0TNS?=
 =?iso-8859-1?Q?/FrSbL1nDsFvvXoC6sEiLwrjDlwF6gLwKnU2XeNpfhGBhvONgQtD/w/tUa?=
 =?iso-8859-1?Q?812qIN33zQ7d8uwCfJpuOuLM30mbWwwxlkSMgUd4J6L6s2xYWTGihA7lin?=
 =?iso-8859-1?Q?dkQ3x9izE3WtKAztWK2OElPrQC+FDDjqzxvyFmyE6xQfXZypgaPpWDsjCk?=
 =?iso-8859-1?Q?BSP3aKUNjOU89SwhkGCzzuJasgRpu8FdIH6Qp4rdxEtGdArQcXLxEuzlTP?=
 =?iso-8859-1?Q?rW/qXPqd9djuGNJxy5tGdP+hIhpqudkm1LKOVU0Oa/xm/pufmdCWvCf0tr?=
 =?iso-8859-1?Q?yFm7sDrD/06hXqkWskD1u6IsbAYmMVVr9/rH2IzLHYitA2DQJg71AmbqcQ?=
 =?iso-8859-1?Q?muMY6A5tuR3OX0HPUBREC5RfX/z7OADHtXJOKxljzp5Gqk+Xn89j5xfDLb?=
 =?iso-8859-1?Q?YTQ6cMbaGl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1e9ea1-fede-403b-23da-08d9608d6251
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 08:11:00.4096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2CIFHJyTm6tM8ODxuQgbzAb/C7uE3AzLTBaYwOne0cYub5BjMbd77eTkKOXmBcojQhxTcLCZwSknk1iQME8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4516
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
Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
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

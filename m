Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB83DFDDC
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 11:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhHDJUi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 05:20:38 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com ([40.107.8.98]:59630
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237050AbhHDJUc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 05:20:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYbu2tODxORzooFrbgHcyfEX+vG2Z8R/5TC5nVhxr0vQc6WXcciYxppfz6UL3IlgXsN++EBA51vce0o608rqTWNT+OrNM1BfGsU6CskvIwieuZOMyqKYMJrmNEYb4byofIXMyh9BNddaR6+/pwoKXikwP5wB1anTDwJXos6gmOwGapuEQF4cMJdl5txYe7X55XrO+2zrZsZrRZhcUe9Hx1P+EIfmFDWdyLmbaKcaYiy8uJdapMZ3qy6difyhT2RH8stSHyqGDvRr50xqI4xM0yBeRzbObudSnBJVvICuWJq5RT94AA/jwT6xt60xRlaMvkwQLk0w+GZGOtJd6x6r/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/TIU5N2FZLgMOWiJIqqWnx3V+vp78jfgth3y++gQB8=;
 b=NdNGuj8ex6+z1/rI+FnQ/FdalVmbKuqzqpYokvaZ0PX3Ilbh5Mtr34voKijWU5cm3PPBmuassHysMi8f7yrGAqnblTz6ueiraJ7EjKQTTuZcImgXzLSRUXETk2lU2eHCF6B8gVh6ShDG9WJpjyRCAxvvq2n4Fze9zjvo562uwlIwqFZhLaQNmT7M0pA//85YioAgziwokg2l3D8Vi3BruY13NArq93MpAoWf9EJnuwnVlc9yojSw2S9NdMV7r2dJKsEs/e1ZAoF8DS7w+Nq7dgWRde353z+OkUJjQpyX4IiOLCZjD81AqNZLrRaVX2pCkjp5FkxfBBHM66E/FGJGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/TIU5N2FZLgMOWiJIqqWnx3V+vp78jfgth3y++gQB8=;
 b=lNqrIDZnj4pCgv5Bn4zTkxjC7tSFWk8lyivd9Pnm5IT1AR8/nc/mb6SG5MVWqcPx4rHe/YTOukRD9RQaqClnmfxqQnpn8IWwZ7BELEODibxfWT1CHjPLB7yVxzy7wI517zL5ceujFf4+brHCPH/EoUX0zuar7Sh74RvTO/n5l+E=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2545.eurprd09.prod.outlook.com
 (2603:10a6:208:d8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 09:20:16 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:20:16 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v6 3/5] IMA: add support to restrict the hash algorithms used
 for file appraisal
Thread-Topic: [PATCH v6 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
Thread-Index: AQHXiRHwT9XyeFXmY0qBhemJf3HNsA==
Date:   Wed, 4 Aug 2021 09:20:16 +0000
Message-ID: <20210804092010.350372-4-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
In-Reply-To: <20210804092010.350372-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1581efd2-4b7d-4ca8-2dfe-08d957291291
x-ms-traffictypediagnostic: AM0PR09MB2545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB2545E810AA666391271E827994F19@AM0PR09MB2545.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HcCjxbE2dJJmu/ki6AUJJ4quYce+/JlL0oEF8S7ZBafCKdyQhOkafkiy7lAktmQ5MVb4l8p5tW/RN7zQFA3j47zUlbnerP7yh3zKsYR0jy0x3vGxSmShZaDBQyBn21/a4fMquZ4O5fiA4eDtMjOB+aY7zSmiGpTVs85STATNyNHynVA5prl15zat6ozLiEZajljju0h6Fu3XlsOzvxUo7D92ivAhXPqnEYyCupxghHLYemNXRUxjL8kUWtl/mzRqoU1MiedBYAd7v7sPIY+sCAxS3B2pNbgZi+WG4xzO3z/mR8f1fhl45raWuxsQpVWC7kzOI5z2mQNcmM0joTkuoQYKhEhklGRnc73MzPLDyBt88HrDX5YuhCcVgRwnRXiVxtT4EHDhX6hMrIXKy40LVSAABQa4WQWlA5jyp5uoba21h96zb9qAF2izBjaAaydCtNsmzC6eFqyGBJDGaxf8Ckug3tmEOwOSOzxVGtqP6GG3mcD1OahMyHqySXMg7kLY0gmSa+RdDoW56E1l6DDQGlMvaJnogaU0KUrGBsiWxCmZJiolRNrMSxEZAx5AwYCVjIKVys2lUzw4qzKip4ezx29C6NVjV4DMj9UtIJbTas1oVMC2BXL98kzGHjAPfVW88Moup+uPgsgpmpOQjZG57mt44LztQkaabSskm0aV0GpWNIA7UZhcn0E8oCyyUdUfAfaRKPnhAVyBs5g2ljdjuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(478600001)(26005)(66476007)(66556008)(8936002)(64756008)(186003)(66446008)(83380400001)(36756003)(6512007)(66946007)(316002)(86362001)(110136005)(2616005)(38100700002)(6636002)(1076003)(38070700005)(122000001)(5660300002)(107886003)(6506007)(91956017)(6486002)(2906002)(76116006)(4326008)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e4jrjR1YOOLi4bXqyks/UD7l1g1WB9z370kA7v3WPQObieKkwH0UGf+/7a?=
 =?iso-8859-1?Q?wF/4kTfQvOjFdvB89MbG1rCRycthd1X+bouViNJ88od3leAenpU62nnSvr?=
 =?iso-8859-1?Q?DzZdxWdDCxGQItiXjxb60qrTvb5Q7VALHTPpH1JdctTtDdg+lEQxl/fmDx?=
 =?iso-8859-1?Q?dKTIAXwdfW/uVru2J0MEgc6QuhSVSXo82Gr7+boFByCtQRez3i9IFuscwv?=
 =?iso-8859-1?Q?+Eco5zLpfq3TwoLZdjAjr7FzUb3uxfK5t0/kIwJu6B7B0V2vszQQHIjNMG?=
 =?iso-8859-1?Q?C6IqAfeNq/ByULCq0m4Q9J4HYyoW36pRYSSlCSWlDv6OJYII08r6Hn3XAm?=
 =?iso-8859-1?Q?x5M4h7D1h0rcplddtK6hc+jPzd/TUgq5I5+ckvnPW8v+ucLj96VNIJzo6x?=
 =?iso-8859-1?Q?VjNrC5Pc5N1OdA9fW8mGGDN0vT85S09duvADZx6r6MFfXheX+t6IC9RU0+?=
 =?iso-8859-1?Q?2OmGQruyB7VsjtcGuYHG861hrq/8w1zAQ+W5kwb2evE6hExAlO/P5zjrci?=
 =?iso-8859-1?Q?DGwfIr9UP4nKUB+7p2Q4lkdTZ+L3Uj0Syi0/MRmeDxzDSDd2c/rH/TWDBJ?=
 =?iso-8859-1?Q?KwZOpgo5i3Ie9y/glhGgPd46zuS/Bly24U/+VZ6zuH6GnwopsiuhEBte4t?=
 =?iso-8859-1?Q?70x4BIEKduINKETIkDz6X4qfG+v4EISF3xffxCBDTc5vDNhWs8KMvppu5a?=
 =?iso-8859-1?Q?J2dYN4miREdTZml2XUqmkw4a9S2qZfc1wom3l76h4Uewp7fL7Spr5FnEJu?=
 =?iso-8859-1?Q?ckdBrKmEoXxCiC0yCwRaYvtvDXTmhO3dnX3lslmcdWp5Olm1BeHBTLB6Dz?=
 =?iso-8859-1?Q?n+H5Jvl0GUAEKEETvk6jUV6b3/TxdKb0eOXuKCWi74JFbLmkb7tvI4B/h2?=
 =?iso-8859-1?Q?lOYCX1DADC7s2uDr8JRZZy/m+A1gmeejitjukwZrqIVHYCMTexTMnpLTfq?=
 =?iso-8859-1?Q?X+e89YO+p7zv35VMtw2hFEwJnILHnRAsOtkyFqi8Lrwwi6ZjPbw5qBZYvR?=
 =?iso-8859-1?Q?HA+sDBjitErRx2JugCpUD9ZXvQmfaqWc949m9K/ELZfnCsCfOVJXQqrVhd?=
 =?iso-8859-1?Q?jzRhH3bw596TfVxKzhI7ZHrPlZKkE00+7Y8gX6cV3Q6coopz0gbVpg0jvM?=
 =?iso-8859-1?Q?DYxiNSNLXb/ZJj8rHIXKWrZiO9Q20hgl/9Tyjpyqh4SVxgwQv2Nt2UDgZ5?=
 =?iso-8859-1?Q?HoP6H19g3iqZN9qMDjMSSG6Ng1k/q3Rtxo13UQVEeEIrOuWS9zyWOk/dZL?=
 =?iso-8859-1?Q?vAcAEXV2zW0DMBbqZAUNnpuhE5n6FYrr/1y49ISrRGe2DoH+E6BjDKZsSH?=
 =?iso-8859-1?Q?9CVA4+R0+kZnm4lBkHKObAcCwEEvcdjD7yWMe1YcmAnzq6frK8l7ZvcC7I?=
 =?iso-8859-1?Q?3ZVCKscvhk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1581efd2-4b7d-4ca8-2dfe-08d957291291
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:20:16.5796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCQdk1dLxiYrf1g73y9RWEyDYNAgreGhRw9mjuxVqagNRwCDt5LDKm4g4E957WLcVgwytZr+oMHItA/S/44c1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2545
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
signatures, where the hash from which the signature is derived (by
signing it with the trusted private key) must obey the same
restrictions.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h          |  6 +++---
 security/integrity/ima/ima_api.c      |  6 ++++--
 security/integrity/ima/ima_appraise.c |  5 +++--
 security/integrity/ima/ima_main.c     | 18 +++++++++++++++---
 security/integrity/ima/ima_policy.c   | 18 ++++++++++++++++--
 5 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 829478dabeeb..8db0238a0fd6 100644
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
index d8e321cc6936..3dc41d997dc5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -172,6 +172,7 @@ void ima_add_violation(struct file *file, const unsigne=
d char *filename,
  * @pcr: pointer filled in if matched measure policy sets pcr=3D
  * @template_desc: pointer filled in if matched measure policy sets templa=
te=3D
  * @func_data: func specific data, may be NULL
+ * @allowed_hashes: allowlist of hash algorithms for the IMA xattr
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
index ed1a98f6ee19..9aa0334b8e54 100644
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
index b70ee0125168..205138e7016d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -216,6 +216,7 @@ static int process_measurement(struct file *file, const=
 struct cred *cred,
 	int xattr_len =3D 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
+	unsigned int allowed_hashes =3D 0;
=20
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -225,7 +226,8 @@ static int process_measurement(struct file *file, const=
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
@@ -362,6 +364,16 @@ static int process_measurement(struct file *file, cons=
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
+				    pathname, "collect_data",
+				    "denied-hash-algorithm", rc, 0);
+	}
 out_locked:
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
@@ -439,7 +451,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsig=
ned long prot)
 	inode =3D file_inode(vma->vm_file);
 	action =3D ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL);
+				&pcr, &template, NULL, NULL);
=20
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -897,7 +909,7 @@ int process_buffer_measurement(struct user_namespace *m=
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
index fd5d46e511f1..a5b6162535f3 100644
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
+ * @allowed_hashes: allowlist of hash algorithms for the IMA xattr
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

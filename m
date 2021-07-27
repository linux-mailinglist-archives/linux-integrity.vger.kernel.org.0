Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30D3D7B02
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhG0Qdp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 12:33:45 -0400
Received: from mail-eopbgr130129.outbound.protection.outlook.com ([40.107.13.129]:40010
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229441AbhG0Qdo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 12:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g06yrBdt1yqhGuVe5tCQdtS3UPl/pabTOk19IA6rP2kT0sMIVgMbijuSvfijQhTDiVifVEm5tPwdKFDMQrsins+sfu/0ZzTo6doZJXWMhFVZEvTCyCsvI3N/GHr0wP+vRqb6xy9QgkYP5MC31i4JeCD4twl/3i03leD8+bSDwyp5hOxzaueZm/gS+ShNULlNGqOVgQ/NwSk3EdRtkpek73DIqG0na1BWzinLT9aH9XOjYkXaKA6C04kC0jq95jhXpy6cPZ+2xIhDgVC844r2hQEwRm7XeU8ZT6GHyLdXH/dtCeYsdcmu6zGsawV86j1ONWbWRMZtP1Vdwf1VGIiN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFFl+D7Af7WzMuG/KyaYJ0TfcCBtrzKkuRR7GWdnrw8=;
 b=HvNorciobl3ArhPgGD2wL0X+xGBTEDRUlq5q6SRepZSRGCiFyhOx7Dwe8FhTeBZQ1XBXkiF+s1mRWpPPl0buIxUEGFJcjeVa7XJaw9vj/AUrtWdQCkaojlvCkDE718YmXaNNTKvqvrgyUGO/ZDYkRoKnkmryPs8yJAN336MIC4d59WXjBOAP0ujNMa3jJ7fca97uWfLDGudWRrxwb3FbRk46blntGQo7TKXyDvy/y5eCLBX2sjXfteC3IO3acBLcwRVKxRP0y6tMolYR8pWMzSBvznHQc2/CTjkuEuFXL0do/cwvG2RdiAVXWlx812a24zHBvS069cAiMi+fdK+xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFFl+D7Af7WzMuG/KyaYJ0TfcCBtrzKkuRR7GWdnrw8=;
 b=cWt9T9Hv9kHGyvReJZqmKRHF0r5pBt2XNv6ZHG9Dip+WUkE4gmxoMQ2kI5C6N6YBbKcLlwrQwRSrezo6ZFl9BnzlQEjzPxxc4ScDnlETK/xR2YUcF2cUiFs82ylqBiw25HdUQW/TLbNS4Jo2MTkoZcn97BFUqjEbqGa0WEBGu20=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4243.eurprd09.prod.outlook.com
 (2603:10a6:208:182::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 16:33:39 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 16:33:39 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v4 3/5] IMA: add support to restrict the hash algorithms used
 for file appraisal
Thread-Topic: [PATCH v4 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
Thread-Index: AQHXgwUklAbJH6TdA0uMJmQIZ6AxQw==
Date:   Tue, 27 Jul 2021 16:33:34 +0000
Message-ID: <20210727163330.790010-4-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727163330.790010-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8433d12-ca55-44e6-d268-08d9511c4a62
x-ms-traffictypediagnostic: AM0PR09MB4243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4243CB6B6506A49113C9474D94E99@AM0PR09MB4243.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CP+alk1WB27Rel3KnwSwyrx+KX9AZWmVWs/e6jzIFeTnNkhoYxVsmCTW3gh+0nmog4hFqsxcNLv5tizS8bo4yHoepTyjGKeUgicfdvi0a/pB+MMMlLDXRZkX6YfQoasqkcBIjpezq0th6tx0sCNRqTx4ICNN43iA0jiDZe/OyOE3MJiSukkqj2acGYVMua4cI47Yhn+1jJxhehX5FDu+R6wRO4MbXdCFoyHJk1zBbUZNvRUfkmvGCuEDbC77okV81fMNn9Y8yPoTFPO9DF+msVYklt4CZZFK+WEIBsTssAoYu4Dd6a5Pi4lHorwS5hCjO631qwpIJgSeXKbdZ2h6m3RX127K6s6TIkF3VNJ60174FIiaB5uBWyu3almrZKBmV0bnkLO0B0dLhMqAK0MTruiIP82Bk9yziss+1ciL6B3EbwJe9qyGDiDd5n8kEukPuGlFKv8XmZJAik8OXLwjDtkphYJIBB1avoRbQYNlzZmWnG1ZHl9Am8xCmMZqdcMzS5FeatEVessJDvA0q29IPRMJDEDNPSMcsaGTGEsmceLzaPv2ImxQ6ugDIrE71wwDbai9Ian5Pp1eJQx5J92Dz0kQUYmm3YTlbsAtkYPgTnC0cSyq7QoOj2LJ8YW4qWChXpllonouNDFS1oVWXXvYDRJTkzzwu0b+7L8nZDN9p+uyALkScdFByuB+Y5vuPqcFkkozsH3euLuIDuNvIWGJFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(396003)(346002)(136003)(66446008)(122000001)(66946007)(6666004)(76116006)(36756003)(91956017)(2906002)(38100700002)(26005)(2616005)(186003)(6486002)(86362001)(6506007)(110136005)(4326008)(478600001)(64756008)(66556008)(66476007)(6512007)(71200400001)(1076003)(316002)(5660300002)(6636002)(83380400001)(8936002)(8676002)(107886003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZyExwshQNV4/hkTIvGSMT2n+JFT4TW+B2YwQW787os7CVVH4SvoYbJdWkr?=
 =?iso-8859-1?Q?dVgRkPhWsNL4sPm55cprFyM8WYwMJA0XpMMFefcAFpeEbK9AUTyzOkDdKI?=
 =?iso-8859-1?Q?vxPuFQBgokdPPn3b6gQ9EQvHixV54xALwC8QeR3IoGwYT6byIPR1kTrtPv?=
 =?iso-8859-1?Q?KHsFOV8/WRYNlMP13XO/66k+L386B8kjWTQ7kGW7ADiWDFf72G4Ng47vqZ?=
 =?iso-8859-1?Q?5eucUOw9n4LWSOaAWNTi47LPBiWtGQToz5hZN/66+HBzxQiODnsoTw93SV?=
 =?iso-8859-1?Q?GiuK1jiH9OtmDmJ4yYF/cBNBZOeJe4Gf0dDiz/WNJh43Gym53XGDRRsRyv?=
 =?iso-8859-1?Q?WuyQvnyj56mhQ/4vq3sPoi7GQ8WuDxepu3KP3mfxCBLHrH25A2LztjiLve?=
 =?iso-8859-1?Q?QIixxMP92ZnjnoRRfn5OWALgg2qb+z3vqgVBRouT22Tvuc8Qla3YKJ/c5T?=
 =?iso-8859-1?Q?0XWQfZ0CaMCzfqBVppKvCzV92ypzSysCtlLlrMsbcWAybgX5/LjdJEya6/?=
 =?iso-8859-1?Q?2vLs0W6QlFUN6MHdoIr1wQv/9lAlyAHbPmGP3SJzBuaZEpUHFvSzfoPGVK?=
 =?iso-8859-1?Q?GjgNCDxk6nKPPGT3uGFg1z+V+Ly1FSj4H4DJSe1Qy5jvylri2F849W5uPV?=
 =?iso-8859-1?Q?1+58klgGRX+04sLZzt16LknWB+lNeaApnC2+2QtlbYdfxEcLKqEWSO7JK3?=
 =?iso-8859-1?Q?tlDbQMrVkn9PSOGbU06Xu9r7YxijpcNdWtsRm1GFO7Rs3g+tqm5OIWL9Pw?=
 =?iso-8859-1?Q?ERTgeiKR+v6xBDk+5OcDoMJeLO4155ZqjqrNTwHh30A7K/SSAqfjX3m0HL?=
 =?iso-8859-1?Q?DuFMHwuTWW4gZNMFCgiIKW77UI493lrMHM03cfGe9CvPs8neGUm+4puTyR?=
 =?iso-8859-1?Q?6LV4lDBcgnEBDydTgU+nTI2nffoQOFMRZPJcrC4Mz+b6uZNGnurPgmqLpx?=
 =?iso-8859-1?Q?4cz1fe5iJZDvubhlDY8i/VbPvqsCw9x3KwkjLWvj/p0tC9s5tLT5PeN8Np?=
 =?iso-8859-1?Q?2f4wPapXc71FevDS6U/unbDSS2+rsYcqeObEiUjzoEMSsezn1+sRsf71RA?=
 =?iso-8859-1?Q?yAyEdhmC0syUDSlN59VVPPiPaO0bMAFYhSM/ae7w1MAsNyzfYe+NrZXPYu?=
 =?iso-8859-1?Q?ZXttbrWq6P5IhbRYuEvtqGrasUA1OiioekxQWbhg98SUNY8S5uVBbl7I6l?=
 =?iso-8859-1?Q?590b+8a3W0ajb0vSRcXMQOr5rQDBZ7yOE9w5qng6kXnBtU6pqYDycOnq+z?=
 =?iso-8859-1?Q?0qHI895qn62pmnz149wg8IOL5rEwrBTlWHuyf5IXx3rQj3jnWMBY78tDsA?=
 =?iso-8859-1?Q?3lECk/O3HgxgvYjwRcty0/PukJ5+tPdfvrdIMMdSDIHtGWw7UnKXWGzp4w?=
 =?iso-8859-1?Q?selJVl2SG3e3J4hIAzK71BYRSsGkZfvg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8433d12-ca55-44e6-d268-08d9511c4a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:33:34.9212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQ5JcfzCIVqoQOAMhR816mBR95W4ak43CNTqSwCT8D4txm+9wQOhubQwAltz1xtKAyXJwpuRLkqW978Ekpg3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4243
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
index 989da2fbf496..f751410930a5 100644
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
index d171764230b7..8aa0a3fe00a1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -212,6 +212,7 @@ static int process_measurement(struct file *file, const=
 struct cred *cred,
 	int xattr_len =3D 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
+	unsigned int allowed_hashes =3D 0;
=20
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -221,7 +222,8 @@ static int process_measurement(struct file *file, const=
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
@@ -358,6 +360,15 @@ static int process_measurement(struct file *file, cons=
t struct cred *cred,
=20
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
 		rc =3D 0;
+
+	/* Ensure that the digest was generated using an allowed algorithm */
+	if (rc =3D=3D 0 && must_appraise && allowed_hashes !=3D 0 &&
+	    (allowed_hashes & (1U << hash_algo)) !=3D 0) {
+		rc =3D -EACCES;
+
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
+			pathname, "collect_data", "forbidden-hash-algorithm", rc, 0);
+	}
 out_locked:
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
@@ -435,7 +446,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsig=
ned long prot)
 	inode =3D file_inode(vma->vm_file);
 	action =3D ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL);
+				&pcr, &template, NULL, NULL);
=20
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -884,7 +895,7 @@ void process_buffer_measurement(struct user_namespace *=
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

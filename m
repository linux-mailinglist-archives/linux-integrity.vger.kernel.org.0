Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31CE3D8EE1
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 15:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhG1NVe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 09:21:34 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com ([40.107.0.100]:63456
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236259AbhG1NVb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 09:21:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHYMSTHc9NyNajbSEbWbEMsQS5cxbmEnSsyCv7LUa8rLzcU5Zbx+tQpI1ptT3TWsm7GKjc5wu8dJ2ntHX0+ZJNbSlcbJ6+5QLP1m1cxQgh/altoX+aZbT8UUWXnyHVfziImyp95ApatmBJPAev4u9ktWXFiPyXF920WPHqIiG8H/rXO/dIdtDPrd3KcCrH0/LapWzmoc56YGj8ZT4RzI6WeGYMTxKT32SCtPlaa01GFfereqLvqCVu8M1y6Irbec1YqGoS+gdbjXwJXVVDovZOxVgF+0nvmmci3jX8SMTe3Ytt9+62o2xcR+Inrmww3S1Di2DGzEiL+yn+kbrYq0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9HR3FpasfmEXN9zKXbw9/BDA2cEMOli7CYojW0/xr4=;
 b=obPqQVtnRRQAlMvPAGQ1J1rm7PvrumxgnDnoBG969zc5m50nQ3m+IMZ7lmxzOIVeLGybebfFo70VUkRsG3vY03BVwzvNo2nfl5tuwbi9gWkcmLeAccWPrwNuvUiypmfiNJqmWxTIi9PhbeUyOp6FWP+3fTyfAwX86eJ4lGQMZztW9aDCjhSYQ+d2aou0SRF/DyhB0FJlVAtOmcEdc93HcSsTnBCLfgq3XXcmKayG1umXzyWMVtX8ALW2hcQnvWjX9pqwR5h3kslZdPvaVRhZrNxoEeqqEWtwl8GQP0kTXcvtgVTtMN43Xz+uFAin7xNsFsMMt7Acvd/2pzpfs3utjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9HR3FpasfmEXN9zKXbw9/BDA2cEMOli7CYojW0/xr4=;
 b=mGJcNV1b+SO0Dh+n70/LAq6TxnlK8bvQgxOiMQGe5g9oy0I+Tkwi+0ZpoPBShu9baVgoSwswuLyhCv9zDMfPKmxukOeGd8BTxzuEeN/7Rb2t1YciOsS+g2ZLMOebMKcEIyMhys3Sa9WqQAan9srsMs/ea6Ik2PgvOVor02dqSTA=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3361.eurprd09.prod.outlook.com
 (2603:10a6:208:170::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 13:21:25 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 13:21:25 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v5 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v5 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXg7N3um+oBXQ92U6hndVjgnx0Bg==
Date:   Wed, 28 Jul 2021 13:21:25 +0000
Message-ID: <20210728132112.258606-5-simon.thoby@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
In-Reply-To: <20210728132112.258606-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea6b98e4-162d-47b5-a06c-08d951ca99b7
x-ms-traffictypediagnostic: AM0PR09MB3361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB3361832C706570302049A19994EA9@AM0PR09MB3361.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SBS/j7jzgklh4H6NNN90D4hAEBYWPzz43mzxsoItFYai80FoCp7RldG/NBa+dd4yIG6BLkY9Zts/eAkJIBuZD17GaxJgRRQY19Mmio7XhPfMCtKc/fDrmqMgM5JwNQluqeKknRt4DezQlS0vcUDeGwoEmYWLXmvAwCF6rwDBxUouoiYHZIHpIGbKjs69JHld+ySEDnFVUO2yX/agbUZnIutgORZv7qcrK3Nq24R3jB792qqIqTvBnKCLf+eVC6WlSyhSKGq6mfmDXi2c6rOU7HKSu9G6p/Ug56qI/VGeLzk2l8sYQ9rwzR0dQCD3y5csCgsvmNT3WfhscdfgKj7AErnApJO5sVrDtwJQY8kHf6PEIRqn0ifhjDWGvVytL8iCJ2K5937ah+Z+6f0IB6lwKSrkSVr071fjX8/3FcQjCKraezaWV5gB0MM5iLP4qP0TEzSzmShInf1a8P9/Xf+K5IiaN8N5HdPkCTQkOrG/DWgJ04zj/v02AI8VwlUW8WWyj7XL0idZoLbc9GqI2gFS0cKvxink9BFx4pz3IiZ+1Avj14g4S0WwnQXBij44GblilpLKM0StU5em/y66f9gFVl8JEFS9w2pF/OCtR1zc0k0qrHsreWlvChWNW5S3OVHqtsTWTu41vn4Ik+Tuuk3hQQMmkBOJ8kuI02uvzdotHL0+okxHQcb1clwxEyvlQZObPglOX/V0p1AAdxcbv9fnIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(8676002)(6512007)(8936002)(6486002)(110136005)(76116006)(186003)(71200400001)(66446008)(26005)(91956017)(83380400001)(6506007)(64756008)(478600001)(66946007)(66476007)(66556008)(38100700002)(316002)(122000001)(86362001)(1076003)(4326008)(2906002)(5660300002)(6636002)(107886003)(38070700005)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ypBfI7jTci2/Jn2MkyG/+VhmhZUwavYH3mMQe4Pv8n8b+eJCijVG5YQS8O?=
 =?iso-8859-1?Q?LJvxkCZsmukWXeZUZQU8CibKpd3aIY4E+1UYz59gN2SRxhjRhmlWvJUqh4?=
 =?iso-8859-1?Q?brUINy1G0gryyEzmk6G2bd2gfIkrQSdzL8w837jnQhErrRUPGXbOGMOPEm?=
 =?iso-8859-1?Q?mtnJaBZ8wQ/zMNZ7qhUBjr/8kcmJv7oHPLUOzttqlrv6XOSRjBq9km7Ys7?=
 =?iso-8859-1?Q?iVM8N82wZUTFbgT5j4kz1Pp/5Rnlgf3suOxRZEICw+EdcbyAFWPZmpqUWh?=
 =?iso-8859-1?Q?gj0Ko+tpO4mc2eK1UivAVTXKNuHgEmVipr6TAihSAeFWLNhUJ8MYgWilaj?=
 =?iso-8859-1?Q?36RYeL3asEdVC2kNw55u1Oi2sK80HHy1gVRIxUCam8zVpgnzqjPrvITzvc?=
 =?iso-8859-1?Q?SqeeEDuoWbZbzeArR0mXxi96uy4PSbqYiIg6XzBEGmIAfbxo+uo6t9F5eY?=
 =?iso-8859-1?Q?N0kt27qpHJ3tgOhMIZrXw31U6ohJPIWclRGYYIQueG87v/f73IvzReSyk1?=
 =?iso-8859-1?Q?sTBiP5kWJuXj6YZUX/gu6nPb1qOcc/H8tino5G9McuOcU4m6em+swMY3zr?=
 =?iso-8859-1?Q?oinsN+ml99ZLbdqO54U3A18/axbOLjhdg6kCh+IaMMCBEfSjcHDEVo7q9q?=
 =?iso-8859-1?Q?Ar2yWa5S3rsfWXleQOrman7d6V3s5+Ghs9s3zo+aKL+XiouopOns2wrSA2?=
 =?iso-8859-1?Q?1raM8AhxulvpqCGpSqhfyQs6aAjKrwxdLdVJCaB/rn9s4fCEo2+pWWXgQQ?=
 =?iso-8859-1?Q?knc1tnkfAg6dqL9DjiPV3MbL6/Ed+NWmU+EE3oKFoYCLEc2gZAsg6U4yit?=
 =?iso-8859-1?Q?qJUp48OYQgqqq89Uyfqk8e9xi+Txp1fg0WQrz4GNsCxAdB2yg6pceyAmxD?=
 =?iso-8859-1?Q?/7yx4KjyYFY1MjP4O2oaO2TEHM/OTrj5cU5OyUZwYSPIHfabCZS/ISkZkA?=
 =?iso-8859-1?Q?CI1RF6/OFYjcd+8qLzvXPntL3CTc5t8eZxjm+nuempyoBEcTzlgo6Bf3pr?=
 =?iso-8859-1?Q?Y8dqmfjEdACYMsZGKy31Q+DqfcwT6komhIJEnaytMATwevDa3J+Cxh6WtX?=
 =?iso-8859-1?Q?CbRzxcaQTvXJFOgvoypEMEFR8zO3631obGOWOdI+OL4gsaG9COoovWlbOX?=
 =?iso-8859-1?Q?ZuAuwlrNqdZLo0GOM+e0epdPFrige7NLTG0EKQGwHUaIO+F3JJxw2H2lQh?=
 =?iso-8859-1?Q?gWQ3/XE6gdCMU/Dqp5pTK5tbBzASnQTUq9xy602S6A4RJEBPIrNyN/5Oqk?=
 =?iso-8859-1?Q?n3I0YDz2KT8dcWuPmUsJVMnRInPq2NCkUfP+OV5kvPTobXs2LzAOl0swYT?=
 =?iso-8859-1?Q?YolBYeKju3WzWcC2XQA4uk/mglSgDZI9Kv616hkHY5k39nByXO1SK2EIbe?=
 =?iso-8859-1?Q?MJ8byPiyRH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6b98e4-162d-47b5-a06c-08d951ca99b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 13:21:25.1028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXi1uwOPwvzlKi3tKCufPhVcU0Iap3iO3AgkxdTeraKwuJDuFgekxUHFVOJjdmCfhl4/eAVYxbAlBbwuDZMjzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3361
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel has the ability to restrict the set of hash algorithms
it accepts for the security.ima xattr when it appraises files.

Define a new IMA policy rule option "appraise_hash=3D",
using the mentioned mechanism to expose a user-toggable policy
knob to opt-in to that restriction and select the desired set of
algorithms that must be accepted.

When a policy rule uses the 'appraise_hash' option, appraisal of a
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/ABI/testing/ima_policy |  6 ++-
 security/integrity/ima/ima_policy.c  | 74 ++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testi=
ng/ima_policy
index 070779e8d836..aeb622698047 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -27,7 +27,7 @@ Description:
 			lsm:	[[subj_user=3D] [subj_role=3D] [subj_type=3D]
 				 [obj_user=3D] [obj_role=3D] [obj_type=3D]]
 			option:	[[appraise_type=3D]] [template=3D] [permit_directio]
-				[appraise_flag=3D] [keyrings=3D]
+				[appraise_flag=3D] [appraise_hash=3D] [keyrings=3D]
 		  base:
 			func:=3D [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK=
]
 			        [FIRMWARE_CHECK]
@@ -55,6 +55,10 @@ Description:
 			label:=3D [selinux]|[kernel_info]|[data_label]
 			data_label:=3D a unique string used for grouping and limiting critical =
data.
 			For example, "selinux" to measure critical data for SELinux.
+			appraise_hash:=3D comma-separated list of hash algorithms
+			For example, "sha256,sha512" to only accept to appraise
+			files where the security.ima xattr was hashed with one
+			of these two algorithms.
=20
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index 344b5b0dc1a1..f944c3e7f340 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -960,7 +960,7 @@ enum {
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
-	Opt_appraise_type, Opt_appraise_flag,
+	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_hash,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
 	Opt_label, Opt_err
 };
@@ -995,6 +995,7 @@ static const match_table_t policy_tokens =3D {
 	{Opt_fowner_lt, "fowner<%s"},
 	{Opt_appraise_type, "appraise_type=3D%s"},
 	{Opt_appraise_flag, "appraise_flag=3D%s"},
+	{Opt_appraise_hash, "appraise_hash=3D%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=3D%s"},
 	{Opt_template, "template=3D%s"},
@@ -1095,7 +1096,8 @@ static bool ima_validate_rule(struct ima_rule_entry *=
entry)
 		return false;
=20
 	if (entry->action !=3D APPRAISE &&
-	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED | IMA_CHECK_=
BLACKLIST))
+	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
+			    IMA_CHECK_BLACKLIST | IMA_VALIDATE_HASH))
 		return false;
=20
 	/*
@@ -1125,7 +1127,7 @@ static bool ima_validate_rule(struct ima_rule_entry *=
entry)
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
-				     IMA_PERMIT_DIRECTIO))
+				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_HASH))
 			return false;
=20
 		break;
@@ -1137,7 +1139,7 @@ static bool ima_validate_rule(struct ima_rule_entry *=
entry)
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
-				     IMA_CHECK_BLACKLIST))
+				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_HASH))
 			return false;
=20
 		break;
@@ -1187,6 +1189,28 @@ static bool ima_validate_rule(struct ima_rule_entry =
*entry)
 	return true;
 }
=20
+static unsigned int ima_parse_appraise_hash(char *arg)
+{
+	unsigned int res =3D 0;
+	int idx;
+	char *token;
+
+	while ((token =3D strsep(&arg, ",")) !=3D NULL) {
+		idx =3D match_string(hash_algo_name, HASH_ALGO__LAST, token);
+
+		if (idx < 0) {
+			pr_err("unknown hash algorithm \"%s\", ignoring",
+			       token);
+			continue;
+		}
+
+		/* Add the hash algorithm to the 'allowed' bitfield */
+		res |=3D (1U << idx);
+	}
+
+	return res;
+}
+
 static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
@@ -1522,6 +1546,25 @@ static int ima_parse_rule(char *rule, struct ima_rul=
e_entry *entry)
 			else
 				result =3D -EINVAL;
 			break;
+		case Opt_appraise_hash:
+			ima_log_string(ab, "appraise_hash", args[0].from);
+
+			if (entry->allowed_hashes) {
+				result =3D -EINVAL;
+				break;
+			}
+
+			entry->allowed_hashes =3D ima_parse_appraise_hash(args[0].from);
+
+			/* invalid or empty list of algorithms */
+			if (!entry->allowed_hashes) {
+				result =3D -EINVAL;
+				break;
+			}
+
+			entry->flags |=3D IMA_VALIDATE_HASH;
+
+			break;
 		case Opt_permit_directio:
 			entry->flags |=3D IMA_PERMIT_DIRECTIO;
 			break;
@@ -1714,6 +1757,23 @@ static void ima_show_rule_opt_list(struct seq_file *=
m,
 		seq_printf(m, "%s%s", i ? "|" : "", opt_list->items[i]);
 }
=20
+static void ima_policy_show_appraise_hash(struct seq_file *m,
+					  unsigned int allowed_hashes)
+{
+	int idx, list_size =3D 0;
+
+	for (idx =3D 0; idx < HASH_ALGO__LAST; idx++) {
+		if (!(allowed_hashes & (1U << idx)))
+			continue;
+
+		/* only add commas if the list contains multiple entries */
+		if (list_size++)
+			seq_puts(m, ",");
+
+		seq_puts(m, hash_algo_name[idx]);
+	}
+}
+
 int ima_policy_show(struct seq_file *m, void *v)
 {
 	struct ima_rule_entry *entry =3D v;
@@ -1825,6 +1885,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
=20
+	if (entry->flags & IMA_VALIDATE_HASH) {
+		seq_puts(m, "appraise_hash=3D");
+		ima_policy_show_appraise_hash(m, entry->allowed_hashes);
+		seq_puts(m, " ");
+	}
+
 	for (i =3D 0; i < MAX_LSM_RULES; i++) {
 		if (entry->lsm[i].rule) {
 			switch (i) {
--=20
2.31.1

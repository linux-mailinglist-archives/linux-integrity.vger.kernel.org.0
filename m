Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF393CF6CA
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhGTIpU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 04:45:20 -0400
Received: from mail-eopbgr70103.outbound.protection.outlook.com ([40.107.7.103]:9089
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235008AbhGTIpT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 04:45:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCg8RaAYT/DZimZRwP2Wrs4vnHaeUGKR2QAS7YLZZ2RA4BAzShTpESIT5VKBfoauHA9yig5grlgsuBj+JZRM8gg82Jp0+JPiMf2oDXosg4qhZ8E4MBDyCa3ieRHbznGnHe0sM7IL3+QQYyySqZlB5NGXdiOpLgvwo4K1P0caz6JU7ITl6+XjsK1A1nvl8C7sZNqwaoA4SZZv05C3pwWlGh87qEURx5Is7IzikCHLkfHliAlPh56jhSFzSQTt3/yfWI9RFqT2QP3X3aZ1hYslCWV8P56wU5JoGaPpNLLPEG9sWUYTpW5w0h+GVOpRKTdgNGm3FbI7O43dJg2fPtuELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci1fFu0TRKjfcInKjwvuwq00y5j+KuLGgLJAnXnfKTQ=;
 b=KuSMe208x5WT+UKDF37PEeIKXcLGNEup45EkLsW1NDJr+KZDa9kXUrg+Vm2NwAmkkETmi9DdiDdtL5/T8MtBDrXjb0IIoxa9wcUbJxZ0gi19MB3+Q50zfAtm2yHeUxDZwFWGIOqqXpWE8dtXJt62DpeVZv+yky7wjzfy1QHKip1/VnDJAH7AkT4LE2i7HWE5Bd8c/Pl6jdPH/2vH3fpBoi/TzBgue/fLoozSSZpa1M0aaWOrn+0wlJ4596cEHY5eRhZGGi87ZkZBwXA+yv5p7BVMRR/8OBmomesQn++LXXjFWhWrdqDBTsannYlMRJjwRiPB9Ft7aE4JuO8BpFaDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci1fFu0TRKjfcInKjwvuwq00y5j+KuLGgLJAnXnfKTQ=;
 b=D3nLsjuVfR9ZcFahP1iAsSWtNK+J3onRm0PEM8jYlFK7JVLDR/9KhLIKlh+75wRKM/vxSbD5jDklCllw1cg1/H6u4UI8cgb0W7azZD5roKDDPTBQ/D7unvcjX281cD7bL46e6uLDfNhSR6zBwcTyOPCS5BDKptG8euXdQSEKUOA=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2370.eurprd09.prod.outlook.com
 (2603:10a6:208:e3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 09:25:25 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73%12]) with mapi id 15.20.4331.034; Tue, 20 Jul
 2021 09:25:24 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v2 2/3] IMA: add policy support for restricting the accepted
 hash algorithms
Thread-Topic: [PATCH v2 2/3] IMA: add policy support for restricting the
 accepted hash algorithms
Thread-Index: AQHXfUkrbrCZqEujskqoTvqViI0afQ==
Date:   Tue, 20 Jul 2021 09:25:24 +0000
Message-ID: <20210720092404.120172-3-simon.thoby@viveris.fr>
References: <20210720092404.120172-1-simon.thoby@viveris.fr>
In-Reply-To: <20210720092404.120172-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef36d3f6-2c27-4d74-1cbd-08d94b604e26
x-ms-traffictypediagnostic: AM0PR09MB2370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB237049E6C0C85A471E7C03E494E29@AM0PR09MB2370.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lXkOtu0CvZ1xmU5Kw/0TKb2X3v/MNx7/3Bsc0nsbUtQyxSEM/085I+hNVOgIGn8G/NksIvRNkbnMnNKChU4aIlZnNC2gEE16GWFnteqxpzXYsxSun6TOzb1XYpr03JBNB5lBLtFcAFnfvq5MgnCRQaQ6dYG8WDt7J83lQSggSkzxXZP/TN5yxwHbXAAW90H9fUZ+DGlBejEFv+CYWrAsAXWsbpVwy5lRAJ5mMZ8AnBwuCAKV892CGqgfNRlR8kiv8y2qI1p0ZNsYUGfhhrszRuQfyVRZ9GicGXVGphUQk3My2uOnXF5k+r6VKdkdPGT4JyNloLo9101kCBziLCRydRgv+OTkbSo/wWkV72tTKXSY/JPr5XkmTLFFh2tZFi2stguWa3QQA3VEgtXoyzqflUlS2KZzSTAI6mrmefU0gLaOO70la3yqCeqKFVBMCdPfnmXvFUlvT9jbQSRjDWs42Qt7upQ+6brB3rC9tKfgfespfvcEzdXjolpfyqCQRwOptRCTojMd82ThgrRk6atKxTHrk1L/M/4iIzTHfImKxse97eemZiRX3eBCo55rJGIZp2yCZys2RtbMseTGH8uiwmVqD8qZLTgsPS9gQnDnLX7medGEKB07eqFXNHqHZZyY+tI44eEo7zW25L/8aM1U37sMLtsFk6bwhkje5S46G2Ojmo5FHxsk7a/Z9vd3N3OOZwxeyjHAuGfHP7Ywrf5Xxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39840400004)(346002)(376002)(136003)(6506007)(66476007)(6512007)(64756008)(110136005)(66556008)(107886003)(8936002)(26005)(2906002)(66446008)(36756003)(186003)(316002)(91956017)(6486002)(66946007)(76116006)(478600001)(8676002)(6636002)(5660300002)(4326008)(71200400001)(1076003)(83380400001)(122000001)(2616005)(38100700002)(86362001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E1cCvQ11JGZwcLTbif2mWePAVK6eEVZBRC1Lru1BSfSeBSjfy2+HpRElLH?=
 =?iso-8859-1?Q?9ISfNy3QgVEF6UEUYea4lPoBPdpVaiKMjH6L1cr6w2U9jsWFJ0WyhLg1vt?=
 =?iso-8859-1?Q?R3FVSPd5UtpPOfN9djfrQTxrlVr/bCBvCJOS7RsXN5rwjGYnJJ1ywISNSY?=
 =?iso-8859-1?Q?xSYa2zGN5qkoGeTYgO6oP3NcRtYN8uiSl5YDp92wZ+0GuSNJ+dRS8g1It2?=
 =?iso-8859-1?Q?kyVsdRSuGpBEvUVtCkCivx1E+FPQJxp6PynFISQJ8lc/5E5MiPeHFWXE2T?=
 =?iso-8859-1?Q?ohMksx3UASdd5HxZggZr8zWYVX7nijabkfLY0mLSOtOqqt+WCAzyy81B97?=
 =?iso-8859-1?Q?lbDFeJ6WoLiA8DRSncscVDGHl5CLNeQvTq6qA8yhVT2HIwwOx6FXDR0f/Y?=
 =?iso-8859-1?Q?0F+AkNKMJVhFxE5cEFPYiOTxwKItJfuYk8o/sUT/9gELyq5d+i2CEW+z8O?=
 =?iso-8859-1?Q?+xzyEExNVs81C+ei7YTVQcvP14hA/kh5gUy6GQTf+0LV9zaDkfFfpBl9oj?=
 =?iso-8859-1?Q?siA0wziEyjAjTfal4AWSrVimWUgqaxcJAgtjs48IjBG89vJ6vBFJfuE4q/?=
 =?iso-8859-1?Q?pgo3122doklC83wmyiGY+us+kLCLnuMJpz4ucuQgbj1LJU2alFC6stUFyB?=
 =?iso-8859-1?Q?E5VATCon87pH2HjmjMCBzbb9Y0tV0sYWREQwZlgPus5FrPSlGrzs1td9fC?=
 =?iso-8859-1?Q?5+tMm5XViWR4/M2EY7ZqK6bZHnh3LijIIZfu6ySjl910jvCS+DbH5LjXtQ?=
 =?iso-8859-1?Q?v/5zuLLYsoXfJVSFa5vQ7SvuuxoorX/iIhI/vMCDD0i7QjDmTYrJWYkw01?=
 =?iso-8859-1?Q?ShpEK8GAqSxZNe6Srvs1QgSaAApn3fhPFnyGUQWOKi4QuozhXEUtGtraMK?=
 =?iso-8859-1?Q?IBR5fqFbZftaTZbdQu7eQpeFvWMRGAqFDvn3sP/5/bhUabXJF/Ohus+uG/?=
 =?iso-8859-1?Q?CdPhg0P0iDOzZdHkeBmsEavtZX3dQrWZHkM2JMAjag+0y3VUxPUVnujftl?=
 =?iso-8859-1?Q?9c5ne5LNMmThEoGhtbzRAst9HOqDV80JvxkcHPi/7izGWXFXLZBJvnoEsN?=
 =?iso-8859-1?Q?S8ZlCnHgQ9rwHo8h+91PT4+28/Jv0ogliAA2wfiGot4V1pFvyzsRrVJnRw?=
 =?iso-8859-1?Q?jOq8vBbFDdpb/A75mI3or2JuqdaNDzxDP/HfL2x7xTKRRJ6q5fiFJJCY8R?=
 =?iso-8859-1?Q?y9yfqn/mI+/SsJclFvRLGcXuDDRuuar8Jr+ZEYNx0j+vqYYnaz+g0BQxxn?=
 =?iso-8859-1?Q?pFNj55K2Sm0Y+ak58LXe/D/ZGkuNU95MgV2ODI+nm/qepvqOAaclp8XhvK?=
 =?iso-8859-1?Q?fgC0VdQ0wIKd/+tkLdm9MZ5iU6/9jfDcVt4SirpF4lva6yr3rh9lSsJrm6?=
 =?iso-8859-1?Q?Y2O0DtD6Vs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef36d3f6-2c27-4d74-1cbd-08d94b604e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 09:25:24.8280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNeS3BHpKQL0x1MpjjXSoLA9/gPSG43Lzh8iAqUhCI9KZVAd5OyqST/B7LI93aFO9fXDkHilJm8oaRxbUDyDtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2370
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch defines a new IMA policy rule option "appraise_hash=3D",
that restricts the hash algorithms accepted for the extended attribute
security.ima when appraising.

This patch is *not* self-contained, as it plugs in the support for
parsing the parameter and showing it to the user, but it doesn't enforce
the hashes yet, this will come in a subsequent patch.

Here is an example of a valid rule that enforces the use of sha256 or
sha512 when appraising iptables binaries:
  appraise func=3DBPRM_CHECK obj_type=3Diptables_exec_t appraise_type=3Dima=
sig appraise_hash=3Dsha256,sha512

This do not apply only to IMA in hash mode, it also works with digital
signatures, in which case it requires the hash (which was then signed
by a trusted private key) to have been generated with one of the
whitelisted algorithms.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 Documentation/ABI/testing/ima_policy |  6 +-
 security/integrity/ima/ima.h         |  2 +-
 security/integrity/ima/ima_policy.c  | 82 +++++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testi=
ng/ima_policy
index 070779e8d836..365e4c91719e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -27,7 +27,7 @@ Description:
 			lsm:	[[subj_user=3D] [subj_role=3D] [subj_type=3D]
 				 [obj_user=3D] [obj_role=3D] [obj_type=3D]]
 			option:	[[appraise_type=3D]] [template=3D] [permit_directio]
-				[appraise_flag=3D] [keyrings=3D]
+				[appraise_flag=3D] [keyrings=3D] [appraise_hash=3D]
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
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f0e448ed1f9f..049748e3fe9b 100644
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
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index fd5d46e511f1..1b6c00baa397 100644
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
@@ -90,6 +92,15 @@ struct ima_rule_entry {
 	struct ima_template_desc *template;
 };
=20
+
+/**
+ * sanity check in case the kernels gains more hash algorithms that can
+ * fit in un unsigned int
+ */
+static_assert(
+	8 * sizeof(unsigned int) >=3D HASH_ALGO__LAST,
+	"The bitfields allowed_hashes in ruleset are too small to contain all the=
 supported hash algorithms, consider changing its type");
+
 /*
  * Without LSM specific knowledge, the default policy can only be
  * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
@@ -948,7 +959,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_label, Opt_appraise_hash, Opt_err
 };
=20
 static const match_table_t policy_tokens =3D {
@@ -986,6 +997,7 @@ static const match_table_t policy_tokens =3D {
 	{Opt_template, "template=3D%s"},
 	{Opt_keyrings, "keyrings=3D%s"},
 	{Opt_label, "label=3D%s"},
+	{Opt_appraise_hash, "appraise_hash=3D%s"},
 	{Opt_err, NULL}
 };
=20
@@ -1111,7 +1123,7 @@ static bool ima_validate_rule(struct ima_rule_entry *=
entry)
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
-				     IMA_PERMIT_DIRECTIO))
+				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_HASH))
 			return false;
=20
 		break;
@@ -1123,7 +1135,7 @@ static bool ima_validate_rule(struct ima_rule_entry *=
entry)
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
-				     IMA_CHECK_BLACKLIST))
+				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_HASH))
 			return false;
=20
 		break;
@@ -1173,6 +1185,27 @@ static bool ima_validate_rule(struct ima_rule_entry =
*entry)
 	return true;
 }
=20
+static unsigned int ima_parse_appraise_hash(char *arg)
+{
+	unsigned int res =3D 0;
+	char *token;
+
+	while ((token =3D strsep(&arg, ",")) !=3D NULL) {
+		int idx =3D match_string(hash_algo_name, HASH_ALGO__LAST, token);
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
@@ -1190,6 +1223,7 @@ static int ima_parse_rule(char *rule, struct ima_rule=
_entry *entry)
 	entry->uid_op =3D &uid_eq;
 	entry->fowner_op =3D &uid_eq;
 	entry->action =3D UNKNOWN;
+	entry->allowed_hashes =3D 0;
 	while ((p =3D strsep(&rule, " \t")) !=3D NULL) {
 		substring_t args[MAX_OPT_ARGS];
 		int token;
@@ -1542,6 +1576,23 @@ static int ima_parse_rule(char *rule, struct ima_rul=
e_entry *entry)
 						 &(template_desc->fields),
 						 &(template_desc->num_fields));
 			entry->template =3D template_desc;
+			break;
+		case Opt_appraise_hash:
+			ima_log_string(ab, "appraise_hash", args[0].from);
+
+			if (entry->allowed_hashes) {
+				result =3D -EINVAL;
+				break;
+			}
+
+			entry->allowed_hashes =3D ima_parse_appraise_hash(args[0].from);
+			if (!entry->allowed_hashes) {
+				result =3D -EINVAL;
+				break;
+			}
+
+			entry->flags |=3D IMA_VALIDATE_HASH;
+
 			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
@@ -1700,6 +1751,25 @@ static void ima_show_rule_opt_list(struct seq_file *=
m,
 		seq_printf(m, "%s%s", i ? "|" : "", opt_list->items[i]);
 }
=20
+static void ima_policy_show_appraise_hash(struct seq_file *m,
+					  unsigned int allowed_hashes)
+{
+	int idx;
+	bool first =3D true;
+
+	for (idx =3D 0; idx < HASH_ALGO__LAST; idx++) {
+		if (!(allowed_hashes & (1U << idx)))
+			continue;
+
+		if (!first)
+			seq_puts(m, ",");
+		first =3D false;
+
+		seq_puts(m, hash_algo_name[idx]);
+	}
+
+}
+
 int ima_policy_show(struct seq_file *m, void *v)
 {
 	struct ima_rule_entry *entry =3D v;
@@ -1811,6 +1881,12 @@ int ima_policy_show(struct seq_file *m, void *v)
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

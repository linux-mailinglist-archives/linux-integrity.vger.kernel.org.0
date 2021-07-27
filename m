Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30E33D7307
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 12:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhG0KXt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 06:23:49 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:4837
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236186AbhG0KXs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 06:23:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzKG9aveZGGmh5BN25BKLg/33AywAvE+AaClsmh8BIM8ZGxK6JRn24SzZpfcgPstEjZDhVux0rF6ir7Bv0JXVkFaAFnaz28bhjb3tufypzYLtx7QUvvK9ni+x6NeyGaIbfEcIf3hM4uhT5kF3VEBgIZ5HQ0x2W64BYFlXKIXss3P2OLR+lb/1HzGe107HVgVeerU2VIs6sxBqu5dnjdh2OJPovNU+k12GAPUZwX8dcnto3q72uLNCWKgr/5n6a5bP9B+uKtXlBSWmSqEFZPrvjbws+H+Kg0jMD+kWfXGdcgrqWVcwo7mN322G5tETkNw3mbleSKFSKwq823kamhXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuqiuLqDg4H46p554PK93jVZLQ6W3AxkFPD95bs9X+M=;
 b=ntIu6L4Y09H9+w2v3iCr6lRh26Uc8B1WfbSadwKQQ8DO5Ni/n7cRZauZgbx2nrCZSK+BtmuoR8Pi0DsotTgT4/4zSeFcpDaDxscFuKR+CHJa/uuoKen+uPbfwiJNDAX/DsP/iSL3VyH27VZCWc+G9LojhAVhzY0rB0tJfbZos4G1Ccvfg3MW9YxsxbUO2lXIxb+Vc6KQM79CKTA4FUnrKa5CDYO2ZLlJgcaBDzOXeVm9tfrLlPLsw8dO/nZpQX0jPq/hreNwBuBljMiEUAjCs6bHdKPRmOCS+qVaoWnpAW0hRP0y0gsukWQ2BwUIUKtQlcRpyG56nbvZDsvL3zmF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuqiuLqDg4H46p554PK93jVZLQ6W3AxkFPD95bs9X+M=;
 b=fpdqxrx+KB7iaD6l/I4vrjUV/f1PaHdVOQPMscUb7K7C8jkXLttrLzwTUWbW325fUgM9lE0MlLYPlhCEYF6nJO6BsQ15GjUp8XpDMH3EIrENccoOIwjXM+ApaYVoqozyNrAVqvipazRQxl0mMNQ3QWYocPSN506xlFHBZnas3kE=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3364.eurprd09.prod.outlook.com
 (2603:10a6:208:16c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 10:23:35 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 10:23:35 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v3 3/4] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v3 3/4] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXgtF1pRaUiKF7xUWdp+GcV86ATg==
Date:   Tue, 27 Jul 2021 10:23:35 +0000
Message-ID: <20210727102307.552052-4-simon.thoby@viveris.fr>
References: <20210727102307.552052-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727102307.552052-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0e8bd24-e30f-4488-0401-08d950e897b6
x-ms-traffictypediagnostic: AM0PR09MB3364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB33645E14E8A5EEFC27DE11C094E99@AM0PR09MB3364.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYxcfOdDHfJBPkH8GPw1x3WdxSIUAtkUOk3LdhO48QOs542419FtB112MPpOQU6WQEgDr8Uyyfy003mlxoJc8vSid83mx1YQsITA/YDuKSKzP8P/pbDbi1SyL3MOSWyeeJ1b8XRebmoPcDqgClxPclTROqH2nfdktNuTnbQIWDBhaguDrihgb2baZasW6av3ogw+rAr2ivCRwRfba4jpR/KB1pe+j1z5a6AYXLfFwE81qz1iswEryxuyUJfITwW1LGHHVmUrS5LDdR8kQAqaIRjg7Lej+p8+29PNhOvq1Jhd513IPBLx6aa2XjS4vOUiGJiLNuhtS32VlJDMkbfR6E+RV6K0QaJKb7eG4sp2ynp7yBW2SMEylaJ7YYnn4R8JDF3H+ZoMnefx+0YDzlSZIQJKESuQMZoNTOagXCltz6yTS2u5O8fYRIWNm6kQY2jyJuCTq04XXX5eqWJt8fASdL7I3A9kvJqNFW5ZzJQhYi+hnt1wkVx3Sn8xjYrZEVJ9rKLMVJJUr/4aflHdiEl4QFrL9OUwnSNF/TuPbDTMSWt6GrauctIN9/A1Lp44lr+hldB87T9s6C55cIvHmG2ZJk+M71IJQaftMu6ApGX2UBgFQOt1Opk/eQCgutOJnU2G1jzpE73mSc+bdIy1xAHSa9UOVQpVMUwLJogmccZvVGQkCbBUCW8y8lE6f/s5BA6GrL5QLYcAon35NEpG8XSJcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(6486002)(122000001)(2616005)(6512007)(6506007)(478600001)(8936002)(6636002)(66946007)(2906002)(316002)(91956017)(76116006)(107886003)(8676002)(186003)(66476007)(4326008)(64756008)(38100700002)(86362001)(5660300002)(110136005)(66556008)(66446008)(26005)(83380400001)(36756003)(71200400001)(1076003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jsepJQT0hh4h5zb25GZ0Pl9wIzTohn04fjvpQu7ft3BSuKHeCUId7JbdmC?=
 =?iso-8859-1?Q?FK4BUq7RZsVkkFzaI7/IWve9p9xIwJO0BBUQyAbUs6bdZudxk+b+0CQV0R?=
 =?iso-8859-1?Q?gLwQsMsGFtl1KyABQTNKHigonEJ8NlKY07/rRRftVVS7imsK+jqJ7w6zmr?=
 =?iso-8859-1?Q?+jQo2ffZ39PWdNuRCXMmKuYsNjMa6E0W6pa4rG4VDIhtjNqWj6/X4I6ym5?=
 =?iso-8859-1?Q?+7TgwITfwpX8YTYkyMMIe5Rtrf7Dfpp9M0QiZpKPsbWJCzPdYeEqDayRrB?=
 =?iso-8859-1?Q?ogYcyOON3Ww387hfYl+U1FC4uwkbnmSotkLmnIPUUh3H1MA7Nd5uW57VxE?=
 =?iso-8859-1?Q?HtN5u7w5MHd9avnfk0HvMRv6iKlbLsa6pCakz9xl9fw9fJ7bYmL3vJNGyI?=
 =?iso-8859-1?Q?IE14GABJw2kYkEuEOmhgEVMbe7oj83/WiVs/9Tx0/mjKODO9OCfEONsA51?=
 =?iso-8859-1?Q?3oDH1+bEsow0+ZDjQdwRh9wcpVYidXwO4UDx8M9F88i5cl6z6OryqLqNRY?=
 =?iso-8859-1?Q?jiMxK1GH3O8YoGX1Qp5GKaEN00AsCGXBKu9GcgRUOHbEPqYJ2hOtPvilVd?=
 =?iso-8859-1?Q?ufGkFz2vNFgXg4jvqO7F3aXpRIMEtHmNUPbZK0xItKYpSHeAW0V4PcW5ug?=
 =?iso-8859-1?Q?weJ+QHunUuTy6ZNGJXm3fdWDmQ0f73eb96AcLSM9DvHgFFXx7Js6JRGypI?=
 =?iso-8859-1?Q?AW8MxA1fsGesWcuhoddVNDGdj3djOae1Dukuz08Nrl9yKqM+i7yMhsb7M9?=
 =?iso-8859-1?Q?275HVlTUPDRV7czkbC2DBgHfxB5YIGWIuVWKbSmL0OcCtQF/d2ANtC0jcn?=
 =?iso-8859-1?Q?e7dAqb/iadY2ILN1PyUmiYI8VrAKwfdilnhKWF9085na4mYGbqBTgsS5iI?=
 =?iso-8859-1?Q?izwzB6JxNTHPAm7cALq7qX6bv71NWC+/ywqwkvRd9RkkadAVazpXyY1Uvu?=
 =?iso-8859-1?Q?Pv/KcGhX1j2jbGWToMgO9KFc0RK8fkW0z0bLfpyGPl+3an9TWSXLiAEa1r?=
 =?iso-8859-1?Q?5L30/p8p19tutc66hn1mpQAcR6JQnd/w2qvlxt2T7yfviVRW01XD+BY4Ux?=
 =?iso-8859-1?Q?X3odFG7AWVEge0Wk0qTcoPjbgwIv1LU3FU+q0+nYI3m/EpDFW/blfE8XSq?=
 =?iso-8859-1?Q?JYnun9uRcteuHKpSGsbg5kQGKiNAsX3IKeq0AOtKOUn1blNj4WMSfJQbw/?=
 =?iso-8859-1?Q?AEF6KZx9hZuvCkrX2stVsx/AEfhC8RLPOIit6abhpCrVt4GcP3H24oeBE/?=
 =?iso-8859-1?Q?aGpp5bJP8edN5ZUqf5ynaohI7jxaftfyxII6Dazn6iufQgzRmzaBNFiezQ?=
 =?iso-8859-1?Q?dINsNho8QPLBUa5QDR2LJtTj4i+glbM47xoBdXx826l3yy29yi4fCpBn2r?=
 =?iso-8859-1?Q?rlwlSAbSIs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e8bd24-e30f-4488-0401-08d950e897b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 10:23:35.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4uPcsqwVxUnm/vShYJwPpQL3pd2ZELcdoCU+xg5Ht52snpsmkesTvBhrXLsW2uQPKvkEmsuff4Kkyh+TT/51A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3364
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch defines a new IMA policy rule option "appraise_hash=3D",
that restricts the hash algorithms accepted for the extended attribute
security.ima when appraising.

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
---
 Documentation/ABI/testing/ima_policy |  6 ++-
 security/integrity/ima/ima_policy.c  | 72 ++++++++++++++++++++++++++--
 2 files changed, 74 insertions(+), 4 deletions(-)

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
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index 344b5b0dc1a1..a7f110cbbff0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -92,6 +92,7 @@ struct ima_rule_entry {
 	struct ima_template_desc *template;
 };
=20
+
 /*
  * sanity check in case the kernels gains more hash algorithms that can
  * fit in an unsigned int
@@ -962,7 +963,7 @@ enum {
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_label, Opt_appraise_hash, Opt_err
 };
=20
 static const match_table_t policy_tokens =3D {
@@ -1000,6 +1001,7 @@ static const match_table_t policy_tokens =3D {
 	{Opt_template, "template=3D%s"},
 	{Opt_keyrings, "keyrings=3D%s"},
 	{Opt_label, "label=3D%s"},
+	{Opt_appraise_hash, "appraise_hash=3D%s"},
 	{Opt_err, NULL}
 };
=20
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
@@ -1187,6 +1189,27 @@ static bool ima_validate_rule(struct ima_rule_entry =
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
@@ -1204,6 +1227,7 @@ static int ima_parse_rule(char *rule, struct ima_rule=
_entry *entry)
 	entry->uid_op =3D &uid_eq;
 	entry->fowner_op =3D &uid_eq;
 	entry->action =3D UNKNOWN;
+	entry->allowed_hashes =3D 0;
 	while ((p =3D strsep(&rule, " \t")) !=3D NULL) {
 		substring_t args[MAX_OPT_ARGS];
 		int token;
@@ -1556,6 +1580,23 @@ static int ima_parse_rule(char *rule, struct ima_rul=
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
@@ -1714,6 +1755,25 @@ static void ima_show_rule_opt_list(struct seq_file *=
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

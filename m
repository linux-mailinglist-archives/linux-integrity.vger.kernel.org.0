Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9273D7B01
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhG0Qdp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 12:33:45 -0400
Received: from mail-eopbgr150132.outbound.protection.outlook.com ([40.107.15.132]:37894
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229831AbhG0Qdn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 12:33:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX9CndbTR5babzmWGAdC/0IpIm+Ei3fEwmk3gtI9jCADqHTigBR9tyrPjSccDpvWLVRYgEFNNPHcQas2/ZRunW4t96H1VQayQ1ZwK7MnDxOjEWKn0mcoc/vnDbswsC8xkNNO13ayfUq7kplDmVEcoUXFh5q3jYY7VPmun++6/reGd6G/NY4mh9mLNQqkY6eMApeDZIgwcIpqAX8/ZmCZdnlHBJu6ZXMY82h0SGOavVworDlGjQGGkbUHU4kO15kixZ6ThtpPYQ9isFofr83YDZxgKXHbip5A6FDL6uRMO6G9CgJ5hTR2Dg5A8dOQOzrmDmji3z8wIPBf31Np+BV6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w77eN8x1rgvT0k9FQrcK8P/CB01uSJWX59lgD2kU6tU=;
 b=gA+AshB0gMIojS3JVtjZMfHlWLVpLKBaHK0mitml5GccqYXmcKPKoGckmpa+6pfm9Mw7xCclqdXaBCt0Sq+/Dkw0Sug94eBBHvvaFnQi/rU6bHL4FyHyZbpsj7+crHFUoMfQ3gtz8j2hogq9EwUBqmYZPwUjRv4WsE4dZ3vzoOFtPTdKLTRUienPSi2ZJO/WBa6Cat5QO4fHqF003wGjOYB8TSENNlSY2rfQyGydcIwIwu6Q7uOBxcZZsAIo9LR6FVO8W2BeqDJoPosOk5X3sOodOVwgmMJ1NR5uKwtOKITewRvU2t7/3UIWrrN/WQO/l+agS6IbYA6XgSz+I8Ou7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w77eN8x1rgvT0k9FQrcK8P/CB01uSJWX59lgD2kU6tU=;
 b=EDg+g8t9obOv1xPAIH+gr8Fp94DmjTUuXQmOBSPz0FdAFsfdVAxYtI3Qe6Te1d5UlPSaaXbYgYn+XIrofKptw5NTkEeFcPGheOfNwmRMx/ZBAl3r2YR3EDMNf+QQ3rgkAL38Z3RQvu7jp5AAMFvph4AjONaOBKwaIqZbAQDowQc=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4243.eurprd09.prod.outlook.com
 (2603:10a6:208:182::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 16:33:40 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 16:33:40 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v4 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v4 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXgwUlxwiCOsAhwkeORDl+jS8LHA==
Date:   Tue, 27 Jul 2021 16:33:35 +0000
Message-ID: <20210727163330.790010-5-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727163330.790010-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5e8b9cc-de12-4afd-169f-08d9511c4a82
x-ms-traffictypediagnostic: AM0PR09MB4243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4243AD3E17AEE3BD9347B19D94E99@AM0PR09MB4243.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OupXHkOjr5N1mlXhqKyK4fwugzI33HfX4x7EhKFtyi0f5MiCSCqYAYdbp1lgZhpAoRywMBkV19Il0I5+jT/zeE0UlfQ4WgPgZm6FGIH5/lq3l8w2/vjRLolRmmtN+S2zATIYdUGLWQOQMOzo2jRfnm4kFgbv2VTLLwkyZrKK6cL6t5/gjEDkG+2PgSSxjv76WpggRdAE8IovfbSLWtCn9mlYw3I/oKwO1hPE1WAJU4/1fqrwDEzsglxTmj5hab07kkviGWE/D0cTR/U7/V8dEVIsZZrKAMaLStB4n5KUnwKPg45vZA68n8M1NjN0ppNzDO6TM2J11pnUAh+b85BhIywbzslrrun+Voyv4Jkz8fJ6dwhhjYM8LtFJQ6IhKezIBjm/Gkpq+MOTYiQBsbhZg1w23iOEye8M4Gs0t9n0DQQn6j2TDq+6RtWdP4bQ/2zc8rgc8zoahWqIJQqKJHIb8eS0z2KaoN7+XsnTYVJ24zySfp4ywuczZu+/axYFud2H9Tst9l+5k95qCCg+lj78TJo3g8Hq9f5W2a+fXtM/I5kJXshMeM0RAnp0befHdAJnROtz3Fq79Gz/Xpy1V6AT77vOdBuQEj6/V7LFSNR2awx1mR9kip+SKpkD/xnwx8OH7l1hS6ShrmjlfjcfcbntrINsI95LB401Ro52P76EfAigQSnKutHnbic0cY8Vp79QyAgPEgyik80tyr4Lv6ThCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(396003)(346002)(136003)(66446008)(122000001)(66946007)(6666004)(76116006)(36756003)(91956017)(2906002)(38100700002)(26005)(2616005)(186003)(6486002)(86362001)(6506007)(110136005)(4326008)(478600001)(64756008)(66556008)(66476007)(6512007)(71200400001)(1076003)(316002)(5660300002)(6636002)(83380400001)(8936002)(8676002)(107886003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?je8xoID7F+nJMSl08VPn63iZOhKWnmfbMN3rDyMH5sk/rNwA90HusGkqQc?=
 =?iso-8859-1?Q?tVu4qZeV7quH7PbdGjX4+xp5T5qdSbWGQq65oVwWfguD8yR/yUi2T8KvkH?=
 =?iso-8859-1?Q?xLnRj3VxdhlBVWfrVveQma6xX28Wn31b2YKcPQVM4zvmKWNsPSl+izuYD1?=
 =?iso-8859-1?Q?nVVH5uxHDEQWnfoFb5gdbmOVL8wChjWUj6Wb2Jxo/HTZIUbw5Bxc1qbcX9?=
 =?iso-8859-1?Q?Y/1dtZzMqxhSk4OjUvofs+byjSHY0yF3lhYmAy+Ss3P0DfxRQKzncnfdom?=
 =?iso-8859-1?Q?kM8aCTS9/rfptYgxA0Qhkq51cpYWBLsV08z7uON0zB7ULGopKbICSYrn9v?=
 =?iso-8859-1?Q?LAehQsLI66qbE8yjcIT9NAWUCWG+TT8o/HNlPgeipjhHMWwdqN5REU+wzD?=
 =?iso-8859-1?Q?6v2CkIGDciw9AWvY6RiTYDaLgknpy+e5MsmuXOZ9bHXn2LnWxHTDLqrndv?=
 =?iso-8859-1?Q?4xkmjvnP9UwUdZGhOOn61+paltSV/JLhQyhxI3GRc6etbNy4QiLrcB4LkI?=
 =?iso-8859-1?Q?aVl61kEhww7nCq9tS82aAa4Xb8CevntI5c99KryR4irwDkECEDilnOGPDF?=
 =?iso-8859-1?Q?Mv5vIWV5xWbiB23z9PphiGuG6Ot0431CN07etEh0u8j+qZllQu6AO5lxO8?=
 =?iso-8859-1?Q?IiOHW1F/s/oXmNHXCxvjR+RoQxvFxM3wuGXAMUNkwZxn9WDs1VPnUJCBeT?=
 =?iso-8859-1?Q?ppV7oAMsm3q59luTxJrqadCvOETslhoIi9hSVNi4uQoL7R/drlRbPmBZbK?=
 =?iso-8859-1?Q?NlW2R4PJXag0uE+g1BjuL6zaBh+2XfOug0QK/9fQBX+/qQtRWUkNnFwz4N?=
 =?iso-8859-1?Q?ng/56rM+0dz/enQRxxAKUtgg00XYvDBcdaIE3grmh5wMzJyWIJBCrlBJeU?=
 =?iso-8859-1?Q?a7jTYpJf0rq0ApkneTScPs5zzcZSKSbORA6dcr5zW5tC2rYWAplQtK83Vz?=
 =?iso-8859-1?Q?yq3C4pmDE6ScEdoC2tZfkdH/Bd75CrIH2JCy+bLeC0hGyGlvZYJbaHQWgR?=
 =?iso-8859-1?Q?xWlU+6gbSGCbKA7ttXWQnbYKTRikXUih6fD/tGWSoNISukkrz2S0cIvhwI?=
 =?iso-8859-1?Q?RYVDuv/iP7YgqkQ/vVpqXQLsMZThNvSxqEOdaiMpIgaJTORI2ObnJ/CGjH?=
 =?iso-8859-1?Q?AvhYZn2e8iHFgLSl3TLU04CdOOiNHTZAzSgRMM9Eym+Kqzvcw0Ikl2SZeE?=
 =?iso-8859-1?Q?Gkp2BPlu6W1tI0fFYsvZcvRewPycKOAYNSFJTwpTdgnoJvj0QSR07lzog9?=
 =?iso-8859-1?Q?lDFLNgmrOZyNvEpqyLlO0yr9VLrhIbXJOfP4C3QYWPF1dLYg/Hxnz3NAWL?=
 =?iso-8859-1?Q?C7NFbVwIa+kL63NpBt/7ncAw/FuKSyUnUuPT/7Y6KIHn4Dou0x3Q3lm3I8?=
 =?iso-8859-1?Q?r8Dwqi/7CkeqqaV/JG/lnNBWRhP2EQ0A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e8b9cc-de12-4afd-169f-08d9511c4a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:33:35.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AD2BrUng8QbBemXZpEhok0O1FpgX2EUpQA7AsEW485W2baQ8IbBcFp2slP1ckSoGqjCdT+RfO+PWj6pzAwv8BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4243
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel have the ability to restrict the set of hash algorithms
it accepts for the security.ima xattr when it appraises files.

Define a new IMA policy rule option "appraise_hash=3D",
using the mentionned mechanism to expose a user-toggable policy
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
---
 Documentation/ABI/testing/ima_policy |  6 ++-
 security/integrity/ima/ima_policy.c  | 75 ++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 5 deletions(-)

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
index 344b5b0dc1a1..aadd95753229 100644
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
@@ -1204,6 +1228,7 @@ static int ima_parse_rule(char *rule, struct ima_rule=
_entry *entry)
 	entry->uid_op =3D &uid_eq;
 	entry->fowner_op =3D &uid_eq;
 	entry->action =3D UNKNOWN;
+	entry->allowed_hashes =3D 0;
 	while ((p =3D strsep(&rule, " \t")) !=3D NULL) {
 		substring_t args[MAX_OPT_ARGS];
 		int token;
@@ -1522,6 +1547,25 @@ static int ima_parse_rule(char *rule, struct ima_rul=
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
@@ -1714,6 +1758,23 @@ static void ima_show_rule_opt_list(struct seq_file *=
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
@@ -1825,6 +1886,12 @@ int ima_policy_show(struct seq_file *m, void *v)
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

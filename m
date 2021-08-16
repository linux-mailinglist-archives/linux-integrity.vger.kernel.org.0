Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06CB3ED005
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 10:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhHPILj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 04:11:39 -0400
Received: from mail-vi1eur05on2111.outbound.protection.outlook.com ([40.107.21.111]:26208
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234732AbhHPILi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 04:11:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUhvNLb10vNO2RBOSbAp4U/65DedL9GB/Q50ZbWmFvp/ekb6ayMKJ0BLpVg6ro2ALuS2Fu6LXE/J66RyMwE7sQFQ1/vng6afj2rUwS0yvDaT00ybm5cX7s1vpO0NRo0arh7xifP/9N+7S+5e7YKCdbV7E6wyQDDSakfP1L7vQ4sxd9f77woO7tPF7uXUj17Oaa+6iRv0xNJU24+3EIFw7hN+MPsS5AkABaDTyeryoVUCQGvVLxPvuhnY3prAqaD5Q6MedZFxLqHOvssjRE5zoubh3GpLYQoczIehQLUPy75p+LKXYHwTcNa3NpKOV1RV7RL3d2rZgTwKt6WsvQoYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk/3jL92HL9n1OuBzAAE4njqjN5OcAzPX5Z+turhasY=;
 b=jvM/lP66uFAdb0HePEO6Uh7Js65X/oQ/jpQ/S1xGcnFXV30j2wSEovpCGUshF11X9aDiYIlVvMTYociMTt6Vvc1VxWuIwDd5AEU6tZycAcd2wq9Rc0XeECvXAHC+gE8LME2YnN/Fdj8irqHPw1xpNK7UENC5ZKbyxdXj8+yBBYp1JfUgKLaiG2I3lUJSBlBrxV14o18d+w0eSdptiwuVCglHcU7l+jMWnJW1ztnjq6p8POZzilBHsMsNi6y5i5mAAx8mjfFSHjMDuROZ9rDHK644ClNyWfwsHvcnPAcZdkYrnZImbdCKR8GHlY1Bwr9ovjUZ9KlSAAKqemp+mKZogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk/3jL92HL9n1OuBzAAE4njqjN5OcAzPX5Z+turhasY=;
 b=C9zspP5jXjx+IOncOtE13T6nimjLucUC1n5Fjc3Q2/7YWlKYDLyRSR099LAR/C9Wev8nijnVBgsF7ToGUfAQjMK+Ci1CSHDGM3FTqc7+lP5WkOLNHbipd3uE3MVWCp7Pe2AvezTITOBWxpMxbKSabaeb8lWuRsm/7Sl+uSJ2dmk=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4516.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 08:11:01 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 08:11:01 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v8 4/6] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v8 4/6] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXknZA2tcwmmdQXE+MM5n+bbjdmw==
Date:   Mon, 16 Aug 2021 08:11:00 +0000
Message-ID: <20210816081056.24530-5-Simon.THOBY@viveris.fr>
References: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
In-Reply-To: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d181221c-e2c5-4ca8-66a7-08d9608d6294
x-ms-traffictypediagnostic: AM9PR09MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB451665A50236A4F91F7C996F94FD9@AM9PR09MB4516.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uIWVmpyr2/5zG3oIG5bhzfNF0El5r8X06EEcOx63o89hQNHTQ8Fetjqx+9TnD2F9iIGgoIyrup43YU5KRT7JSpVIPYpAOuR7XRaeNPKbfQuQE4BwYe3mY3jjpgB3teDpX+Niyak7c+yTKrrXfvCZlLOjDvXWbHksJkOIU5BpxtnICeusPUDnI/IUY47cxrgtIa39mDQwehJGuPy2neXWJflLnextg8s3T7xJ0XUP1JuSut8y7I6iM2Sd2ovBrRYH/ZIWjsiHDpc37OXj55gFw3rOyR4LKfWSILWZ0lsmkhR4h+GU/EnGUczc14AhCc8EB+uoCU80h48TpcW0lcHTE8JCl14JkmBudphpFcbyVF/6U0ViFAWUyw3nvP7u32rTz9Uu+01gGXFCBz4nqBMj5jOPtJ4B0ow7zB2l28NqWj/0Uuc/puBsMkMi6PQQ0KCLkIWC4CqrRgWEJ+13BwP7UvqJJI2eLNYvEPd5Enq/ynSwqZZmlKGQkTq91PhFgccp2Al82Ywuc+YKjc+Xg3sXsCki5fidFdHcKqmHwk4XCh4VVhWJC2/E7E3Lfu7eDAgoakXED9vmExtWh5oieWXDFV5bjk9XW+tq6uZRI7z/M9PzX6cf3X9CkmKNNrfCErn+R2gC8/vBaNACpCiBS+ed2nwpQVvph+8hCONBVwDTIsGE8m5SuQJ2KbZ08Kk6otKosemYDKtfaVTRjAUMGugSyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(71200400001)(6636002)(2616005)(122000001)(83380400001)(6486002)(36756003)(38100700002)(66446008)(8936002)(4326008)(110136005)(26005)(66946007)(1076003)(2906002)(5660300002)(508600001)(6506007)(8676002)(54906003)(186003)(38070700005)(86362001)(66556008)(316002)(76116006)(91956017)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m7fYdSXI78VvMrPDsc/u/CYPt1RKz/NjiDeIanFY04pGfnmccQTJCv9RqB?=
 =?iso-8859-1?Q?AKUApJuYsUiUkQwlMeKWAaWhJqwX0J/hFdtQcKkr7QPJT0VvLGWTqYIWiy?=
 =?iso-8859-1?Q?MHAuEYMkdyCumb3tO7M06p6G2KG8TqfAbPnsG4uVuC+BQEOxKHw0ha6HzB?=
 =?iso-8859-1?Q?5TjpAgVSTs/eecW2dRrn1fSS+q1C7K6ZbEnHHw4Qql9ZhFCIPqCN4BfYPy?=
 =?iso-8859-1?Q?NdzJhvPam/kGWcK3rtmV63RkxojW1swAwaBhlp7SvYCXPYwLxe9LA1dnnb?=
 =?iso-8859-1?Q?JSI7Dg7pz3e38ix2Kwtcv0gfMcs8YpzBzNfVie9Gw/mWa85WaIeYhO0LL+?=
 =?iso-8859-1?Q?zQgj0CkxMy8bMyQIgUbHkydU7hJ8lwC0VE5vmiVhuCshRSEG72qzwP8z3M?=
 =?iso-8859-1?Q?vL+IDxKAPRTt9dobKnUM1Y+rYaoh19MNgwLQHrzAzgebcMB13ai6kVC1et?=
 =?iso-8859-1?Q?RPBqctbg/DttjCAq7/sRve+rTOOdhNRAmdL+vRdYoBiVdCcecfHU1IwHyb?=
 =?iso-8859-1?Q?4HlxEiEog7b9erGXU4a9Z+j6BAKSgjntL+4njSeWpbhZo8AM0q3pQDDURo?=
 =?iso-8859-1?Q?0o2KrEAEQ6RJUmLio2OwaUd0n7Nsv+5d0lUeTFV6mOptidZ/Ku85Rthg/3?=
 =?iso-8859-1?Q?xXONhJTncOO1fQw88F/Dfcy1Czr4XcmBWQXeg3byLN7FMl1Krl59o1lOfj?=
 =?iso-8859-1?Q?m/L1SL8FVwoUAdY3y+udjpuEZ+2VtJuawcSkCiyBD22/uztVXVe22d8szD?=
 =?iso-8859-1?Q?g1cYpUpMTv7AsrDMqG5oRDoqNtMoSDJ1GkCFJZLewvRrBTCzY4ITS2nysi?=
 =?iso-8859-1?Q?WK/6KfoK5m6YYDMeP1Ri6W7rblX1vO4S0hr3fyCk4gXS/LUL6y6Ng/gWFI?=
 =?iso-8859-1?Q?w6v8jsx2nKXnaD+GE9xy8+lUBEGgXU0j1DNoYFClXz7Rb9BznKDRM/mjbN?=
 =?iso-8859-1?Q?YtptjzdZ+Iv1mysXmbLReUO5qCnW5GeZjhe7MQCeT+CdMptsy0bpM1a9ZW?=
 =?iso-8859-1?Q?/HlzdAR1Xhbsg2Mg6FrTzsFgEXRRuMyGxNk7yR6xE247mAgJta33S6Zv+K?=
 =?iso-8859-1?Q?yEo26oeEZR/K4U7uDctmMJwawcZM8uf4t+T16d13Nb01T+5qz3fEILLRpW?=
 =?iso-8859-1?Q?ilcTGobPnsoYvyUMzBBJeBsSAndbcaWx9zw9aIW2+doQxSLLDxjw5kuelb?=
 =?iso-8859-1?Q?ptLDwCJ3lGppPLL3xHfDSpexeNkvtlPxi/tDKuBECdvdskK5yQtLV05Qhq?=
 =?iso-8859-1?Q?YsCl7xT3ZL3kjU6tJyU+Fjw2lb9Bz83a0ZRjiQH4TBeDkxcXzIDuHH4qKX?=
 =?iso-8859-1?Q?H2/OxHGqFkaxK5DUsbZpmg/he3/kfECV0UNl/CcSlI7RyqKTg/N02kobS2?=
 =?iso-8859-1?Q?sFsmroMfRS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d181221c-e2c5-4ca8-66a7-08d9608d6294
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 08:11:00.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwbLt7lKh4J19fj6NIVNFcPob7pATFz+YuVSAUwWkZ6+jQui9PnnWEdKfqax0eQrqIjzovheZednoRZvW8l0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4516
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel has the ability to restrict the set of hash algorithms
it accepts for the security.ima xattr when it appraises files.

Define a new IMA policy rule option "appraise_algos=3D",
using the mentioned mechanism to expose a user-toggable policy
knob to opt-in to that restriction and select the desired set of
algorithms that must be accepted.

When a policy rule uses the 'appraise_algos' option, appraisal of a
file referenced by that rule will now fail if the digest algorithm
employed to hash the file was not one of those explicitly listed
in the option. In its absence, any hash algorithm compiled in the
kernel will be accepted.

For example, on a system where SELinux is properly deployed, the rule
  appraise func=3DBPRM_CHECK obj_type=3Diptables_exec_t appraise_algos=3Dsh=
a256,sha384
will block the execution of iptables if the xattr security.ima of its
executables were not hashed with either sha256 or sha384.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
---
 Documentation/ABI/testing/ima_policy |  6 ++-
 security/integrity/ima/ima_policy.c  | 74 ++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testi=
ng/ima_policy
index 070779e8d836..b0e3d278e799 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -27,7 +27,7 @@ Description:
 			lsm:	[[subj_user=3D] [subj_role=3D] [subj_type=3D]
 				 [obj_user=3D] [obj_role=3D] [obj_type=3D]]
 			option:	[[appraise_type=3D]] [template=3D] [permit_directio]
-				[appraise_flag=3D] [keyrings=3D]
+				[appraise_flag=3D] [appraise_algos=3D] [keyrings=3D]
 		  base:
 			func:=3D [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK=
]
 			        [FIRMWARE_CHECK]
@@ -55,6 +55,10 @@ Description:
 			label:=3D [selinux]|[kernel_info]|[data_label]
 			data_label:=3D a unique string used for grouping and limiting critical =
data.
 			For example, "selinux" to measure critical data for SELinux.
+			appraise_algos:=3D comma-separated list of hash algorithms
+			For example, "sha256,sha512" to only accept to appraise
+			files where the security.ima xattr was hashed with one
+			of these two algorithms.
=20
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index 1536e6f5eb22..cb86da0e562b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -960,7 +960,7 @@ enum {
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
-	Opt_appraise_type, Opt_appraise_flag,
+	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
 	Opt_label, Opt_err
 };
@@ -995,6 +995,7 @@ static const match_table_t policy_tokens =3D {
 	{Opt_fowner_lt, "fowner<%s"},
 	{Opt_appraise_type, "appraise_type=3D%s"},
 	{Opt_appraise_flag, "appraise_flag=3D%s"},
+	{Opt_appraise_algos, "appraise_algos=3D%s"},
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
+			    IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
 		return false;
=20
 	/*
@@ -1125,7 +1127,7 @@ static bool ima_validate_rule(struct ima_rule_entry *=
entry)
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
-				     IMA_PERMIT_DIRECTIO))
+				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS))
 			return false;
=20
 		break;
@@ -1137,7 +1139,7 @@ static bool ima_validate_rule(struct ima_rule_entry *=
entry)
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
 				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
-				     IMA_CHECK_BLACKLIST))
+				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
 			return false;
=20
 		break;
@@ -1187,6 +1189,28 @@ static bool ima_validate_rule(struct ima_rule_entry =
*entry)
 	return true;
 }
=20
+static unsigned int ima_parse_appraise_algos(char *arg)
+{
+	unsigned int res =3D 0;
+	int idx;
+	char *token;
+
+	while ((token =3D strsep(&arg, ",")) !=3D NULL) {
+		idx =3D match_string(hash_algo_name, HASH_ALGO__LAST, token);
+
+		if (idx < 0) {
+			pr_err("unknown hash algorithm \"%s\"",
+			       token);
+			return 0;
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
+		case Opt_appraise_algos:
+			ima_log_string(ab, "appraise_algos", args[0].from);
+
+			if (entry->allowed_algos) {
+				result =3D -EINVAL;
+				break;
+			}
+
+			entry->allowed_algos =3D
+				ima_parse_appraise_algos(args[0].from);
+			/* invalid or empty list of algorithms */
+			if (!entry->allowed_algos) {
+				result =3D -EINVAL;
+				break;
+			}
+
+			entry->flags |=3D IMA_VALIDATE_ALGOS;
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
+static void ima_policy_show_appraise_algos(struct seq_file *m,
+					   unsigned int allowed_hashes)
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
+	if (entry->flags & IMA_VALIDATE_ALGOS) {
+		seq_puts(m, "appraise_algos=3D");
+		ima_policy_show_appraise_algos(m, entry->allowed_algos);
+		seq_puts(m, " ");
+	}
+
 	for (i =3D 0; i < MAX_LSM_RULES; i++) {
 		if (entry->lsm[i].rule) {
 			switch (i) {
--=20
2.31.1

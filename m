Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4709E3DFDDD
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 11:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhHDJUr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 05:20:47 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com ([40.107.8.98]:59630
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237058AbhHDJUi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 05:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyOU+Bw+dgwnH0bt3kk+Vtrto224qoAJ3fn/KSrewwGadHZV3WBP9RP9oJh5XPaDL65pzX1FjapsDvhw+0LULTSScVd9ZHym7BWwoMF2VuVrYPjI8bRXYDNSgk7yhrAyrITZarol9re3rJFAqRMqswZuoHsVrTMPsFAtl2m5xgNpImtCqg1QKM/M5oiptjNhTlY2OPU8t5VIHjAfhZIRWnqUWWbqMs2yMqEKmiKTJmirZxaPDDdnznHozisgok+vznE1d5e8xyE5NCN5LpTcSLmtpYiicDcRG2/J8drClK83NzkaOmwyXHTBatFYfYEwe0r5GebT0tF19WTL9ChjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONetmWz0KWp+CT3m2BQW3i8Q2fUvlp/c2rzEPkBi0wo=;
 b=Kj5h6FPZP2sF6ScfC0S41/xEuSaiuQcMyneQtgyblS4n2g3cPHRCfeYy18KveNy3c2/P5RjEbgYvca0ByRPAVUSnbPtraqjS93mcKGtVy8j7c4aC3Zl3PDCI/ZRrYYnG2f+xtybz77KBjEs2FAsh1E8YSKojYtgFR/mAsjwuvScH1cxD3fXa/OJK5+vEu8XdhXiVdD2aF0ujuHA6BTpGKCkpO4NhoPYpMsUV1GSKNz56p31ludAWdjVS5XFJq+iUiVRk8dQgNdHT1efExv8KT/yaA5XHAP3XvJx0RQfacnMHfbZedmindSPnW7t4WbGEF58bix9pstQla40b/XN+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONetmWz0KWp+CT3m2BQW3i8Q2fUvlp/c2rzEPkBi0wo=;
 b=bvBD+FjzF8DPrkh11MG3Eu3NBUa2npuegYs9B/9uM+q92XZYoY6SBPkq9x/kHMS2g25MczMDqlSuj4t0VK3Kvyz9cPguDfOdicdmG+RJ+8T1UUT1Z/ALx4b+R1XF3wj+J2otMQUwI7WmlovZawxIiLLky4iJgLsTsJiA/S5SAPA=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2545.eurprd09.prod.outlook.com
 (2603:10a6:208:d8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 09:20:17 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:20:17 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v6 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v6 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXiRHwP4uH3YN0jEO3MuWIchehQw==
Date:   Wed, 4 Aug 2021 09:20:17 +0000
Message-ID: <20210804092010.350372-5-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
In-Reply-To: <20210804092010.350372-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a49f6855-fdf3-46d0-0ba6-08d9572912f9
x-ms-traffictypediagnostic: AM0PR09MB2545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB2545C5696C1CABB4E79FDE8C94F19@AM0PR09MB2545.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ioshhtwi8v5xMeyo1Zav72IVlaKieJWK4je/TjHgmbYvUInIWHPJakNWgWdno66dRqoZCEsqL4jzPt4OYyNE2Rvh0fsQpn9I67Ft09PKn25teixE8Hl2dThg73HTYCwyL3um3uo9egh7nPkjx7kOJc0MeJ0Z2wbQJfM2nocP4Jtkxid2A8RJG/zV37i9iCFNUgI7IgkB/OlSNeGJdbO7V+M4StDEykYtPleSXZA5yWcCjm5a2RwmSnwCj/YE6+z8IWzGqcFr0oQQe1QMBAxYyMGvqp4yYFBTLhDPblo5Xj/H9Oz+NtGmfia7pR5Z2eY11+hXR6swGcW3cM+/0o2I8HQGKGvOKKIbkOWww2XpJtQmjlCiYeBuKE5Ev3NlizZIBa0c1Ymj7UH5s0TPOTA52Ff72OQtE2IqcdHYtI5rLAEzRH2qiK/hb3SQoKObpfOBjP0JpNSgi4SZ7tC7+nws0YewwzI/Dx9bnnOiOpQyFTFP7Ott6ZgbqGk9EAWQoB7LBmO4MteRb0Qh5H8OUdrf968bADQawieDkPhQ+aAdhDXMwqst8H8TnHwD5d8WLyb5YPEvJDkhMIf9pXTegQlQuVLxM0XKAjM4M87R+riv88C6tWD4h6kuUO+FLqROukubaHiXMIvIz5yw/QhAMiJjmO4IeCIWAhD5Fvp7lsLTYEhC/phzE6+hEwyJXU/7TczuDOknM7l7cdwAeasRWWpgLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(478600001)(26005)(66476007)(66556008)(8936002)(64756008)(186003)(66446008)(83380400001)(36756003)(6512007)(66946007)(316002)(86362001)(110136005)(2616005)(38100700002)(6636002)(1076003)(38070700005)(122000001)(5660300002)(107886003)(6506007)(91956017)(6486002)(2906002)(76116006)(4326008)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6OrHmia6QQtaaeNa4+vA/dSPSLJF6i2n56p1tTYFt7DTsxqriNpBr/81ZE?=
 =?iso-8859-1?Q?9GnlhB19nzbzbdqwpFFhn6O9Q5G9lDlA2U8HL9b9hZoysnxmkxTkC/4suU?=
 =?iso-8859-1?Q?pABqFr3jasKfWD32TMPuxuDmy0OmPqtEAFR6I/HyYmmRdM5Kma2WmROCBK?=
 =?iso-8859-1?Q?rXjyQjsQztXcWKVZUbbdwaGvHg0wcMTFMqi354NXbKEfsqk7QVK8IR8VPj?=
 =?iso-8859-1?Q?pRNlSeFAFAHpAHBW7bUVTTNwIle4YZcwl3KxHPg9g7PllwZkaCGVCBeLKn?=
 =?iso-8859-1?Q?WObzcpPcpA24vEGUFBB75mrl6jrFSymhU/D0WNhBUXONNy0H2d00yUFKMJ?=
 =?iso-8859-1?Q?LbSilk9P/kUnILbIiJ3GrPAOrfKeiB3jFJ7wZxK8d+ORIuJkTrLwcHr2bM?=
 =?iso-8859-1?Q?w4uupFr6lMFduls5FOljM9DVUCHvCiAbvwZgVgqg2T7WH6UXTBAo0njKu/?=
 =?iso-8859-1?Q?chRWR1/2HAk7nMoF3dB5vpDZZGx6P8P/byejPPGA7kDO/u9X7Jeo9qGdNt?=
 =?iso-8859-1?Q?69Aa4MH4ofsW05B9NlnNDNs8HJaoHOdFA61b0cGJuHVxYrV/qhB7mN9V3W?=
 =?iso-8859-1?Q?eOykE6oTPQT/rgC429U/P45ZVGIQ4puJybXxrLsIO17TteC3W9ZZrUubrF?=
 =?iso-8859-1?Q?QH+QW0QuIHD25kLfBH6wQApu2f7VfbNVlop/eEmCmpQdEWdAEnjXmIJVEI?=
 =?iso-8859-1?Q?V9TKj9w30JsU+fxr6tNLtHyjov7LtNuM0RFn7Ml4mJxOyEzZUuh76tObwX?=
 =?iso-8859-1?Q?Uf1puvvAj/ea7lqz3QF/RGfuHLixGTmmX2ie3eqZ7Jag+kbnZeHij6jtfZ?=
 =?iso-8859-1?Q?wZEfBVuLxowpXUjb/STQ3CA4shlv5aVlL0rw+zWq4xPfXQkNXMIfEKUNKo?=
 =?iso-8859-1?Q?hy7zkwE7dhpdHN423NNvYtpp2enGqx5BYBzw9PFSF6gXXfiq0UU083Fc4E?=
 =?iso-8859-1?Q?E0nNog5mM9FlvyP+F0PnFx7AtM0SPDWFi/1l7uTEqh5INYZc7yAWmPmAe7?=
 =?iso-8859-1?Q?gUuuk249MZePn4Qk3tpSgTrnSwy1nXiB4L/9bZSmNftNP7zYxmQBaNG5cB?=
 =?iso-8859-1?Q?mImJ4cN3W6F5W/FJ7egSl5r46z6o4cP/6AZhsBLMUTfw73mt7zTlmt6kvD?=
 =?iso-8859-1?Q?TIY7ZHFOwnWSPaKqgSlmDFeTW9c8bQlf4bzAcun7mRfqzk7AF82W2DmRah?=
 =?iso-8859-1?Q?ZFZ+sEWEQvKnJtASsrGUom/oTsb/AGR4AyUR8slpgZmvt80lDT3s6Y1VMy?=
 =?iso-8859-1?Q?u4keT1prr0ib75R9ykp1ETatqeOXh1Y1on/A9xN/3fDXjCE4AVu2lUlL28?=
 =?iso-8859-1?Q?WpMPVFcLvOuIKR+0dnOl96egPjaLQD4Cc94IxVcAhcj50D+s7CYNMXtsQz?=
 =?iso-8859-1?Q?kTMdd8l5VY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49f6855-fdf3-46d0-0ba6-08d9572912f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:20:17.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWJDTfDj37Scw6ntxl6nrT8ryVIHS1s7HFF/afImKL0ig0ULFMFXTiKuH19nq2FHCzqaIL7PU4GeTSe2E+vk/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2545
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
index a5b6162535f3..831ce0c690ec 100644
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
@@ -1522,6 +1546,26 @@ static int ima_parse_rule(char *rule, struct ima_rul=
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
+			entry->allowed_hashes =3D
+				ima_parse_appraise_hash(args[0].from);
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

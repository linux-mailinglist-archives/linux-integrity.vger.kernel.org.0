Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE93E8F96
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhHKLlO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 07:41:14 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com ([40.107.21.118]:48096
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237395AbhHKLlO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 07:41:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXdB5MGnzrIhEM39LQkPH2lHljAs2cCBDI8Yyse87rftKUqjeoYBJgmDHKjtqwRa6UChW/pLxRrL6wEUfM9VUB2d7IXvTmBAuIUvydmeItzs5ehKLdwvpIKKvMCIHg5Ly87wrAV8oGG3Sfj6FVObNXOZVdrtB9zI1Iw6BOAzEnIt6u0QlGfPoFq1uNMB2ZDufhJdU/FYhygQiStQNplyA8r6ZHg/Gmk0Ku1YzaNo/tnvXvFkYGU124qEj8mMnbgGhJc5vjMRyhSzLfbCH1ikKerWWDBi9S5rlGeegy6KwyQypq089Q5Aj1VRi3MQQL2q6jbMlOjc2kRgkhIqVMGBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ0kRqj7A1UIO9Dw/lbC3whlM+e7fFzD3uHBxyAbSao=;
 b=n6rWirO8zyR+STgjocjUKzqsFy+aWkcYkzotnIkCNiTFOKsksdtmvfAEvjUDAZrwyAlaUWKaim8zn/UTbHpVbMxumwWTSmI9jpYqe/OojHmfiZZjR1BGa3gXeTTlIwSP9agdEERQl00KzRf5TOT8Bctc43V3UnC+k7w3nh+zK6K4sX0AJE6NoY6jURwtNh4uXdf9sqgmG7+YGTj2S2Sm2zDzm3attCl8YvhneTgzwS3+E2hROJqWuMckr/kvonCyX2DPxYZmVWymy7hsgG0oXL+1LalW+TEVrxPVWjuXF6o7v2KFpvXzdtfknA3Ugd2waOLHMfZLVHLe9dMgPM+u1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ0kRqj7A1UIO9Dw/lbC3whlM+e7fFzD3uHBxyAbSao=;
 b=cZgX/MrHF0pOq4JKwxFhB5srTkwO60D8bQNUNs0sjPBspUA+yRK3LLEnnII2FYwRrJ05H7711Yq0mGutNHWyzUb+FWP/mmoN9Gg6VJyGpLn38xKpQ3/3FkX3Ohy/DMg3r5Og+LaHU6mrChsfPmU0QDytRwnjKHUs/IsVAO7JvT4=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5105.eurprd09.prod.outlook.com
 (2603:10a6:20b:30a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 11:40:47 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 11:40:47 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXjqW6HKtkRWvTZ0yNvT6BOPuNRw==
Date:   Wed, 11 Aug 2021 11:40:47 +0000
Message-ID: <20210811114037.201887-5-simon.thoby@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
In-Reply-To: <20210811114037.201887-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1741bf33-176b-45be-1eb6-08d95cbcdc96
x-ms-traffictypediagnostic: AM9PR09MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB510572BE945EFD9B929AA4C394F89@AM9PR09MB5105.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LKT0wBjQTdSHe1KtmsSMV737YqXNlWz/vEBt1+tpSYc3sZ0hhMzU+nirh9tknlXrMrdKuY60OWaBD+MUi+X3ghGbNOdw/Gu9x+Oh7JMBfz2UcHh/p+aiwBA+6+XqAH87p4n3+W67zECorcgQT+NN7AsP738LE/p9IhejcNH32WWeiyuE9wfe04tZIb9P31cd0bBqV2H84AiE/GByD7bZTlLIYhgC0qYJop7PCpqriLaLU9FEK/UA4hKX646V3Pb6BFVjWPe7wY8vt9GVDVOS7URUTS2mEftLLBe7tro3xnAcVUvtq56COgHxY2MKxBxSZnfB5uJdCphsPhwyE730z3JcESt24b64mD8HuXwe3Ml3BJJRbd9xmdl3v+E1HhhHv0cnfnr/vpar+yfkk5qAY8Cf/BcBw0wmF1dE6QO+4vApKmfq9zhsIPOXjMjlhFHViabSMpesuuFKm44q+aKrGskuG34JpGWdRVZhFWHQXlPBYwGs5yxS4ILGLhfeCN6+I4B5L1iyZp7NmSBGcxBxTFvu8g3HHgK1lOe7jTRExhmFasM+eUoKImwF3JvXAngBITKogZ2hSCduV5dvc53LfKjTNdZCpcozt7+at4R5w7nUNQj6B/PnnfwWluzd6UeAsQvolEShKr5goyVFj/IsO0ZgVnGT442wiY8OuBgn4Yk93DOL9HK0yIrxqrDPbiE98gR1kXJWgHxAkuyyuRcTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(136003)(366004)(376002)(2616005)(5660300002)(36756003)(54906003)(76116006)(6512007)(186003)(316002)(8676002)(6636002)(6506007)(91956017)(64756008)(8936002)(66556008)(110136005)(66476007)(122000001)(4326008)(38100700002)(66446008)(66946007)(1076003)(2906002)(83380400001)(6486002)(38070700005)(71200400001)(478600001)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vob7nV/GwmWM37x9Iua0/NigzDN/nAnoziU70d4X6pABmQh5I+ZzrnPnfA?=
 =?iso-8859-1?Q?b+FpJwaJv08ySniY+bUIB6vk5RjOOXI1wkyRJifQZdAdLW1gPoABdJnPvg?=
 =?iso-8859-1?Q?m/YDDBjjvWlIZBZZpCoAwg9QEqB+hlRL7gHKz7iU+N5MrdUQtmd7C+6MQ4?=
 =?iso-8859-1?Q?645SZT1EGXao3hDghze6shJLJGlMgW0R+9t+0QNu9BsNS9CNVW6MtTXX7l?=
 =?iso-8859-1?Q?SeJFR6kBOcCl0lbodM4DrwzS+y7/KyqRl40uu8el48KDgSWPfew3xStMWg?=
 =?iso-8859-1?Q?h3LMEnD4zquTH5iy2YNXLCiuvfJ4zlx1i2xdlsSCtd6LB/QDX76h3Y5GbM?=
 =?iso-8859-1?Q?FxjqmJcJ5t+66InPcNprne0q1SYeHNRW3aaOjBdGqmYNgQMJhvGLjJ2rQf?=
 =?iso-8859-1?Q?P/CrdDk2+jefsYGs9SN9I8/Hjugm3VGiS6cXijtzf+K3zBA1THDPQUKqwy?=
 =?iso-8859-1?Q?WCxED5FDooMe48fwBXHJnc34jFFMAtQ7lDc+bVdCjIdbdnOSXRA50XULHj?=
 =?iso-8859-1?Q?GJepq3TAywHwdW16z38FLvv5XUc0/ieyKgaPeCIxaJWtr7axdvKSMASfiG?=
 =?iso-8859-1?Q?fnNjyU7hDs/tVcBQ+EJDN3IWGSiFpy4/4VDf3VRpZoRxiewkeyo3XzFpIk?=
 =?iso-8859-1?Q?y5CY3Pj2KkjRtRatG1aBDcXrh3xXoDbhdGtUIvKJrZE2hJF5v6Fuq7gf9i?=
 =?iso-8859-1?Q?7Ch7sbxaJa7EFSCGPtPXii4/RHgf1U/BX6VdKUgkF5L8T7Nd2dYsCSMYcr?=
 =?iso-8859-1?Q?HRbmSywMMMo5KukyPV9UEeQGCXr15qN8ThMPlcMBwrswxcLuhkEpMsWF0s?=
 =?iso-8859-1?Q?P2J05cUXliJiMkdhjdFkAfkQga5t331vIukB807H+pJK3ndCGgwgpddxaU?=
 =?iso-8859-1?Q?EOeAZfwM7Aw+Tb4MHHIwAMKM7lsJX+imQJ+oqJFNbN3cNPJ+tCQ2OdgAOI?=
 =?iso-8859-1?Q?PD0XBQQXBNlc8pKXF7U9m5suTh5Q1aKblpV80ToE/ZYRbz0qJfxC+R1a2Y?=
 =?iso-8859-1?Q?2rIRdPU4rNT0cF/iYKaS1MQEn2Q8bz42B2QqhiB0e10mkgLEatp+3deZYR?=
 =?iso-8859-1?Q?T2JPTWXb2AEhlolxMMPWOqUtyYK03/vZHFkPNMMb/7G8++YVOLkW15EU8X?=
 =?iso-8859-1?Q?rEKNu7ycAaPsQTFsG1Zw1OwdD/rzZb9ProIE5prDw5xt1ZCC7Gyyd3namX?=
 =?iso-8859-1?Q?f5zCyg7rtGK5HPDo3zgQLV85zrMmbeh8OFvFZ19PcHzkO4Q777kADEXe9j?=
 =?iso-8859-1?Q?n9HQ9nl1rff+mzzWtMB8Usq/MUYKBjBLvq3sTA2NfeKRTyP5w56yHRmocx?=
 =?iso-8859-1?Q?9xHlKwLfq9aDxC2xAxleq+1U8GBbXjHatLXiDWY7JbCDyF4vLq2nlrV1aZ?=
 =?iso-8859-1?Q?GLJJYu5uRF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1741bf33-176b-45be-1eb6-08d95cbcdc96
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:40:47.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvvA0DO7v4tq88BTShrkxcHf8Qe2MKE8BqB1KqCD4JNjqoKbEaRlBX7P0CtSXB6mz8Am2T2j4oJQ68NlT11xSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5105
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
Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
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

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693F23DFDDA
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbhHDJUg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 05:20:36 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com ([40.107.8.98]:59630
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237027AbhHDJUb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 05:20:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVZR62uuJiNWWUnyrDA8/0MwivfCSfvbHKBOvXV3s+cVrOD92VBGnJavQL1yONSh0s3cp9LhCB+5OOwKlnjN9KIF0daRgLtz7h8Sc8r8xjnjohGvAXco+mExmhgDRJ+WNCHykKDG3lwq1s7wEBE52wjXP7lVO96Y6QJQ176sm103dei9W4LXbBuSPVIz9Mu9yEO+Lka9sG41e0nS0mK/MFZQJO6FF6cAqiH3Mv/TVtQPn4ekLW2pH4BNdYRG779sbPjsFOXKiWijkWERF8e45cl08yYQn+yRnmkO5UagLCXxFAeKrLqF7m6nBUK43yWx4+d4NMGp7w5KBSAjE9m+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57/vIXuVo29Fep5tJRXRHN7s5vFG/giZRZJ0lGzgw0g=;
 b=ZdhcF69l5mmZaNV+0qS+j0ekC2rqaGNd6NJ+JeIR6nLoidZaq+6umh7qt71044KFsc7VoAt+HTAhKt3pi0jSpBA0Bl8MVhMyOr95zh7CNnSLvmMBsEnEwIyvZ1UB1+0JZO6CuUi7FRA6vRWJQfYDWc7D7c80AJKwP4uSegFCysHbq4vrSIQb42gN9gJkVZAV8pmfVtJ12Dk194Gom7RZpkZ3a90VumfbC+TAYrQCooHOkTKk9qSAPDsS5jOlEgkc+fGT/97qUzFJmZNB1P08dUTa7i8y0Y53Nki85ZIcpOjLizQunI4gojUE6fJW3b1L6X2rt0kSQwjzjkrmKy/caA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57/vIXuVo29Fep5tJRXRHN7s5vFG/giZRZJ0lGzgw0g=;
 b=qOvcBbcUk5hkB3UC21a2XqRn2Heo6AYpOt3YtC0YcPqVG44Xouz9RjRtc3zNlZ5MEdGM2OQb9NzsXWIjTQ7+asnbi5NcLI3HCEdjx3zVEurNRQlIVnIFheW9BKdkIRVJ12K3ofQ6fA9lEhTTe13FQgPb8ESVCUNj/+Q00TB/DnU=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2545.eurprd09.prod.outlook.com
 (2603:10a6:208:d8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 09:20:15 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:20:15 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v6 1/5] IMA: remove the dependency on CRYPTO_MD5
Thread-Topic: [PATCH v6 1/5] IMA: remove the dependency on CRYPTO_MD5
Thread-Index: AQHXiRHvn33NqmS8Tk66lWWgcxAu4A==
Date:   Wed, 4 Aug 2021 09:20:15 +0000
Message-ID: <20210804092010.350372-2-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
In-Reply-To: <20210804092010.350372-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c0d0482-9418-415e-692e-08d9572911d7
x-ms-traffictypediagnostic: AM0PR09MB2545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB254505C53EDF842A0971CBA094F19@AM0PR09MB2545.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOZThsba7y3A54BCPYdE0sTfAfm1XzNDnCwbgLbF4ROPdW6m3lEkuMbZj1DwaMHTNTu8DYrWYYlOYIRqA7EgxdCDhiOOxgOl2OEOZcghzutdZ9M5QurGpSVuki3dh9YUZcFNURo4DfS9fQ2qJvPITT+dXZxsxVoQxqPBzu3/ybNHFmk0YT+AHmDrNQFc02XHw8G/dM25HcyzkSvoTu4zpMjMn0gJ97zJrS7tMj0uooAf008GVjt46V+Ii9RfjaPqn8vdlMWG8mczQ8+MEWaJgxz6vJfRRsoxapW8z7ijoKID9U0/3mGAZFIMglpqObA76oT4qsQJAdGxY86wQiGPe25pwzxwIKhTfBu32SbnDkQRWotypEn94VolYPpM7PlaqLEjLJ/lWNw2rXZxgJfoCTpeJuK5tg25seKymo0JKurF0fO2Ju+CkHp1BszVHHymTf9UDj88OBJxDCCzSRT5V93P0RzQS7OjCPWvlmgmDuzuG1tpZcnaBHqN0x+CWmcfJMSjIXKa8l0u4jqKQiHrTxXSlmB+1oh6JzGr7eKH9R2CAgM7tgR6+DgTN+9R3MG8d2GcqZx37pU9zqc3nfllON1OnWVKrIETh8z9lGpwb7VH6E0yVJn37C50TqQZQdQmhFlU9TVWSy3uF8Ksn4BHXNt4R28csQjTM13JLkZQU2ruNBF0ez8oBMc5HgtNJrRPBxQZYP6lTapURwd/UaDBVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(478600001)(26005)(66476007)(66556008)(8936002)(64756008)(186003)(66446008)(83380400001)(36756003)(6512007)(66946007)(316002)(86362001)(110136005)(2616005)(38100700002)(6636002)(1076003)(38070700005)(122000001)(5660300002)(107886003)(6506007)(91956017)(6486002)(2906002)(76116006)(4326008)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yMqBAB1sqiBnob97M7fpi8NjJ9FylG562ammoxkV36RR7TwLMcYIDgLBPd?=
 =?iso-8859-1?Q?DwGrmRnSg8vHTGBTaXSNDROR/JmIVCFUItyxI33LuAdhiDv/bCssbzYtJH?=
 =?iso-8859-1?Q?nHQT4Qma8mSX27YLLYHaohGyjxKMHz5+aPBDeOzn5DZL1OXhHBeuYpFePA?=
 =?iso-8859-1?Q?6q18KjGkYmuhcebpGDoYMQ7C45G9iF3lDv/CHfibwED2duBwD9YOwWO/w/?=
 =?iso-8859-1?Q?YKuF6i2HYq/o66E9HNxb1D6zOZpZn2jo/rD+PV2zQZ3MdikVRUi2pizGQp?=
 =?iso-8859-1?Q?5p5ICju271Jk71oQ3Fnvh3tiTWn2phj9bpctPRYShdTjUAnDIsInwxOycW?=
 =?iso-8859-1?Q?kc6xKUpp8mfa1QduwDRVf80DMETSWsfPTXwroySMDw8otV2E7j3BziU53Q?=
 =?iso-8859-1?Q?EEH3fjmv4bkBYvf38fdIa+B/Y31oo109DPPbDjxZzCc8pgDs25R5CX9TdU?=
 =?iso-8859-1?Q?uRHL+jibu6+YC4jj3Zcnm+EcgG/480ahrRVpWPv6KjaotANvkMjbQPLMkm?=
 =?iso-8859-1?Q?KiwepZB+ErbPSQ/UfxhRW0UzdfwYC33zvwII24h3hmarW0iIyvwMzHAxdk?=
 =?iso-8859-1?Q?SO/wgRt9urTM64AxZQr38o5w65dDlvARWZoTjao38caXZ2r9wA38zT7MaZ?=
 =?iso-8859-1?Q?9EAJiJsAtJobREQuJofaJd7AogMnbSS2LKImehFbCiyzeIY160Cg0qBicL?=
 =?iso-8859-1?Q?odkdSXzwQuspSPtK/bri9StghWbBSzpRf1u2LV42NCb65/M6bw3mJy3FuM?=
 =?iso-8859-1?Q?DdJ/TakayR68aAjzHiNQEzl1GVr/QhEuszYeGSFs/5tJxLrmppVJhcjIYe?=
 =?iso-8859-1?Q?lrE/1wCykvxciP9+cP5xbdwV15wBEnD/Tlm7P3YdjHJMdojeDnQ7cU+ceN?=
 =?iso-8859-1?Q?jQkHkkP2pegzvT4iAdCskXpCPnjxK2H+cRjbiv3yaG0wUeG89bdf0gF7vm?=
 =?iso-8859-1?Q?9MEmn3Gh0DiBZV+cyWOnZJ9l5FgL/nRb6c4nesw4AboNmZzOB3pfi7lLPr?=
 =?iso-8859-1?Q?y2PhSME5tClCr71Wv6F+kXhBiRms6WcYkihs4PDuk5rEKHvT7yRuPj4hz4?=
 =?iso-8859-1?Q?h4b6iQXo06Gxpy+qo2cbSUqqi2eDRR+IyBsDXq5jd0+AmB76pBjAidOVYI?=
 =?iso-8859-1?Q?5jQP0uQfq/B1T8a/9N0TgwU3MkN1V2ygSmqTfPdM0ITB6Jau1pDd9jmfa9?=
 =?iso-8859-1?Q?/PTgcbLFwgcEvysRABSJQ/4L70bXAhKA1ruGPr0+pDYYPpUWsETe7OO0Kg?=
 =?iso-8859-1?Q?MKwFoqaui399cDj4zfJIGwDp9K9FqJ3jLa9fPwiGsjL2HyOl9UIz4bswLY?=
 =?iso-8859-1?Q?hFgwsbXx2+vHcbFH4cwu5qFD4o7DPi9SArXBwcWf104EOxhdXX3XvqZgkp?=
 =?iso-8859-1?Q?z30FuXJ57W?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0d0482-9418-415e-692e-08d9572911d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:20:15.3171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rM50W66fxzPwhwyCOseS6+qq7tGB/MI+ec+wfrL7xAB5uNZ6t+gPdVML1vaFfDb2JCwOJGqfhflMPJhqnMUrJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2545
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

MD5 is a weak digest algorithm that shouldn't be used for cryptographic
operation. It hinders the efficiency of a patch set that aims to limit
the digests allowed for the extended file attribute namely security.ima.
MD5 is no longer a requirement for IMA, nor should it be used there.

Remove the CRYPTO_MD5 dependency for IMA.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/Kconfig    | 1 -
 security/integrity/ima/ima_main.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfi=
g
index d0ceada99243..f3a9cc201c8c 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -6,7 +6,6 @@ config IMA
 	select SECURITYFS
 	select CRYPTO
 	select CRYPTO_HMAC
-	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
 	select TCG_TPM if HAS_IOMEM && !UML
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index 1cba6beb5a60..b70ee0125168 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -53,7 +53,8 @@ static int __init hash_setup(char *str)
 	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) =3D=3D 0) {
 		if (strncmp(str, "sha1", 4) =3D=3D 0) {
 			ima_hash_algo =3D HASH_ALGO_SHA1;
-		} else if (strncmp(str, "md5", 3) =3D=3D 0) {
+		} else if (IS_ENABLED(CONFIG_CRYPTO_MD5)
+			   && strncmp(str, "md5", 3) =3D=3D 0) {
 			ima_hash_algo =3D HASH_ALGO_MD5;
 		} else {
 			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",
--=20
2.31.1

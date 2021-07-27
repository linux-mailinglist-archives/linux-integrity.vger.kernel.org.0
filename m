Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9B83D7AFE
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhG0Qdn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 12:33:43 -0400
Received: from mail-eopbgr130129.outbound.protection.outlook.com ([40.107.13.129]:40010
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229441AbhG0Qdm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 12:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwsLOXHw1jTPhAA9xd9O+p+tASL7eISSuRSo21vVajZFqyaWId0LYN6rmhGZkAPHeeGEF0g3vESbbmK2kYVfLHZYq/8GXmSt+ir/+xQgumxshMX1nOq1ewXa5GaYRXV0nxYUbx6sLsnJY1o6Pd5ti5Va5ZPxJfCRWYwzsPtPl14ZhjJ5wi8pPdgSrcYe0+hjMl8076me8PvIMKvQbHARazRU/Oolz4RYPJ5O8J5ofbd6uWXoyIPtZmkOgABsbCYacWNYSONtd2Hfs9vVmflgzmME6NNf8dQpHnz53d9Y8aGb/eKrIZhVw3Xp45Udygjm8x1egZRiDcfTDjJ05htWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/WoRWCG3xvwfsrvc4xL2tDdIzeNLfKmv+iH3QWKiQc=;
 b=oMj1+VZpm3++PZzWcZlpfc3Lff0NT0GP2wt4yaPT/ftLqnDVlvwsFE3Dk42M86pPalahNhgu3Tws2EnEGAqDmP+r5LzkV2tNX7Ztsq50gXoEbt+MefLMYuM05flFlZ30ouYYOh2D3aqkGNvaljIlhTOaJt6sLwSxHypt8s7Hr5QXAIUAgnrU2mPdFf7x035lG1qJPVYcSMTMOy8ZMsoSKA90c41hsPUwoOT3KUWkQnGx70YeFFErzsaxL+W3gFlZMxYjaQ6bkP8NV8o3cLvmg3u+3KW82sPT+KW5DMfNJ/IE+hSA0JEO5SarMloCI01VXepi6n4pC5PV3IpiEAOGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/WoRWCG3xvwfsrvc4xL2tDdIzeNLfKmv+iH3QWKiQc=;
 b=vYUsQ3E6rk6h9goa+2bcz8q4k6OM8fDvmGHzEfiXafEvGa4+twlB23m/3bKbzIexZxqBMOgb8T5/mbwtgs4JexoZk/EJp0MZkKRTtXUhmsGfam3kp5pD7hMoeNkgdBzhxk8JN71a23yujDGPeo9c0/HYzKoanXoG7O1PPgqXGEI=
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
Subject: [PATCH v4 1/5] IMA: remove the dependency on CRYPTO_MD5
Thread-Topic: [PATCH v4 1/5] IMA: remove the dependency on CRYPTO_MD5
Thread-Index: AQHXgwUkKmokX09Kxkiedz7G8dviPA==
Date:   Tue, 27 Jul 2021 16:33:33 +0000
Message-ID: <20210727163330.790010-2-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727163330.790010-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebdfefc6-dc42-491b-4592-08d9511c4a26
x-ms-traffictypediagnostic: AM0PR09MB4243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB42436258247F487D0D4261AE94E99@AM0PR09MB4243.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ksp2wx/TMkXLbtvGlzHye8JX32IMJwn1vg61dOrhUtDsusgjfpq7R7szNekLYZ82gbIisdHGpweZE4gSfk6x8Mvos/tb718m9jPnJ1MGr2GOz0Bo+fW23he6ANuZtDAlnJpRPKmF9s4Bq/sTU12REDKe+wGm7d4jp2b7FjlNPO8yO9Trc1d3360xECDfcnA/2ryDfz2qXzBOtjKdTX7jCCAFtlR3EI8wjkU5CsUWi8RRUoAfCtbTDd2j961j2C2vvpUymVoO9tT0l080/e69HIyccJ/HulZwiv1NA4NhcopVVY9AO3FviDMrQPvm0Tyu2bEuaxcjqdRwXZwVeCTuB7R6nrWneKzJIqR/wJpe4kd1XfcFScqebG5pGwfHcfjWslPUfVm5wIOizRfWV5LWcbWhyf5U03kZaW58h/yPTrZWsvoQTDYNtcfhd2+73od0Co/x/swF0dJMRNBCvHqRHCxfdRs8NwARUUeoDry3Kuyx0QhOXvNOCp4LggWh5QT5cR9psXSobUsIdh9h9DeT9ueojTo05WGk1hqL4VopVQk4TnCxOPSqK9ROaT86e8OS+l1Ur5U6l5zchsdjLmHzQMVKLtzmTrXrKzr8CqqxvrQ0D/Ih8cl5aZuITHZ9wTN24LAl1cyccmNBKGUaR8oZLU/rkW1h1XfqizIkZ/5SjmrBLsD7VF/zi+xofBXGjVmgahquPtRhkq9GvU/UI36G1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(396003)(346002)(136003)(66446008)(122000001)(66946007)(6666004)(76116006)(36756003)(91956017)(2906002)(38100700002)(26005)(2616005)(186003)(6486002)(86362001)(6506007)(110136005)(4326008)(478600001)(64756008)(66556008)(66476007)(6512007)(71200400001)(1076003)(316002)(5660300002)(6636002)(83380400001)(8936002)(8676002)(107886003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/oSNQxrG83LiH/bYsG5OD70yYmNvZrEURejPUuOKgsWuYbw2406XOejwaz?=
 =?iso-8859-1?Q?Da5jGNgTXnKppgvzxkoOF3k9yOuTpuXIyvBBUA9VYj/NevXwlQy9fROcD+?=
 =?iso-8859-1?Q?JTyqeR+YIvWusRo8KaMM4jNSzerc90l6pOajDYf9rXNZr8D4WSXeq2ZJZr?=
 =?iso-8859-1?Q?5H88RRc7AIfVoOKQkejmWUnDDtzLv16WR6Lv27fkRSRSllYtoNgEm0YPQs?=
 =?iso-8859-1?Q?fEXMpw57+3I6cNrO3yU8uFFv1VJhJBwt/8G4BlGsF9inUj6OsHsbdigo0G?=
 =?iso-8859-1?Q?nJ3N59wMmpRRfwy9+krLZI3zz9CcVnKDo+tRte+pUNIiXU8wAtsp88t+LU?=
 =?iso-8859-1?Q?uWojvLZzP2J06QHmglo6VCaIgN9kT0cUEiqoFf9xYSz+fhmpjlk55AdpQn?=
 =?iso-8859-1?Q?xIONGLtUUmSsogE4ziuxYfCnr4LD66obC6Be8HarvkL9CaB1TAtRLt8Ef6?=
 =?iso-8859-1?Q?4yDyRIsvjgDH8zxDjAkL7phjT1cvQD4DMQRApvWO9Tm03bcCCg7Cx7iw+x?=
 =?iso-8859-1?Q?U3ubYVonJF41A86QysS11S+mx8g4GbDfSwPrx7sU8O2QMk6lAHa6nCdDHa?=
 =?iso-8859-1?Q?baRZ6GSQBBAJb+c4obmY7Hr2EmzBkTNPXZnBjFg3eV/tVC8Nyk35LssvP6?=
 =?iso-8859-1?Q?IsTqGZWtg17BCaOHwEdDK94PeQHZnnJHkF2k77IE7L3zUg4eQXVZdjEsEn?=
 =?iso-8859-1?Q?zlPZKe8djXLz6nR4hEKQ+dBRSuWbOr9IREoyuHFUUT2cgJwutoNH2yjWNU?=
 =?iso-8859-1?Q?67jU/7wFnEVGaic2a7Z7wdkLVN73f8j2mub1Nl5TWTEmGZvDjyzQXNSDX2?=
 =?iso-8859-1?Q?bO7wCcDvHDAR5v6HoIjefF7KsZAv2Ie1d+5zkRAM697umh9T0w1UEl9UO8?=
 =?iso-8859-1?Q?es9D6Wsh3jq9JQOx/jJjW1cxQw+OY1Jx3SDU4Vi7hy/oq78AAv3KkQUTP2?=
 =?iso-8859-1?Q?dBPusiPf9uaWxFnRDbqO0nMuMKHNMpXLVgnRMIkyWWAjF0mJLwMJyrMMX8?=
 =?iso-8859-1?Q?8m4XuoRBLOBZnlo3ElrrzHVM9JYfFfKYsU9HZqcaeoQb9fuTlM/xP55Lbf?=
 =?iso-8859-1?Q?jSs0UXRrnSPtjYbrSRL0LqE7WjLxgtzc1u8YQKpjB53w4Xs5uf30ifgWRx?=
 =?iso-8859-1?Q?3/9iFB8Cifuk7e/sDfXVGwYmM9abz1r/sKtaTE74yfqHyBT594MO83n3XO?=
 =?iso-8859-1?Q?b0LH6joth4x9SUBEv9iWuQhXTbiB+NW+Ycmz6ABXJMMh8TOFXBYAfCaSnG?=
 =?iso-8859-1?Q?AfWmyAPBg1s1glvrmNYhxkEmpFjSF3pH/IohNi2wBBZLbmfk/t1t0rmQZp?=
 =?iso-8859-1?Q?T/1JmSvMad3b/6oTSPq2nQM0Zorp2O24YpfG3P7HzvWO0KEfINKJ0Yk4py?=
 =?iso-8859-1?Q?sp91axsYR+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdfefc6-dc42-491b-4592-08d9511c4a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:33:33.8297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RY4RTEdU3u6qFNWW669vJZAdLBsXyfcQkJpZ7iXcpyFIpiKV+XmcbtOGq7W24IlHQSuLeD2dGoTvIn7AC/auJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4243
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove the CRYPTO_MD5 dependency for IMA, as it is not necessary
and it hinders the efficiency of a patchset that limit the digests
allowed for the security.ima xattr.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/Kconfig    | 1 -
 security/integrity/ima/ima_main.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index 287b90509006..d171764230b7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -53,8 +53,10 @@ static int __init hash_setup(char *str)
 	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) =3D=3D 0) {
 		if (strncmp(str, "sha1", 4) =3D=3D 0) {
 			ima_hash_algo =3D HASH_ALGO_SHA1;
+#ifdef CONFIG_CRYPTO_MD5
 		} else if (strncmp(str, "md5", 3) =3D=3D 0) {
 			ima_hash_algo =3D HASH_ALGO_MD5;
+#endif
 		} else {
 			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",
 				str, IMA_TEMPLATE_IMA_NAME);
--=20
2.31.1

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC893D8EDD
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhG1NV2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 09:21:28 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com ([40.107.0.120]:63047
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235942AbhG1NV1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 09:21:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/RxW1Q0MhOG+lnkmM+fRClanYUl6AaXi7JsKr2wFeAkROBflRDqTSm1y8z++lO+c/VBcMnMBljrZQAA0ZeL12vbv5OmMQ/p7UHRzDked8Qh/j4VsQkgcDA5cPFluKNOS/qOip4QZW4FWOjCf+AYSjUXPi1uH3h6gOJ0BnIr8KaaPRxHLEJ3TC29g+errWjG4qk+DC7CeZynleCFRETADoS8mgx/uhVawHk0r3h8KTCiDsr1UzRdjHc4RqDqd/MmiLDu5PeI7/71AGBmW17K3Ap93XlfTBVNE7XzuGe6SegegUHhuFJCE0YaejjsFML0F0iSVJj4vAB1+Ya/H/Rtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTE2TJ+xJv3P4eJXcMv9JINq/CSiCyK2DzoWI+/ID1w=;
 b=Em+yxFLmFmtvuAE9082dcTPWaLRltGsReUjH+DShlALUcy3GR3sKEkQXohp/zixR2EWcYr/9HpfVtdNEMz70VJisl9kMLJSskpwa8jxWG1oYZzjDQ+8XH/iVuB0HpXcbd1b6IJkMuSp34/h3L+v4IQ6Tg+r2/1HxBala3ki3XlMefSeVynkpjq2co6Lnm4Zs5UJxF/lxa6+fn3PUdVAnDGMC8omts9pKLuYXbxKSq0bZsK8Yw8iC9r4heNDNXWuduZeKHJI346JHYHddPSBtG0QNkkcepl4qGTFBLw2rMLE69KeqPwAEEBbNchhWQW6QahR29N/Dyx4nEa772Okwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTE2TJ+xJv3P4eJXcMv9JINq/CSiCyK2DzoWI+/ID1w=;
 b=MFYnPn6/lrhQH+GFueAdGxpahT9AlD0pbhufyYUsk4fA7xDIhk6kiDKN/a9BKoajVkxH135rVwiH4ZSG4XCXWOke6chWszlwLpt+VNLJ3xs8qpyV28w5fNSboMWtP/ZNwLDmlB9cxoq9DcrwyPI250F6RSLTA5ecz2TXboeU5PY=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3361.eurprd09.prod.outlook.com
 (2603:10a6:208:170::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 13:21:23 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 13:21:23 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v5 1/5] IMA: remove the dependency on CRYPTO_MD5
Thread-Topic: [PATCH v5 1/5] IMA: remove the dependency on CRYPTO_MD5
Thread-Index: AQHXg7N2fvLqxpXErU+wQ9o8XUFZPw==
Date:   Wed, 28 Jul 2021 13:21:23 +0000
Message-ID: <20210728132112.258606-2-simon.thoby@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
In-Reply-To: <20210728132112.258606-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f49b6913-2a1d-4211-5337-08d951ca98bf
x-ms-traffictypediagnostic: AM0PR09MB3361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB3361A73F209AE175345111C794EA9@AM0PR09MB3361.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ru+B8fRkAnSdJneZWnf8JWcL4bPQUelxRYcdOa+wPmak6JWWzYLwxqKIJgv756hkLiDoShAOorf4w3MmGmKfGQjyyAeRCu1z6WnN564MEkpxXbmm3ix3hlsvb3OiYBQhYiXWRbnNN4N/MpFd6ZtfrWJC2MdicgKYu9Dl/4cT/p3XtdrEfrXvZfYvfZxprfEBBzlcF4UOulEortoI/pv4i3O/B+skolUp/QAV+DTMxeMKuQe8PUMMY9RVdGswT7kchMrcnXNrYaDb7tma+q3mq2B57AxBN3IciEkb7q0mPZw2A0UOSnU7QtKmWpQlLJm21tP4u1IThwNJwyvqzfNx1ufbPKA7cYniN3cf9KKl+wMAnnjRa5dRymi6NkXadC917yE99IrcppMnUCi4krWAJBiUGqInLy/DzwsuzbR88/pms9gsCqNYko+xjJE9BYToqCcmQZrLpCfrzgAJ+GfWA/Pl+Ei7qus809TV1hdiSaW+o18SaJg5Oscdmi3dcMCkWPYcpJAXo9h5YUCHuEdxkozUu2L7kHWwjoBCKKMGVbMKwZKZpwv6n1K9uG9IPNFJ8inldEkUHyP9jE6mTSJQD1iqyzuEgXArq35HA4siu61kLK15RkT+gp/3DX0Mh26o4D77RIeXCzFk9b/iEG5bVC9BjIr/eOck7jlx+50FacyG/D5X19TU1pRMX4yc9P0b/ONOHtsDurPDpBQJuWoTHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(8676002)(6512007)(8936002)(6486002)(110136005)(76116006)(186003)(71200400001)(66446008)(26005)(91956017)(83380400001)(6506007)(64756008)(478600001)(66946007)(66476007)(66556008)(38100700002)(316002)(122000001)(86362001)(1076003)(4326008)(2906002)(5660300002)(6636002)(107886003)(38070700005)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h2sOTBua+hEkgqiuAeLPN5JBXZv3S2mz9dgawrCJ3M1+7eQdYL1fNkzq+L?=
 =?iso-8859-1?Q?RJKRdMO6AKV+UdpxGfe1jxWx3tTcXAJLJdeBqcXwgvXMzAw+T6JZ76ZZg/?=
 =?iso-8859-1?Q?H7N0uODzCQfzFaKC4k5DPCnQyBNVXMT1O5/2BZEGg1s675ywrUZBLHzwzd?=
 =?iso-8859-1?Q?wfwbeMMxcxBqZm/WZv9N1UN++VNoW/1zjZdpSkPCW7zLKEW044kxlPfcLT?=
 =?iso-8859-1?Q?5IqTWNaJTrbYOKvY67UhbQMg72ycpryWfjSlh7eZcGe99RVCMOz5hmDO2C?=
 =?iso-8859-1?Q?g04dyM8W+ve0RBKH9na/RiVyjv7G1tY75bFGnSGEuS0gFbXgr1gAWoabS4?=
 =?iso-8859-1?Q?NqYpYumU8+T0nip/lFaonvQlHhrdUtcA/e/SK9S99JRsuMG2oE1nwUjVCv?=
 =?iso-8859-1?Q?+HGgOQDgn27cLVXeqlFetxaGEhXGi4DwKhM+G9JwsK7Dt4o/HAcFBoViI+?=
 =?iso-8859-1?Q?g+DQaalPARg4xUEVZhovzcUXI4VrGm08FoxFMDHt2V1hz3W0ArXt/ctw6H?=
 =?iso-8859-1?Q?yJzaPZoaZvvSnRoHwqv8ep9HBPvwiTxJ14cqfjgOyat/eebk9Y96i6vSPM?=
 =?iso-8859-1?Q?p6YiU/LKxAQTm4WMsml6EU++ctw9zHEjry/gv6I1nN6lAJr1EfvcAvUPl7?=
 =?iso-8859-1?Q?IwBATtANL6u8DQu6CJVkaVFIcciwjoeUYtlM9M7jU4r+m9OF+4EUDp2uae?=
 =?iso-8859-1?Q?OMvL7dHWoENg30vISJJ79r/I0NCUidSJwQRl61m3OSTLrPEtUjifuIftqQ?=
 =?iso-8859-1?Q?rjcVLNUUq0z0C5ZD595l0XVvxdKbF6USkrBWE+slazzsVHzBU/xX8cMMLQ?=
 =?iso-8859-1?Q?bxYrwalVAItuHjM9iWfG+GJEPxF4FYCLfCHYnOROfJ1+srEVjqGkGCHksj?=
 =?iso-8859-1?Q?dDwuttp/jQLL2fdjLeQae4qXgcs0gufO8GllIJHlkkUV65p8Wr6TzRp3i6?=
 =?iso-8859-1?Q?G5yU5HNIGoHsJ36lPdDf/jlQA/26H7sgpBOdMqGhXhr5DyDXj4sOl9Nuks?=
 =?iso-8859-1?Q?xUDsztzINVmS63DVmHH4qNQalaH+PKWrv/AXG+XtHdnPDM77IKbqYP+TDA?=
 =?iso-8859-1?Q?syHkldoPatMGGH1eGwqdUNeRmIH/czZB4j8R7btFlYUNlpD9keJW5/CA1J?=
 =?iso-8859-1?Q?d4LFz+XkS7CXj5yi7WcG7CKaeh1V2ScC1M1k+VboZbit8kIfzfhZcICnqI?=
 =?iso-8859-1?Q?gEehI8XM16hRBn0PdAGHEDKVD4kEVBK3CgXw1jigzG9rVHqo0uJuCOoswN?=
 =?iso-8859-1?Q?jD/VM+al614P2K7yw4KV7r9G36Ev0ncUoympI8NGyArU/2U9634dSsbpEi?=
 =?iso-8859-1?Q?ArRUTI+EvvVVjtuS1loRt5neoG2YGyG53+Z+opduIS9sp3ojXHyKo3PA/e?=
 =?iso-8859-1?Q?A8ntTm901uj9FkjYObBa+Uy0AsS0U2Pg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49b6913-2a1d-4211-5337-08d951ca98bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 13:21:23.5995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BABbB9Xc1V7hd10fdnmcz8vkG96uzeqngOmCDm6FgnppZxPDqRUgyl0P8/zFGiNKqU9Yjc77LaPGzLL0HGK6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3361
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove the CRYPTO_MD5 dependency for IMA, as it is not necessary
and it hinders the efficiency of a patchset that limit the digests
allowed for the security.ima xattr.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/Kconfig    | 1 -
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

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
index 287b90509006..7f2310f29789 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -53,7 +53,7 @@ static int __init hash_setup(char *str)
 	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) =3D=3D 0) {
 		if (strncmp(str, "sha1", 4) =3D=3D 0) {
 			ima_hash_algo =3D HASH_ALGO_SHA1;
-		} else if (strncmp(str, "md5", 3) =3D=3D 0) {
+		} else if (IS_ENABLED(CONFIG_CRYPTO_MD5) && strncmp(str, "md5", 3) =3D=
=3D 0) {
 			ima_hash_algo =3D HASH_ALGO_MD5;
 		} else {
 			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",
--=20
2.31.1

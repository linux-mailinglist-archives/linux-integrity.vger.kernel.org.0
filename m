Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADBE3ED000
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhHPILe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 04:11:34 -0400
Received: from mail-vi1eur05on2117.outbound.protection.outlook.com ([40.107.21.117]:8288
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234637AbhHPILc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 04:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNcU6CV3Ax4UYN/cfDDnZ/GbthWCXHgZJHUOhRMZF6Upp7io2XD3+pMmox/jgdlKAzXYDtWX5hZdaQYTRL3bWlMiazPu8fEObm3M7hO19Dnn3svnGre1VwhKe/1DmbQeTr/GKkAlMYbvWUZULYP+xbQnf/No5sg+Gj+JwQ6aCY6FCo002FY4258dp8Ut/5OxZisTc5BDxdTMwMo3nQqlK2eg3eEn+EvL6NUDkNeG5FE+oav4taGKNxWhdGDeeKdywvXrCrn3VH9lUJgqwCKml+ZJdRPihim+bzoGBsIj4F7w1Vr5JcmbeK05dsd33jff+p8JAagxeWVD6sMN55FWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIYBRcM9n4S0k5nbbcIYw4HAYPuf0bd3fATpTmhsdvk=;
 b=OCjryB6ILdr7yWczDEE0Vs1psKMXufioo5dDxZfReRamEsyZ9Bukyoo4pBhMQ9YW70HLiGKNNMd5K/ierhBudYUJmZy621HOdZ6VGmWp5ST61Fq8R3xjq7DiUIL/vGNUJOhAXOLSYil1n/Hnb6UpzcnIBuTBCRUDX31IYj6+qRcc2GyJXRANGNjzCF3pww1DHnlKyZeGdV/dJrKzoWY3E0oJTkkBSXcmi0z75XWfG/OfUlcw6G3Z8Ljh3yi0yL1qbxzQ3L0rEjgDJaRbYJ25Jictlfm2iY52jB2o6IUXEQBatbBH/R2j5Hbe7YitVEm4nUur5uW6nfFDEHdTPpAUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIYBRcM9n4S0k5nbbcIYw4HAYPuf0bd3fATpTmhsdvk=;
 b=yH1MBGuwVKENH5uRZ8bdTSMaeFed0W0B/MAgbYaWpg43HWfpUgBMaO2Z+hhLjkl+PHG7Y4GeJdXfStaymsLCbM6qOsbE3g9LJW8aOwTSPlfVBgrjShE+K++OzsuhUg//9BIZKCIaj/qFtr5GrfWDCJzx9kTwwSpm7/WA4GKL69M=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4516.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 08:10:59 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 08:10:59 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v8 1/6] IMA: remove the dependency on CRYPTO_MD5
Thread-Topic: [PATCH v8 1/6] IMA: remove the dependency on CRYPTO_MD5
Thread-Index: AQHXknY/FswZT53nwUaiQJcU12EfMA==
Date:   Mon, 16 Aug 2021 08:10:59 +0000
Message-ID: <20210816081056.24530-2-Simon.THOBY@viveris.fr>
References: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
In-Reply-To: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bd8aad4-e113-43e8-9b28-08d9608d61a8
x-ms-traffictypediagnostic: AM9PR09MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB451654E8E05FAD6709EAB97F94FD9@AM9PR09MB4516.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +d+EeBcFpM0PHEl/2X2ZUjv+vd9AzElOBCDeEBjvDu+09Ut+dIdRDv8Sd3xHtQwwJ9TO0bmTpmCeDW8V4W/j4XiD9G6x76AKl9P4JfghX+0QuEIU+Zxgw4j4D4CFVhKOagD8kzekrMURJDDLXsYeMqRGnEvNUpWHdU9BH/78OWWcN4LDvkIHgHiJCEA8kulw6//D9Yl3JNnJroaSw4DE1MEzGlG2OxGBNOZSdpj10vlqw4pORPiugQvOxfGUd8rGP51WaVGEnZTrSA+z/ywVa6cHJfTrmOLrILsAFkymzelNFTut6do8tj/zMrQoa8mJKzQXyd3a36iRnxgljCoqENB7tXRclKb6+WZpfMJBeh9NsrU7ES15H8Pd/Xqcy0UQ2/3F62Oalakn26itSWGzvTLuv0hwUyz0fNKXa6q+f1Fgz4hYsPs7YelltZHJgsoZwl1jKTCrJBZSrA7DDrke27cUIewgyYrOshMFnmTGMCmx5sESY0LxFgVyiVoZokdhzNdAFPyaiXi0Rvm6y5ciHPdSXUByhSnh6dHqqw500V0c4bDPmmOat6urC/4oHGUrpWm3Abqv2V0cq72qxYpQ1CJbHuEXG97kaJLfUZKg6OPrSLDqgIHdx3c+R4XRBf9NgZAAaUMJ1PTEGO5dvNZYCkT7Z6BGxclkXfpa/DxEUGLnP3TATvGZLMmyg6G2VkWetf2jpfHA0WcwmyVGGcqOjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(71200400001)(6636002)(2616005)(122000001)(83380400001)(6486002)(36756003)(38100700002)(66446008)(8936002)(4326008)(110136005)(26005)(66946007)(1076003)(2906002)(5660300002)(508600001)(6506007)(8676002)(54906003)(186003)(38070700005)(86362001)(66556008)(316002)(76116006)(91956017)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1mM7H8Nc6GHQs/YVA4uWrqwe4D54Abn6KCvakKK6qnz7jck1llzOVVeVMw?=
 =?iso-8859-1?Q?qcF7vqtYb1WBz3RJ1CYI2Y+frLunntW/zARfkEiuFD80BZXw1Hu44Ypuam?=
 =?iso-8859-1?Q?stMd7GfFOL66vLzUkFvmYmKusIeiY77KfZFrovZxyMQPBD4asbWc2gwXDS?=
 =?iso-8859-1?Q?0wFdlLZbdGhA7q4446m5IqWsvEVH6PG/fEOI1RS6vDPrr95E32jk6NGBoG?=
 =?iso-8859-1?Q?zc6qpY5bhzvJSaiwpQHYMZRyLZN17yTDfm8VWOQpT6rHj32kHoyD9tofPD?=
 =?iso-8859-1?Q?mry8h+lv50jjNuUJcEyB+6gRuINVxgk7d2vi5L8oKOt6u1e9iGLQdJf4+c?=
 =?iso-8859-1?Q?S2SmKnoNaNtqVvS7OHFzaY77+KC2qVqMt52VsNzNokJlTtj0x9KnXXS6TU?=
 =?iso-8859-1?Q?HBcXzW4jwrugk+429BgfJI2rE1aI2yPjWkcYyfEFUjyL6lDWdwEhIMWgkh?=
 =?iso-8859-1?Q?siKiysv3YcpxpNjIjqJv5XlF4cPPbLif7spHo6/gGiDtG3Apmopw+HzjnE?=
 =?iso-8859-1?Q?AJUP4X9rw5QLEh00lR3K2cpUAruIZHWHXHQoEpi6vnRtPgypC2XngLQc1U?=
 =?iso-8859-1?Q?7jlw61/OmggKQmiNdcvoxha1DOQd80DVk+mwv7iTwXdY/u329HI2UcKifD?=
 =?iso-8859-1?Q?rqCOyHofWT7cy00BcKXNGDX5+7RW3zrfpJRVNMbv6oFcTY3Gdv/AKN2Ol6?=
 =?iso-8859-1?Q?rlv1q6XC4OaGZUjlzOlcNaW2OGKGBVBWCvsZX/Ow9D1l9WmWAH2du/XdnX?=
 =?iso-8859-1?Q?DAZQ1z4hl52UCDelYQ4fUFz3dRvcFcAT24YqEv30jCR9JuKMEKmuxXnLJU?=
 =?iso-8859-1?Q?L/RXtThSzn9g8z85SyZkyJi44mpzx5ZLmEWRmT5E1bgGR1yo+bd7Kb90IX?=
 =?iso-8859-1?Q?9N3WW0UuMqbYiPYE5n0ieP1pMA52osPoK/4YkS389yKiSL4Pk5Q29HTjkG?=
 =?iso-8859-1?Q?COsACHBmc2Iiy/I0PbAdmYKulX8Enk6y0p9/lK9Qbm6tURxEJqTrREalm4?=
 =?iso-8859-1?Q?Qw8rFdudpbw6b3AnbiXzJ33O1B2KKsih2XplkkbWchiLGftiUrGFMeivCr?=
 =?iso-8859-1?Q?WD4PK4emigdkkQ0wWb/UiEnZCB+wSyVt4RWH+uGnO+3aSxTs5ditJJ/y7G?=
 =?iso-8859-1?Q?9qBoapW8eOLX7WERGlzmHbVz8M0AVfCXnHBoTYe4nemP9Ldy8iRlaJoFD1?=
 =?iso-8859-1?Q?gXkkzeyt9Bm2lPEE66yirpd8FsUBYFf19ZXANkBCtXa5HZiRqaufiZt+EH?=
 =?iso-8859-1?Q?JIrUothU3Y92C8NwNhaFyptXCFpXR4H8z98xumzLSZM9/xLJDhmN1Weys7?=
 =?iso-8859-1?Q?zzL1YuqShNk0Yta+JfFl2WFMzzUJmutGpF/c2Scud5d2vZqnbUnLoJ13yw?=
 =?iso-8859-1?Q?2gnCbQPSk0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd8aad4-e113-43e8-9b28-08d9608d61a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 08:10:59.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZe/cvH5gwa7jnknAe4vjttfyYt6yiBAD+0H21CRKKOYx2IMcXpE7ZKQ3scYiigKulMMz1AsiWQUqWcLHXdZ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4516
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

MD5 is a weak digest algorithm that shouldn't be used for cryptographic
operation. It hinders the efficiency of a patch set that aims to limit
the digests allowed for the extended file attribute namely security.ima.
MD5 is no longer a requirement for IMA, nor should it be used there.

The sole place where we still use the MD5 algorithm inside IMA (setting
the ima_hash algorithm to MD5 if the user supply the 'ima_hash=3Dmd5'
parameter on the command line) fails gracefully when CRYPTO_MD5 is not set:
	ima: Can not allocate md5 (reason: -2)
	ima: Allocating md5 failed, going to use default hash algorithm sha256

Remove the CRYPTO_MD5 dependency for IMA.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
---
 security/integrity/ima/Kconfig | 1 -
 1 file changed, 1 deletion(-)

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
--=20
2.31.1

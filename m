Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557193E8F93
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 13:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhHKLlM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 07:41:12 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com ([40.107.21.118]:48096
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237385AbhHKLlL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 07:41:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StK/5glKf+nT+Jol2BrS2znghNMkN2j3Lh0S6ubRGaCZ8qssoiWsD12GXwoA7hYDblfCl5gR8JuyV6+TdY3FuDZxoxlnZeuigV6rIegiXwGzdYxGuRfL//2fZtGmyzsBVngKk0dSlD3MQGm1JVHEW7NxyvxA1SPYwotFx71woC3bjQuyskPjg6MrTA/HhaH7txWGRKIog3IRvlYGi9eGmIdpgck9BnlE3zvCtEAJPxrgA2wdZc5BnGiOwFOny8N4tknQTcORgIggn27ulznlmUri9sLyshgR1MLfimbOMU9J8C2gBOstSOf/N7KO+yCM1fXwBWS+oSd+ZLJp+iDCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGecE9pDh1EGTYYt5lYmj27ZFKYKVDIi6OAfAH0L2xU=;
 b=Is+dUjhkPKrLS3j40xSpxOFyWxN2hmZMgPfMd+Iob8FzpRYlCzmDyHjN7agXILdXQPaI2u0m3zJHDXQZJpuUJsyEcK3Sjawz1odZot6D1BQ7yzrulr/m9tJHfjPVs/wPK0MuT3f7PAwIG1oNe/fJcN0GjwENoobcxiKg6nXH8y6uNW9wADsreBrqGNBmd8wTdPX9BFwmVVlzbBImQgf3J/xTpV0wUeevtLpJUwlXNFf/KO80qOdVHbEX2a/4mYf8q0zZgwLc0S/PcfltG5QbaCC4uozXruTaPzDy06w+LeYxYgprdxEOdy3cbPYA3mum/+EhD8PpfJO2GuUzxI5JRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGecE9pDh1EGTYYt5lYmj27ZFKYKVDIi6OAfAH0L2xU=;
 b=xfbnZdI27+spTfC07YaliG6sYszJ2az37jc5YoA8LSLbUZ9rC4izNNoeVcNx9vH8x6bcNOY92rALd8H4PnS/EwBNBnaaXLgvlmSg7F9PMC08fJPlxJrKLy8EuvtJXWgRwkH9y/yStER1PmPnS4gjHHeMIYFVAs2TtTjXBxZdq/w=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5105.eurprd09.prod.outlook.com
 (2603:10a6:20b:30a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 11:40:45 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 11:40:45 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v7 1/5] IMA: remove the dependency on CRYPTO_MD5
Thread-Topic: [PATCH v7 1/5] IMA: remove the dependency on CRYPTO_MD5
Thread-Index: AQHXjqW5bdV6gCmCy0SiyopH3D8xRQ==
Date:   Wed, 11 Aug 2021 11:40:45 +0000
Message-ID: <20210811114037.201887-2-simon.thoby@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
In-Reply-To: <20210811114037.201887-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 464322ec-eec6-4364-aede-08d95cbcdb9b
x-ms-traffictypediagnostic: AM9PR09MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB510584E3D58FEE6E401C3E7794F89@AM9PR09MB5105.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RS3EVePQ3GfMsIZvuBsRdK+whZ/ooKC0hZLcr3Xb/zWhGVDr2/uin7NG2YH5waTTWQYT0eI7gRcyJPJL2WPLktH97MrD5iYpiMbcwqSGD+8wzE49PNiBNAk3O9RhuALNXwUsCn89G4lRd6qXh5yJ62g989SG0mEFcP7IiwK8AsORzI6LTPl+6n0lHEtZS4sU9+7VfInwuPRA788BYjpM2lyv6iBIKTeq0VDvnhb3dpAOYe8U35ByCRlNJ93keAO/G5StMOcFVoARCFtn8PmPEOc7x5KWqnt6otTlEoI4eib1hSLPyELt/27SnLYaqdgnvP9Yiyo5MYdvwsuwRegeN6gtdtgpOV8S2jzLXkArJfe+PTTMoseqVc839SzZMirBtoHA6wSjJ6OH25aKRZGrfRbkm43aOlVPd1qBMfbLV1Ce95ppscJaS+dqk3hsYt+xs7MGUjohYiB/DxqTBoV1dWANaqFX2M/6eoTtg7zCCUV8ga6Xm2EDOEfJBrmxqQXrFFN/HwECqefBFoDbHZ4moxexcSsA6WG2/Uinth+2AtrIBTTj2n14+Y6nFtPgEQMuw/4SGXuNkwTXRIS9pKy0nDgTLepw5ZNr5pgpM11yIpxe3GadV+5WrplCgQhudqmJv7yiUWbPQq7pmso3RorPX3IJK7Ace238obwcZUdqoJA5HfrCHM5PSrr9ZInhWxQwCmT10rqB9Zgf3rwbV7s7cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(136003)(366004)(376002)(2616005)(5660300002)(36756003)(54906003)(76116006)(6512007)(186003)(316002)(8676002)(6636002)(6506007)(91956017)(64756008)(8936002)(66556008)(110136005)(66476007)(122000001)(4326008)(38100700002)(66446008)(66946007)(1076003)(2906002)(83380400001)(6486002)(38070700005)(71200400001)(478600001)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zKSCmqXud4KJBs0eC3nQsnWphP7S/GdlzP75pzE0JP3bGNkbruZFXT0Y7i?=
 =?iso-8859-1?Q?Gz3X7A6DJk/Z9P+s8E1K/k/qF6FqNsLQxu9Bk7iyW8C1nyIVZmie+CthHI?=
 =?iso-8859-1?Q?t6S4uEdyrOylwDJDmfE5gDplHty3PXuyjYUkLwEHgGmygWzM3ymZFSzp/D?=
 =?iso-8859-1?Q?aFnZ4GFrz4elUg2yHct9lyIEQZuGESbIdsT3G2tCp4nvU6F1aFX4lWNF22?=
 =?iso-8859-1?Q?z2hmcNOttvDfXQ3fskBlGjnxv1lt7ZRgsuCY3VwXsvVHYRxwwqMLa7I0t5?=
 =?iso-8859-1?Q?2A4MfBNN6Qcea4EzgtjIqkGDcMzysRXf8ucVh+Rw6BmuJ+8uHPeV4RGwVS?=
 =?iso-8859-1?Q?j2veAwRdcbFqF6VsLU75xxisnS3mk7/DDviyrfpLFQE0NTNgX1RzSYacGs?=
 =?iso-8859-1?Q?Hbtn7j/4dj2MwvfLjfqeQCQKDxh42d1OmytQOgAtYO0chZ37ICHn1vSFTE?=
 =?iso-8859-1?Q?W3usZ5hD5kSqeN69E3QfGByGTgPn/HAs8DQmkrT80LQhhnp0DSDQD0qHUJ?=
 =?iso-8859-1?Q?IBb3X+IsyxnrwmbxyD0qDf9fi9exttB778zkaEVroe7n1GNdCEHZ8VfjMW?=
 =?iso-8859-1?Q?+CgSGvwpPi2p8wJlik4WRGSswN2TfXqJte1IoJBtjnu4f0wKZzteI/Ax+k?=
 =?iso-8859-1?Q?RpBisYJwDg+OBFLy0ZJ9S8lWcQLhgTxv4e2fu2Hp90q5q574DsC/79BwdL?=
 =?iso-8859-1?Q?E1vyeLKVL+K74s/nCFcyfHp6qAd/IYz373qyq0D6RQTTHz/R2AJx5JcD/b?=
 =?iso-8859-1?Q?lUtrMyYxFHpqTfPWbHka+Ac/cMIBtPlmJ0FJ5mT2TT0e8pEeHxvj1c2S3l?=
 =?iso-8859-1?Q?JYnzfabsnqcQjz3YMMx8LNZQ8L0mtWxen6GvrBW+fF8C+Uz1XB2kc20xqL?=
 =?iso-8859-1?Q?o7uLYPZUQub4+lS1F4SsCfxMIlhOyP/X5lbPcFcilhbpMWZP6/XJ+fUjH9?=
 =?iso-8859-1?Q?eqxxfVgkEdVq+wzJkRVVbk8ldbhbhKtE2M+HvbB7BwkTYa35hgi9gCD0G2?=
 =?iso-8859-1?Q?JhctKkR6PKOexu0/fbvJEw0ECPALK626MlgsMIJEoSAHLyQfPxpihklzMj?=
 =?iso-8859-1?Q?yMTfAjE0MT3R8S/vAzCWtm5Ya9S93eap4gOlA6NGqzDAwnERwcUdQJCq6A?=
 =?iso-8859-1?Q?8zsF9jMCmHjYvqVemDITspAwoROCkKsV3MB2CgFyFIFXfAJnGSH9YxoLP3?=
 =?iso-8859-1?Q?GOPj9ZVHiOdxAMsrf+oJT0pUQba65Ni9QPM1JWWl3lJZBetKNhxvchYWOb?=
 =?iso-8859-1?Q?NA/Y/jKiyqM8clfC0jX0JUFw4+WOLN/+v9Ac4c0R1SIRf3QAy/uIBQ654x?=
 =?iso-8859-1?Q?Q9murchPntxL0ihk+1RjWa77AoLD0mMxSRFm2n/9gPZ7eLZ/agjB/2tDHS?=
 =?iso-8859-1?Q?OnIvYVvegb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464322ec-eec6-4364-aede-08d95cbcdb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:40:45.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gp44fojIP/afS9jKW5N15GIgz+Cn6Z8jKrY7D2teJ2UqXwW0Q2XKN3GwXN6KoMJ07/Ws7xblTqlPJ01r1PjRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5105
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
Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
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

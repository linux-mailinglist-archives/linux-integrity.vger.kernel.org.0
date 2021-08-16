Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F863ED003
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 10:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhHPILf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 04:11:35 -0400
Received: from mail-eopbgr10114.outbound.protection.outlook.com ([40.107.1.114]:26756
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234637AbhHPILf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 04:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnaw+8ciA00iTmN7V5v0utSudYKC0ev9b2M4bohiSlk8gidhEClHSnFR225prBQhUE5vyMyYi9scCaFoVEvAa73uvPeZVh3OYkYIHo6Q0ZW+o3TErFEAWZXhjBqzXRC+k2W9hByJoXjG2tvsH+/EExpXpsH/C+hx+HERUeAnAJmpLeccA7Te4BB+M9Gartqxmxq2vJsE53uV+Zf/nSQcZE4hazrNkYtjqFoMWRT2+qCooeRcZF2MhUPktcFu9tcc2WjRHS4ecc8c6N6NO1ruZhRSk2hg7ySglZx4FtIK0JWzLvU56alCHYmEIyippRvYpQX4tGq8cB0kdVB7OUEd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJqBtIdb/nt6MhQ+tnZbiKrtHw89Qv1G+FZUlBqtpW8=;
 b=jUpA99IFA15RT7mGjkTNMz3Spl5qdqhFxI0yVVoJzls7Kyep8MRJjzvdgdQ0LPb0CvyogtsLV2VqkA1/lsA1CqI9A2HOTpxfkCu6kpxTXAD1F8BuHejy9q/tUybPrfnF+2ogIz7fuCrIqEoluKdsZJCFMtuUaL0A1aF1VejvJc6J80vYyJo7UnrDR4UdNh538FNSZ6RHm8hm9vmYkyz8Cxm7WxKT6vWSx+FG1YCu5nQOF70h1ItzqdU0LjD9PziQpPblq5e9PQvcW6Ozjm6jaOxwIrXYtXCEyViTACU/o9Ooz+diT435INX3/wEEXeblczqderQjNnZsxYNYM1iOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJqBtIdb/nt6MhQ+tnZbiKrtHw89Qv1G+FZUlBqtpW8=;
 b=L7btKvwKvyiiK/COnPyRpiLsZAuGMtLQDVbDkKnegUexEKPxIbhhpdo9djRUYRsvHAdh2Bkro3PRRnfkUB0sBraoDe/U60fAsdkW3f4n7R69RKAcvpaZZSxo+5hH2QwJ5XmCBkr139nHUrJvO3ey1bCQOg6ucyWWQQVGpipHiDQ=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5073.eurprd09.prod.outlook.com
 (2603:10a6:20b:301::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 08:11:02 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 08:11:02 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v8 6/6] IMA: prevent SETXATTR_CHECK policy rules with
 unavailable algorithms
Thread-Topic: [PATCH v8 6/6] IMA: prevent SETXATTR_CHECK policy rules with
 unavailable algorithms
Thread-Index: AQHXknZABL7BGu5ZKkWVcYT+5iM91g==
Date:   Mon, 16 Aug 2021 08:11:01 +0000
Message-ID: <20210816081056.24530-7-Simon.THOBY@viveris.fr>
References: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
In-Reply-To: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb03762b-1f3a-4486-3900-08d9608d633f
x-ms-traffictypediagnostic: AM9PR09MB5073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB50736721173AE854C3F9143694FD9@AM9PR09MB5073.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2q7Ay6Cv506IbJ+vLhtywFej7/W9wnp1tgXISKvsLCpzmMybEkrzNWMxeAhn6cgRg6QxUuvYEZKcJkqobRIeb78VdSdd/Q+A27UKhMxnab7oX6WoNTnYnO9F/+KQNaSH4vCh3B3wERWNQZ+3zNgjc0Uva24PKlelGPaE6qAhYARXsHm2VKFIHQ7CaRWRtDaOZmbRQg/UZ50i9ZF+Nvr6VGRn6tYVBJGQq4oiua2QOrI232yRw6L2Gz3na1gFE2rE55oChfiEfJgNiAh15h2u8YHpilvOYRbLguHC6h8T7Xk0/c+ZrwR/ich3ozhw9YEnujmMgBhRDYOLtKDieO0U8wYXWiOVoZctD61QV5iQTKmCdsSG0i2JAFmNAScSbkiP1LgPpdM/9dpnFqiPrA/4Jz+j3kisVj4RxmYbLV4UB2F3BCabYWB+3FfSL+N6P8BnCr7URHGHl4DrdNmL2a43CTENbqTM+5ylX6IaOOWvXCuma67uIKemsipR1TikEnvoB3OjKFQ1suqMVhY92Xns3nNUiFy5KX3bJRy8frr+qwmJg5Lk+al2mSKOH6poorsSkXiX8mgBhg969Vt1a/uLDa+4jmB06rw3MIvKHE3MOXyHTFtiAgbuJjPph2UUHWfoJOzV76RvV6z+JU0+PkQTfgc7r3AnvU0ijSFLrQPRTNsFhRT532xQ8UjP1c0ZMnQKwBF7MplDnFVBarL+txhTsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(376002)(346002)(136003)(366004)(396003)(64756008)(66556008)(66476007)(6486002)(66446008)(66946007)(36756003)(8676002)(6512007)(122000001)(478600001)(38100700002)(6506007)(76116006)(91956017)(8936002)(86362001)(110136005)(186003)(6636002)(71200400001)(1076003)(2616005)(2906002)(4326008)(107886003)(5660300002)(83380400001)(316002)(38070700005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0+F8VNldARslWMAaDfOucqYjjQV+QfunY7Udizyf3xz0Xa9V2j9iDe0mnR?=
 =?iso-8859-1?Q?w2sSAk/OPgEJKKRQTPUfBx7ardtsP4ODZQFE0IEd8j2J7c8Im2uK2aaLW6?=
 =?iso-8859-1?Q?jAPT+f10rJtXo2DAOLY4k5TnyNHImtHTco9LbcObTifRv4ByhjDgPIHJ1Z?=
 =?iso-8859-1?Q?rIsb+fJUfIqL7Yy+9cB4D2qpg8jBrItqbsWeRQrcwiQ1FLSkEaU2+yDtpR?=
 =?iso-8859-1?Q?LebBhTzFbhdw4TCtT2SmRCMj9G3YJWfJLRac/Ga1WgRwN3XAk2YRvghx6k?=
 =?iso-8859-1?Q?G5IEDTNYrUUG1+4MbgnOUhU5tqp66GSC68hZzB3YLIKVJwMZz2WNIVSMTj?=
 =?iso-8859-1?Q?b3OlxbJ33paf0kKfCIYyfJ9HopPaQ/BMYhFxZDJdIIJcse4G3oruRDLLSD?=
 =?iso-8859-1?Q?d54TptC3JgUhkKdaSvyEo3Rbjes3HdOCpliKKAUUDIr85laxTwzSrs+drs?=
 =?iso-8859-1?Q?FewGFsO/1VLY2CLFYFAkgu32lR03Jkn1qa/pQUr2C87eownI3Sv6gofAmh?=
 =?iso-8859-1?Q?mNQ/L4fi9iZycOhfddIWi3FpC0myLSKnQp9D3L3qqlPvHS5REBp5EmGMy/?=
 =?iso-8859-1?Q?cv9Yj0yruy2a9NdVUDd2Jpj7800mcM9XuKG+Jfd9LilAKF/LqnOPZH70yc?=
 =?iso-8859-1?Q?rXxrXKod7lPFS4sHusS7aNx2MzBSXQ3r1FymR/CcTagUr8pLkoBigkp37m?=
 =?iso-8859-1?Q?l4OA2WE3+9N2xu71frgDsPWY6Js+npy80gIelM6+Bk0qvrBuH+hv0s1WVu?=
 =?iso-8859-1?Q?ezR1cNyCRgD4kifvNDXjL8sjDMz7xp0dLo+cxyS0xzJX8j9USUlEG5StI1?=
 =?iso-8859-1?Q?i8PsLKy1uCEqP3kOcVtyB0T0YUOvm9fVIjF4unRihBoOz8CnNoKLYOGy5V?=
 =?iso-8859-1?Q?YdANHNe9APOdLTaH7pzLviAR5/WZejsjRAEPTP/jU+xdZjLklZEXUL0w52?=
 =?iso-8859-1?Q?UU3NVa30KschljX0MJap6idlRgQt7ayOcca3tOr/xekvj631vkpcPTmicU?=
 =?iso-8859-1?Q?hPKk9YkgVoPof3i8iqy6etmfL0fgjbmv7qrvdbe88mgfzdlKjJJ89zDyO5?=
 =?iso-8859-1?Q?wXdwbPTu8d3vmmnj+7w3eFx/G2EHO9gEpsn9Q+RMeMzMpXtciJqqXaENQO?=
 =?iso-8859-1?Q?IfzNvxfCWsTQgJ7rGE3r/CFC1QHJyvwcxZV5mb+ni3CD4qdWnhHmscZOUO?=
 =?iso-8859-1?Q?obbsO54s6OEwgDqfVy8N1tAOaS9KE/cU5DD0xBwCMVbu13ysG3WE2l2ckz?=
 =?iso-8859-1?Q?zt96Wc6pK/Gb6gPMlHca28Lz/oVUTB4YbnccLjOnv9BQ3eaOJZ4FKDRkeq?=
 =?iso-8859-1?Q?cweWfrKVYj7b79r01jA6AwMAvEUIce8J4TUt5oL1T+g2L02ZVVbalcUcvz?=
 =?iso-8859-1?Q?BBHOdHEhHq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb03762b-1f3a-4486-3900-08d9608d633f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 08:11:01.9849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGdPIxUep3jRTNYxqoCPrqrXhRONc2c91h8hCrBFXVBsFSB+064TpL8jaUmXFBq3wa7To8PFteewqZfFC0eejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SETXATTR_CHECK poliy rules assume that any algorithm listed in the
'appraise_algos' flag must be accepted when performing setxattr()
on the security.ima xattr.
However nothing checks that they are available in the current kernel.
A userland application could hash a file with a digest that the kernel
wouldn't be able to verify. However, if SETXATTR_CHECK is not in use,
the kernel already forbids that xattr write.

Verify that algorithms listed in appraise_algos are available to the
current kernel and reject the policy update otherwise. This will fix
the inconsistency between SETXATTR_CHECK and non-SETXATTR_CHECK
behaviors.

That filtering is only performed in ima_parse_appraise_algos() when
updating policies so that we do not have to pay the price of allocating
a hash object every time validate_hash_algo() is called in
ima_inode_setxattr().

Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
---
 security/integrity/ima/ima_policy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/i=
ma_policy.c
index 9eaa509f487a..87b9b71cb820 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1258,6 +1258,12 @@ static unsigned int ima_parse_appraise_algos(char *a=
rg)
 			return 0;
 		}
=20
+		if (!crypto_has_alg(hash_algo_name[idx], 0, 0)) {
+			pr_err("unavailable hash algorithm \"%s\", check your kernel configurat=
ion",
+			       token);
+			return 0;
+		}
+
 		/* Add the hash algorithm to the 'allowed' bitfield */
 		res |=3D (1U << idx);
 	}
--=20
2.31.1

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636B13F2BDB
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhHTMTo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 08:19:44 -0400
Received: from mail-am6eur05on2125.outbound.protection.outlook.com ([40.107.22.125]:36064
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240270AbhHTMTi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 08:19:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt8oA0l261VfUvcH4/Awa0gAmuanUOaI8Dab7ozzcRzGk4K3mIztQ1DQ+vMvzUkJdiQIiip2sKfOBSsHtwO8BtLiN9p7gkKCEnw/dsPagkyBe1apkTUZInj0dBoKgDd5QzomTjBlFb3tuV35n1Q0A1WvZBhFAGftVYXJDg3tqp+IAzi+dPJ+wIyi7HI7pPeRLShiy1enpjZedGDNFIUov4+M1KfzhZQWJf7pU44hJmcu4woHp8f2waLDnvUQPjxUnsOTFLmw4Nsi2VzJNuiJKDSQseXYBprvQZQRDwQZ3AIFjsPJfSv3qeERPLBH/Eg8QTe4Rm5cU18Lgu3I2+XN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUv6Ffm9Ipr88bPVneF9uOsgwuz3enBHNeBY/Iyj6fU=;
 b=fQAWidGubYLcbpCZ8np+/03yRwrpji7OJi7WFYeY2//wsPCUZh+3Z0o8ZTHwujd7oozDbnSoCduK6V8dMhS/NZyfSjIV78u6T6MSDVttqX2AeFHZfy4A6opS/GgKExJlJpv3dOPcbNWzJ7M/CO0o2xdrF3ENv9SQP0euMEZ5QOjGLL/7lA370XU05CxDkxD26Qn2yDKRnoCuskmwxcbA/DBmqRE15fotnqqz5ZwKtxLCi90oMgURVPR8LlYpZDg2w9MiCqDf7qmqKHV0S0JZGIqPO7dzLeVPFgnaLGtY2hPSrjReJTuXd0XQqwVQB9cpBppXIV8wLux+QkYXpM0vYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUv6Ffm9Ipr88bPVneF9uOsgwuz3enBHNeBY/Iyj6fU=;
 b=cXREHtOOkSAmlqcPCl9yO//ykj7W4wHpc8yuljU447Lw6ZgvVpn3i4L9vWTuiMbwqcYw01tLfmQe4a0b/pHGOeWfPhCGaAC/6eZqaxAfzfn6aRL/5fG8fPjx9vjEs/lKPlrmBUzS0hNtcyoXhEu4V6zFR90ts43w6eyR7bMCD4Q=
Received: from HE1PR0902MB1755.eurprd09.prod.outlook.com (2603:10a6:3:f2::20)
 by HE1PR0902MB1739.eurprd09.prod.outlook.com (2603:10a6:3:e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 12:18:57 +0000
Received: from HE1PR0902MB1755.eurprd09.prod.outlook.com
 ([fe80::dd95:456d:43e0:786f]) by HE1PR0902MB1755.eurprd09.prod.outlook.com
 ([fe80::dd95:456d:43e0:786f%10]) with mapi id 15.20.4436.019; Fri, 20 Aug
 2021 12:18:56 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com" 
        <syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com>
Subject: [PATCH] IMA: set a default value for unknown digsig algorithms
Thread-Topic: [PATCH] IMA: set a default value for unknown digsig algorithms
Thread-Index: AQHXlb2Mz5FNCgaZH0OE6wUyeJ02gQ==
Date:   Fri, 20 Aug 2021 12:18:56 +0000
Message-ID: <20210820121847.34087-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c0148cb-f6b6-4511-12b0-08d963d4af03
x-ms-traffictypediagnostic: HE1PR0902MB1739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0902MB1739F5AD0F0CDC35C87AAAFE94C19@HE1PR0902MB1739.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9FY8DAacXGoS8siyLWjGP8DSCXmiMLGh2voidvs5tZwNtnmH0he4PGaKqMkFnRgpu1DcjzbTafSbJcRMv+wRCMF5Www9kUrXN13t5fX235EDkrHYwsfpO2+2mFTVZ5oIGhYiV4D5f16I9fwqwPH7VnlY5qzpLzEpK8RSxLWtbbiGoI8tgyFPCOa37gSzD4jjVXubwTndNNmqaOM0m/nSRCgiooDo5F9d1vk4zaTmgG/IIp5k1TDsWL309swUnQvEEJiewkMo108K9uqwfmYjvchmrk+K7yGGmmYhNv4kAVLzz9Ka7yMvGiGtAaU67xZcrYkV27zmhbMZHPEW4kFU0d7Ll1RcXNdqLEThIV3BD4ZKQ6j56jT9WAzAd04JBCUmTNZQ9mWourQD83iNmlrOBPU4/uCzkJDssOErHo84ZUpEOOZk9zy1PCcHbItOE5+HSK1VNO/ANzRLAkEAfL6Gi82+jEY4yED8slFWNw7yUXhX8Tb7S1x2T4rf7NEi0bwTo4XvyUsuUhflXzoioXjaAt6RKrI0GD5NVlXWkZ9JtWa8vTRC0zmst/cP1MqxrOqN1O89XnDUYp4Xo2urUz24KSFFKjyDBk9++DqGIQDO8NG9oD5/f1Uj+BtNoGFglzLnravpw80wyoykM4JDviRmAGTzTG4IMwMN0BQ6qVJhuHzF9QFZ3EiVIQiNwVKtLOKGUEzuvtrGUF0CxLsfp//oD9FNm0RJCwkboOxb7s4TiXOrba9Shaexffz4yvMfxiB2zQcuncwX5Xg6eBvMmSpqqNXsGds9DZn9CG6KHa2YyqG8j9uTQlF756zkz3idcW9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0902MB1755.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39840400004)(396003)(36756003)(83380400001)(110136005)(6486002)(54906003)(2906002)(5660300002)(966005)(91956017)(66446008)(76116006)(66476007)(6506007)(8936002)(26005)(86362001)(2616005)(66556008)(64756008)(66946007)(478600001)(4326008)(186003)(38070700005)(316002)(8676002)(1076003)(6512007)(122000001)(71200400001)(38100700002)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LaXqmM1URDy5sdLT2TaZPvK4CzI6FqLWFqZ1AliV8ByrTZ82v4RJFxoDgm?=
 =?iso-8859-1?Q?JrUj2OxRxmLjApFsYkZc8JNh5Xv957ON74LUOEEiRIGiGTdEWCw2jj0tCw?=
 =?iso-8859-1?Q?KK/HM3ImXnfI3zu6iKVYGrdYh3ESfuJtOB1tE8TA0MMBQihzApriut1xuB?=
 =?iso-8859-1?Q?N8DuCc5hQvykjwozoY+rhywPJRN9sbEw8X1Zg4TfvcJRcnAO7apNbq2Z/m?=
 =?iso-8859-1?Q?NKp4O1OafYtX6849xyCtnPG+bU284u92573RaJQRubZoyZST27xA+WBqYu?=
 =?iso-8859-1?Q?mQdm61d4XIrT3MdJX7KVHizkqY+hD3IuM+lqGFJvziJLzSmS2xJxCyK4gO?=
 =?iso-8859-1?Q?6U3ojOUlrU21KB5VutrfLzVLPcpz2tHNbG2EMt9wgzYVqfPtZdEFMDvFDT?=
 =?iso-8859-1?Q?2aVvK+C17CraV+OVFETuqb8c1Dwh98HEc8p9QnszTLSLx6Q3tqK4omVkwq?=
 =?iso-8859-1?Q?2VkanRZgs1/BIt5SjNdjG8B8uKJxlIAbN4WqSpa19faoKAEpTmiaZO011a?=
 =?iso-8859-1?Q?YF+i1AsX3i1QLhl3VtdEt9wkQeXLf00ClsZ7NC2X/kEjYwTOCYtzv+UxFY?=
 =?iso-8859-1?Q?Bd4ditMDOv9U8bGHTqcUMdGa15E9n8Fwr+Cz61hHjSXYLUUo6L2QeWQRtX?=
 =?iso-8859-1?Q?bQIK+MoF9uh531Iph+01au/zeLJn9xq/EyNzYKCDDJv/rZETc+Naqm7D/T?=
 =?iso-8859-1?Q?FR/ZAFbaFR9/F+tVeLsWumSkeWi8YI/S6tOhHQKqZLTrjivp/8/amtXHfS?=
 =?iso-8859-1?Q?DFfpXXTKQErbH0+F1hDmfzlxehGgXmCWfE6f0EKzRQHPsdsib4avlHgb91?=
 =?iso-8859-1?Q?TodHIpv4DEZ3+JwfBkElJXkfCjFgERkS2cdZ05DmKN188czclmoBjKj19m?=
 =?iso-8859-1?Q?k7MPfp+x/Y/jcMUmorUcFUsPsdlGAWnMTAZPJkmsclLHMpRUMs+ck3/yWM?=
 =?iso-8859-1?Q?FcuomBMmKkL3fIb2EKhSDBu9qC3ma8FQbIBllm8nhtjeMrJ8UkhJXIbMRD?=
 =?iso-8859-1?Q?Pt8HI7G0hSU86U3Z0BVLp1SDVzh9yvv9Sn1nMh3rpJQsQb5SjF64QS9IKa?=
 =?iso-8859-1?Q?xrHXoy4iXDIZzQaQQJyT8JhGVFiQYITz2+qkHaHKgFyBsTTd5kH/tcIDx9?=
 =?iso-8859-1?Q?FtH4nW1ZbBCRVDC2qqkAXKtwhxHqtip7xuu/BI/doZRG763xNYI8EtwaOA?=
 =?iso-8859-1?Q?7nZASwYoqdJKIYzQNK1zan2axWowHj4FYN/yxZwK8PH0YGGq2egVqlu+cy?=
 =?iso-8859-1?Q?Ya6vxiH8cywApKtWScOEc7ct3wuEu/BzleBw2A5rDKlWpJCwrJMUzYCL4R?=
 =?iso-8859-1?Q?/RtVSpUkI2fCmqBXPe2Kl4VjP2ng7s6xKKtfRkzKWR48JeA6Dlf9knQYxu?=
 =?iso-8859-1?Q?YGh9VC5D/2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0902MB1755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0148cb-f6b6-4511-12b0-08d963d4af03
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 12:18:56.7657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLp3yFPyGdY7s/rzGPBmO8o4Si240KM5yRnM9ie4q+eJWq/iTmx6n5zS+2uES6sBCdjr0PEUTTVd86nY+v7yyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0902MB1739
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When adding new protections against writing invalid data in
the security.ima xattr, I erroneously expected ima_get_hash_algo()
to always return a valid 'enum hash_algo', but it turns out it trusts
the user-supplied digital signatures and return it without any checks.
It didn't affect process_measurement() because that function
(indirectly) calls into ima_alloc_atfm() that fallback silently
on the default hash algorithm, but it did affect ima_inode_setxattr
as that new function didn't perform a bounds check.

Update ima_get_hash_algo() to always return a valid hash algorithm,
defaulting on 'ima_hash_algo' when the user-supplied value inside
the xattr is invalid.

This patch was successfully tested by syszbot, see
https://syzkaller.appspot.com/bug?extid=3De8bafe7b82c739eaf153.

Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
Reported-by: syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com
---
 security/integrity/ima/ima_appraise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index 8f1eb7ef041e..dbba51583e7c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -185,7 +185,8 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_x=
attr_data *xattr_value,
 	switch (xattr_value->type) {
 	case EVM_IMA_XATTR_DIGSIG:
 		sig =3D (typeof(sig))xattr_value;
-		if (sig->version !=3D 2 || xattr_len <=3D sizeof(*sig))
+		if (sig->version !=3D 2 || xattr_len <=3D sizeof(*sig)
+		    || sig->hash_algo >=3D HASH_ALGO__LAST)
 			return ima_hash_algo;
 		return sig->hash_algo;
 		break;
--=20
2.31.1

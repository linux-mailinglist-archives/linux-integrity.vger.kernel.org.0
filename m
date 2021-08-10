Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879473E53B9
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 08:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhHJGpO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 02:45:14 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:13121
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236506AbhHJGpO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 02:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrtX8+ME+QE+B3EW0tdLsqA/Wt3BVVHLu8zyK3leaS0qVyerTTTYUjih9By+egYjNnYqDffjdQLQ9s3Fpw2uzICqUSfLDTNRzaH9aSVaTYFqhjfhZefP1CLLUzQy5yf7DXtOV/smCnuX2oVs1Cgy+EY8htswgSiQcAJwzM8jS3YVI/gCqqde1CNUR3FQK23K9XOBAqnJ4RpSarhO8iY4SM24kCqoSIs6PnnEb7KusCgCTHpy5Zj9zLQP9waN+g4ROHmDh3oqUwhNwRfyr3U1YRXJaBbV3pyaH+YyWqfos+Z1r5vNGM8nTgKndrRyMJeoiR8TavEriLaqcdYEKSPKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHyjmgcfNH1+bdm1MhMaKA6Cta38c3LolYXjRENIcCg=;
 b=dBu7bQqPauYxwuu4O1MQHNFIbmMnPnLD6X/cHNPMk+JwbqJb9Nvt6JMXxwFXe2C9jPzsgenI/tvCIem61t7tLXEg2RJNo21/vd7s3DqpgJjMk2/eMXZfI9/PBWmiVsFZt4+nziPqBq7tN0wOWJxTmxH00qRFa3KkZVqfaQfJFV5ihB67xbVIT+5lFebEG2QsGMpktFzKHlij2yVvARttTAIxY+mWm4kH9N6OA0XeAeGRtiiJDEj5NrT1ovLmEg1uiHZHJ2hWwSNHWFu/Dp8QE9A93uBZMlQqE6RPfpFcjH+iIqznrLvEjnPEjoVIIypjuZlHiCfcAUkEt3l02iM2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHyjmgcfNH1+bdm1MhMaKA6Cta38c3LolYXjRENIcCg=;
 b=jk6whW5A4f+GeMplZheiNWg0qzz9o/NlUiAF9JcyNS1Ajhb9rCViiAehlwhRgOh9dAt9XfTe7E1DZL/tGmVloZNwaRBdj6fO8rpvR/IqdeKTNqKa/q41l1t7NOJwVCzD0lgo7vJDPxdqV/ZjFLfo0SPuSdYACDCs349sovfe9jI=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4242.eurprd09.prod.outlook.com
 (2603:10a6:208:18c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 06:44:50 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 06:44:50 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Subject: Re: [PATCH v6 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Topic: [PATCH v6 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Index: AQHXiRHvsKoLCmhItESAenpSj4tG+6tr2/+AgAB4TAA=
Date:   Tue, 10 Aug 2021 06:44:50 +0000
Message-ID: <869c1745-217c-3ed9-2221-b3dcda946ae3@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
 <20210804092010.350372-3-simon.thoby@viveris.fr>
 <1381b22a98d7b43b7cba9f79fc0b739ed2816a5f.camel@linux.ibm.com>
In-Reply-To: <1381b22a98d7b43b7cba9f79fc0b739ed2816a5f.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a8c0a7-9576-4c1e-3634-08d95bca5a77
x-ms-traffictypediagnostic: AM0PR09MB4242:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4242B18D4291BDB3973DD62F94F79@AM0PR09MB4242.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vL+EYG8qIaAwqWzCRvxpVo+yc7aRvNDJG4BgntNFmt+gLtos+oTih4H1AAmpINBdaCSbGmH8vqfyfgXRaamkE8w2YNwT7lRauWkEw/0PwSRmjzrWwDkcqUD0kNkDWTNaH9RfUZT/Pc6BNgh9GeVJUKH/PSrCa56/1y+WAx3iO+SUZHNKQAfYlC4g1xQu2kcsvUmY1LyAiKvMC/203hqkuWcZzl7M3eUUKQ9znftYGxP1fLd31POUcLeSSOVabg9QlKwvAdWAobFdnx+r8G07yqBobcco09KlBQuImankYFfTdvR6FnZkpzah7FdLDyKnhqBOe4AJpCSR1GUiqTpWGcik4ZTNi21N/X8yie6DVkuYyfEWZPSlNtO7bQp4NjiaMqM8FdMZIV73KJi86pEtkSP6AQbQSs4/OD0Ms3HnmupmA0HjyIAB0U3/gL26497FeP/GfLO3vNiC6zSwLi1s9+WBoxB2AzNSAk8+KxdO9AFyWh1Tby7J9cl3HAvcd04xDtL+gybsrq8492mLCX9DeJhAA+BxACEj3/hhCOjkUgu3FtylmTg8GH2ofLYW04gDkvzwpNNxIfe2W20vJfF0jm4JW6tg3VrdKIiho2ZxtZFvu6wm5UbHA+9can7Ot43nGO0uDPDERXO+0DiXoYUlXziUmEiXo+Pdzdqf9eaHlcMG97Iygf68qDfRmEvn+7WKoKi15h0OtiX8kOjkM9H7kxTueT4v5alt3m405PtzXIdqhfgBglITGHJ3DBfBDQVW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(66556008)(66476007)(64756008)(66446008)(71200400001)(6486002)(110136005)(2906002)(6636002)(86362001)(8936002)(66946007)(15650500001)(31686004)(6512007)(76116006)(91956017)(8676002)(31696002)(36756003)(38070700005)(26005)(38100700002)(6506007)(83380400001)(2616005)(508600001)(122000001)(53546011)(186003)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?/i5J9FsKAYH5VoJYfuNsZ7rYm4KmBxWMpWHnVTdeHJeG0/KsvBNIwgSH7?=
 =?iso-8859-15?Q?W5R2B/agpnac7v8TQA807hL8GNpnOUoeSJgWKIq0rUs5hWkBpZ2wUO1Pq?=
 =?iso-8859-15?Q?uB/wdUu6LM6BKNIvGyczVVE6aCGEwMhi6KStI5EaPnDJN9aBPHwK9AAiI?=
 =?iso-8859-15?Q?h+J8Ff7G+XS74xM3f1hxyxDwcV5fCCNyYkpnA3NHyLBE9T8q+VRrh4iGQ?=
 =?iso-8859-15?Q?u/nUcWPZONltmTgF8/flX0LB5whULUQjHYROalc9gIRYGY83TsCOqnd7O?=
 =?iso-8859-15?Q?HDFYBpD9youjmobSOEc7KvgT0775PwDrdPnhS+zMDOIuRmka22fy8hrcG?=
 =?iso-8859-15?Q?lRwLNsdKxJNZMEWDuhag9YYaWt/i+hHcZD6JWvYCNedGZ4TGBNN635TqY?=
 =?iso-8859-15?Q?GU0kFmTEkTYBlaejjt8qLhQBX5VvVZb/suUw9flUOY0ni6qzSQRu+f10k?=
 =?iso-8859-15?Q?2ZXcylQ+cLPGXNtVerHJaKMBOb7VlHLO5L1SOYqmGRI17xTs3kYfiZRM1?=
 =?iso-8859-15?Q?OdL1Q00gmUj9+ZLXD9R2ARCu2ONnrTC9QPn0vVxJaC8NjLHuQX+im4jPi?=
 =?iso-8859-15?Q?F5umF/h0bp+1giE7ZPFS+IeLWAmeU+eEz8N/iptFx1y1cBQJTAagGviq7?=
 =?iso-8859-15?Q?A6vYVrKnFh/KzbxiUx3O86wpx5OiFIba6am9mBhqlHooRfRB7K4Wr4sr4?=
 =?iso-8859-15?Q?BbD2ckaBFbJxO4e2e7/3FfvUm5xO4Lp4+pqCRv16i2mHi4jTl9QHF6BOM?=
 =?iso-8859-15?Q?xNNSxf56F4Gv1IjNtK61W7is6tfpogCQ+rbtUbxMtX+F0T/lmx+gk8iWg?=
 =?iso-8859-15?Q?P+J/Xwj/kwp1ov7Q5YAPF7HeSlPrMhUFYuj8r2mrPuFS93RAkcqZ8MHjG?=
 =?iso-8859-15?Q?F/KXZBJdKi/X5O+XhZsxdg9GUfaJ3+zDK+6nfS4LkPPE/dYiRsgvGU+f9?=
 =?iso-8859-15?Q?X7RVhYOTCsTbHSxqTLIMHIOZ7BDdnFFKZFgqgPGZe8ZFS5dUXSbT2a+MU?=
 =?iso-8859-15?Q?5Bo5q3eowYOTg6gFGYeG7KvYZxqb5wtFLzcsahjS3iK2ECfN+rFMSx1Du?=
 =?iso-8859-15?Q?dcYLrRbAnMqUYywO7iYt8mDGJVuktzMUqmfE2UN/k0w7roFS7hR1whlub?=
 =?iso-8859-15?Q?LggojGuBYQePWH5R3fY0XQWuX0I43VSut423teIxatfcwUqYbCNHovKqi?=
 =?iso-8859-15?Q?rt+A+q/M+EcadDTluxCscrABXRFDbJofoOdy3mwrGq2BBzKb1lhvcl1qM?=
 =?iso-8859-15?Q?S4Q8faisQh+nduDkxncdWmulLwRyY98rO2WolJaYWpo3H5l6JOyk2IQaI?=
 =?iso-8859-15?Q?utuPCWE6aNKeP1w7E6A0ha2mC7HKSc+sGIVw6tZI/MdMOpDAJ+sK1FKFM?=
 =?iso-8859-15?Q?Rzu3enJG/SVUfZ7v4mVeKUDw7I6agEnZ8?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <B1C56036DA69CA4CA279F9DB19F36D04@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a8c0a7-9576-4c1e-3634-08d95bca5a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 06:44:50.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teDdGIX7yzkdssUUbXGefWpWebK5YZ8siv40v37TUUQx6CCtAJaoeJpFBoqRqRDPH3rEch76PJPsqRM4uu7ZCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4242
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 8/10/21 1:34 AM, Mimi Zohar wrote:
> On Wed, 2021-08-04 at 09:20 +0000, THOBY Simon wrote:
>> +static int validate_hash_algo(struct dentry *dentry,
>> +                                  const struct evm_ima_xattr_data *xatt=
r_value,
>> +                                  size_t xattr_value_len)
>> +{
>> +       int result =3D 0;
>> +       char *path =3D NULL, *pathbuf =3D NULL;
>> +       enum hash_algo xattr_hash_algo;
>> +
>> +       xattr_hash_algo =3D ima_get_hash_algo(xattr_value, xattr_value_l=
en);
>> +
>> +       if (likely(xattr_hash_algo =3D=3D ima_hash_algo ||
>> +                  crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)=
))
>> +               return result;
>> +
>> +       result =3D -EACCES;
>> +
>> +       pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
>> +       if (!pathbuf)
>> +               return result;
>> +
>> +       path =3D dentry_path(dentry, pathbuf, PATH_MAX);
>> +
>> +       integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
>> +                           "collect_data", "unavailable-hash-algorithm"=
,
>> +                           result, 0);
>=20
> "collect_data" refers to calculating the file hash,
> ima_collect_measurement(), which may be stored in the measurement list,
> used for verifying the signature and/or included in the audit record.
>=20
> validate_hash_algo() verifies the hash algorithm before allowing the
> file hash or signature to be written as security.ima.  Instead of
> "collect_data" it should be "set_data" or something similar.

I will update that in the next patchset.

>=20
> thanks,
>=20
> Mimi
>=20
>> +
>> +       kfree(pathbuf);
>> +
>> +       return result;
>=20
>=20

Thanks,
Simon=

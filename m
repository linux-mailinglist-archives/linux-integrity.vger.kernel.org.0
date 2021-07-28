Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BD3D8E52
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhG1Mx6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 08:53:58 -0400
Received: from mail-eopbgr50090.outbound.protection.outlook.com ([40.107.5.90]:36929
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234966AbhG1Mx5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 08:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGdlT/O+53pIa7KVpHlf+jaEVoGaDnoUK9xQiqqYn/pz2+Jeiy7hoskrzxXtlS7sNAXcIYI+pHJM9qcIpwJC6rJNKAgOekM4P07McdWCmURVC2xL605rEZGlhn5bJZKrzw/iH9DSZxUVLrf4HvIMDiRurluUxDTppTFHWWZJm5R63nsQD3LqdJ9p0OX7eSAwfGIEOMmI7ZGTdkL5cZBOQO4mcD+I1oG6zS0NYuBXSzOR6hETuxs3oS5/EHydt5bLzYsK7iHYqglOkbzlTBlgNC+kBoOQ6wbSbs2hpr/IXoRj+sQMOo6+YfmY1q1tyFSwEkOX7tJ/e2RBMcLLjI8dzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLT1x0lh8Okl4Yf16K8GZyYtnaoZhvuiZ+45PIpWUPo=;
 b=AcOxxlubLhgvA6dejglp5wUwIB6BS6X8Al1dOynCPWGA8mfyGF+WU3dx52TzxKCkbXCXlbjlZUNjc2IzKoskGva5P/QBl00B36XMOZba9fl3pm7iGd3ygHsUcjtIWUDyK8KYIY7Fu4q5t1bVNnxlY44wv7tkdktPOwHdbp0vQVmTu8+GJlnKWQR684IGdQ7/IVktHR7up3jrqYX2GscWAA5b8z8JPPlzotMh8sn4eKI9cVzXu+ThrkS3t5rzd9HfQIic3PEitUB4xC68uvigLUDSDMORGNHA27Zy/Ex5G2YKu3uMOoqWp4xv5jyhjZQl4Q6+ERpXY7zVnaKUelBXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLT1x0lh8Okl4Yf16K8GZyYtnaoZhvuiZ+45PIpWUPo=;
 b=ohbEE6vWykJcrbuwpyhmdN6n5t6g0G6Rvqg0Y0EhJv3LoptbUf7UaqG311hOC+syyHd4WWdG6pPKcGcPPPV7sM+2bDmmBEiqVoYa3w6SByc2fvapW9ec13PfqL2hf6xv6awNbpwCS9JHk0A2FPxCL53njTajlY1LK26SUfM3AIs=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2404.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 12:53:54 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 12:53:54 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v4 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Topic: [PATCH v4 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Index: AQHXgwUkWGVV9iy3rkKcNLQiDD+1vKtXRwuAgACvXQCAAF/mAIAAAuUA
Date:   Wed, 28 Jul 2021 12:53:54 +0000
Message-ID: <7bc627f3-a3bb-1cf4-44dc-097b241ac7ad@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
 <20210727163330.790010-3-simon.thoby@viveris.fr>
 <5a3a35b5f20fb17f7430046b0378e05f1dffa098.camel@linux.ibm.com>
 <529bc35e-642f-9f50-f3a7-0d3c07890afe@viveris.fr>
 <3a576c8f562201f441a72bb7232c4bb0faa36318.camel@linux.ibm.com>
In-Reply-To: <3a576c8f562201f441a72bb7232c4bb0faa36318.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 170a8b53-48ed-4f3c-ccfc-08d951c6c1be
x-ms-traffictypediagnostic: AM0PR09MB2404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB2404DC6A4BD199605BEE2C3C94EA9@AM0PR09MB2404.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGOgNTjUwLSB5cD7EaR/G4S4N2C2XUPgt1dACliAE+l4nGeEX0rcC36n+Z9kqegbxs7ucYUoPhd79hjX764suq6nw4tpLTLhTyPR6edljzndFw4c5IqXCiDS9H5LfnA6m+jDBN+x+yz+XUU4FKP80Iq1+m5o0OB+EbGcYkPclc6sOVp9V2LF1ioCEG88PECAcYaBdP0QPZptdlWEhjOTnTwug7Wzy5aFtqoaHlSIrqRnsYMTiEmPBUN0Kxo0CpL70PzVGC3b1tI1Z5dCVX8owUGhedKDpt9m40mVgjCJiesubH+2lbOFq5WJuqT4k8ixVsBNj0Iwoq42U3AzE6FRFZK1/14iZ0SVkgQ+K9YpHkvilOYEhVAv4SPpIMoFla5UyklKdrXmuAUeUVYDsxyFr/pWxpJTs3wAGPfB3gmej0nHDKz6Plqg9YSK/GwyE8eSWmV3XBWhsITC6GWe8oOKP1HPSANbyAadLnd1LTGm1awwsFR223E8kfTRymNb22/KOVnhbGF9d/W1lM3pVp09uNc+uj+59bCL/iGlW3+HyXK3FzGA16AaoNjvwlXUfZC9xu+/zhE2dIL1BgMgESUzs2UkmYOTkSCI0mBW+R0bQsZC5ptfG0k1Gi1GWNTHFaDIXXO130iaVz4HbV6qQzhK6t4IP80w6cVj71+DHsbE4ealn50+O0Vu8sZzmQH7VfuXGo8OOittOK4f2PIzFjsqW/+wkX3qEGuYNIiGF80hUxu9LM8GUcKu3+40eRc8d3mG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39840400004)(6506007)(36756003)(76116006)(316002)(5660300002)(53546011)(186003)(91956017)(38070700005)(2616005)(110136005)(2906002)(8936002)(8676002)(64756008)(66446008)(6512007)(71200400001)(15650500001)(122000001)(6486002)(26005)(38100700002)(86362001)(4326008)(66556008)(66946007)(478600001)(66476007)(31696002)(6636002)(83380400001)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?N9nOdZUbrs5n5NjNyaaOXK97AbB1lhaDu3NfKGQ9VJjDOqlTjck5aJJfn?=
 =?iso-8859-15?Q?vwn+Sipjaj22onz3Hhsu9gukNjlzdtCtbv7AVTpjs+Ox4GeP3tWuGK8Db?=
 =?iso-8859-15?Q?OnTuu3AuUYAfbxY+rrasSnPpaPyPKHBgJsmrK21uwPn2OvENBwknumobT?=
 =?iso-8859-15?Q?HWU4YCPmuInznf0C71tW09IWYEvf4Xp0OFj+fzckUB1Cctlesv0vaMmAp?=
 =?iso-8859-15?Q?+47Ogp4TnDNtV+dx3cnnGdgYq4/bfYn9VgqWD5OVZ4bmIm2wEaO2g/Qx2?=
 =?iso-8859-15?Q?WLAxac4segrIvWdT1si0HeKomDAXZiYXVceGJF5f+62bJSMeXWrlclStr?=
 =?iso-8859-15?Q?tZhoOAjXyTIrMd/vPIcTliKFkJgy/1DqOf43CTk9XbgkcLalSe0PSumty?=
 =?iso-8859-15?Q?C57lW5G01q9TRKXHxER+ODu8cjLClTtHQHHlRtu9wNrbAWuTVeyqv+QXF?=
 =?iso-8859-15?Q?O9K0fON9nKIaF5oekSGtmANpLf5SqwgRLow6qOkbeJ3+lYCf6FmPp+yvK?=
 =?iso-8859-15?Q?1vmCe0CM1DDMjZ/HRFj6d9YUMO2L2lQR31HuxAkpUa9KL9jvW08O/H0Gv?=
 =?iso-8859-15?Q?L3eq1HCWndFUk8cjdzcYAybzi4oRuJzfFLNovqJgWGje58HodMXWdjH13?=
 =?iso-8859-15?Q?3mN2dckdU0EBzVuluZZVjsBYkQhEQ6hg4LcBZo0+4ULz7fUAcJQtVtfNx?=
 =?iso-8859-15?Q?Q+fAPY0+n9T8Mtwe8nV/esbUIJOdoigmSX5Rl8s0YQFgohJRYj7iSefUa?=
 =?iso-8859-15?Q?GewjjQb5hsCv2qhN9Dpgez9IyY34ClHsEQxr0C+eAy1YnxPOUqp4x0yTw?=
 =?iso-8859-15?Q?TPXNkELT3yAPb0RWaCeoyQUej+m/GRekVL/khmW0WDKcMN+yIdl1t0zQk?=
 =?iso-8859-15?Q?HV5ZpvFTd9JlnRfFeCj0hBT0J9vQIBI7EPErVtOS9VDObtL3u8yp2esyE?=
 =?iso-8859-15?Q?FJF4yGq3f4Sp+kcX2IgYgSQuF/f601lP+gS0V8oyB87G1vNErpBSkCqzc?=
 =?iso-8859-15?Q?smBPrCgirLWxkALmL0tCt3CU1fq3zvrLAWFEMo/nt93583P3hs7kcKQw/?=
 =?iso-8859-15?Q?L+utw8AZQWom5SIQelr758kfTA2vnmFi4lrHq2fQw0aQVn09ddKhquz/U?=
 =?iso-8859-15?Q?SvmIhaiYUs+wSTEyoeQ5DZgIgJO1nBaLZGYHzzlQUDgJrxulLFrCo44JY?=
 =?iso-8859-15?Q?2/gTYz78+o9jLOa/LpoCq4A1PQ/rZ8gf8KKpf0ofbhnS9PVAOid34JQAi?=
 =?iso-8859-15?Q?+MvcZSE9cwzn4y/g3Vt/P0LNDiKIIX8wyPAeWk11Uiyu/gRqou7/e3Fgl?=
 =?iso-8859-15?Q?d+zRh65XGGB6mVd4+0aPiSPm3sS8ucwKpiIetxlsXteHTAhAnUGNA9zZI?=
 =?iso-8859-15?Q?M8dmJHAes0X9ReYgKG6FxffEX2rTzhAnrM490YzejMjjHTGm2JEz6uQ?=
 =?iso-8859-15?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <31CB3B102E96FA4395894ED9F951F6F9@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170a8b53-48ed-4f3c-ccfc-08d951c6c1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 12:53:54.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARipWXUO2u+RA9iloDKmcADLOy3AQte3H3GjBI0+XsvYFX+SuSXJR9ruXutH+2seggZDD2EEHup7bqsMQJGg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2404
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 7/28/21 2:43 PM, Mimi Zohar wrote:
> Hi Simon,
>=20
> On Wed, 2021-07-28 at 07:00 +0000, THOBY Simon wrote:=20
>>>> +
>>>> +	if (likely(dentry_hash =3D=3D ima_hash_algo
>>>> +	    || crypto_has_alg(hash_algo_name[dentry_hash], 0, 0)))
>>>> +		return 0;
>>>> +
>>>> +	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
>>>> +	/* no memory available ? no file path for you */
>>>
>>> The comment here is unnecessary.  Avoid or limit comments inside a
>>> function.  Refer to the section "8) Commenting" in
>>> Documentation/process/coding-style.rst
>>>
>>>> +	if (pathbuf)
>>>> +		path =3D dentry_path(dentry, pathbuf, PATH_MAX);
>>>> +
>>>> +	/* disallow xattr writes with algorithms not built in the kernel */
>>>> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
>>>> +		path, "collect_data", "unavailable-hash-algorithm", res, 0);
>>>
>>> This will emit an audit message without the filename when !path.  Is
>>> this what you intended?
>>>
>>
>> This is what I was clumsily trying to explain in the previous comment: i=
f we cannot
>> allocate memory for a file path, I thought it best to log the audit mess=
age without
>> the path than fail with a -ENOMEM (auditing will also try to allocate a =
memory buffer
>> too, but a bit smaller, and memory could have been reclaimed between the=
 two calls,
>> so the auditing operation may succeed).
>>
>> Of course I could also return -ENOMEM, and it would happily propagate ba=
ck to the user.
>>
>> What do you think ?
>=20
> Memory pressure isn't the reason for preventing the xattr write.  It's
> the reason for not being able to audit the setxattr failure.
>=20

I completely agree with you, but I'm not quite sure I get the action you wa=
nt to take
from there.
Does this mean you prefer the mechanism already implemented in this patch (=
not printing
the file path and trying to audit the setxattr failure anyway)?

> thanks,
>=20
> Mimi
>=20

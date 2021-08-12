Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C613EA049
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhHLIGy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 04:06:54 -0400
Received: from mail-eopbgr50121.outbound.protection.outlook.com ([40.107.5.121]:29035
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234788AbhHLIGx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 04:06:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2gvbSsGYZQDOJo7iFkcYjGSS1LcsT72QqjH5uZ8Fojv4DHmjvnqGptlCzR6W3+t9ls1I/J57B5MCJwVGv0Cs6dfS1SbPrhvnSzivi2MysVVNUFWYGMcWr+qlf6VpsmIfq240Lp2BMqCHyjC96UFrEPm+o3Zam0c2/nTMUzQh7FxtL0Un/SAICMb3Uq7f5PILTF/KzcAtldPgm0+CcWAT1sxjQbAee18GTn0WGbK9eX3qZJjL39pzx+fQMEFNE+wuofEvI5J1qMuoOre6WNIDV7J0tvn/EivPDheFCVrHdV1gDHjIPI7Wn7Sz2w+jVugfqs7kq9mw/zAoGVm0ONqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYEBOlIvbWpOvcpkEgEyyAPwBI5pJ9w1/vyNQNfoOK0=;
 b=DtWRhINw2T2HDwJ/C3orTYt6uDe2vM05UrMUQt/O6XDP9xS7HC8VuJGzal9VTdgCRbhjFUnvSWAuBJz9VD8xrd2IPWyRT2V2sZmZjUccJYOkUn8pR9q8RxuKCZwwGwfrvBK8P5lY3f2xhi3QtaYk+IJ9MsJclfQ3mSbZ//yhxUqJ075uBuDwr4BVCkD2Xqth+aAA+GM6b/4r+u7DNz4xL8Kmd6TgjYAQY2VHHMXAGt5X1LBSSH3SJqBlVTNjmQkSwyJSkbSpdbsOAA7nD8sx9BekMX9SPWdPFXcGE4RcAT9fqQYrEBEW89gY99pNZ8FBBsZKxZgATPjaFY9UFGzX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYEBOlIvbWpOvcpkEgEyyAPwBI5pJ9w1/vyNQNfoOK0=;
 b=Xd3toheeRtNN7T4+6giMZ8Nfd0BGPHw98Xf5TURsn6pPSyOp8+t/ZkawDCvCkYPM90rXKcmFzpWRGwWSJHoL+4shgymvR5vN2XIIjhtyZS+Zp0+GpPQ7+jF78XSpWLZuDr2pArh+7DOwS1+peTtSGQPWhSVnoFaSJ79b1bCFnOQ=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM4PR0902MB1668.eurprd09.prod.outlook.com
 (2603:10a6:200:91::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 08:06:26 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 08:06:26 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXjqW6HKtkRWvTZ0yNvT6BOPuNR6tufhgAgAEGgIA=
Date:   Thu, 12 Aug 2021 08:06:26 +0000
Message-ID: <023a0ec1-aed7-9862-e0c9-a825d46ade0f@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
 <20210811114037.201887-5-simon.thoby@viveris.fr>
 <84b3a572eb5fc1ec81291656c9f9af00568bff9f.camel@linux.ibm.com>
In-Reply-To: <84b3a572eb5fc1ec81291656c9f9af00568bff9f.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d1ba1fd-3ab1-4e3b-ac34-08d95d681543
x-ms-traffictypediagnostic: AM4PR0902MB1668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR0902MB16688D1B5F605DEC912B944694F99@AM4PR0902MB1668.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IY8w7oe0YQ7NiSVDeYIMdVvt2/dU5ZyJfbkFw3TndBXkauYk3RQyIM1zssZmec5F/d0xB1hjWQf9WpvLJvDw1aVR6ZYyeDzMALQ1I2LH9MNsfNcCwBWKgEN0TXQasCIOclzJY8SM4V8l0KKRHRMMSDE9FazcuxjncbC3xmkZgNIPMTSG6VN6YddzE40Tf/t83dI8L+gN6C+F5R4W9JZL9DcEHqc8cuE4ds5wXqgBrbrqECKypC7ieL4+uKHBvna78jbWy0v0f48gkamZRanEPsj5h2mzYv+QFxyKjqljPFSeU/MkubpR54OhgoQcJYr2UJ7ssT2Sqb++vC/8YdW2gxpgzE7Ot8ORCOebsqREkNOWNb7lTkO2nlCatotsScBd3CL41F2mTWFoVNei4TdElWwpY2cWJ9jKQhza9225X6tz/sB+BRT0gCthVQEF4bweVwqSmIXxOWDdEHalLLwp0Kv7FB6dM+FdD9yxCZTf93FTRAwHqXjs3X4y4WaXkxjamluK0ZJCGhi5Yt++eJYYLlcIaC4fuCJiK/uVHhRkwz56D+hn53bOaGvMii0BYwCLOHy3zayvL1d4NdUQhczLVnq6BomXzDcxRdGsUCC+YZkqHRWV7Jmv2nvdEDDICad52uHs5RWSbK5mXlFhxbnIOGk0pgrDVKiCezbDXp9wMpRDRagMeXu/JDblr314P9l8rZsksmMuFwZXQ3Ln9sC937fw1ORZjoqwIpjU00pNOuGlFQOEwn9EUhxCs21mJpoy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39830400003)(396003)(136003)(376002)(366004)(5660300002)(478600001)(186003)(26005)(71200400001)(6512007)(2616005)(6506007)(53546011)(8676002)(6636002)(86362001)(31686004)(6486002)(110136005)(122000001)(66946007)(38070700005)(31696002)(36756003)(38100700002)(316002)(91956017)(4326008)(66446008)(64756008)(83380400001)(66556008)(66476007)(8936002)(76116006)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?NasgyMjB9vfiMNFgGsYtU6KBOdk1fVkm4x711kv+KeginHBISHGIPZj3s?=
 =?iso-8859-15?Q?AIheA6U+X6ZGU92z/Ob1/MkorbyEyeuhgauVk/oX/hEB/Co4Z1D6XGH41?=
 =?iso-8859-15?Q?yUhM3qonV8e7UHAO44uu9d9hKBRlW0neVcAEzRL4fS+hBjJButtbd24sj?=
 =?iso-8859-15?Q?x/7wj3JtYqxTdqF6E4Yry9L/PdkrHZmY1upKGiqejgzS8Z/IQDri6gZyX?=
 =?iso-8859-15?Q?HhtpAqMtbXksL/dNT3ntq6c49A1nd7lpGJdy9I+gmWmnTp2TbVW66vpiq?=
 =?iso-8859-15?Q?SbgaQRCXqpSnK6VdMaj/wTgnDZxzDZUqq+GtlsBetIcHs5uopLF2dsp+p?=
 =?iso-8859-15?Q?u/ymvvp+77SfcmnP8EYnD8EmKxuWIZacbiPdtGf0V1z7GNFmfFglp5J7I?=
 =?iso-8859-15?Q?SOu/DHCPfTlPHxXtebJTOJMlj3citzUAFQXsq70zelG7Kb6PWRwZ9rEap?=
 =?iso-8859-15?Q?+q2yqQx8K+pxBDdJHdVWv+09vtNxN5kxIiIrTFEDISijin1uKHfCJNMC4?=
 =?iso-8859-15?Q?nizB64QTy9dndK4TJJ7C/uYBkZVfwcRvM8LNqKTtQOE5TAqDMXIxhYQK0?=
 =?iso-8859-15?Q?SSC5isSOXps5/gsHaWPygTqtRNkjwJFc6Cxx3ofA6o8WHR8eljCIK5vTF?=
 =?iso-8859-15?Q?RWCjigjBMd4LvODQSFBO31vUxIrQVKIs4PkTRE56D+O+r2JYVorvsKwFe?=
 =?iso-8859-15?Q?Rzwnfqf7H6UiToBddMpLiFbvZhl7KckGOB3Rr9kMQK/TIfq1vpJ3YfjYa?=
 =?iso-8859-15?Q?GUtQzLyWmrSgR1CO1EJPdmGvfjRWGLQvyBim4sJaDqTSLtyvpEUsEh8s0?=
 =?iso-8859-15?Q?b3rcpH+sWTkmsuiAgs1Ta6xs1ejNU+uNqDyifk+ZDE1EcC9lZafbB2JoP?=
 =?iso-8859-15?Q?4wlfPXEnK0WQPPrRGhA7glLOGzIqRg08a53+uLjmPdmqvGfB3DO1Fz121?=
 =?iso-8859-15?Q?hoUTMphGGfZ+sXWioMnOV2uHl5QCTt/FD/9nKorqU1R4bh6m0Awxl3iR3?=
 =?iso-8859-15?Q?VzI0WpoJtz+2+H7ADgAjzfMPcqTf61MTgPecK9PtefsYsev43I+4EZ8wP?=
 =?iso-8859-15?Q?GnksqWmMlIwIRXVIFFL+upJSDLtyTD1mMZ/pE/F7g6y0cIXsR6y1+6w/e?=
 =?iso-8859-15?Q?3QkkjKAhfrsNkG0SjuphQt8bBj3Tp5sqxPxjVgbFJBt0kcNhcwNMv4Nf9?=
 =?iso-8859-15?Q?aUALrvc6/3lI13i2PvsWMdTXbD9c9vAu0bfFr6Gk8Z58fZaOv+V1qotUl?=
 =?iso-8859-15?Q?iqkmjlrNqZqv84vJhGpG8XFS7MlPJ6MuezFGbkPelaaKInuIjdGoq6FBh?=
 =?iso-8859-15?Q?gJpdt/E1A0uAUZz8fLxH9IJAJyy2RykuRbG/dr1xfk+UTBFI424lkDarC?=
 =?iso-8859-15?Q?RkgD/G7d38+H4L7FU/ekb3+ncGN4sjlUu?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <7C865876263CEB41B55A543ACA0CACB1@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1ba1fd-3ab1-4e3b-ac34-08d95d681543
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 08:06:26.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zY+bxQ9n0bNpglsrWrJPT1uZRHVJp0vtf289e6uXX6ZYDrAmm6XXWuP1CH16WxYjIBJUZ1VFlNUBczsWaLbkbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1668
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,


On 8/11/21 6:26 PM, Mimi Zohar wrote:
> Hi Simon,
>=20
> On Wed, 2021-08-11 at 11:40 +0000, THOBY Simon wrote:
>> +static unsigned int ima_parse_appraise_algos(char *arg)
>> +{
>> +	unsigned int res =3D 0;
>> +	int idx;
>> +	char *token;
>> +
>> +	while ((token =3D strsep(&arg, ",")) !=3D NULL) {
>> +		idx =3D match_string(hash_algo_name, HASH_ALGO__LAST, token);
>> +
>> +		if (idx < 0) {
>> +			pr_err("unknown hash algorithm \"%s\"",
>> +			       token);
>> +			return 0;
>=20
> Previous versions of this patch ignored unknown algorithms.  If not all
> of the algorithms are defined in an older kernel, should loading the
> policy fail?   As new IMA policy features are defined, older kernels
> prevent loading newer policies with unknown features.   I hesitated to
> equate the two scenarios.

Yes, that choice isn't easy. I changed the behavior in response to Lakshmi'=
s
remark on v6. It's true that failing to load the policy on an old kernel be=
cause
of an unknown algorithm is not very desirable, but loading a partial policy=
 may
be worse.

As an exampe, if we load the policy rule
	appraise func=3DBPRM_CHECK fowner=3D0 appraise_algos=3Dsha256,<new_algo>
in a version of the kernel that doesn't know about <new_algo>, a permissive=
 interpretation
would yield
	appraise func=3DBPRM_CHECK fowner=3D0 appraise_algos=3Dsha256.
Now if the the system files were already hashes with <new_algo>, then the u=
ser is in
for a world of pain as the system can't boot (trying to appraise every exec=
utable root
owns - that is, pretty much all of them - will fail).
Admittedly, if the kernel doesn't know about <new_algo>, there is little ch=
ances the
filesystem was protected with that algorithm, unless the user did migrate t=
o <new_algo>
at some point and is now trying to rollback to an older kernel for some rea=
son.
So I think that remains a very niche issue.


On the other hand, rejecting the policy protects against typos and human er=
rors
(while trying this patch, I once wrote 'appraise [...] appraise_hashes=3Dsh=
a256,sha384;sha512'
which was accepted and silently updated to 'appraise [...] appraise_hashes=
=3Dsha256',
and I didn't understood my error until trying to launch a command and being=
 greeted with the
infamous "Permission denied". Had I been monitoring the kernel log, I would=
 have seen the error
right away, but as the policy was accepted I assumed it did what I expected=
 and didn't thought
any more of it until seeing failures).
It is also more consistent, as I think it is a desirable feature to know wh=
en writing a policy
to the kernel that reading it back will return the exact same policy, modul=
o the order of the
fields in the policy rules. Ignoring unknown algorithms breaks that behavio=
r.


Additionally, I don't think digest algorithms are added very frequently to =
the
kernel (or else the list would be much longer), which mitigate the potentia=
l impact
of either solution.


After some thought, I am personally inclined to prefer strict checking, as =
I think failing fast
and early can save great ordeals later. Of course it's not always easy in t=
he case of the kernel,
where failure is not an option except in some rare catastrophic situations.=
 But as rejecting
invalid algorithms is coherent with the IMA behavior with regard to new fea=
tures, and rejecting
a policy cannot break a system (although it definitely reduces the trust yo=
u can have in the
integrity of the system), I think that's an acceptable behavior.

>=20
>> +		}
>> +
>> +		/* Add the hash algorithm to the 'allowed' bitfield */
>> +		res |=3D (1U << idx);
>=20
> This assumes that all the hash algorithms are enabled in the kernel,
> but nothing checks that they are.  In validate_hash_algo(), either the
> allowed_hashes is checked or the hash algorithm must be configured.  Do
> we really want a total separation like this?

I kind of assumed that if the user allowlist some algorithms with 'appraise=
_algos', he is basically
saying "I know what I'm doing, trust these values", and thus these values t=
ake precedence on
the algorithms compiled in the kernel.

In addition, validate_hash_algo() is only ever used for setxattr, not for a=
ppraisal
(which is the subject of this specific patch). If a user try to run a file =
appraised
with an algorithm not present in the kernel, ima_collect_measurement() woul=
d fail
before we even checked that the algorithm is in the allowlist (process_meas=
urement()->
ima_collect_measurement()->ima_calc_file_hash()->ima_calc_file_ahash()->ima=
_alloc_atfm(<algo>)
would fail and log an error message like "Can not allocate <algo> (reason: =
<result>)").
So that check is already done "for free" on appraisal.

However your comment does applies to the next patch ("IMA: introduce a new =
policy
option func=3DSETXATTR_CHECK"), and we probably could restrict the algorith=
ms referenced in
ima_setxattr_allowed_hash_algorithms to ones the current kernel can use.=20
The easiest way to enforce this would probably be to check that when parsin=
g 'appraise_algos'
in ima_parse_appraise_algos(), we only add algorithms that are available, i=
gnoring - or
rejecting, according to the outcome of the discussion above - the other alg=
orithms. That way,
we do not have to pay the price of allocating a hash object every time vali=
date_hash_algo() is
called.

Would it be ok if I did that?

>=20
> thanks,
>=20
> Mimi
>=20
>> +	}
>> +
>> +	return res;
>> +}
>> +
>=20

Thanks,
Simon=

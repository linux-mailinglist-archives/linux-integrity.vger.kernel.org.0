Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6430F3E53BF
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 08:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhHJGp2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 02:45:28 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com ([40.107.8.94]:6017
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236783AbhHJGpY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 02:45:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOsoY4IvWiGm4LMre8d5kcajJOCF+ZLWgIxN0spq/PMwpaQl+XCTITFeas37QvQq2MjsMR2shNKMT3vaauPfPZL0SdjKdJCOi4OdvTOPY/oJvvBcqiz/tohWqd8sCcrQyrSAllBmS8KnCJo2dziSPFcV256GjM4BKYITqHOcbAFl5uP921awE/GhaTpaz8UHNRbYWq3yqmMxtv0XTz31ij1hx8uDhvVJnSC3rT2UgsL00qVdOK0+LqxJTRFLC1Sduxd1HnE7r0rtvpVv5DigqVaHxC+leoGoch0fNDrPb2/mU2rRY6J9bf+6WDEl4ml2YCl5/7ANzr6GjPqaKqYu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KorEzAQQNpzjxuKglFEYylcTHIUlZnczVk+9xrKZ/eI=;
 b=FikMLKPO64fqLfQFxsUVdK3YejJSVQVgX+VeX+2y66XXQ3yQ/pHpRkNc9sFTFWoCs3via756+3g7ubmKkOp7jRiJNrGQqlYNfKAibkN3mQLoQDVKi6wAbwUgkT31A5oFQiIzQZOeCv4qWSEh93zU3HuIWhskYrzbxZcByadRTsU/KeO4xaNySsm0oVE2XMsp8IqssL7ZdI4KI/umb9SifmdRT7oG3QxODmz8NX4gCuuQN5z8fiGwnldJuBaJ/kXZEz9O1HaQc87VP7j9BSCrmtFZnbqfCpbBxZ++4ky+ocAh8ZnLD996Qjcm1aK/fAfCDECpIi2Wcm7HpuMtj/OrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KorEzAQQNpzjxuKglFEYylcTHIUlZnczVk+9xrKZ/eI=;
 b=sEtk0Rgd4JezOx9WBdR8u5fBrIKK/qPW2vZYlHG//SRB0n3t+bvV6xJzr63vgWdfUPaRloedwN6UI8VLTe71nZB/+3poiPpsXYdtsALJbeFAM8TO9fq/LPb1cjtBfcDc2FAR5G/Imu1AsvU9MU/lWL2JTHE0uYxxQAcm7k0Ywpg=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4242.eurprd09.prod.outlook.com
 (2603:10a6:208:18c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 06:45:00 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 06:45:00 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Subject: Re: [PATCH v6 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
Thread-Topic: [PATCH v6 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
Thread-Index: AQHXiRHwT9XyeFXmY0qBhemJf3HNsKtreeuAgADaawA=
Date:   Tue, 10 Aug 2021 06:45:00 +0000
Message-ID: <b746a7c4-2fa1-4182-89ed-e5fec4b009ea@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
 <20210804092010.350372-4-simon.thoby@viveris.fr>
 <c1dadaa101b041fc7dcde1a5b3b52593a949e992.camel@linux.ibm.com>
In-Reply-To: <c1dadaa101b041fc7dcde1a5b3b52593a949e992.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58779d16-7a27-435d-1111-08d95bca6067
x-ms-traffictypediagnostic: AM0PR09MB4242:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4242F68272B3135EA41F9D0594F79@AM0PR09MB4242.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sPih7utrYdCR+M0TRwYYQAoZrXPmCMznTA5jnL98UJ+BNYLMwgbTh42vkuW+PMpPCOio7yXb8wpQyLVCpH9tlGqXZzQF6oYPIn0Gr3adgaBdMJLWD7rhs0clhK6BslPexerteraoRiMBoCdrQ5Oxzv0d6o4XeYA0HloQ64/e7n3INNyTKyzOQIuvgKZySRmViWbfRno7hIxGFQIbJIS2K/WrshJhW+5DgNG1ulGBIPdbo88ETwQ60rinOBqGOEgKbxD8L4AsgCQeokYzyjteaW8uP84g0xaNLTaj1s/HKLHFY/fAyGL3eRWiBl9oTaojaWEcMc5tqEHqijZK3juXWZhu9CezfsdtZmgrHVPiUCl/utjyuhFNIsDxTQ7KL3kKMkkgwphHdvCCnmGFJNUr7qLceXrK6kDAlUjOkRqCJlRPMJ0PtT5RwzMt8MhpwPP9l4GHbJBuPs83q6aipb8SJ0f7iwKcBFSPouBYnwYr3GeeiolxBW8q1qZcfMVaQwP7u3qZdGp/Ndv0n9Q9PcVPhYNkRFbRLarB0/l4MrocVg8S311WMT5I75tFmH/BD5SFKt3hfF3RPPd4gZfOTZHmobfc5YC/ppJdQrl2w1FgppoDdC6oubRg320OFtebi22mLxRuN0YVqjKLkcrv3woIk5gRSuDPzacFR0f7bYQn1R1APnwhjypOqrrs/LdPqyIMGWazZUL6SdiX3rTDwPQbnNTE9t3btX+ma69O+89lXsgqVeF/jf/4FQ1lE79gZt2F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(66556008)(66476007)(64756008)(66446008)(71200400001)(6486002)(110136005)(2906002)(6636002)(86362001)(8936002)(66946007)(31686004)(6512007)(76116006)(91956017)(8676002)(31696002)(36756003)(38070700005)(26005)(38100700002)(6506007)(83380400001)(2616005)(508600001)(122000001)(53546011)(186003)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?8IFSi08yTP9q1vtMey5jbCTtkUE2FXLl2Zgh8d9BOjLNsABYrtZ1naIRg?=
 =?iso-8859-15?Q?mC6evKqULwvOHdbeUQAvZaBWgaCmu1S8XhmZVMABnapnrJuwRd6PCrPgk?=
 =?iso-8859-15?Q?GT6FbRhzwjtq2BSGQKG2AqKTMUsLsAI+zSosXFnbQmFU/AdVKqZah5Kjs?=
 =?iso-8859-15?Q?3E+5Jkc8h641Tq7Lm2y5mZtOsx3Y96bDXDcARFH3bCphq3XFd+58slclJ?=
 =?iso-8859-15?Q?lAokPd3OepdKC+LvHONKV/mz/J3etkjxsEkqyI2V7JMVDhC9Ce3906Hh5?=
 =?iso-8859-15?Q?xfyN6qvYeXF2ZcaSitj04JGpG/lN4F9+YpsJzadxwuWUluSS5OTGAtl8c?=
 =?iso-8859-15?Q?h1PflZ/dnfwgNEZMynf8paB+A6rXBAwSp67cCyEa8WqbAKoTWn7zX2WlR?=
 =?iso-8859-15?Q?hgk4xC4mIQ/u8S0jnpchDRmC2fQOfN2OdsjSiDfuF3Ue/ldz8co2YUnNj?=
 =?iso-8859-15?Q?mvzcecVdOO5n1WRlE6JIOJIyTuWovkYSPch34VHKqh0eWtNchZAhXtLK4?=
 =?iso-8859-15?Q?kBdTOS8RcJ1hm3KU6Faruasc0wYyd/omU88NDnvWAyeJr7cy1MAKX8jAe?=
 =?iso-8859-15?Q?6vXD2FaKQJrKdrCVup4nXgFARuf1VIxM3WxsZtntlGuLlQHR1fu4KmbLy?=
 =?iso-8859-15?Q?x0FK254X/W1iA/apwDZIeFllQJjID9G3hP9AHMv2Trb8fULygM+12Seip?=
 =?iso-8859-15?Q?Bb9co0V8Xt8KR0RRjR+GGDrYZOwSj2qxswi6AauL4o6NQSUpPD3xHK7TH?=
 =?iso-8859-15?Q?hE9WuP7a3wSEXZH6HWFJmwjnDZ+7jaeeBdNm+hAmRovdhScQPrnEt+KI/?=
 =?iso-8859-15?Q?slxStM4Io6kLPsf6DOlPmWip3X5TxvCzvWTZDpDBx0K/tj+vaasq6jsjU?=
 =?iso-8859-15?Q?O59qdpcMcXp8f9wphhP8s/vfuvRf5V959lJM2CAHL3f01b15s98I5tF9J?=
 =?iso-8859-15?Q?gOQ4T3BkhR/r+tzD7q+Y7jINUUlECRQnk9JDnvNAwzanxRX/9Oy86YZvT?=
 =?iso-8859-15?Q?aUS/4+L10qcLhjHGlHuvUAMVelUfAf6/30AtCGCUkhpiI90m2odMy0Ubp?=
 =?iso-8859-15?Q?E4zs7Giz6o9hoN3rqYc+J+C4gChNiZBP0U5o5zxY3vKjDbp/e19eSSJFi?=
 =?iso-8859-15?Q?Dij89HxHIUIKpPbjEcsjMURubYU9BPrEMV107EAtqFGrbTODuGCtr91T3?=
 =?iso-8859-15?Q?YMhT7/pCr4ox4Gakn9XNQUqFljA/0TT+kRSaq4oY+Tg3b0Tzi+gtVi34h?=
 =?iso-8859-15?Q?DIotS4tkWPyhBJZQTzDVPxl+62vwvNQZq48/McH0esGgDCuzd6C/IauTp?=
 =?iso-8859-15?Q?h+pMEV0IjPzupB2lAOZpgTWx039ADDJS3QX2BEGCSnbR/DilHhhllp+Pm?=
 =?iso-8859-15?Q?om6bhS8brcfIi/NVyw7DzllepB5pketQc?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <1069F08C44F25A4694C6F7A52548A73D@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58779d16-7a27-435d-1111-08d95bca6067
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 06:45:00.7275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yth59ABpp3qQpsk4LsvHlbpiHFgiVtWkhADdFs0cxOqiSWClmKhfeyNI9GfOeRutd6IqNrFhz0cpqZhWi0/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4242
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 8/9/21 7:43 PM, Mimi Zohar wrote:
> On Wed, 2021-08-04 at 09:20 +0000, THOBY Simon wrote:
>> The kernel accepts any hash algorithm as a value for the security.ima
>> xattr. Users may wish to restrict the accepted algorithms to only
>> support strong cryptographic ones.
>>
>> Provide the plumbing to restrict the permitted set of hash algorithms
>> used for verifying file hashes and digest algorithms stored in
>> security.ima xattr.
>=20
> simplify by saying "file hashes and signatures stored ..."

Will fix in the next iteration.

>=20
>>
>> This do not apply only to IMA in hash mode, it also works with digital
>> signatures, where the hash from which the signature is derived (by
>> signing it with the trusted private key) must obey the same
>> restrictions.
>=20
> The patch is limited to appraisal.  Is the above paragraph needed?=20

Yes, what I was (badly) trying to say is that the appraisal check work both=
 when
the security.ima xattr contains digital signatures and when it contains has=
hes, as
digital signatures can also be generated with different algorithms.
Except, as you pointed out, by talking about "hash mode" here, I introduced=
 a confusion
where the reader can believe I'm talking of the "hash" IMA policy action. I=
 will try
to clarify that.

>=20
>>
>> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> This patch restricts the "hash algorithms".  Looking this over again
> after some time, does truncating variable names here, and in the other
> patches, to just "_hash|_hashes" make sense?  Perhaps the emphasis
> should not be on "hash", but on "algo".

I will update that (and patch 4/5 consequently).=20

>=20
>> @@ -684,8 +695,11 @@ int ima_match_policy(struct user_namespace *mnt_use=
rns, struct inode *inode,
>>  			action &=3D ~IMA_HASH;
>>  			if (ima_fail_unverifiable_sigs)
>>  				action |=3D IMA_FAIL_UNVERIFIABLE_SIGS;
>> -		}
>> =20
>> +			if (allowed_hashes &&
>> +			    entry->flags & IMA_VALIDATE_HASH)
>> +				*allowed_hashes =3D entry->allowed_hashes;
>> +		}
>> =20
>>  		if (entry->action & IMA_DO_MASK)
>>  			actmask &=3D ~(entry->action | entry->action << 1);
>=20
>=20
> "allowed_hashes" sounds like a set of digests.  Instead of
> "allowed_hashes" and "IMA_VALIDATE_HASH", should it be "allowed_algo"
> and "IMA_ALLOWED_ALGO"?
>=20
> thanks,
>=20
> Mimi
>=20

Thanks,
Simon=

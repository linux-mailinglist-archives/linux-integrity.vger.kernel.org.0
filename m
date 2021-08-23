Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAA3F4A35
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhHWMDE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 08:03:04 -0400
Received: from mail-db8eur05on2100.outbound.protection.outlook.com ([40.107.20.100]:26469
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233895AbhHWMDD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbCwUiTVko7m8L+geGfPTm0iexc77GzjxklFt6xPvU5q4V4pY3oev3247+KacHJFPrZsxgHUsUGekxvjc1CY7d79REIA8h0A0Bbcd4Dve7WSsgZ49cIUCA3zrRx6NIE5FyW721bwiLJe1R5Bpp0qPb8DjuR58B9xbVwuGQvjTFjP4EoFps/ujTGcTfCKPDBa3DvydA8QwhkpjkvU2XwjdGyI435DvTkEW6x2vhA6DkLr6rZ4+qspzKkZv+YG4mJmLx92TXxpy1H+wKAHObT7rUPJlRCzQKdTAHmZ2UiK6C41W0LNNl/kcb3YiooTIQQ7xznia6b2H+jO5lrV7aTTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wNSGOJA/PLGOFg1TX32shUien9mug/MGSTEnRTpODw=;
 b=NB36pXvuvpSndduieDgy5r8+P9fmiqOQYNiKp22Zqk+Wh+4xgDFEY+HAOwP16ecTdHmLx1bg0s+KPa55h/C1BtWYlnTjohZ+p4CFh3ZE9SW5KY38NqvwZ2GLuAwzG+VyiElAXoVT0Zf5bGqn8ysnIARtIy0P1VNTwUZg/HaGEsP2tdoyusNhAr5WSpdh5J+ZbtqlMMPHA8jdnirUKlvRRsA5nuUFvu0ANFVm4paQ+2A7CGhdmqm8q0sWWk1a85dzVFoCtkdHl/5qV2MdYUBZcCKFFhHlvpdDNsatp46mwrhzZdN9/+FwcAaHl9mY7YPMK9mMTskEO5sPyd+opuQsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wNSGOJA/PLGOFg1TX32shUien9mug/MGSTEnRTpODw=;
 b=ng5z87TF4a9xoLqAQog86iz5mT1s9o/rnL/9YPD5JCXvT28sUhEuR1Bl94GIsORlp0FQbIfLm7UVLtpHRdAIww4SD1DsyTfzs9jVEYP3g0cBbV5pYeuw0OcXAVrHXscI24fbhPEZlBFLJi0JBHgohFpU43+6N/e8NUFIbuCAY0o=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4737.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 12:02:13 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 12:02:13 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>, liqiong <liqiong@nfschina.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
Thread-Topic: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
Thread-Index: AQHXlPnZCsK5CNi7NkWxUIAyoKg2DKt8LpyAgAA0rYCAAChigIAD4XiAgABUhACAAAJBAIAAPl8AgAABMIA=
Date:   Mon, 23 Aug 2021 12:02:13 +0000
Message-ID: <a4302c76-5865-a8f5-e754-c5dd04030533@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
 <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
 <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
 <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
 <96037695de6125c701889c168550def278adfd4b.camel@linux.ibm.com>
 <f9798484-7090-0ddf-50a6-7c7c5bf0606c@nfschina.com>
 <fee498ec-087c-b52d-102c-d29d98f9b794@nfschina.com>
 <cf715a40-b255-c688-578c-7f8bcd004ee3@viveris.fr>
 <c02ff60205fdb343cb5a2ff0e4384fc7b47635a3.camel@linux.ibm.com>
In-Reply-To: <c02ff60205fdb343cb5a2ff0e4384fc7b47635a3.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91d7a4b1-4e37-4b69-3e4c-08d9662dd83e
x-ms-traffictypediagnostic: AM9PR09MB4737:
x-microsoft-antispam-prvs: <AM9PR09MB47377C9DC38B22F85F1E0E6C94C49@AM9PR09MB4737.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGATLNOGqa2RhqjSS9Sg2cREahW5RgFk76OIb7tRZMaccuDWjz4Sgv753GHaivYWNB0NgzVVfWCkwoSvULWnrzXc0l4SCAZ+kYHyqUdoXJORKrATFmEfFTJflbpl2o4ikOOEAKrfZgrBpZvMw0C+udBaJ8I+L9Gda70NFSBGNdB68iPW1jdTX5OM1qLAY+9iTwNF1Lz0qUf6ie/EKJMi0JiluEIH41Eqe2UBdn0dCF5XxftVw9B5VEXhtEr9Hi3/7sqUQ0+VrEAoRIA5HL+8088uJaF4zzNEqkVdOXKcqRdpRBlZalppvPTuDNqsmhKuxF3IOexdPKabNoFnuhg1XMorLFOsXXahPMe/mof3+AaCvC8Jiiybic263zr9eiRAqjFuM/Ut1JQLIZ4l6Cgd3pObueP5Kwgq/7rJSlDgy1b4GFrmLCdxfYXKhMgxu+XKBf1mv0ou1TArpLh1b9d45mDv1hwUgm5yI+ikp/1220NNwV9vBDnw09Evce1msBKzkYXfNrotYJ1gcA4FGcIvw6atxCT5ylkhorOGWpFwujqKpRzgU1zgPZDWFcfWWx771TtUPd5eHfZB+nwfwuslZl45db2QD67yxSZbJKDU9z0kLLgNRgdg1i/2Sg4RRaFd7GSm3R9wrM1gQuP8vP60jKpU4M65q6ES6bA/NV+/Tf5kpXzd5BVsmMs8WqNNf/VKL/ZVXK6RcQRGerJ5e9UbSS/ZWPmo+y2b+wNIAesoVXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39840400004)(136003)(396003)(83380400001)(6486002)(36756003)(38070700005)(26005)(6506007)(2616005)(6512007)(31686004)(71200400001)(186003)(2906002)(8676002)(91956017)(38100700002)(316002)(31696002)(122000001)(54906003)(110136005)(66556008)(4326008)(66446008)(76116006)(64756008)(66476007)(66946007)(5660300002)(86362001)(8936002)(53546011)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?09MMe/Xnw4v2WklIaTYkj2XhYbZZh1AYfxDx+EHKw0X3Ok7QsfM/VPTQT?=
 =?iso-8859-15?Q?WbwoS350j4HrDHycI42kEXTq2CEG0eoyS6L94SP3DfbXolPHDxwnDLPfg?=
 =?iso-8859-15?Q?hEO7If41J/pDmO2y8ynmqPggVSwagOY/V8VAyXLhZq5z2rRHkmj8GsOfW?=
 =?iso-8859-15?Q?+OgQirjnYf0+r4gwAEC83ejZoPPTSfhOQYqtdJ2w2EL/sbKzlfz9GnHzH?=
 =?iso-8859-15?Q?OSgJ+JfYabRY27C2FuaLiqbAHP1MllmrG7cTZEp3EiGb8RGe/IcrhYG0Y?=
 =?iso-8859-15?Q?ypVcOo5zImuko+DVed9plrKKS+nkErc3ivt7xHdzQl7R1X+DzliqAm8Wr?=
 =?iso-8859-15?Q?TlvbbreEXOvQXQR/HMxA2ctZwWlDSoDPOb1KIq9h/nRRIAL00A767jMJV?=
 =?iso-8859-15?Q?vA0XSYr2UpY0rjV8jTBF4/Ddn9D7257lSVP3x7fZTTbe2knifxLgX7+iu?=
 =?iso-8859-15?Q?kLF98wGcrKOySsB51qwWI4nS/2U3LLcy8BomaiBbhz1K/NtnI0MassqoQ?=
 =?iso-8859-15?Q?dBvmXNR9dDw2erY8qCiG22p5II5nqvYLm0IuJMt4QmGRBthD7Fr/ea5Bb?=
 =?iso-8859-15?Q?O5zHwbNQWENGCxdTSXLH/zG7V5MNj4OERhUXVXGNB7oEtUJR8xndZy2ps?=
 =?iso-8859-15?Q?RoCf0wX/MxP1oygaFyxGpIPXuBVl650zkgfCwWXxHXBVH9csz3qKftj1j?=
 =?iso-8859-15?Q?0+FqBjY3JIdWGPSdSnKUJNyHq5YU8hRtbYkaHfxzSeupqlP/MX+Tc9LJK?=
 =?iso-8859-15?Q?g2VjjNe/vVITAG+Z7hg/ejqE1IZfCFaAIMKal5z+Hfeucj8k7iSSV1Xw/?=
 =?iso-8859-15?Q?r76r5PJ3pwmOcoU+G8NMZaGHUH5cwRLUcAVHivC67zcvfzSrCB6WSQqyU?=
 =?iso-8859-15?Q?LHHdg15RAtRFIhnle3aA/a6QCJ5gVcViOuiJCrRhPTbSiI9ed4Pi1jGBU?=
 =?iso-8859-15?Q?Ikv2nRcdyDDRxjDtAKr7dA37rD+FKZc/LtK2GmPEKGBsRORzvcBNM8OgR?=
 =?iso-8859-15?Q?wm/1VyiQ8aDRvdqNBccmC0XrCUDyoZnt+zMFh9eaXZLfVGyYih6onKBA4?=
 =?iso-8859-15?Q?OAHUavTynUnB/mssE4qPhXNWdO3USDJMaHSDGfNoQ323+LG/qXqyluas2?=
 =?iso-8859-15?Q?B5855KTuqlBdqoSxZtFOAGrqJ6bnME1OhvZRD5VE9BvKIo5vSmqLzKfZc?=
 =?iso-8859-15?Q?vUk9VslMwq7VQFd/XMKqZe8FvnunSNAqrRRn3nI/tCMbkKB/hRu9x4Z2x?=
 =?iso-8859-15?Q?Qnu0f03SGjs4pUhzcunatQrAVwCO/9qWTvq8HKQh2Z0HttgyA/+uFS548?=
 =?iso-8859-15?Q?dzWQQotxYzwwuFT5zDRSH6C4pXZ+Pte4mk1zlne479U9yAHysuFSwCkzh?=
 =?iso-8859-15?Q?FzWsBEG++IK+kGW+Y4XyNn7Fnh+yn3Mfz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <B90E8D069B37F94DA0D302BFF30CBB19@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d7a4b1-4e37-4b69-3e4c-08d9662dd83e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 12:02:13.6055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrlH5p0yL/IV2YR9KzUsk800rdHI5oIbBNWYgNKgAxPOA+m6RYT/46jbOv+6Y+OYRSAuasGNcTnJRSPt8zDAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4737
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 8/23/21 1:57 PM, Mimi Zohar wrote:
> On Mon, 2021-08-23 at 08:14 +0000, THOBY Simon wrote:
>> Hi Liqiong,
>>
>> On 8/23/21 10:06 AM, liqiong wrote:
>>> Hi Simon :
>>>
>>> Using a temporary ima_rules variable is not working for "ima_policy_nex=
t".=20
>>>
>>>  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
>>>  {
>>>  	struct ima_rule_entry *entry =3D v;
>>> -
>>> +	struct list_head *ima_rules_tmp =3D rcu_dereference(ima_rules);
>>>  	rcu_read_lock();
>>>  	entry =3D list_entry_rcu(entry->list.next, struct ima_rule_entry, lis=
t);
>>>  	rcu_read_unlock();
>>>  	(*pos)++;
>>> =20
>>> -	return (&entry->list =3D=3D ima_rules) ? NULL : entry;
>>> +	return (&entry->list =3D=3D ima_rules_tmp) ? NULL : entry;
>>>  }
>>>
>>> It seems no way to fix "ima_rules" change within this function, it will=
 alway
>>> return a entry if "ima_rules" being changed.
>>
>> - I think rcu_dereference() should be called inside the RCU read lock
>> - Maybe we could cheat with:
>> 	return (&entry->list =3D=3D &ima_policy_rules || &entry->list =3D=3D &i=
ma_default_rules) ? NULL : entry;
>>   as that's the only two rulesets IMA ever use?
>>   Admittedly, this is not as clean as previously, but it should work too=
.
>>
>> The way I see it, the semaphore solution would not work here either,
>> as ima_policy_next() is called repeatedly as a seq_file
>> (it is set up in ima_fs.c) and we can't control the locking there:
>> we cannot lock across the seq_read() call (that cure could end up be
>> worse than the disease, deadlock-wise), so I fear we cannot protect
>> against a list update while a user is iterating with a lock.
>>
>> So in both cases a cheat like "&entry->list =3D=3D &ima_policy_rules || =
&entry->list =3D=3D &ima_default_rules"
>> maybe need to be considered.
>>
>> What do you think?
>=20
> Is this an overall suggestion or limited to just ima_policy_next()?

I was thinking only of ima_policy_next(), I don't think (from what I could =
see in a short glance)
that other functions need such a treatment. The ima_rules_tmp dance is prob=
ably safe for the
other uses of ima_rules.

>=20
> thanks,
>=20
> Mimi
>=20
>=20

Thanks,
Simon=

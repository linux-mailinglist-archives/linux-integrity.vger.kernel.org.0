Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0503D886F
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 09:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhG1HAW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 03:00:22 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com ([40.107.3.101]:16231
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229939AbhG1HAV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 03:00:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ4Ncy05s5VCIvLFH50Ykj7Pzqvv5yxmaxqX9G6ljI6rPNHr6yk6jmpxq/hTk3rleKpZJ8BotBnTkjShMezbkWRM+yf/Z6d7s9jqIuKr7Hq6hhRGxH6GF2QHh9J98dpRlIebVDYopgApnCqS+lOD3JWczqIGMRWrzDKMKUEcmUeE/hH9vdfizKftQu2k+GqcLifY/ErVevZuUFth4qjZBLLXbEzhyiY2FS+I5ATzQHo0+YNKnACXO/nHFEosC3O7alj3VypLErKGRewfrND/V85m73HwmybmPwbH/41J3wKNCIXnmWGwhYOIPyXnyNodKrFahW15RGqlnsrsP4Tm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkYwNohnL8Tm2PsTYcJukzJ+tQmfD95gJlZ6TsTiVP0=;
 b=cPYsnozUWIBX01pU99g4xhDhOhsea/Nwmbr/bGGgs1BUKmcW4AxXAvNEYE4FVUzwuVnGDeRQJXEH3UfMp/sYs3LZw1FQSOBe+on3Qs3iWSuDbOxsfqYhXRB2+Eo4Lunobkkpzowrtb+haZ2Uk8eavDucafYINsU7CfOwgGeF/1ah46j2cnxaDkaJge7Byuyce/E63R2j3KXmZ7JCO7RbayZbplc0IkwViNegnLxO+DLOVAVLPX6R57AHaSflwePBJ5N2Xgpv4GZ7TPWj5uHllJCvzLl7JEzC0mjzUO1dT9ORz5kHzll65nmUlYA+wpVdeG1WMmkm8AO6MZ3SKv7w/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkYwNohnL8Tm2PsTYcJukzJ+tQmfD95gJlZ6TsTiVP0=;
 b=leBCOHoBd0inIqZMJYNvd0e6wgLpOU0XOre4gzT6VEtx+c2aafqeMPl8+OIY+NzNLth9/8kdNxlE7bO8lTDKy91DIlZrwtuQHDPFl11zPOydgHAwkaXViT3Gnj0nPDQhAYK02tPesJS9Fix8n9zNYU2LCOmypiN2vESSf48Ovds=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4052.eurprd09.prod.outlook.com
 (2603:10a6:208:1a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 07:00:19 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 07:00:18 +0000
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
Thread-Index: AQHXgwUkWGVV9iy3rkKcNLQiDD+1vKtXRwuAgACvXQA=
Date:   Wed, 28 Jul 2021 07:00:18 +0000
Message-ID: <529bc35e-642f-9f50-f3a7-0d3c07890afe@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
 <20210727163330.790010-3-simon.thoby@viveris.fr>
 <5a3a35b5f20fb17f7430046b0378e05f1dffa098.camel@linux.ibm.com>
In-Reply-To: <5a3a35b5f20fb17f7430046b0378e05f1dffa098.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d52de5a4-138b-432c-01b5-08d951955c3f
x-ms-traffictypediagnostic: AM0PR09MB4052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB40523B1E64D864DE1961126294EA9@AM0PR09MB4052.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gIQG8HDs9lC2JAzoyzjs/nCEWkZ+wQ2GdG3g38L3/cr2wdOGzeE3QvlT9AFz9XNi53YQzHo3B5iq+ATKHxf2Uqk1FCR2Ag3yRtSZVp3bUpLdcOtuYJ7P2KVH8kWfTxrOqCgKd/tQehyisa0wL9U8trAH5IPi326C6SiEe60Teg+8upgqUdsuGbSUdZpDmwIkKWPGZud9rKHQHex3fWHVkf/Gbz5zsvkJ402vrWgUXW4fx/7p6fDyn+YgIX/0F+hVzuC6FAgcpXd5YsBNzo8ZgOyRwK6JjR4879hr2zpOSGwZoSerRiOUHKXaqir0ldJkq0LLi7VN/fhC8+LXjqLYTW8CB4/2iBsTY/t43xG+LqoBl0o/ViD7PRIM7Y+mJG3FymW2ari5ZbTlztL51w4oqf3GtqOVU9XkNtcQQ0GGEyuwi2NPmpFTGyg0VimN6GcvhFmSXdwV3sIlFbQinelMJx9FjjRzpFKzV60zAUoLrEaCeBTfjyg3JFDVIM7DkpGCs64BAxLx+idjDT1k/ZcuUO8T/VJ2MY2jyEtDt2zG0E7PBr3bSYmv3wpyKTFrXvfa/zZw3lq2EXYr+es+4yM4WqDvfsa6p705uBhRBGoUGU9q7jwOkoiCXspKQqWQIMaKmfabjyFvqblzR/NCSzm+FnQ52VXxD7QfTQp+2xMrQjJUPNlBnkQ2xyzJbFnEWHe9l3Ug+vw+pAa8Kh47bwsrKTJ4bghzummvhTlCeurXafdFiyEHieLaaviLP8F1WdIt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39830400003)(31686004)(4326008)(66446008)(2616005)(83380400001)(38070700005)(66476007)(66946007)(76116006)(64756008)(66556008)(6486002)(91956017)(122000001)(38100700002)(8936002)(71200400001)(110136005)(86362001)(478600001)(316002)(8676002)(6636002)(31696002)(5660300002)(15650500001)(6506007)(53546011)(2906002)(36756003)(186003)(6512007)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?o94GR4xpLjmXAA+RfKTB0+umN35br1KK41i+T9GJn7OyXH7fJ88xh2MEE?=
 =?iso-8859-15?Q?S9XOCNshR0vE92fNMb01Rb7/EVZU+RNYROT7a6umPviq0V27l51u0O0iv?=
 =?iso-8859-15?Q?US21g5kRW91a6/gkInIwufcqp+ASP5wnkN1XAbMKT/gJmyLZN479SM7hl?=
 =?iso-8859-15?Q?0gLed8x9qVFUJU9UGj7XiwDPMdQAQFpWShqA37Z/5XlDjz039Y5qaKv5C?=
 =?iso-8859-15?Q?0tuuPimX9US34ZAOiwO8Gzgm6LIZcw1rXR09bNfbpD3zP9GM2fmyOOA+s?=
 =?iso-8859-15?Q?Wr0yZlM4pWvF10VWXAXdn13BlJx9qUEXE/SdYrQnFf77417LpsvqKMIVd?=
 =?iso-8859-15?Q?S5nwDTfwZiiZZJnHKx+kxnDeuJks9Qyp8CCM2odTyirrRHu/YHyqP4GRs?=
 =?iso-8859-15?Q?UMHkRf1+x3wmqTiqxDJ+BZJxWVM+HsuYVYR3wnjFFk8o7/S0KrSJmPjJ4?=
 =?iso-8859-15?Q?2xuq/KTiPEBfwMKPo5FgH9Nes7+VF8tMsoKmqYO0TI1ZuxanHJ3bFm5YL?=
 =?iso-8859-15?Q?8enoxdeZEGaC7rtWKHaQiZhb8iaoGu2gdR8LKz6FM7BScZRhqK/vl6+vj?=
 =?iso-8859-15?Q?YYKNyKkqu/oKwrLXHCiFd7PquMtVqK9rND8Dn1xuBAyR7dNjIMfqkRpvD?=
 =?iso-8859-15?Q?NzP1SM1K1aSmVdQRMrbIwlQxPjY9aOn0vMCuCjdwEqiXebFWMKVfTjlDm?=
 =?iso-8859-15?Q?BCRb/qwcpmwbZ9lBCnl9cSRNxneEp0uwn1N8HrEtchtwUicMeZoE2mEnU?=
 =?iso-8859-15?Q?97LtQHe678yclRSht8m5mnGe66b6cI1nnr5nOFiQCLLbYQem3Hc2BH9iZ?=
 =?iso-8859-15?Q?MDK4wfqBRj/rm+aa8Mo9lbemUPmjRHNZvsUwR0tGzIuWi3Kpfsj7PdQ4w?=
 =?iso-8859-15?Q?SZaB/vKC7VLHOW2wIBEnCyBrIijL+P8V9mAci662XOfgpW8f8IR/7qH0M?=
 =?iso-8859-15?Q?+1cqC5hUyUp/Ik+kaFiDilCZjrwae9Aqh7s9FgHOg0j+aja1Huxjr6+um?=
 =?iso-8859-15?Q?y6kC4105jr0BgYltXiegLnf8D+ASwIWU5C81vmpjvMUzUIILykXSVqWEJ?=
 =?iso-8859-15?Q?2MkZoJ0Gp3uQFqWT6+duiftPqHg2yB2eHICz9rFBjZR6iJdiLQiFcFAbo?=
 =?iso-8859-15?Q?dQjL624jEuU1Q7Cxe7a/qMqWHSbQL6tG004EZxfnhqGMC+8hnyskkguvO?=
 =?iso-8859-15?Q?XM+rugTVZHpqwDSmBbx36RXA6ojNQ60K6zb4rVlqVZfjGl9MGLeMRbq/m?=
 =?iso-8859-15?Q?U9nl9bwptMgWHCWJ5ht9329Mk0a5zXHBjCTFFTyP9lniwnOy+DgB0H4ti?=
 =?iso-8859-15?Q?gqikI1//Oi+k9Qr08sSc1G2GY09jFNgOprhRQa87WwSiK8POCb4MLhInt?=
 =?iso-8859-15?Q?BGrAQmGK1SHXCATyj36mukE5sDhznel/d0qLf17MPCM6wNqW6cg7X3Q?=
 =?iso-8859-15?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <5DC2A30D7C111644A2909D4C86E473EF@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52de5a4-138b-432c-01b5-08d951955c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 07:00:18.7616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHfWHQ7PZWodriehjvGNcjgpNQTlWZYReOMKhwjrox6acD9llSvoAusKUKomP0ioiLh03iYLQdJvHzkW01/5Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4052
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 7/27/21 10:32 PM, Mimi Zohar wrote:
> [Cc'ing Paul Moore]
>=20
> Hi Simon,
>=20

[snip]

>=20
>> +
>> +	if (likely(dentry_hash =3D=3D ima_hash_algo
>> +	    || crypto_has_alg(hash_algo_name[dentry_hash], 0, 0)))
>> +		return 0;
>> +
>> +	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
>> +	/* no memory available ? no file path for you */
>=20
> The comment here is unnecessary.  Avoid or limit comments inside a
> function.  Refer to the section "8) Commenting" in
> Documentation/process/coding-style.rst
>=20
>> +	if (pathbuf)
>> +		path =3D dentry_path(dentry, pathbuf, PATH_MAX);
>> +
>> +	/* disallow xattr writes with algorithms not built in the kernel */
>> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
>> +		path, "collect_data", "unavailable-hash-algorithm", res, 0);
>=20
> This will emit an audit message without the filename when !path.  Is
> this what you intended?
>=20

This is what I was clumsily trying to explain in the previous comment: if w=
e cannot
allocate memory for a file path, I thought it best to log the audit message=
 without
the path than fail with a -ENOMEM (auditing will also try to allocate a mem=
ory buffer
too, but a bit smaller, and memory could have been reclaimed between the tw=
o calls,
so the auditing operation may succeed).

Of course I could also return -ENOMEM, and it would happily propagate back =
to the user.

What do you think ?

Thanks,
Simon=

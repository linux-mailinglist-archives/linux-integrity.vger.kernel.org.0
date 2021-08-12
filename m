Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1AF3EA6C2
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 16:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhHLOrg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 10:47:36 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com ([40.107.7.90]:39751
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235298AbhHLOrg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 10:47:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWmBRMS00j4ulVxZjNMtbvUBNClMzy7Af1a7tEOyJJdIhiPtIxvez+wiNR2mDcrZgIzct77ZjA7QZNVpehZMLne1VHNUXpTxwwISrqTOG9jHcYfR9xyMNIEK1oeipYQ7584QhEEIylq3LQAaS1IZ49gqrFbHLxrQj2mDCaRy3nmMX6mG/Ww5c5wI1MNSxI7Qna/e3TXeFULRKOx21TAIPjreFKEjtbKnRr0pUaO4b0UavHTA1AMt5BYuB+h27Q3sXJIyXOl5m0U/8g3Lz/ATU2tpGabOlcK5Q2SBIuWG7c7OeepX/rTmICOIT9QnZVMtv1QMEGsEJEW8Oxl7lnBPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVnCWNLNIgt+4QB7I0ya18nzfcKgDSrRbZYJjwU7aQQ=;
 b=lAiNdB5lD/wI96CBtWhkT/ti7u66A2THEsrfonQdEK5pdgMwYcvEdASaewWyZ3XKDWqs7BLsLkpk9JOHQy0n2r7b+F/vGBFHtp07AaZVbcz4aA3Ola0la/8EigMFEFdcqJe63KXd2F587bP8MPJiKSfQt+mAefeQA/ijbMrXXuxcQXZaNTrVFWTx9v+bEYv8fxPrjoo+3cvoTpWZpTvb9XCF6G44UIOhXvKZ/YNqZVRHGH4hhtLxXToHB8AavRmb0Dff3dGqBx0vea2OxlfuppD6+hVest4r/4uHehKUEstneVDQJn26eOdIUYZ5vFScRMZfWH20GPOrKuUt67zGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVnCWNLNIgt+4QB7I0ya18nzfcKgDSrRbZYJjwU7aQQ=;
 b=uJRf34GBgzESrDdVxEefbv1p8W4ciJ711P2yGUcI4zshXF6mWtGHbA/NCdQnYR4w3e3rNJVBii1BJRIEtL0ig+L7zVF/gm3O/IkfnDLkDQF2bJ/6iPm1HWC/j36yaTVH4ajxtMqk9J7rJi8BHyhBJjh/VIbkgyg/VpiZx7yWPy4=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2403.eurprd09.prod.outlook.com
 (2603:10a6:208:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 12 Aug
 2021 14:47:08 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 14:47:08 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     J Freyensee <why2jjj.linux@gmail.com>,
        Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
CC:     Igor Zhbanov <izh1979@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Topic: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Index: AQHXg5n/AqeKwEHmDUiYDh8DD+AiWqtsP7yAgAPK6QA=
Date:   Thu, 12 Aug 2021 14:47:08 +0000
Message-ID: <335a7571-be4b-c56a-dfdc-15673410c8d7@viveris.fr>
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
 <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
 <98408368-119a-b00c-97eb-8ea9fd1d5244@gmail.com>
In-Reply-To: <98408368-119a-b00c-97eb-8ea9fd1d5244@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 874ece86-9f4b-4cb9-a8d5-08d95da00fa4
x-ms-traffictypediagnostic: AM0PR09MB2403:
x-microsoft-antispam-prvs: <AM0PR09MB2403FAD4A25670C24615118F94F99@AM0PR09MB2403.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkFaJ8LPEnkfCA02YsO1rTd3PZ6fcvdZu9R48mli4s/vHJ21pX1HuLPpzPRevQxXREcLkbJewVvvx327uwrXRdtSjXycl6K9JMbGAeeP/heBrDzTLJVMZ1Hg3Di9W4QDop6/QaTncs0G6AHatfp54J2KzPsUBb9jnFaBj0t+zLmybYoX7UmFpQQ8Ot/B82fcPrWk8zLJSeBfqBizjpvEwvdQgbPSVsobWaNDCR5SILLD54xM0GScSrk9nqbQY9z7uQaSbHC+te6h1npn0sp/awJh6JgOJzypyNeNc5Nr7DEI4PT9zy3oElgKKT+CAjyBtcp0s/aHxo3T3zlBc4T7NrpTsPFhuv8ZDJmd07xsM0YDaSuYE6cpJtb3lUKVigAN5oaMNg0VUVUomd8NIldIhAv5SlgsdcDAVitTyykgu/afDilZTPxcKDqXyLHpzsJIYTYdoyvrotW2xquT9C3LKjlJWx9KiIZkPhxsiwDhtyFY9DDwWUkRL4P8KiHnj42CfTBKiesmk+dE47xCZev9o9nrRycY0mHZO+n49G/68zfgYiha35g8+UKAjT0n9Wbv3Bc5fPQPXnT2PtYZ8RiUvL2RdtfFdo0pa3AheLiKfrw3tJDg790FEYVFugypc39c34O6l1oDZXG2pFW/TJydC+2eSHQvbjifwCBe074H3w3CIvzvm3rvoiQDVgkt1rP3LUbj9tJzqiIQA+HAh0GuV35R9O8Kj4qXTGaFKTmrNOSnXyJPcF7iyy+JDXrgxf1j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(376002)(366004)(396003)(346002)(136003)(83380400001)(2906002)(2616005)(478600001)(53546011)(86362001)(54906003)(110136005)(316002)(5660300002)(4326008)(36756003)(6506007)(8676002)(71200400001)(66446008)(31696002)(8936002)(6512007)(64756008)(66946007)(76116006)(91956017)(66556008)(26005)(66476007)(31686004)(6486002)(186003)(38100700002)(122000001)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?UQWArsfqOqbTJVAbPGiyxqbuqnQd7VwSViUpo9pi/RS6MBW77j8s13lM?=
 =?Windows-1252?Q?9DCFEvCfGv3f2xD+8mB1S8nRpqrOjldpJh19ur6Ez1rIrGfu8BRiJE5x?=
 =?Windows-1252?Q?0ZX30FvupYG+D47AjvGRHuDyJZgYfDeR2HMvmFJMHOGBM4n8PttZt6pw?=
 =?Windows-1252?Q?e+OI1GmqiCaF2hCXK+gD2Qe/yAnN+e5JUQ537d9FnGgid/E+F47jqyN7?=
 =?Windows-1252?Q?ZIlKTVsjBfooJn14mU5nsq5OIRV3ho1EPnmHL8TaT4/Tw4W4613bJVo5?=
 =?Windows-1252?Q?GPTWaphcQuHOU0o7dHOcZElju+VY/L+w35wS6VPSv6Wda28wxxDbohL1?=
 =?Windows-1252?Q?kTz2/gAF3ducwNtce+AEd+PMi2Zdr+4y3FeXl24jYQXyNE8tIfb7EKGX?=
 =?Windows-1252?Q?sZqguHUtdhDjjTq1lI2vEBgusKpg7xo2yjBWiEGq2jHhG7qkQVzzTKuT?=
 =?Windows-1252?Q?Ku2cxeVdmWl8yIRsdWG3FVSokis1LVGulG4ZRx3FSm3QSDDt4RISbTXw?=
 =?Windows-1252?Q?9kis/ht4yS7NdgJM5JJMTr77GAQrB0t1XnHa2vpXhWiG4cSk+l8i6HI7?=
 =?Windows-1252?Q?KEOvzqlRfxzI8Bw9v7WGiCi7RxR6AViOW6I7P5Zk3AXCrZADL4eTAIjG?=
 =?Windows-1252?Q?MceCvxkenCugaRvBmkT+RnKHfHSAJnDkTG33fyWErihT1RVbQB3ott1P?=
 =?Windows-1252?Q?Iry96448SxXEKba8zC1fKFguaPh8Zhmpv9BpCUmEqx8SHX/6fdrx/A5J?=
 =?Windows-1252?Q?nBZpTbw33CVJoxRjf/kb3hqmvB2PGEyI5YVZrlhE1hP7JcABZjWExA+6?=
 =?Windows-1252?Q?MzzMAJoeCBpddBmLvilSFXiGUZF7/dV/twzi6c7MUyA5wLzf130/L5mS?=
 =?Windows-1252?Q?Mh4C/GvKG0EAvUvKJdmDDpPdagAEpbrniMayrDEhcJs3+fteCsWQ1Q3T?=
 =?Windows-1252?Q?NkOK8OdtpJaAQGhMg/04b7xyGU02f8R3KYShwk19MQrzv7NUoGdjThDn?=
 =?Windows-1252?Q?kgEHYND5BOZZig+rnkBdYrgjJbjPHD8bAHbIQiJjdCzL/HicbkaU6lk3?=
 =?Windows-1252?Q?rgZFJnm6Pw+Bl/yL8r5WWhH2jyqpRAON/aalNJiKrTDtWM9M0u+YrfKz?=
 =?Windows-1252?Q?Ps2VpKKhkhJ+PUyg4LEySMqApp6vDsH7ZKFOJazsSqJmaJvDvLXq6ntf?=
 =?Windows-1252?Q?xrbUN5LH9muvRy9iX1NdxH6pDvDpVhkU8H8hM5LkDCZwVeRN4q2Y7d5+?=
 =?Windows-1252?Q?sqmDOGPM7JrOvwV6/UnkX8LIFaPV5+CjY54NFzQxTqnJ7ObPX4hijCsI?=
 =?Windows-1252?Q?JvKKcUzP4effhO/riLg8ia9tCmpB50jqqAO6D63vCWk6qybfmCSCX4f0?=
 =?Windows-1252?Q?/Dy6MJ0gpmkj9Sc/gGNN7lZcomV9xou6CavASYKXUkvHvhkD0IlN7DBr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <8F19C9D197EA744A9F151663FE17F93E@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874ece86-9f4b-4cb9-a8d5-08d95da00fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 14:47:08.7586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSfV7SoYOZWA+xvuhtJLQZzm3GLPJX47HUw88+lKn2dRXXYX9v9fOehBuOxzShIa2j/VWUyiBPqDOEcWh4PSBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2403
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/10/21 6:52 AM, J Freyensee wrote:
[snip]

>> Have you considered writing to the audit log instead of the kernel messa=
ges directly?
>> (not saying that this is necessarily better, but is there a reasoning to=
 prefer one or
>> the other here? Audit logs are often consumed by automated tools and it =
may be more pratical
>> for people to detect and treat violations if the messages were pushed to=
 the audit log
>> - but conversely, that requires defining and maintaining a stable log fo=
rmat for consumers)
>=20
> It's a good idea to writing to the audit log, HOWEVER I'd want to know
> what all the rest of the LSMs are doing in a case like this. If all of
> them just write kernel messages, I'd want this module to also write just
> kernel messages for consistency sake for use with say, log harvesters
> for a SIEM/XDR system solution.

Right, after taking a quick look through the SafeSetID, YAMA and the future=
 BRUTE
LSM, it looks like they all use pr_warn/pr_notice. Only the MACs seem to ma=
ke use of
the audit log, so you can forget what I said about writing to the audit log=
, this
shouldn't be necessary, and is probably a bad idea for consistency, as Jay =
said.

Simon

>=20
> Just in general I like the thought of this LSM.=A0 I used to work for a
> security company in which their cloud "watched" situations where
> mmap()/mprotect() would use anonymous executable pages for possible
> "dodgy" behavior.
>=20
> Jay
>=20

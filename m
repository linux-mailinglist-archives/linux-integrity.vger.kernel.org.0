Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09653D9EF5
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhG2Hry (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 03:47:54 -0400
Received: from mail-eopbgr50090.outbound.protection.outlook.com ([40.107.5.90]:27788
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234524AbhG2Hrx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 03:47:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbIhpsv73QJZ7cU6Y97M49PKeWrFUYO4Z4T6q/D3NB/IjUqXEvZtQImjRqAYbZdT0s26Fk2HHS4rPZT2SH8Tuh3C8wJZxfo6B1RxLHvkuGmST0iAH8AWBcoDqGgFQ2uIaleOeYokxv55wXjJp2pSXcjrbFEO3mgkTlVFTXkHEYLXHk1LMy4zIuBftvrZAQ8J2k1atUywOvD3tE5l7stK7JX5VnvUsLPRTwjjeQBU1aQrOl/QEJhXKKCOwkjZ6IcH8MPEIiePfIgxg2qO62p6R1dqlrNSMREcE8Gh7c3p2b/KbA71ae6nY8HDC/O/dF+1Su6jfI9XhmWhm21PiXdB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4VbEo9C+80z11MUKLjGJk4fhmpHvlvvyFuDhzjMQmk=;
 b=krkf9ip/TjU9OTg8tI9/Qrmu+039GoyPe0ORitLx7HsvtpPD0JZgMvfGTETe+b1NK5vPtlPH4HGNemz/TC3z7BJejZzpWxN/UCAOWDhtt2IkIMlOYUgxfqQGTm0UdN/UUwNjhQq8TdiRo1bu+YxOMumGKrR9l8Sjsg8fhkhNLH9zdZSyoH+evazhy/TsBvviS4n2Raesf2HBt5kN2Ma/LbWGvyI3IqLwOM5MblPtVAXru6I9Hh0WfLqUsh68VVTaTf2zKu964QiQl66wAixewkHrnGVqIm0axr9B5o4LVTnCCToB2VUQiWxz23FJfq00Sut2OrEo/GTbxV86B+Fhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4VbEo9C+80z11MUKLjGJk4fhmpHvlvvyFuDhzjMQmk=;
 b=nl5jwUF0aePONSs1KBlzC9fHmPC1JBEC/6Au5+oNxNJIwAg7BngguRvqACyc01HNhky+YmuTXKax6SLRWYX27X4pf1gWyRcF1Lc2owhDubot5TtMPu0XdjieAuk5LREV3m/Cxl048ENkFQpCBQZWvG9I3WTuOozaXytN8byNmRM=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4132.eurprd09.prod.outlook.com
 (2603:10a6:208:193::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 07:47:48 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.033; Thu, 29 Jul 2021
 07:47:48 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Subject: Re: [PATCH v5 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Topic: [PATCH v5 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
Thread-Index: AQHXg7N3E9MODKwTS0SH7kSeFFCcAatZAGeAgACUPYA=
Date:   Thu, 29 Jul 2021 07:47:47 +0000
Message-ID: <1fdf70ea-a5db-75d5-3e33-71229fcfd31d@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
 <20210728132112.258606-6-simon.thoby@viveris.fr>
 <acf4fc349a59b4390e0ff57728f8f4920f89386a.camel@linux.ibm.com>
In-Reply-To: <acf4fc349a59b4390e0ff57728f8f4920f89386a.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb448ff0-5067-4f5d-9cf8-08d9526528ea
x-ms-traffictypediagnostic: AM0PR09MB4132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB413257DB834B618199E21B2294EB9@AM0PR09MB4132.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iyXTPcMkWUU1V/FaJjDkirIW6QHbywPOfVOdLob4jRrI1G5Eelw9NLVY3b+6qve/DvL2//nA0KRSUqBwy1o8dXtECKaurSdp8U7Dnt1elW2eLf8VnlradRPRSB9BtWe7gbhyNSn+R5pAXD/7FhraOkxdrEoi/ciVs/8XzO8rpiC8w81GrosoOhz0naYYwaeFjnWcjKK/RwfEAQ27jfgtJh544bYPZzQxASnCZIhAnc1mRJxppSPP7nhz7epwiyLLxK9vVAowmL95RUKQ8Yt2uzTU+ErYoAnEY6L9WRyr+z/owfVvr3BWDl0bhLXekna2vATbVo9OkA5CL2H0QQJXthHB5Urr/3JTcdUMp/Tmt7HfXLoR9qb4EpjxsFYRYWgy4kPLDOUiiPlZ9eVmwIM3I1zyFFuZcV872MGMBj43cxJF0uQ4/ProNFKqedxYNhpNHHf3SYECRoVB0fmg2objQ4X1Pj87g64ShyvrrynhKQNgcIvwmV9WOZ2HGKlhI5QFOKeyGeJVN36+gXwy6ElnVU+OkrTbtB2yUYBac27Og2qvYE5vD8Ia4d6wcLYDODGSh8ClH5H6LTRlwzNRidof2zCE6Xw2ZNt5+A/Lbh17CQH2U33o57hbPHj9RlrsApNLjECZIXYYcHz0NIWeK9VAj4sna/Exe8FBs/2LRJhYmFCehleIaTYI2em1Vznovx5CaRxNHCTjwoPkT5tAPRDzsjO/PQeuYuamNxUPBIgIHLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39840400004)(136003)(376002)(5660300002)(31696002)(66476007)(64756008)(6512007)(86362001)(316002)(66556008)(66946007)(31686004)(53546011)(6486002)(8936002)(110136005)(186003)(26005)(71200400001)(83380400001)(8676002)(6506007)(36756003)(6636002)(478600001)(2906002)(76116006)(2616005)(91956017)(38070700005)(122000001)(38100700002)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?WvdXz9vA14CUyNcEPb23xHjvdoIuqApsuSe06E10XzopSIgsq1nOygffZ?=
 =?iso-8859-15?Q?fNWKJjkeLpz43sXYUsj1LF04OQaSrokNmUZJ7e6OkeYimxTbFPWsYcHuD?=
 =?iso-8859-15?Q?XSOZxWpXL6MMoUcwxWm90UB1QFNxVsFQRRM9HltaOzFmlaxpJA7DnyBYA?=
 =?iso-8859-15?Q?hy3lXUXgqtc/drJGYWpLL6CNPpXMoODqbM0bPT0NRdJZSzzTDs1WsQkM+?=
 =?iso-8859-15?Q?mVyDW6q5gxDYWPDhVTGqpNSbaLYFzZHJ33BkHECgimNzk7EWLghB/YK1a?=
 =?iso-8859-15?Q?iApcK4xt+30+I79jZQaHg+P4CTD6zxks7Eh9fvOm9VsfkwcY+vEA6k3nM?=
 =?iso-8859-15?Q?1reXVJWakDb5QgUPHiZqttIfXTRbUVCUR2VKohf3vTDAm0tRYfCmPMbqT?=
 =?iso-8859-15?Q?SolvGs9zYUKVVveXVgqrorzuYrIblQ2gV8Fahmh4Jl6Dw5XvJmPZ2uSvS?=
 =?iso-8859-15?Q?5CQ7r1uVP5OmjTQsZk3TSmeNEg8U7ePIJu5nEH9Sc99vYAehSxx95SDHx?=
 =?iso-8859-15?Q?Az5/7VExG9y7RDur3yggNfk2WHmXJv9KCVY4pdVyAtJHgCfx64W3LAVPm?=
 =?iso-8859-15?Q?50y9iLDVMg4eEYmrz0eluhtCcWUxUCvnFBIXWBFQFjWpou7Hjotitb++k?=
 =?iso-8859-15?Q?jJ6+6PmtitiR3xLoPFgFVNhrY7yediWGn/vxqed/XZQRLBnqAQaTNVWQT?=
 =?iso-8859-15?Q?IlxfCXR4jrfsoh1UloVIGYANKjxPnOzD8gI+1lKizTCubF62MQ37boOP1?=
 =?iso-8859-15?Q?JgOntxOEoLwtpvTXxGVJvv83nNtQ4mHeXd6hLrjVa6Y1usUbrO9hKK9aG?=
 =?iso-8859-15?Q?iqegn32EvQzbAT4lo3dzc9tw0n/W7QoUhbp/73ezax3Z28joCw3xjaBvF?=
 =?iso-8859-15?Q?DI4dTr2ylrE0zdyOePWaOowwB0B8s72jweTYIl6xaSXqaFRGrFFj8gUE6?=
 =?iso-8859-15?Q?ap7Vv2oLeeaFOMUV4qqA+zLWzm4JIDac/C360qEywPkaUrbbEx6/LVBsR?=
 =?iso-8859-15?Q?St2GG7ywtlzV397ZPlzao5+cQ2npRFtzHg++axAICr/0vOueRKCqcXD3D?=
 =?iso-8859-15?Q?k4ajikQt5FvgtAd7skDufby9bbBBzb7yMSWh6+gKw33yuWJMNszaoneZL?=
 =?iso-8859-15?Q?h4MqSiZa07AjU2vAPw8TrPQhzl5magwOGajvDzT0THhtAT5u1yKjPp9Qc?=
 =?iso-8859-15?Q?1aLm9LBSzaRTsTFrrQfCe3iVINrQrhP7eQlQt9Snk+6A5o+BdS6BDTOMn?=
 =?iso-8859-15?Q?xc3pyEygUghtBlYzzFCWi+YnNnS9ZVnWpfITEzcCHyWtLClcGLLAmTI8y?=
 =?iso-8859-15?Q?OdO+cdxKKRsF/YdDvFeaNblSV/9JygjdMkgd2uQdg4JGwZvgIw+9pAuXw?=
 =?iso-8859-15?Q?2eywkdfyLyI/QmSsq0elYK3H28GUqzie9?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <F37293FDB11C2646871675D2AA3D5F7A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb448ff0-5067-4f5d-9cf8-08d9526528ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 07:47:48.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqks77NFLiC06r6Cwlx6ZLBEdVGnDaF7c99DfIhvo2z0QcWWNmnU4JohHr+slG43e+G/v4CBkV/UdyWRKj32Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4132
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 7/29/21 12:57 AM, Mimi Zohar wrote:
> Hi Simon,
>=20
> On Wed, 2021-07-28 at 13:21 +0000, THOBY Simon wrote:
> =20
>> @@ -914,6 +918,42 @@ int ima_check_policy(void)
>>  	return 0;
>>  }
>> =20
>> +/** update_allowed_hash_algorithms - update the hash algorithms allowed
>=20
> The first line of kernel-doc is just "/**" by itself, followed by the
> function name and a brief description.  The brief description should
> not wrap to the next line.  Refer to Documentation/doc-guide/kernel-
> doc.rst.
>=20

Thanks, I will fix that in the next revision.

>> + * for setxattr writes
>> + *
>> + * Update the atomic variable holding the set of allowed hash algorithm=
s
>> + * that can be used to update the security.ima xattr of a file.
>> + *
>> + * Context: called when updating the IMA policy.
>> + *
>> + * SETXATTR_CHECK rules do not implement a full policy check because of
>> + * the performance impact performing rules checking on setxattr() would
>> + * have. The consequence is that only one SETXATTR_CHECK can be active =
at
>> + * a time.
>> + */
>> +static void update_allowed_hash_algorithms(void)
>> +{
>> +	struct ima_rule_entry *entry;
>> +
>> +	/*
>> +	 * We scan in reverse order because only the last entry with the
>> +	 * 'func=3DSETXATTR_CHECK' apply: this allows runtime upgrades of the
>> +	 * digest algorithm policy, unlike the other IMA rules that are
>> +	 * usually append-only. Old rules will still be present in the
>> +	 * ruleset, but inactive.
>> +	 */
>=20
> Oh, my!  I really hope this won't be used as precedent.  Before
> agreeing to this, the existing policy rules must require loading of
> only signed IMA policies.
>=20


After some though, I think you're right, there is not much point to do anyt=
hing
different from the other IMA rules,=20

Below is the modified version that I will submit in the next patch.

However given the similarities between this function and ima_update_policy_=
flag,
I think maybe I should merge them together: they are mostly called from the
same places and they both serve the same role: updating some of the global =
ima
variables after a policy update or at system initialization.

Do you think it would be ok to add that functionality to ima_update_policy_=
flag?
Maybe updating the name to reflect that the function updates multiples flag=
s?

=20
+/**
+ * update_allowed_hash_algorithms() - update the hash allowlist for setxat=
tr
+ *
+ * Update the atomic variable holding the set of allowed hash algorithms
+ * that can be used to update the security.ima xattr of a file.
+ *
+ * SETXATTR_CHECK rules do not implement a full policy check because
+ * of the performance impact performing rules checking on setxattr()
+ * would have. The consequence is that only one SETXATTR_CHECK can be
+ * active at a given time.
+ *
+ * Context: Called when updating the IMA policy.
+ */
+static void update_allowed_hash_algorithms(void)
+{
+	struct ima_rule_entry *entry;
+
+	rcu_read_lock();
+	list_for_each_entry(entry, ima_rules, list) {
+		if (entry->func !=3D SETXATTR_CHECK)
+			continue;
+
+		/*
+		 * Two possibilities:
+		 * - the atomic was non-zero: a setxattr hash policy is
+		 *   already enforced -> do nothing
+		 * - the atomic was zero -> enable the setxattr hash policy
+		 *
+		 * While we could check if the atomic is non-zero at the
+		 * beginning of the function, doing it here prevent TOCTOU
+		 * races (not that I think there would be much interest for
+		 * an attacker to perform a TOCTOU race here)
+		 */
+		atomic_cmpxchg(&ima_setxattr_allowed_hash_algorithms, 0,
+			       entry->allowed_hashes);
+		break;
+	}
+	rcu_read_unlock();
+}
+

As a side note on the patchset, maybe I should refrain from posting for a f=
ew days to give people time
to comment on it, instead of sending new versions in such a quick successio=
n?

Thanks,
Simon=

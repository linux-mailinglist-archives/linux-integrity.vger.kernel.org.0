Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170C85B010B
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIGJ6X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 05:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiIGJ6Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 05:58:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32EDB5E4E;
        Wed,  7 Sep 2022 02:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyZ+DB+jGW5Xcc1O2eCpFdbqoFuXk2L7s26kTaO/Rfe7f23s9OMCQXhwAw0YzxLAWx/QWpgL2RpBrkwjhtStwZv85hGwn0Ws4X9bhfAw88RkAKLZhFfW9pzKalxtODM4hkwcqx9gAt1MznOy0ZWTBVEh9tRmVmRekUNB/8dh3hGx09pnw/ZcHZDURXbkkYbPw2hAkJZ+xzQ1MK4IzS2lrihEVDmnyk9R0GL+4Lm3PFkPYOmgP7dTbNElz0Mv9Z09fdaV5ir+wRLORyKkUyUCV7EOyN9xVknUVG0VdM8D1bkIhVToRJlPk8d2YcHmwxDbusbcED9LUthz0i1qoq1HzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ITSHMHnTVqM/VmPhMbjtiJsEF6BhNcv6UWPeyHlUwA=;
 b=kApBQJitzxBv5gPQjhRn0T0PogmcH6al+1Q6JnoYgiFR0H635xk7PMwe96YrQ9FjdrRg8qbsfXLAl15LjPMDqiFvUwwdopohsp71R7k9FQzKB0rdg481JNlly8MmKR9bByRZ+Wp12frnuDc5QzNEvIqg1ztJDXWxNeNyJ2jEE4rQ4z6q/9KGNn93s/cAi8/lI4XMLO1rpA0243P3Dqv6FbvrE1maXZAxP7V/vVDp25oZ6SJ7dpzpFu1+qHFmgOA2VMhX4upYmL79PwF+8ELMyFmfcBs7wXDpyjWKq4j8ztTIkcM2uZygkJmf/l5zC2oj2EN/teJApsv6EB8A850MpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ITSHMHnTVqM/VmPhMbjtiJsEF6BhNcv6UWPeyHlUwA=;
 b=nFTABNcctWK9yIiqmuQxtIwPUJ2q3tLDE+CsIKcE8dm1aWZ/WwBwxz4va/z/3g9f+gPlT1Mv4kZw3/CzANjJ6xRlqBkJQsecyEpyrsfLiSaFPimh2JQgIJwjdTtiayeMxDbdz3CzkIbF0BcyO2D82GfpOPpppUCTbOEUCnxjpf0=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 09:57:50 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 09:57:50 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Michael Walle <michael@walle.cc>, David Gstir <david@sigma-star.at>
CC:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
Thread-Topic: [EXT] [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
Thread-Index: AQHYwo3tNksinToq8Uy3w7riQYXhMK3Tnc4AgAAMkVA=
Date:   Wed, 7 Sep 2022 09:57:50 +0000
Message-ID: <DU2PR04MB86307A87D2D1870C55E7E0D595419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <047746e1134d5bdce699d8c021f849b6@walle.cc>
 <DU2PR04MB8630C63609D6D785F12DEC6E95419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <5d67b4d45aa1b2a3d2738c93edaeffdd@walle.cc>
 <1E73DC47-9494-453C-899D-CE386336EF8D@sigma-star.at>
 <9f6fbc2b549fe8bca8a442a5bcaa1942@walle.cc>
In-Reply-To: <9f6fbc2b549fe8bca8a442a5bcaa1942@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS8PR04MB7493:EE_
x-ms-office365-filtering-correlation-id: 537724bb-1839-47e1-b985-08da90b76cea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NB2sS+Nv929lgcZWsxPnwmgDfTIAgc3yWzIwdYhYRdsnyBzSpgUNfLuqUXlIoPGMYV5T+fGMQHnYhNmdKUEB/7oUZTjUOa3RAimCYUlufsW/9mosWebR4w2ul9GKGLAdt9JZj4uAqJcOrFjTCUbyYDfmlv1k9ZQkPZ3bV6t7xMFr7GJm7OV5QkhECfNKiIDxXTNH3PTvE1xZO7Q6DCuOEJKZR2dDjYLiYcDC6wlkICQHk9CW+XUtuRGVCpmAbq1JVNdk7tDB38zfaucmakwdsdF84Fuj2lv8QvwLQ530GdDOevWIwnz/wDCmugaB0nObEG1EhljW4ydJiHZHVBga1NGjrptHrGhIy2/fO00+bmNLrHdfDEkqVmngNjkZZaG8m7+L0oI1/iCjsr1YmmdlVEwL9qZtQeRWFpvzudCt8Jd2UMBh2JYiMA9VDsbGLFCVicpYhNYFB6JlE+FshahKndQbymkJr0mMxqW0WC4QA8FskVD+x01jOOTI3e+hZulMdDVoEXulHLxK8Gcl0cbWsQ9vhppmicWWdbcVlVWiEq7Bi/9hQQ68wR24JuAkRnjdbGiJDr2ZToFQcVpcPVHGFxSXDHKhNOsKMlR32QssPJgVfpW9tbpwDBibF7TkEY/HuiHtnYXORRj5WsSzsfDkgH3RgLp4ddLg0HGvQBvb/AH1YgeCNZcNmoR34OwCBiD4W2lmH+BCcKVD6wrceCYLd/drvE7pujyHW/MHkaedBeC3KN4AXmra20laT7+y42iW+eLlKml+Aq6fYBHxwlBiUFot9awWxaQRnnCZhAUFvbc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(44832011)(186003)(110136005)(71200400001)(55016003)(54906003)(316002)(38100700002)(478600001)(8936002)(7696005)(6506007)(64756008)(66476007)(122000001)(4326008)(66446008)(76116006)(52536014)(66556008)(8676002)(5660300002)(66946007)(9686003)(53546011)(86362001)(33656002)(55236004)(7416002)(41300700001)(38070700005)(83380400001)(26005)(2906002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm5KNlRXUFBhUmpvZkNWZVpHOFNNemdDREM5RmVUNC9DRGprMFBIbUxoelBH?=
 =?utf-8?B?OTArRnJvWDRjbHI4Z1AzNlI2MUx0eC9qdnBObFA0WmZmMCtHaFQ0V0NybHc3?=
 =?utf-8?B?c1k0d1pzbE1SMEZ5V2VEVGF1Y0haaHV2MFcyaTZYa0ZJSllTZDZaOXc2R3lT?=
 =?utf-8?B?NFRRcUtoWWVYQXN6MzJLWEdvY1JTQW9RLzZLQWRkWTFkY3N3OW5aN3A1emdU?=
 =?utf-8?B?RVZ1MnlUY2lxL0g3RDRsWE4wVkRJUWRMRm9LRVU2V0RKcHZTSUR2bVFNdWJF?=
 =?utf-8?B?MWNaYjNVQk1JVmtDRTFNMG1TK2l1dDFTUUNFU0Fyd21hd1k2bStKaGpOanJW?=
 =?utf-8?B?VlpmdGs2UWlzZXRSMFpJYWdSbVh2OEdiUXptKytWTWtvTWpyY1dkc0pVY0lj?=
 =?utf-8?B?MVlDaWtOWlRqOFBRYWx5blArYWVzRjRWanpSRDRIdmp3cndFZmhUR0xKSjMr?=
 =?utf-8?B?YklnQXNxRC9NaEpnYmI2aWNRSDlzalpicXM0RFBhVFhLN0FDS0I2WEhjT01J?=
 =?utf-8?B?T0lLUWJYY1F4T0NreDA3cGtWTUdIekdDUldjWmppeDJzSHVEb1FJNEpvOXJo?=
 =?utf-8?B?aGIxaUhVZGU3WEVyZDNDRkhRQ2NJNUdYUHFaZEFpazRVRlFxcFJpYjNOWFZT?=
 =?utf-8?B?dDBENExGSjJZbktSNjdsbVF1UGh4eGF0bnl5NDJYb3pJeU42cGhQTlhyS3ZE?=
 =?utf-8?B?dCtaaDJMOXc4MlNLVnVWR0xRbG1BQ2plWEkxaUNKcnFrdEJNSGhhekVGWERI?=
 =?utf-8?B?ZFBwdjlLdHFuZFdWOXpkMzcxRVZLTjg5MGhXaUdzRzJTbllyOFA3bExNVW8r?=
 =?utf-8?B?VmthcDUzN1ZidE1zai9Va2Q3ZnZoeTl0REtrU3JZMFpPNDJUMTYweE0wNldw?=
 =?utf-8?B?TkFzRGl2N2lzNVJqOXZ6YytXaFMwNFJQZ0NCSzUyRGJrN2RNVlluZU1PdEdN?=
 =?utf-8?B?c2tRMVZiK1MweDBneThiMjdBOFBVcEp3M0pQY2NpZ0pIMXExTlFLdjIrbFRj?=
 =?utf-8?B?cndxcWY4N2J5RHZtbXh4UmR3SDlYdWNNcnpaSHFreGhBVnlKQm44clgvMVND?=
 =?utf-8?B?ajN5aCs0dzZreHpPNTM4Z2djNVd5QTRWYzZ3QzZIRTlzK21SSFhEYXA5RTRD?=
 =?utf-8?B?bTJPcVpwYkRKWUxzbzNsTU1wbnRVTnNwdDRaVXN6Ym50OXhDeFNrcGJpV21z?=
 =?utf-8?B?aHcvbDlaZ3g5ckUvUjFVMmdERDl1WUdCbmtkd09nLzI2V3Zzb1hpNnEvb0Qr?=
 =?utf-8?B?UjVrdFB4cHdzUkdoeDloK2FSRW1YQXFMU0txTE5JWWpmTldtSlNoeG0rVWhY?=
 =?utf-8?B?aUxJQXNNOWZlVDIwK3U2TnovUFU3dk1zUVJsSE1WckJFSWNmMDdQc1kzYmpV?=
 =?utf-8?B?OHBCaWVPMTBmc0ZncWI0N09NRWxZdHN1dkcwNHdtU1NSQ2RPOFdldjk0ZUdX?=
 =?utf-8?B?T200NWRwdVBYVDYxZWc1KzNPdElrMlNXVXhqVExzMGlpS0tEQkxKbGsyMFhm?=
 =?utf-8?B?dllJZUorbnBRUmtPZ1lrMjdvbjZ1RHVaUXZnQ0FpdUd6OVJEeExaZ3pIQlFs?=
 =?utf-8?B?eWtHd0ZJbnZWeFNSZkF6WUtTRXBTcU15VFpVM2dMSFlmcVhaT1V3Qy9yT1E0?=
 =?utf-8?B?YmQ2WmtqQmpBMzRCRnlhSHFBUUNwb1l3WmNzS0R2bHBJNHVScFUxYThyTWJT?=
 =?utf-8?B?THFwdVdseFZ0WG9nMWZnR3ZZaG5yNDRiMThUT1o5UHErTzR2OXE3cUJlRlhL?=
 =?utf-8?B?K2x6eWNnYlUyWlJkdmxzUm5xVkk4REpoZm1Bb3NhSWQ1Ky96MHZCRmp2YmZp?=
 =?utf-8?B?NGZhcEV5NXRTdHpyc2lvanVkenptSXNSZlVIL2xGK2ZwNFlxRU5hbVlnODlx?=
 =?utf-8?B?M0V4Tk9QK09sOExYNmhtNmVHb2ZHYTVqRjB5UGFMSWpVb0NQc201S1h2cmZ5?=
 =?utf-8?B?QU9EeHVLaENXczAvdUpCK3dLY2xrRnpaNDhESzh2VFZsWjNVbTBIN3BGb0JM?=
 =?utf-8?B?NW1hbnJZem5MN3JmY21DVEsrejA5VGFBWThJVXBwTW9wL1JIR21kZ1FxYnBK?=
 =?utf-8?B?eHZWSW1rYkpuL0NkMEVHYndVUS8wYVNYU2NRa3lTaTVjMGVyaFBZNWh1QTdW?=
 =?utf-8?Q?BaECQXTd/f1OVTPb/anOHOvvG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537724bb-1839-47e1-b985-08da90b76cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 09:57:50.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZF2/bmKe+EQV9Rn6llJw3Ssxsb/xJ+lIR2ZEshHw+tNKJGClkV0xc2iph+H8uoX2CDJP5goV2PDbQQda5T9Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNywgMjAyMiAx
OjQyIFBNDQo+IFRvOiBEYXZpZCBHc3RpciA8ZGF2aWRAc2lnbWEtc3Rhci5hdD4NCj4gQ2M6IFBh
bmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+OyBBaG1hZCBGYXRvdW0NCj4gPGEuZmF0
b3VtQHBlbmd1dHJvbml4LmRlPjsgSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz47
DQo+IEphc29uQHp4MmM0LmNvbTsgSmFtZXMgQm90dG9tbGV5IDxqZWpiQGxpbnV4LmlibS5jb20+
OyBNaW1pIFpvaGFyDQo+IDx6b2hhckBsaW51eC5pYm0uY29tPjsgRGF2aWQgSG93ZWxscyA8ZGhv
d2VsbHNAcmVkaGF0LmNvbT47IFN1bWl0DQo+IEdhcmcgPHN1bWl0LmdhcmdAbGluYXJvLm9yZz47
IGpvaG4uZXJuYmVyZ0BhY3RpYS5zZTsgSmFtZXMgTW9ycmlzDQo+IDxqbW9ycmlzQG5hbWVpLm9y
Zz47IFNlcmdlIEUuIEhhbGx5biA8c2VyZ2VAaGFsbHluLmNvbT47IEhlcmJlcnQgWHUNCj4gPGhl
cmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47DQo+IEphbiBMdWViYmUgPGoubHVlYmJlQHBlbmd1dHJvbml4LmRlPjsgRXJpYyBC
aWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwub3JnPjsNCj4gUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD47IGtleXJpbmdzQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGNyeXB0b0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJu
ZWwub3JnOyBTYWhpbA0KPiBNYWxob3RyYSA8c2FoaWwubWFsaG90cmFAbnhwLmNvbT47IEtzaGl0
aXogVmFyc2huZXkNCj4gPGtzaGl0aXoudmFyc2huZXlAbnhwLmNvbT47IEhvcmlhIEdlYW50YSA8
aG9yaWEuZ2VhbnRhQG54cC5jb20+Ow0KPiBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW0VYVF0gW1JGQyBQQVRDSCBIQks6IDAvOF0gSFcgQk9VTkQgS0VZIGFz
IFRSVVNURUQgS0VZDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IEhpIERhdmlkLA0K
PiANCj4gQW0gMjAyMi0wOS0wNyAwOTo0Niwgc2NocmllYiBEYXZpZCBHc3RpcjoNCj4gPj4gT24g
MDcuMDkuMjAyMiwgYXQgMDk6MjksIE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+IHdy
b3RlOg0KPiA+Pg0KPiA+PiBBbSAyMDIyLTA5LTA3IDA5OjIyLCBzY2hyaWViIFBhbmthaiBHdXB0
YToNCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IE1pY2hh
ZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+ID4+Pj4gU2VudDogVHVlc2RheSwgU2VwdGVt
YmVyIDYsIDIwMjIgMTI6NDMgUE0NCj4gPj4+PiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3Vw
dGFAbnhwLmNvbT4NCj4gPj4+PiBDYzogamFya2tvQGtlcm5lbC5vcmc7IGEuZmF0b3VtQHBlbmd1
dHJvbml4LmRlOyBKYXNvbkB6eDJjNC5jb207DQo+ID4+Pj4gamVqYkBsaW51eC5pYm0uY29tOyB6
b2hhckBsaW51eC5pYm0uY29tOyBkaG93ZWxsc0ByZWRoYXQuY29tOw0KPiA+Pj4+IHN1bWl0Lmdh
cmdAbGluYXJvLm9yZzsgZGF2aWRAc2lnbWEtc3Rhci5hdDsgam9obi5lcm5iZXJnQGFjdGlhLnNl
Ow0KPiA+Pj4+IGptb3JyaXNAbmFtZWkub3JnOyBzZXJnZUBoYWxseW4uY29tOyBoZXJiZXJ0QGdv
bmRvci5hcGFuYS5vcmcuYXU7DQo+ID4+Pj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgai5sdWViYmVA
cGVuZ3V0cm9uaXguZGU7DQo+IGViaWdnZXJzQGtlcm5lbC5vcmc7DQo+ID4+Pj4gcmljaGFyZEBu
b2QuYXQ7IGtleXJpbmdzQHZnZXIua2VybmVsLm9yZzsNCj4gPj4+PiBsaW51eC1jcnlwdG9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOw0KPiA+Pj4+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+Pj4gbGludXgtDQo+ID4+Pj4gc2VjdXJp
dHktbW9kdWxlQHZnZXIua2VybmVsLm9yZzsgU2FoaWwgTWFsaG90cmENCj4gPj4+PiA8c2FoaWwu
bWFsaG90cmFAbnhwLmNvbT47IEtzaGl0aXogVmFyc2huZXkNCj4gPj4+PiA8a3NoaXRpei52YXJz
aG5leUBueHAuY29tPjsgSG9yaWEgR2VhbnRhIDxob3JpYS5nZWFudGFAbnhwLmNvbT47DQo+ID4+
Pj4gVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBbRVhUXSBS
ZTogW1JGQyBQQVRDSCBIQks6IDAvOF0gSFcgQk9VTkQgS0VZIGFzIFRSVVNURUQNCj4gS0VZDQo+
ID4+Pj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+ID4+Pj4gSGksDQo+ID4+Pj4gQW0gMjAyMi0wOS0w
NiAwODo1MSwgc2NocmllYiBQYW5rYWogR3VwdGE6DQo+ID4+Pj4gPiBIYXJkd2FyZSBCb3VuZCBr
ZXkoSEJLKSwgaXMgbmV2ZXIgYWNlc3NpYmxlIGFzIHBsYWluIGtleSBvdXRzaWRlDQo+ID4+Pj4g
PiBvZiB0aGUgaGFyZHdhcmUgYm91bmRhcnkuIFRodXMsIGl0IGlzIHVuLXVzYWJsZSwgZXZlbiBp
ZiBzb21laG93DQo+ID4+Pj4gPiBmZXRjaGVkIGZyb20ga2VybmVsIG1lbW9yeS4gSXQgZW5zdXJl
cyBydW4tdGltZSBzZWN1cml0eS4NCj4gPj4+PiA+DQo+ID4+Pj4gPiBUaGlzIHBhdGNoc2V0IGFk
ZHMgZ2VuZXJpYyBzdXBwb3J0IGZvciBjbGFzc2luZyB0aGUgSGFyZHdhcmUNCj4gPj4+PiA+IEJv
dW5kIEtleSwgYmFzZWQgb246DQo+ID4+Pj4gPg0KPiA+Pj4+ID4gLSBOZXdseSBhZGRlZCBmbGFn
LSdpc19oYmsnLCBhZGRlZCB0byB0aGUgdGZtLg0KPiA+Pj4+ID4NCj4gPj4+PiA+ICAgQ29uc3Vt
ZXIgb2YgdGhlIGtlcm5lbCBjcnlwdG8gYXBpLCBhZnRlciBhbGxvY2F0aW5nDQo+ID4+Pj4gPiAg
IHRoZSB0cmFuc2Zvcm1hdGlvbiwgc2V0cyB0aGlzIGZsYWcgYmFzZWQgb24gdGhlIGJhc2lzDQo+
ID4+Pj4gPiAgIG9mIHRoZSB0eXBlIG9mIGtleSBjb25zdW1lciBoYXMuDQo+ID4+Pj4gPg0KPiA+
Pj4+ID4gLSBUaGlzIGhlbHBzIHRvIGluZmx1ZW5jZSB0aGUgY29yZSBwcm9jZXNzaW5nIGxvZ2lj
DQo+ID4+Pj4gPiAgIGZvciB0aGUgZW5jYXBzdWxhdGVkIGFsZ29yaXRobS4NCj4gPj4+PiA+DQo+
ID4+Pj4gPiAtIFRoaXMgZmxhZyBpcyBzZXQgYnkgdGhlIGNvbnN1bWVyIGFmdGVyIGFsbG9jYXRp
bmcNCj4gPj4+PiA+ICAgdGhlIHRmbSBhbmQgYmVmb3JlIGNhbGxpbmcgdGhlIGZ1bmN0aW9uIGNy
eXB0b194eHhfc2V0a2V5KCkuDQo+ID4+Pj4gPg0KPiA+Pj4+ID4gRmlyc3QgaW1wbGVtZW50YXRp
b24gaXMgYmFzZWQgb24gQ0FBTS4NCj4gPj4+PiA+DQo+ID4+Pj4gPiBOWFAgYnVpbHQgQ0FBTSBJ
UCBpcyB0aGUgQ3J5cHRvZ3JhcGhpYyBBY2NlbGVyYXRpb24gYW5kIEFzc3VyYW5jZQ0KPiA+Pj4+
ID4gTW9kdWxlLg0KPiA+Pj4+ID4gVGhpcyBpcyBjb250YWluIGJ5IHRoZSBpLk1YIGFuZCBRb3JJ
USBTb0NzIGJ5IE5YUC4NCj4gPj4+PiA+DQo+ID4+Pj4gPiBDQUFNIGlzIGEgc3VpdGFibGUgYmFj
a2VuZCAoc291cmNlKSBmb3Iga2VybmVsIHRydXN0ZWQga2V5cy4NCj4gPj4+PiA+IFRoaXMgYmFj
a2VuZCBzb3VyY2UgY2FuIGJlIHVzZWQgZm9yIHJ1bi10aW1lIHNlY3VyaXR5IGFzIHdlbGwgYnkN
Cj4gPj4+PiA+IGdlbmVyYXRpbmcgdGhlIGhhcmR3YXJlIGJvdW5kIGtleS4NCj4gPj4+PiA+DQo+
ID4+Pj4gPiBBbG9uZyB3aXRoIHBsYWluIGtleSwgdGhlIENBQU0gZ2VuZXJhdGVzIGJsYWNrIGtl
eS4gQSBibGFjayBrZXkNCj4gPj4+PiA+IGlzIGFuIGVuY3J5cHRlZCBrZXksIHdoaWNoIGNhbiBv
bmx5IGJlIGRlY3J5cHRlZCBpbnNpZGUgQ0FBTS4NCj4gPj4+PiA+IEhlbmNlLCBDQUFNJ3MgYmxh
Y2sga2V5IGNhbiBvbmx5IGJlIHVzZWQgYnkgQ0FBTS4gVGh1cyBpdCBpcw0KPiA+Pj4+ID4gZGVj
bGFyZWQgYXMgYSBoYXJkd2FyZSBib3VuZCBrZXkuDQo+ID4+Pj4gV2hhdCBpcyB0aGUgZGlmZmVy
ZW5jZSB0byB0aGUgY3VycmVudCB0cnVzdGVkIGtleXMgd2l0aCBDQUFNPw0KPiA+Pj4+IFdoZW4g
SSB0ZXN0ZWQgdGhlIHBhdGNoIHNlcmllcyBiYWNrIHRoZW4sIEkgd2Fzbid0IGFibGUgdG8gaW1w
b3J0IGENCj4gPj4+PiBzZWFsZWQga2V5IG9uIGFub3RoZXIgYm9hcmQgd2l0aCB0aGUgc2FtZSBT
b0MuDQo+ID4+PiBDdXJyZW50bHksIGtleXMgdGhhdCBhcmUgcGFydCBvZiB0cnVzdGVkIGtleS1y
aW5nLCBjb250YWlucyBwbGFpbg0KPiA+Pj4ga2V5Lg0KPiA+Pj4gV2l0aCB0aGlzIHBhdGNoLXNl
dCwgdGhlc2Uga2V5IHdpbGwgYmVjb21lIEh3IEJvdW5kIEtleSwgd2hpY2ggaXMNCj4gPj4+IG5v
dCBhIHBsYWluIGtleSBhbnltb3JlLg0KPiA+Pj4gQWZ0ZXIgdGhpcyBwYXRjaC1zZXQsIGlmIHNv
bWVob3cgdGhlIEhCLWtleSBpcyByZXRyaWV2ZWQgZnJvbSB0aGUNCj4gPj4+IGtleXJpbmcsIHRo
ZSByZXRyaWV2ZWQga2V5ICB3b3VsZCBiZSB1bi11c2FibGUgd2l0aG91dCBody4NCj4gPj4NCj4g
Pj4gVGhpcyBkb2Vzbid0IGFuc3dlciBteSBxdWVzdGlvbiB3aHkgSSBjb3VsZG4ndCBpbXBvcnQg
b25lIGtleSBvbg0KPiA+PiBhbm90aGVyIGJvYXJkIHdpdGggdGhlIHNhbWUgU29DLg0KPiA+DQo+
ID4gSSBkb27igJl0IGJlbGlldmUgdGhpcyBpcyBpbnRlbmRlZCB0byB3b3JrIHRoaXMgd2F5LiBF
YWNoIGtleSBibG9iDQo+ID4gY3JlYXRlZCBieSBDQUFNIGlzIGJvdW5kIHRvIGEgc3BlY2lmaWMg
ZGV2aWNlLiBCZWluZyBhYmxlIHRvIGRlY3J5cHQNCj4gPiB0aGUgc2FtZSBibG9iIG9uIGFub3Ro
ZXIgU29DIHdvdWxkIG9wZW4gdXAgc29tZSBhdHRhY2sgdmVjdG9yczogVGhpbmsNCj4gPiBvZiBh
IGxvY2tlZCBkb3duIGRldmljZSB3aGVyZSBJ4oCZbSBhYmxlIHRvIGV4dHJhY3QgdGhpcyBrZXkg
YmxvYi4NCj4gPiBTaW1wbHkgYnV5aW5nIGEgYm9hcmQgd2l0aCB0aGUgc2FtZSBTb2Mgd291bGQg
YWxsb3cgbWUgdG8gZGVjcnlwdCB0aGlzDQo+ID4gYmxvYiBieSBjb3B5aW5nIGl0IG92ZXIgdG8g
bXkgYm9hcmQuDQo+IA0KPiBJIGFncmVlLCB0aHVzIG15IGZpcnN0IHF1ZXN0aW9uIGhlcmUgd2Fz
LCB3aGF0IHRoaXMgc2VyaWVzIGlzIGFkZGluZywgaWYgdGhlIGtleQ0KPiBpcyBhbHJlYWR5ICJi
b3VuZCIgdG8gdGhlIGhhcmR3YXJlLiBUaGF0IGlzIHdoYXQgSSBkb24ndCB1bmRlcnN0YW5kLg0K
PiANCj4gLW1pY2hhZWwNCg0KSnVzdCBvbmUgY29ycmVjdGlvbiBpbiBhYm92ZSBzdGF0ZW1lbnQu
DQoiS2V5LUJsb2IiIGlzIGJvdW5kIHRvIHRoZSBoYXJkd2FyZSwgbm90IHRoZSBwbGFpbiBrZXkg
dGhhdCBpcyBhZGRlZCB0byB0aGUgam9iLXJpbmcsIGFmdGVyIGRlLWJsb2JpZmljYXRpb24uDQpT
ZWN1cml0eSBhdCByZXN0IGlzIGVuc3VyZWQgaGVyZS4gQnV0IG5vdCBhdCB0aGUgcnVudGltZS4N
Cg0KVGhpcyBwYXRjaC1zZXQgZ29lcyBhIHN0ZXAgZnVydGhlciBhbmQgZW5zdXJlcyBydW50aW1l
IHNlY3VyaXR5IGFzIHdlbGwuDQoNCg0KPiANCj4gPiBSb3VnaGx5IHNwZWFraW5nLCBDQUFNIGtl
eSBibG9icyBhcmUgc2VjdXJlIHVzaW5nIGEga2V5IGRlcml2ZWQgZnJvbQ0KPiA+IHRoZSBkZXZp
Y2XigJlzIG1hc3RlciBrZXkuIFRoaXMgbWFzdGVyIGtleSBjYW4gYmUgcHJvZ3JhbW1lZCB2aWEg
ZUZVU0VzLg0KPiA+IFNvIHlvdeKAmWQgaGF2ZSB0byBidXJuIHRoZSBzYW1lIG1hc3RlciBrZXkg
b24gYm90aCBTb0NzIGFuZCBpdCBzaG91bGQNCj4gPiB3b3JrLg0KPiA+DQo+ID4gSW4gYW55IHdh
eSwgY2hlY2sgdGhlIHNlY3VyaXR5IHJlZmVyZW5jZSBtYW51YWwgZm9yIHlvdXIgU29DLiBJdA0K
PiA+IHNob3VsZCBleHBsYWluIHRoaXMgaW4gbW9yZSBkZXRhaWwuDQo=

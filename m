Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A5522F1E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiEKJR3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiEKJRK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 05:17:10 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20080.outbound.protection.outlook.com [40.107.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7301C5EBD8;
        Wed, 11 May 2022 02:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaBfZm7NoIM/d11InIQ+vWJXOV9K+qBZHqCBlDcy4AxjFXPwn9rR22g2XC93zprinIEJhX8DtJ64Tp8/p1eSLqnJ1JdTBOjYJpJw2O6JM0brapYWr21mJJO2OEyhbVQLX/Ya2m3s9Tw5ehdlyfE2n8ZRrdP6pXp6HM9CrKTiY8fsNR+a3UG5K6ZD1gwlAo9nKfYmioN0LFvIrrzVlObOO0Ok7fgF0Q7wlkWo2SX980GPYCh4lhvOQ5azk9UEglzJmX/804RVLIJmCd11ACSEFcboFmZMROxPx5nM6YVi7WvB3F11i9zBmH/H5Mhhvaac1MLp355djXUI1K5oh3wX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecGj0Wzday1OZHRx3U12Wb/KmsHKwp7qfRhlmF8aBCg=;
 b=O60s6x924mZpPPCzTIbaEN/l+kTUqvzNMbRiJQEMWb2atNVDGCPLVzNy1Y+2ODWz0MBUtaRbIbgws13kIUTm1vFOsnKv4cbAWml3cxM/SARgeFgBi2ADPBRDHdcQ86QokkeGniAl8HNkJ5O5sVIm5RAhqDhjUtgelMzJPFhc1THDOHlANWVPxItk+zvwNg4xu5cv33kxVdsLN55gX2wVUydWdhW777ZpZ3WW8LSurY2uswD03R3jxbKifgYconaNs30eu9x65izPuoASFhrRgbHKPW60HY40JwMzJlladtx3ZQVQxLgFxp0vFDKd2iwYzW/e/uxrtA+sy8RC2nh8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecGj0Wzday1OZHRx3U12Wb/KmsHKwp7qfRhlmF8aBCg=;
 b=WNHNLGx/8RspWkYYDVs9diZ18z74GqLXjUf7FylnDaRDdQWDlCIpmIAmnctqJvW5qZzYgepcZ7j4IZ7rBbyLXv5M0hfjg6hAQB5w92DJZqL3+JE/FjOchIAaQv+wIIMIiU+WK8/qXeOpDt5BY/vT2fTOJICCeQmNUSnyvRdOx1Y=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 09:16:55 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::b454:80f3:ce2c:6fbc]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::b454:80f3:ce2c:6fbc%4]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 09:16:55 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Michael Walle <michael@walle.cc>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [EXT] [PATCH v9 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Thread-Topic: [EXT] [PATCH v9 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Thread-Index: AQHYYRI97Pupc5Ww9UOAxVboSwK5L60WgJwggAAH1wCAAuOogA==
Date:   Wed, 11 May 2022 09:16:55 +0000
Message-ID: <DU2PR04MB8630A6F925454E5C007FA3EA95C89@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
         <20220506062553.1068296-4-a.fatoum@pengutronix.de>
         <DU2PR04MB8630501008F661C596C0106295C69@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <5e7c0b3c9bc285f1cf9f7b20f055aa376e1688cc.camel@pengutronix.de>
In-Reply-To: <5e7c0b3c9bc285f1cf9f7b20f055aa376e1688cc.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efb53979-30d8-4151-060a-08da332efe6f
x-ms-traffictypediagnostic: PAXPR04MB8286:EE_
x-microsoft-antispam-prvs: <PAXPR04MB8286A698173B77C9E991F9D795C89@PAXPR04MB8286.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: So4EBMlvN4QiMbMEwxg6/BFxBqS4gjCmOnqtFfVwj1iYJvSjgaVP855C6a2JlayYjfvMdPu9FAisVzGvO5EsuujZfNXcRXGGSmvJBvh9ewJniCJ/JeVc6+8ty1Xutv/WCvDJksxup3qT2Uv93IenTCtZ1WCiBp/cLdkeEarPdcAfeU3CPowIGTPwX60uwTViFJK4epRedM8fMs7QxT8UfxpemcLe1dJnQW1oFmCw8Vwf7e1vsuqn6vqPm1Qwe5Pg5Zv6nvSbfx0VGGZ/mE4d2Cc1VEG7dj6i228JsOl7AabOyamdgVhjooGOHrWGM4VAEPQP6nU4rFdG7RRIvBm1CRKrzq5QCiiu7qwEE/PtE/zqBP21lvuGHOCWkQ8e5xoB0KG2oQ2fmpuZTkSjdnFrrdXMELHQC3Rlai5I40XWSyDhFQZQEMC+Bs6/2KtGk7FYQTgq5cUkV6R3zFnprxfPgf6uczcQH4PUJlikbuuWrjdx4Xix9oUrmlRXCM38c9l0ePn10C+TvQMjXNcqNTkEKZE+VMmYPT/eUjXS43l8YWAUrXrZv7jg4IhHHYYijlXxCwHoIHboGEpYPG+ntLfTEHXc20zmu37JAWxNfsdm1J81pM+y5vD0RWJ/2XCPwlIY8/+UDvcVQ5RKAMCzQdJcTGG9SSFfJfcea+K++FK7atVPNnqQU/WhD4vqTQ+ZF93qb9F3N3Wp0HBp41ztM7BPXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(4326008)(9686003)(64756008)(66446008)(66476007)(66556008)(76116006)(2906002)(83380400001)(8676002)(5660300002)(52536014)(8936002)(33656002)(186003)(7416002)(508600001)(66946007)(110136005)(53546011)(54906003)(6506007)(122000001)(55016003)(316002)(38100700002)(38070700005)(26005)(7696005)(86362001)(55236004)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0NGSU12c0dpZFJ3c3ltaXlSUW5Cb2tuMmJzeGx6bW0rMWtueERtNit0WVBS?=
 =?utf-8?B?Z0RXTGliamNRKzltSTZZeDlwK3Z6RTJaYmhGaUdLMDlNWWRQaW5ZWVkyc0RI?=
 =?utf-8?B?MUlITzk4cmJTbFQ5R29xNWhwNlFTM2R0cFZieVJpU2w5MnZQWTluSW9mc0I1?=
 =?utf-8?B?OVR5bWk3SHRMcStjVGJ3ZmNsN2I0SXIzbWZodmlRbEM0VWt4RGtjM2JucENM?=
 =?utf-8?B?Y3MxVDlMR0NkcjRKeUQvRWVseFBabERuU3RyaVFBdGR2SG5yRkFrdXA0S09x?=
 =?utf-8?B?ODZCaEpqWm5QMThLZlFteEV4UEdlNjlRcyswN3FYSEhzME5uSEk5S3dNNzR1?=
 =?utf-8?B?czJCTE5qWUtwTmNKMDF0QnRSUVlVcmk3VmZkQklkNkoxNTIrYVZkQ2Q0QTht?=
 =?utf-8?B?aDdBcFpyYk0wWW56anFKd2h5SktwWllyZDFsd1ZmRzQ3TXk0L2V0bEJJVzhz?=
 =?utf-8?B?SmpEZDdjYnpqdmhRL0VXeVNzaEdTMHFJZzVCSkhwRmpVYzkrdEJneDM4QnVs?=
 =?utf-8?B?cW1KUGtGWFRnT2Q0Y2RqZ2NoZDQ2aFF0MHFhcEJ4QkttS3NFWjFkaGNWeDJn?=
 =?utf-8?B?c0d4bUZLTnZqMmM3MEcwd0tJclJrZGpjb21oK3VHaWlCTnNNcEJCa2tHSUho?=
 =?utf-8?B?b2gwbnRhdXNaMzg4QWJLRFFjb3dta005Y2I3Nm5RYkNpZUNxVnlwd2NCM3Bt?=
 =?utf-8?B?VFhyOGlaNVhuQUMxRUkvWUxqWHlDM1cxaVl2b3AyZy9tUllXRGtoM0c5TlBN?=
 =?utf-8?B?bFZsRkpld3NvR0ZhUUdMS2tsZHAzRFFlaDJUMG1IN1p6MXh1VWcwQVhyWlov?=
 =?utf-8?B?dnh1Myt0Q1g5WkZRSWZsVk9Bek1OMEtsZzN4LzkwR0NHMVo3Y0Y2Vy9Ueldh?=
 =?utf-8?B?aUdhOXRvTmRIVkpqSFFpTVA4TGJJalphKzJzRitvZFo5ME1TOTIxTm8yQ04y?=
 =?utf-8?B?YTRFVk9qaEJCQ1UxM3hHdjh6dU1DSVB3dnFjQ3IvRm05cmU5eHlua0RQMzJ4?=
 =?utf-8?B?YzJ6dXp4bnhXQmVjT3U5N3FCWlJvcHdoTU4yeWdLV1NSSFpISml5WUtkc2hm?=
 =?utf-8?B?YjYySG1kNGxnV3VVeWZCOWVEUlU0c3hrS1lRRVExYk1vUmhZWmM2cVhxUXFP?=
 =?utf-8?B?cXBoc0N3V0lWSXJtcm5hQnZyZ29ueUY0RlAzbFdZM3RCdTduQlIwZ2JvaFlC?=
 =?utf-8?B?RlVoeW9SZkZJc3F0WTFFdXYxRUdMZUF0OENjNDFqclFadXJGdjZ5emFNc3kr?=
 =?utf-8?B?R1JnQU1NNURVakwxTWFrbnl0NncxRVV3Nm95V2tOSnorR3o4cUFwbFRqcWJT?=
 =?utf-8?B?V3BoS3JRcHkrNTVFc09uYlNxYXlUSk9VZ3RpSEowUjVIZmdDbEswd0F5YXFX?=
 =?utf-8?B?d2RWVGNyV1QxRGFDOUhTbXVxUFhjaVkyTDBXM1UrQTg5SVZheGdvc1ZwQ0Nu?=
 =?utf-8?B?YkJPSzdndHEzYW54aVJLSEQ4ejlrbTI1UnJWaVZKaDlaNEh1R0UrL0hWR0Z6?=
 =?utf-8?B?L1U3d2Q2STZkakQ2SWFZM0hhWnJHN1hhTzMyMVVPMzFHU2kxZUNlQVJYdkd6?=
 =?utf-8?B?Zm16c0NHVXl0anJtVFpBbU50VzBuZjJFVnF6VXV6Z0JtSUhhMEdzTWxzbXd4?=
 =?utf-8?B?RFZLOHovbVpHdG9mZXZBaFIzdVEzSit1c1ZnQUMyU3VoK1pkWEp1VjZYRVY0?=
 =?utf-8?B?M3RTdmI4dWNERFE3YXFyRUZaalBxNDB3WkdWQ3ptNWNoMHkvRXg5L3QvaUNp?=
 =?utf-8?B?anUrazdYYzg0OUdCbGpxQnJLTzByRkRaVjg4MVdQOHBwUmwwckNrZ0VvYkFa?=
 =?utf-8?B?TkxDczJzamNXYVhpWktNUGZrUFRSckJsYmxaV3ZsQitYVFhQdE8vaVJSS2Jp?=
 =?utf-8?B?bDRhbjNadVdVTHl4YnFpTzdGbFhvSU1ybHhMaGJXR2Q4ZGNpOTdXQjh3YnJU?=
 =?utf-8?B?ZTEyaXd4S3c5KzBoWHZjVnJqZHhrUmxTU055TDA0RDY0USswUXZFQklWaGUr?=
 =?utf-8?B?ekRxc29hL3FZZjN2cGZZSlhuQzlxQVAwR1U5WEp1clMvQ3BaL1dZTVV5cGdz?=
 =?utf-8?B?eVEyWEdPRFc0THBPOUliVXh1Z2NRZzQra21OZXRUb2lUMXhxK0ZqcklmeHNL?=
 =?utf-8?B?Z0hObGFqVXMyZzQxL3RRN1drSzVEbE0ySTQ3OWZiVDhxVmNHeExrSllIK0Np?=
 =?utf-8?B?eS84enRCY3hHUk1hVWd6endLbmFQT2IySms3My84Tis4M20wUE1CMjNyRmhv?=
 =?utf-8?B?MURWY2pxdEFmNE91ZDNqc1ExZE8yNmdLNGZIVEpxOWNTR1d6WkljKzFxL1hk?=
 =?utf-8?B?QklvTXYvNHN0YVQ5TzBYSkNXQnNFNEFZajIyZHJ6NkdoNzRQTkVBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb53979-30d8-4151-060a-08da332efe6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 09:16:55.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgcHocwHUYYYpW0ql79rbzwkpV2D+Lla+Ot4IcZ4SG7LI83tbThmGtCSBXRWWqk1j/XCgs9mCkeyycfOr0s/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgQWhtYWQsDQoNCkNvbW1lbnRzIGluLWxpbmUuDQoNClJlZ2FyZHMNClBhbmthag0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFobWFkIEZhdG91bSA8YS5mYXRvdW1A
cGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDksIDIwMjIgNjozNCBQTQ0KPiBU
bzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT47IEhvcmlhIEdlYW50YQ0KPiA8
aG9yaWEuZ2VhbnRhQG54cC5jb20+OyBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5v
cmcuYXU+OyBEYXZpZCBTLg0KPiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+IENjOiBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+OyBK
YW1lcw0KPiBCb3R0b21sZXkgPGplamJAbGludXguaWJtLmNvbT47IEphcmtrbyBTYWtraW5lbiA8
amFya2tvQGtlcm5lbC5vcmc+OyBNaW1pDQo+IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPjsg
RGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT47IEphbWVzDQo+IE1vcnJpcyA8am1v
cnJpc0BuYW1laS5vcmc+OyBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+OyBTZXJn
ZSBFLg0KPiBIYWxseW4gPHNlcmdlQGhhbGx5bi5jb20+OyBKYW4gTHVlYmJlIDxqLmx1ZWJiZUBw
ZW5ndXRyb25peC5kZT47IERhdmlkIEdzdGlyDQo+IDxkYXZpZEBzaWdtYS1zdGFyLmF0PjsgUmlj
aGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47IEZyYW5jaw0KPiBMZW5vcm1hbmQgPGZy
YW5jay5sZW5vcm1hbmRAbnhwLmNvbT47IE1hdHRoaWFzIFNjaGlmZmVyDQo+IDxtYXR0aGlhcy5z
Y2hpZmZlckBldy50cS1ncm91cC5jb20+OyBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxpbmFyby5v
cmc+Ow0KPiBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBrZXlyaW5nc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBjcnlwdG9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW0VYVF0gW1BBVENIIHY5IDMvN10gY3J5cHRvOiBjYWFtIC0gZGV0
ZXJtaW5lIHdoZXRoZXIgQ0FBTQ0KPiBzdXBwb3J0cyBibG9iIGVuY2FwL2RlY2FwDQo+IA0KPiBD
YXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IEhlbGxvIFBhbmthaiwNCj4gDQo+IE9uIE1vbiwgMjAy
Mi0wNS0wOSBhdCAxMjozOSArMDAwMCwgUGFua2FqIEd1cHRhIHdyb3RlOg0KPiA+ID4gLSAgICAg
ICBpZiAoY3RybHByaXYtPmVyYSA8IDEwKQ0KPiA+ID4gKyAgICAgICBjb21wX3BhcmFtcyA9IHJk
X3JlZzMyKCZjdHJsLT5wZXJmbW9uLmNvbXBfcGFybXNfbHMpOw0KPiA+ID4gKyAgICAgICBjdHJs
cHJpdi0+YmxvYl9wcmVzZW50ID0gISEoY29tcF9wYXJhbXMgJiBDVFBSX0xTX0JMT0IpOw0KPiA+
ID4gKw0KPiA+ID4gKyAgICAgICBpZiAoY3RybHByaXYtPmVyYSA8IDEwKSB7DQo+ID4gPiAgICAg
ICAgICAgICAgICAgcm5nX3ZpZCA9IChyZF9yZWczMigmY3RybC0+cGVyZm1vbi5jaGFfaWRfbHMp
ICYNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIENIQV9JRF9MU19STkdfTUFTSykg
Pj4NCj4gPiA+IENIQV9JRF9MU19STkdfU0hJRlQ7DQo+ID4NCj4gPiBDaGVjayBmb3IgQUVTIENI
QXMgZm9yIEVyYSA8IDEwLCBzaG91bGQgYmUgYWRkZWQuDQo+IA0KPiBEbyBJIG5lZWQgdGhpcz8g
SSBvbmx5IGRvIHRoaXMgY2hlY2sgZm9yIEVyYSA+PSAxMCwgYmVjYXVzZSBhcHBhcmVudGx5IHRo
ZXJlIGFyZQ0KPiBMYXllcnNjYXBlIG5vbi1FIHByb2Nlc3NvcnMgdGhhdCBpbmRpY2F0ZSBCTE9C
IHN1cHBvcnQgdmlhIENUUFJfTFNfQkxPQiwgYnV0DQo+IGZhaWwgYXQgcnVudGltZS4gQXJlIHRo
ZXJlIGFueSBFcmEgPCAxMCBTb0NzIHRoYXQgYXJlIHNpbWlsYXJseSBicm9rZW4/DQo+IA0KDQpG
b3Igbm9uLUUgdmFyaWFudHMsIGl0IG1pZ2h0IGhhcHBlbiB0aGF0IEJsb2IgcHJvdG9jb2wgaXMg
ZW5hYmxlZCwgYnV0IG51bWJlciBvZiBBRVMgQ0hBIGFyZSB6ZXJvLg0KSWYgdGhlIG91dHB1dCBv
ZiBiZWxvdyBleHByZXNzaW9uIGlzID4gMCwgdGhlbiBvbmx5IGJsb2JfcHJlc2VudCBzaG91bGQg
YmUgbWFya2VkIHByZXNlbnQgb3IgdHJ1ZS4NCkZvciBlcmEgPiAxMCwgeW91IGhhbmRsZWQuIEJ1
dCBmb3IgZXJhIDwgMTAsIHBsZWFzZSBhZGQgdGhlIGJlbG93IGNvZGUuDQoJDQoocmRfcmVnMzIo
JnByaXYtPmN0cmwtPnBlcmZtb24uY2hhX251bV9scykgJg0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQ0hBX0lEX0xTX0FFU19NQVNLKSA+PiBDSEFfSURfTFNfQUVTX1NISUZUOw0KDQo+IENo
ZWVycywNCj4gQWhtYWQNCg0K

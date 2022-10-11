Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3305FB0EC
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Oct 2022 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJKLFz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Oct 2022 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJKLFx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Oct 2022 07:05:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796B4199A;
        Tue, 11 Oct 2022 04:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMAE0+GLkrLiWDaW/QaW2dAGgytxsHodnlZ4//NzyAPz9qsrhNMQctbbHwPiLzsjgDzuaafyyItjRyb2Dxgl9Zw8zuhXgLOxnD+ZKky9igNHRzPBc9o3Ho65HQOuGQyvBnnpNDCoF7boHITLQLw9S3tsUGFS59Tmo12+JjNAAwKFImZ/4z0j4NyThoI3BEC0pgQs9MusUtb7VVrAXsRExbJw45qxuCs1HGR7kM2i+uX3iWs2UA1kE3WbBNntTfoYZaGedSK1T6MWPrXeWjpsFfnYM2S0VUJErmtKoA+UtYTUU+Bm04C+iXOWQk1BX0piXwLHrFoqtytQqfCHupjWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92F3UWI9Tlrj8w2+5dVQX6OqfTvgIKkLvmhLnt1pErc=;
 b=T6Rko0JDRJSTMmMQn1fCkw/Xq3PKhKSGZHAbd3zkV2pO4Z0SBhWNgbKPY7heTDG94WBYaGBoEqiMdeET0tH+atEgztC0yGCOFZpR6yubSu++LPJsraJssfGJRFiGbbGE2ZWQCYAtZoWxzQ3MoG9QMCzjL1ukeILSSr8LZLd22WoViJ5HQfkTbxccqcVZmFfgRc3h52RgNgDVkBf9PHFPqiWGitMe+MhPME4v1pxKSSoMlzFL4MLR8BHD+KhUG2v8eoDqyMfyzhgTvZFQuXevW2shPqivmMF6Dl7m1iqvXL8tSvZdtkwjNmVLpU0hvIHKC9+R/4dBQWT0S7dsmrl64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92F3UWI9Tlrj8w2+5dVQX6OqfTvgIKkLvmhLnt1pErc=;
 b=CCavAtjPVVcm/o9dC8/wN6/aRI5G24sENkmShkWFyMFgiNiU3pHnFjEWLUIqLubwr1ft503oqNMRy57BKRG1de7luIXxqJBvOBc6FAjFk34YY05dkQfALXKStB3pj7hi1yXADsx+K2GxwDFN36dvtwE0I9sDrXYx5XkIWkhOQrk=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 11:05:49 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%9]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 11:05:49 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "gilad@benyossef.com" <gilad@benyossef.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
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
Subject: RE: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Thread-Topic: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Thread-Index: AQHY2XuZ7wDJr0j14EOJG/A0UWusR64CgW+AgAT+i0CAAENoAIAA+wXg
Date:   Tue, 11 Oct 2022 11:05:49 +0000
Message-ID: <DU2PR04MB8630FBA525FB560E3604447195239@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
In-Reply-To: <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AM7PR04MB7062:EE_
x-ms-office365-filtering-correlation-id: 950a92f7-f3c6-4826-6c50-08daab788e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTWGeHw+9cFnPD/nYX9ThS29r046C4DrE91AEIkm9pyt1EqspLD6LAO064jMkYs7zbd7yEYpdeVu4dOyMlQpf6Z08AJFrM5QzRSw4LU5YNc41ynsNfy4gu4R/NDzd154f5G4Hvo6EmmvIOtCASsoYfYucW9EJXmfkG2Cv34ZHroBlrTNsEEScww2G4CBhCSaS4yEE9O0UZHUu5p6F1Tzwc1Q2C3Vsgoy3AbYTQtwPs2sn8Z+uWsS7FjJ8mgWzWDYlfCw4nY5d3QlVVYvMpB24sOAS2snSMG3k/m6Ts8sruczy9yrp1jP3ebU5M+qkYMR2NmiwSOIIVG7cPvwsf0/3qYgNkhfDcwWUoD63mizmwcQUMprEuw4p+r6f31f6Wdik59VDB7+DJIfGFOX0tyocBfFVN6yTz2m2BiZPrN75lomLTwsvmn/SBTMQzvurPVXo/bVtVHveJEhUHDme1Ru55GqtpoIAP3zLLTfmI+mGGdIo1rqI/um3H1Ku7VwO45+XykyQjdJavO6iBRF5y2CKcyQo4i+VjdciGOp6rX+K8km0YnVOMKuZWGTFBYjXatGnD3Jy+hs4uUSNo+fHKcVcHpT5ue60jy2lH+0GAhBqPH2FQdZh2GEh0wvEPctPTTyHVJ5XMj27eCUnf42iH4sJIiX9mQUFoIZbDrUz/uxhBiQv6BzUVaKfX2xMszUt2Hem0PH4+nnJlN7N0Z5KfLA/8tr2LJzVNYYYPwgtLq8/PHengTJcK+1MX8c5TVofCmsFJJMKh1xYjzwvR1GPkqfRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(186003)(83380400001)(38070700005)(122000001)(38100700002)(7416002)(5660300002)(2906002)(44832011)(41300700001)(4326008)(8936002)(52536014)(55016003)(478600001)(9686003)(26005)(6506007)(7696005)(55236004)(53546011)(8676002)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(54906003)(71200400001)(33656002)(86362001)(66899015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDBjZENpSzdOQlZ5bWRtSkZON3RJMmp4c0E4Qjc0cytVK3FvL2wzYzIrSGdj?=
 =?utf-8?B?aGV6alBiMEZoQ3NRT2hTSEJHRS9TT2RDUkpaZTJhWStzTUNCNnkrdE05RWhT?=
 =?utf-8?B?eTZTcVZHYlI4eVRyM0tLMnhoYjNOUUVYRXRlRC9GRm0yTlA0T25zNHI3SnVh?=
 =?utf-8?B?bm1rVkhjREZwSWM1WkJabFhOeVlraTRpSkxVR1p3MGZqM01WVjh1Z3VDMWdn?=
 =?utf-8?B?NWJXaW1rU0RxaUpreFZmLzhUdkRjTE5JLzZpWGtDQ2x6QjRIYjVEYmhNSW9Y?=
 =?utf-8?B?SmNUNzFpZVBtSUlxWmhuMS9qUk1ETWlueFhwUVJ3TWgxSTNLOGFUenVrdjRm?=
 =?utf-8?B?U2p4Rk5pbUR1UnBwR0hzWU9NZ1VYNW1la1RPL1lUYWlOM1FmdUpYR0RkRitn?=
 =?utf-8?B?REtRQTlGd3MwamlabUhvV0c5cnZGdWgwVklWR2g5cWJWbWg1RTE3bGZsOTBz?=
 =?utf-8?B?Uzg3R3o5UlBkY0xabnJPcXVLQ1FzK3ZvTktJZVlSNXJhdEI5SVNsVXIwVEJS?=
 =?utf-8?B?Vjdpc2NrVjlVTUVlMlZWVmRCSE5abGk0bFZCcHdDckhFWnNBSWlhSy9zNUI3?=
 =?utf-8?B?ekUwM3owMlZsNi9zMVJ2RG1jZXIvaTU4T2JZbktTWllGckMwcmdiclhFWTVp?=
 =?utf-8?B?eStpUVpVM011TmJYcURKeDNBRVFUVFU4aDdlMTZOWnVvUy9RaUJJelZsYnU1?=
 =?utf-8?B?c2tpeGQ5SVNSQzdhYlRmL2lKMm9hT3B4cjlRMzdwK29ZYkQwdGpNVEx3SWtv?=
 =?utf-8?B?UkdBdys3OXRLZmx5NWRub1BWNlI4SjR4aVVDUWlZenhLcjlpUnNGUU8xSWRX?=
 =?utf-8?B?U0xEMjZqaEVaaDRISzFIUGRvWVhuR3lvYlJPMmRnNnp0VUFUWUpJWXFqSG1T?=
 =?utf-8?B?dWE2cmpZUVFaV3FYVVdBRGNuUlAwdUNoTGs3NmY5YmYzWThlNjZSY2RBeVU2?=
 =?utf-8?B?R2V4b3V4bGtwZHNXcXFXaFhxNkdzL2kzbDVxT2dOQkpPaDVTYXBkMkZ1TnV5?=
 =?utf-8?B?UjVPQys0SDVxQjNKSUgvc3NVcE55QTUvMVBWcXdjaDc1UG54bU15NzFXVDZv?=
 =?utf-8?B?dE9GSzgvUEpPMDFDRUtEL1M4N0xveHoxT2lIcVY2Q09xd1I2d3dLTVc0Q0tv?=
 =?utf-8?B?SUFEbXpVLzdLam9VOVc3OEh2NlJsYW5Xblg4b2FkNXQ0eU4rL2lqTzdmRXlV?=
 =?utf-8?B?d1NDSDdrMzJqYUFhMEhidFV0bjNOVTdpUkFzQUdZTlN4VlFYeUlqaDhEaXVQ?=
 =?utf-8?B?SDY1VGhxWW9VcWU3VzcyUUcyZmJNMVQrTHdrWXNReGd5eFJvQytZVWJ0ejcx?=
 =?utf-8?B?ZElLbzVoUEJSMVJ5UDdhY3RaZjV5T1pVVmZDVjU3MnBNWmpLWHY2eUpoM29B?=
 =?utf-8?B?ek1XT096UThtMkZQdkpQTXh0aWtNZTVqcjFqL2lhZnhablQrVTkzRWcxdUpE?=
 =?utf-8?B?bXl0WmVDbWdyWW9MVjQzejFqQ1RKZ3UrUzBWVDhJaUY3UGxKYnVweUw3UVk1?=
 =?utf-8?B?czNUSHpnQjFlMHY5SjdWU1o4NTYzRG9QWlBSYkxjNUkyV2RqdGpyakFqRUtG?=
 =?utf-8?B?Zmd1eUNyZEJTL3RDTWtEelFkY25PbnVaRVRSVjVoS3RzVDhoVkVleUtmdmVF?=
 =?utf-8?B?TWU0cEUzT253dUtoQWVoQ0N6ZXVLckU5ZURnQU9odktSVGxiMXZ1YXNLOHQy?=
 =?utf-8?B?YU4xMXBRT1lsNmJuUmZoTHY0bWhoZ2hJek4wcXNVTFhCdXRqWWJ1NDYrSU5Y?=
 =?utf-8?B?bSt6SStnY3RXakxUb2pvaVFjdlZkK1g3NFhZbEcvdEVweVdCU1h2YWJMNXhZ?=
 =?utf-8?B?bzFoT0FtUDFZQzlkS3FPa1B1b2tqcTdRblJNbkVmMVoreXo0cDBiRHhVUlFo?=
 =?utf-8?B?Rmt6SVNlTW93T3l6aHI5MkN6MFFEdkcrUkdkQWJuek82Tkh6bzBvLzQrcXM0?=
 =?utf-8?B?dW9MSWRGdXZPckFYRGJmN1V1SGV0eHI1TjBSNEFXZHhtdjlhdVllVEpGbkJS?=
 =?utf-8?B?YVJYaUJYbGVMeEltbGZ2dTlJTk96N05jVkQrUnNrRTJyRnpYVGhjY1o3QlVW?=
 =?utf-8?B?WXdMMGVrN0ErUENiaUxNZ0tsSGdqSlkxTnNRemtOeVVjNWY2ZkR0c3hyKzhq?=
 =?utf-8?Q?eptCTwfHFhnhSLq4FOABgAgqi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950a92f7-f3c6-4826-6c50-08daab788e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 11:05:49.3638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQMnlazpwzz6Vk432xldIs4QCl5gXFP72aPzGaGgdzQRiLof42bu+u9IYuEP/gIrXnw9KwAxXrGSd/9k03sLNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBBLiBEb25lbmZlbGQg
PEphc29uQHp4MmM0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDEwLCAyMDIyIDg6NDYg
UE0NCj4gVG86IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+IENjOiAnSGVy
YmVydCBYdScgPGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT47IGphcmtrb0BrZXJuZWwub3Jn
Ow0KPiBhLmZhdG91bUBwZW5ndXRyb25peC5kZTsgZ2lsYWRAYmVueW9zc2VmLmNvbTsgamVqYkBs
aW51eC5pYm0uY29tOw0KPiB6b2hhckBsaW51eC5pYm0uY29tOyBkaG93ZWxsc0ByZWRoYXQuY29t
OyBzdW1pdC5nYXJnQGxpbmFyby5vcmc7DQo+IGRhdmlkQHNpZ21hLXN0YXIuYXQ7IG1pY2hhZWxA
d2FsbGUuY2M7IGpvaG4uZXJuYmVyZ0BhY3RpYS5zZTsNCj4gam1vcnJpc0BuYW1laS5vcmc7IHNl
cmdlQGhhbGx5bi5jb207IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGoubHVlYmJlQHBlbmd1dHJv
bml4LmRlOyBlYmlnZ2Vyc0BrZXJuZWwub3JnOyByaWNoYXJkQG5vZC5hdDsNCj4ga2V5cmluZ3NA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
aW50ZWdyaXR5QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtc2VjdXJpdHktDQo+IG1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc7IFNhaGlsIE1hbGhvdHJh
IDxzYWhpbC5tYWxob3RyYUBueHAuY29tPjsgS3NoaXRpeg0KPiBWYXJzaG5leSA8a3NoaXRpei52
YXJzaG5leUBueHAuY29tPjsgSG9yaWEgR2VhbnRhDQo+IDxob3JpYS5nZWFudGFAbnhwLmNvbT47
IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTog
W1BBVENIIHYwIDMvOF0gY3J5cHRvOiBoYmsgZmxhZ3MgJiBpbmZvIGFkZGVkIHRvIHRoZQ0KPiB0
Zm0NCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gTW9uLCBPY3QgMTAsIDIwMjIg
YXQgMTE6MTU6MDBBTSArMDAwMCwgUGFua2FqIEd1cHRhIHdyb3RlOg0KPiA+ID4gTmFjay4gIFlv
dSBzdGlsbCBoYXZlIG5vdCBwcm92aWRlZCBhIGNvbnZpbmNpbmcgYXJndW1lbnQgd2h5IHRoaXMg
aXMNCj4gPiA+IG5lY2Vzc2FyeSBzaW5jZSB0aGVyZSBhcmUgcGxlbnR5IG9mIGV4aXN0aW5nIGRy
aXZlcnMgaW4gdGhlIGtlcm5lbA0KPiA+ID4gYWxyZWFkeSBwcm92aWRpbmcgc2ltaWxhciBmZWF0
dXJlcy4NCj4gPiA+DQo+ID4gQ0FBTSBpcyB1c2VkIGFzIGEgdHJ1c3RlZCBzb3VyY2UgZm9yIHRy
dXN0ZWQga2V5cmluZy4gQ0FBTSBjYW4gZXhwb3NlDQo+ID4gdGhlc2Uga2V5cyBlaXRoZXIgYXMg
cGxhaW4ga2V5IG9yIEhCSyhoYXJkd2FyZSBib3VuZCBrZXktIG1hbmFnZWQgYnkNCj4gPiB0aGUg
aGFyZHdhcmUgb25seSBhbmQgbmV2ZXIgdmlzaWJsZSBpbiBwbGFpbiBvdXRzaWRlIG9mIGhhcmR3
YXJlKS4NCj4gPg0KPiA+IFRodXMsIEtleXMgdGhhdCBhcmUgaW5zaWRlIENBQU0tYmFja2VkLXRy
dXN0ZWQta2V5cmluZywgY2FuIGVpdGhlciBiZQ0KPiA+IHBsYWluIGtleSBvciBIQksuIFNvIHRo
ZSB0cnVzdGVkLWtleS1wYXlsb2FkIHJlcXVpcmVzIGFkZGl0aW9uYWwgZmxhZw0KPiA+ICYgaW5m
byhrZXktZW5jcnlwdGlvbi1wcm90b2NvbCkgIHRvIGhlbHAgZGlmZmVyZW50aWF0ZSBpdCBmcm9t
IGVhY2gNCj4gPiBvdGhlci4gTm93IHdoZW4gQ0FBTSB0cnVzdGVkLWtleSBpcyBwcmVzZW50ZWQg
dG8gdGhlIGtlcm5lbCBjcnlwdG8NCj4gPiBmcmFtZXdvcmssIHRoZSBhZGRpdGlvbmFsIGluZm9y
bWF0aW9uIGFzc29jaWF0ZWQgd2l0aCB0aGUga2V5LCBuZWVkcw0KPiA+IHRvIGJlIHBhc3NlZCB0
byB0aGUgaGFyZHdhcmUgZHJpdmVyLiBDdXJyZW50bHkgdGhlIGtlcm5lbCBrZXlyaW5nIGFuZA0K
PiA+IGtlcm5lbCBjcnlwdG8gZnJhbWV3b3JrcyBhcmUgYXNzb2NpYXRlZCBmb3IgcGxhaW4ga2V5
LCBidXQgY29tcGxldGVseQ0KPiA+IGRpcy1hc3NvY2lhdGVkIGZvciBIQksuIFRoaXMgcGF0Y2gg
YWRkcmVzc2VzIHRoaXMgcHJvYmxlbS4NCj4gPg0KPiA+IFNpbWlsYXIgY2FwYWJpbGl0aWVzICh0
cnVzdGVkIHNvdXJjZSksIGFyZSB0aGVyZSBpbiBvdGhlciBjcnlwdG8NCj4gPiBhY2NlbGVyYXRv
cnMgb24gTlhQIFNvQyhzKS4gSGF2aW5nIGhhcmR3YXJlIHNwZWNpZmljIGNyeXB0byBhbGdvcml0
aG0NCj4gPiBuYW1lLCBkb2VzIG5vdCBzZWVtcyB0byBiZSBhIHNjYWxhYmxlIHNvbHV0aW9uLg0K
PiANCj4gRG8geW91IG1lYW4gdG8gc2F5IHRoYXQgb3RoZXIgZHJpdmVycyB0aGF0IHVzZSBoYXJk
d2FyZS1iYWNrZWQga2V5cyBkbyBzbw0KPiBieSBzZXR0aW5nICJjcmFfbmFtZSIgdG8gc29tZXRo
aW5nIHBhcnRpY3VsYXI/IA0KDQpZZXMuDQoNCj4gTGlrZSBpbnN0ZWFkIG9mICJhZXMiDQo+IGl0
J2QgYmUgImFlcy1idXQtc3BlY2lhbC1mb3ItdGhpcy1kcml2ZXIiPw0KDQpGb3IgZXhhbXBsZTog
QVJNLUNyeXB0by1DZWxsIHByZXBlbmRzICdwJzoNCi0geHRzKHBhZXMpIGZvciB4dHMoYWVzKQ0K
LSB4dHMocGFlcykgZm9yIHh0cyhhZXMpLi4uZXRjLg0KDQogPiBJZiBzbywgdGhhdCB3b3VsZCBz
ZWVtIHRvIGJyZWFrIHRoZQ0KPiBkZXNpZ24gb2YgdGhlIGNyeXB0byBBUEkuIFdoaWNoIGRyaXZl
ciBkaWQgeW91IHNlZSB0aGF0IGRvZXMgdGhpcz8gIE9yIHBlcmhhcHMsDQo+IG1vcmUgZ2VuZXJh
bGx5LCB3aGF0IGFyZSB0aGUgZHJpdmVycyB0aGF0IEhlcmJlcnQgaXMgdGFsa2luZyBhYm91dCB3
aGVuIGhlDQo+IG1lbnRpb25zIHRoZSAicGxlbnR5IG9mIGV4aXN0aW5nIGRyaXZlcnMiIHRoYXQg
YWxyZWFkeSBkbyB0aGlzPw0KSSBjb3VsZCBmaW5kIHRoaXMgZHJpdmVyICIgZHJpdmVycy9jcnlw
dG8vY2NyZWUvIi4NClJlZmVyZW5jZSBmaWxlIG5hbWUgaXMgIiBkcml2ZXJzL2NyeXB0by9jY3Jl
ZS9jY19jaXBoZXIuYyINCg0KTGlrZXdpc2UsIENBQU0gYmVpbmcgYSB0cnVzdCBzb3VyY2UsIG5l
dyBjcmFfbmFtZSB3b3VsZCBiZSBuZWVkIHRvIGRlYWwgd2l0aCBDQUFNIGdlbmVyYXRlZCBIQktz
IHRvby4NCldlIG5lZWQgdG8gY29tZSB1cCB3aXRoIHNvbWV0aGluZyB1bmlxdWUgbGlrZTogZm9y
IGVnOiAgIHAoeHRzKGFlcykpIGZvciB4dHMoYWVzKSAgICAgICAgICAgICANCiAgIA0KQW5vdGhl
ciB0cnVzdCBzb3VyY2UgZnJvbSBOWFAgY2FsbGVkIERDUChkcml2ZXJzL2NyeXB0by9teHMtZGNw
LmMpLCAgbmV3IGNyYV9uYW1lIHdvdWxkIGJlIG5lZWRlZCBmb3IgdGhhdCB0b28uDQpUaGVyZSBh
cmUgd29yayBpbiBwcm9ncmVzcyBmb3Igb3RoZXIgdHJ1c3Qgc291cmNlcyBmcm9tIE5YUC4NCg0K
U28sIG91ciBhcHByb2FjaCBpcyB0b28gcHJvdmlkZSBnZW5lcmljIHNvbHV0aW9uLCB3aGljaCBj
YW4gYmUgZXh0ZW5kZWQgdG8gYW55IHRydXN0IHNvdXJjZSBnZW5lcmF0aW5nIEhCSy4NCg0KDQo+
IA0KPiBKYXNvbg0K

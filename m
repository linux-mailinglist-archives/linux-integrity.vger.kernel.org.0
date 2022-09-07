Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A195AFD67
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIGHYE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiIGHXg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 03:23:36 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00057.outbound.protection.outlook.com [40.107.0.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D5A3D60;
        Wed,  7 Sep 2022 00:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfaBpH9VbFfW59r2r/RIdrJ2EWjHOOPQtWS2GeRk0Ym3Msc1NsDWAt9WUjjv/X0fPP4IFFnUm6FxsdBm5RtJayJK8YLnAsA1C0WETilTo2CrI/u3at+5EqdHcmLxlWe7uyyMO2uidg7lEtKjYY7rLnh6ZvLzlpH1JuntXNpbrPoml9PnQOs4zrBPEFeEM5sztNG17r2qX7CSiw6uoTSBPW737xVnuVGfIXlfQt0HJxGrz2rUF9+asIwENIg5puUg28ZA1OIbzA2zri/CV1vr/Cjch6xMLFiSL/6ncwFdkzc5Eaz64WVfKNZ7DmY6jqFNRa05AbjE48icS4V07PzzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q51xkMU2xZdscoSdRRo2ts7Cpf3iORJrb+7e1VcGIDU=;
 b=Z/v1M8YxZwfQXd9Wzl6paKk3DbnE5FCucfyDWQcZdQZry91o6gCod5aL8o72QufeU69up7sqCkxSr+orXmaxxrZupCuy3IkYCG2PR2qsVkHh4ts/QFfoHqTIA7q21K6cC2q4B+LCF3xE1Kv1IXAbJvBhQnIrvDDfzdrt32X/rIn1uhSWt16H6q3FlXviyxUNj5lLizg4f9W1X3SP+st454+7yB/UVsO7b9vhq+A+c5nTggD6fe3nDpJ8Mo888dMjZSYFKofj7eIJIkxBvNbBmzzaTPNGXdI1t0WKqRysXaZsAVCbbvgLB8gTMEh+7ikv21o/gcNFbL2v1Mllvv9jeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q51xkMU2xZdscoSdRRo2ts7Cpf3iORJrb+7e1VcGIDU=;
 b=YrcaaIUQ4x9M2XGBSw15BLI0AyuRxOu0eHsBmasjLOZRHWmnBZPc0hiK7TNcLCSeZUUi9ed7gQyPwc/dr3ty0i7qhyKNohRY0T0X4ihAIyOyZRyXqJit1UnXVeir1mmodYViOzbqLz5F4s34ftolA/73qm0js6mMcoCHICfe9v4=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB4004.eurprd04.prod.outlook.com (2603:10a6:208:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 07:22:54 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 07:22:54 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Ben Boeckel <me@benboeckel.net>
CC:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
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
Subject: RE: [EXT] Re: [RFC PATCH HBK: 6/8] KEYS: trusted: caam based black
 key
Thread-Topic: [EXT] Re: [RFC PATCH HBK: 6/8] KEYS: trusted: caam based black
 key
Thread-Index: AQHYwbSjtnl6fBsJbkWAX6YiRgMGJK3SXssAgAELEsA=
Date:   Wed, 7 Sep 2022 07:22:54 +0000
Message-ID: <DU2PR04MB8630B4F61AA0F28825D482D695419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-7-pankaj.gupta@nxp.com> <YxdFNIYcD1QO7mtC@farprobe>
In-Reply-To: <YxdFNIYcD1QO7mtC@farprobe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AM0PR04MB4004:EE_
x-ms-office365-filtering-correlation-id: 5644ed72-8b8a-453e-df74-08da90a1c7cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oX19BHrVh72zLyEVOeGX7sXDC/3PbZb5vEteE7KPOqKJLRk4QJKxp+wPf2UQmjyfj5BDwwMZu7sx8ugMyVvnDAAt4vnQi/9nRgSd4/PoLOwN6ptpq8LVtZSxi2GJF6rDkkQiizHtowKAMHTZgGXjSh88y5JbRNxw4+IZ5gLzXHOyWQGWU8puvhL+Ni0hNci5MSJbGZfrN7nIrG3DTFn/5JBFTPsBMpFj75tcj4kW6tKXXZytFijgMkISUq85Q1zQPAg7TYvkYFrBfjnykV57uJvymjD0y39xMh4i2VY7m804h/sBlJlJgb6BDIDGVrFZilFajE4qRWOudj9sY9JIp6fHE8Oo6lclS4cTE5rrwcah8Mq7xiYAoUCjUAeWNm8aiDaCfvdZo/jOl22xb53ESzC1P1oEpqU2ENL/X0hY438VL0Fqt+Kb5/GW2lgTo62U0OiWNSBGrp9RScxKdWjVzeAsNRjqkBwqgF+2SRbyP3dm+ltZL+ZizX5e48PyZ5Tw6vRsGnJ5LKJq2MyrLM1ETQhYYFMtQXLIHFvWbMAtF93sZs93WtYV2kSz55A8U+TbyoExme17Aa8jvAl+htn9fs3wQJaU/+Y/G8waiQXzntNvMMXlAFcW3U80KSSjwzbqdwFyWHpv7uFKxLgvmAT8N5QJ1+mtmIbYOYlYqOS2oPUiiChR4esA+GD13NeBWCU5W4/ZGsJyjoOOQ5VKI22FQluWaLVZCaaxVWKjDSXuqlNm3xMWO+FzTS8gUHYbEKzqyb1A8exq2G12JZMNsE1/+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(26005)(7696005)(478600001)(8676002)(9686003)(6506007)(66556008)(66446008)(66946007)(55016003)(64756008)(66476007)(2906002)(86362001)(316002)(38070700005)(33656002)(4326008)(54906003)(6916009)(71200400001)(41300700001)(53546011)(55236004)(38100700002)(122000001)(76116006)(186003)(5660300002)(44832011)(7416002)(52536014)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXZ5KzJCZXhzdDE1M3dnclg1MmJOSHJVdU04Q21Na1RSOTRGMWQvaUZ4UW4y?=
 =?utf-8?B?bW1mdGw0WENuc1dEMVBOd3RKSm53cWRWN1ZzWUxIUXZwT01tcndGSUltSmtR?=
 =?utf-8?B?eVpUcHlEdXdSeTdPMm5IUHQySTlzTURsVFVtUDRDWGdHU1F0cnNqNTlmR0dh?=
 =?utf-8?B?Vnd5Y3RoUlpqMnovWXhnVWlDL0x2bUFneGZ2SFF4YmNDRWZvMFRsT3o0V0dU?=
 =?utf-8?B?U1dKOWc3elRxOGJXckJrV1FmZ0lQZHlTY09WV0xpYS96RWd3V3d0eEJVUjcx?=
 =?utf-8?B?c1ZaSzJRc21DdFRLNXdPd2VXMGNWaVNseCt0SlQwd2cyTVBFZlo1UjRxMXVY?=
 =?utf-8?B?cVlCTWNBbE1xL1FIT3J0SmZRNHVSWThWci9SaUxXYUNpZTRQTXkweS80K0hq?=
 =?utf-8?B?TUpWamJhSWxIbFJ3M3RUWFFudFNnVFVPSWlFTmUzSWF5Nm14M2ZDMEdFOVJv?=
 =?utf-8?B?d2lHRno1dUUzNlBWem1CeVFUYVV4SXNwN3o0dXZQSnQyY0h0S1RQMEJreFNL?=
 =?utf-8?B?R1Z6TFczOTVKTGxySUo5di9uZ21GS3pNRVpDREdlaGlaZEx6UFNYbW9rRHhV?=
 =?utf-8?B?QXRpOGlQOGFNazNtcjdCS2k2NjRQOEZ0TEFMSWs1a2V6TXRnN08wdnExMUxr?=
 =?utf-8?B?MTNjRzhGclAxY211azMwMTJGc1V6dmFSQzJhZzMvb2F4Q1pTdkNTNzZQZUVo?=
 =?utf-8?B?YXJIU0FqUHN6cTk2UmlUendoUSsrRnpaeEVKVE5EOUZ1UnI0cHFGUm8wNksx?=
 =?utf-8?B?QmEwSmRpNi8vdVpWTjZOOC9KZDZxenMwdzM0VEwwejUwM0RWU21hQUZBTm9v?=
 =?utf-8?B?a0t1L0sxSWdyTnFQVHVPWWp6MkZ3Sm9xcXEwM1R1VnpTNlp5OURKNG9rd1JN?=
 =?utf-8?B?dVJEc2JsK1BIMTIrT0tSdnNpS3YyRGhNMThHQy9KMUVxZTI5ZWk0UDdPRWNV?=
 =?utf-8?B?UUZib1c5SjVoT0hKWU1rY1ZhVkxCbHJRUzZONzQ2THZPQU1OK0ZaNURXWFVa?=
 =?utf-8?B?VVEwYjlRb2JKZnJpK3E0NWhpU1VHQ2VEdi9qSU1TalpZb1FxczhDQ3ZGMStV?=
 =?utf-8?B?eUJoNnFsdENZUWNZUEVQanpobFJ3VWc5NDBjTWNjRU0zYjh1V3NpdWFvVHFt?=
 =?utf-8?B?cDZQYVpGTmY2Qnpzd3RwR2gyZ2hJL2tYcG4ySjE0SW5idVVUUGxkTDM2K1ZP?=
 =?utf-8?B?bENxU1grN05JZDZnRmJzZXN1VEY4WS9nYTFKc2pBNmFDeUo0TnArYjZCbDhw?=
 =?utf-8?B?OGxGSDVFZlZOK3ZNcmsrOFU4MVI2citSUnJ5bXR0UzhsRjlmTmNYb0VVbVZS?=
 =?utf-8?B?b2o0eGM5bnBaUjFNSjB4SHA3ajVXazNtbUZpZ1VtVklmQ0VieUFmQlJtK0Vn?=
 =?utf-8?B?WWlRNHFibVJrNGd3L1VPRjZLV2ZmWExWRFhEU0xWWlc1Uzl4azIzZk8xVE9y?=
 =?utf-8?B?MGJ5S09TeVVyenRCNHpsOXdnNllnV3Fxa1BrbGNBWkxFenR6VkV3VTJCTDho?=
 =?utf-8?B?clNWUTRBWTJPNlk5dmE5K2tUK3c2clprQ2ZnVWdtL2VFMDhkT2dGckF1TDFF?=
 =?utf-8?B?Z2QzLzVncmFJRm1xQzJNOWlrYnNZM3RLV0U2VG51elc1YUhyZU8vTE53K25O?=
 =?utf-8?B?TENZLzdHWDAycXJjdGJSanZqckhuNzFiZk1TaWFiblhmb01aWjk3dWNWeVpI?=
 =?utf-8?B?djZjaXd0UVhFQjRtdUF4NXUwUmwvNFlTUVVKTHhHdE1qaUpZbXVDbUJvQXp2?=
 =?utf-8?B?eFFGSkdHeko2TG5id2tGVkdoemJzdmhXUmY0Zzg1RU5nTGJsRFA2QzArY2hI?=
 =?utf-8?B?M2wvYTk5WXNYbHRlZk5MOTBReFI3czlhWGpSK0UwZkRGbWZ1ZjFEQzM1aFVP?=
 =?utf-8?B?WFJ3bWxLWDJJMzBUOHV5NmpLU3ZXRU1rbFFTQkFldnB2b3Y5MkJxM25JRkFW?=
 =?utf-8?B?WkVMWnc1S0ZCMDVYdW1RSlh4ajQxWXFrRElTU01OZW52czhrSHFzdktVMTds?=
 =?utf-8?B?RDN6Y01UQkJSWnVPVG9sRnNmTnNSQzhXMWxuT0hTeVRKQVdSV1NtZXkzOHhr?=
 =?utf-8?B?VWtzVExyQkxnUVZFWk9NdkFTMmppT1NhMHRNWkVydG9TWDRadEN4OUdrU0VL?=
 =?utf-8?Q?U0t+YyV6jBtuoog8u+ENQSBcr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5644ed72-8b8a-453e-df74-08da90a1c7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:22:54.1883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CS+WygM/78hmOdgcw6t6Wgcl2fm5DIT3hvAYW09hyuso6oyER2Nq5c4j3Vdg1tA/Psc8VSvm6J/DuxiEWphEhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuIEJvZWNrZWwgPG1l
QGJlbmJvZWNrZWwubmV0Pg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgNiwgMjAyMiA2OjM0
IFBNDQo+IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPg0KPiBDYzogamFy
a2tvQGtlcm5lbC5vcmc7IGEuZmF0b3VtQHBlbmd1dHJvbml4LmRlOyBKYXNvbkB6eDJjNC5jb207
DQo+IGplamJAbGludXguaWJtLmNvbTsgem9oYXJAbGludXguaWJtLmNvbTsgZGhvd2VsbHNAcmVk
aGF0LmNvbTsNCj4gc3VtaXQuZ2FyZ0BsaW5hcm8ub3JnOyBkYXZpZEBzaWdtYS1zdGFyLmF0OyBt
aWNoYWVsQHdhbGxlLmNjOw0KPiBqb2huLmVybmJlcmdAYWN0aWEuc2U7IGptb3JyaXNAbmFtZWku
b3JnOyBzZXJnZUBoYWxseW4uY29tOw0KPiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGoubHVlYmJlQHBlbmd1dHJvbml4LmRlOyBlYmlnZ2Vyc0Br
ZXJuZWwub3JnOyByaWNoYXJkQG5vZC5hdDsNCj4ga2V5cmluZ3NAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaW50ZWdyaXR5QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc2VjdXJpdHktDQo+
IG1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc7IFNhaGlsIE1hbGhvdHJhIDxzYWhpbC5tYWxob3RyYUBu
eHAuY29tPjsgS3NoaXRpeg0KPiBWYXJzaG5leSA8a3NoaXRpei52YXJzaG5leUBueHAuY29tPjsg
SG9yaWEgR2VhbnRhDQo+IDxob3JpYS5nZWFudGFAbnhwLmNvbT47IFZhcnVuIFNldGhpIDxWLlNl
dGhpQG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUkZDIFBBVENIIEhCSzogNi84XSBL
RVlTOiB0cnVzdGVkOiBjYWFtIGJhc2VkIGJsYWNrIGtleQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVt
YWlsDQo+IA0KPiBPbiBUdWUsIFNlcCAwNiwgMjAyMiBhdCAxMjoyMTo1NSArMDUzMCwgUGFua2Fq
IEd1cHRhIHdyb3RlOg0KPiA+IC0gQ0FBTSBzdXBwb3J0cyB0d28gdHlwZXMgb2YgYmxhY2sga2V5
czoNCj4gDQo+IFdoYXQgaXMgYSAiYmxhY2sga2V5Ij8NClRoaXMgbmVlZHMgdG8gYmUgY2hhbmdl
ZCB0byBIYXJkd2FyZSBCb3VuZCAgS2V5Lg0KDQpCbGFjayBLZXkgaXMgTlhQIHRlcm1pbm9sb2d5
IGZvciBIYXJkd2FyZSBCb3VuZCBLZXkuDQoNCj4gDQo+ID4gICAtLSBQbGFpbiBrZXkgZW5jcnlw
dGVkIHdpdGggRUNCDQo+ID4gICAtLSBQbGFpbiBrZXkgZW5jcnlwdGVkIHdpdGggQ0NNDQo+ID4g
ICBOb3RlOiBEdWUgdG8gcm9idXN0bmVzcywgZGVmYXVsdCBlbmN5dHB0aW9uIHVzZWQgZm9yIGJs
YWNrIGtleSBpcyBDQ00uDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
Xl5eXl5eXl5eDQo+IA0KPiAiZW5jcnlwdGlvbiINCg0KQWNjZXB0ZWQNCg0KPiANCj4gPiAtIEEg
YmxhY2sga2V5IGJsb2IgaXMgZ2VuZXJhdGVkLCBhbmQgYWRkZWQgdG8gdHJ1c3RlZCBrZXkgcGF5
bG9hZC4NCj4gDQo+IE1pc3NpbmcgInRoZSIgYmVmb3JlICJ0cnVzdGVkIi4NCj4gDQpBY2NlcHRl
ZA0KPiAtLUJlbg0K

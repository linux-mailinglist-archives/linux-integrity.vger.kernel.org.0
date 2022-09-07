Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFE5AFD5F
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 09:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIGHXi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 03:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiIGHW6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 03:22:58 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00057.outbound.protection.outlook.com [40.107.0.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A763B93203;
        Wed,  7 Sep 2022 00:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD/cCYgtaSuUotg9ED0aSTLg4k64H0Mizgv/di7rVquNVCRO1UcwRS3EV/gV6D87tOMnDVkclEKztoBE6sJ+Z1AO67a+zPyI8hMZcoAvXDIH9PKmY8Ek5W5kMvTXkgoeRa3Z+bpLPZnDxlp9R7IgGNtxPSjiOFF+JscK6T5LNug3hZRBUCVe16OMRxzPkwCJA2jNas4spRbNXIGS3Cx3ZZMaorQlVVH87SgxjVpNzKcKwqITS70kW/dtvBajEO+u2PdVIAfMjuIE/LR9PzMtcNjBoeGaxCVqwGO7TCnmR9mY34PUn8S0X3RCCCQnPnnJuvot9AfiwSlVDfpqgYmiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGEngVSajdJES1azJnz3w+jN8sVuJaknVg+VxzsPVPA=;
 b=gWdJfBxe8aGPVPd8aZs7Km8zHyDOdy6JJX7gtFxlhtmg9QFQpKPDb+XEzVF4uU1pCb10ID4xQIcarbnpSRKdel1kkXNri5/A+XRWT09BTILYu0qqb6a/ZNiFp7C/fcm3ACjBVI4Fk0U3pbFLDB/65+lutN9/w7OJc/AhPg8fcI6+HUFmLb1GkgGNRl0zxvw35g2BDZQTQ3WpS7i9YEtI4iFn8xgdakgsZijHlC9wkhvUVcQUbC1mXt6a/DIkSsk6kjP7Xa7LY6oy+kgpNy/lP9unCT15GF1b96sgv06sH+FmZqhmTEDIvjwc0fvlBMY+6d6jRlsFu8ueWHhuTaWWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGEngVSajdJES1azJnz3w+jN8sVuJaknVg+VxzsPVPA=;
 b=E/oQA9mDPezpOo3JJ6rKVGnoll7SZkg8gsiO1se5Nxz9Zfbqd4ZPftzJEVl+zxCjBqh7Es4q+N/nP7E8fflzIbKNn3KJu6v8yCs0WNdMlV6BZ0KMdbUbt9TuCT9dpBP52I3KGl2WYB0stPAZ9hKCEUxSCxwoQQ7Km3SNGuQNGuA=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB4004.eurprd04.prod.outlook.com (2603:10a6:208:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 07:22:51 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 07:22:51 +0000
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
Subject: RE: [EXT] Re: [RFC PATCH HBK: 1/8] keys-trusted: new cmd line option
 added
Thread-Topic: [EXT] Re: [RFC PATCH HBK: 1/8] keys-trusted: new cmd line option
 added
Thread-Index: AQHYwbSNAtpw9J7uC0SCoRsXRS49W63SXi4AgAEi/nA=
Date:   Wed, 7 Sep 2022 07:22:51 +0000
Message-ID: <DU2PR04MB86303F82A10F5989DE0A0F7395419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-2-pankaj.gupta@nxp.com> <YxdEsCmQIwi7VSuv@farprobe>
In-Reply-To: <YxdEsCmQIwi7VSuv@farprobe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AM0PR04MB4004:EE_
x-ms-office365-filtering-correlation-id: 924ad0e6-9588-4648-5776-08da90a1c625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CTAFLazIAWCboY+9eBlesnTipPc+zQNQB4s+RgIKcoLDis8KCChhEYO2IJfPeeEBWEKjFr90wmh0XUAP/Zu11USECEiywlC8WxWZVHZ8wJ1sBWpfWSgGnrffZKRo872aAD1xQqWKwhYUVZGk34Hz7Cc/gxdz7Gac0LgBp1QV3Ub950Mmi3CoFGmJTL7Y7guIXER3TvppWqKeUSdVRtQAtaJQBtA0DQaPhnyGnjmP/jBbmT9slbAYWTCvZ/H9+aeKC9USmxZ3JJtBCEqimWpSGGvfJgUFLgQoZnFTjVgWvZtwNlIHkoi5tg5hbIHt14oBBE0DRn4cicU/LkMzsGDbr7G+WRxVesBw1uZd7zfOeSCossTwiMuFGnSFKN7OBFzAY8t/dGmlXhjjrm3WdZYQzJqt0eyhKpv2Lnvvbw6SWm59+p4IfPiNUoNTpu4JzEydcfk0n6eVLSouxOv5CJd9xFdtp3RQ6+oaKoh13/rcpFuvnjqu16bhSF+zFkxeh/dlNwBp4Vd9hq8T/MKpZ7OqE7zDQJMUUYg1zJWHHZlM7/VCOCgo7iudpDrTvxjESrGEJDIF2ZUwr0ss/VfGI5P20c2Xxdypj1qxc3jRlvVNCbbHLnctjBM9iNVVzJD0oeQpptMbsRyDthTSMw7WXXi9rpeE9vXHywPoL5aUNzw+CYPpzI6w/suggHOzTOLFXDfAfHm/ezCyWrOEyzEIbiHFXJXmXz50N8LWwrRFCcL/Ywa5QBWzuMX2e89AS7XiUsS3XQFagCCLkty/y3Hb+ISGHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(26005)(7696005)(478600001)(8676002)(9686003)(6506007)(66556008)(66446008)(66946007)(55016003)(64756008)(66476007)(2906002)(86362001)(316002)(38070700005)(33656002)(4326008)(54906003)(6916009)(71200400001)(41300700001)(53546011)(55236004)(38100700002)(122000001)(76116006)(186003)(5660300002)(44832011)(7416002)(52536014)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0NDTC83aWdZZG5Qem1wRTFXNnZDdWZZbG9Ua0dtMllSODBvMlBnOWZ2NFE0?=
 =?utf-8?B?cENMRklob3ROblV6OTVmZE40bVhERmMwTEF4VmJVQ3JnRUZxWXNVNldpbWdj?=
 =?utf-8?B?d0xlb3NabmpYVzkrR3RGb01lZ3NNY0pSd25vMk5rUzNQTzhUWW1rYzZYMU5w?=
 =?utf-8?B?TExCOGZaMy9YQjJpK2d6TzNJTnV2ZmVUVEVCSnovODdiTTAvWFppMlkwVmhO?=
 =?utf-8?B?dWtQbmdJc0l0Z1R1RWZqQ2xOOGZJdWs2M2toejZ0QVlmenU2bm5tMTFNUjRP?=
 =?utf-8?B?QnVzMXFoWDZnRDZBQTZPY3pORGRNTzlJSHVGZE9JSjVzTTYxQWVFU1FxYzNx?=
 =?utf-8?B?RXp5SDA4RE5HNy9XcU1Fa3RTUTB0NlFrZlAvVHRXcGFmcXVTODVoYUhjSTBV?=
 =?utf-8?B?WFJlZnl6b21hWVNSL081MHl4MlVla0h5dGhPZGo4Zkx6TmxKYStrdytSOG1k?=
 =?utf-8?B?MFNCVDNndFpBUVJqVzVHL1NiVzcybEtvOWUxVXlDbGs5SEhKMVh1MkMrTEVY?=
 =?utf-8?B?dGZNQktXMy91N2Z5ZFBsbFI0MGdqcitHMXhUVHYwNUMrQzhqdFdiVitBZHBv?=
 =?utf-8?B?V2QxSjRzd0R3T0VQTFJTcXBXaUkzaERQYXNwL2FtSjdzRFpDKytpeHZuakJL?=
 =?utf-8?B?eGdWLzY2UGIvckpxVXZibTJuN1ZVSzZZdCtDMVhaVnJaWSt1bmJhdTNUQUla?=
 =?utf-8?B?d0FOdFBzL1Z6K1AxQjA5REtmNkFMa24yTEpCZlRpZWlDZVIxWWgwRk4yNXRB?=
 =?utf-8?B?Qmc5WXppbE8wSFp0eWJRcGNUZHhpSDZYMzdoYXZ4eHp6MThNLzU3K0lZdVQw?=
 =?utf-8?B?SG5PZzlIR0trdnhIc0pFamplWWo5Vld3ZlRwdUxFQTd3Qkx3NnZCbTdycTJv?=
 =?utf-8?B?UVpiWVpCcW9ucEVXYTZnTXFSQytqQ3M1ejRpU2U2elg1NFFiamRKRk8yRTNN?=
 =?utf-8?B?TEdoZkFxY3E1aDR5ekxIdjg4QTlCblpWZ1lJc2Nrd1Jndm50d2hQMWY0OFNT?=
 =?utf-8?B?VEh4bG1qN0ZtSUt3V2cybzF3V2RUR2xZcUpUZ2dGSktPWC9uTWJ3RU8wbTB6?=
 =?utf-8?B?TCtBdTBacmxzQkw4VDFZN1FoN2RGVEFYQ0lxYkJ2c24rcmJKZ1Azck1UUHJT?=
 =?utf-8?B?c3lMbC9Qd2JGSmZFNmZ0bkZQcDRTUnZxQVlXNDFHTEFJNE9tWnQxakxaSEg5?=
 =?utf-8?B?TkxKdE1xWTZ5Mk5vSmo0ZGFvejEwTk9HMFdwOFdOSENUYlkwOWtCY2lBeU1a?=
 =?utf-8?B?c2JmVFNhcEFibVpUdjJlSEVaUVFXdDY1QkxoQWx1YmpIcWxpellSL29YamY1?=
 =?utf-8?B?anZUQ0FXcUsvVjFDdndYN2x5aHpSS0lJWEQyUWlVL1Voajc3a2VNd2RNekhV?=
 =?utf-8?B?cGZSdndTYzlnV29vVzFXcFFKRFA1azI1R3NnZS9KTlNHdU5mOEJYamJqZUJZ?=
 =?utf-8?B?VDBNR2JDSXJaZXMxdlNYaTU2bVo0V0dMcGp6TEROZThmNHlyM1BXcW9ybHo2?=
 =?utf-8?B?L2tmNno1ajhGQ3VCSkdSOTZFc2Q4VkpoSUt4STR4ZXA2RzVnZHJXRTEyb2tz?=
 =?utf-8?B?OU5QZ1ZGRXpMWWprNzdqdkVDbDBWMjdXbEFXZG53amprbVFVSTkzVVNabXRj?=
 =?utf-8?B?Unl5Qy9QMXpORmNrVklqSXRRRDdhZlNBQkQxVTArWEQrdkpQaXVNK1pSNXBQ?=
 =?utf-8?B?bFY1SmR0aFpERUUyU01sTHBxRWhPZWJzREhOKzhjTEVoMEpEU1RzcXdVZVlZ?=
 =?utf-8?B?MVlobE5RNkRWU2sraVhWSVIxbTArWm9LemZSejBNUHVtazB2bXR3U255MW0r?=
 =?utf-8?B?SC9TMTZ6UWV6ZktVWUNBYy82dWRjcEg5OHo4cml0d2ZJZ2gyc2hFMDJxc0di?=
 =?utf-8?B?WHg0WTJjUzUxaWgyZGNOMFVyZ2p5cVlpNkJuaG1PaGpWVWxsY1RlNmdwUm5D?=
 =?utf-8?B?aExDOTI2clBXZ3dZY1dmcit5RXNBVzc1M3dhbUJQMStEQzRsYU80TWNKdDdx?=
 =?utf-8?B?c3VjdTlYNWN1MVA3bEJNWHJ6Rm1tWDA5SW5WS0NjRVpzSjdGanQ0MWhjaEJa?=
 =?utf-8?B?NzV0eWxNUUVOOGlRbFo2cU4ybkduUXN2N1ZONWhnOTJWRTlwWGh4dmhodkpC?=
 =?utf-8?Q?Ic8JVzPuUPeXH58ehj9LIARkA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924ad0e6-9588-4648-5776-08da90a1c625
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:22:51.4660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mkc5o/E7uZehiV6xmIKhsgOeD9dG1LyNQ0erE8h+RUphnteKQrTGoWmJUSw3/gc0YvBiaR2TZ96x8zDYWYBJA==
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
QGJlbmJvZWNrZWwubmV0Pg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgNiwgMjAyMiA2OjMy
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
dGhpQG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUkZDIFBBVENIIEhCSzogMS84XSBr
ZXlzLXRydXN0ZWQ6IG5ldyBjbWQgbGluZSBvcHRpb24NCj4gYWRkZWQNCj4gDQo+IENhdXRpb246
IEVYVCBFbWFpbA0KPiANCj4gT24gVHVlLCBTZXAgMDYsIDIwMjIgYXQgMTI6MjE6NTAgKzA1MzAs
IFBhbmthaiBHdXB0YSB3cm90ZToNCj4gPiBUd28gY2hhbmdlcyBhcmUgZG9uZToNCj4gPiAtIG5l
dyBjbWQgbGluZSBvcHRpb24gImh3IiBuZWVkcyB0byBiZSBzdWZmaXgsIHRvIGdlbmVyYXRlIHRo
ZQ0KPiA+ICAgaHcgYm91bmQga2V5Lg0KPiA+ICAgZm9yIGV4Og0KPiA+ICAgICQ6PiBrZXljdGwg
YWRkIHRydXN0ZWQgPEtFWU5BTUU+ICduZXcgMzIgaHcnIEBzDQo+ID4gICAgJDo+IGtleWN0bCBh
ZGQgdHJ1c3RlZCA8S0VZTkFNRT4gJ2xvYWQgJChjYXQgPEtFWV9CTE9CX0ZJTEVfTkFNRT4pDQo+
ID4gaHcnIEBzDQo+ID4NCj4gPiAtIEZvciAibmV3IiwgZ2VuZXJhdGluZyB0aGUgaHcgYm91bmRl
ZCB0cnVzdGVkIGtleSwgdXBkYXRpbmcgdGhlIGlucHV0DQo+IGtleQ0KPiA+ICAgbGVuZ3RoIGFz
IHBhcnQgb2Ygc2VhbCBvcGVyYXRpb24gYXMgd2VsbC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1
ZGUva2V5cy90cnVzdGVkLXR5cGUuaCAgICAgICAgICAgICAgIHwgIDIgKysNCj4gPiAgc2VjdXJp
dHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF9jYWFtLmMgfCAgNiArKysrKysNCj4gPiBzZWN1
cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX2NvcmUuYyB8IDE0ICsrKysrKysrKysrKysr
DQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUva2V5cy90cnVzdGVkLXR5cGUuaCBiL2luY2x1ZGUva2V5cy90cnVzdGVk
LXR5cGUuaA0KPiA+IGluZGV4IDRlYjY0NTQ4YTc0Zi4uMDY0MjY2YjkzNmM3IDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUva2V5cy90cnVzdGVkLXR5cGUuaA0KPiA+ICsrKyBiL2luY2x1ZGUva2V5
cy90cnVzdGVkLXR5cGUuaA0KPiA+IEBAIC0yMiw2ICsyMiw3IEBADQo+ID4gICNkZWZpbmUgTUFY
X0JMT0JfU0laRSAgICAgICAgICAgICAgICAgICAgICAgIDUxMg0KPiA+ICAjZGVmaW5lIE1BWF9Q
Q1JJTkZPX1NJWkUgICAgICAgICAgICAgNjQNCj4gPiAgI2RlZmluZSBNQVhfRElHRVNUX1NJWkUg
ICAgICAgICAgICAgICAgICAgICAgNjQNCj4gPiArI2RlZmluZSBIV19CT1VORF9LRVkgICAgICAg
ICAgICAgICAgICAgIDENCj4gPg0KPiA+ICBzdHJ1Y3QgdHJ1c3RlZF9rZXlfcGF5bG9hZCB7DQo+
ID4gICAgICAgc3RydWN0IHJjdV9oZWFkIHJjdTsNCj4gPiBAQCAtMjksNiArMzAsNyBAQCBzdHJ1
Y3QgdHJ1c3RlZF9rZXlfcGF5bG9hZCB7DQo+ID4gICAgICAgdW5zaWduZWQgaW50IGJsb2JfbGVu
Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGNoYXIgbWlncmF0YWJsZTsNCj4gPiAgICAgICB1bnNpZ25l
ZCBjaGFyIG9sZF9mb3JtYXQ7DQo+ID4gKyAgICAgdW5zaWduZWQgY2hhciBpc19od19ib3VuZDsN
Cj4gPiAgICAgICB1bnNpZ25lZCBjaGFyIGtleVtNQVhfS0VZX1NJWkUgKyAxXTsNCj4gPiAgICAg
ICB1bnNpZ25lZCBjaGFyIGJsb2JbTUFYX0JMT0JfU0laRV07ICB9OyBkaWZmIC0tZ2l0DQo+ID4g
YS9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX2NhYW0uYw0KPiA+IGIvc2VjdXJp
dHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF9jYWFtLmMNCj4gPiBpbmRleCBlMzQxNWM1MjBj
MGEuLmZjZWI5YTI3MWM0ZCAxMDA2NDQNCj4gPiAtLS0gYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQt
a2V5cy90cnVzdGVkX2NhYW0uYw0KPiA+ICsrKyBiL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlz
L3RydXN0ZWRfY2FhbS5jDQo+ID4gQEAgLTEsNiArMSw3IEBADQo+ID4gIC8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gPiAgLyoNCj4gPiAgICogQ29weXJpZ2h0IChD
KSAyMDIxIFBlbmd1dHJvbml4LCBBaG1hZCBGYXRvdW0NCj4gPiA8a2VybmVsQHBlbmd1dHJvbml4
LmRlPg0KPiA+ICsgKiBDb3B5cmlnaHQgMjAyMiBOWFAsIFBhbmthaiBHdXB0YSA8cGFua2FqLmd1
cHRhQG54cC5jb20+DQo+ID4gICAqLw0KPiA+DQo+ID4gICNpbmNsdWRlIDxrZXlzL3RydXN0ZWRf
Y2FhbS5oPg0KPiA+IEBAIC0yMyw2ICsyNCw3IEBAIHN0YXRpYyBpbnQgdHJ1c3RlZF9jYWFtX3Nl
YWwoc3RydWN0DQo+IHRydXN0ZWRfa2V5X3BheWxvYWQgKnAsIGNoYXIgKmRhdGFibG9iKQ0KPiA+
ICAgICAgICAgICAgICAgLmlucHV0ICA9IHAtPmtleSwgIC5pbnB1dF9sZW4gICA9IHAtPmtleV9s
ZW4sDQo+ID4gICAgICAgICAgICAgICAub3V0cHV0ID0gcC0+YmxvYiwgLm91dHB1dF9sZW4gID0g
TUFYX0JMT0JfU0laRSwNCj4gPiAgICAgICAgICAgICAgIC5rZXlfbW9kID0gS0VZTU9ELCAua2V5
X21vZF9sZW4gPSBzaXplb2YoS0VZTU9EKSAtIDEsDQo+ID4gKyAgICAgICAgICAgICAuaXNfaHdf
Ym91bmQgPSBwLT5pc19od19ib3VuZCwNCj4gPiAgICAgICB9Ow0KPiA+DQo+ID4gICAgICAgcmV0
ID0gY2FhbV9lbmNhcF9ibG9iKGJsb2JpZmllciwgJmluZm8pOyBAQCAtMzAsNiArMzIsOSBAQA0K
PiA+IHN0YXRpYyBpbnQgdHJ1c3RlZF9jYWFtX3NlYWwoc3RydWN0IHRydXN0ZWRfa2V5X3BheWxv
YWQgKnAsIGNoYXINCj4gKmRhdGFibG9iKQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gPg0KPiA+ICAgICAgIHAtPmJsb2JfbGVuID0gaW5mby5vdXRwdXRfbGVuOw0KPiA+ICsgICAg
IGlmIChwLT5pc19od19ib3VuZCkNCj4gPiArICAgICAgICAgICAgIHAtPmtleV9sZW4gPSBpbmZv
LmlucHV0X2xlbjsNCj4gPiArDQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+
IEBAIC00MCw2ICs0NSw3IEBAIHN0YXRpYyBpbnQgdHJ1c3RlZF9jYWFtX3Vuc2VhbChzdHJ1Y3QN
Cj4gdHJ1c3RlZF9rZXlfcGF5bG9hZCAqcCwgY2hhciAqZGF0YWJsb2IpDQo+ID4gICAgICAgICAg
ICAgICAuaW5wdXQgICA9IHAtPmJsb2IsICAuaW5wdXRfbGVuICA9IHAtPmJsb2JfbGVuLA0KPiA+
ICAgICAgICAgICAgICAgLm91dHB1dCAgPSBwLT5rZXksICAgLm91dHB1dF9sZW4gPSBNQVhfS0VZ
X1NJWkUsDQo+ID4gICAgICAgICAgICAgICAua2V5X21vZCA9IEtFWU1PRCwgIC5rZXlfbW9kX2xl
biA9IHNpemVvZihLRVlNT0QpIC0gMSwNCj4gPiArICAgICAgICAgICAgIC5pc19od19ib3VuZCA9
IHAtPmlzX2h3X2JvdW5kLA0KPiA+ICAgICAgIH07DQo+ID4NCj4gPiAgICAgICByZXQgPSBjYWFt
X2RlY2FwX2Jsb2IoYmxvYmlmaWVyLCAmaW5mbyk7IGRpZmYgLS1naXQNCj4gPiBhL3NlY3VyaXR5
L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfY29yZS5jDQo+ID4gYi9zZWN1cml0eS9rZXlzL3Ry
dXN0ZWQta2V5cy90cnVzdGVkX2NvcmUuYw0KPiA+IGluZGV4IGM2ZmM1MGQ2NzIxNC4uN2Y3Y2My
NTUxYjkyIDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0
ZWRfY29yZS5jDQo+ID4gKysrIGIvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF9j
b3JlLmMNCj4gPiBAQCAtNzksNiArNzksOCBAQCBzdGF0aWMgaW50IGRhdGFibG9iX3BhcnNlKGNo
YXIgKipkYXRhYmxvYiwgc3RydWN0DQo+IHRydXN0ZWRfa2V5X3BheWxvYWQgKnApDQo+ID4gICAg
ICAgaW50IGtleV9jbWQ7DQo+ID4gICAgICAgY2hhciAqYzsNCj4gPg0KPiA+ICsgICAgIHAtPmlz
X2h3X2JvdW5kID0gIUhXX0JPVU5EX0tFWTsNCj4gDQo+IFRoaXMgc2VlbXPigKZiYWNrd2FyZHMg
dG8gbWUuDQo+DQpJbml0aWFsaXplZCBpdCB0byBiZSBhIHBsYWluIGtleSAmIG5vdCBhIEhXIGJv
dW5kZWQga2V5Lg0KIA0KPiA+IEBAIC05NCw2ICs5NiwxMiBAQCBzdGF0aWMgaW50IGRhdGFibG9i
X3BhcnNlKGNoYXIgKipkYXRhYmxvYiwgc3RydWN0DQo+IHRydXN0ZWRfa2V5X3BheWxvYWQgKnAp
DQo+ID4gICAgICAgICAgICAgICBpZiAocmV0IDwgMCB8fCBrZXlsZW4gPCBNSU5fS0VZX1NJWkUg
fHwga2V5bGVuID4gTUFYX0tFWV9TSVpFKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPiAgICAgICAgICAgICAgIHAtPmtleV9sZW4gPSBrZXlsZW47DQo+ID4g
KyAgICAgICAgICAgICAvKiBzZWNvbmQgYXJndW1lbnQgaXMgdG8gZGV0ZXJtaW5lIGlmIHRpZWQg
dG8gSFcgKi8NCj4gPiArICAgICAgICAgICAgIGMgPSBzdHJzZXAoZGF0YWJsb2IsICIgXHQiKTsN
Cj4gPiArICAgICAgICAgICAgIGlmIChjKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlm
IChzdHJjbXAoYywgImh3IikgPT0gMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwLT5pc19od19ib3VuZCA9IEhXX0JPVU5EX0tFWTsNCj4gPiArICAgICAgICAgICAgIH0NCj4g
DQo+IFVzZXJzcGFjZSBkb2N1bWVudGF0aW9uIGlzIG1pc3NpbmcgZm9yIHRoaXMgbmV3IGZpZWxk
LiBNdXN0IGl0IGFsd2F5cyBiZQ0KPiBzZWNvbmQgb3IgaXMgaXQgImFueSBmb2xsb3dpbmcgYXJn
dW1lbnQiPyBGb3IgZXhhbXBsZSwgbGV0J3Mgc2F5IHdlIGhhdmUNCj4gYW5vdGhlciBmbGFnIGxp
a2UgdGhpcyBmb3IgIkZJUFMiIChvciB3aGF0ZXZlcikuIEl0J2QgYmUgbmljZSBpZiB0aGVzZSBh
bGwgd29ya2VkOg0KPiANCj4gICAgICduZXcgMzIgZmlwcyBodycNCj4gICAgICduZXcgMzIgZmlw
cycNCj4gICAgICduZXcgMzIgaHcgZmlwcycNCj4gICAgICduZXcgMzIgaHcnDQo+IA0KV2lsbCBj
b25zaWRlciB0aGlzLCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggc2V0Lg0KDQo+
ID4gQEAgLTEwNyw2ICsxMTUsMTIgQEAgc3RhdGljIGludCBkYXRhYmxvYl9wYXJzZShjaGFyICoq
ZGF0YWJsb2IsIHN0cnVjdA0KPiB0cnVzdGVkX2tleV9wYXlsb2FkICpwKQ0KPiA+ICAgICAgICAg
ICAgICAgcmV0ID0gaGV4MmJpbihwLT5ibG9iLCBjLCBwLT5ibG9iX2xlbik7DQo+ID4gICAgICAg
ICAgICAgICBpZiAocmV0IDwgMCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+ID4gKyAgICAgICAgICAgICAvKiBzZWNvbmQgYXJndW1lbnQgaXMgdG8gZGV0ZXJt
aW5lIGlmIHRpZWQgdG8gSFcgKi8NCj4gPiArICAgICAgICAgICAgIGMgPSBzdHJzZXAoZGF0YWJs
b2IsICIgXHQiKTsNCj4gPiArICAgICAgICAgICAgIGlmIChjKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIGlmIChzdHJjbXAoYywgImh3IikgPT0gMCkNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBwLT5pc19od19ib3VuZCA9IEhXX0JPVU5EX0tFWTsNCj4gPiArICAgICAg
ICAgICAgIH0NCj4gDQo+IFNhbWUgaGVyZS4NCj4gDQo+IC0tQmVuDQo=

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C06BB85D
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Mar 2023 16:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjCOPrh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Mar 2023 11:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjCOPrg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Mar 2023 11:47:36 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E7B471;
        Wed, 15 Mar 2023 08:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKIkfHnHfZ2SzCZwRCPIGxb2qSyzfJ2Gs8/61JRLVb5b5EA2s1zMGMsTI3ED1BDBSPdF9O3SmD0j08Ok2zqXQpOPXSFG3+hqtgqysMm+YVDOry4QNLIfnR9lwgGdwS3yP9tItwgl2yKtwan3/UUjj6aSL6JCMwzUjjqUkiZNFmwDGB73GrxGc5+WD4BBG1iad914qBeWSSqAHxlcwyYTofT4H98mbYqDe2Dxum4VnG3mDZo4kL/WZkPFeTCT+nhTmWHoIHEB2hVYwBDfMpZNMknkckxfoZsZrYY6fZ6m4NMOKEvRBkBkVdGKoXMuIJphcmmd8L5LuuUNJhHdUEPTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVDCCqANAqdvMzRq/FubMasicKudqtb4q4wgoyn/PHM=;
 b=jtCgRtxVHq/9Y4WOJapbnkY5VPhYNtGLYTlSk0lAKQqgpC+7mBoUEugTU9QMcqlxgzJwz45R11YIatOq7xR3jrHZjxlXMgLfNeoTIORs0+QIlDs8Jr2yNbq5iCid+ZD8D9MtNXncfv+NB6hGBgNTfwOf1l8JMPbM9/l8t8TKZJEGcUfsdsOl58DYhqwngVoB5ENqMZXDtR4H2sWgfpMznkRzm7ZoddBV5dIRSigjzlhnAiDQn6l8pPBhH6dk0WrKh6oUw8MSOeqHGcAH54BavqMA5r+YUi2uYdg0pddx55lDXOnhnmUBuUM6EpTDbtyo54KfMBKnhR+YohvGr3pGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVDCCqANAqdvMzRq/FubMasicKudqtb4q4wgoyn/PHM=;
 b=QAEd/2gvIcgIhMql5xoYwEIxBNFLSYs07hbCSV2C9h7VqHtLWlFSYOqZ7edeheueJRx932gWrxCz4j5vW+lWfJnXK5tdLcbZr1ph4dyl8W7mDnWawoN6mryq9CPPBLPPbueiwMketkSRKTwRTZraJXj3NUxdRFSrXxvFIfnpYvWVXqrNryWArMfRNM39faioRHy6M2rN2mJ/iVTTfKxZUYcK50wD1uFILQOA88mmw01C9NNOmhc3LrdnzSz5hMn4OSGuiWEuKAur96cQHYOu5UNCBU4jWjM1QRr7NVkm3ockmj10OaRKrptDHCGLhu2f2DAyrCQ7MflB07t46YqRdA==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 15:47:33 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 15:47:33 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: RE: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Topic: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Index: AQHZTL4LmmU2weVzlkGZavw5z7vfj672LROAgAXjllA=
Date:   Wed, 15 Mar 2023 15:47:33 +0000
Message-ID: <DM4PR12MB576911FA514FAFEBE6B3A39FC3BF9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
         <20230302041804.24718-3-kyarlagadda@nvidia.com>
 <01959c869e01075705cd436afa822f2586d0509c.camel@kernel.org>
In-Reply-To: <01959c869e01075705cd436afa822f2586d0509c.camel@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|BL1PR12MB5350:EE_
x-ms-office365-filtering-correlation-id: b0bfdac7-a830-406d-ac5c-08db256c979e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+Fy00UxYLW7rHVCLt+N+L2OyjOcRx+fsy7iear3q8lofHLpjdkaExHfzp/kS7YSi3ymfQgf54jUbgyUxjJA1/qPJE3g58tWOZwHiK8ASSX1eMoj8INa+izppN+YTL12HK3rBI4nwFiwU4hHAU9Jz8i107Y36d3UX1WLIZum+roMvrepltTGHRgOANGzkIpPj8Ipjyb1IkfrwQVdnPDpzNbAk1TEap1GDytm/l5bpWtrKk63icm12fvnx2riYeG5t8bzo2+1/DSxBoL5TtgipPtDHBFB0J8WK32yh7NOf8yGWa7pV8RYMQ73BlPE0rTmS/n0MteoLF4UDtIOQML3JM0KlPjuDxBwexUjfjCe3CdfZ0sGlZjXaC3//3NI0W/kRk6bna2qJQOH+if2hK8ShtvvfdbVlKh4d2xjee0Hx3D1adOQXxGANHgmHR2z8tCM7unw5eTg7Iuj2Ke2zd+yucR/pc4k8sWW8sxgsTDjeDMIgbb+sjAH4HnhSVuVHn4HVIlvxqwLwB6/PH5R0HIM3Ys3+gTW1mbe9KLlt+eqZxCaiOngwDpjfa4QpafrU/wpHF2d+a11T35F5nTW9dURVwliYWh6/2EpxmfAmS952B3X87COSxW8/tQA4cnyMRlHi+82UYq2mWhDmHvRjyLGQtylQBP6qwJRE8dpxQUtcl7U1hEciNS9VLxtyr8b5zFRGoVjryRtuYQc85OBKvVOUolPrsQ5GcIQTP5rqMxcqXw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199018)(5660300002)(7416002)(83380400001)(66446008)(478600001)(66556008)(7696005)(26005)(107886003)(53546011)(71200400001)(6506007)(9686003)(186003)(921005)(38070700005)(76116006)(4326008)(66476007)(52536014)(64756008)(8676002)(55016003)(33656002)(8936002)(41300700001)(66946007)(86362001)(316002)(110136005)(54906003)(38100700002)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzN5S0Y0bitLekVWTkIvbTBSTWE0cUN2YjlVbjRNeTdVWVdoSnRvZXpkVW1K?=
 =?utf-8?B?QkxwMEpWaE5JY0xXZmd3YlErZ2kzR0QrL1NLcVlsYkNMdGZIK1h3eGhBdjlw?=
 =?utf-8?B?TXJ6bUFONDF4ckdUWEhNV0pkUmJQMFVHYSszZUtWbjl4NVFFUytoNjQwZ3FY?=
 =?utf-8?B?dUZ5VS9yYWgybG55WlVGanllZzVZWUMzVncvWXoyS3VIRmxnWk96bHdmN3Ux?=
 =?utf-8?B?KzdTYWJvMUs4WFovenh0RU9RZ295dVF6TlZvZU9OWmh6UVF1RmhhUzI0ZDdL?=
 =?utf-8?B?dHpabktMa0RvbnkvZTlrL3pzUlB4S1JzeG02V1pERHFqS1duS2RYdnE5M3NF?=
 =?utf-8?B?SGF2RmpYczhpZWNHVmFKdk9CL0g5SHMxRFZ4S3NyMkZoMG0yUjRxRmMxK0VH?=
 =?utf-8?B?ZEpRUEgvZFVKNzBFWWRpQVlETHY2aHRxZW5xZzB2K3RSOHg3bGo1MVFIYmZy?=
 =?utf-8?B?T1JmaDRhcWIzb3Z4V3RzcCtaeGhCbXJKbXFNbHh6aEgxMTBONzdxMXd3VUNr?=
 =?utf-8?B?eEZjL3BpLzUzUGoyelEzbEI1RXJlUGE2YURpVDZLWk1yRVI1K3orRUNPQXNn?=
 =?utf-8?B?alVuWmwxd0JGL3A0LzlYWkoxWUEyM3JXdTdFeURaWDFRd0NlbzB3QXdncWx1?=
 =?utf-8?B?Q0FNNzFSRWF5TUs4V0FndjFicXcrelFqZXM5akVDL3dlWnM0Y1IvOXhXUzc1?=
 =?utf-8?B?SDd4SURXZEJkQTh0UEprZWNuQ3M3MkE5ckpaTTJDY2tjTUxJUDZQZVoxdkFP?=
 =?utf-8?B?REpkVGRzUjhucndlb2xkNHVzc1FqVFZ2ZGNWVjZ4MWp2UnJPamJZU1lzWmxK?=
 =?utf-8?B?SENIS3pZYnVsMVNDcG4wUDNub2dkMzdDNGFlSkxYMm13eE9sNW5oZUdDc2d6?=
 =?utf-8?B?WnNRN2hZbEE3aUUvQVRnUG1OZWZJNXRzMFlENnhxalUxdzRlWVZZc212Zjcy?=
 =?utf-8?B?Y1dIdExFanZtYXZ0RmkrNDVmMzBJTnNKNjV3eE9ISGF2elQ2WTkyc2I4MmM4?=
 =?utf-8?B?cElST0F0bEhLU01kVFNpYldLbFEraGZBaWlkNEtkUmlFQTBFdkV5ZWljZzBp?=
 =?utf-8?B?S0QxY1kzWDBTNWY5a2tYczdFdW9ETVlOZjFNT1hNcWFNN01Lb1p3cGtNcnc5?=
 =?utf-8?B?Z0t5aDdEMlBlc1lQd0FDd2U2cnk4dGc0VkJZWTBwQnhxbjFaSUpTaTJpNlJk?=
 =?utf-8?B?RDhqazJzNk1tay81Qm1yR2s4dzA3emlGVnBMT1hWNStSblJ3VUpUKzlQYXY2?=
 =?utf-8?B?bG9vNkl2OFRtRXN2TkwvVWIvYlV5bjl5SS94MDBWcSt0UVdhU3Bnc2hKS01V?=
 =?utf-8?B?dm9yaVB2K1Y3THV0VXl0anBGSE5YKy9yQnRvdTFKaHBMZitLaEpSZHkvN3lk?=
 =?utf-8?B?Y2pxQnZnNlNDRHo2b2RPd2xzQmpKbnZzVERuZ1JNeGVvT1dhcWVaTzdJOXlP?=
 =?utf-8?B?MVNVODhJeUg3SGlZL2VpWHlLT1JYaTBLa0RWUEtHb0J1cGVVaEdROGlkNGNr?=
 =?utf-8?B?WFZ5VHBnQzQralhrV29oWDBFdUUwUjhsOG1TWFdCVjQzcURTNVNwOHRPKzJl?=
 =?utf-8?B?ZWFlSE9sSGVqMnVyMTBVTGxQL1hRbXk2aUVhcTFtU0EwVUNqK1JNSXVKRzRz?=
 =?utf-8?B?cVZ5WDRwV05iOGVScVgrTWY2WnVISDdmSURTTmd3UkhTTUNJK2hRZkRBdlpw?=
 =?utf-8?B?czdEZ3hVS1k4THRIVzB4OGp2bEc0RllxTHZGNkE5MlFlRmRLWkt1ajhlNW5j?=
 =?utf-8?B?QlM4QzlMUTNhUDZEbDZJRXFDYlhYUjZMOXR3bFhUdFhwcjRWZkV5dGdyNUVY?=
 =?utf-8?B?MmJ0UUFTQXE2WCtha2xTYXpVQmJCb0hqbTNmcFhTUG9STFJIdTJlYSthMDMv?=
 =?utf-8?B?dTFURC92MWVFbjQxMmZpRmxNWDFDRE9CS0xuTHJYcHZXS3NxejRUd21ZM3p2?=
 =?utf-8?B?RDJuUTZXanFCNWZsbjgwTUtMWXRmVUJhcEFEbHB2VHJ6bTUrbldIbEVMa09h?=
 =?utf-8?B?eHdycURyL2NrMFNVVGUwNWdaQVJrZVhJd1dDWCtycC91YW15ZDQ5VG5uSVl0?=
 =?utf-8?B?eEZqOGdraldydXZ6WmRxVUFtMDY3WEw5STYwRkF0M0VXUWVGNENaMTZMNU5j?=
 =?utf-8?Q?XfgXyqgMxoyTYK3D7Wm0QBHDd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bfdac7-a830-406d-ac5c-08db256c979e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 15:47:33.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPp/xmED/BluQIlqdFwpEv5aijHOcef26dfKUwFRHCEVX5acmr34VPus7jI8/Zff3fM9D9HIulunrHX18G9rdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphcmtrbyBTYWtraW5lbiA8
amFya2tvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDEyIE1hcmNoIDIwMjMgMDM6MTkNCj4gVG86IEty
aXNobmEgWWFybGFnYWRkYSA8a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT47IHJvYmgrZHRAa2VybmVs
Lm9yZzsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBwZXRlcmh1ZXdlQGdteC5kZTsgamdnQHppZXBl
LmNhOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4LXNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB0ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWludGVn
cml0eUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IENjOiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5o
QG52aWRpYS5jb20+Ow0KPiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEu
Y29tPjsgTGF4bWFuIERld2FuZ2FuDQo+IDxsZGV3YW5nYW5AbnZpZGlhLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQYXRjaCBWOCAyLzNdIHRwbV90aXMtc3BpOiBBZGQgaGFyZHdhcmUgd2FpdCBwb2xs
aW5nDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cw0KPiANCj4gDQo+IE9uIFRodSwgMjAyMy0wMy0wMiBhdCAwOTo0OCArMDUzMCwg
S3Jpc2huYSBZYXJsYWdhZGRhIHdyb3RlOg0KPiA+ICtpbnQgdHBtX3Rpc19zcGlfdHJhbnNmZXIo
c3RydWN0IHRwbV90aXNfZGF0YSAqZGF0YSwgdTMyIGFkZHIsIHUxNg0KPiA+IGxlbiwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgdTggKmluLCBjb25zdCB1OCAqb3V0KQ0KPiA+ICt7DQo+
ID4gKyAgICAgICBzdHJ1Y3QgdHBtX3Rpc19zcGlfcGh5ICpwaHkgPSB0b190cG1fdGlzX3NwaV9w
aHkoZGF0YSk7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIgPSBwaHkt
PnNwaV9kZXZpY2UtPmNvbnRyb2xsZXI7DQo+ID4gKw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAg
ICAgICAqIFRQTSBmbG93IGNvbnRyb2wgb3ZlciBTUEkgcmVxdWlyZXMgZnVsbCBkdXBsZXggc3Vw
cG9ydC4NCj4gPiArICAgICAgICAqIFNlbmQgZW50aXJlIG1lc3NhZ2UgdG8gYSBoYWxmIGR1cGxl
eCBjb250cm9sbGVyIHRvIGhhbmRsZQ0KPiA+ICsgICAgICAgICogd2FpdCBwb2xsaW5nIGluIGNv
bnRyb2xsZXIuDQo+ID4gKyAgICAgICAgKiBTZXQgVFBNIEhXIGZsb3cgY29udHJvbCBmbGFnLi4N
Cj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgaWYgKGN0bHItPmZsYWdzICYgU1BJX0NPTlRS
T0xMRVJfSEFMRl9EVVBMRVgpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiB0cG1fdGlzX3Nw
aV9od19mbG93X3RyYW5zZmVyKGRhdGEsIGFkZHIsIGxlbiwNCj4gPiBpbiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3V0KTsNCj4gPiAr
ICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHRwbV90aXNfc3BpX3N3X2Zs
b3dfdHJhbnNmZXIoZGF0YSwgYWRkciwgbGVuLA0KPiA+IGluLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvdXQpOw0KPiA+ICt9DQo+ID4g
Kw0KPiANCj4gQmFzZWQgb24gdGhlIGNvbmRpdGlvbiwgYmV0dGVyIG5hbWVzIHdvdWxkIGJlDQpU
aG91Z2ggY29uZGl0aW9uIGlzIGJhc2VkIG9uIGhhbGYgZHVwbGV4LCBmdW5jdGlvbnMgYXJlIGlt
cGxlbWVudGluZw0KSFcgb3IgU1cgZmxvdyBvZiB0aGUgdHJhbnNmZXIuDQpLWQ0KPiANCj4gMS4g
dHBtX3Rpc19zcGlfdHJhbnNmZXJfaGFsZigpDQo+IDIuIHRwbV90aXNfc3BpX3RyYW5zZmVyX2Z1
bGwoKQ0KPiANCj4gQlIsIEphcmtrbw0K

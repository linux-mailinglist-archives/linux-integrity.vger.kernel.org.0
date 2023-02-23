Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5B26A0DEA
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 17:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjBWQ02 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 11:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBWQ0Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 11:26:24 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0C5650C;
        Thu, 23 Feb 2023 08:26:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgjJWgrE+dQMD2FA4wiRIVaBNilbGlrc4CO/CNXa70gwF7uxIJPYyjV/RAuBHtRrJcv9vh3JgSxJbUm4DX3zecuPc64Z9Jt+ZBNmLECx60DEHJRLo1EVDZSXtpQS0uWTspqlCjH7CxgfStLHYd8Lyx+J7IK/1yMvUcR8ABeKdhvPeMIAXu72yxqPzYd3dwGb3C80BS1x7nDFSLAoPDr29RbACSRvSqMMzJ9LVGDIQqkaONsjAYU6gvzLtBB33+YQepEN73F7R0YVxH7h+FY+wxZjdgV0zX5offgHYvmdhlSagBMyeI2iIIEJnQI0I1gaQwfRj6X7CbF91i6cTjpYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HBX2u+/3flutvOtipm5S4pMD5vNOwGQMeC/s6/66PU=;
 b=Yw8PeNtMKxnR6fqZ/cZVVo81WVooXdh+wkOyFll/NAA9yZOThs7+TMRm3Wzx9M7nyYO92ME6I/c8c9snZGrOXh+VKgI0vP6rUos2vXRAOSLSSxkU3EGdBnXnA4JoEmMUq9nYyW5Ix5cxGzSF56ns1yKIhRoONFnr1t2q/zDTPHiX2UypwRhERzPK5aE7u2BFBd0Q2seMAlMl5L6lkh7hC7+9UVnWBjwo2s9GakWM8XmBKRbhCGcpsUNm/Wb8Y2b6yZtEZSx1+gSa6ALBjAaiEsAjHoyhuaZz/CFd/d3ce90OtUXoctTjUoHkD8mUj4vTo6Vj5qwCQ2yWmzonJAKwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HBX2u+/3flutvOtipm5S4pMD5vNOwGQMeC/s6/66PU=;
 b=T1r+u/PK7X5pvxc/57cb3n28WK66dc0IfksBoWuO905DlYauRMbVBRf3x4rAg38a1Gv+qb/pG/X/ZsU4Jr3b132mWKMEFX+U/oNQ/iWidBMCEaxxSFnTX8XduTAiyOJl8z+q7S7eOotjvq4Br0F8T4DODrWlF7xoAlW83vsx7K+SLba5O2iId7U/IaD+vjlIqRdVlUHz3G94R9zaEjyBx9YxeDZYWG2lh06CnO4/iLVeRCtNDEOnWnYMtD54KthsvActI/kbhd7fkV6c/11imB8PjU4fb/5O8KruHnNKfQS8rCHdpz0NfRce9W580mvmsC+yf4nN41PoxTd+Zb7IsQ==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20; Thu, 23 Feb 2023 16:26:19 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 16:26:19 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: RE: [Patch V2 3/4] spi: dt-bindings: Add Tegra TPM wait polling flag
Thread-Topic: [Patch V2 3/4] spi: dt-bindings: Add Tegra TPM wait polling flag
Thread-Index: AQHZN8++62r3mBEHJ0mzwA9moaCgsa69oaUAgB8ohQA=
Date:   Thu, 23 Feb 2023 16:26:19 +0000
Message-ID: <DM4PR12MB5769035B6C55C581B410FA0CC3AB9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230203130133.32901-1-kyarlagadda@nvidia.com>
 <20230203130133.32901-4-kyarlagadda@nvidia.com>
 <CAL_JsqKph2iK3Qb1=PFKxVScSs1f8sUcDh52py8WyhO6pu27TQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKph2iK3Qb1=PFKxVScSs1f8sUcDh52py8WyhO6pu27TQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|MN2PR12MB4373:EE_
x-ms-office365-filtering-correlation-id: a4737f76-ecfa-4e0e-f459-08db15bab1e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4jwqFHey3krQie58OW8H/v0VBXXhM+YOwnZaSjxN8Qa2OAz2CRUEIeh+WGQnO4m7prygTKT5w7FsJru3HASpmLtPE4h4/o0uoNfKgS4GiyBN8m/H6cUSgk7ZoixNh/0YBIxW/GTR92rCGzgdX+VoHQhYZgyvzg8Vkth1P2Hqcz7xuaUVwxD7WiJKVccWr/KQ0K40LVhuJivwLPRb2mpQZkkQwyZ00gtCwRAFAGm8Wz7221kakXAYvOBTNqG0VjhoLMeaSzDYraPreMFWNmN0IE/qeGT8ylbfj0ixO27cD4whlkQWJMtPvfqLQc6yWDe0GMUMyPP4v1SrCw5tq/TZhldq1BH8xu7Vyd9OKBqnJ1bw1fl5WrBuMJnq5GFnyJE7NVsb4JSM/xhzlgTjAqUkoz+J5sSKzmWbrjW38w8VT4JPA06oaN3Y2focpgwTMd69RfiAo6imWm+cLCBzlMCsh/iVfTAHID7h9M97+Q0OAhvbX4ckb+OfSRkbnIEc5uBz61Oc+pgS+CgpXGtXrY236dflt81gi8vINAdkUzvLL9oUwNrL4mAleIVlZ+NEGsLpuBOdBhoLvePfLt93z/gGIlfDFuj87XAIMu1A0FNZLJdB+cDtTl0m17qz2x0GU17dhU9Q2N5hjdgyZrVX7NsEa9D9S4atP0SW6eJctIiBfqtnZiRpcAxhJGEddRtuZOaq/tSgwhwJHoSe69no1EwNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199018)(122000001)(38100700002)(6506007)(38070700005)(55016003)(66476007)(26005)(2906002)(66556008)(107886003)(64756008)(4326008)(8676002)(186003)(71200400001)(53546011)(316002)(54906003)(478600001)(66946007)(66446008)(83380400001)(52536014)(8936002)(41300700001)(76116006)(7696005)(86362001)(9686003)(33656002)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUQwcHNCNkJ3NmFIYW80UHZ0ck9SWUlqZ1J3TVREVy80VVNFVXpWaWhkLzIw?=
 =?utf-8?B?elpyTkwrZGt2SUZ2bXNGOW9SczdNYklUbWlXYWpDUUNtSGhGVkVlcmhYRDRq?=
 =?utf-8?B?OE5Gd1QwYUY1VTFFRnFCc1V6YWtyZGdpVDZwYUpwclM3aXlaTko5UGJwendQ?=
 =?utf-8?B?a016L2xaMVNQM2loK1NXcTAycjB1S3JlUmN2N3kwSUJkcjdtSEh1azN2RCtt?=
 =?utf-8?B?cWRqRlVFbTljQjBrUnBZZCszK04xRHNYV1o4QkU0NUxVcWZPalAxMHJTZW01?=
 =?utf-8?B?djdrOVhkSXc4RHEva0VGYzE5dU1PSFNPUk9pdGpQejFDUThhSTRFZDh3TmlQ?=
 =?utf-8?B?UU92MHFFTzkyYlpLNUJZejRjZnl1Q292STRNendNZmVIblFVb0JGaThZOHE1?=
 =?utf-8?B?QUNIZVYvOUVQTU9rVUVPMG9CbmxYdW5SRWpZdUZpSytyelNQaERKN2xOU3o0?=
 =?utf-8?B?blF2U29pUUVBZEhKUERKSmlCOFpZQ0dtZEZDTHR5NDhMWXpTTFF5UDJhallI?=
 =?utf-8?B?b2ZESGpLVFl6WUQ2T0U3Tzcyakd6QkJUaHJRS21JVVVoU0dTNTM1NXBwZnJC?=
 =?utf-8?B?VXRpb0hDVGJqdWVJY0twMksvSUxtS3NwNThQUW5TbzVZS3k4NmMwbGIyMGJM?=
 =?utf-8?B?VTVDTWJ3U0VOZkR5NmREMlI2OXlENktualZscGpBWC9lZTJ5SnJZUzJYRTZF?=
 =?utf-8?B?VjlNV284UUh0YWJxMlFHMjJpeHFoaXJsVFpLRUNlSjA3d1lwWTdpTVllWXRB?=
 =?utf-8?B?Nks0a3ZLOGlNU1RQZXpuaXoyTjhiLzkyeFpDWVRzYmVCQXo0ZWFBMWE5bVEv?=
 =?utf-8?B?MGFNR05MUjhoQVhudEUwdnQ1Yi91dkw2a2ZhbThzSUZzaVNhMG1MNUduWUNK?=
 =?utf-8?B?RzRZemQ1dktSV2ZYQk4zTlRDc2NBZ1lINzMydXhQdk9ja1I1eFVkbjczZnZX?=
 =?utf-8?B?c3ZnbDdLaDg4U29ZM21lYjdtTzlLNVMvS05KUko0RzFCY2ZWbVU1Q0k3TnRM?=
 =?utf-8?B?cGVYaGhtRVBIMVMrcVlnZFZ5c29ZSytaNm44V3Q0SW4rbXRrcTZ2OXNRRmxj?=
 =?utf-8?B?bmxvREFGTm5XWjdDYXZpVzl3ZzZ2dG5MV0NmVC9DeDBSU0ZxOVJZa29RMWE3?=
 =?utf-8?B?MFF1dUVQY1poUnZRZ25pSSt5Q1ltdTMveXZudGxOT2RqNFlRdkZ5TURGcmt2?=
 =?utf-8?B?QkE1NmxVaXhIZkdWUzgvRXRpN0lCZ2tCamwxRkZHbWVjYnZzNnljclRkTVYw?=
 =?utf-8?B?YjAzN3cvVE1qdUhGSEFnYUJBMmhuUnBCYzQ2YTF1L0tJWlU2bExHR1lJa2Vq?=
 =?utf-8?B?QitIaHZKWldQS3pDNkViaGZFVEIwY3FNWWtBOFJ2WjZKTkF1UjV4M0pBWmdY?=
 =?utf-8?B?TGxBQnBoYmtCZ2s2Q0dCc3A2a1BXZ0hFQkJUWm9RNU4rMmhuNEJHVlBIci8x?=
 =?utf-8?B?K3Zxc29rbTY0enUvbElDMHpSWllZVW1MUlhjWGpWOXZiWDVjMGVCbWRLR2hl?=
 =?utf-8?B?S09qUFVuajFSa2pCb0pNS0NKWnVIR0NnVkcrV1pnYk5ENXJRbGdOYlljQWJK?=
 =?utf-8?B?OVhwWWRld0h1enBYRUduQi8ycU0yQnNKNFNtaFNYeEpqeEg2WFJZZXhldWRq?=
 =?utf-8?B?OHh2WWFtblFhOU9UbDlNNmg0QVZRbGQ4NjUxUU16WEwwcFBYaVVoWENTWkNp?=
 =?utf-8?B?ZnVLUWNjUzBEemZmZWxGdm5KUm1HSDAyeCttRVJCSzA2MFRvb011NTJTV3Y3?=
 =?utf-8?B?LzhmYzM4aVg2ZTluSVdudTNCL2ZlQ2lCWmRWckhyNUZGeUZOUFZaYlFaTnEy?=
 =?utf-8?B?ZU9GQ0FNRmRzbEZ3QVF3YmlSVVJ3V0ZQN1RudDQrdjlXVzBvb1V6QjQ4U3VB?=
 =?utf-8?B?SjJsRDFQQ3BiTkZNNEV4NDNPYUxlOUM0bS9MN2gwUkpheitwUlpzWktmVGVX?=
 =?utf-8?B?M3pIemZxWElxVTduOGIvVlVhcXZFM1A3akJkR0d2bTJIeEZqYkV0aHVDUmtz?=
 =?utf-8?B?SjlzRUhjWnh2K20xMnprZ2wrb2dONWFnWXJxTVJXaFE2SFZCankwV3dPQUIx?=
 =?utf-8?B?ZW1QWCtnekVJYWczNFluUkNjQTAwQkE5Y2F2UlorbTd6TjlnNGJMeUhneURM?=
 =?utf-8?Q?vXwDMhXq5gS7G6j5ETu4ZHBmW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4737f76-ecfa-4e0e-f459-08db15bab1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 16:26:19.4569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdAGBEpMb8IfcQnizTJmKhWx9rOD5T5MPdqn97WCLLvAm2PdV6p27mmA5wPPCz6mET6bJnisWA9Jy8OXphF/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaCtk
dEBrZXJuZWwub3JnPg0KPiBTZW50OiAwNCBGZWJydWFyeSAyMDIzIDAxOjIwDQo+IFRvOiBLcmlz
aG5hIFlhcmxhZ2FkZGEgPGt5YXJsYWdhZGRhQG52aWRpYS5jb20+DQo+IENjOiBicm9vbmllQGtl
cm5lbC5vcmc7IHBldGVyaHVld2VAZ214LmRlOyBqZ2dAemllcGUuY2E7DQo+IGphcmtrb0BrZXJu
ZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4LQ0KPiBzcGlA
dmdlci5rZXJuZWwub3JnOyBsaW51eC10ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBp
bnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5oQG52
aWRpYS5jb20+Ow0KPiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29t
PjsgTGF4bWFuIERld2FuZ2FuDQo+IDxsZGV3YW5nYW5AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQYXRjaCBWMiAzLzRdIHNwaTogZHQtYmluZGluZ3M6IEFkZCBUZWdyYSBUUE0gd2FpdCBw
b2xsaW5nIGZsYWcNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxp
bmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gRnJpLCBGZWIgMywgMjAyMyBhdCA3OjAy
IEFNIEtyaXNobmEgWWFybGFnYWRkYQ0KPiA8a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBBZGQgIm52aWRpYSx3YWl0LXBvbGxpbmciIGZsYWcgdG8gZW5hYmxlIFRDRyBU
SVMgaGFyZHdhcmUgZmxvdyBjb250cm9sLg0KPiANCj4gVGVsbCBtZSBzb21ldGhpbmcgdGhhdCB0
aGUgZGlmZiBkb2Vzbid0Lg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgWWFy
bGFnYWRkYSA8a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRp
bmdzL3NwaS9udmlkaWEsdGVncmEyMTAtcXVhZC1wZXJpcGhlcmFsLXByb3BzLnlhbWwgfCA2ICsr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9udmlkaWEsdGVn
cmEyMTAtcXVhZC0NCj4gcGVyaXBoZXJhbC1wcm9wcy55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9udmlkaWEsdGVncmEyMTAtcXVhZC1wZXJpcGhlcmFsLQ0K
PiBwcm9wcy55YW1sDQo+ID4gaW5kZXggMmMzY2FkYTc1MzM5Li4xOWQyYjMwY2FkYmYgMTAwNjQ0
DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9udmlkaWEs
dGVncmEyMTAtcXVhZC0NCj4gcGVyaXBoZXJhbC1wcm9wcy55YW1sDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9udmlkaWEsdGVncmEyMTAtcXVhZC0NCj4g
cGVyaXBoZXJhbC1wcm9wcy55YW1sDQo+ID4gQEAgLTI5LDQgKzI5LDEwIEBAIHByb3BlcnRpZXM6
DQo+ID4gICAgICBtaW5pbXVtOiAwDQo+ID4gICAgICBtYXhpbXVtOiAyNTUNCj4gPg0KPiA+ICsg
IG52aWRpYSx3YWl0LXBvbGxpbmc6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAg
RW5hYmxlIFRQTSB3YWl0IHBvbGxpbmcgZmVhdHVyZSBmb3IgUVNQSSBhcyBzcGVjaWZpZWQgaW4g
VENHIFBDIENsaWVudA0KPiA+ICsgICAgICBTcGVjaWZpYyBUUE0gSW50ZXJmYWNlIFNwZWNpZmlj
YXRpb24gKFRJUykuDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy9mbGFnDQo+IA0KPiBXaHkgZG8geW91IG5lZWQgdGhpcyBmbGFnIHdoZW4geW91IGhhdmUg
YSBjb21wYXRpYmxlIHRoYXQgYWxzbw0KPiBpbmRpY2F0ZXMgeW91IGhhdmUgYSBxdWlyay4NCj4g
DQo+IElmIHRoaXMgYSBUUE0gZmVhdHVyZSwgd2h5IGlzIGl0IGVuYWJsZWQgZm9yIGV2ZXJ5IHNp
bmdsZSBTUEkgc2xhdmUgZGV2aWNlPw0KPiANCj4gSWYgdGhlIGZ1bmRhbWVudGFsIGlzc3VlIGlz
IHRoZSBjb250cm9sbGVyIG9ubHkgc3VwcG9ydHMgaGFsZi1kdXBsZXgsDQo+IHdoeSBjYW4ndCB5
b3UganVzdCBjaGVjayB0aGF0IGZyb20gdGhlIGRyaXZlcj8gQ2FuJ3QgdGhlIFNQSSBzdWJzeXN0
ZW0NCj4gdGVsbCB5b3UgdGhhdCB0aGUgaG9zdCBjb250cm9sbGVyIGlzIGhhbGYtZHVwbGV4PyBU
aG91Z2ggc29tZXRpbWVzDQo+IHRoYXQgbWF5IGJlIGJvYXJkIGxldmVsIHByb3BlcnR5IEkgc3Vw
cG9zZS4gSWYgc28sIGRlZmluZSB0aGUgaC93DQo+IHF1aXJrLCBub3QgdGhlIGRyaXZlciBtb2Rl
IGluIERULiBIYWxmLWR1cGxleCBpcyBwcm9iYWJseSBzb21ldGhpbmcNCj4gZXZlcnlvbmUgY291
bGQgdXNlLCBub3QganVzdCBOdmlkaWEuDQo+IA0KPiBQbGVhc2UgZGlzY3VzcyB0aGlzIHNlcmll
cyBpbnRlcm5hbGx5IHdpdGggdGhlIGZvbGtzIHlvdSBtYXJrZWQgYXMNCj4gbWFpbnRhaW5lcnMu
IEl0IGhhcyBpc3N1ZXMgSSdtIHN1cmUgdGhleSB3b3VsZCBoYXZlIGFsc28gcG9pbnRlZCBvdXQu
DQo+IA0KPiBSb2INClFTUEkgaXMgYSBtdWx0aS1jaGlwLXNlbGVjdCBjb250cm9sbGVyIGFuZCBI
VyB3YWl0IHBvbGxpbmcgaXMgb25seSBmb3IgVFBNDQpCb3RoIGNvbnRyb2xsZXIgYW5kIGRldmlj
ZSB3b3VsZCBuZWVkIGEgZmxhZy9zZXR0aW5nIHRvIGlkZW50aWZ5IHN1cHBvcnQNCmZvciB0aGlz
IGZlYXR1cmUuIFVzaW5nIFNQSSBjb250cm9sbGVyIGZsYWdzIGFuZCBTUEkgZGV2aWNlIG1vZGUg
ZmxhZ3MgdG8NCmF2b2lkIGRldmljZSB0cmVlIGZsYWdzLiBNb3ZlZCBIVy9hbHRlcm5hdGUgVFBN
IGZsb3cgY29udHJvbCBpbnRvIGV4aXN0aW5nDQpkcml2ZXIuIE5vIG5lZWQgb2YgbmV3IGNvbXBh
dGlibGUgbm93Lg0KDQpLWQ0K

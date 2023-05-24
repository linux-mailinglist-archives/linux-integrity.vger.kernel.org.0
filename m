Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1550B70F6C3
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 14:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjEXMnc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjEXMn1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 08:43:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED2A12F;
        Wed, 24 May 2023 05:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOkWgiLvYhfw5ylCKvlX3iFPhc4BoTAEohO9ga1gfHhJwmUhaIHmawKKQM3gVe9jtdpF8NQbD4OkO8TuKgYRJGnFdon37A5yxHTMzHIQ0TSI0b+J5wUjLnLF94QCRqtvQZXdBagnIeGjan9N0A0HyhlFaXLMd4CcsZaUDZzmdyyhGa/Dg5Lrryvslb6Cg4+knmWbdNzNEJ3+TpJnBPtN9FRG+yCMwy8pIdR68aKn8w5hqWqHfu4t4ByEhEeEkd03CTq0LmC4k1jj17hkIIFAIjLcB7k9JnFinSZ0Al9cfWLqdLVJLZTpNP9hgUaNETnAce00/oxaWCChxdgyluhmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG1sWKrVdRu8BYqfkBdToxws12tlZyXzw4CIG+tpniQ=;
 b=aeF7ZJBUHt5SUU3ZAvaShE2JoTZyYdgntFz/8A7K7x2grRj4jxdwvkAAcokmzn7VN7w2dIVdEZis/XHyK4oiNLWSr8sMz//cu8h0LwfIGJMw9uQjOwTrVsmrSMLiq0AfxAVBn1zeTsD6j4/X298UlOz7fkUUl+lPI3D0Q20Qzoypsx5tOScjHxWlCLAjALI/89nlZePcoIBYOF6X+JHagchYWkg698m21n1fRwsss21xSCsEM4lzyzjtZFM2J0gziL2ehwGrejr+p2qnW1Q++oIB+SD7nfyz/8jju+jAdQwYc0ZKqXm063kqk5C9kyOTLw/IezS2RagJRD94e6cUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG1sWKrVdRu8BYqfkBdToxws12tlZyXzw4CIG+tpniQ=;
 b=FjpCiQweGRUWmd1KJ6zjtl6q3VYdFj/4IBLOrMBolHNm4ik8C1xbMI4QNtG7sScHcDBnkgHhoVJ0sRfqItd+08j9CF1tmOZZdK3swoDgTfpP/gkbelNnow/r+pB3QTKOlc6HDPjmkPXaHw4mzrNXID5pR4KEhDICmvB0+SBGl8+ohDjW2m1Aci0WVqEGlB+6Xg5jTzwXwhevyB0M6Qy0ZrobyeLQE2gu5pjmiEiTdWWY4sd1h8CPM/Q9VsrdMJiz7uTTzPmbQEaL3QEda8CD8cz9jzU7ka3Sv9mWDJQYptZ5aj/YkQJ5c+ER4ToAJgjglHZ6aFMC/hajKxKe1TZM5Q==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 12:43:12 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::2c4d:1cf:626a:370d]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::2c4d:1cf:626a:370d%7]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 12:43:12 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: RE: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Topic: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Index: AQHZdDGUn7qO3n0DaEywabZxmXB7Nq85AnkAgAFcuoCAAC9+AIAACQqAgAADlQCAGR6r0IAV1ZKg
Date:   Wed, 24 May 2023 12:43:12 +0000
Message-ID: <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk> <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk> <ZEag1lAonYcmNFXk@orome>
 <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|SN7PR12MB7956:EE_
x-ms-office365-filtering-correlation-id: 836e641e-1c06-4aee-a415-08db5c546fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bxg4RiGBL0AsHWSHwFKoc421o4PD8+QMCD04IzLR8iDzL5F1dMXPa6Xg4zsXaWF2F9o2AlGfWz/I+l+zhN2yn5EhfqbEiYn7x2QGJDRfMmdZzC2GD9AR6FPdfRmlFnd1kzMhz6UF8REAX2+YeY/i45qLWj8HCl1A9td8YzpC8hj3W19Ki3SSmwsntdiPYj+6Sk+ntSRw3FfOjwc+LV/M5uQxhYBdHM4bW/qGDqg+RcsTrlFi70pM4H1SFAwjxHgLOs7zU4LDegieCdcfyWiXFQZA075x6tk9MOrLbOsWCR+9oPLYHu27FNFy7P+CUtdxnAD+Wo4gzsGSp5vaC9fg6Ri8eOl/B2DI4p0ZDCicPjtMX+2Nb9CFFvxskitAY5ML05OXXgZ7hvTehGxwzE3Cj6ERnHuFiP8dZ3Svjy6j9Ik1seQlpbVRkOewmEMKg0wne4XgSzzLKqJ7nFV8IxvI/8cwMCp/0r6BtJphVgUjoS56uR500rVmAMdUzgOqgUt7gphRwCOO0rUHUKFfEmqNX0JDL/2SRgr+RVNTbDvZhYuAXiLvopXVf7aPIhJcXik/2vjZmQTIgCBf99CFFAXq6v4KYzZ5PuN5/SFRYQMGhCcktmj2/QDnmk3P6wA2feG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(55016003)(110136005)(4326008)(66556008)(66446008)(66476007)(66946007)(76116006)(478600001)(64756008)(86362001)(54906003)(41300700001)(7696005)(316002)(71200400001)(38070700005)(52536014)(8936002)(5660300002)(8676002)(83380400001)(107886003)(6506007)(38100700002)(26005)(33656002)(186003)(53546011)(122000001)(9686003)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gKajHSBc//Q2s/qMi8718copcdFqqfOT/Mub0n8F38Yjsawb7eig0tp+aZZk?=
 =?us-ascii?Q?4+iAsn4HKVYoAcJwcpqAcGkD77wEsO8jHPaYnj04jp0Bj+KpOi3m/SHUfCdT?=
 =?us-ascii?Q?s38vPbRn0aUgv7HyeQhnZ7MBhvm5sOTVcdPQzbr7Jp149SFGOSH1QJ5rmjdR?=
 =?us-ascii?Q?H0dUGnkWP/tUNxGbiCuysaT7R3evGOz735WKNXTJHkG1ieYfe3u8w2UmdXf6?=
 =?us-ascii?Q?8qKHWEjsZ+SVtC2g/JVyI1G7QJJem4vopmkE0Hy5Rm6pHtjwvevRYu3PMast?=
 =?us-ascii?Q?8PhPBEbuVMPrM7X2KmdkfMsY42l8yNaHMvhaT+TdmkamR2Ge6e409dLlSQ14?=
 =?us-ascii?Q?z9nt04MXqKhF3m3cVfxFOVIaAQruL7+8QmUv1fLCmFEcDvlMg7igl2m3QG3Z?=
 =?us-ascii?Q?7ox9U5jby1/FMjoveOSMn2wTnvw+2wxfGcYYZEGSC9J1nwfFTdlxJ5KedOuy?=
 =?us-ascii?Q?vGmHywzQtjaR/TAORFRJWroAMX/aTYSPgKAi7By2cuK1Hu8GLUcrqOZakfQG?=
 =?us-ascii?Q?XO28aT3sZ1dCaAfaSDmaCVvHS8f+DZsd7/6sTEF6QUVaVgiy6k5NJvTZTuSV?=
 =?us-ascii?Q?in2mD2yRKklkCribPeKNqitufZRSZGWXSxMTWJFgYbyxjWEJCi5c0BPeVHd0?=
 =?us-ascii?Q?DJJQ1pdJD8bnq2zWmMMQtjgCzTRTyX5PeGmfHyQDxz8nBl5ngoNReXO+60gX?=
 =?us-ascii?Q?6WTP2dBQlxRjC79ZkWBCTWrroC4ljGsjKcqRL4kpsA+INgGbfxWEjuJSdXi1?=
 =?us-ascii?Q?alg7sfAj+oy9alcBdr6nErZ9rkCd4nNwfiknBAtqniiXmvu7dMqmXcA/tQoa?=
 =?us-ascii?Q?XHHGSW60eH5uiOyvqnj0XCi3TwpqNzbrhnAJW4G0jp42mIDzIScA2BG1gLCD?=
 =?us-ascii?Q?HRObSBasPl9lG4Nr81yrX2kzfiqIIB5e0olkxLImpBEqa1s6zWbMWyWQLsu4?=
 =?us-ascii?Q?phN4ePYmn9pLXdorGEDVJXRAgyqq1ZIlu+DciE6cZTEYsnhgLoWAbUP92Xrj?=
 =?us-ascii?Q?JvH8nk1xSy474tNJOeOnWV1sgYVALCVq8XfoLMfiaesRwrZQZxgWh5gutCvk?=
 =?us-ascii?Q?wRpXQUjIPrtJWeWLaBjfzHlt0/dY6EqSEuF5aRpuiNeiSsvgiultQ8aanOIQ?=
 =?us-ascii?Q?PfRT9XcjiMePIJYsfYA3IBh5uCPf7DMXIaA5KQNYB93V1hXMuRg5rMIBcf0f?=
 =?us-ascii?Q?Qal5DfIHG0tihJ8hyBWZir5o6V91Dv3MqE+sv7AxIbX6fxjXmyo//tSGEeZw?=
 =?us-ascii?Q?vAK0/6fxO7tazwPUDkehTUA8YMJRV285lwAOsbH37bjrR9QueKyq2uEOQuVH?=
 =?us-ascii?Q?AHN/q3BRECHuETuAAy+z66lL0FeIxB+5S83c4DRf0KFLrj5YQN0dDy21MzBN?=
 =?us-ascii?Q?/kCAefOJt919WhRvRWp43ryMRv9D5LNgbcJCMB6h8NAxca21frsUG3QE3kOE?=
 =?us-ascii?Q?58Hv4Azs3c218NvAKPCI3uBYwYhPOCvYs6hw8LHXS0iDXO9L/4Cti6oPu3pT?=
 =?us-ascii?Q?uL4Uhyay9hK4b/Qtkdef9FGDdsXiFVBLXSONHwYfETXxClo9GUc68pQaA8e9?=
 =?us-ascii?Q?RkzjeGsV2u4OlJm/HNI5f9hy5CYeZiuSOsK7fOWS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836e641e-1c06-4aee-a415-08db5c546fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 12:43:12.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAtwtUYpOTjfP9WNYVOCxQ/5ZPQouwKZ+WnsrSO2keFdXweOJ0+KthvDEAyR3lfI9VJge59moddEDVN3E/Y+2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Sent: Wednesday, May 10, 2023 8:41 PM
> To: Thierry Reding <thierry.reding@gmail.com>; Mark Brown
> <broonie@kernel.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>; jsnitsel@redhat.com;
> robh+dt@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> krzysztof.kozlowski+dt@linaro.org; linux-spi@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>
> Subject: RE: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
>=20
>=20
> > -----Original Message-----
> > From: Thierry Reding <thierry.reding@gmail.com>
> > Sent: 24 April 2023 21:02
> > To: Mark Brown <broonie@kernel.org>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>; Krishna Yarlagadda
> > <kyarlagadda@nvidia.com>; jsnitsel@redhat.com; robh+dt@kernel.org;
> > peterhuewe@gmx.de; jgg@ziepe.ca; krzysztof.kozlowski+dt@linaro.org;
> > linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> > integrity@vger.kernel.org; linux-kernel@vger.kernel.org; Jonathan Hunte=
r
> > <jonathanh@nvidia.com>; Sowjanya Komatineni
> > <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> > Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
> >
> > On Mon, Apr 24, 2023 at 04:18:45PM +0100, Mark Brown wrote:
> > > On Mon, Apr 24, 2023 at 04:46:24PM +0200, Thierry Reding wrote:
> > >
> > > > Would it make sense for you to pick up patch 2/3 as well? As far as=
 I
> > > > can tell there's a build dependency on patch 1/3 because of the new=
ly
> > > > added SPI_TPM_HW_FLOW symbol.
> > >
> > > I'll include it in my pull request for spi this time round so it shou=
ld
> > > end up in -rc1, my thinking was that I was happy with the SPI bits an=
d
> > > if it was in -rc1 then the TPM bits could be handled without cross tr=
ee
> > > issues when the review was sorted (which it is now but wasn't at the
> > > time).  If the SPI side doesn't make -rc1 for some reason I can pick =
up
> > > the TPM bit as well, and/or do a signed tag.
> >
> > Sounds good.
> >
> > Thanks,
> > Thierry
>=20
> Mark,
> Now that SPI changes are in, can we pull this TPM change for rc2.
> Will this be picked into SPI or TPM list?
Jarkko, Mark,
Can we pick this change in TPM list since SPI header changes are in.

Regards
KY
> Thanks,
> KY

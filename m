Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164806FE13D
	for <lists+linux-integrity@lfdr.de>; Wed, 10 May 2023 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbjEJPLD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjEJPLC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 11:11:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFF4200;
        Wed, 10 May 2023 08:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkSgzcdvMtMxVe2HIiMCJg39o74VVp3jsKz52ZQvAPQOJpG9QNS/3n4tVVqAsKabcL4FW8CKEJ6bhb0A23lOuxKuJiLSLGGEp33KyrzH+p7OBgbC/wJCDvoOzJ0vgHfRBP8wGMToIrtljgEdNghz+YE7yK5lXfYlRDJyK6TK7pnjULfcjs3S5vdkcYid4b40r9lwPurAsIcEu3+CE8NcI/1lsAF04z+JWfnIPIy/aPhlmJkuf9r1ETg3DhaOOi63eFzLOouXWMtuSBZcuTR279EWPZKSxYqIrSojdJJoDUsz+D20qJPAU6AZfqvAxSSt8TWNR4k/IUEcGmXTil/uNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKh6E0c9AS05P5jAhI0kzbhAL10ySk2ewZB0/iqk7bQ=;
 b=dEzsudCaxV6oTY4oOYwpuH+HQJFxC0caupcAqGsK3RGGZKO3lxxaKkITMkTQe5g2lKfsIefFalE3f5lwrzawiqwFNqr2XCuBjyxu0OuCTnC4PfOjfdbmH6dHyaMLmAxe7exIbuVkOVlJ9HiUmmbIC9THMVDWBKGxeEuiQPytfQihyJHZMpdB5wRgEuf7UzM5Om403oVQgnu/NQD4uPirgGiPP/dc62JxNA2RG/Xwk1bO6rpOnk6+u3bvm4p58B7rQYDvny5Ba9rhQsXVS5EZ3zWSUXcqAPw216s+jq6WlYpbG7nMTrALKEsOtphgP4X+9AsZhVHDtozETyqZDRUs5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKh6E0c9AS05P5jAhI0kzbhAL10ySk2ewZB0/iqk7bQ=;
 b=piF/4YUGN7440h+JuqLahWwOgCWfgJnjUD6InwD/6bkVN8rwE5Eqf5fAgWBPud600VP0xtdUkwNIfgQAtW5t52t6aEZaGAxCbyuXkrQb6TdZqQOcufEpXpWt2oZ/ZhGf5mV+/rfkDVaSRblo/hFTAmGkAvhA/mH/sb8Ad9m6DMNNoFbe6QHfivUxsb6ErNkdx5sI2dBiTPr0x65TSw0GR9vRG7OWSb2VnWaSF0XhQ/9YJonrpxSZ7hPUww6nKx1qo2O8mzmBum2JyQx4BFfr5bFajdXREC8SpD0IGRzgqm646c3ZjEz19hM0haWvvf7rQwmXkZoO8aw42A12QN7Nlw==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Wed, 10 May 2023 15:10:56 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::2c4d:1cf:626a:370d]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::2c4d:1cf:626a:370d%8]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 15:10:55 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
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
Thread-Index: AQHZdDGUn7qO3n0DaEywabZxmXB7Nq85AnkAgAFcuoCAAC9+AIAACQqAgAADlQCAGR6r0A==
Date:   Wed, 10 May 2023 15:10:55 +0000
Message-ID: <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk> <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk> <ZEag1lAonYcmNFXk@orome>
In-Reply-To: <ZEag1lAonYcmNFXk@orome>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|SA0PR12MB4448:EE_
x-ms-office365-filtering-correlation-id: 16e76122-4393-4879-ae1c-08db5168c09a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C6VZtPgIbCJDhuNv1NewijH3oAU8h4au1boGNs1YfysWu2R9dwvTx4Dz4rFhGcvJ8GtLaPfl8gwihKR20HNCaQwj0EFdoQGCLUJuE1syfLyn28YiVIIvMdb3tGf0Lu/zZNlOrzaWKdPVWx2sZgH0MdJo7Y7SAVyEyWieN0ct6xzPSdxAZj71BKCY3o1xCmI8wDLZXjRx0+tl8LjrK6Tew7uewUn7y4NSzKr8DNV6ZOWPEv9bvGcUD4mfsGc2NrTnJYAkbCw0nmFpzkPNTfv3q9PBP/ZPUnZlMlHJHYyy7gb6ujDkrkcC8DhWjL1ZUddx+3aajwZ+ZQEojWw70KReQY/fcSpnQ9P1seUbjM7LIMFEs7bJmXAz9OJDh3YCUU89hxq6pYt3dHe/zLJ2THCf4JLYV6y+ukw+7abSUuxY5nPp1Ea4BbdcA3adyelZE/yxNBmJ0tnaV9xtEYyY8Pzxc1GeAQQuhWZN9CLF6xmxwwqLIAaHpHDtigoDnkgjz6tz6fav7LdkpIRgw2qbe0KBMTs4UgJcITgKpMk6OkhpAl5EOo7kR6xOY6u3AHvMb7QDh6LMyf8RkBQZmTgz798xYeCFOkkW7KSlWK3e7/avA3FpazJpKBEgZR+hDkSeAJMy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(33656002)(71200400001)(4326008)(7696005)(110136005)(478600001)(54906003)(53546011)(6506007)(26005)(107886003)(9686003)(186003)(2906002)(7416002)(52536014)(38100700002)(66446008)(66476007)(83380400001)(64756008)(122000001)(66556008)(76116006)(55016003)(66946007)(41300700001)(5660300002)(316002)(38070700005)(8676002)(8936002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CcWlrHtew8WBF4hELtiFWdlZyXVlYlcajJoQtuMswOOIKalKCkHE1najT2aJ?=
 =?us-ascii?Q?DujD/Q/8FkW6vCVCtbstlBYQ+PiTEdrsOQ3VOC3Jm+814qYi6vfvvVA1hQ+L?=
 =?us-ascii?Q?Uen0Y/TW0Q+DMb/j/utirHPA1WDHkQ+yvczU3huebCuK+JWcGw4r4NHQwlTA?=
 =?us-ascii?Q?AnloC4zmD5S1pzlDKpDC2x90/AbPKA2iRTfnIFl4+nxq6/e2bKbyjyYhuprv?=
 =?us-ascii?Q?WlVeTfSC0PqXtkoNOHLICmqQISqc0ojmu6Ge8Xge1en0S2+4aerw4m1xqzTb?=
 =?us-ascii?Q?K8LxxBTPsbZ1Cpvh4lZrHYWN7UvzmewOVOqDIAV2qmmcrZRunqvBxNzIm9mA?=
 =?us-ascii?Q?SPRrThuuXehV+qZPXhcLwf8aom8YbnSPnaSfSEXpl+ngkz5kAZosBVMUaNAT?=
 =?us-ascii?Q?Z0fP/N+BLs11nEuJ720GKHv/jQExyPmQZ5Fd2Vr1PWvyLMnU+dTdz9VtQvjV?=
 =?us-ascii?Q?hI2Vqf7CqbLYxIm3xTEcD9jGltB10Ke3y0+dVkQmrW3CaELGf4kFowzi61ww?=
 =?us-ascii?Q?3zeFJJnDUpGeGP0UewsESRqQIzXu8KtKtc4RNCbRGzzuhITMxLuvgVjcIa/8?=
 =?us-ascii?Q?kpkdXBMduzYGVwGPH7/eRKq6VcIvsC+KhdaPHzsz2wRhLzrC1K5OHk88InED?=
 =?us-ascii?Q?2mVFfrcdOPYrmSVqTA3Tnd8HY0A5DaXR0A+H/hq0OIW3xqLWCY631Z4ril7p?=
 =?us-ascii?Q?ZqhY2ViTUGShioioXrTa/SeAfKwqe2ZcH1BAYjRjlcqE13i6PZHCzFvyhhvR?=
 =?us-ascii?Q?vuI4M+/pzmT052vbIpIVAfyo2Z1UrKLvJQQdtmlfu90GqMu3HCfw4/1C06VC?=
 =?us-ascii?Q?KKs7ZhCw+xxqtaoQnOfAnWqRNM53BIcfeq0la+jgB+eS2FWsTUxVxPIlhyPL?=
 =?us-ascii?Q?LZ804x0W8K7cTCO1S2WXu86QKDBW3Fe48W5QvE+NxsdidPE82S1qI8y8Pch2?=
 =?us-ascii?Q?9SIvZdMAgznHURh0jpf2+E3WIBWx93CdIEu5OMecXnpO8VX4ir8TNNWw/rMl?=
 =?us-ascii?Q?57oG3PKoNJKWLmYXqsnvwYkUs+WhMz82pxJiBqEViTXFTAbx4EXpPS+8QSk4?=
 =?us-ascii?Q?X4IrAGZR7Cfz7zXUbOUzZ4pn2dHFPfQ9sszPLsIBjmyVdRnEyj6mEX7qlPwU?=
 =?us-ascii?Q?u9bjr3pjlZTyZ61VVzB4u65KO6GTIwoG7QeoAcLlQS60tv2DAbJLtSHOxI6O?=
 =?us-ascii?Q?DMA2fNrs0B9tCx7SWksqmIIlTVkhQy/fSgY36FopneovOXJkiF8eGZtiE8Tw?=
 =?us-ascii?Q?tqEL9oWRfJKH/3Fc60p7lyBx/hmA481x+PnDN087CrYDLM0cxnUYa8dEa6kv?=
 =?us-ascii?Q?baJU8BHANOuCewoWaxV70MI2DJG6gXA8n32YQ27q2MIgyniA1SA1xdYUGXP7?=
 =?us-ascii?Q?yFQUrqNq503oseg0HpQkySbeArOMqf4ufuJ8Q9/cRK13YHs5TSyXsxvVxPcS?=
 =?us-ascii?Q?bsBh/ht5pe+026imEofsi/OscYqFD1Z9eUr2PQVbmDedIUYKd2x+FG7vwuU4?=
 =?us-ascii?Q?ynQH8uvHfsiZ9rYriuDWpl9lIDD+L6KTVoqzXYD1Bwdgmqy60MuuPOxCiGmD?=
 =?us-ascii?Q?75PKrKXhfcIvJDoR8If2ARIjwcY3KIlQ6cnln1pW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e76122-4393-4879-ae1c-08db5168c09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 15:10:55.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewc9kcsrcle7pVz6J2+LZB43Ql1OkJE0baSUoerZ1B3/SZegpJ6xx37bJjhwN9EBFFIdbTwdP5EC467j1cSDGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: 24 April 2023 21:02
> To: Mark Brown <broonie@kernel.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>; Krishna Yarlagadda
> <kyarlagadda@nvidia.com>; jsnitsel@redhat.com; robh+dt@kernel.org;
> peterhuewe@gmx.de; jgg@ziepe.ca; krzysztof.kozlowski+dt@linaro.org;
> linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
>=20
> On Mon, Apr 24, 2023 at 04:18:45PM +0100, Mark Brown wrote:
> > On Mon, Apr 24, 2023 at 04:46:24PM +0200, Thierry Reding wrote:
> >
> > > Would it make sense for you to pick up patch 2/3 as well? As far as I
> > > can tell there's a build dependency on patch 1/3 because of the newly
> > > added SPI_TPM_HW_FLOW symbol.
> >
> > I'll include it in my pull request for spi this time round so it should
> > end up in -rc1, my thinking was that I was happy with the SPI bits and
> > if it was in -rc1 then the TPM bits could be handled without cross tree
> > issues when the review was sorted (which it is now but wasn't at the
> > time).  If the SPI side doesn't make -rc1 for some reason I can pick up
> > the TPM bit as well, and/or do a signed tag.
>=20
> Sounds good.
>=20
> Thanks,
> Thierry

Mark,
Now that SPI changes are in, can we pull this TPM change for rc2.
Will this be picked into SPI or TPM list?
Thanks,
KY

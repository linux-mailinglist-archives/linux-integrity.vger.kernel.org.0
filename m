Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB26A0FA2
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 19:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjBWSq3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 13:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjBWSq1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 13:46:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59A5BB8D;
        Thu, 23 Feb 2023 10:46:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOwiI5PpQ3whXJy6alJnpwFktT+NQQrY6vHfzR5ARIkwAb9SOCr/wgYgWTp1N0/yseKBHJoKZpmeRxMg+7frNyydNzlMj6m5A8+DXojl5C70rlrMXzZLCSXfKnCm34enLmAbA8aPwDIbSbEf/LrF/CD9gDLeTrXLLK1bEGc86Rgf3JNGMebfaei3OTQCiFgly4GFHMQcZl9FkTFSuv8kAiGrTRcnSYAWRRVgS5iP0NpTjCuTQW9Z5ZtcI34VLQ2bk6mxuvqm0qMqbOXk8rbNjDkpdkQcnGyJ6ytyyVCn2Cl4Ctk7DnSo54CvGjX9xZuXDxEd9QYQOpNsQxlr0Ie2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvQGUaWjDCYRahSdgerL28x/sbP7gp8Cgpn3ujX0liw=;
 b=N8gByeAqKeI7BiusbVhQTt1Aew97ZS7zTnUOzmUUb4JYBV8dzdqMiLRReHmExAirryT+oRoASjR+p4ug9pg5PLJSQD0kLsMCjwJKDo/3JATxKzs15fmfI7/S9Pq7i2VfBqTotylC3i1Ynx4qCocEGYp9yCpu7Npnq9RKDAT4LRGTrtc03S7K2/iCyzg/ZmNXLnKmk22gRou7bakbZ9y/wTokXtX8ZzAzmCvMlo6A9bwKDhZWT1o8NLA7Fu/yNMh4l15WmXVKHo8y/0lRe+KMPdbfy5tpVkBlu0vjw1nWlc1uDetBQ0McTI/JcPeyg2LrnK88nQCBPxEwKjjBTdqtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvQGUaWjDCYRahSdgerL28x/sbP7gp8Cgpn3ujX0liw=;
 b=FeOfcsplLVUYLguo6i0D2kWgJfR2mMDRKGMEXi9zQQPkk29o2jX67OyOPM8fEhYgJnSRuu8abcstTex1oEdFkF58gkWtBah/yvZtraSXgefTe47J9IGFFeHkMr40lqXjhL2CDinWlHgZUlC/6M6eMoQ6FGZz+RLqnvJfhw8gesi8eEuXR6WlsVGFrwPGDWp9wgEafwWQ0f3CTuNxsJ3YmnjQbYazU+vMRyM1t5sta4a+xtvB2VrlLCnyk1MqUS5CkjbW4gSNt1d3D9QieUx4+FHn+GrCpeQgz3MMSZ4y/2tjUGZrQ1qcIXocj5b0p1/LWayhyR5j/88+JlXmtAtu6g==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 18:46:23 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 18:46:22 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [Patch V3 3/3] spi: tegra210-quad: Enable TPM wait polling
Thread-Topic: [Patch V3 3/3] spi: tegra210-quad: Enable TPM wait polling
Thread-Index: AQHZR6OxGxF/RwO310KJcd4KIXk32a7cyTsAgAAUkWA=
Date:   Thu, 23 Feb 2023 18:46:22 +0000
Message-ID: <DM4PR12MB57696F6C2AB9217ADBE6FFE4C3AB9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
 <20230223162635.19747-4-kyarlagadda@nvidia.com>
 <Y/eiQg56fPn17uVf@sirena.org.uk>
In-Reply-To: <Y/eiQg56fPn17uVf@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|MN2PR12MB4392:EE_
x-ms-office365-filtering-correlation-id: c00e585a-8a37-4544-fc03-08db15ce429e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OvlB4Dj1amgOkKmyPXLZg+KhnorM6hCVwUPXzeR1tXEcRckifhOtV3OR2CeS2syjxK18ZqmQNAHO7Swt9PzqluOOo1Y9q2xfAPqtnXYYn56NJ9eIbbQAcjGSy7ENG2P0ABvpstxAzGvqKyoBD/Ey/YvFqRwiwSwa9DW5vUv5M9cWJjETwFL4EU1Drtzh0D7rItRcJVHI8LUhNuojuTiIjOW+uAgiMC5d0IHUIBmgjWKx3TmjRR0aQUu2iZ9nTncwsfmO7XECADmTbKZh28m6bxCwdzcu3MwFdbqeAPi7GbXN5+oXekBuOOfS8VTooP1lM2HlqBhxfjRbm1xMD2fIjw2NhkpHBOqjaUU+HCnsqSD2FJ7fzyNgXm6peY7tWWzlg1+fsFQUEUOqxqXCczRWI7JeR9oJN1YKYLQmA+ZLJ3Ol4kXx8vhQDZjZI1GI4cDRCQcvU944bd2Io/BwL1AXVKQ9SRNwwHDwgavh6IZlfMSaYfiyY5w50HIzL0O1WX1cFWOgE1dMXTm/etC5JGUeuURHBA3gW5hIl+/OwpTVrAg1OQbaDuX7nw3bmCk1VU2jIA3QfcJlENAFXansBXasdp8HotHMfEV+CqAIPTZ7TECYv15mWzjtUooPzN2+PyNPJ55QTpAkxYD+0KTivAmZSGJNoCwy/RXlYZ1ikCtT07G31enY1olWpaO2Dplkdl5b+plyFeBrXcFNPgI2h2XGsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199018)(316002)(54906003)(478600001)(7696005)(86362001)(52536014)(7416002)(6916009)(41300700001)(5660300002)(8936002)(76116006)(2906002)(66556008)(8676002)(4326008)(66476007)(66946007)(55016003)(66446008)(64756008)(107886003)(9686003)(6506007)(53546011)(26005)(71200400001)(186003)(38070700005)(38100700002)(83380400001)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7gTkwG1/PMpmYPWr27HfJdFAfOGEQFPdBV8axjSu9o+tIJ5ptN9kEbNjiHo0?=
 =?us-ascii?Q?6rXSwV9G2SZ3cvM/bO0YIf/SrcwiGaKt99AYVlr8J65gvYdsTz/S/hCeCpxX?=
 =?us-ascii?Q?GUZ7JGPGiK16heDlmWPrn5xNxdTDrV4fLIP2vqhlMM83uMJys6bfMstTbZPU?=
 =?us-ascii?Q?LkPgR+AZO3lAxQeB0hjgTJ76G+QTxnuXq2MvtM9zdpqUaeN/5Bb/f0a/cwRj?=
 =?us-ascii?Q?e3PjI+8p101D2vRnKXHQ7M99k8ZxVgluIJtxyORsCLfvC0ai27K+c1VkwogU?=
 =?us-ascii?Q?KGBm8ltaRiRxZvzOg9Pz1ikc7WArpucnkSpHxPljdJuHi0/LkL4C+jgPiD4w?=
 =?us-ascii?Q?kXtaHVWHf4jJx4oVldiyujJ/pBhaCwTUMx68b4gnIypMSYqop4euwJ7hxaa1?=
 =?us-ascii?Q?TbCebfwxpst52nUKZBLvY+SLUYxlBgifHeNDOWCltrjd7/gig+wO+Zz027eg?=
 =?us-ascii?Q?tEU52pvOua2uyc4vK55Jg9kM2iZF7eIYNlep19g5YMxMkfjkQR5npvoclVCy?=
 =?us-ascii?Q?dCLn9UL5JlqpnBsEadNK7A8nMIM8ltBQ//cRuwMSocFPRI+8JCv72tBPZ2FF?=
 =?us-ascii?Q?k76R2LBpvrCz6jeAqN+WX6i5ZweH0C2lOyGd+/+yqXStRTy+z8IKgBTq7gxO?=
 =?us-ascii?Q?Bg1w4G3wyLlQVFdcIEUZROtbd11B7mEMjLtfcPZ6Ee37q1ySi/GRRQkorC8f?=
 =?us-ascii?Q?Mi53JciXuwkBtYPj9Q7pS9luLDl/nbhxxeYnqbtv1vPXIFCGcGXrhOm8CEdD?=
 =?us-ascii?Q?ixekeMWUhZP0C6nb1IDXmb0MG2S6DgwyoRJ1nza0/k0zVZhxiLj+3np3u0N8?=
 =?us-ascii?Q?aRd80K86gPFb+JR6PxAFLJtyuoYMDq+MYUsGHkUk37G3v7bHLyHssgXayoaD?=
 =?us-ascii?Q?r96RzMQ6YWQf/XBV+U1iJ7iIK41Y5523JxFARLg0GFqiif/tf0s594J5Vud3?=
 =?us-ascii?Q?aKFc0fgXi1+iIRa/Jz9ESuoGaNLe/SuGWoyd4iD1uw+u3oJo0xcsqFK+vOfi?=
 =?us-ascii?Q?h25i0oQ6bzs1wBSp+7Kd4CnvIltrH/C2j2TGkLAbupT5YUUSJ8DNtGnWitHD?=
 =?us-ascii?Q?Q1fyG80F1sD7q15GdvgVJ5zYEvcaUs+r4VREkHKiLFvMQE8khlXZGNw+vRK+?=
 =?us-ascii?Q?6rDQi4t9BLBfFhXPOltwZ+movoPnD1OSlk7+MvlBMwHc9GcJYbTVOVsdikPY?=
 =?us-ascii?Q?8iYhM+LeMXJeHgL9P/Z+T+0mUFbhABJdx4eIYlxBSeeLGBPj/OVqIqE9qEc/?=
 =?us-ascii?Q?xKykEgSUeeVnG7go1MdCzyL3kLmJ7wX9yk3uLu63KxL8SliGENa19t1IuOuB?=
 =?us-ascii?Q?QR1u9NMfk5xY7PAK2ulNHd5U5+6dXZQHm5IfWq94I+CuYyY0UzhIJzdT2ahf?=
 =?us-ascii?Q?e3BOKgdKORB8oSKFOcG4v97QW0C+KEi815ciIocJNLOVD3GGqN/Jj51hEhwZ?=
 =?us-ascii?Q?uXXG9MUX9bLG+KlvSZ1p8OJAZogigmHTlsYIbtf5UymCVWOHGHce1jbP4nXw?=
 =?us-ascii?Q?TGYRS640rpHeKI4qEkLBVVFsF8ua/NroZ9/WP5Q+kh2J5Lr7E7R/sjTiK0Xj?=
 =?us-ascii?Q?rXfRmx3pAwP8570PRvX7ybuonUmgvZn6ftK/2llW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00e585a-8a37-4544-fc03-08db15ce429e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 18:46:22.7594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7AwmAkRP1en6/ZOINULi/60v2VylImD26cpLLEZDMHw1v8VXBtnfyn3S3vakcR1c4Kcqkx5VOIEkh/LlqEEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 23 February 2023 22:59
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> jarkko@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>
> Subject: Re: [Patch V3 3/3] spi: tegra210-quad: Enable TPM wait polling
>=20
> On Thu, Feb 23, 2023 at 09:56:35PM +0530, Krishna Yarlagadda wrote:
>=20
> > Trusted Platform Module requires flow control. As defined in TPM
> > interface specification, client would drive MISO line at same cycle as
> > last address bit on MOSI.
> > Tegra241 QSPI controller has TPM wait state detection feature which is
> > enabled for TPM client devices reported in SPI device mode bits.
> > Set half duplex flag for TPM device to detect and send entire message
> > to controller in one shot.
>=20
> I don't really understand what the controller is actually doing here, or
> what the intended effect of the SPI_TPM_HW_FLOW flag is supposed to be.
>=20
> >  	/* Enable Combined sequence mode */
> >  	val =3D tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
> > +	if (spi->mode & SPI_TPM_HW_FLOW) {
> > +		if (tqspi->soc_data->tpm_wait_poll)
> > +			val |=3D QSPI_TPM_WAIT_POLL_EN;
> > +		else
> > +			return -EIO;
> > +	}
>=20
> This just sets a bit in a register...
>=20
> >  	val |=3D QSPI_CMB_SEQ_EN;
> >  	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
> >  	/* Process individual transfer list */
>=20
> ...my guess is that setting that bit causes the individual transfers to
> be delayed in completing without further changes?  Is is just some
> transfers or all of them?
TPM spec define flow control over SPI.  TPM device/client inserts
wait state on MISO line when address is transferred on MOSI. This state
has to be detected by reading the MISO line which needs full duplex
transfer during address phase. Tegra QSPI controller can only support
half duplex. But in combined sequence mode, it can detect wait state
inserted by TPM device and send or receive data when device is ready.
Detection happens on all transfers with TPM.

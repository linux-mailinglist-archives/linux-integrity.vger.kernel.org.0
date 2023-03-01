Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4386A6BF8
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 12:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCAL5C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 06:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCAL47 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 06:56:59 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764BD2CC46;
        Wed,  1 Mar 2023 03:56:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDNaiQhykfqerTvP1OpHGth3wNtibK+x599XGrtSIb4dy9078rH0WslSglPcJjyobdWqTqp7QaS8x/Frk0Y0i8Dg9l3yGFuNC8nIqzm6bKhU2xGRsFePi6B/0/96xAVgkKTBH0tIDazY82BvVCC1WWBNj16MWa2dAwYj0jFlFDCvrI4W0VdzZDR60+bP4iWtzoMgJ5g8APytHzI7FDBWtigFMiUgKtPnSNQ2zCiG1cyjmNy7hiZQG2fpt+Q3TKr+TmDOSsVRutSid6pfDkHiRjjaXmG32Rnx7WmL0icAY3O51U5mJSfdiGkVd+WeOSMILKuSm/SjwXkuf0b1smDZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdaX/H/FfIl7iktSsMfLiTNGaIQXFdQFw7iT/cpOO/U=;
 b=mdlK2IvDqsT81hppbDLNhyJfIJLmQA18QJ4oIvomSKWV5VvvR83yLeYkehjvTaVI4EvRDRfTEJ62OW22+kXDeFSWBEh6k9h6TEmvT8zRp3E7ZwZ2qcpUs37UDuU87223j1BJr7ajQeCYbD3qsfL2pOW+0KASU9C6DB8c85nnQrcxW/N6J7yzTdAylAFbQgq64BJGzclWEJL4TBLlkwNvy6NyonEYD3kvrP/XsGKkbWzf7upaR5Gg1+f5kwuo/zhFDwz6MignxGSaCuaIogTVMUTv9UKPfxih6LWHdepH6+9snCR3ZRzfO43fb+PhnzainApTUTIr4sb/kVaKQ7qL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdaX/H/FfIl7iktSsMfLiTNGaIQXFdQFw7iT/cpOO/U=;
 b=KwAhIYH1bEmUfGT9+zf3/6CYJnfLOEg2uxHN2tNurXFssQYmZfWT6iI7h98WfvQEDqWtadM9J7uzavEACI9LQiQwEtbqsZha9AIjxz1sgm9oRWUfrwlrIVqjCRm63F8D39MiIp97pfBm6CvvNGtIDBjfzxjROdB4PVSQSTT9n/vjL46R1IrAF4OOmVN+y5RttHQKa84ua5sTp0UTKIRYOMQQGHB4HuapNPRJDNUeHfVcOsCUt1PF+geF+X91H/214H3ORYvktqTFdaqDIBZ7BPSp3hqoSCq5CDckhhbxcvm0zMPueeCb9HE02lEF9lC/Ru0lIZLN60+rcrcP4w4S1Q==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Wed, 1 Mar 2023 11:56:53 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 11:56:53 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
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
Subject: RE: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Thread-Topic: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Thread-Index: AQHZSqQUcW4yC19F/EyRW9qbZsaOO67jpaAAgAClToCAAYhzAA==
Date:   Wed, 1 Mar 2023 11:56:53 +0000
Message-ID: <DM4PR12MB576942B7C00F446BDF58D984C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com> <Y/1oqr0RfD7KVA4y@kernel.org>
 <Y/3zVdgnVz8BvGGl@ziepe.ca>
In-Reply-To: <Y/3zVdgnVz8BvGGl@ziepe.ca>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|DS0PR12MB8270:EE_
x-ms-office365-filtering-correlation-id: 29d8a4af-1396-4832-1584-08db1a4c0ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +hJNQWbrCoqsuYJXd932RemB01gHBazBVQaRnlpzSVeNrrgZ+cBjH71czrcc6sPkJJ9cBYIRMA2G5CnnD0aqbLQUBN9IJcHacwFrcSNhPmfp8hzP6ZqKIeJoCBG4i7dJ4mAxNSOekGGTGIpe2fvniVjo89i9gx10dQF40/J7Nwe3mpalhKfW9rRBtmYG4x4HMCuI+2gCqu2pGIqG1KNOZW2NJUpf0ywif/5R66D3HbuWLIfbYQUI681GeUZE3dFMwLh4UHsBRCHzh3EHGLXMrfJ66ft0KwI+spi39f21frRib7z/nB6xgJ7onauvviKP1jYUAQy2A7tKLJsXzHaM6a6EgGOBgLxZczxTbQtLrPCihrpvKpuVtVxVZj03fYTn413MOM6dgcX4uiNlfqfHQBs180QDKY9JAThYue+ItH8QZ29Qk1+TjVrnLXWh6UEk3/DLHP54wBqT3BYJVb5n0Gt1xnA7iqxAApvPL8vxWMtIqapNv3d3RgGvpfDvZBFvQn4a+1r2+s9TJ2jubVaV8pqPDjLorThDwrLERBmaMtW+HortMHERYolaAiIVGgcx78NNo8wRLltqlR8RsWEMEnIyKVwBuxod17IbcaQT8pIgCkgNwd28ib4pHIXq6L+be07c2pqhwPTHyQdKE60e2UcRCjMOWOyf/RGdUP8ejU0D08VxMS2ybk2/j4H+H2m5jk/S+CPAvq+Q6BEUkTfeSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199018)(122000001)(38100700002)(38070700005)(52536014)(86362001)(2906002)(7416002)(64756008)(66556008)(66476007)(66446008)(5660300002)(55016003)(66946007)(8676002)(4326008)(41300700001)(8936002)(478600001)(76116006)(53546011)(9686003)(6506007)(186003)(26005)(83380400001)(110136005)(54906003)(316002)(7696005)(71200400001)(33656002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Dik6+/PG+LL2mIg6JgE6CBaPuQZrDMi+QIg0eVPyzTwD+i3weXelMoHQXSr?=
 =?us-ascii?Q?0fouohplr0M5m+RLVG+5nOaqMO4ztcQ1nPRT6WyakmZ0XCp9p4tWaLQT/yQC?=
 =?us-ascii?Q?lQ7jk31oi6U7bG8jmf6ChjdhyT8FUD0gkAOfChklP65m9uetRO9uxZnwy5mj?=
 =?us-ascii?Q?EoJKV+2Sp4KYiHC3tvFICDoVthMBXEfgDY0JYEop74IN1RZ0XA6VeAe1pC4c?=
 =?us-ascii?Q?+D5A3bFHAUaaFJOjCvqN1MC0wHbljkI6CMqUTUPHm/BeGq50JwktIZBXRy0D?=
 =?us-ascii?Q?ayU9ci18J+rO2+TDCM/PLpVMudU/86g1kV3pOzF651tmHA5F5CZOrrcUM7n9?=
 =?us-ascii?Q?hFfX/20Y8DT/BqqA3pMZ3vbOfmSrMrEMEyX0HKeKgOKe+BGdjAVnVPSouNtu?=
 =?us-ascii?Q?tBvbeHGFhFDL9Efv7u2GDHpaGevBYOC0s5AbWzWAIRNVNfTDfotAXyNrPWcf?=
 =?us-ascii?Q?rwz9xW4eVO5LH589AtOE6BhaI7Eq+J8sZ/oFg/bCWjQcRhwn2R7iJxaLZ+O9?=
 =?us-ascii?Q?N1QRlrzj6f27+fsEu7nLBUAa0A+T4Qq31kuhM2M+QArT/0K+bkh+KFShh2HT?=
 =?us-ascii?Q?i/MZf2l4WsQvrksUuOATPQqB9Vgsre6auMEMo70gmv6OFjqdN/RWdwljTExG?=
 =?us-ascii?Q?vF06JhfZ36Z5l3IMyxZcRUxPccki697Km+94S47R6zWV1Hz+2i3swN4QY/EC?=
 =?us-ascii?Q?oudQmBINI2qkHl0aISsjgQlSq+U5M+Grd8WZE4PmkrI5X6h7vcYVOwcNr8i2?=
 =?us-ascii?Q?t5BakPlZ+JUwSjLhR6RDJ9KroZ5jMwobvJleIcCYyGFVIi5wiTWCUNmWgBvy?=
 =?us-ascii?Q?BuHqmI3XinOJ+w9GU/TqPLYIp2N4xe7ojIQaxOLSHkqrSok0VvFJgEVTbE+b?=
 =?us-ascii?Q?Hu6IXdUXT2MFBVhjZ5iBFmWG29Sar5DISTWRi+ma4I+/FZ3KpowDZN7eCk3X?=
 =?us-ascii?Q?I5ch2NpcA9T4Zh5B47C4eM7QRl7a1kMQR6SFbqoEm8/LTeeoRUfUgQdTSydE?=
 =?us-ascii?Q?7Rq26U6s4BXJttU6PDqUdlOcOjFuQC/Vj7RqrZ4hjnLjuWnpd+LeJvG+TelB?=
 =?us-ascii?Q?Op/K7tQ95rACOSMinS4uPdIsoVsmexN3aXWO/5ECP96Z36EEjpYv9BUk+IC1?=
 =?us-ascii?Q?6VDwGKRE9qGuep8PdcP0SizIVN9uMPbygxopUH2Q0Oi0S3kLL7Kos5fkeLi7?=
 =?us-ascii?Q?REnkbGuH0jfok3prgt32jvwSoLM766i6Qhd1igMllTiL0GbFX8Vh3S9Wvb79?=
 =?us-ascii?Q?A4vsLvghNQUjLBpPZFjWN2dTiG8VYtYQ7gTFm60MZ5AB01i6n0WS0lQCuEQ5?=
 =?us-ascii?Q?rht4D/cuZ40DQ2GQiSnUJfqVGWEBE51JiypAGPF1GBowuLbe6gjc6n/74ZSz?=
 =?us-ascii?Q?/ZDwYR6sGZhVXDqYjeRYP990D0caSjL/djQNARL2J4rVd3UfMgBsMKu3wAD+?=
 =?us-ascii?Q?lXucg4pZb22Iy2MjCNIADmleGSNsb3h4gcHozDL61OCf/qbpNZZwnuenCPOb?=
 =?us-ascii?Q?NswQREZbxm3FnMs5uNijMP8mpBzhjO4uKeSxpbzdq0A3vRSP0Ra3qjUCL3HD?=
 =?us-ascii?Q?a611yEt9JeWu9erNOj8v2/TgOiYNfPvulXHsQ5Bi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d8a4af-1396-4832-1584-08db1a4c0ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 11:56:53.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Y+mIEc9kNi1ikl1MYxyQVIp/nk0yr8v8zEClKVe8voS/gNCOi26mHnImHb1uUdbuVkyF6oxHe0y/t6FCCLmvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 28 February 2023 17:58
> To: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Krishna Yarlagadda <kyarlagadda@nvidia.com>; robh+dt@kernel.org;
> broonie@kernel.org; peterhuewe@gmx.de;
> krzysztof.kozlowski+dt@linaro.org; linux-spi@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> kernel@vger.kernel.org; thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> Subject: Re: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
>=20
> On Tue, Feb 28, 2023 at 04:36:26AM +0200, Jarkko Sakkinen wrote:
> > On Mon, Feb 27, 2023 at 05:37:01PM +0530, Krishna Yarlagadda wrote:
> > > TPM devices raise wait signal on last addr cycle. This can be detecte=
d
> > > by software driver by reading MISO line on same clock which requires
> > > full duplex support. In case of half duplex controllers wait detectio=
n
> > > has to be implemented in HW.
> > > Support hardware wait state detection by sending entire message and l=
et
> > > controller handle flow control.
> >
> > When a is started sentence with the word "support" it translates to "I'=
m
> > too lazy to write a proper and verbose description of the implementatio=
n"
> > :-)
> >
> > It has some abstract ideas of the implementation, I give you that, but =
do
> > you think anyone ever will get any value of reading that honestly? A bi=
t
> > more concrette description of the change helps e.g. when bisecting bugs=
.
>=20
> I would expect SPI_TPM_HW_FLOW to be documented in the kdocs to a
> level that any other HW could implement it as well.
HW implementation can be controller specific. I would add comments in the
header to say CMD-ADDR-DATA is sent as single message with this flag.
>=20
> > > +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 le=
n,
> > > +			 u8 *in, const u8 *out)
> > > +{
> > > +	struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > > +	struct spi_controller *ctlr =3D phy->spi_device->controller;
> > > +
> > > +	/*
> > > +	 * TPM flow control over SPI requires full duplex support.
> > > +	 * Send entire message to a half duplex controller to handle
> > > +	 * wait polling in controller.
> > > +	 * Set TPM HW flow control flag..
> > > +	 */
> > > +	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> > > +		phy->spi_device->mode |=3D SPI_TPM_HW_FLOW;
>=20
> Shouldn't we check that this special flow is supported when the SPI
> device is bound to the tpm in the first place?
TPM device connected behind half duplex controller can only work
this way. So, no additional flag needed to check.
KY
>=20
> Jason

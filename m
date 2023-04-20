Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B86E9AF0
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Apr 2023 19:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjDTRjX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Apr 2023 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjDTRjV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Apr 2023 13:39:21 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76D5114;
        Thu, 20 Apr 2023 10:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFWDlgYYul4Qa6ZBTh9hdEbwsJ8wHCqvfiv6bhSRHmMrF4EcUiMJVjIH9D63qKGq0qwNacuCn1bhUy2Ka667IlNYGvzEewgZG/zypOG26xpQNcpLBsjWg4foCWk1zfRnUkrqSY7nVRzTnd09T3lRX+Ewg+UiNdAgZvuxs/soCxG9MqEK00zJlZ1XNH2/DMldEpjjizMCaYe1AiqpclV7Le+8IAwbITURX9JcLqgWZiHEqauQQPrrHn1wKHiuAhWWN+4nsShA1GUbEgcfyFQzCp3Bsxt6gGmaOzboghJS+L3YvSxeyByPkmxrhew4Du75fXXgfG5iwZ00ZzGur+RxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhUjXrgAXJMp8bcKX211gL0OP6157yXawXify/h5qk8=;
 b=i9sYaklcvKDQwAKhWEGwb0/qJJiMMid5A7mFXQuWOyI0VDQgUz4ISwQnpz1qZ6R5a67T+XbdAf7tpvoM5ks2BkSXS1/WObSIlgw8bt5O7N6tRXQg4lJ91wtsAIErggm8wG6ZmJCCnBHJDDU4lmTTuqVz6MDaURVP1csZqMdUkUzAYFDYKI8sTOXJ7Vhq/CwTA29yrrS3Ha5E8hPaalGj8WfkTtjGTOQq5FVe+nFIKNCWOOLwZZ56SYgUsDjc0+RGfuTJm2vW2QTZ7GGsvzbd5TGZPJaJfakNE5EBfULzITNp7PzmLZdFsJtgE/Ec34RyMwaYlEKhFQhLUPNlj9AxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhUjXrgAXJMp8bcKX211gL0OP6157yXawXify/h5qk8=;
 b=aUdWffgEjsw0fUkqEWzvHJqEkMmhRqiT9ckBnLIYPPViXWtNnzJ+NZe58bIASDEs7dVlk8COfbAefQ5OwPzppoA7q+e46fUAEFfJa9Lk/UThBersrWohJ8rtnM6qrZ1A6DZd+99beSRECuRVYNgKc5P3UwaeBXqhIrPNd8IUBkM6wLLEOhP79HfsxS6PR/iCc9GuwzsUJLRMjJ8EwFyIf5ImUbBEodiu7Ra4Z0oWyMyY8bO6esuHR9xOg3iy9RIpg3lWwJb2WK31AYIkPGiKL6X47j7zYxOhoit69uvu086rfnGmm15CaDc2kJ+dcJmqh49kGqwiN5TYEL5Rn5OkiA==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 17:38:14 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::2c4d:1cf:626a:370d]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::2c4d:1cf:626a:370d%7]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 17:38:14 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Subject: RE: [Patch V9 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Topic: [Patch V9 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Index: AQHZX0h81KY9bh9+SUqG7w2Lpn+Pn68zojAAgAAK9gCAAO+4kA==
Date:   Thu, 20 Apr 2023 17:38:14 +0000
Message-ID: <DM4PR12MB57695772834DF2FEE76A0C58C3639@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230325183409.7695-1-kyarlagadda@nvidia.com>
 <20230325183409.7695-3-kyarlagadda@nvidia.com>
 <a6jhf7wghnos6yjvgt3rbudhwsx4r4r7kurm35euofz3mjwmdu@74z44ohjgmre>
 <enfduqgdgrdpfw73suydlbmu3mopk545vwrpoat2chkop375np@o3fxh5k7wc76>
In-Reply-To: <enfduqgdgrdpfw73suydlbmu3mopk545vwrpoat2chkop375np@o3fxh5k7wc76>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|SN7PR12MB8147:EE_
x-ms-office365-filtering-correlation-id: 43f0752d-25b6-4b8f-ce8c-08db41c60514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+QVC/dsqTAh2l8PQ36N65fU2tp100id3xSvXO9rtNZTwIQ8IjYjurxL26+SInFa1UNuK2WDNWrPAP0koFL8xU5VQhpPjAgODjyqDdZ6BLRtmQ0VQ0XsLZcjF9w7wPTiUpS9VYDjUIaKqrAjPNsCxoI6yqx+6s7JwgWkVX+ANHZNXCrVne4kFQPMiPlwfHWltMO2Afpl3DT0cMyhwTRuTiqjF3xeb9XmCxsIY/sDlELr0BQpKdjaskUSLTprju/AiqOWPT+LOuB+5jOdzghTpg5jXmMUlSBuat6OPeTtS48U1Vp9NVJr9KESmvyAkjMwuXl9354msgTGRgUdXwV1WWZBazr+7+fk4qQlPpMZ3IgfNjOPcYZEfEhpk2xKGFKKhqOrXnh3DbELQU84Nna/8VIA3fxRTWeNpolXvEzXhuISMR529qFC42Wc3AGXRxEUlTOYnbWQ5LEOYcCDcPewBwaF7mRg3UP3vN9NBb2O30WGQ0+mZPMzebJq0RgD0RlJpF7mAzBbHj5vltKauUm9csr8aUH3fqEE9PwzAmhnjhGFpYtmQxU2dawkpROUaaLAwbd4HhyblGF50Idwu3EwraY62ioyw7CXA/odpJ//vLUzrdI4dG6cOjSikQoUYhQb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(186003)(6506007)(71200400001)(9686003)(53546011)(26005)(7696005)(107886003)(52536014)(5660300002)(316002)(4326008)(41300700001)(66556008)(6916009)(66476007)(76116006)(66446008)(7416002)(66946007)(8936002)(8676002)(54906003)(478600001)(38070700005)(38100700002)(2906002)(64756008)(86362001)(33656002)(83380400001)(122000001)(55016003)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oONG+qVKcIUl8efEyWpXmKsC4L+vd0u3CHxEa+9kIhkonbMWsiBcn1gHsWGH?=
 =?us-ascii?Q?wt2etB5YSq5s1syUX9E7taVGs/2yWrLZrulk+uIC2Cgyh6Sk8Vq6h2P9VzuG?=
 =?us-ascii?Q?NBsKTBxaXw0M5PLeKGc76kR+ZwolCXHb598oS7nRz0PGIaz6v7tFwmQbrnFS?=
 =?us-ascii?Q?VIm7h84EacxHcnSGc2olZx8R+xY+iU2atytxhiLmL0HWosT0xmkufg4nKrf4?=
 =?us-ascii?Q?iyZAp/+wddlaTScJyYx40nyp1gMDRJvU+o4zta83RhXNGAMy+uTKgoVT7s6p?=
 =?us-ascii?Q?Wmrj0BWY2uHy1f203oUTZ1xj8nGTDMXHEfeOEApO+TEAEh7bsUJlrgw5uxeF?=
 =?us-ascii?Q?QCYsSVRokOdfxIiap3kt7fFOP5C6nLiK5QTYHA+XHC4uLsg7scLjA0OmHt/K?=
 =?us-ascii?Q?TFxq+P0kLseDVWICYJUkosfeDUjel2itEz0Gg4uCIqJ4JOpxdb8dBg4w5ZOG?=
 =?us-ascii?Q?44x8Y0B0c7PCr3DVWW7lCtMvNhI6vwdaoMVsOrcgrmWOL+k2JYW5kO/pQkKx?=
 =?us-ascii?Q?+MmlTDvarotRCh2+zj0iTazP85lFpEmh2Ux+895vNyUWIThajgWqqRlgXhnt?=
 =?us-ascii?Q?Ci/3XGo8FT9W4SoztqQLvE0wmSR0oXvGb3rE50ckxZYX1adHzJLPLnzxWZFy?=
 =?us-ascii?Q?1e7zuunY3e+qmy8Iu+wXMoubq+HAf6NYLioohNr1OPPMjfHrLPGJd2BMXJ43?=
 =?us-ascii?Q?qZmG7Rrrn6FfcK7CO+C/O/TX3+aDiJtZP6tJEcn7lj9S2DejtKfQRbxD25Ab?=
 =?us-ascii?Q?FtR8AeTHucTwpnic7VcPYP2a5Q8FqrFqMQkfdKpYMVler0i8BdHKZtouJYS6?=
 =?us-ascii?Q?Z8aYkNHZpF+7E0ggMgJ7ablayun0jfs2BOdTsdNIN/Em85udc0yGmHt2zsup?=
 =?us-ascii?Q?z8/woDyVxNy4RwhDAA3iHPeqsZWrzpI3k0vw2hCV1L2liroeh3TG7OOCIJEN?=
 =?us-ascii?Q?+UzwMNvw4WL6XSaDeingdhftTK7pjOZKoKbgV5Zx+T9M7NWcZPzKOzlS5Z+8?=
 =?us-ascii?Q?BB4u1Y8uL5lq7g46drhNNvf+9mnr/ukkhUo1PdVRF/7+MoFh9AE9dYwCk6j6?=
 =?us-ascii?Q?0FrrfVsoHFzBn9h9zYkKsocG99KGjK9KGUvR9RlH0IpfB5lRqHpP2LtVEiGs?=
 =?us-ascii?Q?WviB7T75FdM90n2xM41yqmD7QHnUm5IL54Rd9FdZ1WW2yZcqk+OMAcyyvD/x?=
 =?us-ascii?Q?BeV5TrinK2kyjELahKbrSHz9XdmlwpaKhy15WR5h5S05YnISn5TGOSUhLrbI?=
 =?us-ascii?Q?n6LHgk1S6mDddtUBqhm5X8FwVsYz+Qgj1U4+b9WAgkvYV5Ci1VReLiJWw9XC?=
 =?us-ascii?Q?gwAQ6jfOiqICeNAbXEuuNK9rdl+twyOZ/jZAVhtUJdu3fSSvvTRSCyyaw1na?=
 =?us-ascii?Q?e73JmKKwF4jb/TQAxQepdWYT1n1j5K0fpGQghGzT6JzvVei8M1eaJ7/F21hl?=
 =?us-ascii?Q?4GVHIFX8pYn1IgJDYa9czK9iGWISvcMdHhglYusdZVTCdkVqh7agcQ76SY6d?=
 =?us-ascii?Q?mMYKTKFRhbTNeJhc8sqd+r2mCayKDjdQSqPQnYC8Ir1UeWSl5NhUwO6whjKS?=
 =?us-ascii?Q?wdQHlNVYrrRo5RPZJYujTQIkVKnNoBeRUP3dSXwi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f0752d-25b6-4b8f-ce8c-08db41c60514
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 17:38:14.7511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6ZasJZRXrhXxi1uNJyyB2Jcp/sm7576AW3Xf5RREpWFowCs+OwG2JEUuNhKDrCrWWa0zna535baMe5pvxmfRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
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
> From: Jerry Snitselaar <jsnitsel@redhat.com>
> Sent: 20 April 2023 08:42
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; broonie@kernel.org; peterhuewe@gmx.de;
> jgg@ziepe.ca; jarkko@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux=
-
> spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>
> Subject: Re: [Patch V9 2/3] tpm_tis-spi: Add hardware wait polling
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Apr 19, 2023 at 07:32:40PM -0700, Jerry Snitselaar wrote:
> > On Sun, Mar 26, 2023 at 12:04:08AM +0530, Krishna Yarlagadda wrote:
> > > TPM devices may insert wait state on last clock cycle of ADDR phase.
> > > For SPI controllers that support full-duplex transfers, this can be
> > > detected using software by reading the MISO line. For SPI controllers
> > > that only support half-duplex transfers, such as the Tegra QSPI, it i=
s
> > > not possible to detect the wait signal from software. The QSPI
> > > controller in Tegra234 and Tegra241 implement hardware detection of
> the
> > > wait signal which can be enabled in the controller for TPM devices.
> > >
> > > The current TPM TIS driver only supports software detection of the wa=
it
> > > signal. To support SPI controllers that use hardware to detect the wa=
it
> > > signal, add the function tpm_tis_spi_hw_flow_transfer() and move the
> > > existing code for software based detection into a function called
> > > tpm_tis_spi_sw_flow_transfer(). SPI controllers that only support
> > > half-duplex transfers will always call tpm_tis_spi_hw_flow_transfer()
> > > because they cannot support software based detection. The bit
> > > SPI_TPM_HW_FLOW is set to indicate to the SPI controller that hardwar=
e
> > > detection is required and it is the responsibility of the SPI control=
ler
> > > driver to determine if this is supported or not.
> > >
> > > For hardware flow control, CMD-ADDR-DATA messages are combined
> into a
> > > single message where as for software flow control exiting method of
> > > CMD-ADDR in a message and DATA in another is followed.
> > >
> > > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > > ---
> > >  drivers/char/tpm/tpm_tis_spi_main.c | 91
> ++++++++++++++++++++++++++++-
> > >  1 file changed, 89 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c
> b/drivers/char/tpm/tpm_tis_spi_main.c
> > > index a0963a3e92bd..db9afd0b83da 100644
> > > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > > @@ -71,8 +71,74 @@ static int tpm_tis_spi_flow_control(struct
> tpm_tis_spi_phy *phy,
> > >     return 0;
> > >  }
> > >
> > > -int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 le=
n,
> > > -                    u8 *in, const u8 *out)
> > > +/*
> > > + * Half duplex controller with support for TPM wait state detection =
like
> > > + * Tegra QSPI need CMD, ADDR & DATA sent in single message to
> manage HW flow
> > > + * control. Each phase sent in different transfer for controller to =
idenity
> > > + * phase.
> > > + */
> > > +static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,    u=
32
> addr,
> > > +                                u16 len, u8 *in, const u8 *out)
> > > +{
> > > +   struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > > +   struct spi_transfer spi_xfer[3];
> > > +   struct spi_message m;
> > > +   u8 transfer_len;
> > > +   int ret;
> > > +
> > > +   while (len) {
> > > +           transfer_len =3D min_t(u16, len, MAX_SPI_FRAMESIZE);
> > > +
> > > +           spi_message_init(&m);
> > > +           phy->iobuf[0] =3D (in ? 0x80 : 0) | (transfer_len - 1);
> > > +           phy->iobuf[1] =3D 0xd4;
> > > +           phy->iobuf[2] =3D addr >> 8;
> > > +           phy->iobuf[3] =3D addr;
> >
> > I haven't looked at much TPM code in the past couple of years, but
> > perhaps some defines instead of magic numbers here? 0x80 is the rw bit,
> > and 0xd4 the transaction offset?
> >
> > > +
> > > +           memset(&spi_xfer, 0, sizeof(spi_xfer));
> > > +
> > > +           spi_xfer[0].tx_buf =3D phy->iobuf;
> > > +           spi_xfer[0].len =3D 1;
> > > +           spi_message_add_tail(&spi_xfer[0], &m);
> > > +
> > > +           spi_xfer[1].tx_buf =3D phy->iobuf + 1;
> > > +           spi_xfer[1].len =3D 3;
> > > +           spi_message_add_tail(&spi_xfer[1], &m);
> > > +
> > > +           if (out) {
> > > +                   spi_xfer[2].tx_buf =3D &phy->iobuf[4];
> > > +                   spi_xfer[2].rx_buf =3D NULL;
> > > +                   memcpy(&phy->iobuf[4], out, transfer_len);
> > > +                   out +=3D transfer_len;
> > > +           }
> > > +
> > > +           if (in) {
> > > +                   spi_xfer[2].tx_buf =3D NULL;
> > > +                   spi_xfer[2].rx_buf =3D &phy->iobuf[4];
> > > +           }
> > > +
> > > +           spi_xfer[2].len =3D transfer_len;
> > > +           spi_message_add_tail(&spi_xfer[2], &m);
> > > +
> > > +           reinit_completion(&phy->ready);
> > > +
> > > +           ret =3D spi_sync_locked(phy->spi_device, &m);
> > > +           if (ret < 0)
> > > +                   return ret;
> > > +
> > > +           if (in) {
> > > +                   memcpy(in, &phy->iobuf[4], transfer_len);
> > > +                   in +=3D transfer_len;
> > > +           }
> > > +
> > > +           len -=3D transfer_len;
> > > +   }
> > > +
> > > +   return ret;
> > > +}
> >
> > Does tpm_tis_spi_transfer_half not need to lock the bus?  The doc
> comments for spi_sync_locked
> > state:
> >
> >  This call should be used by drivers that require exclusive access to t=
he
> >  SPI bus. It has to be preceded by a spi_bus_lock call. The SPI bus mus=
t
> >  be released by a spi_bus_unlock call when the exclusive access is over=
.
> >
> > If that isn't the case should it be using spi_sync instead of spi_sync_=
locked?
> >
> > Regards,
> > Jerry
>=20
> b4 mbox -c to the rescue. I found the earlier discussion with Mark about
> the lock, so I guess the question is just should this call spi_sync
> instead of spi_sync_locked then?
>=20
> The magic numbers is a minor nit, and can probably be cleaned up
> separately since the full duplex code was already doing the same
> thing. The only other nit is just the older tcg spec being referenced
> in patch 1.
>=20
> Regards,
> Jerry
Magic number can be dealt in a different patch for both half and full
Transfer calls.
As we send single message for complete transaction, bus need not be
locked. I will replace the calls with spi_sync.
Will update referenced tcg spec as well to the latest.

Regards
KY
>=20
> >
> > > +
> > > +static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 =
addr,
> > > +                                u16 len, u8 *in, const u8 *out)
> > >  {
> > >     struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > >     int ret =3D 0;
> > > @@ -140,6 +206,24 @@ int tpm_tis_spi_transfer(struct tpm_tis_data
> *data, u32 addr, u16 len,
> > >     return ret;
> > >  }
> > >
> > > +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 le=
n,
> > > +                    u8 *in, const u8 *out)
> > > +{
> > > +   struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > > +   struct spi_controller *ctlr =3D phy->spi_device->controller;
> > > +
> > > +   /*
> > > +    * TPM flow control over SPI requires full duplex support.
> > > +    * Send entire message to a half duplex controller to handle
> > > +    * wait polling in controller.
> > > +    * Set TPM HW flow control flag..
> > > +    */
> > > +   if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX)
> > > +           return tpm_tis_spi_transfer_half(data, addr, len, in, out=
);
> > > +   else
> > > +           return tpm_tis_spi_transfer_full(data, addr, len, in, out=
);
> > > +}
> > > +
> > >  static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 add=
r,
> > >                               u16 len, u8 *result, enum tpm_tis_io_mo=
de io_mode)
> > >  {
> > > @@ -181,6 +265,9 @@ static int tpm_tis_spi_probe(struct spi_device
> *dev)
> > >
> > >     phy->flow_control =3D tpm_tis_spi_flow_control;
> > >
> > > +   if (dev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
> > > +           dev->mode |=3D SPI_TPM_HW_FLOW;
> > > +
> > >     /* If the SPI device has an IRQ then use that */
> > >     if (dev->irq > 0)
> > >             irq =3D dev->irq;
> > > --
> > > 2.17.1
> > >
> >


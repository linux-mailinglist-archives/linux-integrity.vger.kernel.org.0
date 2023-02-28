Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA36A51D2
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Feb 2023 04:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjB1Dc3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 22:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1Dc2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 22:32:28 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFDF23850;
        Mon, 27 Feb 2023 19:32:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp7u/+cQXlc0VeAH8O31xdut+YWBXUIiXClwPoYqRo6qzDRPUtNP2osS7j3SwVYgPi5ikyBPBeToRunwMQuMGspS0rBw6YYCsLIfsScB9xWTJSghqme9zBZLlmlEN1C+BXNhmcsaFxRzkaa0IWb1/5WuBkVi5WPl4U+T+txWpemf2EXoYQ8FMMy6Hj3a/tCGLO8F+FKebJ6rn7iRwq5ooupEkBal8Agi9outsTW2yjDd1anwFG/nI3Ki2KVIOl4OXfIChE9WWlNa/IBl4KjjLNSB95wKwInIyKUbM/9daThY0nh7bgZm6PeZLTnQvM3ay+01aVRjIPXWq7HHvJKjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiKLwnEMHkz0LUInNLaSTrxbxGUw1v7ckvpPZX/gX3Y=;
 b=VMt6NWRBBd6byE09xz4FH6IVYEmrv8Cy7AfMdtQZBkCQHqT91rxE45DJxty+OZgG5YD3AfRP2yKYXR9q4pDkpPLoRPSMaR8tkfgSoTxoOa+I46QrC9nwGCb7GlYRWCmag6FZ7XViRHHvocYAY9nM7sP2RVMWusolyZ5E5i1idp12rUPhzbH9jiIoiOnqkON6Kpi3fxdqu7znMpUJar5Ad/mhVdsB/tFFLrPJ99zSWXuvDJRCDfELg/jdY/YAyhBmHJ03luwyjPZxW2QRVUeNsEsgtjpfhx32R1A9gnFAyo64NvQDDhUfm23f2+SC0JDNE18AWf016UF/eix+gx5KlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiKLwnEMHkz0LUInNLaSTrxbxGUw1v7ckvpPZX/gX3Y=;
 b=FD0u4/K4g5Iotc4abYBKGO0gX6vNP6LIVoQu0hg1BpoI/qejUPRpWQ4LOpOgVHsyg7DUgC6uO/0iX0HcZVASLDkBVnB1UmU5bWK4euY7Q0DF1lyUEXznmZJY7gWfkaDWzB2lZYBQLbPZ577EITOyof59clZBk051ff2oEXcS7pEZ+vHkGcVUn6l8mCLPR7q4gfsODXKvZCFJUl3jfPBxxCtQo1/ssBUteytpqxzE9fhvpiQnxxPr8PzCis2ZTEGnOMvjuiCaGcxjXcjwO3vMfj04zIoXl37zihPmjysKzd29uQVqpCGZ5hfVshCxWcRWxLm2Xpgc4WBJYhbw2VFecQ==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Tue, 28 Feb 2023 03:32:25 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 03:32:24 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
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
Thread-Index: AQHZSqQUcW4yC19F/EyRW9qbZsaOO67jpaAAgAANsKA=
Date:   Tue, 28 Feb 2023 03:32:24 +0000
Message-ID: <DM4PR12MB5769BCBCD410C75DF3EB26FBC3AC9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com> <Y/1oqr0RfD7KVA4y@kernel.org>
In-Reply-To: <Y/1oqr0RfD7KVA4y@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|DS0PR12MB7770:EE_
x-ms-office365-filtering-correlation-id: 66d596a3-dc7f-4de6-90c8-08db193c6897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFuZaSW2Iu/KP7icdQVEeKYSaWjnXiRrBlVEw7IBLli4qyRgCE/S/hRvY7Ari8yzKZKMgYSp2gUPSFFxGRWcFBha6DLJU1//1OVetLLvjQxu+sJPVTsSsddWjjbbwxkwP9h+ICYlBkOMlDHtNByB8uecuwV7ZDVWqeauNM4fM5pIuKIKNaBTWbQdGSARoJy4uL4nQAGFsSJHZ1OBNZkO954r6Xod+/6XJSD1Jc76UFw0TyK+du8pOnchi5JRRQ5QGjzY9Wbt0i/Ztasnnr9Lp2DvCjYG6cVIO8HQQxh6OHQsE3RJjGL/rP9sVJtgMdGFp1FtTE/UtfuinsFhP9ls5uGHLit2YCbdN1HpL6tvUE7nL2TmrndyX0ZZfGjS9fCnnEdxMuSfPHnTPxaZcsb/Ms8IqMhSMJLhY2xYyTvrI1EvBm88PmHB4BaM+eAaH+EX8sNPT2tjKD0RfuN8YgTBWIFUiztpAcO5ZcQF+XOme1LeDIXa/qYMdN/jdngQUHJdkyR/oafR03fO9yiXgUowXXaUCmCwO7IhgaOnQ/F+UlYnrtlXImTbCdUQtj9ooHFBXbUPpSS29NIOJ/1tZIXmx0R6tEQ/tYn1fdSzdbSPtnmVqueG+kSItxTGgBOY5jaw/uC8T93wUn0sdL+m6DidmC16cm9VNN2NSRpY/nvt/oiru8Ig4VkKHH8d/+CfNWzg+32Ab0En7NK3nk2f/PKK/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(107886003)(53546011)(316002)(66476007)(64756008)(8676002)(54906003)(83380400001)(66946007)(76116006)(41300700001)(66556008)(5660300002)(52536014)(66446008)(6916009)(4326008)(8936002)(26005)(6506007)(186003)(478600001)(7696005)(71200400001)(38070700005)(9686003)(33656002)(55016003)(86362001)(2906002)(7416002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xWlbzMXKu8Su0p3CORQKfNApO/KdGyNK2IUmfZS1SNyVaoqLiNVME08ZHc5q?=
 =?us-ascii?Q?U8i1NqcxDi6cCOwbUtmj33Av7RKpq2+SyeDlXF2W7FGnd9HeouyG1RqjyRSx?=
 =?us-ascii?Q?/2xCC8NlAvzAmOyfMVLGwHOTQxBgWC4g/Y9pnCjvJO+tOy+7yW85C1ecYYrO?=
 =?us-ascii?Q?4UWClXDBX1IGu2nuaonDKS5pT+vnXmQdpGQGAyjOIhgVwMfNdI0klQOMxU5a?=
 =?us-ascii?Q?RoKagVH1v8enNZwBwLtUlfjRMP0cTS1WVPQHHDGzDQpwCftxB+mS4o5qQgp3?=
 =?us-ascii?Q?qttpM+8opo4vZ8oRPh3yg0Xg2vgtHnxoY+ttoCvsI7jZEx8gyrwgB0jANWJc?=
 =?us-ascii?Q?m60vAeyZID4EbtxqRfWycsNySM7l0A7biflyLG1lAtQpYG9MACUlNSEc7IgX?=
 =?us-ascii?Q?SFS4A08zCWKD8aVf5TCN+p4KM//sVJfVFp60ASEoe0IhyoWwdWzB+VnTaL73?=
 =?us-ascii?Q?2IgrU18AMaAWfe3PJBgLStb4Urwzaoaunq3c/0UPhrEaZRrzUQYpbU35thTv?=
 =?us-ascii?Q?8ETmL6YFklk3muMELv69vSl9DQO+GNieghtQRtKYRm08qEAfW+vyL0Lzk741?=
 =?us-ascii?Q?o2MJwBs2f0r8MeLBUUdvbQgAevKHRxlbZ66J3764t68XYu4/kwFjT4sDaHnB?=
 =?us-ascii?Q?pwTnwmOn4id70kwA3eFMfAcB7ZF325DtyAmnD7KjaBA+r4eTK55wSkRFCJuK?=
 =?us-ascii?Q?aJgJY912gYKB949VUq2Z44kxg3dYOs57Yi4QgUH7bkMm1o8ov5+MLaDJhkmy?=
 =?us-ascii?Q?Ihj+LV5PTNndcM3rTLV8MXVjXwFziviDrC6rR5OP5ArivxT7FnJWvuMmGqqh?=
 =?us-ascii?Q?nl71PAaOFGioqueduGPY5rVk1IOdwhZGu8GVk5ECTirofQVrs3ZUKybQTSUC?=
 =?us-ascii?Q?HYZvzzMxPXtm+SorClTPJgCpqIpHo+0CokWrjTdqltVSA4QpF0yu+vy9e/Fa?=
 =?us-ascii?Q?MrRDLSLZfW7KE0Cemjf+eFqGVU15I9FLUXWsQI9SlvF2QnBZHgl4PMRDRN7f?=
 =?us-ascii?Q?nojL4uGgIYgoey385xvPOPYUq8LIkIb5KdAViKjjAJ5/9v8sgmL0PT43S+nn?=
 =?us-ascii?Q?7fZ0EW4rrAVOUmGm4JX2LdCqWupoGsOA4aQZmT1x/3nsOIZ/rkK7MJmI6Y9Q?=
 =?us-ascii?Q?5ok8IPk9bO2EIN/jcumA5PoJdKkviF+AJg+YwMbZWjXlxudJkFRGGnQ2T8lS?=
 =?us-ascii?Q?p5QyKh9Ce0GPybrWDXuVk1oiXP31KfsROs4XZorisjnY80K8GRF/dwTX6kC1?=
 =?us-ascii?Q?0nTeIvf4HCOXTC5Le8cJtZ/MGgcmf4AUAZQndWtV/v5ElhhbSyowlKy+6BUn?=
 =?us-ascii?Q?7ahRmMXERXUdcDc2mhhSdi8g0YCjtKbxm8tBYZ4boG3V/Lu7+KDME6su6Cbv?=
 =?us-ascii?Q?b1YI+kVDktZ8bb4fWu7RUedT0gnoFV2k5aRrkwnLnv9h/p6Sg3upD/plwyOf?=
 =?us-ascii?Q?6w2eeqClN2zW92Nx3tKuDbhnYpuqrrlEMRLtFLuXWaOL4JHWcqjN6VKVob2e?=
 =?us-ascii?Q?RILbbmc7RGPk4Hf/874MhUKiz+DYm6aul75Y9GBqQSAzLErXJlZnaeuI9fPY?=
 =?us-ascii?Q?T1TzX56gcXVQ4jq6FyS1z9NNp+nxFX96QUVMHYUM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d596a3-dc7f-4de6-90c8-08db193c6897
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 03:32:24.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwIJGU2R/PxPJODJVDtaiLc0g7T637f+XJFjHPs5qNcYlz7sXRRAemkbyr2/DHc30+J6D3g2IEBuCwCdkS02bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
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
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: 28 February 2023 08:06
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; broonie@kernel.org; peterhuewe@gmx.de;
> jgg@ziepe.ca; krzysztof.kozlowski+dt@linaro.org; linux-spi@vger.kernel.or=
g;
> linux-tegra@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> kernel@vger.kernel.org; thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> Subject: Re: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, Feb 27, 2023 at 05:37:01PM +0530, Krishna Yarlagadda wrote:
> > TPM devices raise wait signal on last addr cycle. This can be detected
> > by software driver by reading MISO line on same clock which requires
> > full duplex support. In case of half duplex controllers wait detection
> > has to be implemented in HW.
> > Support hardware wait state detection by sending entire message and let
> > controller handle flow control.
>=20
> When a is started sentence with the word "support" it translates to "I'm
> too lazy to write a proper and verbose description of the implementation"
> :-)
>=20
> It has some abstract ideas of the implementation, I give you that, but do
> you think anyone ever will get any value of reading that honestly? A bit
> more concrette description of the change helps e.g. when bisecting bugs.
>=20
I presented why we are making the change. Will add explanation on how
it is implemented as well.

> > QSPI controller in Tegra236 & Tegra241 implement TPM wait polling.
> >
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/char/tpm/tpm_tis_spi_main.c | 92
> ++++++++++++++++++++++++++++-
> >  1 file changed, 90 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c
> b/drivers/char/tpm/tpm_tis_spi_main.c
> > index a0963a3e92bd..5f66448ee09e 100644
> > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > @@ -71,8 +71,74 @@ static int tpm_tis_spi_flow_control(struct
> tpm_tis_spi_phy *phy,
> >       return 0;
> >  }
> >
> > -int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> > -                      u8 *in, const u8 *out)
> > +/*
> > + * Half duplex controller with support for TPM wait state detection li=
ke
> > + * Tegra241 need cmd, addr & data sent in single message to manage HW
> flow
> > + * control. Each phase sent in different transfer for controller to id=
enity
> > + * phase.
> > + */
> > +int tpm_tis_spi_hw_flow_transfer(struct tpm_tis_data *data, u32 addr,
> u16 len,
> > +                              u8 *in, const u8 *out)
> > +{
> > +     struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > +     struct spi_transfer spi_xfer[3];
> > +     struct spi_message m;
> > +     u8 transfer_len;
> > +     int ret;
> > +
> > +     while (len) {
> > +             transfer_len =3D min_t(u16, len, MAX_SPI_FRAMESIZE);
> > +
> > +             spi_message_init(&m);
> > +             phy->iobuf[0] =3D (in ? 0x80 : 0) | (transfer_len - 1);
> > +             phy->iobuf[1] =3D 0xd4;
> > +             phy->iobuf[2] =3D addr >> 8;
> > +             phy->iobuf[3] =3D addr;
> > +
> > +             memset(&spi_xfer, 0, sizeof(spi_xfer));
> > +
> > +             spi_xfer[0].tx_buf =3D phy->iobuf;
> > +             spi_xfer[0].len =3D 1;
> > +             spi_message_add_tail(&spi_xfer[0], &m);
> > +
> > +             spi_xfer[1].tx_buf =3D phy->iobuf + 1;
> > +             spi_xfer[1].len =3D 3;
> > +             spi_message_add_tail(&spi_xfer[1], &m);
> > +
> > +             if (out) {
> > +                     spi_xfer[2].tx_buf =3D &phy->iobuf[4];
> > +                     spi_xfer[2].rx_buf =3D NULL;
> > +                     memcpy(&phy->iobuf[4], out, transfer_len);
> > +                     out +=3D transfer_len;
> > +             }
> > +
> > +             if (in) {
> > +                     spi_xfer[2].tx_buf =3D NULL;
> > +                     spi_xfer[2].rx_buf =3D &phy->iobuf[4];
> > +             }
> > +
> > +             spi_xfer[2].len =3D transfer_len;
> > +             spi_message_add_tail(&spi_xfer[2], &m);
> > +
> > +             reinit_completion(&phy->ready);
> > +
> > +             ret =3D spi_sync_locked(phy->spi_device, &m);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             if (in) {
> > +                     memcpy(in, &phy->iobuf[4], transfer_len);
> > +                     in +=3D transfer_len;
> > +             }
> > +
> > +             len -=3D transfer_len;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +int tpm_tis_spi_sw_flow_transfer(struct tpm_tis_data *data, u32 addr,
> u16 len,
> > +                              u8 *in, const u8 *out)
> >  {
> >       struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> >       int ret =3D 0;
> > @@ -140,6 +206,28 @@ int tpm_tis_spi_transfer(struct tpm_tis_data
> *data, u32 addr, u16 len,
> >       return ret;
> >  }
> >
> > +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> > +                      u8 *in, const u8 *out)
> > +{
> > +     struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > +     struct spi_controller *ctlr =3D phy->spi_device->controller;
> > +
> > +     /*
> > +      * TPM flow control over SPI requires full duplex support.
> > +      * Send entire message to a half duplex controller to handle
> > +      * wait polling in controller.
> > +      * Set TPM HW flow control flag..
> > +      */
> > +     if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> > +             phy->spi_device->mode |=3D SPI_TPM_HW_FLOW;
> > +             return tpm_tis_spi_hw_flow_transfer(data, addr, len, in,
> > +                                                 out);
> > +     } else {
> > +             return tpm_tis_spi_sw_flow_transfer(data, addr, len, in,
> > +                                                 out);
> > +     }
> > +}
> > +
> >  static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
> >                                 u16 len, u8 *result, enum tpm_tis_io_mo=
de io_mode)
> >  {
> > --
> > 2.17.1
> >
>=20
> Looking pretty good but do you really want to export
> tpm_tis_spi_{hw,sw}_flow_transfer?
>=20
> BR, Jarkko
No need to export tpm_tis_spi_{hw,sw}_flow_transfer as well.
I will update this in next version.

KY

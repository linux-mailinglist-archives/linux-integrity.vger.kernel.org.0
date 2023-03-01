Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDBD6A6F6C
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCAP1W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 10:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCAP1V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 10:27:21 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA21BC;
        Wed,  1 Mar 2023 07:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXLaldsF/qlUEHsdrC+U7Wli3QpYxHAd/0q1so55ZOfIUS7423Anp6k2FRzQIaP8MfUqrWEBuFzDL3jkOL66yXOqjJKaA65EI98PVt4AkdrI9/sVeeEOLAX4i9rsAulzf4HeRORTRE/HPhQt02+9AFH4UHP6hAjs5nISH7BRzL1zImyOHl578PcLUUdlZLGn+GH4el78ysWxtcRvAKMeSDfUYR2aFj0lsqSoufm97TXMeu3yuE1YWVkRWOPxGjCEBtoikg8J1zicGajm1ZSe5SWbDwn1A0cCl9d3z+pM+XLNPRg4Jtuoem/Ouyg5OiyTeER4xQ70y7Eg5uQyEPtDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L003LXu0bh/fPVth2k/jdKhWkKmfHp+8smr5xaDjRfo=;
 b=icfw9MbOQStIWw6KHxiytoN4eK+K9BzbOy+z4J8Y/PXdw2nQx/VjxC0CWk95NkwtanXJ34U33qd753HTw2K2pHmPLYktWVsrzMqIRFwKdLwbVe1EpsVn1rzR37QZ7nufSPk1TRCCHREJuhzbrsSNUwULwSgcA8S7sVm8xR1ojGcJ/ocagJzGm9nufpDtgo7RodfUx5dP14zxGkjXFzzhrM8Bznd1YeJjvbuQYwhWU7Jqz6iW7UElKYv9E3+XbDdkP+Te4p0OAYSUIOQoTeXTLPInymNw6h4sfiXVtX+LyiY0xv86hMnA7Nw+52RT4ejbpOaFGLltfpcaCsAWQzGztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L003LXu0bh/fPVth2k/jdKhWkKmfHp+8smr5xaDjRfo=;
 b=ba487eG0bLObKc6l2QiYE9r/23mIVfdW0KSs/xKpUdJW0oWqzxcw0sJ9DmXuJuURtBzl1j0z9CUjIj2jkmbLOw1Ti0TGfPmmOpyXY9Iidn1qm9/zvbQDzdyTv+iAxyYett4v8UL1v80POXIzmInyYEI25tqyH299buIPa7WlbKwxuYv4YnU1Y+zOAttuwNv/x1Of42F9myzqzt5fPsSwoFmiUE+v+pDZkePpR42lEwOL9zrVfs2AmEJzXEBtz3fhPKLanm54HjwlVWtaFiWiz0y7z07DbyDG7pu+uQ20gDLnDaann30KgsCw76ucM7ZOD+vCLAccHHzEMyZfUNfBgw==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Wed, 1 Mar 2023 15:27:16 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 15:27:16 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
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
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: RE: [Patch V6 1/3] spi: Add TPM HW flow flag
Thread-Topic: [Patch V6 1/3] spi: Add TPM HW flow flag
Thread-Index: AQHZSs/1XgRJnlUcCE+IdtrfY6Yn4a7l72OAgAAev4A=
Date:   Wed, 1 Mar 2023 15:27:16 +0000
Message-ID: <DM4PR12MB57698120C06D056E79C077F5C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
 <20230227172108.8206-2-kyarlagadda@nvidia.com> <Y/9UU8UA5R9eJFuZ@orome>
In-Reply-To: <Y/9UU8UA5R9eJFuZ@orome>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|DS7PR12MB6334:EE_
x-ms-office365-filtering-correlation-id: 10b6c38e-0661-4302-d610-08db1a697076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZopbQ22vE3HvOtggjd8MSKx09wNnQGCTmUHdQmZRmjA1lfa+KlJJ7osh72mHhzXi1sxIOFBXgr9GKPqGppV/VV0xc3fZGcmodDGtJKKYEP/IB5MKgXpKbfl5XWHaspnk+vvM703RIKJtzO38AUMHPvLJ1qih9DPICbFGPTphEOcAihfQgUGrUA7ZBRc4TFPyo6X7ppwEEWIeEKmO4v5YvmHCNPq300ZidjUnl4v54DB4GHN9r1yeq8fSBR/xH1EBzEUBJybsvewjLZhKsF0qIbDCCXghEpFnlWFvYnZmPq94XE70bn9g90x5zIWKUgc9Enahop5ivUYB9uhTQMX64dHPX+qSzXlD3zpMThQfdqJkV2g2a/sgDGPLljbW3TPRaNcPajmdkMQR0a7lbPHgIO/RG4xiaXeR1SPR+60M8ziqIPP2ykJLrrpH/REGuSf9iTu3cinoIDN8LlQgEuTER/cbVRmlAnK8DZy1tz9HE1LEoBKM7gBHGcmzm/7vo2umB4NF6rsEsSys94AapNhMHFJZ+F6MUbveSbdB+V4eGyfDtLSY4LAZ9GkxXfnEDRU/LQYJO7JeU2j6q2ZOCm/P0zz11RoaNGyLuY4oXAX9iG0zvI3M43nSE0ORpRRi2vnSAO1vdd1NzjAUO8SZI/OjfbQyUmZWZNhhd5PiwDYx24PHEB/wuxuHl7+ths2m+x+CPvtjvBgQNUPzf7BuR0xB6wXiwWY/5hZQ0zPCiYx0NQRj57WdFkB5yrqqSLYCGoK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199018)(2906002)(83380400001)(86362001)(38100700002)(38070700005)(122000001)(66946007)(76116006)(6916009)(66556008)(8676002)(4326008)(66476007)(66446008)(316002)(52536014)(7416002)(55016003)(41300700001)(5660300002)(64756008)(54906003)(186003)(9686003)(53546011)(26005)(107886003)(71200400001)(478600001)(966005)(7696005)(6506007)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R3EH8cJ3XbnN1FPi16tCT/YtxsQTh853asysqbkCaw/1WtDfmdOQmF7i8PmG?=
 =?us-ascii?Q?Fa/4PfUy59pZGa1rQE+znGdUT9kKAYH3ih+5vBLR71svch3HUFL8oj3iVxPD?=
 =?us-ascii?Q?co3Plm6Aj7pB1PAAnoUpIeaIgdHsqJj86kcvdC77zS4Bb3OC81FauZQ7kYTG?=
 =?us-ascii?Q?PlygrbYN5d9Nvr8ZMjDfR06XbWTY3+4ga3lD9nsm3KXpvDycCeTvd8bDxIOS?=
 =?us-ascii?Q?UDeMHfgqAHlS5NtyiYzO/r+WxR0YLxX77eEzHPJ7V8198Qvze1JRpgH4XoR3?=
 =?us-ascii?Q?kh0gYIcNZ1TnQLshLcPr/TO6DrP9RyVTQcr0X8nv/u39G8WVcAbh3Z4C0+L1?=
 =?us-ascii?Q?ZzQVbCbHd0UNyi45MFKdoN4bT6vHxckFvGBSXmL4VrSTqkRFdQMPRpRYJR6Z?=
 =?us-ascii?Q?CAnbzKVbVTwW07LVEqZiy+Pf1X5cOEJXobVyvCWYSGm1fEK84wOoACYpZwn0?=
 =?us-ascii?Q?sgYzjQ+MEbRybtXEmjhGwFH0eYtZJjMBfYmQhHaqXqk3IYYjiuepxpDSeC4q?=
 =?us-ascii?Q?pSdY215iZidjyeSCSOnqDdYQPszD3Fzr6kkUakDg/Y+hmHmTcm9jIFZkaNGL?=
 =?us-ascii?Q?vbi042ka0/VQj87P6pvFxWgo8M86nEuXjK9ZCdHfbjN5GmCXfpXDSkqHj405?=
 =?us-ascii?Q?j+g2yA/0ATBPyS2jty8Q0WErPLClhhEcEQi/XZDmFAgj3kNJO4M58EjetARk?=
 =?us-ascii?Q?6RSrKPhCrI5MKSEKkhTNift9aZittD23pekwIZUsnxthnMhfVFaDMn4m1OS4?=
 =?us-ascii?Q?e1KLBpsRdGSkhMMazDwXN8TFUe2SPZzAqV+kC+6G95FPQIDfXmPqjfSy3a7l?=
 =?us-ascii?Q?T96ZbycwZklWbHgkmZJHiD7crCiZ6HyPbpWNdmf8kUYB9uqe3F7U1W4BrGzB?=
 =?us-ascii?Q?oPe3Jjxb7O1F87gqplYuk26/CGiRcsFyIZapMXB6Ab3nILSesAM8iFgJJP2N?=
 =?us-ascii?Q?ESDkMHK1j14hKtxoWFpseIAI1DLAwpLaBl/mWZw1/8wwnPHK1rvgV1P5wdS2?=
 =?us-ascii?Q?KP1poCFr9O1XyK5lrSvQSf3sAc0NFtHxBeIZBC7UmN2PPFJlOsTPnYj0XmWK?=
 =?us-ascii?Q?rjdek979FKy3vic49ZzNqbYIdziHiWHLRoFcw7qju3fFUzAHBzt0T1VeVqNm?=
 =?us-ascii?Q?URx6l2HSsKlsSIUK4aqIHyRVuNL340h5Bj6P8NNTxrrM4bTl7mhHMNQC87GO?=
 =?us-ascii?Q?IQtrM8mXyjcyH+iHwVWN3ta0evhvTyJS5cwIDVwTGS7ayLMEFt4N18Nj7LaL?=
 =?us-ascii?Q?zMlJ+ubT/7iFhvMx2wOGVtVjGNH+P+HQxhslxmfAQpPra46gW43wXgLBqFbH?=
 =?us-ascii?Q?JqCxSsa/v9u2hzOYGF+ETfgLRtH5pQx+R3bGn+HyP/WCA7L8vZFS1l/ABw50?=
 =?us-ascii?Q?CuXm/0MbN+DyJeBONxGFXOKcxYPg9ZHKWx0CQZiO384sJ56fOn08n4hBnj1d?=
 =?us-ascii?Q?SYrcNjRbnmrifeBb74Pce9G+ctxvRvh5l8QpUcxceanKTBLIyrNfdEuNVObT?=
 =?us-ascii?Q?l9b4uKSOjvXWeDwaYIG5Zq1YrJegWJ9ybGrdzP1RW1VxWgeae1pTEdtXE66e?=
 =?us-ascii?Q?gLQbRCvYW0pDxt/bM7PNFkg+5ZDjuYTMKp+gbIMU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b6c38e-0661-4302-d610-08db1a697076
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 15:27:16.3625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dw0DceNlJ1gjZyx8YLGjxFWM4vovkN5j+KYNOGLxGRIxBBw0U5tEinkx5nGgwuxf+015hEVIOBMOuHAi1EiS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334
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
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: 01 March 2023 19:04
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; broonie@kernel.org; peterhuewe@gmx.de;
> jgg@ziepe.ca; jarkko@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux=
-
> spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> Subject: Re: [Patch V6 1/3] spi: Add TPM HW flow flag
>=20
> On Mon, Feb 27, 2023 at 10:51:06PM +0530, Krishna Yarlagadda wrote:
> > TPM spec defines flow control over SPI. Client device can insert a wait
>=20
> Maybe add a reference to where in the TPM specification this can be
> found? It looks like the specifications are publicly available, though
> I'm less sure about stability of the links, so perhaps it's enough to
> name the document and section that this can be found in. QEMU seems to
> be using this link to point to the specification, which I suppose has a
> good chance of remaining stable:
>=20
> 	https://trustedcomputinggroup.org/resource/pc-client-work-group-
> pc-client-specific-tpm-interface-specification-tis/
>=20
> It looks like the latest version is 1.3 revision 27 and the details of
> this flow control mechanism are in section "6.4.5. Flow Control".
>=20
> > state on MISO when address is trasmitted by controller on MOSI. It can
>=20
> "transmitted"
>=20
> > work only on full duplex.
> > Half duplex controllers need to implement flow control in HW.
>=20
> This is a bit confusing because you first say it will only work for full
> duplex controllers and then you say it's also possible for half-duplex
> controllers.
>=20
> Maybe reword this to something like:
>=20
> 	Detecting the wait state in software is only possible for full
> 	duplex controllers. For controllers that support only half-
> 	duplex, the wait state detection needs to be implemented in
> 	hardware.
>=20
> > Add a flag for TPM to indicate flow control is expected in controller.
>=20
> That's not exactly what the flag indicates, though, is it? It primarily
> indicates that the device uses TPM flow control. It's then up to the
> controller to configure itself accordingly (i.e. if it supports half-
> duplex, enable detection of the wait state, otherwise leave it up to the
> client driver to detect the wait state).
Flag is enabled only if controller is half-duplex and HW flow control is
needed. Will change wording to say it is enabled for HW flow control.
>=20
> >
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  include/linux/spi/spi.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index 4fa26b9a3572..6b32c90e9e20 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -184,8 +184,9 @@ struct spi_device {
> >  	u8			chip_select;
> >  	u8			bits_per_word;
> >  	bool			rt;
> > -#define SPI_NO_TX	BIT(31)		/* No transmit wire */
> > -#define SPI_NO_RX	BIT(30)		/* No receive wire */
> > +#define SPI_NO_TX		BIT(31)		/* No transmit wire */
> > +#define SPI_NO_RX		BIT(30)		/* No receive wire */
> > +#define SPI_TPM_HW_FLOW		BIT(29)		/* TPM flow
> control */
>=20
> Maybe some (or all?) of the information in the commit message should be
> duplicated here? That way people wouldn't need to go look for the commit
> message in order to find out.
>=20
> Given what I said above about the flag, it may be better to name this
> SPI_TPM_FLOW_CONTROL, but I suppose what you have here is fine, too.
>=20
> Thierry

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A8E6A0F97
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBWSlt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 13:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBWSls (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 13:41:48 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C477138B58;
        Thu, 23 Feb 2023 10:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNe3ZrSzIp2lhEbyZNesFnp55ECRyU1lm90RZhHZmJowfxPJVjcdYfq+lDOHXqiV81YE8zek4yVqmNMx3xVeHVWzwjreATlYHzGg6UgdJBRQQX/MYSpNvjidL7TsD7LeQz+grftExiH6IX+yvLbezXFBcSdg1b4lvP1qjFrzbBUt+XjkzR9/cNbhoVGYxdyVxEeE7v4rJ9WuVR1Qkunn1BZYo0gERoLo+MTNZrH1wqjq6PE7nhYq+l0p7dOnMCyrbYHtlf7ZiGxAeBLPTtKT4bgXmfZN83oIdXgghEKyevg5A/oRAIx/ihMtMDuyJmGwnDZTOpydUv6cMm5km97LyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG2DvBTDmMNHD6TxCB+8lVgv7kc/ZsBBcjHbz+Xov9Q=;
 b=KwTDwU8tQmHRiOEPTAoFcBnkVW3oI649kFvY+4g+A+DGSfgexfJuS8KuKJNzWIXCUwUKf+y+MjcwELLoDJl19EJgFcAdp60n582G1uGvujWh1k/zzuoIbG56SXMNpQnphAdR4XJLktAccvK9B4UkT45UlwVuXosl46dGpsHWvi1MsoM+cuhYM+r+WUXo9o1iBpI+xH3anKdfYnTFDaIiSi42MDAKVU8Z4cwjBButdlK9prAxGpfyNYN/0xPlrack57yEJfmVXY/DGVW0NB89s8BF4pcf0Wwc82rqWs0dFyHpAydXvCuUtAAKNC+BOeeZiHWctQrAOjgX1elxZea3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG2DvBTDmMNHD6TxCB+8lVgv7kc/ZsBBcjHbz+Xov9Q=;
 b=dtTilFsQl5UZU/rzKl31CDzwCpCWnT63a4FDluhNkoT9XMcflXuDidVHJepjq3m6kYePhc8eS+5NqEuS5YplZ/ePwctd4HQQSYcWFunORWZHa4HXPJJWYMH3w7P0hEAW8w094ewE6SSfkkeqFM86EhF04OiD/zU1W0I/tR2yli/NXPWxley5i4AbivJTntwZ2SP9OW4CF+BPeatDw6N+iPbYoxtiKufvvzNpD3gmsR9TJ1oR92vOL6GUGPpuSxIoCY5eh9DqfgKQN7AxAroPXR8YoLl3qseU4zIK0RO7GHLDNYlyukUkIfYDrbW5EGx1DeFiGsNWN4lJNVoU1v3kIg==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 18:41:44 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 18:41:43 +0000
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
Subject: RE: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Thread-Topic: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Thread-Index: AQHZR6OqOBQhj0zBTUWL/FYm6RTrP67cxooAgAAUpuA=
Date:   Thu, 23 Feb 2023 18:41:43 +0000
Message-ID: <DM4PR12MB57695DE127286D1DA436E804C3AB9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
 <20230223162635.19747-2-kyarlagadda@nvidia.com>
 <Y/egACRAp6nKZWdN@sirena.org.uk>
In-Reply-To: <Y/egACRAp6nKZWdN@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|SJ0PR12MB7033:EE_
x-ms-office365-filtering-correlation-id: ebb17f6a-29df-4260-0208-08db15cd9bff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pju7gUz4hWfN6m0l6ou1+PiYOH/VvAemyPQAyX18dVfDuyU/1x9zFnmf1lCuOC3BHBM+g22B0/ZId3qYAOOeM67HJ9vxmzFYvogyyVHkiFC/6UGLhDAL6NFUB+4UfKsOfHizycu3BSyMriS8hysVMQpM9/uRZyYbjUBMP3IiCOZGrCdEq1ElQSG/oXPYo0lfYNjjcdPi3/AFNe2VuSWn4zhe+ZCwK7c5T2+uk+dGUjJfAX8qheJ7f/J8mq8SZxlh3O7VWU+ti/+12kXCd8y17bObl3eYof8LkEnHDhPIrk6JDM0FSFUzZ4zhd+Du7pk6rkFbH1fjqZCtDYnFIiQPzuZgjne3tL8QoKI2KiBfLv8dQUJQmkyp1p5TOnmHv3Dn0uFtL9mIswXrgjTWWJqzR8IcdSZQicxvZh1QAomR5t+/quMW3xZnbXkY85NEKPCa1KnGliR0IPiNUdaljn1Rh3NxeFKcm2Zn9bHmjBax6GOAUyaViUnzB1ZzJwLoqs4Q72DwYPCv+lZK7ixtVcyKRT8vq37mEzA/gUNS5nNfU3xB8v3r5OLpO++HaMivJyp9hN0FgT9bBR4SZ6kylehNe9/yEhBY7Y0g8VXZgx0m7PdRUrHv+givDj1AqHU4Us3au6vjtZbnuux8NVdIYFUFBI4YAdvCBEAyqru7MbkX+6uc69uV6MxxRgNfMNIYjrqUoCSh+I5gvGV5IbRLPHaisA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199018)(7416002)(86362001)(38100700002)(2906002)(122000001)(71200400001)(7696005)(478600001)(9686003)(53546011)(26005)(186003)(33656002)(55016003)(38070700005)(66476007)(66446008)(76116006)(64756008)(83380400001)(6506007)(54906003)(66946007)(66556008)(41300700001)(4326008)(6916009)(107886003)(8936002)(52536014)(316002)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O02mfb0f6iy2hlJDqVfla/rVspQJEmkscU6eT5+sGISiMd5Huk7A7J5hB0CM?=
 =?us-ascii?Q?sF7AJ4LgZT110Yjg9s9poFY6ZMEJlUrOsxVTVmnllTA/IxQpuGhmPu5aSr8m?=
 =?us-ascii?Q?tllaUJtKrEXmQ9HQKAYNJPfNqMW+auwPdic9aGiGCBQshY2PXAEliBZ6Q96k?=
 =?us-ascii?Q?0XYenqzrn1ASKCHnEdDKKCubkoYb0ybXEGxuoBUlX4EbLqr4c2rV/K3TSyy+?=
 =?us-ascii?Q?p5ax+uJOK/S0hDkdy1jC32Z92szGqSvPyBrNe/1TQCQgqGnf70E7Hxbtw+t2?=
 =?us-ascii?Q?frQcDsQ3gktGA7VjTTFGxngC80Fy0XB2O9If/hQoDlw/vTql7xLnsTlcbDeP?=
 =?us-ascii?Q?Ed5lbE/4Aanro9yLzXNnuqkcukFGPT5i31gSgWKlDYcTUe67h7NckT+MISNK?=
 =?us-ascii?Q?Nf+UOMdfVlyscHGjlPNbvITgZV/rPx4//53lTS7xV+ukS91QW1PSFw18yGAL?=
 =?us-ascii?Q?sJQs/dJaB43bJJlilhY7fJ/kGRUDGaxezj5OahnDATRGyenZCbvSDe4G/2mN?=
 =?us-ascii?Q?pw7juX27S2j/QjCIYaURMmrUpdSxaMPUDSX9Xm58NdWW/K1PoSdbiuSlGraj?=
 =?us-ascii?Q?vU4c/a1bpOZKxf//PtCB8AOGLQEJWHXEhHw4N1MalKq9d6d5Sb1kpHQ+Rqu2?=
 =?us-ascii?Q?9upYw6DOq7CC3G7L5LKWS77S7534JKqMr8+yDabw3vPHHnMltRugiHog05uH?=
 =?us-ascii?Q?SoELoCptMglrxMm9T9SynpeI4bpMc++VdoyeLxfznOOcrLa8qPKr9NcaYD2s?=
 =?us-ascii?Q?YwR5aCUGCi4cJKLA2wdPn1qMgRNxYtpqPzxm9mECrhd4qUD25ufEZEor7DfC?=
 =?us-ascii?Q?9sbIi9esYvPbCHooz9kCKpns16Wl1fAFzu5M3P0jQCvISflhpM28xGXlc10m?=
 =?us-ascii?Q?i4Jbh+Dgg3+Ootg0CI4ueMZG+eKn0W0gXusw6UTr0QGVhn23Qtrf2VpcfIAR?=
 =?us-ascii?Q?m2F2LRFT/m7qJ+mosblx8Zr4tZ4m/PuJ2n+SeOs1Ks/DahkVWvmkMe3oc6qX?=
 =?us-ascii?Q?dEei6KHDqtBEX1Y4T6WieWWTVGr8eG8/X0oFuWYVyWHW1ZooqCClfIHB8kCi?=
 =?us-ascii?Q?J6JjQzahGPTOVcggYf6uLwbYymwAXAWygq9xP+YNlaMIH1CZcjzF42rit8tK?=
 =?us-ascii?Q?ovzy6xqHJH5OiwXLTYolB/ZIkC2+kjUjLPXfGVw2AdPwjesmopegghcXwQbq?=
 =?us-ascii?Q?eGZFoDVuJSWAmFfYwAyq2AoW+qeFkigQGIiOgRGHtYkjTiDBZ3nWpTe3FSEG?=
 =?us-ascii?Q?CwSn79peW4FFssMjVVXEgl54QXcRikWaUQF/V820iH59jvaPESs4mP4tbgAR?=
 =?us-ascii?Q?0C9Cu3vowFu+GUUNO9hMeFY9oeUpQ7e9pOJ3kZoVHPmwMI4aSc4aHiQAin8+?=
 =?us-ascii?Q?OaazXeF1wkF2Hr59ASJpeJs1i2VHI8S7HkWlp7JEM3isaLQZzvIXkxZJP34w?=
 =?us-ascii?Q?X5qA1LUSYq58ip5oq4iQi7/xi9XpkonmRlfo7ZEZFnKwkaqTqHXu6WT/1kTa?=
 =?us-ascii?Q?RNx6RH64UgIigLpz0QyR/3FOPrL7busfPASZ+99T6DcM6GOXweFPM6Rzqxlk?=
 =?us-ascii?Q?206qRyCFnR/B2OKaf0ioxW+hhRPgl88YSuTppg2D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb17f6a-29df-4260-0208-08db15cd9bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 18:41:43.2405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aW5KKc8Mrtv3TmdGXLJ1AgXZJsII1ek4mgNN986fDsJSsbqRzLnjxy5acrm9eQsyxXi9fJgQcCTz9fjHUgguoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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
> Sent: 23 February 2023 22:49
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> jarkko@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>
> Subject: Re: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
>=20
> On Thu, Feb 23, 2023 at 09:56:33PM +0530, Krishna Yarlagadda wrote:
>=20
> > +       spi_bus_lock(phy->spi_device->master);
> > +
> > +       while (len) {
>=20
> Why?
TPM supports max 64B in single transaction. Loop to send rest of it.
>=20
> > +		spi_xfer[0].tx_buf =3D phy->iobuf;
> > +		spi_xfer[0].len =3D 1;
> > +		spi_message_add_tail(&spi_xfer[0], &m);
> > +
> > +		spi_xfer[1].tx_buf =3D phy->iobuf + 1;
> > +		spi_xfer[1].len =3D 3;
> > +		spi_message_add_tail(&spi_xfer[1], &m);
>=20
> Why would we make these two separate transfers?
Tegra QSPI combined sequence requires cmd, addr and data in different
transfers. This eliminates need for additional flag for combined sequence.
>=20
> > +		if (out) {
> > +			spi_xfer[2].tx_buf =3D &phy->iobuf[4];
> > +			spi_xfer[2].rx_buf =3D NULL;
> > +			memcpy(&phy->iobuf[4], out, transfer_len);
> > +			out +=3D transfer_len;
> > +		}
> > +
> > +		if (in) {
> > +			spi_xfer[2].tx_buf =3D NULL;
> > +			spi_xfer[2].rx_buf =3D &phy->iobuf[4];
> > +		}
>=20
> This will use the same buffer for rx and tx if some bug manages to leave
> them both set.  That shouldn't be an issue but it's an alarm bell
> reading the code.
>=20
> > index 988aabc31871..b88494e31239 100644
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
> Additions to the SPI API should be a separate commit for SPI rather than
> merged into a driver change.
Will split this into new patch.

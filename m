Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3AA6C6770
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Mar 2023 13:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCWMAs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Mar 2023 08:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCWMAc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Mar 2023 08:00:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D836FD2;
        Thu, 23 Mar 2023 04:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS6PgHh8kMM6ThdUv+q/+h6ul/YVP9yHZMn4w0eXfnNn+m3A8GsxKO6gVig1i3Z/SsqCCmFk6xJNU2RjLapEi8u9i6Knh6seya2iiA9nMlt777rkcB9nhr5y5NIPPEmwLQJmk18RUkVjYFpBoC07xuqXPw5jQKu6owt6XsyOkp0xLism3i33LZfw+oZk4Q2yC943xBYjLcSHCwq3oyE9F2zXmjyCbNT8ZhbeQ9aGocYnKeyNg/l+1a074DIcvlkMLOEvisZSlMrgbpW0YdiTGqdvBjmybp6WSU/i+VDYHkTng0TIlNdB2YMOoPLGV2vuw1GdO3JgcH9ExUeCDT+hjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZYbs8XzBc+zE7j1FhonOlFoL+2WoCjAN26XsFT3568=;
 b=MgzT5e7MBeYcz3zhr9+shxyEQJzOsQ+jMXxZLsbglJyZzIRUTxfV0+m4yBWEv//p9mDmZN6WnsK5Qbr50S0L7cYIYdPzqb0yeVzUDG93daO0TwdrH1fbINLmsMVfNzrxUb6mUDLIZ7hZpdAaWQVQz1yvug/9Zz64lVph2Vw9ANE1m4DP9kRNdcgP4s2KjTX4aJonqPGNFT1oKjmOnQUNu3QnguBoU5+K27iVo+AoXW/yBQ06tX+0Hv3zLQujt6jvgKsIzZhSokfhr3NM8+vFuwwNuHJIN/K+HbbyyNU/y8wRvHKg240VNAtmLQIz7YjW8qhnTpbgN0kD6OcVCqgDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZYbs8XzBc+zE7j1FhonOlFoL+2WoCjAN26XsFT3568=;
 b=Rzd+nmjj0Y5ev+br9qnx32lDIeT96MyfriTOQ88W3CWBN9TrRT8/cUwRgplEBxK0E75UX3dqJElc7wKVHhHmgnpH4tzBKs3a5fHlLDr/3Fek5zKbXLS8yTjTcSB4MCfOSra1xLAmdr4sgaCHvcr1SnxnxsIRzUhIhaPGH9xyG1YwzI5rF9OxBK9l/toMkGbq0OglcYd1Hvs1l1JeLYkaXaKlEU36k+NSke1aLc81uoXHZSs38I5UeBEBYWIhyx3BYxyW9Up3qNSghv3CLxNhmq9DU7Z/iSe6R7ym0hr9G/SwgTupMw6Ad8Xa8NR0yYFoniEPJjXGecq1eH3n/7IVEg==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 11:59:02 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:59:02 +0000
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
Subject: RE: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Topic: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Index: AQHZTL4LmmU2weVzlkGZavw5z7vfj672LROAgAXjllCABicqAIAGLCsQ
Date:   Thu, 23 Mar 2023 11:59:01 +0000
Message-ID: <DM4PR12MB57699E524BF3CAF642AE3E56C3879@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
 <20230302041804.24718-3-kyarlagadda@nvidia.com>
 <01959c869e01075705cd436afa822f2586d0509c.camel@kernel.org>
 <DM4PR12MB576911FA514FAFEBE6B3A39FC3BF9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <20230319134232.wzjvk4ddwqrbexil@kernel.org>
In-Reply-To: <20230319134232.wzjvk4ddwqrbexil@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|CH3PR12MB8583:EE_
x-ms-office365-filtering-correlation-id: e688547e-3951-42c9-0c24-08db2b95fe52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TL7Mi1S+/qX+X/GKtK0XhUqYPdpE1A3yfpiAb/aaNBjcUd6S4QZETTyFOwBQ1TS9guwWswDoDLD4VUd0zYb2DmYhdC5BbqF90q3YFAQDv4Eipid6ZNnoopq7bJy7GtV73rttfw8WLhjOdTGmJv0uPtaTr/CNN5r4jU980b7dUzEaNE5OGx/npTRa7L5suIdpIiI6m3+4Ds5R8vYX49uza6SpOiDtch6gZmQPv4adphLwn2JRu1wGIboHJfwPn7O7pQEcVL2UsgrGQlj8fI/9ptepcov80UY1OCg0SHIhFk5lRCV6pU9s/cFw67W8WfCzd+BdnHXo+taRatOtu2gOyDY3I6k7SYAKByYXAptgFyeWZ2u2I2maYXkAlz5PIcXfRswq76H1qeAVxGMJNsgo8flKjt2TZOySFfLRxZdzU35ex3peiSobB5yyX2GcJ8hXEXMmjF5HcyGbFYy1MfqkLZGB0s5QD1BWEG9HdgeNRvb4mbKceCCDiF8jqjnDBWvJx1ltE6GyaU1i6GwIakr5EvGm1UwnacS1PW+NWQHP54aWAFYbhg8HjXS/z3ka2gmOuRLvdJEiUvkyHgJcjHPkr+gbf8TOKVmJjODqpSyGbfEhaqEblakb3vW78Gt6JinJF9c6h/qV8Xnz+9nhFS/MqNS4z3K6rQFVJHKhxIJqMbdT0VaXyIuHUo/D8VbjZPcSlxsWEjq+SZGP7HMKCpY3Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199018)(186003)(53546011)(26005)(6506007)(107886003)(83380400001)(55016003)(86362001)(38070700005)(33656002)(38100700002)(122000001)(9686003)(5660300002)(7416002)(52536014)(8936002)(6916009)(8676002)(64756008)(66476007)(4326008)(71200400001)(66556008)(66446008)(66946007)(76116006)(54906003)(41300700001)(478600001)(316002)(2906002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XL63WvwD3mhlXucgEG25sc7T5/AfOYsupEQgr2Oywj/FyVxgGUPGaxHa/Fqo?=
 =?us-ascii?Q?qH//OLf92HUJ0dGatnH25tUZOYiM2mP0ZrH2/kndjDG8L/xkZEyuzyN8JtxH?=
 =?us-ascii?Q?47vXFoOS7vdGDwV9nDf3i+bF6JG4ckh0vrDJ6C/At8zCpTjaeb/UZwryEbQr?=
 =?us-ascii?Q?esTW3DRbDmlJM5hETM0WlaDcRzE5rsEEU5Ni56PBb5NrAE9WhWaMn7Iow+3i?=
 =?us-ascii?Q?siWl0q4L3QLhQPo5pioYO2OagCyaZ4KBXZKmhq/zFH2/u2pRG8awKqMIpA1P?=
 =?us-ascii?Q?eupNh0wFAdoempeGUiDrH9VITuZcch1LKid0i9BRjaKi003azcdxWExtlYJx?=
 =?us-ascii?Q?qQb90rzN4E++3qZdLOzKAvAGYlRhf8+QzifYoTsErfkxAbLQ6y7Npq4/BxJ2?=
 =?us-ascii?Q?DCnWAuWeZ3WfGolhyVCpTm69b721TL8kfD7pin7sM32QPyM8KIXbs47tjPOC?=
 =?us-ascii?Q?npTz/0SAtFJrcLYzEayU0+Jqmhz3s42UnW3UaTJF5IBBHCUZMIbOTWIzhZuD?=
 =?us-ascii?Q?UY9j8Qw5MPYqab8S0QyI+YtfKJFhrw/ewYHUConuZmA+IvxPzdQIRNB9IJZg?=
 =?us-ascii?Q?grFnL05N4MYUXA+r59ydQl9+9NiwKaUXp4H19HigofRdSu8cQ1p+wbU+7mI5?=
 =?us-ascii?Q?mvKcSz1aWXy+WjwABVtyswLITShhRC9z4FTVlVy5GqLLr2DuFkK2AuSoYuYD?=
 =?us-ascii?Q?2jcNPrWp4v9/D4w80zbo3dbLfVzKpiKMy8FKZvW+fPWy+/YTNpklxyiN6Kj2?=
 =?us-ascii?Q?q5wiM07hz/Ob1W/kfzdkFH+RUtxotnv5iOx4N5VPleVZYqZtz3mSf0a4/Ny0?=
 =?us-ascii?Q?K08enyZKQpKzNJ63g/bW7GOVxDUUo90+mZun2rOZBqzF6SZSCoP2O0+kdXTI?=
 =?us-ascii?Q?WKrV9LNka7c+RXAP4wSVNlZev87Idyi5QsebWrM2/WoylkUHY/F92CpVIMBI?=
 =?us-ascii?Q?dfgzhQkgBq5oTurx+X33dAJM27Dp2TTC3kd49/Ynp5HMSeJORkNxWQUjOJce?=
 =?us-ascii?Q?hO0cFkUEjYnmCvYEGKr5njMd/VdV0vqFYSTESx/cu0CI6gck1Mk/AYEGbezb?=
 =?us-ascii?Q?q97+ynj2UR0cj1nU3khx1B4RO6Lj0N+SqMi24AyEQggjG/8mBNjVoOFNydG2?=
 =?us-ascii?Q?YNRsqKxnHKwuI4+AuThTiaVZMbvxUznL1Dq4W7ZesLiA33i2wFv/kqPuAefx?=
 =?us-ascii?Q?CeHg7NH2Lqv9D7W/Z+nSYg556afaRSsOp0g7E+YkEv8l8CWHRcTMTAO8Ij+l?=
 =?us-ascii?Q?OXU8TYxywfNHeS1a4G99BElzkNXRRmSw2DzTdsns/S19UXE8tXd/VpdVUJzX?=
 =?us-ascii?Q?LT57wBwcdybGNiTqh5T30N1QAJA+lPyAlcJdIP0h/q+ha7RaCfp0LiKHq+Ey?=
 =?us-ascii?Q?F/bQs9SSeHyEk5MU82rOhCyrioNmeaz+JFUpg9qdMZUJX2Lw4BV86hPGlHhx?=
 =?us-ascii?Q?4FfBomHy/l5WDrt6W9/EsCuWr2bjNUT9k64KTN+nXxdsBnN211z5ffAcXEbL?=
 =?us-ascii?Q?/v/OUfShtEcxjpolqHS3oQnxXGOyv5Qb7DvF23lx0fKb3PUj40PT1BW1zlM9?=
 =?us-ascii?Q?q1FXXxg0C8s5Lshw0zxx12fX8RiEUEdUYth5b8c8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e688547e-3951-42c9-0c24-08db2b95fe52
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 11:59:01.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubhFJD44hiJwcaKXz11CYTcXCinuUJQcJ5uMuIrYu/1ynoAA3iMZ50HvS/mN7Jt/QyAWxwM3T83+IzXpwdeW4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: 19 March 2023 19:13
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; broonie@kernel.org; peterhuewe@gmx.de;
> jgg@ziepe.ca; krzysztof.kozlowski+dt@linaro.org; linux-spi@vger.kernel.or=
g;
> linux-tegra@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> kernel@vger.kernel.org; thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> Subject: Re: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Mar 15, 2023 at 03:47:33PM +0000, Krishna Yarlagadda wrote:
> >
> > > -----Original Message-----
> > > From: Jarkko Sakkinen <jarkko@kernel.org>
> > > Sent: 12 March 2023 03:19
> > > To: Krishna Yarlagadda <kyarlagadda@nvidia.com>; robh+dt@kernel.org;
> > > broonie@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> > > krzysztof.kozlowski+dt@linaro.org; linux-spi@vger.kernel.org; linux-
> > > tegra@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Cc: thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>;
> > > Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> > > <ldewangan@nvidia.com>
> > > Subject: Re: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
> > >
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On Thu, 2023-03-02 at 09:48 +0530, Krishna Yarlagadda wrote:
> > > > +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16
> > > > len,
> > > > +                        u8 *in, const u8 *out)
> > > > +{
> > > > +       struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > > > +       struct spi_controller *ctlr =3D phy->spi_device->controller=
;
> > > > +
> > > > +       /*
> > > > +        * TPM flow control over SPI requires full duplex support.
> > > > +        * Send entire message to a half duplex controller to handl=
e
> > > > +        * wait polling in controller.
> > > > +        * Set TPM HW flow control flag..
> > > > +        */
> > > > +       if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX)
> > > > +               return tpm_tis_spi_hw_flow_transfer(data, addr, len=
,
> > > > in,
> > > > +                                                   out);
> > > > +       else
> > > > +               return tpm_tis_spi_sw_flow_transfer(data, addr, len=
,
> > > > in,
> > > > +                                                   out);
> > > > +}
> > > > +
> > >
> > > Based on the condition, better names would be
> > Though condition is based on half duplex, functions are implementing
> > HW or SW flow of the transfer.
>=20
> Both are hardwaw flows in the sense that you are controlling a piece of
> hardware.
>=20
> BR, Jarkko
Yes. I will push new version with naming suggested.
KY

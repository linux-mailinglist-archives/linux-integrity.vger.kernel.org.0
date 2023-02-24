Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E377A6A1FE1
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 17:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBXQn5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 11:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjBXQn4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 11:43:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F182ED54;
        Fri, 24 Feb 2023 08:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/YBlB7JQf2xSlZexoXWfz9EfFTnBf83c7bKyVY9jP0BRU6MGNiql4zgExjYbyUES37kPScQUchUcCIUEt7nXLTlJ2rBP0N7JHDJJTtbYh5ty7IcRbayrin6W0LObuFwZeyLpJ5YUONa1lEsFeH7YJVtdKWIByiIM+MirbYo75C+G6hg5JtR48L/xsTo4bOhN0C3smyijLFnnRn+J6JC7rvfwt/q3aZeXqaYuDm2Xn6Dw8DLnAKp5phZwV2zAvUhMwcVR6rCi/M4tcTLvtkaqedD8x+AoBjyrn5S5Bs0TFMEDbtKMa8tLCw8L68s0874gejol5UwIKOMpLQ1fB32vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O95J/g6FOgMGFK8JoYj6WXEalHWbckDVaCIVFmLhCCw=;
 b=kW4+4m6pXw3kAOtzWNwar22ewFFP2+jQXiar6wXt8l1i1Itg5aav3RgPbStlzclfOycjpn3Y4lurpHriS3u3SkgFIGUxuE0W90MR1i0WXQi+gFAQ2Q5oL+Y5LNJNVX5ar6VwR+/5JGsIpw3SCUchnZ+6dj0wNn2fNpDrmTHR2IH+uxP0cVT3SPtfKmWdPSZeTzPIyhqt964Aa2xuuX+E6pH++O6C2LgOs/jwVAxC3l8d/+QPLCKpannh5ZnokeNgvHIdcWVsrhjiIEzOkX7QkNHWkL6dJ/JnTymKGIGt3b3kK9iUwYa/JxgjGm+hhZxW/HvsegX8AYRIVNusCGadng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O95J/g6FOgMGFK8JoYj6WXEalHWbckDVaCIVFmLhCCw=;
 b=THf8ytay7T4APtHC9DbrCUA0SG/Phj4hQ6TqSFOsYk1ImdPQQXKojjZlpgP0/db5QGlMNdkCI1MNuaOJhUcEpPHutJGzzf6qJ+DtrUDeX4hzqnOHS3RnDU1htOeirCp5bPvZBhqBlC2yHV5dnyurE7h9fiw2gBNKMViYYJS/dxTW/jdPYRlwuR1fLdGVrwPpuyow999GuS9rUgdLtOJ6e0Wsv3dX61z1fKVfknEXl4tIEaliPQtWYmZzaXHUktjv5MyrpEjvNfgW30S/SlM13lOneFs4tpYi7+juU82S5fquyZemKF/xNAmBIZLWrPpHhnuKlQtCuS95XyhVuEl4pg==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Fri, 24 Feb 2023 16:43:53 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 16:43:53 +0000
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
Subject: RE: [Patch V4 3/3] spi: tegra210-quad: set half duplex flag
Thread-Topic: [Patch V4 3/3] spi: tegra210-quad: set half duplex flag
Thread-Index: AQHZSGewR7jP0GiQNUCWppgWRcmc8a7eS8SAgAABeAA=
Date:   Fri, 24 Feb 2023 16:43:53 +0000
Message-ID: <DM4PR12MB57698E2BB2FDA89BA2B8CCE1C3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230224154941.68587-1-kyarlagadda@nvidia.com>
 <20230224154941.68587-4-kyarlagadda@nvidia.com>
 <Y/jny4dDix7txf0y@sirena.org.uk>
In-Reply-To: <Y/jny4dDix7txf0y@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|DM4PR12MB6231:EE_
x-ms-office365-filtering-correlation-id: f21fb4f1-7f69-4aae-6309-08db16865060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSLW3Bxwrab+5zbBkKjBZ1pE5X8zOhVI0syjW4whZ9Hs1J6X/fZrxEDhmnTfJyhShxR6jsaeRRsBupqjlZKXDxcBJ/hezHYrgBi+Ux7CkeR87+PlAdTEC4TdrMy7aDW4pWgoA3UNlDkGgoHNOy1Ijv2tSVQN/Ib7ytH9sys6cdr8CuFACiwherQ+UbKYRcaKa+NR3OTcDtDdBM+dDAgrGW9PvjuxRMXyzdpnrgByOsgfZFp8Etb5yAN1PTGokr29JbDKpHlfoImkcvsFEYEKorOEjbevPD/buiDexdo85diZfLXh6xDri/aOyBDzXZ6ies7UM8gALx86/AnYyVfCQrWjXOf9pQ5cwSXIn+j2ywsiFi0ilp/9nmvJ176LHMKpcBNt+Xq05CIeI/xVCDwUY6BIafhE3KBB0bhNLWQc8nPuYhH+6ZF305s7B3IMRsC8C5EuQQmA9bMZ3Q9ljcL52/Jdnw5JMRTeLJv1KY/63W5zP3QkHBLrSKaJ6uu0n2XtrbjlSujjLzwVQJpmISRp5p92tkBpfNTuT46WXgGZLNxPd9VI6eSgq0w4k4U9C+VsALuUte4S+ThbrIwV3gWnmqTkcMyddAPvboR75z05Xb+TYYrHJAW1I8X4LONZzInM168c8yzRmL5dLcyfAiA6sm/94eg69pfOfihR0ByAa/AE0iGyDV8Gr0oNNwfmxd8aXdJHWPFBIDNp99dXXyhJBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199018)(478600001)(7696005)(71200400001)(86362001)(122000001)(38070700005)(38100700002)(33656002)(2906002)(4744005)(316002)(41300700001)(54906003)(83380400001)(8936002)(76116006)(66476007)(55016003)(64756008)(6916009)(66446008)(66946007)(8676002)(66556008)(5660300002)(4326008)(9686003)(26005)(186003)(53546011)(107886003)(7416002)(52536014)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GzGOcVz9tIdWIGrFwTR7U3ymhuwSbdhtNtX5aXvDy5NXY+ZKm8MoN7aJPQq0?=
 =?us-ascii?Q?YCgMgAJzHCFnTuLsXygc2W2J/qVMRJJXd2pXji2w/wp9ZKB2rnBrZcdfBdSM?=
 =?us-ascii?Q?++inmhIgebZZlsaIOUZakbKII7uThKLB1MHVfc6gXp5wZsj3xPXkMgHq91js?=
 =?us-ascii?Q?U4fI3Pe0mj8Jxi3vxqhRexeRBwc0yDva8iHwkz1VE8VNB97QrSpIi/2vbNHM?=
 =?us-ascii?Q?iU06g6b9TtJNuGNEs99S4MWbJtfRUwZx9KJJVilBYAPgDPEfEBBIn4bpquna?=
 =?us-ascii?Q?I2uRENOdzkzju28zFowfb+aCoAnS3hlRhVNCracRdAnuzD0NstcR1f0AiQ4h?=
 =?us-ascii?Q?kekx2AzQZpl7IgPgpOCJco+UVLf45fLpYP7phiNgXqLgkA/2c2CfBYt01HYv?=
 =?us-ascii?Q?Fr7iDNZ61bKdH64b810w9X0RrU8ng1jw4deZxmCrLW2+7wMKKVBOO1awd0tN?=
 =?us-ascii?Q?hQDfaehrY8HNnwjq0lQnD69VvjJqD1JJoLD1SHMDqeDFzz8sRChzO9UrC3vE?=
 =?us-ascii?Q?0g617Kzk0nlmI9HngN+nJJb6D5kAtZNP2NZocCIi++yoeS9uiZowG8GJYr/D?=
 =?us-ascii?Q?yla0rlJ7Ps4ONQgHX2KF/KkWbeCQcNW0fOaBowlD8wC+MBaLoS/yG8iHRG7U?=
 =?us-ascii?Q?pN5bFTVODl7EXuHpnJJZPllh9WF+XHHLq+qma7FiUoNF6+OG6i6f6lgBpCZD?=
 =?us-ascii?Q?gMDXaPzp/cD+fXfLhsLBPEpZZf4RWm7DeFJ3Oc+ylUkBepMIp9izTTykvlyo?=
 =?us-ascii?Q?Pt4TzUS6pi6o5DGdQCQVUv6LFw/2MfHDp5P1sp8+mpUTszGMYCRQ3fsiAQJj?=
 =?us-ascii?Q?TFFPKtqoIjzECYJGrkUI7dKPIbysW948T+Hg1rUR3V+IcVyQcCgvbA7diavb?=
 =?us-ascii?Q?i4buk/Kn/3gfBzIQewazpCOD4OA1p5zYdKnfZUxxRM6e4nj+zSApfT32VNCZ?=
 =?us-ascii?Q?iiNhZQ1+s0Ca9hStHkKEIecmG9kEylyj+Hkmco8IMMyYSDmB6C4jKEHELfnZ?=
 =?us-ascii?Q?evieKSSiZgG82qAfqfTuqRDicEwolP0CbOGnNEUp6S6fm/JtmeLPgBO3LkYT?=
 =?us-ascii?Q?ks4S+80l4+7wHXmazpJcyAyVEmyZNiWk7NQR4mlBuGmHnfLi1vM3xgocqTTx?=
 =?us-ascii?Q?gyC8aMsu8+caJmn4Lf8Xz+rc000P5FECHv38HbV/3LeWR7BszswQZ9XZ6SEb?=
 =?us-ascii?Q?wWHB3Qrxf7jryhgi4GTfh9ycJFjDBobYSg4bE4+WI6G5do1eZv7zj25nnP4L?=
 =?us-ascii?Q?cBrlfnfR2F4m0VccblJe3UQJ9yXt7VCzAjp0Ng49GTvxM01kCAAsmNeoMVzW?=
 =?us-ascii?Q?x1ZVnKSD0giwe4+paw34dPm8RkoSPpVImnptoHmOwExmMHje0tSJi+FJtlWl?=
 =?us-ascii?Q?6TVNiSSEmMhOK2M9Dlmv4nYYRwEp/P8oMkPt4Epil1rhrdnZjnH7hlGJ0iKx?=
 =?us-ascii?Q?dgK9u7BlVgUmfSqVo6LbvKLYv/G+OA5RxrRtW9RtyiQ7LeY0uKQFQ7DlCVN/?=
 =?us-ascii?Q?/+BWv20xmujYAXX85hGWypYMXswRT/5bz3Rl7aLc/qXarBE+rYBCO86tpeKh?=
 =?us-ascii?Q?TC/7HpjnOKsJBzwETryEmJWlXTu9WBJJ1RVuTMlN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21fb4f1-7f69-4aae-6309-08db16865060
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 16:43:53.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbr+58fcdCaeHqP/WrUMkBLpbClAU92gOhhry4Z+aj1SNa0jafupcSc6muiQaQ+v9PoiLs9V6d09OzCFbjeMVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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
> Sent: 24 February 2023 22:08
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> jarkko@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>
> Subject: Re: [Patch V4 3/3] spi: tegra210-quad: set half duplex flag
>=20
> On Fri, Feb 24, 2023 at 09:19:41PM +0530, Krishna Yarlagadda wrote:
> > Tegra QSPI controller only supports half duplex transfers.
> > Set half duplex constrain flag.
>=20
> This was already applied I think?  If any changes are required to what
> was applied please send an incremental patch.
Dropped wrong patch. Will take care in next version.

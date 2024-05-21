Return-Path: <linux-integrity+bounces-2526-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC828CB338
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 20:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB3B2835A1
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 18:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEF9149E0E;
	Tue, 21 May 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kwVAmwBW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094801482ED;
	Tue, 21 May 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314377; cv=fail; b=aXybysDoj0a6Tc0xnDqmrqa/6Y/0snVerGiWqeUYui/UDLAhe7+rP72cRvRmWh1izGnUagSqw9Eksf09/gxTq/f12d3FZfeA7o3wyJsyJWV8Rk5tfjXVTdxcnJgMetvRaDRQJuwg9SbVaq4+5Nk6FAzypU864i6XnKn+NamgE+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314377; c=relaxed/simple;
	bh=5BNizYjrlQgZSAU2yp/PoRnMVqo19i8zEzXcBHwAZ/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MyrMtPNDLPIUTpgcuNhe8aThgVOm37qxBPhEOgEh8Zmc5y9DO61+fhBLfkmxvKy5e0ZzKGGfLkvVaMvNC7FUObKzxYMM4Ep4MHsJtnXaflWXORH0IxUfh2mJJDQ1GToJtKp8Pf/4k7NFhEzy/ow4tvseOdWpc+MYGnafegBalVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kwVAmwBW; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJy7XCp0FIBgLfyw0Hfs8omROUQwdkXQ8A4Z60sHNpbWcM7avOItyPyh2awkDH391pNVfJnuKoKpBia31M19R9xLIytaDJ/cZnhswFBJWgoZVV3l89+FLbocDrCb6j6c4BhbKq6agsMUSkxx1qlEtafLNxm24wD914e5rAlpdIQeDGEvsY3TqdnGodWAluOQY8A/wxY3FObaF586tuYiqQy1P1lVJLTWtFMTcpQG+C5ju255afFiaPCZwyeZPdeFt9ryf5K0SFZPt5CPS7xhGC3eyEIu3BWs2KaVXSJvQmkFwwxm+apOg5BbShJxeWpTPhSHja0O/lzA59mzL6tSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyyTeyCuq2tDBgxMM6OeQ92w6ezHTtkwlXUEbqpEGJY=;
 b=U0jfdR4x8OYznPF15kzMX5nnjr8rUZqk6iFmQbDwMVZwp1RZ0o3PqbRT4Tzn9xMT2wQMxBSxmqPyeEJ3TMeDaEZKcn1HvZ1ObRc+gYY004h+6M59U3gzyn8nEh+KemrpooIUzxbBoqxV3Tn9YFMtpvdnlwPH245Z2UYGwzxm1ksvSyHdz0xp1XgHtTcaQdJxjLWqG5a5Z3M7XhrS9kom0ORdlj7Dhdgc55XbsdY+H/Yi6zPCqiRQesaWS5LrSf1kIb6OrGaVie6rSsqPluBQxzg+AV3QhjDGNtZrEo1O8AmRuf0aQA/C6rm4YGmOzvVsX8Zdk+2QsoLKgSW11J2I7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyyTeyCuq2tDBgxMM6OeQ92w6ezHTtkwlXUEbqpEGJY=;
 b=kwVAmwBWzyHx7ThsExMv04Lt0807mf3oJzqN22nt/gy8LhxRlY7XXTUDY2hoJMAAzgz6uBPFhZBJ4ZwGyM5b45l62TZ7LYy/EkRHPEZDXSIByMJLcdmdBpELbKTlbpwtafjdVpm/J5C/JbGmvJdPd1+CqOGPob3ulZamyT+U7pAqDNLL5sB+5dYY3KPKzivaOdbRZof+hC/tVJsDJhBGKIlj/TufjIrfjDDCf4z7mHuLt7EheGoTRdnzeDh6CxKeYPZSc86A9zIPGiFjFtrdXcs06eJtmV8+oXxtGc9EAP95Qk7ZDAdxQ7THK7iv0O6qbj5mdhVu6moJqj6V9JX/fg==
Received: from MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:59:28 +0000
Received: from MN0PR12MB5954.namprd12.prod.outlook.com
 ([fe80::883a:d386:a572:80c7]) by MN0PR12MB5954.namprd12.prod.outlook.com
 ([fe80::883a:d386:a572:80c7%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 17:59:28 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vishwaroop A <va@nvidia.com>, Carol Soto
	<csoto@nvidia.com>
Subject: Re: [PATCH] tpm_tis_spi: Account for SPI header when allocating TPM
 SPI xfer buffer
Thread-Topic: [PATCH] tpm_tis_spi: Account for SPI header when allocating TPM
 SPI xfer buffer
Thread-Index: AQHaq5U1+o85zWpeVkyK4ZdirY6tErGh114AgAAitgA=
Date: Tue, 21 May 2024 17:59:28 +0000
Message-ID: <66503B6E-44C3-42DF-B423-7D0214620686@nvidia.com>
References: <20240521154028.3339742-1-mochs@nvidia.com>
 <D1FG0VPIBMJI.2XLL7FD5DYXBX@kernel.org>
In-Reply-To: <D1FG0VPIBMJI.2XLL7FD5DYXBX@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5954:EE_|DM6PR12MB4402:EE_
x-ms-office365-filtering-correlation-id: 9a97e9aa-59a8-45a2-2000-08dc79bfc27e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1koNU42Fxz3SwdxSWxjZzTuqHKGkDCrTlMnlzcCI/IyoB1pHmhW4/zuUUN/a?=
 =?us-ascii?Q?V9nGBtp1PDIGVbXovaAxw4/5uN2VeXUj8YjobU86xpXLOI6naD7TjENSpG+z?=
 =?us-ascii?Q?C4zK7MOAvAd29WaPg8Xm6EJVH+YUka5VfagBa79sVlEFwjK857s0CK3BMLad?=
 =?us-ascii?Q?8hhm57R0wLmrP9HZRV5vvieWQt09DigMl9TQbwe7NKw0EgzLThjQqm7m/rzE?=
 =?us-ascii?Q?QF6PXBe1z4JSeMyjOJLmHlSDmuYrE5RP46DUwHWgWeEx+HnlGJ28T6+TQw6m?=
 =?us-ascii?Q?yNtV7pbuZ4QvftXw3w4jTu1f3cZnKxroAiv4gyjivpz3r2CsF5KDd5odDu7s?=
 =?us-ascii?Q?1RNw0DpISvVIXtgZfoJULliEuXzp/xfOHEhzhqa90uwdZHvDv59z652CvTPe?=
 =?us-ascii?Q?IrBT08bKEeLdH8jfOOBArbjyEkbjvHREc4rW8NzUevN1+W4luhWtMaM4b7TT?=
 =?us-ascii?Q?9oLgT/0P57hF4oezweZ1NAy/+pROMAjo9Vdh/pVRA/WqS1f1m8zZ65uqBbCG?=
 =?us-ascii?Q?B+uRiuh9PdcTO/MhnVTevYRnP53VbT1SKxrgmIP5cLkKTyj8PwhbsX9VcOs3?=
 =?us-ascii?Q?AeVjWxdbDY5riorKLAgvzMbGpfMwS5fULFA7m0/mucwYoDCPJZ8VEo1wB/Zg?=
 =?us-ascii?Q?7FTpzRxW1CcJ473rSPU/VdAFXWa+AIbr7Pi7wfFn6gU4me6QHk2xNpBB6d07?=
 =?us-ascii?Q?3hZbPhuwbBuSzqxQUOa3Rj+Ikh388zfMxAhZM5ynlWrWtBdUNM/0UXjhe2bg?=
 =?us-ascii?Q?WnF95qA1vvbimTItrjnHym81G7qE3PFoTXrNZZLDsXsAz6KGz+yoHdkchzhP?=
 =?us-ascii?Q?q0mKPX1qNOYFhPmT/Ojh1xAzSe1hHhOYctlEdJvsrDXpeQvQ0xoxoFt6BM18?=
 =?us-ascii?Q?kta+64BBxUR3LRBRl+MeRlKPtG0SOUMu8OQTI3QJ9Oh29rMX5xY+PdSrjSHH?=
 =?us-ascii?Q?cQAzwJkrrcS3LlyWVLoHjVyQ0OuCD2Ro/cfHLAMb2K9pjIL3QhMLjozEmY57?=
 =?us-ascii?Q?jMYgCDXzO7tmfSow7j7XVei3kYSncPHk1Q44IlHMcXqgmEhD+c0dubQp06KE?=
 =?us-ascii?Q?Gs6VYxzYB4LMChBYdAFPTtMosCBqvqcqxIhJSDORZGvUDb0s8RlXNzdQS2qT?=
 =?us-ascii?Q?Z8mI9OjyF0D6HXEFQFSWYow5lMQvqwup/kQRmne6MB/zOh7q+7tggdgVMNDm?=
 =?us-ascii?Q?FTgJpTd0c2GGg0y1c38paKWVbKOLdm+yM8BurGeqg3SjDSXRVVd+93Npzpmt?=
 =?us-ascii?Q?okFUT8RvFq5hxHb+xQOA8KihxM6e8gTF0YM4wxv8UHiP5FdA59cTQveKYBoe?=
 =?us-ascii?Q?l/khL2a03gLSy5JxG6wNTUT2wqcbMG25EUclzMm97urSpA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+QJiaXqreoSo/5zrD5eoTSJ3d5mJfkFBiHnV1xbkyu27Z85vmNeETh1rPb+D?=
 =?us-ascii?Q?tXVWb8GYz0+xky2LsgKAgOGqPJvxuyQ5foUIxDzUe472hC8JMDoEhfkrnepH?=
 =?us-ascii?Q?j7CNwedZR6d8QXAjbTU8f6Nq9WnjZhc5GKWE6ypISdinLBwC0sr3JL7Rx2nR?=
 =?us-ascii?Q?l6mYTEWw1DL7DxsgoWrxYzf9vFKKIl8LuojwWBOfYWJLPP/DDZFmfPKP2lkY?=
 =?us-ascii?Q?EEbyCHD7QC2UBhYKn8fQm2pcI7plb187xDCwg7UEfMGhiCW8/RFXMPskVUmy?=
 =?us-ascii?Q?OzHbhzOBBZVLHXsjxsLevKQNbf2F0Ed4CG+GCW9Zdce3bVhqLRJs+EgxhxLu?=
 =?us-ascii?Q?493L2Mz6uykEXJdvgk4TKipm7p8I64BEbDTjMJULD7F9BEy5y8hEMwi7LIeK?=
 =?us-ascii?Q?ytc896ME3/EpAnJVrL1rPj7gJupaY9s3z7AwENhmtcRsms0EzG577sY4mjqy?=
 =?us-ascii?Q?Grl8IJSKGYS7g8G4ZAQeeu5xqgLF4Uogk6nPkTIcdVBhQKrZLijuPQm7s36u?=
 =?us-ascii?Q?HlzcTG4DONDnAl90xqgj8biMtCyEmPh6qaTgScPDESYuXvJLXlEwqU+8NTVJ?=
 =?us-ascii?Q?pvu4FK6Zl8HQRzMwlfmz/l78xWsCHxhjZFLeMMS0eR3ojNDiEj3FcZFGZvh5?=
 =?us-ascii?Q?quY4n42r42Ijgx+tBAWBfVnJjBIFfKW5eyaI0uoOrx9LedIQYfakWDN9RQSM?=
 =?us-ascii?Q?W6tzs4Og5vUAivlc38gQGyJ4tHtnbJ3M4f10+ilzrU/Bh9eJnn99oydRXl2I?=
 =?us-ascii?Q?LAJaMcluS98qDGkxi4lag29jpFIXATw3PONCDjQWzxu+kJTBINlOY81XsA0z?=
 =?us-ascii?Q?5Kk7UrN36Kh1IGFSrKzrXH9FezcZjiPZxq+bY6+6Qy5OS2BQ45qgYrSoN3Ce?=
 =?us-ascii?Q?e5suYvsEIlTUNntoMOl0prV90w8Uuq6OQz7oWzaDm2R76adABUcsvdPAXCOA?=
 =?us-ascii?Q?Nz9oalyLIuJrLOAHnppAAeZ20zIA5l8N/tnmzFiLEY2hkbupQYUHJOkpYcEF?=
 =?us-ascii?Q?1m1iKxazWhhsmLxKxSNQngw7wgoS49TsBC2/H4RuduKYYI5KH31ljukU+PvC?=
 =?us-ascii?Q?Ja1x2vq0RgrNf05VhJDNmJG6F2hW/RiIh7uFTadOMwQVqnxGfILgCJGQdg8p?=
 =?us-ascii?Q?4GtxXpVYXUwoW/PCJdTg/MSElSZNEJ3cwMCwyerkagL504IGXvMQskgdF0XH?=
 =?us-ascii?Q?GEtHZZsB7wbonfdj/FZpp33kPWhs3ZjfQbg4n0/Q/NEmSGuj3zDBud6b8MiP?=
 =?us-ascii?Q?xvlzEtp5HEeKWk0l/GTf+2HzJuwnuNMr+5hdo3ho5YIMgFPrEFGTd7G1Nu2U?=
 =?us-ascii?Q?hnYevKcd6LePsK1VOgR43Ribc/BZpYPOhdoE2RvBG4DkIDqW6zTWVfPU8VNg?=
 =?us-ascii?Q?aCVUpyBPJ5v9eGEgd6x1bEFHa7O4Ub/Qf27w6Q815E3+BGglD3pNVInkZKaD?=
 =?us-ascii?Q?p2MMPYl2v6mjQt9pGZ9Gu/4mUicofY4MP4CVTzT4ExC7t0Sh2keyLDyGzg2G?=
 =?us-ascii?Q?CGMpqVpDPDi9eVSGiV9SxedvWvAd80UzDAjqLl1H66hQuaEHmrk+hyDAG71a?=
 =?us-ascii?Q?yg+jEH0ZBuiXnT6Rv7GVUWDMnk7f8Vs6ljT6u5p3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE1BC66B012A0040948D7D337313B297@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a97e9aa-59a8-45a2-2000-08dc79bfc27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 17:59:28.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3lv00tRaKA8TC8L84QcY/kRxh+pjI56h8UssAwHjsPeIjyyRSXJbnhUNL5unVPxvN+xyVspsiA0luYg5eXNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402

> On May 21, 2024, at 10:55 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>=20
>> /*
>>  * TCG SPI flow control is documented in section 6.4 of the spec[1]. In =
short,
>> @@ -247,7 +249,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_da=
ta *data, u32 addr,
>> int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy=
,
>> 		     int irq, const struct tpm_tis_phy_ops *phy_ops)
>> {
>> -	phy->iobuf =3D devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
>> +	phy->iobuf =3D devm_kmalloc(&spi->dev, MAX_SPI_BUFSIZE, GFP_KERNEL);
>=20
> It would better to open code here "SPI_HDRSIZE + MAX_SPI_FRAMESIZE".
>=20
> I.e. less cross-referencing and documents better what is going on at
> the call site.

Sure, will make this change in a v2.


-matt=


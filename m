Return-Path: <linux-integrity+bounces-7091-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32EBB5857B
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 21:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AFE7A8146
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76622874E0;
	Mon, 15 Sep 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wasnk63l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from iad-out-008.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-008.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.193.58.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8B287253;
	Mon, 15 Sep 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=34.193.58.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965796; cv=fail; b=owy3RZS7E5TVP+kl+Ho0Fi6Hie1w9hZ9S/tyYDzJO3C9DMPq4z0Z0WLKGYhcYPum6DXPYQqVz2tvmkU/8ww8KFNVWDXx/BbKvzotc18M0M3dAS0Hjf8NMl58OuqiA8UDsKqRtVOzUhv5gN4SkONTu0lsgwei5n+ytHxm6DC8fU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965796; c=relaxed/simple;
	bh=2JsSeCdMN8qRo0N1hK+7U0lRn1VlQvGMOKWVFKDDc88=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YROldb1bcxj7lsa4/QMaieBpL1rCSZ9fcv0Cx/C2c+6QQET4Hn2jdtN8u4FHg9Bvbl/0rtnyduiUIfdvQhaUh495dxNvcBi8m4oc6tmTXxdBcruT5Tc5aIF9JbDH7Aw3nMxRUf1fVz2qDwh5FKW+PSrIgbDZYUNIsW859lRnkxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wasnk63l; arc=fail smtp.client-ip=34.193.58.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757965795; x=1789501795;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=2JsSeCdMN8qRo0N1hK+7U0lRn1VlQvGMOKWVFKDDc88=;
  b=Wasnk63lsrKhJRGPWMIRon0dBPek8VsAL0O+E/UqGut1jhTSKHidLx7f
   PvkAh2uVbMDRYzprD8fXOJfKcKw8hX87Cg7pR+Ide0e4wAgO0Mt11nd7h
   3NL75HpIfIkz9F1nVZu9biPWKBMHL7q9RiaXdpJm9ooPKhBnjRZMdS68H
   8ccM5zlFtow6faF1nVlbJRUKkLchrqkozVfk7nBvR93wWHccWUxHEio+2
   fht3hWvKsSac3VJkVXc8bYiI8YL/8TRs7NuZ4qoSk24T47OLjc369mM9S
   EeKWzSHiVdYD/7qFNZ5aR8YgFIHaPmArBDpWBO1HVBO1pgXd9hJTWvrDi
   A==;
X-CSE-ConnectionGUID: i1wptJMfTB6uJrEChe4bvQ==
X-CSE-MsgGUID: /J6/TyRHRuquq7XtZt3M9A==
X-IronPort-AV: E=Sophos;i="6.18,267,1751241600"; 
   d="scan'208";a="2537960"
Received: from ip-10-4-10-75.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.10.75])
  by internal-iad-out-008.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 19:49:53 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.0.204:6523]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.43.205:2525] with esmtp (Farcaster)
 id ba5a55fe-d10f-4ffa-8eb7-b7978006df3b; Mon, 15 Sep 2025 19:49:52 +0000 (UTC)
X-Farcaster-Flow-ID: ba5a55fe-d10f-4ffa-8eb7-b7978006df3b
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 19:49:52 +0000
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 19:49:52 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.252.134.239)
 by EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20
 via Frontend Transport; Mon, 15 Sep 2025 19:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAf9OAfmyt7qbXP/Joc4zbP9bXwSqA2FN7mBmXT6IuRvrqbbAFeAlOmI+pAhvQPU49lf45ZSog1JuSXgOoG/nsTrFx/GRShsA1x6UiWzS421roNlwyU6epYJLdvvXCKUghtYXN4IyzcLLiGI2cLicUtI+1wOzWGc5I+o/mUYjiZwbiTnwUe1lh0EAfOTx6c0KHfscTs7JX/0dM4ip5TaN+2pvmYaNjcD580DOKBLQOm7Floq/jBC4oBdGkHt7WOltHPvnFFcGmrrslPmmCpib3eYpalL/mwIfKwFszJ+Fh0z+VNHn9kYgELL8G4qMhd6opnRAZxhGY2tPp7us9fSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JsSeCdMN8qRo0N1hK+7U0lRn1VlQvGMOKWVFKDDc88=;
 b=rApU7tgDil8KlnM5JANQzBQheqXIoLVqX9agm5p59XHn91XX4GvpwXnahjERH2Cl+bHWvmHC0cAuJPLdxjduhddGQCQEVddHMEe5RXze9nx3d5O5ngYpbROAfXFZD+FTtViSNGj4yqZctELucUOVRmxsFFlOVn470Y82UWCJW/hdHEYDX5/ivvgNh3kYrbmyX9KUxW1o9B07bzh09APOAidfdRXA/+rRTW6sAGCDNRROUZOW6xCG5pnrrvLxr8x4WRA2flz8qSQJNnTLv5hJah7EChBwPde8pLGdnEltdhfkLsxDWmtIYJeFQDABjtYg+y6U2V2WAezkRLTvk96d7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from IA2PR18MB5934.namprd18.prod.outlook.com (2603:10b6:208:4ba::7)
 by SA1PR18MB4551.namprd18.prod.outlook.com (2603:10b6:806:1e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 19:49:50 +0000
Received: from IA2PR18MB5934.namprd18.prod.outlook.com
 ([fe80::8cd1:e814:983a:38ac]) by IA2PR18MB5934.namprd18.prod.outlook.com
 ([fe80::8cd1:e814:983a:38ac%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 19:49:50 +0000
From: "Kudrjavets, Gunnar" <gunnarku@amazon.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
	"christophe.ricard@gmail.com" <christophe.ricard@gmail.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bouron,
 Justinien" <jbouron@amazon.com>
Subject: Re: [PATCH] tpm_tis: Fix incorrect arguments in
 tpm_tis_probe_irq_single
Thread-Topic: [PATCH] tpm_tis: Fix incorrect arguments in
 tpm_tis_probe_irq_single
Thread-Index: AQHcJnnmAKMAV5v4X06aXgsa3vyhyA==
Date: Mon, 15 Sep 2025 19:49:50 +0000
Message-ID: <F9EAF351-3FFD-497F-952E-D6309B3819B4@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-09-15T19:46:12Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=e1810c95-5f3b-4032-bb76-1a29cd10e853;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA2PR18MB5934:EE_|SA1PR18MB4551:EE_
x-ms-office365-filtering-correlation-id: b74cb2f6-22ee-49a2-cfa2-08ddf4910894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MGVHZXJOaWZoSEFMdnNUZUozdG96L1BHTkp2OHNPaVFVTWxzVzNoRHpINEhE?=
 =?utf-8?B?K1lSZHNQNG9GbmtXeklOanhKTXpBTmJRNnVWdTZUUFJNK1FGL0txUUJ0Y3VG?=
 =?utf-8?B?Y2RtMGtZYVhET1RsYmlMbWEwdnpaQ04xYjFYMmRjVWt2K0lKRlJMN1cxZW1X?=
 =?utf-8?B?WUovU05LU2FmRjIrbzBVcEZuVVJMd0JpMjJ2VTFkVXBPZDdjUnEwSkoyUFVF?=
 =?utf-8?B?bFdFRDdlcjYxVWNzSzlnS2FtY0Y5cW93dTlsWjNnQXhsNXp2MGFYWmxVekxZ?=
 =?utf-8?B?WWtXRjBma1RqbDc5ZWtqUWdjNG9mTTlTaDVGVjlNVTdZOFRUYzViRE9jbk9N?=
 =?utf-8?B?b1VDQ0RvVUI2aHNkREJTZzFqdlllNlBMalR6cmlvY2sxVGtXSCs3N25nWjhw?=
 =?utf-8?B?Um03MVBBUVROT1FOQ0xib3R1bEprWjV0RzdPS3V5alN5Umw3QzRES01sTE5B?=
 =?utf-8?B?bXMxcHpwRXd4UElZZlNJTTBiTTZqTHNZSDFlZS9lZE9MTUNqQVQvQkQ0Znkw?=
 =?utf-8?B?cGYwWUFKVXVodGFXWC9kM0VPRDBLZDVBZjdvamY3RDRZZUdhc1dRTkxIV0d0?=
 =?utf-8?B?bDNoM3RYU3JmOEE4WTVkdkxYVHdEMGhoQUJRYjRQczNHeEV0T1BZbWk4bWor?=
 =?utf-8?B?NkJjMGZuMVVWakdJdXhLM0lrUVR1UGF4T21qQnpnUkVqZWp1ckVFa0pJY2lH?=
 =?utf-8?B?aUVkUk1DWXBENzJmeGxpREowUWFEbE9acTE3bDZISFdPVnUyMzBqcVlMU3V1?=
 =?utf-8?B?VHFHaTNmdWkxaUhyOGI2Q3FhenR1QllpNk80Wm1KNitUaHRLbTd0bS9leGsr?=
 =?utf-8?B?V3pMRHgvQzVWV2J2YUoyMlIyeXFXSnl0UWxrTHljaWlLNGNJVUZNdHVwY254?=
 =?utf-8?B?YldBTzF4Nk0xbElNN2djNjlJV2lCU1F2UjU4R2JhWlRjSnBvRGFIVFNWS016?=
 =?utf-8?B?dDlUY29OOXlOa3hwaVk5eUloc3l1ZEZLMWpGNGg4b0ZYcG55UGt1V1puUWha?=
 =?utf-8?B?WlltUW9YRW12eWJEdEUzblN2M2Q0MGxqYmFEOVJtZmg0cm1aaTlPUUVXdXNB?=
 =?utf-8?B?aWJ4ZlZyZ2psZnZmVnF1SW8zNDhSdFlEQ3hWY3BoWUllRGdaaDkvQ2NRd0p0?=
 =?utf-8?B?RDk5cFFseHZKK0szWjY3RGNzMFJ1bmZyenBxZWpFMlBteEpLSHZCYnpydi9i?=
 =?utf-8?B?cjJsVkxkK1ZGdm5JcXM5YlNVd2J0RkQwRWhPZ0pZRGw1T1ZRd2hBanFhbTQr?=
 =?utf-8?B?T3pMMEt3bGsyZDhVZldPVWlWSzlad3FDeHJORTdBQTRGRXVtVHlmbWJHVFhj?=
 =?utf-8?B?bUV6cTRUNklTL2pqRklickZ3MzJUVXVjNUJmcFpUMDBNSFBwa3ozcWNOVEZ1?=
 =?utf-8?B?YkZlcUtmZm5sQkZ5TFZqWU90VzJWUUM4NVF5THZHYWZzZFExNWp4NEJpLzZW?=
 =?utf-8?B?ZGZod0hmREdxUTJYaWpjRjBTTXpybCt1dlFPbmFzUlI5U1JlWk9TZ096aXJW?=
 =?utf-8?B?OFVVZm5ldmZrT1FZSE9WN2srMVR3NjErVWZPWnR0cmFwK3o5WStjVUFzMDhX?=
 =?utf-8?B?V3BYWngyTisrc1pyczhJSmhudnlyYWFia0Y2bHczY0d6dW1NaXFPV212N1d6?=
 =?utf-8?B?M2s0c09kdzFKV21POC9ybFk1VDN1MFRmcUtsTkErMlBOZ3NqRHQ3TGxPNkZS?=
 =?utf-8?B?K3BGUUs5S3Z4VFlCUHlQamZEVDNteHJ6NTliTGdVTUZwM0ppRW1vQlo3NzFJ?=
 =?utf-8?B?M09ldXY3OWFSVW5ueXFwekJJT1FJeUhtZnRuQ21VdHBFMGxnUTMza3B2TWxT?=
 =?utf-8?B?UEtZUCtuTjJpaFRHN2Zmak9FM3lXSGVhS1NrMm92UHU3REg4aWVRN1luanQ4?=
 =?utf-8?B?T2p1dE45Ty9zb1IyTWkvRWlSTERVazBJOG9vY3BHOWNGN2tKVUtRNWdJUFlu?=
 =?utf-8?B?TmZ3cmtUTUl6MUYwanJxckorWEJNdGpiT1NDdDlINUxzOXlYaVpuTVE1b0ZC?=
 =?utf-8?B?YW8zaXI4cEJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA2PR18MB5934.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eCtBa1RIZjByZXFQbmN6OUpCT1dIWExtTkV0ZGkvL1dPcXBiRWZLM01rRHBN?=
 =?utf-8?B?SHQzZGFKMWIxa2tyUUFXUm5LTFdRK0l5cThveFBRRjBUSDRpTTJibTFkOXQ4?=
 =?utf-8?B?Sm5SUzcyMWhaM0JyR0lZU2JkWWVZemFzeGJMYnl6dDlGMGpxVUxnbkxiL2Rh?=
 =?utf-8?B?VE5tYzZ2YkdoaXNMM29mTjlMdkVaQWtBY2tBSmI1YzNSYXM2SUtVWVZ1cnZY?=
 =?utf-8?B?ZUtUMnR5OEJNN1NvbVlrc21DME94bHJaOGY2alZwYkg0VmtLSy9YL3pGMGQ4?=
 =?utf-8?B?Q01yWHV5dGU2ZFQ1Ym0rcWpKbjJEQUxMOU4rOCtWRTVqNnZKTGVLYjhiaXJP?=
 =?utf-8?B?U0FMaHN2K0V4aWVERW03TUh2ZktNZDVJVXBRUGRmQlJmSDYvVFE5RldGZDRP?=
 =?utf-8?B?YTU4LzB6WXlRWWFpRlhMQWwvN0o2eEZ6OXZGNEtVOUtvYzRlTDV5cWNDVm8y?=
 =?utf-8?B?QlZjcUhuQXVlQ2xqQ3ZGYUF1MzdKOVdSZUJ3d2h3dlZQS1ZGMU5udXArTWxu?=
 =?utf-8?B?ckQ3dHFZSDZvRFhBbDNNTERZc0F2OVU3cTlOdW9aZTNyUjRUSVpYWUJJYkV3?=
 =?utf-8?B?UmNNcnllUjBFQVFwQ29ra0p2UlBOcmhjUlp2M1EzOG5WSWFPdHV6LzRVOHha?=
 =?utf-8?B?TUJxNmdOMjV4UVdpYUlBRFgzdUU2bUQzelVHckRkVXoyckJUbW9vMWlYSmJn?=
 =?utf-8?B?eUpzSDEvSUpjd3ppSzhLSFN5S1NweThURlhVeGFraHBXejRJdEdVbUZONWVm?=
 =?utf-8?B?cVBPZFVadE10c1MxK2xkcGsvbWN0YTFOcGpGdVR0WHEvWGtXSVJRem0zOHNT?=
 =?utf-8?B?bXRmUnBQZmRIQlZrbjRQcXJuRm5YYU9KS09CZHg2NHRKUkUveTh5S09DZ1lJ?=
 =?utf-8?B?VHRSMXVOaVo2TlliVXJLQjFOMDRhVWNEc3VEcTR6c3dLMXZFSmxFeEdiZi9I?=
 =?utf-8?B?VGY3aVlTTVNLQitacTB2elJSeEtOTlErdFRySjhrYnVRbFkrVVRKLyswR3FH?=
 =?utf-8?B?WjltdGt5cjNwUVJkQW5VcitKKzg2b051VkhTV3ozZGpObzJEWkQ4S2ZoQVdz?=
 =?utf-8?B?cGdtYkE5M2p4QVVkQStreFM5R3ViK3BFMkNwNEZZNDlsMWVOQzhxVndGem9y?=
 =?utf-8?B?bXh4M2R4VnRSbko0TkduRzR2S2dtdmtZZVlGN1Q4SndsU0E4SnIzeUduUlFE?=
 =?utf-8?B?bFpnMVB3Yjk2aEhjNHRZek40T3h2TkpoQmhHVXdwYW1Rc3hWcWpyZjBYdDND?=
 =?utf-8?B?UVhqSTdEK0RBamVnVGpXeFRQRWtIMWsxOVhrZHhhYmN3V2ZiWkhXZnc4UkFa?=
 =?utf-8?B?M09HWnNKdFU1cE1qYmFNL09NWDgxaHlYTlBXczlKZHIzOHcveEJOS2VNZTR0?=
 =?utf-8?B?RTB0RlYyOXFMVUV3TWE1WkVSeFdieStseW01cWxNN0twQ25GUjhkWU1JamFI?=
 =?utf-8?B?Z1Y2UlhXdWIrbmxLNDhhcTcydkdDRFQyeGorVURPd0F2aTh5SkRySmk5Q21X?=
 =?utf-8?B?U0doRFY2OSsrSHZTT2VObml6eUQ0cFphWERzUHBaOVkxb3NlMGhGbGhNSFZR?=
 =?utf-8?B?RnhLSUNKTW5TL05OVUJPVHRWUGNEekkxM2JySHJySFFXTi9wTVJJRllVcDRP?=
 =?utf-8?B?eXpkV2x0VEhqRURsdEQ2N0Jrb3F6WDNYb3BWNHFLSzlPU3pFUDNoQ1I0b2pD?=
 =?utf-8?B?VVQzV2dCdEN5aGlHa2s2MGtwL2tEU1lYeFJTVVM5SWZla1BzcExqazdFM0da?=
 =?utf-8?B?VWFZRlFXdHk5QzVtM1NEVDlMTEZWVitielgzZG12U3FPRzIzU0NleThBdURK?=
 =?utf-8?B?S2tsMEZaZng5dnVJSDVkcThmUElsN1NiTEk1UXRiTFBuQjVRT1cvS1VQc2Ja?=
 =?utf-8?B?YjdTNWNyQ0RiemcrZWd2T0pzV2dDY1FZdXVDYWJkZFVVRlBuZmFacDdBQUU0?=
 =?utf-8?B?QUhNVnROclBNdVR2bFZGdkp5Z2xlMnNEQkI4bVhyczJER0RUY0JxV0lHQjgr?=
 =?utf-8?B?THgwbmVlRkFpczN2WERCWTd1UCtpdG5yZm9wclBxMTNpRExtdThaVmFYOFlp?=
 =?utf-8?B?NFFxMmViS3BNOEZ3Qm85MmVkMnNyci9pekFKRTVKdFdUY3hVOGdLOHAwdWZM?=
 =?utf-8?Q?YN+DdX7f9Ig3iijdrTedJD/V+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1CC50138F8959499F734BAC57A3F6AC@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA2PR18MB5934.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74cb2f6-22ee-49a2-cfa2-08ddf4910894
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 19:49:50.7320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWCDi4uEUYcAkiJWxMXwr3PnPeUZDEd5IfHRQ6kPEQGqgd4GGzOodlE8TFipCxseiHW60V6yBDtsq1TxZ95zIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4551
X-OriginatorOrg: amazon.com

DQpPbiA5LzE1LzI1LCAxMTo0MywgIkphcmtrbyBTYWtraW5lbiIgPGphcmtrb0BrZXJuZWwub3Jn
IDxtYWlsdG86amFya2tvQGtlcm5lbC5vcmc+PiB3cm90ZToNCg0KPiBBbWF6aW5nIGNhdGNoLCB0
aGFuayB5b3UuIEhhdmUgeW91IGJlZW4gYWJsZSB0byB2ZXJpZnkgdGhpcz8NCg0KVGhlIHBhdGNo
IHdhcyB0ZXN0ZWQgaW4gYSBjdXN0b20gdGVzdCBlbnZpcm9ubWVudCBzcGVjaWZpY2FsbHkNCmNv
bnN0cnVjdGVkIGZvciB0aGlzIGNhc2UuIEhvd2V2ZXIsIHRoaXMgdGVzdCBzdWl0ZSBkb2VzIG5v
dCAqZnVsbHkqDQpleGVyY2lzZSB0aGUgSVJRIGhhbmRsaW5nIGluIHRoaXMgZHJpdmVyLg0KDQpX
ZSBmaWd1cmVkIGl0IHdhcyB3b3J0aCBwcm9wb3NpbmcgdGhpcyBwYXRjaCBldmVuIGdpdmVuIHRo
ZXNlDQpsaW1pdGF0aW9ucy4NCg0KUmVnYXJkcywNCkd1bm5hcg0KDQoNCg==


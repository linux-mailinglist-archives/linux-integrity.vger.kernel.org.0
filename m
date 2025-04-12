Return-Path: <linux-integrity+bounces-5855-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA142A86B19
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 07:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07561B8399E
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D4131E2D;
	Sat, 12 Apr 2025 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jHCO7Mti";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jHCO7Mti"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CCB17D2;
	Sat, 12 Apr 2025 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744436562; cv=fail; b=QuHPE7cxJ/QIIfChJXNw69HqSozr+uICUrKQs487Our7TMTiomFPonnnV/VB2NZ04wq30yW5Ejcngg7YylnXnFjLowDBLsZmGZbTHtHVPMpmVX1FtvXib5Q2pynZi9Clw2oIEZzBct+7VG/DQz/MddwrqGUblZ3biEAD6bx3oZg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744436562; c=relaxed/simple;
	bh=v7VDgY3byThwMxHwsuRJWtcXQ6bWLGCq4KZlg2LRDiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eR8xEGbUuWTRJlEUeSibEqcApGem9Y8tz+BxHviSXoSni7+VlVDz7AlzbmAdkfgaHXI/0QeWsye/bgR+NBaeNNlxh6bVxBzEgK5j+Asm+pozFqzq772ydLW2p0YgiGUKF/958SjTVRiZXbpBF1O7vquvv1DXusjhlTjqlTUSUAo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jHCO7Mti; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jHCO7Mti; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IWVyi1810V+Jh7B3crmt3BGhC8LB9dBV1LlxAqqBxvOzefHFsetvIM9abWJlnpWQesAplsE1/sDtQfC57LF/RcQPfgny8kK+T3lgM6d3/9J9OGh7mMXeTvchoykL4cALGObSevGBg/EGryH1OkgExn1Qi+GZ7omoaANyJ2t5qv+Gep7b4rEqMNSHDagV/XZGFQM6+7Q9IPApgEpLolZa4Xb/GTdgzzLsktqsHk0Xc/q5RIc53A1bExp0jAA3KKJGscIMTrr6k0zf/6FmnWIgotpN+PEiCE1IIu2mJLJ2Al4qPYcvDUb47aEVjY45cXJAO9kVp9woM8T460Cdcaf2yQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIFQEcnKUwLh/qpuiJxyPFB6MnQYan+eROG7r/fUtco=;
 b=LQbymhd5PvhUjR1yzPVRMSbICBuon2CAvNkda9aLVu14Z4eSZDoyYYp8Rj7DOzDaXjlH8kIgNEmz9MkTr2d3XcOW2kcVTbsPA11UdFXrAvQMIZJaFO5JhFRxsc5hf8/Qmrep0IHITvupJkPCPfV9NPs1V9KEOVkVG9f4cvGkqJ0k7EYhpJsLmY3kkZ8TgA7BK9E8LeTudVa1gIyCa1f2XZxTqJbteFYoNNnAuqWHygup9wOBV/nGqUdMZBP5rmibA7H+QokYwVqu+SZFeUCTznTb8donKWVsF2DuwptGTiV1sIB5Gx+z60TRIiM6k2O/uKFyxTeR3mnRbViQR+VeqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIFQEcnKUwLh/qpuiJxyPFB6MnQYan+eROG7r/fUtco=;
 b=jHCO7MtigHImIhSgMaND/xsdQCQZSN6+RU8ttQgibERrpC+GPL8v9a9j7f38CttG/9LknXr10kBjTnY+kh18OKkG6FIfAb13aurhFUcGUhMm0uweiu2sXR3ZVxTEA5FB0KrX8Ba0qqdRdaABHMzJECJ/uII7RyrpNsf7gTdhTiU=
Received: from AM0P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::22)
 by DU0PR08MB7461.eurprd08.prod.outlook.com (2603:10a6:10:354::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Sat, 12 Apr
 2025 05:42:34 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::56) by AM0P190CA0012.outlook.office365.com
 (2603:10a6:208:190::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Sat,
 12 Apr 2025 05:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13
 via Frontend Transport; Sat, 12 Apr 2025 05:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InIBr7o5gvutz5cUQ3w1urq2epjHQnPHVb0max4RHqc+Gvil0BUmsJMGQpr4Citx0CdG6MQEoJQj8QSbgAbRisoyFJIks2BLZarJuoUDZ6g4Hf67vU965IDMJlMxldmsVPv3us+RyyGpRNYQuy4xQE2b0noy2Gsff8nhqNV8DkUXadIZiCSuWPRGvq/DxnC8/ihNTJ7YZkKm7d7qk4GRkA/1Ut2TwGnZwwv9f1qDbLSWRLO/I/SzC1H9nrUVdBM+ctwrZ7jEuOYlIr38S407OFFkAup77HGmcy+SMRlvmJQzcirq32VUejUOB/Th3RkD/kN5CgOVHvxRhSKiTaxqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIFQEcnKUwLh/qpuiJxyPFB6MnQYan+eROG7r/fUtco=;
 b=LTqoh0zD4ZGYmLxX1stQciV9NmttLXIMJ/nyCu5Uf78Vu84hSWf4p8M0E98N7RHIOrpZ3cizsmYpUkiuVvNIU6UXgLRQvBXF09bR5vdc1cpkd9fFNpowTA59lwr+LT76XF168mjpsJbBOvC9nWRnFg/gUjlHmZlhndVb0me8P9TLkD5BRPciWTUIAtALb3D7Tn72IDkp58ZYDlxWPK6HW/AAsUoBtAo6VfcxpC6cLVCjgFDCtuUbAUChpXSlhEHd/clFiHMRlfFf8QGkg+vx+P0G0h41Q0AfuXaCcBUDk98TwKDNv+51zArEcPcEODEMqTmr2cgG8iqCSkxiVt2gRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIFQEcnKUwLh/qpuiJxyPFB6MnQYan+eROG7r/fUtco=;
 b=jHCO7MtigHImIhSgMaND/xsdQCQZSN6+RU8ttQgibERrpC+GPL8v9a9j7f38CttG/9LknXr10kBjTnY+kh18OKkG6FIfAb13aurhFUcGUhMm0uweiu2sXR3ZVxTEA5FB0KrX8Ba0qqdRdaABHMzJECJ/uII7RyrpNsf7gTdhTiU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB5843.eurprd08.prod.outlook.com
 (2603:10a6:20b:1df::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Sat, 12 Apr
 2025 05:41:58 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8632.025; Sat, 12 Apr 2025
 05:41:57 +0000
Date: Sat, 12 Apr 2025 06:41:55 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <Z/n9I88/phEi1GNq@e129823.arm.com>
References: <20250411090856.1417021-1-yeoreum.yun@arm.com>
 <Z_jw6z_2k0vzqyK_@kernel.org>
 <20250411-glittering-cerulean-scallop-ddfdaa@sudeepholla>
 <Z_m2RYPP_DaER2rm@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_m2RYPP_DaER2rm@kernel.org>
X-ClientProxiedBy: LO4P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB5843:EE_|AMS0EPF000001A6:EE_|DU0PR08MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b71d921-ba12-44e2-97c5-08dd7984d2c7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jG0NKwxbQ/NiECa8zj6zWm/dTdnHLMAC0y3iSC6UbhN2G3iR3ionLwPFqX0S?=
 =?us-ascii?Q?0vWZqugl81cdumwEhvkAJeYAxCPJ8f7s6BY8LGHNe4P2I37zLB/+Yce1fmGZ?=
 =?us-ascii?Q?oeAs9Brb56DPrw5y7BL+loEDRcZVh8kXiUh1QLutcSxf8IPm0cnVSQXHir8Y?=
 =?us-ascii?Q?blj1we2r1W38FNgS2DbemrPYt3QAZIDNtSQQ6exb3IivzNLdzb6theUnQ7gU?=
 =?us-ascii?Q?RzC7NPs0sTCvkLM3lU2lOxxjZ3A6CWOyRHkXg7m4/5rsgBgrVe6mry/4BQxW?=
 =?us-ascii?Q?uy1aLxWJ2Vh7QW3G8nc5OtnBjjUqHGJLvoB2b1syiJQwXdZBwWGyvtDhIl1F?=
 =?us-ascii?Q?q8AL0uCOThi48upw/q+ABaEzOZU+hnHaH5mSMGwPG+3hMtXQzKLz5ZeyiAv4?=
 =?us-ascii?Q?2EJNyEIEaxtHo7ZVrz96S79btxzKLWtMWSW++/KIRHqjrSlzfaELr7jh6Ma2?=
 =?us-ascii?Q?rrz/QkIN/ldjwGLM7R2CBddsZkbCDZdgj2jXf6GGHE6xbVWZ9KHy0e24xi9Z?=
 =?us-ascii?Q?mAY7NDupoLUtkdVy15lmKmgKbjp3p6urALyuMKf5kwSYNBvNpH6t4O6kGq4r?=
 =?us-ascii?Q?tupY6TblYNzxorfBw/bq2zH3zWpfNedhK7llQ65oOzjfPKOw8/Rj2YjW6/7k?=
 =?us-ascii?Q?PwLBT/j1wO1nZLImKCmUxb3M7dVftphhfn9j4kIq0kYkFijo8ki8765euFWU?=
 =?us-ascii?Q?7z9sfBZ3cNgIPfDs621bqnc9i5/EOcQk6cPgZ2FR5+pQqrmtfFgQtZdrpJXx?=
 =?us-ascii?Q?aVxKM80FBfRbrDTiK4mP/RJvwdN0d+UOMl5/f7LpUpXRyLbdqyzcWkOJYFrj?=
 =?us-ascii?Q?nOl2huJDG4Uv+4d0bXlVXRAddLpWuu9VqqOQwJKAnurBeu9GhjItefGCvjeg?=
 =?us-ascii?Q?mhFdzuudnfcxDjlwdfXcP4fNLvFgefdLvZjX/DeTnto4VgIWmFlnmj00/UyC?=
 =?us-ascii?Q?e+K6RvGev6IlUzklUUd9xzEgWQf1jSCIlphHICZkIRNZZYy4Y3VOHJAVq1QQ?=
 =?us-ascii?Q?nDz+8npqw0GSUa/yHdFHydAozMRMjFkH8r1/DAgAfucLyYPXP3Q6V8cqavk1?=
 =?us-ascii?Q?gabTlwLW6ValmuYzDTcLLzp1gpgWsfAPORnXZaubRmxK/ib5a7ei7/VWBgua?=
 =?us-ascii?Q?WVLUbqzG9fgRY6Ad4oVv7BmUs4Zgsn9FfCZqwnsSwfjgCUYNOSELdbbqU3q1?=
 =?us-ascii?Q?gr1DXlz7QxXFEM4m8fiK499Kxx6BRG58u19n2b/6mSDt7NshUqDJ1U4VN3A/?=
 =?us-ascii?Q?z+BCHfTZE2gFx9SaWjo/EEHGXyWTR8BvmfvP2gdmBPh2okIn69yBMSeiLBZ0?=
 =?us-ascii?Q?k7EzwWY5sEPD9KRIxHgt5YkIzNNVKb0EavbWO/atWtvpeSKpds5CNygmKPt0?=
 =?us-ascii?Q?18X82FAFoldQCJE5YVwl39Hb2Aa7?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5843
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	51089c07-a7b2-42b2-2956-08dd7984bd1d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|82310400026|1800799024|36860700013|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iCzZdLM3VzdmGYTCSwpEBdbe0DlgSp40BmF6HJVlHQY85OY3PtsxaP3dQBxb?=
 =?us-ascii?Q?lzP49SPQdzlkUTJnotD4rbLdddlUFBnVg2p22dBhf8thwdziJ/1aOCIqJE2H?=
 =?us-ascii?Q?gfdLI7P7K9HGGgWYQ6GqHOe7GoEspPlNYdHMKVPH10hMYS0VIRjnsGyvtE3U?=
 =?us-ascii?Q?bULjcLJSEYn9+SpxXXFeM0oU0Wh8j3iqmS86DsKG/w9jE3SOIpdbckw7v46A?=
 =?us-ascii?Q?8uWEh9CPkWf0pRu0S7QfEVG48oAzU3igCcp353tY/uv+oekyJJcmfBYhcpxt?=
 =?us-ascii?Q?lxsKidcWVhZEOMyDt3Nhn86Wh/rUNSZZTdHRgVCE3j7w13ji0mCMMdfNhsYt?=
 =?us-ascii?Q?R/qw7sHLwvwp37k8oad7sYKBwPgIJ0L4BzZ9aITr+o9njLF+hq7tTivx3mGS?=
 =?us-ascii?Q?Jj+AQ303jZuKCNhKO1Q4h/N+rlaNA9arzaMHyQ2DAKrLD2uCEv1hTrsqE0S2?=
 =?us-ascii?Q?U3t582vaKCC3iV6DTFtb8sr56cYPkS4AIiLz1CZKPdUB/mjfdInSACsgFYc+?=
 =?us-ascii?Q?m0s0TV6NwCKLzVFyLbWsy2vcc7SLAzAT6JqJ2spei8jdNL6sgSNV/wejTuVO?=
 =?us-ascii?Q?AfUxKCjFJh9M5sMpUsrRo8jd3FpLYMl8ffqT0EQet51qmVG7mtV9/HL3fL1D?=
 =?us-ascii?Q?LKqllnUeyWmTPfLnRQ1DeDpZkZJJgmaGs0MIX7nPzlGAtjiu7YI4I2xiox7R?=
 =?us-ascii?Q?pmaDydZhmXqBmSI16KRIiNsCNUvWWY5QeqyUQR2hvD2ShEmVmM7X1lPrvb+/?=
 =?us-ascii?Q?uYw2YwD7eNDSqmW+3E68PYGrzyvp1N+lwCkjDwNiVf/weV8xjWWE+VPRW4Zu?=
 =?us-ascii?Q?kMbt6oMTAr1RvuvJQ2Dx6bz2F8y2mLIe4VE3lWTeHce3XxTZ6SDboyKFekX0?=
 =?us-ascii?Q?HVPXqIISHiVCiC0g/gX27zMxcAbpIIwI6Et7mTakwmkrYkfEE1BtdwN+hPny?=
 =?us-ascii?Q?chi1wd7393T7O7Q5SRJSEI90pbTeAZ9KMQBOTkiZECGIDG2IJWbGQA/72nAK?=
 =?us-ascii?Q?dH8QXVvKlUhWc4/86hqHvgMgPJAmzVn/PymwKfJLWdS7oT/cI0TW2hoGe256?=
 =?us-ascii?Q?8LdpxRh6/D2IsS5DitfTUzFm0+WfNz/BAA+i8J5uobgtcVfVK3zLVnU9xdQ5?=
 =?us-ascii?Q?ts0rtnMoVbolFfV03Ty38SdAb9ypI1QtDGk2UJDTZLaotAfckzIvM44D7kKj?=
 =?us-ascii?Q?1x4Tyoc0RsQz+ZrdLEraQCSoe1ldyhXTl3X1ZPqXGe9Q9Kt3v/cYncbDgx6s?=
 =?us-ascii?Q?PqEAkBLmM9fynZtLYSEyMvThaY0+utZ3jmG34d0IIvecfi1Nit6S2xuuKOA+?=
 =?us-ascii?Q?ZEBtXSipqTu1QKHsBwbAO63Wm+hK1W0w5UGW5G+KKrkiOpBcdbIes9XFqa2p?=
 =?us-ascii?Q?sxbQSYrQ0CkXMmMphg8mDWje4wDUcf5cLi8LrUf1m5ojbztjXlb4Asvr1GD5?=
 =?us-ascii?Q?iAzfJKzg1NYFLut6IQYtkP7FQF61Ob7NA9HNqFCthV+hiyHhe88rcip6NaAc?=
 =?us-ascii?Q?x6aglJ0AuZj0G/4=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(82310400026)(1800799024)(36860700013)(35042699022)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 05:42:33.4480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b71d921-ba12-44e2-97c5-08dd7984d2c7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7461

> On Fri, Apr 11, 2025 at 11:43:24AM +0100, Sudeep Holla wrote:
> > On Fri, Apr 11, 2025 at 01:37:31PM +0300, Jarkko Sakkinen wrote:
> > > On Fri, Apr 11, 2025 at 10:08:56AM +0100, Yeoreum Yun wrote:
> > > > For secure partition with multi service, tpm_ffa_crb can access tpm
> > > > service with direct message request v2 interface according to chapter 3.3,
> > > > TPM Service Command Response Buffer Interface Over FF-A specification [0].
> > > >
> > > > This patch reflects this spec to access tpm service over
> > > > FF-A direct message request v2 ABI.
> > > >
> > > > Link: https://developer.arm.com/documentation/den0138/latest/ [0]
> > >
> > > Sorry, did not notice in the first round:
> > >
> > > 1. Does not have "[0]" postfix.
> > > 2. Only for lore links:
> > >    https://www.kernel.org/doc/html/v6.12/maintainer/configure-git.html#creating-commit-links-to-lore-kernel-org
> > >
> >
> > I was about to comment on the presence of link itself but left it to
> > the maintainer. It was part of the first commit log from Stuart. If it
> > is so important that it requires mention in each commit, it better me
> > made part of the file itself to avoid having to mention again and again.
> > Just my opinion, I leave it to the maintainers.
>
> Sure, this does make sense to me.

Sorry for late answer.
I think in the file already mention the proper document number,
Here It doesn't need to mention the link but spec name and version only.
I'll send again.

Thanks.

--
Sincerely,
Yeoreum Yun


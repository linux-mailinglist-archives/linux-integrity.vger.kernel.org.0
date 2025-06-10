Return-Path: <linux-integrity+bounces-6393-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4677AD390E
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC9F17B3CB
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C019296160;
	Tue, 10 Jun 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="clAaMnOj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="clAaMnOj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6323AB88;
	Tue, 10 Jun 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561554; cv=fail; b=pUUbfuCCnSfziSlaaHmM+iD5T1LC5kE5rLnfT1JYTHmMBNF/7x7Jh1kJ8Yv7qOuWojC01ZRNi+CIdlZP09fasbsImPAWRvS6QXbFhEqxZt4Rdb8MqZCqbx7fCiNkz6tfr3HIA1NCvHYMzSJHi5O+2bxxa7gnY+mjRcxDjBkOqG0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561554; c=relaxed/simple;
	bh=JrpyfDAkHCCZwi4zzwC6qijWRICQGnKKyGGqsJkhlvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=buCcG1K5wvj167/hYkKFsUyRGaSrREdUPM+q6pm1wd+lNeuKTFtMq3AnTxdsMxjsrT2JZkjwWW/gnyn2RpzfzcYHiz2fsp9BbFG0BCJNRJndpUAynoq+6eIn1tc0XhVqBhVacwuClH/VyEMFDPqCYEkcWSWUsgQUEpqjOLvLt+M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=clAaMnOj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=clAaMnOj; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Gc8L6tDXx7+BDZVUteMw7gr7gD9w9fF9rxW9Lwn+IK5fvBdjTuHSQnT6PbUKQY3ZUfg2QJ2aZ0w8zZ/fHd26MdvraiigK1A8YkyRVd8nYth1bXzB7x/yX8HynEvrF2X0z5t97ySCVVPNKunGPfVNE+iQygXR9UgFjF9Uy3yJ+TDAppi/GM12APERVvl2hv+nOjpERhUJRpKdBaRScmYlQIObz2zb+7XV5wjGj6RhiF2gt8nX9hSDKePc7BbgAaqFgBa+6P5ma6TASoJdOszc2Sp4i5GI+ec9anjwTDNqWvWy+n/une96yib1rmSs/xdenWfJi6WhnrM74unjSFrtZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+di5fwaJfYL7EdzGDYTQ4MmVds2KA5ESf3TH/3NGyEs=;
 b=honjSFanr2z+fnzC2ZxjP4FrhtZ1+LSIUN+mbLokK6AbBVHu97hIw5j5TnipBNhW/WOSuX+1a1mxp57A6SCnB1DQwM9jn6sjOUZES/U5sUUpexmEMwA9C41v2u987EYajdjz0UEL/RRO8/FwdO04uHRm+rIxZvZGhIvh0YWRiMEm+fZKm6AK4dPYhS4mc38jDn6bvA1ruzE5EPAatrJThpGJmHF6Ku3/TDlN6Rs5tP+pdWHDrCUwT8YtWlPFhvfInbkh6vfSvs3dDGK18e0lQGGyV9vQXdAmsEfRq058T/yWGAuomU0+smuQ25fH4HC5CoIUVc6lb4AMp3bNUkL4RQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+di5fwaJfYL7EdzGDYTQ4MmVds2KA5ESf3TH/3NGyEs=;
 b=clAaMnOjkwwIP76rWdooYlD91wnS46oqo1xpigjnV9cPxdfUS8I6NLrxSDafUhA5EgF6oh0GA+fL1OTjAyEJEFH8c0ysfQz8/qFpGxSZOrZe88rWzOhCUfGqIKxgGNopYZgD5F2s+hZh4MNK+r8PsOi5jD5k4xCYrnY/rOlEk7o=
Received: from DB3PR08CA0025.eurprd08.prod.outlook.com (2603:10a6:8::38) by
 DU0PR08MB9004.eurprd08.prod.outlook.com (2603:10a6:10:47a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Tue, 10 Jun 2025 13:19:06 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::34) by DB3PR08CA0025.outlook.office365.com
 (2603:10a6:8::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 13:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 13:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd9vf05IrPYZJbedSRAntmiyIw38fWfzyw3yltBlQPqW90vf2pY4sA8i4jIOn72I4QcCGwsMbFfdhMiUf7XYDa91S5r1bpYMhTwtv8RZsj7OOSc0DhHdUct8vZBaCFjRZ4cI/eMHAMIyRdNqgbyNEWxH8VPu4hW9zldPVrFuUSlZPwkkAXsdIWoFnY/tko9JiUZ7ymkMNsJcpPnmqutllYPWB/uvsst19TbP+DyFWOQbAegKGDjbSPczp1YguyYoM5yMAa00L+Ac0GGAj76BUdoxU2gboRNKYmA5LtsBUTHrBr1nafsQndZ/JlvupGoOKs1kAFgI7Il+XW1M9/lbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+di5fwaJfYL7EdzGDYTQ4MmVds2KA5ESf3TH/3NGyEs=;
 b=rDaDDBgk8kGRwMmhIBIdv0qoqzRLf7qH/w6j/OhRTIrTuR9CdmV4m+5JWkWhAWHC/81gc9WFNljWzhJTuwcxqpERSHR42cktF1MGIzWYMmED/mNxINDnNkszAQfHxCEPH15uEd05DIv6ehT58y+N6ghIvEZEYpy9RsB7Ha67y7Dkh4iqrzOjHzI5gUNTW4FfF4OqOM2okFJSrkQ3gBJdiA25+LOikTDWqm/mSnHq5iC9Hx37tqlmYA7220Jq+sCDkUcYASi+DOPVvMnmb0W6/gChvLbT/tORL0rMR1nh61hHxoQXvq+KvVc/TqnsNnkvIVUgC5s410Cc2wW5K+pcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+di5fwaJfYL7EdzGDYTQ4MmVds2KA5ESf3TH/3NGyEs=;
 b=clAaMnOjkwwIP76rWdooYlD91wnS46oqo1xpigjnV9cPxdfUS8I6NLrxSDafUhA5EgF6oh0GA+fL1OTjAyEJEFH8c0ysfQz8/qFpGxSZOrZe88rWzOhCUfGqIKxgGNopYZgD5F2s+hZh4MNK+r8PsOi5jD5k4xCYrnY/rOlEk7o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB4PR08MB7959.eurprd08.prod.outlook.com
 (2603:10a6:10:38e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Tue, 10 Jun
 2025 13:18:32 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 13:18:32 +0000
Date: Tue, 10 Jun 2025 14:18:29 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEgwpXXftXW6JNRy@e129823.arm.com>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
 <aEgmhwu1RP27yBpw@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEgmhwu1RP27yBpw@kernel.org>
X-ClientProxiedBy: LO4P123CA0250.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::21) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB4PR08MB7959:EE_|DB3PEPF0000885B:EE_|DU0PR08MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e9a129-7104-4133-f1c3-08dda8215fb9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?qWciwaBUEb2le4vhfLGLlg/yuX0kjsBXtujppGcYydbKorLRiR1yBSSLQMdI?=
 =?us-ascii?Q?OCtHJeAGvZUfNFBkzmvCtm5NK1dg9A66SU67LqFSiJvYkQdRxjiJIQNHC19R?=
 =?us-ascii?Q?roE1qOl+R9y2H1esQlEniESpC/bv6bD1nHFcP64qPbuj0fwqDevSxAGwYOoA?=
 =?us-ascii?Q?MM8lKWD/BGN0dsHHBe2Kb9DTfJ4EjMXrHDyGE71xRK+YWbaOKqgGTjFYDzvf?=
 =?us-ascii?Q?Pd8lw+77/j1h5JNba/gi4A8dSUsdL7COKBw6fCpYYADb3KZsvnijNKHAxDfK?=
 =?us-ascii?Q?kJvUH0MZSI9fdjATNyl/XRHJlHtxOcOhgKB3OxQFr5XPaUBsjUwIKPQJxx0G?=
 =?us-ascii?Q?en/wyrKXWunxDkHp61Kz8GI3yGfix9G8ozbBPOThCk3ec03MKnMwTf8j8Zs3?=
 =?us-ascii?Q?lgESkOCB5ysL2TZB3oJuo2rorLQ8/xFbDjRWXnkg5oBvOwEaxu8sItujobvH?=
 =?us-ascii?Q?MrUrnqV2bzRaPKZxQdLpaUgNIxeFQDQ5Bp864AsxwDYwXGYASC7m+kwieFyv?=
 =?us-ascii?Q?cYs3AUfivEtrWnHom7SEVyCUFzVs3uuHHmx/WFPUdDjkqdfQGV6+8EBcuMHM?=
 =?us-ascii?Q?HESx+bUvYkN/khlPbmiCcVrWPIvUdSPB9dQ3xOxXpIUgo4OIiGKbfUo/Ai4Y?=
 =?us-ascii?Q?alj98mnra+F3Dfdia9ucfrNAE1f3d2jujXsFckHyRpXPgJE5xGp5jcLmQ+g4?=
 =?us-ascii?Q?d84EVj0Fp/lFqyy3QChu7w+lPr/g+2nPP1cTgP1VjZdIQcFStLpowQny6CWM?=
 =?us-ascii?Q?BUrbgIGQqSMqfjavU6f22ALqGnZItMk0UizUmTtMVH0+BO2WAiZzAKrkJZMq?=
 =?us-ascii?Q?Y8Cm6xE3LL4L06nrPEHnnLWh0+BhywpLWvLlTc1e92tY1RsOgYreOUYKWaP9?=
 =?us-ascii?Q?U8xZtBfL6Cc9C0Kv9ki+qaY8wiNBOXZOx64okeGQTe3jBppBEIU5fdv/ZrkM?=
 =?us-ascii?Q?tOGWylaEcmM8syipkNN4GzdikMUImameefOT8DeZHzqTpJvTpBgkK01RGQuU?=
 =?us-ascii?Q?HcUKTxLlEJbWQDn9n1cqZMlAnt2iN8SmseR+Jd5exv+knhqFjLTXK2KXKNyC?=
 =?us-ascii?Q?s00OrlUA74KWEDdxmZqZCVH/xy21eyERuXXdg7IMXFttGO5e4RdxmXtwmucR?=
 =?us-ascii?Q?0FUi/aTOvfCmzjITy7rwj7Mth5R/eljnzFbnKpCPPYKVjyi2X3kq470zFcP4?=
 =?us-ascii?Q?87nlHwBiqDJzt46lQKvo2+sfV0C17yUH7kgqE3UIGiFMo3SK9JDqskS/LiTB?=
 =?us-ascii?Q?xlUo6hwBcQ3B/UyyNk3vnLUomV17Qjncsm7cJtqkuAz+nGvP07s1DJ2vQG+i?=
 =?us-ascii?Q?j3ZgEVoTyhMwyQjPzO+ffTL9F2OE7z6ABQobC/W4SHaKk7FBboZ+SfB31PQ/?=
 =?us-ascii?Q?oAt52k/PlgqMA1/d7sieQRmC98zDJm/MQ46oSx2hDkDKbktr66SF8Z5DuR7M?=
 =?us-ascii?Q?EPJcgnobAGg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7959
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eeedd898-a200-491d-c4fd-08dda8214c27
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700013|376014|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?to0MgUEgzIKcHBvgNEKGi20tpaURhNJS9C5uy55Aj8K/nRng8IvXQcjFrfT9?=
 =?us-ascii?Q?/9uzMdvLtQQmrLS/V2O7VljjwxrPPFkK7s6xvZKDUIKaHEtyUxnAm7IjOXzd?=
 =?us-ascii?Q?/1KbRJOntdvu1HBLZKujbVqw1WV1sQ5mLPSlORSGnfj9wsNk/CCOFemSaYoi?=
 =?us-ascii?Q?2lxKBnuwSHVzNiC4YapN9CTgcq/ilDvLd89aNiM4iokE/xlltfebRinc2iO0?=
 =?us-ascii?Q?NIirPdzCrT6QIgBl2W6aMM8YWLoV/cmRoZ3s5S4cUyWvE/KH/58e2+2kSPzi?=
 =?us-ascii?Q?Qqy4yn5VWre6vDUtA5YOlRKirc3eBYy97yPcSy+aU2Dm9IudgCZzKZP7upiW?=
 =?us-ascii?Q?AWmZp0JN6d5/1YJKm1v3mVequDi2b+9i+smDBZPkeYPfCd7J0/DE9GoRMrn7?=
 =?us-ascii?Q?Jiid/SuKcYYGKIkaWOMjFRbtMwOXFevM/ri7wcK8HWTXCYfsZZeAbQrKftGn?=
 =?us-ascii?Q?5wAoDVvsaNkRvrVy6dLpOx2HmiygAKn839Kms1S53Oq5GjBSeNhTO0cIL/t/?=
 =?us-ascii?Q?5dsU+iPd5Cgk1i/aCZ+riXujIsydG2V+noFt4GzFFu0cySiK2V2VzRA0GHS0?=
 =?us-ascii?Q?dMqIElYjKRHX8tOfQq95Jj/NR3MGP4fHZdydp1BbBwp7yKQ3aBgC5EFwHGSl?=
 =?us-ascii?Q?h4VandoU1Aj6uN/d85/dsd7VCwUWp8Mx/6LE0JPnO4Q3U6A9sFsRQm3AAB7m?=
 =?us-ascii?Q?zZRxgUgyaxFn4SsZQbbFKIH2dh6ww1vmfjs3ID+oT4Wxqu9V3nEVjksD544z?=
 =?us-ascii?Q?9buwM5yhNi72C9zr4rxnzcX1nzwQTngqZmgJ7++VPipNlmHqv8Xw74x0rl0S?=
 =?us-ascii?Q?eVq+Y0NdQaVu61AS0AA1Vt8e/lIQMLc9ubXrRBNk/YZ2DlbqjmGbOBGfMNMe?=
 =?us-ascii?Q?IuxClQU629c/XeYKdgjS+YToQ3FJoT6c0xFofvyyeUmBW8peAInE304ISVDe?=
 =?us-ascii?Q?jgAlhM1VpubIlUuqzrR9QTL7FXb93dArif02SSlMSuhh7bShLgy0uR3OUL+g?=
 =?us-ascii?Q?SzHCclDjpkIHNCiGTkhauiKvnIWNYZOftTyWIoMRfikPZqKVs1NzL+QMtxZQ?=
 =?us-ascii?Q?/5xXJK15UFMwxeSVkZGXcR5nFl0oTNIFIHcovjDaV0unfO3FovmXwbQqbuYF?=
 =?us-ascii?Q?Ruozj4ZspGVGnfNwzdVhJDqzLlpfb1/NUBU6MgXTow10SZ3RNBifEFC/jwNI?=
 =?us-ascii?Q?Z3h0XRydLt/efAiKPMgiAa7U4ZhMk0eq1vTzrTgRuGHu1OwxoCfuGn9MiOec?=
 =?us-ascii?Q?Q3fxTMEiUuCKpimZm4BqI/VCOGpWNkXwSq8Z0A2nG+zN/SCwQ/Pk7XFgGME/?=
 =?us-ascii?Q?7s9VeSd+M1R7D2sPIG0roginh77xeKZb4U5DZbhRYVOKT/299zFW2MBQ/qeB?=
 =?us-ascii?Q?efb9H3+dm2LI3D4B/mZum0KLBkPLFNt76vscrmhPpVGV34R03Y0ercc2OYOE?=
 =?us-ascii?Q?R1lmi1D8uhARjOUjyh7PhkTA/nbYSByeJvuRaYXjPvBQoROfdprCjTpHQnB9?=
 =?us-ascii?Q?e+ARWMklA5hf/LDtJIhl5SvzVzgrGG7O9g5o?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700013)(376014)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:19:04.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e9a129-7104-4133-f1c3-08dda8215fb9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9004

Hi Jarkko,

> On Tue, Jun 10, 2025 at 07:03:32AM +0100, Yeoreum Yun wrote:
> > To integrate a TPM device that uses CRB over FF-A with the IMA subsystem,
> > both the tpm_crb and tpm_crb_ffa drivers must be built as built-in
> > (i.e., ARM_FFA_TRANSPORT=y, CONFIG_TCG_CRB=y, and CONFIG_TCG_CRB_FFA=y),
> > because IMA itself is built-in and the TPM device must be probed
> > before ima_init() is invoked during IMA subsystem initialization.
>
> The description of the problem and motivation to solve it should be
> first; not the actions taken.

Okay. I'll describe the problem first.

>
> >
> > To ensure this works correctly, the following initcalls must be executed in order:
> > 	1.	ffa_init()
> > 	2.	tpm_crb_ffa_driver_init()
> > 	3.	crb_acpi_driver_init()
> >
> > Unfortunately, the order of these device initcalls cannot be strictly controlled.
> > As a result:
> > 	1.	ffa_init() may be called after tpm_crb_ffa_driver_init()
> > 	2.	tpm_crb_ffa_driver_init() may be called after crb_acpi_driver_init()
> >
> > For example, the following initcall sequence may occur:
> >   0000000000000888 l  .initcall6.init>  crb_acpi_driver_init
> >   000000000000088c l  .initcall6.init>  tpm_crb_ffa_driver_init
>
> This symbol does not exist.

I don't know you said "This symbol does not exit".
When CONFIG_TCG=CRB=y, CONFIG_TCG_CRB_FFA=y and ARM_FFA_TRANSPORT=y,
above symbols exist.

crb_acpi_driver_init() generated by
  module_acpi_driver(crb_acpi_driver);
in tpm_crb.c

and tpm_crb_ffa_driver_init() generated by
  module_ffa_driver(tpm_crb_ffa_driver);
in tpm_crb_ffa.c so you can get the above symbols:

$ llvm-readelf-21 --symbols vmlinux | grep crb | grep init
171332: ffff80008203ef08    56 FUNC    LOCAL  DEFAULT    19 crb_acpi_driver_init
...
370077: ffff800080d650d8    92 FUNC    GLOBAL DEFAULT     2 tpm_crb_ffa_init

>
> >   0000000000000a9c l  .initcall6.init>  ffa_init
> >
> > In this situation, the IMA subsystem fails to integrate with the TPM device
> > because the TPM was not available at the time ima_init() was called.
> > As a result, you may see the following message in the kernel log:
> >
> >   | ima: No TPM chip found, activating TPM-bypass!
>
> TPM initializes before IMA, so there should not be a problem.

If you see my commit message it describes the situation why this happen.
when crb_acpi_driver_init() is called but before tpm_crb_ffa_init() is
called, the secure partition doesn't probe. so crb_acpi_driver_init()
would be failed wiith -EPROBE.

In this situation, init_ima() which call ima_init() can be called first.
NOTE, init_ima() is deployed in late_initcall and
the "deferred_probe device" is tried again in
deferred_probe late initcall.
However, even the deferred_probe can be call later then init_ima().

000000000000012c l       .initcall7.init>-------0000000000000000 init_ima
000000000000016c l       .initcall7.init>-------0000000000000000 deferred_probe_initcall7

That's why init_ima() is failed to init with TPM when It is deffered.

Would you let me know why you said it's not a problem?

--
Sincerely,
Yeoreum Yun


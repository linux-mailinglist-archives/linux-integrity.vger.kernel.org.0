Return-Path: <linux-integrity+bounces-5040-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C881CA4BC0A
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE33A582B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424314601C;
	Mon,  3 Mar 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="L6E3xReg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022123.outbound.protection.outlook.com [52.101.71.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A29A94A
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997618; cv=fail; b=hHuaZKiBDlyMlALtgtkcnskoIBm8z64wNbVQ1SZp3MRc05T9KI6H+D7uW+bXvhayaNAncGz1lQyBzYEYmzYIouK5xNAWkUnv2QqosM2TSycjASFodqyRPLT4caKNftKPkNAEm9YiouWIjrGWP8MMxLQ/CD5FVQ8/+SSiKJZi/WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997618; c=relaxed/simple;
	bh=CCcfvVAZiFpcNfaz0Jr3NeBeN3gSFpXFSv2Z3wmZQuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SkwD1mO0aFvyWSqxdK58EmHgDYM4WUJA2o8XqvdE2LBv/JUfw3jtqp+0h3nyDCWTPI55iDjKOR6TPkkO+V+8viW/+HXaw/voU04ycUaeJqCXtD132DkNYyY49BYttslpiVxPN1hZ8AYAwL2120oEMFI18SMvgPrUTSG2binsFnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=L6E3xReg; arc=fail smtp.client-ip=52.101.71.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtYg7qvaVhnqLTD7dqGqVwztaNEjFb2IeGHdg9/0Vo5urueXN9kKzlgEFli7FgGmK7TLycOBXvbNK6ydl0NV2JXxC04rrhl45P7iLc/S2D4Vk1WeXQEQ9/EJYQla2bt2CeWPlRSHwBMLIwHlbhJd2Mrwri1kfi5155w50ebQTJTFoD/W+IWt36ubcsyDi7oNAqg6Qrjmkdr0qhzpRwYk4ZjduhEpwgVp/1/q/2UdFtwmNPZs0SFXV/Q0s+gQwoEHB1wcgWU27CY/aIYYaJyW8KAjvdCdn9Fp8b4OAzmA4H3Sn9GgJPwkA9j7X7HdhRmPPo7gYoWJOm2h1QHfJCJrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCcfvVAZiFpcNfaz0Jr3NeBeN3gSFpXFSv2Z3wmZQuY=;
 b=GRt9NPSI5HiHkKnKiMm08gGUkwlBvPjiSa9BPNyXm/scFEfm/n86x/IpYSLo4a5O+4JesPISP9EQzC31buv3ZcI9cdZ8y4HRhe6aSK91xZmojZmE4Hu7sAgdiaOtFxoQ0N24yBU49mg1ku75fcG7EqP1hoxVHiEQ+A6z5BDh2E+FjFdFY4Mjq4vFJoq10VLxsZeGMeguz/nLmIaHOFIfgdvrxbIrBa9ScSHRSfBr3LQee0yT4H+dNJWgcNoqKMVZ1mYoaYqwBVsnfMn5sVnY3+p8A+9NVkrjTV7Yt01uMGzL45ucsmabphS7GZoJXjmC9G9bx6eNG2d8OjiQkrZTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCcfvVAZiFpcNfaz0Jr3NeBeN3gSFpXFSv2Z3wmZQuY=;
 b=L6E3xRegjoYwra+XcJX1fMqLSCBH/qWJMwO6yFmz9BDNG+W5/fNhDPpWpb8bLJpcurFCmET6G5gOUsM3d1X5WnoerC5zemaKZZFId7tyyubLNdKzaCwKIRI6K11Cinfsdr+0rfmaIAtAs3wx/dMDap9WV4hs2W9x2BNNJ8nS9z0=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by AM7PR05MB6709.eurprd05.prod.outlook.com (2603:10a6:20b:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.15; Mon, 3 Mar
 2025 10:26:52 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd%4]) with mapi id 15.20.8511.012; Mon, 3 Mar 2025
 10:26:52 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
Thread-Topic: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
Thread-Index:
 AQHbh4kqbfMU9EdEvEuw3vrfgofl17NY02GAgAFgF4CAAEZNAIAAjvoAgAA164CABf/RgA==
Date: Mon, 3 Mar 2025 10:26:52 +0000
Message-ID: <091e810e9225014ab61fedd868f7fff70e864da4.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
	 <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
	 <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
	 <484b1563482aca871a147daeff916fcb0730c6d6.camel@polito.it>
	 <2a6924b36ab41fd5d9666de726b9f4a0754b9cbb.camel@huaweicloud.com>
In-Reply-To: <2a6924b36ab41fd5d9666de726b9f4a0754b9cbb.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR05MB9840:EE_|AM7PR05MB6709:EE_
x-ms-office365-filtering-correlation-id: 21cf467f-ea5a-40fb-06ed-08dd5a3dea05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3dZN1Vpa1VFeUV6STBveE4rM0NWQmxqd0J0ZzBHQ1dCY2o2bVhzbmplcmVQ?=
 =?utf-8?B?RXgxSW5EK2VZc0s2cnZ6MkRuZ3J6K2xhbTVHTWxMVFFjT3VLRjFPUjlyMzF1?=
 =?utf-8?B?Q1RHV045bU9TUERyTkNVdGgvdGQ1L1JPTTc5YzV5N3FEUDI0UFVMbVdKWkxR?=
 =?utf-8?B?by95OE5zZTl1SnNHWkZTQVFRdlJKL2NRZUNyNTBFY2JFZUxjTmpGVDFkY04y?=
 =?utf-8?B?VVBDQnhVbEdwK0pVZEN0ZkJheE5uMG14d0NuWWFZa1lWNlM3b0xoT044bVFy?=
 =?utf-8?B?V0lvbW00TjRlQzUyUjBwcHRhcHVKL2tSRjRCMjVHUml5RWVWL1ZSSWR1ei9q?=
 =?utf-8?B?RTB4NFBHLyt6WFN3YTBqdjRTRC9uUVV6Y0Y4Q1V2NWd0TUlyOU1jcmRKNXZF?=
 =?utf-8?B?SC9mbXV3dUhGRExkUG5qNkRpVXNQekdtRE83Q1A5cExHK21XZlUyNlkwYnlE?=
 =?utf-8?B?NUlSanE3Y0VoZnh0Sk1FelBPNkpQb2xJa0pReEFSUnlJM21kZHhFTGE4a1Q4?=
 =?utf-8?B?Zk15QnpjeU54UVlyZXUzT1dtMjFmV2NPc3FNdVY1Z2VQbnoyYzdST2xJMXpM?=
 =?utf-8?B?OHBBZWgrWVJQbk1VSDlKU1hidjlwc1JBdU43TjJGK0g5NmRwZkJuQ1RZSmZa?=
 =?utf-8?B?cFNvYkNFbFY0SzMxcHNCbkFNZERrd1Z3ZWI0TERaL1VuQk5ZeTdGbFJBdTBC?=
 =?utf-8?B?N3ZiQ2h4YnZiUzJENmVEN0hubEplOHRFeVltWTd6U0xPNGp4b1EzOXZ3OXdo?=
 =?utf-8?B?d0JKWHlidFNuUmk4VDFySGtrZk1waE5FVDlTVXVLSStmQ01vTUhHRlFxSEQz?=
 =?utf-8?B?SVo4N2pHSWZyeWk2eXpkOWlDVnRNNWkyS3VIblQ4c3hQNHk4blVQT0o3L2Zo?=
 =?utf-8?B?Rno1eTJaNU9XcDdVL2w4YWhNTUJkYjlHZENjN25NUlVrczJ6cDcvYUZvOFBX?=
 =?utf-8?B?TG52ZTVnWEN0dXZ0RG00K050MnpkMEV3S3NZWkJXTmtPUUVycENkQW5MTWpC?=
 =?utf-8?B?N3FMdWVuSzFLOWxab2p3aEVIdktJdmZjNkhTY1kwekxlYTh4b3BzSGwyN3FL?=
 =?utf-8?B?MUZ2Mk8wL2ZNcmRPTnpyVE9UVzdZbEloNzRJVGZic1FNMDdCbFlwYU1jSXU3?=
 =?utf-8?B?aFhmMERXcnRsYXJxYjVqMTdSeWdIajB1dWRFWEVzdmxmU2NYUjhDakpLN1Ji?=
 =?utf-8?B?QUFySGdoT3NpRFd3OUg5Q2dudTRJNXZmajJRTlNnWVdRR1lJUVd2TWRFdXBm?=
 =?utf-8?B?eExCdTUyRmVMQjZLM2RWZ0ZxRjdXd3RDRlF4TmNnbFNUY1BUWnlQaFJCS0lX?=
 =?utf-8?B?Y3ZPdHdtblBQeHF2RkJpS0VmVVl1empYcTFoRjVJSlAzZUlyN00zcHdoMVpS?=
 =?utf-8?B?REszclJKTFhFZ1lwR2xVa1RSY0xGR2xyQzg4M080Qlg5T3lPT2UzVDZuV2l4?=
 =?utf-8?B?Um1FNlRVUDlvSFBncmszalNqOHNxUkhDbnFPM3FXS2h6d1E0SHVxTVVrU0t0?=
 =?utf-8?B?cXliZW1NZDdhOWNTdjQ2anViWU55eVdDSXA1S01vN0NIVmlHYzFiVzdlZjhC?=
 =?utf-8?B?Zm4zOTFMeVkrWGlDZmFMWStaaEZDMmhVZ2RPK052djZpUXM3V0tiWjRZbWVU?=
 =?utf-8?B?a1ZhUWJEUW9hZnA2ZWZiV2dUcXBQTG1MTTJ6bGRHSHBrU3BOVU9vcVlFbVNz?=
 =?utf-8?B?TksyYWtHSm5BMzE1VFNxemdUODgvQlVadHllVGd1akJTTUlVSjVyNkU0S0xR?=
 =?utf-8?B?ZUh1NnozZVBIY3JYYnpCL3RlUXM4SHlkWDg5Y2gwc1kwUFFJekFmemt3bWw1?=
 =?utf-8?B?dGRrZnloWXEyR0FLUHlEYzVrY0d1VDJ5QWJrcEVSSVg0NDZLZkpMMnJTR0Ra?=
 =?utf-8?B?eG5wcnB2ZVAxalpySkwvVXZtYUhkcnhkQm9aQXoweE5abjJUMlpTa1JiNVpm?=
 =?utf-8?Q?LdqzG37d14heZuSZKa8ZmLGk0iLXxH97?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUZLU1dZaHg3eEJvUjdXSWJyTFJUaHdyVGIvOWJpUVByakYrOGQwTFpqYmlB?=
 =?utf-8?B?RDE2UHhzM2dNRnRkV3B6U2h5NlFoRE5ra2lacVQwQkF4bDduZFNmWHpLNEJ5?=
 =?utf-8?B?YUdGQ0V2bWtITndJYWZXR094a05obW1WZUI5YlA5Y2RCMy8yMmthU1F4QzR6?=
 =?utf-8?B?SWFYalRQY2k0djZKNWZkaWZab04zalNnN1pXVHgyTjdNVG13S2lUTHVOOGM5?=
 =?utf-8?B?ZEpRWFlFQ0ZBWlpCU2NvL01RS09oR3ROZXJWa0VkNFVOdStGTXNSNnEzTlpn?=
 =?utf-8?B?WDY4QUtjOGRZZHJPN083MzJXQkpQcktrWVY4dUROQXdHa3hCVU9pUlhnOElV?=
 =?utf-8?B?RlIwYkFJcjJOVnBWNFZwcyt4NGlEZmYwRTI4b25mME9mM0dncXBIUzI5RSt3?=
 =?utf-8?B?bHZmVFdRR1h5WVNQRE0vcW9kVWNqdjdXME1EbkxFV0lQbTBhVG40aTRFb3JR?=
 =?utf-8?B?TXA5SmdoZkZ1NjQ2RHEwVlRkVk80L3Ezc05UTGpFVjZZR0F2MjNaV0crQXlj?=
 =?utf-8?B?NmJLWm94QmlDdXN0bUdvYitwWjhybzZaTzlXbUlEdm5DaS9Xa2ZXbFZEczRZ?=
 =?utf-8?B?aDk1eWhLbGZGR0JRYTBXUHJoeXlrRFEyZFlvNE5JN3ZFZnJkZTAwbXhoYjBX?=
 =?utf-8?B?RDJKVGxYaG53UzNxdHhWYllZMlZkdmhZblk4SkZIbEFJQUp1ck9vbit3bFhM?=
 =?utf-8?B?cW1KSHdZaGhMTVpXdEw5elo4RndTR1JhcXhXUlZ4TWFpSksxeFZCdmlxRXBo?=
 =?utf-8?B?VEgzcmtMMDZ2VlpmeDM0dlpaMFprOHkvSDl1YUZGaDkwNWdXd1J3YXlHVGRo?=
 =?utf-8?B?MVFQVFlJMzZJZ1VxSUxEOHpRS3QyV3JjTlNtSVduNTFxQm8yeDJBdGVFL0FX?=
 =?utf-8?B?U0NUaElzeVErWVIxN0x2UmVheGtydEE5UWFFRC9DaURrcmZOOW9EL3FMTGt2?=
 =?utf-8?B?NGRabGthMGNnMU05MGFKM1JSM1ZhMU1uNmFwOU9IRW1lYzdTRlZ3ZzRqcWtJ?=
 =?utf-8?B?eXRMWkp5OWttK0UyRjFZWUpLYzNIZFprc05vdXJsdWJsL1ZWblNnck1ld2J1?=
 =?utf-8?B?ZVJaRkZDaFEycHN2NEY2dDRWWkptQ05qdnJrRnZiZjFmcno0cmd3SFVvNndD?=
 =?utf-8?B?amN5Z3lFNXI0WVFhY3dXMnk4czlUK21vSXNPT0o1cGxTVldXMFJWeHdDWmpx?=
 =?utf-8?B?MW45OWkzQkpJVXRyQXQ1RitvalBvWDFPL05jOVVsVkZEVC9SWkpBMlh6aEV2?=
 =?utf-8?B?QUw0T1RXdkZwRURXcWNPcjhFNmt5OVVnaW1KOW5zU1hzTkVWdHY2RFVJeEFP?=
 =?utf-8?B?Y011aFRlV1RxbkZaWElYU0ZHb2tmS0kwYWlwazFqRmw2ZUEzbTQ2dUNWcG9p?=
 =?utf-8?B?STU2RGxUK1pBZTFkNFZZUWpnZ3gvTytkYmMrU1ZZcXJFdTVxQWtUWS96RGxy?=
 =?utf-8?B?QWJuc3VSWkZOYnIzLzd1M1VvV2dGVElEdmtQS214Zm56ZGIyMWFzT2F6bWpI?=
 =?utf-8?B?SFE5TTh1d1BBRG5aSDQrWEgydnNJckJCM3hyNFdVTDJYMW82UWpUamFDVnB5?=
 =?utf-8?B?U1RzWGZpZWJLMGlmNEVyY3RRRkFZeVAwUDhsSnlBYmNJTXBwdTNZMzlYUzNV?=
 =?utf-8?B?RWZwTWpZUlVjYk1aU00yeFlHWS9LTW9lMm5SK1JiNVBQTVRMY0JMdXROM01L?=
 =?utf-8?B?R1pEMHllSW1XVHVjM1RpalpjbDA0enlZYjhCcVRSbk1vOW1MRWMzUG1YSnlS?=
 =?utf-8?B?QnJTcmFnU1NkYlBpV1N6QjdqOHdQT2NsbUlCYmZ0V1RuVVU5NVRLNDBuV3BZ?=
 =?utf-8?B?UXFSZUZrYTVjV2NjZEFCWlRqejVHajlwNGNHRnFCRTdGd1ZiQmk2OWVsWUx3?=
 =?utf-8?B?em9YdUpBaG1mcXZOdTVsREd4TUJHQTNkNStZdG1NK2dDd0JJUlR1N2hiOVpl?=
 =?utf-8?B?SlN2c0ZTclhianh0Si9TSDNITlRRMnQ0dGlDN3BnNjRIUnk4a3RhNmppY3ZG?=
 =?utf-8?B?NEtHMjdQUkhhbmNmMElnZFFuYTdvWm1VMDJJSExvNmFQNVJwZG8yUklHcE1l?=
 =?utf-8?B?UTQ1LzYrVi9TTklOekpFRWk5bTNVZk10SlJiR29KbzFyVTRDdFFkR3V3cy83?=
 =?utf-8?B?TWg0TWMzVm1FaHo3Y29XMWU2V0ZNZmQ0QUhaOEdQakgwVm5GM1BKT0NGS0Q5?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CD6D9F80C44124D8F5CA94ED7BC4ABF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cf467f-ea5a-40fb-06ed-08dd5a3dea05
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 10:26:52.1651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tn5pZrrABJ+s60uJQ+ZGeI5/5PnSg+191nZNNJ07kP1liK+kpD99Yqg6H61m7p6S5GPmdluPQ9zBkHfYcac50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6709

T24gVGh1LCAyMDI1LTAyLTI3IGF0IDE1OjQ5ICswMTAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjUtMDItMjcgYXQgMTE6MzYgKzAwMDAsIEVucmljb8KgIEJyYXZpIHdyb3Rl
Og0KPiA+IE9uIFdlZCwgMjAyNS0wMi0yNiBhdCAyMjowNSAtMDUwMCwgTWltaSBab2hhciB3cm90
ZToNCj4gPiA+IE9uIFdlZCwgMjAyNS0wMi0yNiBhdCAyMjo1MyArMDAwMCwgRW5yaWNvwqAgQnJh
dmkgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAyNS0wMi0yNSBhdCAyMDo1MyAtMDUwMCwgTWlt
aSBab2hhciB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIDIwMjUtMDItMjUgYXQgMTQ6MTIgKzAx
MDAsIEVucmljbyBCcmF2aSB3cm90ZToNCj4gPiA+ID4gPiA+IFRoZSBmaXJzdCB3cml0ZSBvbiB0
aGUgaW1hIHBvbGljeSBmaWxlIHBlcm1pdHMgdG8gb3ZlcnJpZGUgdGhlDQo+ID4gPiA+ID4gPiBk
ZWZhdWx0DQo+ID4gPiA+ID4gPiBwb2xpY3kgZGVmaW5lZCB3aXRoIHRoZSBpbWFfcG9saWN5PSBi
b290IHBhcmFtZXRlci4gVGhpcyBjYW4gYmUgZG9uZQ0KPiA+ID4gPiA+ID4gYnkgYWRkaW5nIHRo
ZSAvZXRjL2ltYS9pbWEtcG9saWN5IHdoaWNoIGFsbG93cyBsb2FkaW5nIHRoZSBjdXN0b20NCj4g
PiA+ID4gPiA+IHBvbGljeQ0KPiA+ID4gPiA+ID4gZHVyaW5nIGJvb3QuIEl0IGlzIGFsc28gcG9z
c2libGUgdG8gbG9hZCBjdXN0b20gcG9saWN5IGF0IHJ1bnRpbWUNCj4gPiA+ID4gPiA+IHRocm91
Z2gNCj4gPiA+ID4gPiA+IGZpbGUgb3BlcmF0aW9uczoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gY3AgY3VzdG9tX2ltYV9wb2xpY3kgL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3BvbGljeQ0K
PiA+ID4gPiA+ID4gY2F0IGN1c3RvbV9pbWFfcG9saWN5ID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkv
aW1hL3BvbGljeQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBvciBieSB3cml0aW5nIHRoZSBh
YnNvbHV0ZSBwYXRoIG9mIHRoZSBmaWxlIGNvbnRhaW5pbmcgdGhlIGN1c3RvbQ0KPiA+ID4gPiA+
ID4gcG9saWN5Og0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBlY2hvIC9wYXRoL29mL2N1c3Rv
bV9pbWFfcG9saWN5ID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3BvbGljeQ0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBJbiB0aGVzZSBjYXNlcywgZmlsZSBzaWduYXR1cmUgY2FuIGJlIG5l
Y2Vzc2FyeSB0byBsb2FkIHRoZSBwb2xpY3kNCj4gPiA+ID4gPiA+IChmdW5jPVBPTElDWV9DSEVD
SykuIEN1c3RvbSBwb2xpY3kgY2FuIGFsc28gYmUgc2V0IGF0IHJ1bnRpbWUgYnkNCj4gPiA+ID4g
PiA+IGRpcmVjdGx5DQo+ID4gPiA+ID4gPiB3cml0aW5nIHRoZSBwb2xpY3kgc3RyZWFtIG9uIHRo
ZSBpbWEgcG9saWN5IGZpbGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGVjaG8gLWUgIm1l
YXN1cmUgZnVuYz1CUFJNX0NIRUNLIG1hc2s9TUFZX0VYRUNcbiIgXA0KPiA+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoCJhdWRpdCBmdW5jPUJQUk1fQ0hFQ0sgbWFzaz1NQVlfRVhFQ1xuIiBcDQo+
ID4gPiA+ID4gPiDCoMKgwqDCoCA+IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kNCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSW4gdGhpcyBjYXNlLCB0aGVyZSBpcyBubyBtZWNoYW5p
c20gdG8gdmVyaWZ5IHRoZSBpbnRlZ3JpdHkgb2YgdGhlDQo+ID4gPiA+ID4gPiBuZXcNCj4gPiA+
ID4gPiA+IHBvbGljeS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQWRkIGEgbmV3IGVudHJ5
IGluIHRoZSBpbWEgbWVhc3VyZW1lbnRzIGxpc3QgY29udGFpbmluZyB0aGUgYXNjaWkNCj4gPiA+
ID4gPiA+IGN1c3RvbQ0KPiA+ID4gPiA+ID4gaW1hIHBvbGljeSBidWZmZXIgd2hlbiBub3QgdmVy
aWZpZWQgYXQgbG9hZCB0aW1lLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBFbnJpY28gQnJhdmkgPGVucmljby5icmF2aUBwb2xpdG8uaXQ+DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gSGkgRW5yaWNvLA0KPiA+ID4gPiANCj4gPiA+ID4gSGkgTWltaSwNCj4gPiA+ID4g
DQo+ID4gPiA+IHRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLg0KPiA+ID4gPiANCj4g
PiA+ID4gPiBUaGlzIHBhdGNoIHNldCBoYXJkIGNvZGVzIG1lYXN1cmluZyB0aGUgaW5pdGlhbCBj
dXN0b20gSU1BIHBvbGljeQ0KPiA+ID4gPiA+IHJ1bGVzDQo+ID4gPiA+ID4gdGhhdA0KPiA+ID4g
PiA+IHJlcGxhY2UgdGhlIGJ1aWx0aW4gcG9saWNpZXMgc3BlY2lmaWVkIG9uIHRoZSBib290IGNv
bW1hbmQgbGluZS7CoCBJTUENCj4gPiA+ID4gPiBzaG91bGRuJ3QgaGFyZCBjb2RlIHBvbGljeS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IE15IGZpcnN0IGFwcHJvYWNoIHdhcyB0byBkZWZpbmUgYSBuZXcg
Y3JpdGljYWwtZGF0YSByZWNvcmQswqANCj4gPiANCj4gPiBIaSBNaW1pLA0KPiA+IA0KPiA+ID4g
SG9wZWZ1bGx5IHRoZSBuZXcgY3JpdGljYWwtZGF0YSB3aWxsIGJlIG9mIHRoZSBlbnRpcmUgSU1B
IHBvbGljeS4NCj4gPiANCj4gPiB5ZXMsIGFic29sdXRlbHkuDQo+ID4gDQo+ID4gPiA+IGJ1dCBw
ZXJmb3JtaW5nIHRoZQ0KPiA+ID4gPiBtZWFzdXJlbWVudCBhZnRlciB0aGUgY3VzdG9tIHBvbGlj
eSBiZWNvbWVzIGVmZmVjdGl2ZSwgdGhlIG1lYXN1cmVtZW50DQo+ID4gPiA+IGNvdWxkDQo+ID4g
PiA+IGJlDQo+ID4gPiA+IGJ5cGFzc2VkIG9taXR0aW5nIGZ1bmM9Q1JJVElDQUxfREFUQSBpbiB0
aGUgY3VzdG9tIHBvbGljeS4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gSSdtIG5vdCBxdWl0ZSBzdXJl
IHdoeSB5b3UncmUgZGlmZmVyZW50aWF0aW5nIGJldHdlZW4NCj4gPiA+ID4gPiBtZWFzdXJpbmcg
dGhlIGluaXRpYWwgYW5kIHN1YnNlcXVlbnQgY3VzdG9tIElNQSBwb2xpY3kgcnVsZXMuwqDCoA0K
PiA+ID4gPiANCj4gPiA+ID4gTXkgaW50ZW50aW9uIGlzIHRvIG1lYXN1cmUgdGhlIGZpcnN0IGRp
cmVjdCB3cml0ZSAobGluZSBieSBsaW5lKSBvbiB0aGUNCj4gPiA+ID4gcG9saWN5DQo+ID4gPiA+
IGZpbGUsIHdpdGhvdXQgbG9hZGluZyB0aGUgaW5pdGlhbCBjdXN0b20gcG9saWN5IGZyb20gYSBm
aWxlLiBUaGlzIGNhc2UsDQo+ID4gPiA+IGlmDQo+ID4gPiA+IEknbQ0KPiA+ID4gPiBub3Qgd3Jv
bmcsIGlzIG5vdCBjb3ZlcmVkIGJ5IGZ1bmM9UE9MSUNZX0NIRUNLLg0KPiA+ID4gDQo+ID4gPiBX
aGVuIHNlY3VyZSBib290IGlzIGVuYWJsZWQsIHRoZSBhcmNoIHNwZWNpZmljIHBvbGljeSBydWxl
cyByZXF1aXJlIHRoZQ0KPiA+ID4gSU1BDQo+ID4gPiBwb2xpY3kgdG8gYmUgc2lnbmVkLsKgIFdp
dGhvdXQgc2VjdXJlIGJvb3QgZW5hYmxlZCwgeW91J3JlIGNvcnJlY3QuIFRoZQ0KPiA+ID4gY3Vz
dG9tDQo+ID4gPiBwb2xpY3kgcnVsZXMgbWF5IGRpcmVjdGx5IGJlIGxvYWRlZCB3aXRob3V0IGJl
aW5nIG1lYXN1cmVkLg0KPiA+ID4gDQo+ID4gPiBXaHkgb25seSBtZWFzdXJlICJ0aGUgZmlyc3Qg
ZGlyZWN0IHdyaXRlIj/CoCBBZGRpdGlvbmFsIGN1c3RvbSBwb2xpY3kgcnVsZXMNCj4gPiA+IG1h
eQ0KPiA+ID4gYmUgZGlyZWN0bHkgYXBwZW5kZWQgd2l0aG91dCBiZWluZyBtZWFzdXJlZC4NCj4g
PiANCj4gPiBZZXMsIHlvdSByaWdodC4gVGhlIGFpbSB3YXMgdG8gbWVhc3VyZSAoYXQgbGVhc3Qp
IHRoZSBmaXJzdCBvbmUsIGJlY2F1c2UgaXQNCj4gPiBzdWJzdGl0dXRlcyB0aGUgYm9vdCBwb2xp
Y3ksIGJ1dCBpZiB5b3UgYXJlIG9rIHdpdGggYWRkaW5nIGEgY3JpdGljYWwtZGF0YQ0KPiA+IHJl
Y29yZCwgaXQgd291bGQgYmUgZGVmaW5pdGVseSBiZXR0ZXIuDQo+IA0KPiBIaSBFbnJpY28NCj4g
DQo+IGluIGFkZGl0aW9uIHRvIHdoYXQgTWltaSBzdWdnZXN0ZWQsIEkgYWxzbyBsaWtlIHRvIGlk
ZWEgdGhhdCB0aGUNCj4gUE9MSUNZX0NIRUNLIGhvb2sgY2F0Y2hlcyB0aGUgZGlyZWN0IHBvbGlj
eSBsb2FkaW5nLiBUaGF0IHdvdWxkIG1lYW4NCj4gdGhhdCB0aG9zZSB1cGRhdGVzIHdvdWxkIGJl
IHNlZW4gaWYgdGhlICd0Y2InIElNQSBwb2xpY3kgaXMgc2VsZWN0ZWQuDQoNCkhpIFJvYmVydG8s
DQoNCmluIHRoaXMgY2FzZSwgd291bGRuJ3QgYmUgdXNlZCB0aGUgY3VycmVudCB0ZW1wbGF0ZT8g
V291bGRuJ3QgYmUgYmV0dGVyIHRvIHVzZQ0KdGhlIGltYS1idWYgaW4gb3JkZXIgdG8gaW5jbHVk
ZSB0aGUgdGV4dHVhbCBwb2xpY3kgcmVwcmVzZW50YXRpb24/DQoNCkluIGFkZGl0aW9uLCB0aGVy
ZSB3b3VsZCBiZSBhIG5ldyByZWNvcmQgZm9yIGVhY2ggbGluZSBvZiB0aGUgaW5wdXQgYnVmZmVy
LCBhbmQNCm1lYXN1cmluZyB0aGUgaW5wdXQgYnVmZmVyIHdvdWxkIHByb2R1Y2UgZGlmZmVyZW50
IG1lYXN1cmVtZW50cyBmb3IgdGhlIHNhbWUNCnJlc3VsdGluZyBwb2xpY3kgZW50cnksIGJlY2F1
c2UgZGlmZmVyZW50IG9yIG11bHRpcGxlIHNlcGFyYXRvcnMgY2FuIGJlIHVzZWQuDQoNCkkgb3B0
ZWQgdG8gcGVyZm9ybSB0aGUgbWVhc3VyZW1lbnQgaW4gaW1hX3JlbGVhc2VfcG9saWN5KCkgYmVj
YXVzZSBpcyB3aGVyZSB0aGUNCm5ldyBwb2xpY3kgYmVjb21lcyBlZmZlY3RpdmUgYWZ0ZXIgaW1h
X3VwZGF0ZV9wb2xpY3koKSBhbmQgY2FuIGJlIGRvbmUgYSBzaW5nbGUNCm1lYXN1cmVtZW50IG9m
IHRoZSBuZXcgcnVubmluZyBwb2xpY3kuDQoNClRoZSBtZWFzdXJlbWVudCBjb3VsZCBiZSBkb25l
IGEgYml0IGVhcmxpZXIsIHdvcmtpbmcgb24gaW1hX3BvbGljeV9ydWxlcyBhbmQNCmltYV90ZW1w
X3J1bGVzICh3aGljaCBiYXNpY2FsbHkgY29udGFpbnMgdGhlIGlucHV0IGJ1ZmZlcikgYmVmb3Jl
IHRoZSBzcGxpY2luZywNCnNvIGl0IHdvdWxkIGJlIGNvbnNpZGVyZWQgdGhlIGN1cnJlbnQgcG9s
aWN5IGFuZCBub3QgdGhlIG5ldyBvbmUuIEluIHRoaXMgY2FzZSwNCml0IHdvdWxkIHdvcmsgYWxz
byB3aGVuIGltYV9wb2xpY3k9dGNiIGlzIHNldCwgYW5kIGl0IGNvdWxkIGJlIGNhbGxlZA0KcHJv
Y2Vzc19idWZmZXJfbWVhc3VyZW1lbnQoKSB3aXRoIFBPTElDWV9DSEVDSywgdG8gZ2V0IGEgcmVj
b3JkIHdpdGggdGhlIGVudGlyZQ0KSU1BIHBvbGljeS4NCldoYXQgZG8geW91IHRoaW5rIGFib3V0
IGl0Pw0KDQpCUiwNCg0KRW5yaWNvDQoNCj4gSSB3b3VsZCBoYXZlIHJlY29tbWVuZGVkIHRvIHRy
eSB0byBhZGQgYSBwcm9jZXNzX21lYXN1cmVtZW50KCkgY2FsbCBpbg0KPiBpbWFfd3JpdGVfcG9s
aWN5KCksIHdoZXJlIHRoZSBidWZmZXIgdG8gYmUgcHJvY2Vzc2VkIGlzLg0KPiANCj4gSG93ZXZl
ciwgSSBndWVzcyB5b3UgbmVlZCB0byBoYXZlIGEgdmFsaWQgZmlsZSBkZXNjcmlwdG9yIGluIG9y
ZGVyIHRvDQo+IHVzZSB0aGF0IGZ1bmN0aW9uIChtYXliZSBhbiBhbm9ueW1vdXMgaW5vZGU/KS4N
Cj4gaW1hX2NvbGxlY3RfbWVhc3VyZW1lbnQoKSBzaG91bGQgYmUgYWxyZWFkeSBhYmxlIHRvIGhh
bmRsZSBidWZmZXJzLA0KPiBwYXNzZWQgYnkgaW1hX3Bvc3RfcmVhZF9maWxlKCkuDQo+IA0KPiBU
aGFua3MNCj4gDQo+IFJvYmVydG8NCj4gDQo+ID4gVGhhbmsgeW91LA0KPiA+IA0KPiA+IEVucmlj
bw0KPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiBDb25zaWRlciBkZWZpbmluZyBhIG5ldyBjcml0
aWNhbC1kYXRhIHJlY29yZCB0byBtZWFzdXJlIHRoZSBjdXJyZW50DQo+ID4gPiA+ID4gSU1BDQo+
ID4gPiA+ID4gcG9saWN5DQo+ID4gPiA+ID4gcnVsZXMuwqAgQWxzbyBjb25zaWRlciBpbmNsdWRp
bmcgdGhlIG5ldyBjcml0aWNhbC1kYXRhIHJ1bGUgaW4gdGhlIGFyY2gNCj4gPiA+ID4gPiBzcGVj
aWZpYyBwb2xpY3kgcnVsZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHRoaW5rIHRoYXQgeW91ciBz
dWdnZXN0aW9uLCB0byBhZGQgdGhlIGNyaXRpY2FsLWRhdGEgcnVsZSBpbiB0aGUgYXJjaA0KPiA+
ID4gPiBwb2xpY3kNCj4gPiA+ID4gcnVsZXMsIHNvbHZlcyB0aGUgcHJvYmxlbXMgb2YgYnlwYXNz
aW5nIHRoZSBtZWFzdXJlbWVudCBhbmQgaGFyZCBjb2RpbmcNCj4gPiA+ID4gcG9saWN5Lg0KPiA+
ID4gPiANCj4gPiA+ID4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBmZWVkYmFjay4NCj4g
PiA+IA0KPiA+ID4gWW91J3JlIHdlbGNvbWUuDQo+ID4gPiANCj4gPiA+IE1pbWkNCj4gPiA+ID4g
DQo+ID4gDQo+IA0KDQo=


Return-Path: <linux-integrity+bounces-4396-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384609F2A80
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2024 07:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC921188138E
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2024 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860011CB337;
	Mon, 16 Dec 2024 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="MDCt8DMD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17532A48;
	Mon, 16 Dec 2024 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332148; cv=fail; b=rK4pZgh0MBQgcf6dVmS3kfVgXRH/EN3c/l/+6eLiFHpA04osEnuh8HjM4KTgBVWQCbZZL4J/rQ5/d5FTlVFBv8uJa6+N0MVGmtzttd/X7K+u2DeKXn84/s+AjKnfXfWnH33SZhK55CbQTN8jpKS8GXNVgDRgnDHT+qnJl6aJUHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332148; c=relaxed/simple;
	bh=VdhKaW1PZAe7m0demFwHXacY+QK0VwIK9RXY1snVTDQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=alHrxWTjfMpnGSsZqhHb7zuJy2AgW5zpgSLNUj2xWni+R8Qkxs4x22lpBDmI5YS2bcRGtgY9R4QP5W/IW+PEMdHzWNBF+4AsqLbw/gVNLxVTlKdJ+Ewh+WLKufu6TuTo/ObeTmW9O2WEc18lIpcIPZsRMfIvNBY6pt8+VIJltA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=MDCt8DMD; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG1LVBp010651;
	Mon, 16 Dec 2024 06:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=xESXDBeP0UjYLovKDiVpoeGgj5/umvS
	eC5uavnVU2h0=; b=MDCt8DMDxKVFq1iIl4BxHf66NssvZ3NvJzjc/3AbhcgmUCk
	30oq3WZjxkplBezf+AqR2aCB5LxaQdC3kXARiiYkzH+Mt23ItwS8MInuj20Zjj4G
	G+HO/YN+3tZn14VNf6Vre1NL+AH0SAjyRhvurgdJIVhD2Q/ZVKnV488AlsyT1Kxc
	Y4NwSLe7wTk6/h+89z/N0ezWDczNwoQDNu3/yER63b05pC/QXz8Rie+alKCqSiaD
	OINoMSDokd59BJsDAX4RFnGIz+ql4OINCnqc/Not+vrlAesq4H6MUpuPI6Jp4qfQ
	FrzROpZ61vlEjHtsE5f6238d2JSwqtIL1eNXbGA==
Received: from hk3pr03cu002.outbound.protection.outlook.com (mail-eastasiaazlp17011024.outbound.protection.outlook.com [40.93.128.24])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43gy8wsf73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 06:04:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE7RUizHZB+8aMssPDFo6NoaUU9kZ/ZqakVUH+MbUhkxnYIlJkLakaT/oHLSKyKLnH4FqZZeZxIw6rxX6knFurBTqNQwzkix2cuQ+/awYQSryngUUGRv5ywL2NTelBWNrHHMGXjoBiM85QHC/VLoNFyrHJDACREASpcNnnZlmgDiS+C3PedwnUGLIbL5FqIr/jmsuww7p0eDLx4QlseILhES2QJ6mIm4fDwypP3ZEy+gaBioROK5AMneLtvYYnBZ2wp1MYjO1G2Vbm2lCE95RgDGsbkZ1hYBpz2xe6DZVRxdvUM+VALsaNsU3F8bbvAtq1U2fsafvDWHOGqLhmK87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xESXDBeP0UjYLovKDiVpoeGgj5/umvSeC5uavnVU2h0=;
 b=Op/HujZsz2sKyxU341Y7xngDgnhvEZneMmcpZPqIH9dx3m0IW3ekSib2foVIm79UB6VI4fM2WWmSvA+WJdVeGd+iAuH1JruJdUpNpRzxBm515ncAOST0K9oXTAZpDbg7UZ4S1kJ0C5HM985re/Ko9JvCVxJzxSqLrKgaXFUv8y/QcG6echLlEo7xKPNHFOxwmPEyqmcEcXtE7v9i8Lj8Y7JUpLoVKciRLh0l+JxvniU6z2izpTC5pt8yUdUbMuU0TH/JgCaQReICdcNDN8UBrC56j7zkaJDyzQc3u6Vyam1oAF3a051C+HNrUgl4oSxNx3RCCn9xGuJgYlla2l9+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6486.apcprd04.prod.outlook.com (2603:1096:301:f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 06:04:29 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:04:28 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
Thread-Topic: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
Thread-Index: AQHbSktW2+Jjp9TjpUCMlyY1lZIvgbLgT5vBgAARQgCACAmSTg==
Date: Mon, 16 Dec 2024 06:04:28 +0000
Message-ID:
 <PUZPR04MB6316F684BF023564B7DDD812813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB6316E053BBAA0B434A32A147813E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <6759037a.050a0220.17f54a.0003.GAE@google.com>
In-Reply-To: <6759037a.050a0220.17f54a.0003.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6486:EE_
x-ms-office365-filtering-correlation-id: 867d9dd2-db89-4f57-15f6-08dd1d97803d
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YR6/UD/3KMns98iN+mEiA4GNhyRM4EVEWsiS7upmqsf4/bNrwp7SHN6YUI?=
 =?iso-8859-1?Q?SG3WPPL6xrFVtwTaJU+2yZz+d2RnTgd7VQ+DCUcvLCiHeqSsh0q/2Qyc3i?=
 =?iso-8859-1?Q?5kgsPGYPltsJ7eXnUB09+JDaLddwRi9wx4NCbqw1sQKCL86zDGCK/Ijzrw?=
 =?iso-8859-1?Q?G4YZ1ym5wpTn9gtKleGa1RvDSyTxEjU69cEzGxMwj2VkDjQHGd27lVZBFg?=
 =?iso-8859-1?Q?RDyvUtdWwfZ/qlfYLOilNsXft3tndmwQ38kYic4ygkpCTUm3SP3GM6ODGt?=
 =?iso-8859-1?Q?VrPaf2uin50fYJLjH9OutHiqG/Hsqid1rVnuEqQmHINWLGfEN/fDk6Sst1?=
 =?iso-8859-1?Q?dbyTs2LIh5vw+5OtForCM0ckVMoMSxwfbOA8OWY+isyY6/xWAta66Uny9p?=
 =?iso-8859-1?Q?SC3z5eox+I07to6WWuBCYmGJVuAuMYbSZ5eyGeBpgXFMuXtUgmqm9F40g4?=
 =?iso-8859-1?Q?cx2w87fFwsP4LQ1kOckY5G91CW1+DWJGNHjUY6w5KKqRIaKA+K8uaWwWjN?=
 =?iso-8859-1?Q?5HLH/x+sfQvwc3kxxkQtQWZ5nGOf6bfqViUEBYFbOgnCGYulb2VvEdGtlV?=
 =?iso-8859-1?Q?UqpvASTRxehvncULapT06RJPMTzErCTJK+WC3DQLpZHc9RyAQuowQrEtCh?=
 =?iso-8859-1?Q?cRiBpGv2jvOu3dFJk4uGWxSHa4vWqP6+iR9xvZ4JlO5UMGnMGEzRUeZxhw?=
 =?iso-8859-1?Q?bD2sgzO1jRqkwvPCvT7eCITrxry/eecX8B6A2aow8RVIfd4trTAitukqDq?=
 =?iso-8859-1?Q?E/aXpak54wWWBdTzVvTW/wMtGo5Y1mY3w+li/WHMiGbtPPjHS5AOCq31dz?=
 =?iso-8859-1?Q?kh5eTd05AJKdmprkWEORajjXUBE3tPb08KymbLN6M9iJRNQOj5uzmZYqx2?=
 =?iso-8859-1?Q?GA2J/LfoiXTUDkt0jCY2T0fEOYEWOtt6Kt2HYJkn3Wf2Sz83X/2PsFRPJj?=
 =?iso-8859-1?Q?oXn8b3imIs9gCukFVM7XQ9kUret0MzeGmqDEwcRTCkoALKczq7LkGe6kcc?=
 =?iso-8859-1?Q?S4NDCaoLTOAivwnm/+aHZ2zX9eyhzW9oiZEbO9W8SN2oDn7J74ha4TEHk4?=
 =?iso-8859-1?Q?9LN5pmoo1Pxhzx/zgJmj0nm0XcRaIG4W4F8GqV0znc4Fa/gRRX4SQj7KoP?=
 =?iso-8859-1?Q?0VD4EWXEgv+LfXYoovd1oUyBtOeHM1RBrOc1AyNuJS8C6fgC18mX+YsETB?=
 =?iso-8859-1?Q?oU7p5tFxWPuM6xfAYD7WiHtPfOcGFB1pzwk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9WmQBZtYTGuJo87ynbcFBca3fR/rAjrS3Tiy9bEhFhij5Ca3z02B/xxNk6?=
 =?iso-8859-1?Q?BK0iEOAkMrcy/qcWXLUzzan12E5DjOZrz6wR6gBPZvYd+n+RFhEwsqaZNN?=
 =?iso-8859-1?Q?p259KNl/XU1HSjbC0xJLUG/q2Rnph3h9vQZpPmKzMC2LGpIP7Eg4y2ygCM?=
 =?iso-8859-1?Q?7vF7/kpO4bqa+NRsMDaYgNUYR6ykoWWNkfcjd7EtI5wxsUhDN9VTjyaIlD?=
 =?iso-8859-1?Q?Z8LrlskvDBS43QP38LwgxpmsG7sr1VlX8JPFNers3zm7XqkVLz5oUIu5W6?=
 =?iso-8859-1?Q?k5Eg80TRnZfe6nuMea3eITJW+tUVCVABmQn4x8VNMrvhZMY93XCROx9OxM?=
 =?iso-8859-1?Q?TRY431I4Z2wO3QLtOO/zuX84hFBeKFPDxEQj6J8hcmVleahpPihXUj5tZH?=
 =?iso-8859-1?Q?c515vZQ4QhK7OGN7St12wrOXxA7Jn2MP+W2s6sLe5hYxMuDf3j9hSUWl+w?=
 =?iso-8859-1?Q?9sDdcc0ll7SNMDjhc+NUVF8B5hDgEp9SdeA9BpnIp+8IRhwVecDqcx8pWM?=
 =?iso-8859-1?Q?S1Eia6QNFnayhrbA6rLo1onD49wpHeJfL0UWDTo24ctEuWlNlj7WBy+Qni?=
 =?iso-8859-1?Q?Nj7o/TkA8KuN3tE3yNZqOpimLBNsBU0blS/If85xbLs+F/RLLWzcRbuVq1?=
 =?iso-8859-1?Q?Pxg3SY92iHQVdRAWm0Opz2xH2QTq7BSYAf0h7B+mkDwyCVCO+bJ3/6FXET?=
 =?iso-8859-1?Q?s/O84thUOQpBvbHCfpqFo1CLiHwNoodVlvo7LrgoiEcl50q2AJHs4Zmjeo?=
 =?iso-8859-1?Q?Psm9MAawnR5iOoTS5PeAzI9Xj4LsljpYMpxlXw8rBcKRnjyGvmeKgGaonC?=
 =?iso-8859-1?Q?b5WFvxjz+wOXqZjzQMi6QiEaIV2Ty2GqBdXC6rfp8HO8ZtQqClnaWpkLOs?=
 =?iso-8859-1?Q?cST4IN+ZRy9RtMrpP3wEcXte3XVwwmyToHkAwRK0gtsTdtjHF8BsAHNGRf?=
 =?iso-8859-1?Q?qG2mCTMRWOg6OQQoVBoGYTYiqVYXSuRG0CGYuFrHAUdRut3sQDMfgZG8VI?=
 =?iso-8859-1?Q?jBoiGR9T86APrGzJ0dG1A70tqprH/EfqpMuKYB5OSDr1kvljMP594PREMc?=
 =?iso-8859-1?Q?0IXbeRkXGhmZFWMxGJrkBOYBRWO6DJuN0el7m0VIqEkXTsqGmAqQSFMcuU?=
 =?iso-8859-1?Q?QX+8To+bSIcZP2IKY4gsO404lnxHIvEU1mic3ZSnvZyHQpH3/8VXV+6Q39?=
 =?iso-8859-1?Q?2NXPEQgPC60bJLm3qhcKN0KU2EcFrTnlyGyUQ6XLak2+J9fymtHIfHLMPy?=
 =?iso-8859-1?Q?dra5lewPJdFViK0CjfuaaWrvmXIJAXpBp5mWuKuqfHoH+FRFGuv+oEj62g?=
 =?iso-8859-1?Q?70Y8MnkZlHd/p+bq7zocsZ7TSRJd5RfLFiMcXwg2YCW3juI6pLAnohnxAP?=
 =?iso-8859-1?Q?w7uhLMPcvHLrutCvJ+lWAgpYhkuiW3XDRIhXOB7zgKnjERkPBOtHLwz5aI?=
 =?iso-8859-1?Q?F/GV+PKtKtXVhj/kD/aOaG0q3SMJtuiKK2CO905sKN/LT7TRNnOGfpb0f1?=
 =?iso-8859-1?Q?chr0SP2xq12hS0eub8avIpQlLzuMyXmhzvJg5X19zJPaQ9npFNGY+qK4k+?=
 =?iso-8859-1?Q?BmgnJnHfAByIrzaTYSpXoYQjZuwvyoNC4oKLZPyNapuCcV6H4QcohiFg+X?=
 =?iso-8859-1?Q?7gGMp/E4XHRcwLmTNT6xWMRcmok42G6u1W68n1MWI+logXtHun7JTqpooL?=
 =?iso-8859-1?Q?6tOeNhF4aUHmzFdy3sM=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316F684BF023564B7DDD812813B2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IdIEDkrogdmzz4/kKf+pJfmRkoSCw+FjiebDzOcQf1zDmN7VU2kCguOdAmpmKTHIOIGhJCY8KV4DLC87ClVqL9DRK5TaCYg6vqs5o/S5+pbT3oZ1w9Xaz/+DfOz6LszcqPLpK/VOfm+1Ei+S/MhNQykoDvrAYzVWmYwSHlcbX7nWmKl3nm/sM++a6xM0UItqeCG1jGs3nXkLQyJzeeh99BKKmS0vLlmD7sWMrZxWORQph+q0zv4/z2NvY185HpwzrnaQU2zyU1oKcepu5opIRv6LDHvytSjUT4VNKwh2Z+u+g4bgEm3GtZu8PChgzQm2Ynp/XF4HIv1v3HzQAOMen42zMV1KaULNFhqW1XCBsQsEpqVZpW+ISph2jouZR0+QI4DNYCEy1I2z1jMbHNjoKzkhtv8+lRPwBnzrmWaAKaOqW8dZ1ECrsYC//gO1hwfqyr7HPxJdzGvkvhlfP1twpzBeumakFEXZqU7G51xNrO23AxJvj0zT2G51cSpn/298CovsjqKz4yYJiM8fzOWTRhczAd1Vp0QlilWPcuUfcANJIxUsyPSlIiDVOTK0bqAa6MZrZ/DiGqOtiiB2qiv9tHMgs3CrMqKsgZCkzUoqmrS2zRlRheY0jd3XzQptgWwL
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867d9dd2-db89-4f57-15f6-08dd1d97803d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 06:04:28.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nS1Gjmvt4g3AoBsuaPL56av+dtGIlV0X5tEf4xcK7ycpNr8XoAAdMiXZw3cQ6aC7VxRaDwQZoMj6Zd94KmDvZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6486
X-Proofpoint-ORIG-GUID: 8lY5-3O_lzYjB7B1LpSBtpeuraA67eA3
X-Proofpoint-GUID: 8lY5-3O_lzYjB7B1LpSBtpeuraA67eA3
X-Sony-Outbound-GUID: 8lY5-3O_lzYjB7B1LpSBtpeuraA67eA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_02,2024-12-13_01,2024-11-22_01

--_002_PUZPR04MB6316F684BF023564B7DDD812813B2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB6316F684BF023564B7DDD812813B2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="0001-exfat-fix-the-infinite-loop-in-__exfat_free_cluster.patch"
Content-Description:
 0001-exfat-fix-the-infinite-loop-in-__exfat_free_cluster.patch
Content-Disposition: attachment;
	filename="0001-exfat-fix-the-infinite-loop-in-__exfat_free_cluster.patch";
	size=1200; creation-date="Mon, 16 Dec 2024 06:03:33 GMT";
	modification-date="Mon, 16 Dec 2024 06:03:33 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NWE3Zjg3NzhlOTI5MTA0Njg0ZDk3NWU2MzdlYWUwMTMzNmQwODJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMTYgRGVjIDIwMjQgMTM6Mzk6NDIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBleGZh
dDogZml4IHRoZSBpbmZpbml0ZSBsb29wIGluIF9fZXhmYXRfZnJlZV9jbHVzdGVyKCkKCkluIF9f
ZXhmYXRfZnJlZV9jbHVzdGVyKCksIHRoZSBjbHVzdGVyIGNoYWluIGlzIHRyYXZlcnNlZCB1bnRp
bCB0aGUKRU9GIGNsdXN0ZXIuIElmIHRoZSBjbHVzdGVyIGNoYWluIGluY2x1ZGVzIGEgbG9vcCBk
dWUgdG8gZmlsZSBzeXN0ZW0KY29ycnVwdGlvbiwgdGhlIEVPRiBjbHVzdGVyIGNhbm5vdCBiZSB0
cmF2ZXJzZWQsIHJlc3VsdGluZyBpbiBhbgppbmZpbml0ZSBsb29wLgoKVG8gYXZvaWQgdGhpcyBp
bmZpbml0ZSBsb29wLCB0aGlzIGNvbW1pdCBjaGFuZ2VzIHRvIG9ubHkgdHJhdmVyc2UgYW5kCmZy
ZWUgdGhlIG51bWJlciBvZiBjbHVzdGVycyBpbmRpY2F0ZWQgYnkgdGhlIGZpbGUgc2l6ZS4KClNp
Z25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KU3VnZ2VzdGVk
LWJ5OiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgotLS0KIGZzL2V4ZmF0L2Zh
dGVudC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhmYXQvZmF0ZW50LmMKaW5kZXggNzczYzMyMGQ2
OGYzLi5hYjI5YzMwZWJhYWIgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2ZhdGVudC5jCisrKyBiL2Zz
L2V4ZmF0L2ZhdGVudC5jCkBAIC0yMDEsNiArMjAxLDggQEAgc3RhdGljIGludCBfX2V4ZmF0X2Zy
ZWVfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfY2hh
aW4KIAogCQkJaWYgKGVyciB8fCBuX2NsdSA9PSBFWEZBVF9FT0ZfQ0xVU1RFUikKIAkJCQlzeW5j
ID0gdHJ1ZTsKKwkJCWVsc2UgaWYgKG51bV9jbHVzdGVycyA+PSBwX2NoYWluLT5zaXplKQorCQkJ
CWJyZWFrOwogCQkJZWxzZQogCQkJCW5leHRfY21hcF9pID0KIAkJCQkgIEJJVE1BUF9PRkZTRVRf
U0VDVE9SX0lOREVYKHNiLCBDTFVTVEVSX1RPX0JJVE1BUF9FTlQobl9jbHUpKTsKLS0gCjIuNDMu
MAoK

--_002_PUZPR04MB6316F684BF023564B7DDD812813B2PUZPR04MB6316apcp_--


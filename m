Return-Path: <linux-integrity+bounces-9792-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id loo7KVrPK2riFQQAu9opvQ
	(envelope-from <linux-integrity+bounces-9792-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2026 11:20:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9D678334
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2026 11:20:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=MhfcRLii;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9792-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9792-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CF943083185
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2026 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436FC2DC76A;
	Fri, 12 Jun 2026 09:19:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021080.outbound.protection.outlook.com [40.107.130.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0915B971
	for <linux-integrity@vger.kernel.org>; Fri, 12 Jun 2026 09:19:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255982; cv=fail; b=Xw7SMiMNCUgxyl7qiD8O/rrundgrE/FZWyGD/4F41j+G7Ez3veX5H23tweuG4lzL8sR8BKWtFx/qXwzTdkvFHSpi7rwWJAjZuur/zSoarE81m0Mq/JlPR6swvl/SOVWwD5ukmMOQnFvHubUj1xHKfXsxdGTEHTQYV0MMXAuh1I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255982; c=relaxed/simple;
	bh=vhivCEQlbt1EhfSI99aBIII+1rtY3Sv1Astc5s4x40I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRWthNoRjqINzOLYU+vof2TEgOnIUftfx/PUXW+Nvqlcq8uWFyhL0U7kB21mA/iS+RGq/z8mLmADulGyYqYVtyd2CYykshlRlioTH893mAQeguRwcyo880sQJJRYzPeQCVl4XSGxyfOdEPW6Jx/5vfgVcZZ3TqKYxUp9IFFB1zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=MhfcRLii; arc=fail smtp.client-ip=40.107.130.80
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQHOlYgibMAnUFI/7qzpL1OLJCqUWu9rWEFfHyHKHigHpZwLlwUBGC6XYI4qn8LuNo943MbyXTB55RXsYZK968GOUPa9J4YD5QiHYcSQFvwkECsgjU/D21reNOHPv+/uZZ7ykqSPZl5LgrOpvvfmYaSYGmj8CTiCq+/eRILhPRVy+mCKQyzNZdtIcagjhsptUDIYkrAwp8fY5OcHV04+HRLzSdrvfbZlQU5hprxBUya8epfAqKZPiuZ0tt77c1LjOigs7dKWRNSYoNqIhHwP96vT1efEdqwrc0yJXl6WdwwomCLofeXeWkfGYc+5qgoGKMDy/4v1X14syuy5UKA8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhivCEQlbt1EhfSI99aBIII+1rtY3Sv1Astc5s4x40I=;
 b=kq+CXueDe5ChJMJREbpg5PeChcS72SHHXwxYK+vZXw4I1Cx22WAtgZXdhZYJbtSBsj/DxVQ3LZ7jPNF5czs5ScQ1/TOWmbAjXnNYwtUGNF0MXMUMATjB1Hg366+9GFFVGXHTWX9aF9LiL2JVO3jA9P2ALmoZH+XyVQXTTjF+7ksyVB9gaerd7MvtcSJcU0Hs4b63ztclEZabQAlu6E0hwVCQvAixqpkVtdYf/GwWXKy9KKtPSiUMnP6nn5YNz0B1U2UN1o70IZJpZoF72wUL2w+raZjwQq+JFWHRoLplKCb2By/xnqjcew7sTJzNCwTfgmPtJsCKnMMTexBSoh+Mow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhivCEQlbt1EhfSI99aBIII+1rtY3Sv1Astc5s4x40I=;
 b=MhfcRLiit3BLLg5OxZreZO4ulUT5EPNWq9W+VjQsxLHfBIryT/EEdHASphFNG6Gm9+6AH9Ot6z096pLY1+fgVOz6h2TvvbJFCqqXc6pF3gGtxzh7ivuDhXZ3G5NrMKjpdfNS9vPL0CeIk5BCERbZFY1XpcJNKSgwPsIhuwB08SE=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by PAXPR05MB9003.eurprd05.prod.outlook.com (2603:10a6:102:2b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:19:36 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:19:36 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [RFC][PATCH v3 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Topic: [RFC][PATCH v3 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Index: AQHc7Rb/p4OAI86ozkSrMHU+y/Y+ebY38b4AgAF1/gCAABvVgIABO2yA
Date: Fri, 12 Jun 2026 09:19:35 +0000
Message-ID: <547e1c9c8c54ee4fc043991a4436c48adf7fa0b8.camel@polito.it>
References: <20260526135118.289633-1-enrico.bravi@polito.it>
				 <20260526135118.289633-2-enrico.bravi@polito.it>
			 <f48148da72e9111235cb06d9c4d6c959d5c67035.camel@linux.ibm.com>
		 <7149d8e873fe59fedffd23a06c9c647d42660328.camel@polito.it>
	 <5703152fed864a39eb54cfccb571e9781a493760.camel@linux.ibm.com>
In-Reply-To: <5703152fed864a39eb54cfccb571e9781a493760.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|PAXPR05MB9003:EE_
x-ms-office365-filtering-correlation-id: 960aa332-fa18-4e2a-f005-08dec863b8c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|786006|366016|23010399003|376014|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 a++Uekdp4ESi22OMikUAR7YBSf+ArDguNr9OISPxLhQ2h3W2afsO0CDNbqPkD0cHovqsqlVTqIM0nqrEYveDGxzS3gvCcrIXUkwPA9x1bl1h013dxbYN+ravUIRjvZmV2Xxk7T5EJjGPZh6PwOaM984GoiikHlNuetsu+kb/SFt/iHjusEHIJ7U+Jkt5vk7JlgefP9l0avRQLNdNAVidAz0z+ZCg14CInTw6JdV4mAVHaa8gbsj3tDUJkeaiGyD0oJI8pDVGCNylGT7uPWGkd2rTX9168ei9FZjZJ4S4jQSaUGWI38SbImVR/PNPxz3RnuhIRpeNFuJVjfJDRUuMoPPhdfNukbAXZQSI9BBwY4tkeNnZeXz2HON5aHsEEG4Owi5kqOEGkd/JtEKlYoXrmOlc7z2uvjjPOs8Mh9gu+Ymd8c5EqsfplMWKMOEqUMHk5TEvSD2hmBvfMTT4cP7V07aEy1zsH3SHuBqfNlC75k2KR0TCsWNa2Wbv8g5R9Hq9fxk9iI3tFYkQ7VH+GovJ6Zf6PcRqttN6SLR2rRk0csBkjC1soDbs2syyHScnyfxsVfM6IzBbE8Tlh98stn6Ws9c1PdGFBF1CbdREur3VbXZO7skoM6aCzEBq9X8latADiMIzijvevD6PCNv3u29ig2BZ/4nN6JjcIoWV2jbgagzlWWnPZIqBp0KhqhOtOK+nqUJdl9LP0Fpn44TOq7ICbNGFwq8JlCc6ptUnHHguEqAXMy8F6vU5of2Xo2XA05Og
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(786006)(366016)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUJqQTNkVDZoT2dINVVteGNLOHdPcHV1djNja3VNSktYcld6R2lydlA0RC95?=
 =?utf-8?B?bFJ2NVZvbHRIU0xkOGloYkRScVY4K2dHTmo2ZWhqMFdTLy9xVEc5SmhwR1NE?=
 =?utf-8?B?U2lwYTB4RXhuT0p5ODJvdkI0YkpIbSt0ZmIrejQwU3hKRjc0NGtPMUttV2Fp?=
 =?utf-8?B?RmplV2U0YXlIYTRjTElwbkRhTUJ4M3IzUTZMQ3NxT21iN3JtS0h4Y0Y1T3Fi?=
 =?utf-8?B?UitkVUpCRUZVVWZEQ1BtaGkxbXFjNldZRnkyaEQydnFTV0dwZzVMUGw5bDl3?=
 =?utf-8?B?em5rTENKREd4K1RGdHowU3YzWTlEYVdHbE1sSDhkQnpDcW1qWE9yS2NvWmJI?=
 =?utf-8?B?ZVdYNk40VW1SbXRXSU1tS3NDM3Vka0dtVDBLWTcxc081c3hFNEc0cVlocXVW?=
 =?utf-8?B?bHF4TGVDdHRtazFhL29waTc2ZjR0VEdQSGdRRHJpcEVwam8ya1hXRzJYZ0s0?=
 =?utf-8?B?VVV0L1N4RGo5emEvRm56T2QrTnROYjJ2NXc5ODhIRm5Pci9LWUJtTEdBa05Y?=
 =?utf-8?B?UnlPRmtHUnZyR0pOUWdJaTQrVnZxVEgwdkladjJuY1BOQUJURTUwZi9xNVN0?=
 =?utf-8?B?ckhvdjlmaHJtZ0Z4R1A4eW9OcmRoengxZkI3cm9IbllweUlUL1FRa25PRDR1?=
 =?utf-8?B?VFdzb0pzT1M0T2JjZVY0WWVhK0k1RDNPa3E0d1h1Rys1MWVzL2laLzZxT0xG?=
 =?utf-8?B?MDZvU3VRY1VONklNM0lkSnJxL05ycVhmVmVZUUR6dEM5MVpBSmRhaytRbFN4?=
 =?utf-8?B?VjdEdGlvbEJXWFhzcmtMU3VRTHBrMmJQVFpxU0puZ0tUWjdEUFR1TmRXRGhV?=
 =?utf-8?B?OUxpM1J5aDdGekJRWmcxNGI3UHhNUEpobjJoYTRuRXNOMnlVb2dzVEVOL3ow?=
 =?utf-8?B?ZENqaW0wTGVubWxCcnJlMnhLODJEYXdvRExOTGRtckxacHQ3eUM4SnBLaXlp?=
 =?utf-8?B?Qll3MyszOEtQTHk3dmI1ajloM0h2RWkzMjBCMzZEWkNGQzZCNkYwREE1dUFT?=
 =?utf-8?B?cjNiMXJSaXE2WDZGekNKMDFZYWJ5RU1yenF4TWM3ZjIrYkpvV2c3elRpRGtv?=
 =?utf-8?B?VjNmN1BlbW9jSVJ6Y2pSRmRTdXd6MnBCOE8xM1g1aXoySzNvZ0ZCZmxsYjNv?=
 =?utf-8?B?aUNETHUwZDZMaUNRV3haUkE4QkIxQVBTUUkxOTFNOEw0aVhkOHdFbWRMMTF3?=
 =?utf-8?B?Z28yMU5UVi9zRjlhcGlHdFptQ21SQmJDekpmNTFpS2VyanFQWjZBU2dzQ0xU?=
 =?utf-8?B?d1I5WGd6VDNrK1p5ais5dnkxVTlIaWo5R1F0UzZOTHZtdSs3YW1QdEY0RWdV?=
 =?utf-8?B?NUx6K1FZT0x3aTVtb1NwQzJQK3c5ajkvNTkySk1nbDYrMlBWdlRvRnpNMFdn?=
 =?utf-8?B?RFRkV1VvVkNtZGtPQW91Q0FwdmQxaE91SmZuaW5zV2JjQ1gvWjZQV1htWHdw?=
 =?utf-8?B?MVlDTnVPL0E1d3VNdVNmVWhtd1pmTmpFSGhQa3pEWFdiZytCVHhIMVAzYWh3?=
 =?utf-8?B?b3UxMVlENXJxTXQydE1LMGpZWExXeGZwOW95Rmp0S3BjV2FvUGhvbW5WS1VY?=
 =?utf-8?B?L0p3a0JTNXVXMTJoSHB2SjRZdXNnZDJIVk84UG94cVd5VXRyM0dZMnlBT1Ns?=
 =?utf-8?B?N0RhaGZua2FWK3RFYWsrWW9EQmJZWTQzeDJFbWMwRTlETldyQjUrMWFoWHhy?=
 =?utf-8?B?YUVhOHlIQ2pmK1lzaWw5L2h4alpqa2xTc3FTall4TWtXUmllZksvbnltZ1c0?=
 =?utf-8?B?cXE1bFRFaFFzWUdVVlcvM25KeE1OcFF0REM4K05pZzRPVGQzakZvVjVOOGhn?=
 =?utf-8?B?dE8xUjRnaEc3NTZFQllFNFJYUlFVdnRCeVNXdVdYUTdZWkN1QTVyQ0JaeXRU?=
 =?utf-8?B?cFdNWmx4WVJRMm5ZNWN1dFR1MW9rbUtZZkhsS0x1L0NuUHlKWGtjeHFnSXlv?=
 =?utf-8?B?M0hJNTZXK1dGaEdFc2kvZFRmYUxTQW54L3hWV2hvakpVeUE4d3daQmZrb1dG?=
 =?utf-8?B?bmNwTmpyd2dHMFlZcXVQMkx0NE9Oakt0SENZazY4elNrR2xtZDJNTld2Ym1p?=
 =?utf-8?B?VEFoQ2FnVFlzZUIycG9ienZjMnZ4azhQRlJxZDJ6cnVSakhONkU3UDA3YmlK?=
 =?utf-8?B?b2ltUzN1UTQ4QWJVd1ZZczZ0UGhHUXNsQVlFZjFwZ1NPaG05a0thSDRDbHln?=
 =?utf-8?B?VEsxQTB1UTRjWXFid055Y21TckFtMnFoSWVZQUl0UDRlNGVlSUhmT2toOTZi?=
 =?utf-8?B?Zlp0MWZzSm1TUkxjNnB4ZEF4ckFncUs0YkdzeHNTcDdkM1F6NnN6aTdLY2l1?=
 =?utf-8?B?VEVXMmkxRHJ0TnNjbUc3TFhjeUNra3lKUUJzOFBhVm5QT3hwZ3hlYVNtakpi?=
 =?utf-8?Q?3lCF4w0lDXSqnUM0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0973B08EA02144580746C2F11EB3BE9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960aa332-fa18-4e2a-f005-08dec863b8c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 09:19:36.0377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YinNgE1rDtq1p5XtQyMu3LVFhlZ0U1P+hN3AJvyWah/mqCvszXnDKI8p1ZEV74Q3f6/+hqkANdIAm7O6vWkMbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB9003
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FROM_NAME_EXCESS_SPACE(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9792-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,linux.ibm.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[polito.it:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18E9D678334

SGkgTWltaSwNCg0KT24gVGh1LCAyMDI2LTA2LTExIGF0IDEwOjMwIC0wNDAwLCBNaW1pIFpvaGFy
IHdyb3RlOg0KPiBPbiBUaHUsIDIwMjYtMDYtMTEgYXQgMTI6NTEgKzAwMDAsIEVucmljb8KgIEJy
YXZpIHdyb3RlOg0KPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5
L2ltYS9pbWFfZWZpLmMNCj4gPiA+ID4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9lZmku
Yw0KPiA+ID4gPiBpbmRleCAxMzgwMjliZmNjZTEuLjhlOWY4NWVjOWE4NiAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZWZpLmMNCj4gPiA+ID4gKysrIGIv
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZWZpLmMNCj4gPiA+ID4gQEAgLTYwLDYgKzYwLDgg
QEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBzYl9hcmNoX3J1bGVzW10gPSB7DQo+ID4gPiA+
IMKgI2VuZGlmDQo+ID4gPiA+IMKgI2lmIElTX0VOQUJMRUQoQ09ORklHX0lOVEVHUklUWV9NQUNI
SU5FX0tFWVJJTkcpICYmDQo+ID4gPiA+IElTX0VOQUJMRUQoQ09ORklHX0lNQV9LRVlSSU5HU19Q
RVJNSVRfU0lHTkVEX0JZX0JVSUxUSU5fT1JfU0VDT05EQVJZKQ0KPiA+ID4gPiDCoAkiYXBwcmFp
c2UgZnVuYz1QT0xJQ1lfQ0hFQ0sgYXBwcmFpc2VfdHlwZT1pbWFzaWciLA0KPiA+ID4gPiArI2Vs
c2UNCj4gPiA+ID4gKwkibWVhc3VyZSBmdW5jPUNSSVRJQ0FMX0RBVEEgbGFiZWw9aW1hX3BvbGlj
eSIsDQo+ID4gPiA+IMKgI2VuZGlmDQo+ID4gPiANCj4gPiA+IMKgTm9uZSBvZiB0aGUgb3RoZXIg
YXJjaCAibWVhc3VyZSIgcG9saWN5IHJ1bGVzIGFyZSBjb25kaXRpb25hbC7CoCBTaG91bGQNCj4g
PiA+IHRoZQ0KPiA+ID4gbmV3DQo+ID4gPiAibWVhc3VyZSIgcnVsZSBiZSBsaW1pdGVkPw0KPiA+
IA0KPiA+IFRoaXMgY29uZGl0aW9uIGFpbXMgdG8gYXZvaWQgbWVhc3VyaW5nIHRoZSBwb2xpY3kg
bG9hZGVkIGV2ZW4gaWYgYSBzaWduZWQNCj4gPiBwb2xpY3kNCj4gPiBpcyByZXF1aXJlZC4gSW4g
dGhhdCBjYXNlLCBpdCB3b3VsZCBub3QgYmUgcG9zc2libGUgdG8gZGlyZWN0bHkgd3JpdGUgdGhl
DQo+ID4gcG9saWN5DQo+ID4gaW4gdGhlIHNlY3VyaXR5ZnMgZmlsZS4NCj4gDQo+IEdvb2QgcG9p
bnQuIFNpbmNlIGl0IGlzIGRpZmZlcmVudCB0aGFuIHRoZSBvdGhlciBydWxlcywgY291bGQgeW91
IGFkZCBhDQo+IGNvbW1lbnQNCj4gaGVyZSBvciBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQoN
ClN1cmUsIHdpbGwgZG8uDQoNCj4gPiANCj4gPiA+ID4gwqAJIm1lYXN1cmUgZnVuYz1NT0RVTEVf
Q0hFQ0siLA0KPiA+ID4gPiDCoAlOVUxMDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9p
bnRlZ3JpdHkvaW1hL2ltYV9mcy5jDQo+ID4gPiA+IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9p
bWFfZnMuYw0KPiA+ID4gPiBpbmRleCAwMTJhNTg5NTlmZjAuLjc1Y2IzMDhjZjAxZiAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZnMuYw0KPiA+ID4gPiAr
KysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5jDQo+ID4gPiA+IA0KPiA+ID4gPiBA
QCAtMjM4MSwzICsyMzgwLDU1IEBAIGJvb2wgaW1hX2FwcHJhaXNlX3NpZ25hdHVyZShlbnVtDQo+
ID4gPiA+IGtlcm5lbF9yZWFkX2ZpbGVfaWQNCj4gPiA+ID4gaWQpDQo+ID4gPiA+IMKgCXJldHVy
biBmb3VuZDsNCj4gPiA+ID4gwqB9DQo+ID4gPiA+IMKgI2VuZGlmIC8qIENPTkZJR19JTUFfQVBQ
UkFJU0UgJiYgQ09ORklHX0lOVEVHUklUWV9UUlVTVEVEX0tFWVJJTkcgKi8NCj4gPiA+ID4gKw0K
PiA+ID4gDQo+ID4gPiBQbGVhc2UgYWRkIGtlcm5lbC1kb2MgaGVyZSwgc29tZXRoaW5nIGxpa2U6
DQo+ID4gPiANCj4gPiA+IC8qKg0KPiA+ID4gwqAqIGltYV9tZWFzdXJlX2xvYWRlZF9wb2xpY3kg
LSBtZWFzdXJlIHRoZSBhY3RpdmUgSU1BIHBvbGljeSBydWxlc2V0DQo+ID4gPiDCoCoNCj4gPiA+
IMKgKiBNdXN0IGJlIGNhbGxlZCB3aXRoIGltYV93cml0ZV9tdXRleCBoZWxkLCBhcyBpdCBwZXJm
b3JtcyB0d28NCj4gPiA+IMKgKiBzZXBhcmF0ZSBSQ1UgcmVhZCBwYXNzZXMgb3ZlciBpbWFfcnVs
ZXMgYW5kIHJlbGllcyBvbiB0aGUgbXV0ZXgNCj4gPiA+IMKgKiB0byBwcmV2ZW50IGNvbmN1cnJl
bnQgcG9saWN5IHVwZGF0ZXMgYmV0d2VlbiB0aGVtLg0KPiA+ID4gwqAqLw0KPiA+IA0KPiA+IFN1
cmUsIHRoYW5rIHlvdS4gSWYgaXQgaXMgb2sgZm9yIHlvdSBJIGNhbiBkaXJlY3RseSBhZGQgd2hh
dCB5b3Ugc3VnZ2VzdGVkLg0KPiANCj4gVGhpcyB3YXMgc3VnZ2VzdGVkIGJ5IENsYXVkZSwgc28g
aXQgc2hvdWxkIGJlIGFjY2VwdGFibGUgdG8gdXNlLg0KPiANCj4gPiANCj4gPiA+ID4gK3ZvaWQg
aW1hX21lYXN1cmVfbG9hZGVkX3BvbGljeSh2b2lkKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCWNv
bnN0IGNoYXIgKmV2ZW50X25hbWUgPSAiaW1hX3BvbGljeV9sb2FkZWQiOw0KPiA+ID4gPiArCWNv
bnN0IGNoYXIgKm9wID0gIm1lYXN1cmVfbG9hZGVkX2ltYV9wb2xpY3kiOw0KPiA+ID4gPiArCWNv
bnN0IGNoYXIgKmF1ZGl0X2NhdXNlID0gIkVOT01FTSI7DQo+ID4gPiA+ICsJc3RydWN0IGltYV9y
dWxlX2VudHJ5ICpydWxlX2VudHJ5Ow0KPiA+ID4gPiArCXN0cnVjdCBsaXN0X2hlYWQgKmltYV9y
dWxlc190bXA7DQo+ID4gPiA+ICsJc3RydWN0IHNlcV9maWxlIGZpbGU7DQo+ID4gPiA+ICsJaW50
IHJlc3VsdCA9IC1FTk9NRU07DQo+ID4gPiA+ICsJc2l6ZV90IGZpbGVfbGVuOw0KPiA+ID4gPiAr
CWNoYXIgcnVsZVsyNTVdOw0KPiA+ID4gDQo+ID4gPiBUaGUgMjU1LWJ5dGUgYnVmZmVyIG1heSBi
ZSBpbnN1ZmZpY2llbnQgZm9yIGN1c3RvbSBwb2xpY3kgcnVsZXMgdGhhdA0KPiA+ID4gaW5jbHVk
ZQ0KPiA+ID4gYWRkaXRpb25hbCBmaWVsZHMgc3VjaCBhcyBMU00gbGFiZWxzIGFuZCBvdGhlciBm
aWxlIG1ldGFkYXRhLCB1bmxpa2UgdGhlDQo+ID4gPiBzaW1wbGVyDQo+ID4gPiBidWlsdC1pbiBh
bmQgYXJjaGl0ZWN0dXJlLXNwZWNpZmljIHJ1bGVzLiBQbGVhc2UgaW5jcmVhc2UgdGhlIGJ1ZmZl
ciBzaXplDQo+ID4gPiB0bw0KPiA+ID4gYWNjb21tb2RhdGUgdGhlIHdvcnN0LWNhc2Ugc2VyaWFs
aXplZCBydWxlIGxlbmd0aC4NCj4gPiANCj4gPiBZZXMsIEkgd3JvbmdseSB0b29rIGFzIHJlZmVy
ZW5jZSB0aGUgYXJjaCBwb2xpY3kgcnVsZXMgY2FzZS4gSSBkb24ndCBrbm93IGlmDQo+ID4gdGhl
DQo+ID4gd29yc3QtY2FzZSBjYW4gYmUgcHJlY2lzZWx5IGVzdGltYXRlZC4gSSBjb3VsZCBpbmNy
ZWFzZSB0aGUgYnVmZmVyIHNpemUgYW5kDQo+ID4gY2hlY2sgaW4gYW55IGNhc2UgaWYgc2VxX2hh
c19vdmVyZmxvd2VkKCkuIENvdWxkIGl0IGJlIGFuIGlkZWE/DQo+IA0KPiBTb3VuZHMgZ29vZC4N
Cg0KUGVyZmVjdCwgdGhhbmsgeW91Lg0KDQpFbnJpY28NCg0KPiA+IA0KPiA+ID4gPiArDQo+ID4g
PiA+ICsJLyogY2FsY3VsYXRlIElNQSBwb2xpY3kgcnVsZXMgbWVtb3J5IHNpemUgKi8NCj4gPiA+
ID4gKwlmaWxlLmJ1ZiA9IHJ1bGU7DQo+ID4gPiA+ICsJZmlsZS5yZWFkX3BvcyA9IDA7DQo+ID4g
PiA+ICsJZmlsZS5zaXplID0gMjU1Ow0KPiA+ID4gPiArCWZpbGUuY291bnQgPSAwOw0KPiA+ID4g
PiArDQo+ID4gPiANCj4gPiA+IFBsZWFzZSBhZGQgImxvY2tkZXBfYXNzZXJ0X2hlbGQoJmltYV93
cml0ZV9tdXRleCk7IsKgIGhlcmUuDQo+ID4gDQo+ID4gWWVzLCBhbmQgdGhpcyB3b3VsZCBhY3R1
YWxseSBmYWlsIGJlY2F1c2UgSSdtIG5vdCBhY3F1aXJpbmcgaW1hX3dyaXRlX211dGV4DQo+ID4g
aW4NCj4gPiBpbWFfcmVsZWFzZV9wb2xpY3koKS4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IE1pbWkN
Cg==


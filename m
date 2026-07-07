Return-Path: <linux-integrity+bounces-9890-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ax7TK6PkTGqgrgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9890-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 13:36:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660F71AFE6
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 13:36:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=DFWrWpXG;
	dmarc=pass (policy=quarantine) header.from=polito.it;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9890-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9890-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F72D30DF8E6
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329E3FE374;
	Tue,  7 Jul 2026 11:26:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021077.outbound.protection.outlook.com [40.107.130.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB93F823D
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 11:25:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423564; cv=fail; b=c3oyN6FHVYDnyQiG2m2Nou7QdulCPeN7x1Lb7yRacByF6w9RRp35l34jZVI/YJjKa6anZG6mgL4OHfwS+BHKaNHwJifvbnlAB0I5T02trFemIdhd3pE5KnlJMUG7gpLeFqAfxF9r/hHDa9jNP+BpTK+Ti8Ran/Qz4/8x2JRUCsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423564; c=relaxed/simple;
	bh=0LwhUbyHMO8TRpupLIZfQFIjksOpBmbdfJRsnZZNazo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLYTKiUgVQt4ZdquCqs7ddM6XvCyqnYbWRrcjv4UY/NVT+4+f0Gj+6aYEOgrcKaeD01bJqsKbJeoqMg0XrgNFrKSk2vCfJd4XMR61r8tTGCewEI7ar5pMicInnckGxpuJnIWuChYkv0Pn6WygPw1efGm+wSixDKHJh0YK9mQh1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=DFWrWpXG; arc=fail smtp.client-ip=40.107.130.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS6dS4q8d41OUwCQxxy+5/oK8MxEitQvPgMpbDb5s23TkTQd15/3xG2lRJZ41+lx+zzafycwC/X7587NTrH6qPfNcQgljk2PvHZX3dN5kPSjMRPbnQpB2ZY5GBU5RXdAQbgbjVlG56xeSRw5LbyfUe3ZxY7oQ6yPXks+BsqZk7aDurNVNFfuw1FtbEQdjYm4ZmD0j4gyMWpNm0JeJwFP/OCTSONP34Ttjxal0Ectfnj01gmJ6QiP3hUTxZfjJTOW39rH7AC/tBVqILqW8dndkqH1svonLcDvl/KBjmj81a0ZZG697SMqVKWGvX9pflADkCr8vqbytG508qa7RzguWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LwhUbyHMO8TRpupLIZfQFIjksOpBmbdfJRsnZZNazo=;
 b=MF3dY/HJW+HqMB6wUiIzoGOKHYnaxya3Tbb4izG1cMm0aqGelaps7oWUO0hib2FUVs6XDcq4YPPor1kFNLVM47X9xUKLVHZSbApV+8ZHnai0Q2gHLQvjM5hTKlYVD5qzCa0lMioVZt153CCLIsIgXyx/MZL4zT4ep+APumZ2mnNiGDvDeNj+YBclL20yhm/x6AxdUihoapH6g/xZ/ABDmlXwYQe8sB/LV/911zVZUGNacKC8MhdZAF5SwyMyLIZZd8mujq0LrfF80ItntRov3dmpuhttGF+/zJ2/SYvLovQjlQrT2I/KxMERM0yJhCnW27aRd3WGnR1mHuAB3xLJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LwhUbyHMO8TRpupLIZfQFIjksOpBmbdfJRsnZZNazo=;
 b=DFWrWpXGlOUnKNiXGy2fyiUk2ffIcaVm7u8chSbO0MRKy93HGbddxBaq92EUq3FRWKdS6+sGqPixFnzeZjpAlm62pKNKV7fHstHs/EdpiXLFoviNDYEPDQXYbev7gcHQfbpWawtm4rpOjCX5S7Dj2oR/N1akoa77f73R3E+X8s0=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by PAWPR05MB10305.eurprd05.prod.outlook.com (2603:10a6:102:2e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 11:25:52 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 11:25:51 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH v5 1/2] ima: add critical data measurement for loaded
 policy
Thread-Topic: [PATCH v5 1/2] ima: add critical data measurement for loaded
 policy
Thread-Index: AQHdClXWxGJTFhV87kSkb0fDXWNzj7ZhZeYAgACMKYA=
Date: Tue, 7 Jul 2026 11:25:51 +0000
Message-ID: <fd5791c9dce073698f21dd3cac15450c41e19e32.camel@polito.it>
References: <20260702190403.5844-1-enrico.bravi@polito.it>
		 <20260702190403.5844-2-enrico.bravi@polito.it>
	 <23b77eb601a40063738e0d9c4253fff51e304a11.camel@linux.ibm.com>
In-Reply-To: <23b77eb601a40063738e0d9c4253fff51e304a11.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|PAWPR05MB10305:EE_
x-ms-office365-filtering-correlation-id: 4e0f794e-a5d7-43c5-bbfc-08dedc1a8099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|786006|23010399003|366016|38070700021|4143699003|56012099006|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 w4q70stc5bbi8nsd5U2GyRVnEl+TGSGyQMN+iMfBVy6pzOJNwlm1LNqsZeIMwoAY0DlH15OcWSr7DmLerIPCtO8j5CQnsUlKGIAK8Aab3YccdoSny01KQV6ckvjpARBUmajWlQEF+r7p57cZdxMHjweOJAGlJSZFHeFs/lzEXXTNyontZUmWLPY8YYswcVncJBmvNuSdZwNcLnf81u3luAJhsIA0WcxosxbLX7dkCJYW2eXwEjGRt01MwjxAxCUvGyzwLzBspt5T89dMNgqMog9DIahRWifZhUS9nhqpC4gUFTXadjr6VIj+tOg6rVxO1Fnaa1+0h5qNuLKRKoxLAsHLsTTh5sOjWMiEssc30sZqUTgw5gQPEB+zOrbxT9UuZwb3nxvzCe+iKTY+P3D0SGhPkXAUr9Kv4z06+CoOaKSo6ofbPqiKVDq+Yk8fouF6iHfSPjSZlj9e3LUctxFIHxoWs3I9+pSPcobWDxiVtCYJaT0WLzdx9ttwQggjW+nZbXjuuQNCD9T+MKA7v6J8Fv//4PtZRu+l7L5U9caCYztrG5Z5v3UXxonXKvNmqn6Xb/cT/m94SEwxBGFxbXNRN8o5FtfZGq0IW1Rc0MMmSN3iYE/ADvsHVVakzX0B/iOfhS1RZnupFximnhvcfZbvdG6djudraOGqk5Wal7IPfGNBTKk+Cue8gVmmkI/4Ia/WfrQSOMVhwXeVoYzDcAfFOlTQ8WZvS3ZTJxt9JYIvgKU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(786006)(23010399003)(366016)(38070700021)(4143699003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejBQei9LQmhLZWdBTmY2NCszVGNZcnlTb1lBN3Qxa05PVWo1Z2tOOVd3Znpr?=
 =?utf-8?B?QTlnU0FDVFZJaXdIVkdsM1ZvL3Y4VDBSZm5WUUZnb1NrcUZEaDhNakZNV1Bo?=
 =?utf-8?B?L01nVUxTZ09yWlJ2ZTlNRHUybGJYeG5oWjN2WWZBRVcvanZwenNOM0l4elN3?=
 =?utf-8?B?MHZMRWpFbVdNcEg5MUE1a25wQWp0c29JbTRrbFVnQmFFWno3NUNHRHlpaWM5?=
 =?utf-8?B?cW1JS3NMSVJVRVVETTd6YVIwR0p3Y0IvWXZ2VVNrNmFXYlROWjBabXRsaWov?=
 =?utf-8?B?SDRpaDdmRk5vNHFHa1hqbHd3cEFiczFMb1ZKcGQrNDZqSXlkcENSOCtiR055?=
 =?utf-8?B?K1QvM2h3ckpvRWh0T0dTMzM1RGZIa004SFZUZitkSTl4SDlPV0ZmUXZpYm9G?=
 =?utf-8?B?QkJ4cUg3M1dqSnkwRERpTFdDY3pENm9KaTNKaEtaR1lrb1JLeGovdldjdmlu?=
 =?utf-8?B?VkNYUnFWdFRYOW12RnJjMWRLeUNXNlN4RXdWbkY2d3J0TUl5bXB2ajVjaE9v?=
 =?utf-8?B?R045dVhzZUZSSWZVTFFyemN6elBSVlBTYUpnVkZDaE9xWGxTZXpQdzliUC9w?=
 =?utf-8?B?SVRtTkdaZzJnNktZaTJFRW5SanZTMU9SNUZJQUhvK2pqc2RiQkRPUllob2hP?=
 =?utf-8?B?MjBNdHNqT0tlUjhhNmI1SnlzMTljQkgrZkdtYWRKYk40L1F3QXJZUGI3dVlt?=
 =?utf-8?B?QmpPd0xWUzV6RU1uTVBwNG9pNTZ1LzVpVjFOd2RLczQvS3ZuRjhST05vN0hR?=
 =?utf-8?B?YUs4dzRQdG12Q1dTVFZoTFkyR2J0UXlSQ053WXorMkt3eER6NXc4UHF3M2M4?=
 =?utf-8?B?NlhoV2s4dVFZdG9BTWkyK3dxTlYxb1E2TVV5alhTNE5hZEpsc1JRUzJDVldp?=
 =?utf-8?B?UGpyZ0RjLzRKQVp5dkhqMEtzVVNFMFVOV0FZODlabmhHcWd5TjcvREFqSys3?=
 =?utf-8?B?eHRqT2xNalBhSXVtbzlUdUFXNU50N3hPeERhY2ZmcHR6NG54MVRVNGlZZmJD?=
 =?utf-8?B?L20rZmxhQVVmSzBlUk9CM1M0bE1iTHBrbC9XUjc4T3kyclhjTE5lVWs4Mi9D?=
 =?utf-8?B?M0pZRlJJUlN3b1FkVEFBN3AvVGZrOHU4bzYxcGZISmFwN3htUWtieHVaSSs2?=
 =?utf-8?B?aGw4ZlJJRytFdmRjeXVkSE91KzM2OTc3S05kKzUwR05LeGRKSElOQlpiM0Rs?=
 =?utf-8?B?UUtKcG1VQ0JSK2NLNTFFblRHV0lBV1BSVEc4cUNMblBHTk5MODVpNXhRbkhO?=
 =?utf-8?B?c0dvS0wrMDhZRGFJc1lzZ1dHRFh6ajFOa0lkQnJsb25BY0ZLVUV0alJYcjEw?=
 =?utf-8?B?Z1pvam9SS0d2OGVIaWhiVWNLVkphbFFmODl4dG12cHJWdktqd1VIUENBUmNt?=
 =?utf-8?B?M2JKWExNZWNCVnM2RVpNc3Q4cEhMa2pRNkc3S0lqUlBPdEU2dUt1TmtJWkx2?=
 =?utf-8?B?MEkyWjBIcWJ1Slp0UjkyS0l0d0N2ZnVTNUN6Y1VzK2FzNW5XVTlRclhFa3Rz?=
 =?utf-8?B?d1FFWUR0YjdjdytoM3dQbzM0SERNa1NvNVZRZldqZmVmejhYejg1UkdhcWZ3?=
 =?utf-8?B?TktnMUFvdzRoR3dENWw3T240dmdhR2tEUXlOYmFEWXEyV1lwSktGREZkVWl3?=
 =?utf-8?B?Y21NcXQ3MUxjdTJvdlMzOHNlRksxQUU0U3EweithNklZdTBsdlBSWUl3VXFI?=
 =?utf-8?B?RHJZWFVoQ2tjU3RTUlluNE1tYk1VN3hRcDlva09yS0dIRkpydnRVRXJnUVZW?=
 =?utf-8?B?Z1Mzam5WOVpyUDVnQmd5ZUFlWmdIWEtXcm16SzRBRURCVXlhczZMVk50cWNO?=
 =?utf-8?B?eTdQTEliK2dvcElXMWtRWTFiakgzMjNkK0tWLzd4TXZwR1FLeFR4KzM3UzJJ?=
 =?utf-8?B?OXNYbUd5TUhrbCtqeWFQbXAvWXc4MTdaME9zWnpxWWwyZjVaaWF3alk1dldT?=
 =?utf-8?B?SEsvV3Z5azdVbzRjZkdDZXhXLzhRRU83cjJwV0tpZWhPd0lGalZSWjBtQ2V0?=
 =?utf-8?B?MWhiVkU0RmlaOFJzdGxEM2R0dHV6bzY5Z25KdkNYYXpvZmhpcTIzSXZMaC9s?=
 =?utf-8?B?WWIzYlRUeEE3VU5NbHRJZzFpVFJoNG0wMm81N3F4R1R6U2gzaEpLaUhoRW4r?=
 =?utf-8?B?dnQ4MVBPU3RUTHF5OFZDTlJIdW01ZUljczAxR3VnY1pJdEc2UnlVOUZPT2Jo?=
 =?utf-8?B?Q1laL3VReHN6YXp4czU4d2wwV2R1bHZHbFJaMWNkS0QvNy9LalAwWXB4empU?=
 =?utf-8?B?ekRKd252R3lkcDgvKzRHcy91RmlWa1d3cHBtTWViOHJ2NS9aVG1sTzJJWmw4?=
 =?utf-8?B?NHRSV0g1dys1RFVjMmJ0MGFia2lCZTJZRFdSdlA5c0N2MEZ3RWpwZDV4eGUr?=
 =?utf-8?Q?e9S4M18xOdvko69Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1C02827A80DA44A8BA30BFA1AE406E3@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0f794e-a5d7-43c5-bbfc-08dedc1a8099
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 11:25:51.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhqHzd6MAOLvrnSrkohla6KZvhLxPZuhDB8dSuAONgQIV25vlLE3WOhXAf4zEX6zRJ27OweSteC35CHV++22rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10305
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FROM_NAME_EXCESS_SPACE(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9890-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0660F71AFE6

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDIzOjA0IC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjYtMDctMDIgYXQgMjE6MDQgKzAyMDAsIEVucmljbyBCcmF2aSB3cm90ZToNCj4g
PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMNCj4gPiBi
L3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5jDQo+ID4gaW5kZXggZjdmOTQwYTc2
OTIyLi5hNjViN2U0YjY0ZDYgMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2lt
YS9pbWFfcG9saWN5LmMNCj4gPiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xp
Y3kuYw0KPiA+IEBAIC0yMzc5LDMgKzIzODUsODIgQEAgYm9vbCBpbWFfYXBwcmFpc2Vfc2lnbmF0
dXJlKGVudW0ga2VybmVsX3JlYWRfZmlsZV9pZA0KPiA+IGlkKQ0KPiA+IMKgCXJldHVybiBmb3Vu
ZDsNCj4gPiDCoH0NCj4gPiDCoCNlbmRpZiAvKiBDT05GSUdfSU1BX0FQUFJBSVNFICYmIENPTkZJ
R19JTlRFR1JJVFlfVFJVU1RFRF9LRVlSSU5HICovDQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICog
aW1hX21lYXN1cmVfbG9hZGVkX3BvbGljeSAtIG1lYXN1cmUgdGhlIGFjdGl2ZSBJTUEgcG9saWN5
IHJ1bGVzZXQNCj4gPiArICoNCj4gPiArICogTXVzdCBiZSBjYWxsZWQgd2l0aCBpbWFfd3JpdGVf
bXV0ZXggaGVsZCwgYXMgaXQgcGVyZm9ybXMgdHdvDQo+ID4gKyAqIHNlcGFyYXRlIFJDVSByZWFk
IHBhc3NlcyBvdmVyIGltYV9ydWxlcyBhbmQgcmVsaWVzIG9uIHRoZSBtdXRleA0KPiA+ICsgKiB0
byBwcmV2ZW50IGNvbmN1cnJlbnQgcG9saWN5IHVwZGF0ZXMgYmV0d2VlbiB0aGVtLg0KPiA+ICsg
Ki8NCj4gPiArdm9pZCBpbWFfbWVhc3VyZV9sb2FkZWRfcG9saWN5KHZvaWQpDQo+ID4gK3sNCj4g
PiArCWNvbnN0IGNoYXIgKmV2ZW50X25hbWUgPSAiaW1hX3BvbGljeV9sb2FkZWQiOw0KPiA+ICsJ
Y29uc3QgY2hhciAqb3AgPSAibWVhc3VyZV9sb2FkZWRfaW1hX3BvbGljeSI7DQo+ID4gKwlzaXpl
X3QgcnVsZV9sZW4gPSBtYXhfcnVsZV9sZW4gKyAyOw0KPiA+ICsJc3RydWN0IGltYV9ydWxlX2Vu
dHJ5ICpydWxlX2VudHJ5Ow0KPiA+ICsJc3RydWN0IGxpc3RfaGVhZCAqaW1hX3J1bGVzX3RtcDsN
Cj4gPiArCXN0cnVjdCBzZXFfZmlsZSBmaWxlOw0KPiANCj4gSGkgRW5yaWNvLA0KPiANCj4gRllJ
LCB0aGVyZSdzIGEgbWVyZ2UgY29uZmxpY3Qgd2l0aCBjb21taXQgNTFiZWRjZDgwM2UwICgiaW1h
OiBNZWRpYXRlDQo+IG9wZW4vcmVsZWFzZSBtZXRob2Qgb2YgdGhlIG1lYXN1cmVtZW50cyBsaXN0
Ii4NCg0KSGkgTWltaSwNCg0KeWVzLCBJIHdhcyBzdGlsbCBiYXNpbmcgaXQgb24gY29tbWl0IDhj
ZDk1MjBkMzVhNiAoIkxpbnV4IDcuMSIpLiBJJ2xsIHJlYmFzZSBpdA0KYW5kIGZpeCB3aGF0IHlv
dSBzdWdnZXN0ZWQuDQoNCj4gQXMgbG9uZyBhcyAyLzIgbmVlZHMgdG8gYmUgdXBkYXRlLCB0aGVy
ZSBhcmUgdHdvIG5pdHM6IGluaXRpYWxpemUgc2VxX2ZpbGUNCj4gbGlrZQ0KPiAiZmlsZSA9IHsg
MCB9OyIuDQo+IA0KPiA+ICsJaW50IHJlc3VsdCA9IC1FTk9NRU07DQo+ID4gKwlzaXplX3QgZmls
ZV9sZW4gPSAwOw0KPiA+ICsJY2hhciAqcnVsZTsNCj4gPiArDQo+ID4gKwlsb2NrZGVwX2Fzc2Vy
dF9oZWxkKCZpbWFfd3JpdGVfbXV0ZXgpOw0KPiA+ICsNCj4gPiArCXJ1bGUgPSB2bWFsbG9jKHJ1
bGVfbGVuKTsNCj4gPiArCWlmICghcnVsZSkgew0KPiA+ICsJCWludGVncml0eV9hdWRpdF9tc2co
QVVESVRfSU5URUdSSVRZX1BDUiwgTlVMTCwgZXZlbnRfbmFtZSwNCj4gPiArCQkJCcKgwqDCoCBv
cCwgIkVOT01FTSIsIHJlc3VsdCwgMCk7DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCS8qIGNhbGN1bGF0ZSBJTUEgcG9saWN5IHJ1bGVzIG1lbW9yeSBzaXplICovDQo+ID4g
KwlmaWxlLmJ1ZiA9IHJ1bGU7DQo+ID4gKwlmaWxlLnJlYWRfcG9zID0gMDsNCj4gPiArCWZpbGUu
c2l6ZSA9IHJ1bGVfbGVuOw0KPiA+ICsJZmlsZS5jb3VudCA9IDA7DQo+ID4gKw0KPiA+ICsJcmN1
X3JlYWRfbG9jaygpOw0KPiA+ICsJaW1hX3J1bGVzX3RtcCA9IHJjdV9kZXJlZmVyZW5jZShpbWFf
cnVsZXMpOw0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UocnVsZV9lbnRyeSwgaW1hX3J1
bGVzX3RtcCwgbGlzdCkgew0KPiA+ICsJCWltYV9wb2xpY3lfc2hvdygmZmlsZSwgcnVsZV9lbnRy
eSk7DQo+ID4gKw0KPiA+ICsJCWlmIChzZXFfaGFzX292ZXJmbG93ZWQoJmZpbGUpKSB7DQo+ID4g
KwkJCXJlc3VsdCA9IC1FMkJJRzsNCj4gPiArCQkJaW50ZWdyaXR5X2F1ZGl0X21zZyhBVURJVF9J
TlRFR1JJVFlfUENSLCBOVUxMLA0KPiA+IGV2ZW50X25hbWUsDQo+ID4gKwkJCQkJwqDCoMKgIG9w
LCAicnVsZV9sZW5ndGgiLCByZXN1bHQsIDApOw0KPiANCj4gYW5kIGxpbWl0IHRoZSBpbnRlZ3Jp
dHlfYXVkaXRfbXNnIHRvIDgwIGNoYXJzLg0KPiANCj4gT3RoZXJ3aXNlIHRoZSBwYXRjaCBsb29r
cyBnb29kLg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoLg0KDQpFbnJpY28NCg0KPiBNaW1pDQo+IA0K
PiA+ICsJCQlyY3VfcmVhZF91bmxvY2soKTsNCj4gPiArCQkJZ290byBmcmVlX3J1bGU7DQo+ID4g
KwkJfQ0KPiA+ICsNCj4gPiArCQlmaWxlX2xlbiArPSBmaWxlLmNvdW50Ow0KPiA+ICsJCWZpbGUu
Y291bnQgPSAwOw0KPiA+ICsJfQ0KPiA+ICsJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gKw0KPiA+
ICsJLyogY29weSBJTUEgcG9saWN5IHJ1bGVzIHRvIGEgYnVmZmVyIGZvciBtZWFzdXJpbmcgKi8N
Cj4gPiArCWZpbGUuYnVmID0gdm1hbGxvYyhmaWxlX2xlbik7DQo+ID4gKwlpZiAoIWZpbGUuYnVm
KSB7DQo+ID4gKwkJaW50ZWdyaXR5X2F1ZGl0X21zZyhBVURJVF9JTlRFR1JJVFlfUENSLCBOVUxM
LCBldmVudF9uYW1lLA0KPiA+ICsJCQkJwqDCoMKgIG9wLCAiRU5PTUVNIiwgcmVzdWx0LCAwKTsN
Cj4gPiArCQlnb3RvIGZyZWVfcnVsZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlmaWxlLnJlYWRf
cG9zID0gMDsNCj4gPiArCWZpbGUuc2l6ZSA9IGZpbGVfbGVuOw0KPiA+ICsJZmlsZS5jb3VudCA9
IDA7DQo+ID4gKw0KPiA+ICsJcmN1X3JlYWRfbG9jaygpOw0KPiA+ICsJaW1hX3J1bGVzX3RtcCA9
IHJjdV9kZXJlZmVyZW5jZShpbWFfcnVsZXMpOw0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9y
Y3UocnVsZV9lbnRyeSwgaW1hX3J1bGVzX3RtcCwgbGlzdCkgew0KPiA+ICsJCWltYV9wb2xpY3lf
c2hvdygmZmlsZSwgcnVsZV9lbnRyeSk7DQo+ID4gKwl9DQo+ID4gKwlyY3VfcmVhZF91bmxvY2so
KTsNCj4gPiArDQo+ID4gKwlpbWFfbWVhc3VyZV9jcml0aWNhbF9kYXRhKCJpbWFfcG9saWN5Iiwg
ZXZlbnRfbmFtZSwgZmlsZS5idWYsDQo+ID4gKwkJCQnCoCBmaWxlLmNvdW50LCBmYWxzZSwgTlVM
TCwgMCk7DQo+ID4gKw0KPiA+ICsJdmZyZWUoZmlsZS5idWYpOw0KPiA+ICtmcmVlX3J1bGU6DQo+
ID4gKwl2ZnJlZShydWxlKTsNCj4gPiArfQ0K


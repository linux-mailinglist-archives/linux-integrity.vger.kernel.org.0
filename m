Return-Path: <linux-integrity+bounces-4341-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3799EC205
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 03:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E34B188B594
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 02:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83B78F3E;
	Wed, 11 Dec 2024 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="dCNBLqDu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF3F9EC;
	Wed, 11 Dec 2024 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883366; cv=fail; b=s8FLK/Y/aY0Y8J4r8sdlPytv1LcK0qi8KRYbpLNwB1nytCF3ZzKn0foEixKjjIcD21lB/cx3Exd4HNus/qQ+6tx7WEncrlaSG2U22xZAshidpuiM+LDn7iWhnfW2l12hm+hv3ZRRW1OhQT6P6mHld3ztsEyTxIdElVssHlDd+8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883366; c=relaxed/simple;
	bh=Nd3/uoQq36F6NJH11L3qEKZk6UsgKt6EpqIow1SQIiY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=feIN+vQgzEKDZaoacLt2NuTultH3tlxMtMEepBhKCC+sWX2crpC7kmqLgXtqxFbn8WBNBYsQHAuv+FgEk1lFnQ2a2JuAodaokyiDjzjRrX4vThm3AGCdp61P+anWUm74talm4rmA/9furoI0ZQSPNL6012Nx8HFQUXOOSRR7f2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=dCNBLqDu; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAMoXLe020635;
	Wed, 11 Dec 2024 02:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=rL5Gl/J9bNEH9Myap2b1HARwNG0C1Nx
	7tzWG9Ks0oCg=; b=dCNBLqDuZ/z8OejD7CScTvvGGWGumHGVIL6aI+BJGnDQPb8
	54kWhTu2GNt3pK4LzSZ9j0XcukD4p4QMZvtAgltiGsATyji2ozSVCNJnWVzySK5a
	WSqU1Kcm9AvhQiUI3KmXXEOjOn65QC6Phpomu0I+nQ8Hj0a15Eigk4bWWThbHOIv
	ZZgcMs3ple7zy3wAcw5DRmkljh1YEe+m6r2qUIZQzCkR1ykz+X3L5aQiG/G/tPVE
	WV2lOGQ6Xn11u1EDvMmbpQ0pk2U9gXEnA7BmkWnUGZN9V0Fu21X8D2Up8VI8OJST
	agTOwAh1ZUKcDPF43vlg/2+kcOcQX8X7zuA5quQ==
Received: from hk2pr02cu002.outbound.protection.outlook.com (mail-eastasiaazlp17010006.outbound.protection.outlook.com [40.93.128.6])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43ccjh3fk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 02:15:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWQPTjhDWt1KtX+TDT14iDxssfi7gXFGZW13+NUewTW1DcDaOiTpQtIVTlxGieYPwcsipa75Iz1C4mzIYCYOAQy07soDfaDMnxo5yCsFAjezb4KLSrbga6aRT5PgHAv6Jn0TRhV7PacnwFhMXYekthCAXeAcKlP6m3CMiBD2SlbPN/NFNE8MAAYjsavqNyvuOUwJKJMsnfApfdnDUUITjtN3LbeGadF8pNDRtFaVi4fvVPbVKtmHGkK6GugFiPqJxVhqe9qnu57IU2vcmcvM9eYnqGsG2UXpeWisAo5jd4YybtQlgixYc+cAyqV51jE8hWQxaB6x21Li36Z2GDiePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL5Gl/J9bNEH9Myap2b1HARwNG0C1Nx7tzWG9Ks0oCg=;
 b=c4iUMbik46BVo8kMqm8oIXdcwNTrAg0UvtTpJ95yREVer1Hz2xrocUXDEL+cRhO7LtUlNau3Qi8iO7Btd6nRFvvHrYjPnvWQAi5DLLIdezW6V3jqY0yLqpo0QvLp1Ykyht/sTRs80NW+i8UpWJvATf92XPTdk44QKebvfPhBJgbSnj2w+gSAnarzq3LWG/eKfSX0V5t0G01ZfHZ/Vys5EVd66m4etEMMGrkBHZpjuNKcgz48Ddb7jHpI1MtoffvhAZBk+lBDHtypDCDe8TrE2mCnvF27YloyXViFF/lhbl8dn6fdclfg5+6UdMQCV/AAl84yzuzR5vw1bWszuNczPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7788.apcprd04.prod.outlook.com (2603:1096:405:56::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 02:15:26 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8230.008; Wed, 11 Dec 2024
 02:15:25 +0000
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
Thread-Index: AQHbSktW2+Jjp9TjpUCMlyY1lZIvgbLgT5vB
Date: Wed, 11 Dec 2024 02:15:25 +0000
Message-ID:
 <PUZPR04MB6316E053BBAA0B434A32A147813E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <00000000000065deef0604e8fe03@google.com>
 <6757066b.050a0220.a30f1.01a5.GAE@google.com>
In-Reply-To: <6757066b.050a0220.a30f1.01a5.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7788:EE_
x-ms-office365-filtering-correlation-id: ba347799-9506-4011-6cef-08dd1989ace7
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ofdL9ibN0DZGuv3ljRYBqJTjfDqL6OivPpTuE2ZdQS9gYfYGSLq1IdwoeF?=
 =?iso-8859-1?Q?hgI+VU7WgIwlt+faS8LxXq63bZiLRvzcierbaYzDHbZkfEE+zxpFTBM+UT?=
 =?iso-8859-1?Q?kchNnCSrcKGIgz3sFU8VDbZtUSD7zmn9D+UBniM5Mhjo/63QBq+a6O0LuS?=
 =?iso-8859-1?Q?b2vHVnEP8W//EpqdzPSK4WpakaE8nT5MU7grZ6Is9Ohpf5pO9Ech4Weow1?=
 =?iso-8859-1?Q?3Ofvfpi6se6I9njjnw+C97uKfC3d0KYmfxSacgNUkDn3cn0ishguvKBLbb?=
 =?iso-8859-1?Q?1VzbE/ByPuDJ4KEeEkmUTh4XCK9K33KkkpQcjY5l19Fnt1zC/PvP4qYqRu?=
 =?iso-8859-1?Q?EO/Ka9M0yxNSe98MYwYXvfuIychD80slJOBRwbQcWHBhJ9QzSBh2ONEChp?=
 =?iso-8859-1?Q?8v9VTnFmTtTkJU8rSq5lABn5VQ1g25z+o3JPPNAlnon64U8DdMjRDlCltX?=
 =?iso-8859-1?Q?VQ9Cs5DpyyqeWvyeWG/Wv8JUZDB3bKF2Nkfz4LUW0KakLyWzlJRoFBdV/R?=
 =?iso-8859-1?Q?+W4ERyPxZ+fw8i3aJ2ILpK3crev+K8LifUWz6T8o2T9hmByyNe5GJas5/w?=
 =?iso-8859-1?Q?XMEgFuYoUcyph9nQlN3y8v7S5jfkpvrRnmkyuArchfIwN9/8UuZhiDHAMs?=
 =?iso-8859-1?Q?ND/2G+7LwwN2A1XgILJMevUzhFrKLWehER0+OQxxefg6SUWkQ8hLCM06d/?=
 =?iso-8859-1?Q?VPaPl6xNvPLgG/TpSpOUUYa2l3RZD0E1EEV0lZ9GBjM+drWR8EOtf0oJqT?=
 =?iso-8859-1?Q?fJXxGxoyBMBUmawup1LwtEUQrOkWsbypf5OdKDH52kFhTgvnNVzR+khVxu?=
 =?iso-8859-1?Q?XDX2f203tbFxFlP6R+PBLsF1n9GMAa54obA7ep76WkSTotvS8tNn5Mm4vA?=
 =?iso-8859-1?Q?I/PlWRHdBVM4z4CWF1+MmWMfHrjtDZMqbteCKflvdODOsb/P8G/invU/nu?=
 =?iso-8859-1?Q?lQS8MAiNtNLLuygL2nqTySCHCPaG4HjG7GXTPomkoRWf2CaomjVnljfKGY?=
 =?iso-8859-1?Q?fFpHLMO8WSTkRZAZufzMUyx/CTctffMTyn/4BGQqFZSWeD9tF2ArSFiQ5I?=
 =?iso-8859-1?Q?6GaY17IlgzGpvDqjX2OzOK4UhdcezLzm8gJ+ApVBMba2aWj8lnOAgyW9xw?=
 =?iso-8859-1?Q?bFdceeqwBA1ZzyK5OK9hpMCj49UW/0j7soS0caWHy9jqiVEuLAPORIE32M?=
 =?iso-8859-1?Q?fuG4y9+t4bSLNA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Yolu1w1DgRocghtd7kALKLUF+ZnlBwxjWUUrKmA1rHsxmWBDGF5j5fdIaO?=
 =?iso-8859-1?Q?wt2UGTaNmVUTj95B7PTEXOmIcSm9JNHZpUNY1RXL3vIcjlvHsfRY/cCTKO?=
 =?iso-8859-1?Q?A9XePaVc4hmkKNCe5U3R3Sa2juP1yBK/c9Yyk7vTN9S6rI19amsfoEoLyz?=
 =?iso-8859-1?Q?xSiFuAT9NG/je4xqS/kKr+6xGb960deq7WMk4gHb2AV+dLuZ/BkA9b8eXK?=
 =?iso-8859-1?Q?Oxr7u/3K701pw+8fxytK6fCJfcySqg2Z/uiJ6Dy3Av2Xvpi5I7EJVw0w9u?=
 =?iso-8859-1?Q?KqCsgCB8eSmjgM0N+bBAQHOpNT1/qM9J88CYAUHGEkrDoS4DQd8KqHm8Az?=
 =?iso-8859-1?Q?jgvb8LK7hthogRH9iXt83eKf5IGhl+fa82bCYtWl21SqZDBUjCgBjGXFn0?=
 =?iso-8859-1?Q?KVGqyoPOIH1/oBg93h0MMv08JKIsL7QbvsloXaqn/e5LJ8zA/KZlUB9Ub+?=
 =?iso-8859-1?Q?lZbE0w4R/EyB6P023FjpP8gGbLpzykhJaM8YHaPblGxldWZSPx724fcyWT?=
 =?iso-8859-1?Q?ORbyNvitswajs26iC53gaElCSb+hunbYbkPsy9f8XoSlKEfe3//b8V74po?=
 =?iso-8859-1?Q?FBuzQ+UtDJioDqF/LrS4tUWvMUnpmwckKKAnZRTU/Ewee76JfjSPwhb25V?=
 =?iso-8859-1?Q?IUr513RAG2aeqqmVqXuamLWOmL3bFXBa0vnYoAt+hG+bBK1m/xq1tpt2wC?=
 =?iso-8859-1?Q?+y+KtBwCBGe/cp+APT0SuPlshox4fX0Q5mcy08Owi2CPWiGJUva6+vtQ6J?=
 =?iso-8859-1?Q?jb8PjXEsEI8d0pzQ1UOY7GSAqXJi6XwmdVItdaeVG7n7DslujQHMiNTRPH?=
 =?iso-8859-1?Q?lwErUzsL/zFcrdjcZ1MFQEGBfgFi0TAjNBazX9U7Y7R/9cK6l4PoR71j/2?=
 =?iso-8859-1?Q?SqlBDcq7JUsL/W4MBToOpmO4VtbTtKmzKdaZNxDPtSO8dshLxaddKmk5AQ?=
 =?iso-8859-1?Q?AwRttYLUHVe8iCPpgi/1e6a/MCm4/9sO7AnZHQb6OiiuiHdjrowmpfl2Dg?=
 =?iso-8859-1?Q?0x2iCAHAee8YkFJ+i4xtbVcJ63EurE7dP2cJ/DL+ndaOSjeVhkoifjzoPi?=
 =?iso-8859-1?Q?SuVmnSK6sLEp3WmSqAayVWgh3CjYyK3mu0khgR8q2/SqJJxu2fMG6ue7jG?=
 =?iso-8859-1?Q?XsZYFAtq8pPhgoBYxYJDWi3Dp+PXtDgfAZyRP3bMqgWdExdeMGT8XyGD+R?=
 =?iso-8859-1?Q?TzJao1qIBfGptihG/PTmEXMuRnPigt7u9d2cJg4QPabK8hJnHerZAbokpw?=
 =?iso-8859-1?Q?9PrL0u1iIB0n+W8oKbczzfjJ7Mrmop1uY5P11fuYZWf+y3c0budLkYxKxi?=
 =?iso-8859-1?Q?ZgxNQgD4sRGDKGOZNRzILuFyUi0goTy1HEzmkNPXHN5AnYGQteTQt6n8bq?=
 =?iso-8859-1?Q?slgJR3p0A1TsGBS/sAF4HLRFFCi4ksUh6EQrIk2RcnX4+rR0CGTff96nAK?=
 =?iso-8859-1?Q?NAV0WP8hWkkhkX2SmJMvtlO9phU+KTVttxZ85yMMy8RHPBNoKw2Beg+O9S?=
 =?iso-8859-1?Q?ZMypMW+HOgAvZJyxdh/WBNWXXLsF9YWQtWFXKuodwItewjlyIJfxd3IU6p?=
 =?iso-8859-1?Q?uc9PsYBtH/vZbH3qmUDlIFtUQEV5csPHGuSTZ7nzyVHdrDOW8xBE0xXh4x?=
 =?iso-8859-1?Q?BwU7+D93myyVO7WJqKhDSuy52i5vs5u07w8RQh/F/WW3Qzh+wr5n7jsw4o?=
 =?iso-8859-1?Q?TZI9MC+J7Rm7IiHRYTI=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316E053BBAA0B434A32A147813E2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PixzjKiZrCAnAnjHPpBnV9FjwCtRXIBEzh6x1sqCIjtkbbZ6YkBx+0WSNpVCECbKoaBWlx91cG1nraFW6uCRao8GKC3dZpBdWT6h0RuMcVBe05uHtLLZ0c8tu8h25RK8NUXXyIJ+xUdZtMWOgFi81grXefZ5j+czdjRO6FrgMcX27DGeQQIbhELxjT5PExs5YsHfjgsdPZd9gQJo2l035nJHJlG3HRCGqWqgcSEu1V97qKOw/NK8jZIdhMzghJWSH8Kh59fNYsr/9RL7nVFNXnyrqqHw7iyNHdvtx/Fh30tKg3tuiNx7mjCXm65AkD6aO2KpZSenYQR8VVpcjwLgXl9+5qzYDS+Kd+hNV+UYDiGLfhTH9awzNYT/bBVXB9Wb27348JjcT2PGxwqTnaU/+GntUTxAfCszVmHCVe4AP3UaWvDLQuZ//wAiVuW47mj0u1lIFtc2QiVE9sfd1Hty7+6rR+BpZy5cM6l21cYApCuWGQYirRrPCAXb/AC/bTLOSt6bnQprcifyJ7oj9KkUUT+uWvEaIgQqg75/OCwOctityicelWEkeWnRqdA1oCcfYghKR0Mzq7o9AwF1YpsR490/U239Qdzl+VYbtU1CmT8N8i52mNdQ3zCSSOyHK2cW
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba347799-9506-4011-6cef-08dd1989ace7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 02:15:25.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcljSeS/v9BwYl7zwrAUuxKBZmZQoxHLO+lPTZU+1tWSboR9zoxuBxxcqiHkmmG1B+7JJ6ObvY6MM5zUmDjd1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7788
X-Proofpoint-ORIG-GUID: nEHWQISpGNjE2dQL-gImlgjq1bXoG34l
X-Proofpoint-GUID: nEHWQISpGNjE2dQL-gImlgjq1bXoG34l
X-Sony-Outbound-GUID: nEHWQISpGNjE2dQL-gImlgjq1bXoG34l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_15,2024-12-10_01,2024-11-22_01

--_002_PUZPR04MB6316E053BBAA0B434A32A147813E2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB6316E053BBAA0B434A32A147813E2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="0001-exfat-check-cluster-chain-loop-when-freeing-clusters.patch"
Content-Description:
 0001-exfat-check-cluster-chain-loop-when-freeing-clusters.patch
Content-Disposition: attachment;
	filename="0001-exfat-check-cluster-chain-loop-when-freeing-clusters.patch";
	size=2706; creation-date="Wed, 11 Dec 2024 02:14:52 GMT";
	modification-date="Wed, 11 Dec 2024 02:14:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjNDU5MjIzMzY3ZGE2ZGY2NWVhMjU0MDU5NDI0YTg2ZDhkMmJmNGY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFR1ZSwgMTAgRGVjIDIwMjQgMTg6MDI6MDcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBleGZh
dDogY2hlY2sgY2x1c3RlciBjaGFpbiBsb29wIHdoZW4gZnJlZWluZyBjbHVzdGVycwoKSW4gb3Jk
ZXIgdG8gYXZvaWQgb3JwaGFuIGNsdXN0ZXJzLCBjbHVzdGVycyBpbiB0aGUgY2x1c3RlciBjaGFp
bgpuZWVkIHRvIGJlIGZyZWVkIHVudGlsIHRoZSBFT0YgY2x1c3RlciBpcyB0cmF2ZXJzZWQuIEhv
d2V2ZXIsIGlmCmEgY2x1c3RlciBjaGFpbiBpbmNsdWRlcyBhIGxvb3AgaW4gaXRzZWxmLCB0aGUg
RU9GIGNsdXN0ZXIgd2lsbApjYW5ub3QgYmUgdHJhdmVyc2VkLCByZXN1bHRpbmcgaW4gYW4gaW5m
aW5pdGUgbG9vcC4KClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255
LmNvbT4KLS0tCiBmcy9leGZhdC9iYWxsb2MuYyAgIHwgMTMgKysrKysrKysrKysrKwogZnMvZXhm
YXQvZXhmYXRfZnMuaCB8ICAxICsKIGZzL2V4ZmF0L2ZhdGVudC5jICAgfCAgOCArKysrKysrKwog
MyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQv
YmFsbG9jLmMgYi9mcy9leGZhdC9iYWxsb2MuYwppbmRleCBjZTliZTk1YzkxNzIuLjM5OGEwNWQy
YTJkZCAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvYmFsbG9jLmMKKysrIGIvZnMvZXhmYXQvYmFsbG9j
LmMKQEAgLTE3Myw2ICsxNzMsMTkgQEAgdm9pZCBleGZhdF9jbGVhcl9iaXRtYXAoc3RydWN0IGlu
b2RlICppbm9kZSwgdW5zaWduZWQgaW50IGNsdSwgYm9vbCBzeW5jKQogCX0KIH0KIAorYm9vbCBl
eGZhdF90ZXN0X2JpdG1hcChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBpbnQgY2x1
KQoreworCXVuc2lnbmVkIGludCBtYXBfaSwgbWFwX2IsIGJpdDsKKwlzdHJ1Y3QgZXhmYXRfc2Jf
aW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOworCisJYml0ID0gQ0xVU1RFUl9UT19CSVRNQVBfRU5U
KGNsdSk7CisJbWFwX2kgPSBCSVRNQVBfT0ZGU0VUX1NFQ1RPUl9JTkRFWChzYiwgYml0KTsKKwlt
YXBfYiA9IEJJVE1BUF9PRkZTRVRfQllURV9JTl9TRUNUT1Ioc2IsIGJpdCk7CisJYml0ICY9IChC
SVRTX1BFUl9CWVRFIC0gMSk7CisKKwlyZXR1cm4gKihzYmktPnZvbF9hbWFwW21hcF9pXS0+Yl9k
YXRhICsgbWFwX2IpICYgQklUKGJpdCk7Cit9CisKIC8qCiAgKiBJZiB0aGUgdmFsdWUgb2YgImNs
dSIgaXMgMCwgaXQgbWVhbnMgY2x1c3RlciAyIHdoaWNoIGlzIHRoZSBmaXJzdCBjbHVzdGVyIG9m
CiAgKiB0aGUgY2x1c3RlciBoZWFwLgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBi
L2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgKaW5kZXggNzhiZTY5NjRhOGEwLi45MGQ5MDc2MDllNDcgMTAw
NjQ0Ci0tLSBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgKKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMuaApA
QCAtNDU3LDYgKzQ1Nyw3IEBAIGludCBleGZhdF9sb2FkX2JpdG1hcChzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiKTsKIHZvaWQgZXhmYXRfZnJlZV9iaXRtYXAoc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNi
aSk7CiBpbnQgZXhmYXRfc2V0X2JpdG1hcChzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBp
bnQgY2x1LCBib29sIHN5bmMpOwogdm9pZCBleGZhdF9jbGVhcl9iaXRtYXAoc3RydWN0IGlub2Rl
ICppbm9kZSwgdW5zaWduZWQgaW50IGNsdSwgYm9vbCBzeW5jKTsKK2Jvb2wgZXhmYXRfdGVzdF9i
aXRtYXAoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgaW50IGNsdSk7CiB1bnNpZ25l
ZCBpbnQgZXhmYXRfZmluZF9mcmVlX2JpdG1hcChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNp
Z25lZCBpbnQgY2x1KTsKIGludCBleGZhdF9jb3VudF91c2VkX2NsdXN0ZXJzKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIHVuc2lnbmVkIGludCAqcmV0X2NvdW50KTsKIGludCBleGZhdF90cmltX2Zz
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmc3RyaW1fcmFuZ2UgKnJhbmdlKTsKZGlmZiAt
LWdpdCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhmYXQvZmF0ZW50LmMKaW5kZXggNTZiODcw
ZDljYzBkLi41ZDhiNzQxM2Q4MGQgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2ZhdGVudC5jCisrKyBi
L2ZzL2V4ZmF0L2ZhdGVudC5jCkBAIC0xOTksNiArMTk5LDE0IEBAIHN0YXRpYyBpbnQgX19leGZh
dF9mcmVlX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpw
X2NoYWluCiAJCQl1bnNpZ25lZCBpbnQgbl9jbHUgPSBjbHU7CiAJCQlpbnQgZXJyID0gZXhmYXRf
Z2V0X25leHRfY2x1c3RlcihzYiwgJm5fY2x1KTsKIAorCQkJLyoKKwkJCSAqIFRvIGF2b2lkIHRo
ZSBjbHVzdGVyIGNoYWluIGl0c2VsZiBpbmNsdWRpbmcgYSBsb29wCisJCQkgKiBjYXVzaW5nIGFu
IGluZmluaXRlIGxvb3AuCisJCQkgKi8KKwkJCWlmIChudW1fY2x1c3RlcnMgPj0gcF9jaGFpbi0+
c2l6ZSAmJgorCQkJICAgICFleGZhdF90ZXN0X2JpdG1hcChzYiwgY2x1KSkKKwkJCQlicmVhazsK
KwogCQkJaWYgKGVyciB8fCBuX2NsdSA9PSBFWEZBVF9FT0ZfQ0xVU1RFUikKIAkJCQlzeW5jID0g
dHJ1ZTsKIAkJCWVsc2UKLS0gCjIuNDMuMAoK

--_002_PUZPR04MB6316E053BBAA0B434A32A147813E2PUZPR04MB6316apcp_--


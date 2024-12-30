Return-Path: <linux-integrity+bounces-4493-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D963B9FE2E1
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 07:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D0D7A1131
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 06:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F10619C552;
	Mon, 30 Dec 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="dgqpw3wP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54E1799B;
	Mon, 30 Dec 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735539239; cv=fail; b=l8Apcssh94oz5pjopdXrPRCaAhW/j/GefmRURMN3P3D5wns3RU/CkHb9lx9mo7musuThX7x4mHtWf7oP3RZNMKoAH7vEFCZQFd3G4nKz1P0l61zbdodx87DjZxvjQFuAbKaVHO3DnJj2VRApSx1O5Cx43A2rfAjz+4i2QKD4PTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735539239; c=relaxed/simple;
	bh=S31DOBUxwYKDvXyRCqQD3qLkvtdtKzvTAa0hcyFcj9s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oNJDGhiYcAJLsnplv2bQq7UbtsE7mtzuFBTinRW1R+MJQhPNpyFGZ8ZETgNc8Ita6fT4si0zZ4YlC5b36xRksZWel64UM8N5Y+H1pxcLJPGGfgSAfU9r+96OuQd9XdiipAhumiNm6NgC/fBN0avuAiqZl6RTFXgoji8O3IlolTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=dgqpw3wP; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU4qeqB000942;
	Mon, 30 Dec 2024 05:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=1zBItf0n0PYNlEfoKvM+KAfcDv6gVVW
	mT5jF4bvmVzs=; b=dgqpw3wPZhfzorocYW/KyZurVPY28aOPntzGquWj8EUuVh+
	TC1Oby7vGM87WNdfrNQxQeZVn6Rsx2u17fvcbAp2HgBtiFPo5w4NUyJRM9ifqZbd
	d7f4+cbNbVNPEhGagJKynzIToCnSgA+TQpx5N5FeP0um6q/Ml0gQF9FLH2eLUZDo
	x/zeRacydnNjRrnIOgCOTLDtSuyIVvWD+oVhv5JeTy+38XztnKshiAvmTriIvAjZ
	84pYaMz5N7mRfQ02uRcJ5P9SIX3r/EUGdgUk/Ua0hFUdwZh6/emcdvr4FVYYhB3V
	nnS8+caGKSUe08vP38lK0cN6I+A7oMapMkFNTQQ==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2044.outbound.protection.outlook.com [104.47.26.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43t84411pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 05:15:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCSX1yLPRTImmhMZBYLqH0g4Y9Vxf0/Tb51ECC3eERw2CaaDPxy6ExBze5nV7uO3cYs6o38HbDqBbes+jWeihE/h5dD9FuRJ728OLWTcBfmxMLcxPDTxOeEDqtAP627wEl2WR4ppMmh/Eu+aySq+R9eb9tsAIhb04t2QTu2OTWWkk2Kp/13kx5oUCo0Jt15KyhCmYsDW50mBQ6uWxTvKK5FzstL1d355Z0VyxMtD3gZROfrg59Z9fBhck+iWgm7kRAKnMSohyxBnvnOUdEvhxQ+h6CsGspYxARDyr6/f6ouVqjak4p0CaKrWAg/c4x1wEC0LgLXdu0D2J/POyBygCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zBItf0n0PYNlEfoKvM+KAfcDv6gVVWmT5jF4bvmVzs=;
 b=xTUV+Uwb96JGM+DTEoYDTQV4LJJ/sY4zsh1CGe4uGOc/GerxhJHvVCHJlZzec2GE4vL/aMhU17bjZFRQAJwMNhUyqQKiBUz/ZwAeriPe4Oo/jNslXAqlW79gjVmbqmOkkclZxZw0EIvOnB+MT27Art8DHIDq3yb7PZFssWIi3iPdX82GOMoS9szOkRwfLRM6STpzrcsxDzKzDHlZgZYsuX8GL7LobhIGgl60v40ex9pyA+NNKeGiWHYRJMqCUHYvVXg8JWEMGwSoPtJdv5+fzMksini2SZXGzglifVaTHGpQprCjYzRMbrEhtG0MBSH9pZrTG6JYkT4eNfRa1DDOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7581.apcprd04.prod.outlook.com (2603:1096:820:128::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Mon, 30 Dec
 2024 05:14:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 05:14:59 +0000
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
Thread-Index: AQHbSktW2+Jjp9TjpUCMlyY1lZIvgbLgT5vBgAARQgCACAmSToAACSEAgBXpto0=
Date: Mon, 30 Dec 2024 05:14:58 +0000
Message-ID:
 <PUZPR04MB6316D814E4CF26B2A62EB24381092@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB6316F684BF023564B7DDD812813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <675fc926.050a0220.37aaf.0116.GAE@google.com>
In-Reply-To: <675fc926.050a0220.37aaf.0116.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7581:EE_
x-ms-office365-filtering-correlation-id: 270cc117-9091-4c52-b5f2-08dd2890e807
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SBW68OFfF2/T0fSnnWLzR0YJ5ExvOtvoNjdcNdsYKLEi6ebSmSpHv9r78Q?=
 =?iso-8859-1?Q?79vqN6SQG1CU0xE60+qsD9vOoZ4aVGEDcw1Wrehk6KNPrnQj7De8pYdn+E?=
 =?iso-8859-1?Q?/5fbfY9MlgTeuIxjfbwsnRwGF5wDf+1MWe2g3C6xFY/fqvmbHvYSL9/c36?=
 =?iso-8859-1?Q?dGIjtdP4DOrzc8slB4utajh/4ZVS5gaUfzS3tTKlMGvTPA6rYtPOYUsAWP?=
 =?iso-8859-1?Q?d8tZpdpDZRXA5BYqJ7tIRXLFMSlWlIjlF4VZUGtMkcTpkhzAlw7Q0CkTfp?=
 =?iso-8859-1?Q?zy/Gh09XNMG9KjxZAdAZClsop6c/ykko5wKQB+WQt8JtZH9s0Ff2Atzrkn?=
 =?iso-8859-1?Q?PwzcoWnGd+yV4mfbsSmALwakifhS0phQ+B6s5HgZ0U9PwNQc3zRGe4fR/B?=
 =?iso-8859-1?Q?yZg8c0IxOahU3F/o2c7L2h2iz64iSlOPSFpiUg7nvOY2fEDn3f5uJJhc+I?=
 =?iso-8859-1?Q?naOITig3HUjMxHmBaFtPzi+PkD2YtJYr3fSw71gzMswwgRi3q5EE0Fv/RG?=
 =?iso-8859-1?Q?3/y3pTx+41+6u/FKagLOqY+4YGYi33fn1ccdPYJZLBVdX4CxRzhiuktMY6?=
 =?iso-8859-1?Q?VfSb6fCcHqB9s/p9zB3WVYxOWa9GaOibCymPmyyODDF2jjVwRedV8bTBHL?=
 =?iso-8859-1?Q?fSRo14/t5wPonxsp89m8n5J2FVtG5OEo1WQ9ikDPiHvXJgrSSGK1nsXPjJ?=
 =?iso-8859-1?Q?9lqyPYJ+MQUYpeiomEVbVilTu/NY+JmEjsEK5+WFJz02rup1rV+9NtTRBL?=
 =?iso-8859-1?Q?DEovVqBdZfIhfQmnBZy+KDM3CP0ly2PFu8JjXi8N4wF/FJB2GoVVoXW/6u?=
 =?iso-8859-1?Q?8d9/xJnIQB1cDtYppVt4U5d0OcgZmZor1GT1hkOZTTluntf2P1Y4+Arv4H?=
 =?iso-8859-1?Q?tGHSCBIaxVKrpCTFatVL7vvw176eQyXHJuWPB/OrL71p0SS8Afs2Z268rK?=
 =?iso-8859-1?Q?VUs7Py70TT5Ss6KRrvwlIAlrZ5bhWA5fb74lDH8tDXnMEPgPevx4dJDT9n?=
 =?iso-8859-1?Q?07ma9pHylKifGwH0yUTjwVKuDwIo66gFXKI4dbwk4SDxSkFtSHB5XFJwuB?=
 =?iso-8859-1?Q?Z0awkDnXa0/h2bt0xwpogSOcxAVhlH9eLtFMKUtEXvVqxAtMKr+FO6qesl?=
 =?iso-8859-1?Q?OfydxHWBXJQitZwEBxb++idb8inl7aDR0cLoHSuGbNTzd7vBEB6W5L+5+L?=
 =?iso-8859-1?Q?lrguCk390ixqK46ezC/gF4XRt9CW6FnOkG4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?S31GBUu2ySVB0Fxv9dik4kScy6iAp0ykhieDRzJX6754yld5jLAnCUBf0l?=
 =?iso-8859-1?Q?c+GorrkCrsEdlcNYotYbQ7j54P1y3sM2mc+zL0HD4AOGW1dnuh8o7NogDy?=
 =?iso-8859-1?Q?VM8Mo+GLucRhu2AsvKdc0uOSJGaAMVTanGWQBWTle/1zMRZe1Vdhf3gYAs?=
 =?iso-8859-1?Q?bqtpasLo0cFRwLdMQf9Qc1tFj3/CErPIXMWJLmiQcmd3u7xA1dMHc6Dy5u?=
 =?iso-8859-1?Q?i2HmTO8t4P7qsZwKmfbuJjhFujlhyEvg4TmvngkLbvP/C3xjiDtuIvfvkz?=
 =?iso-8859-1?Q?7g4+bWkxgnjJWWbYNd9Eo/wyRC2GWtEleIbrXWtDMoUMR+KX5tF5xFMj6P?=
 =?iso-8859-1?Q?BZahQBCUeVSfqrX3i3mFdLLozGsRV/Xa+hgAsZq5YoCGJvghbpt9F9TYFx?=
 =?iso-8859-1?Q?AXT50FUvSYfAYS/Yfe2F5m7aa4E8PExB+kmTcm6Y9+7sbDKxsetELn+BM3?=
 =?iso-8859-1?Q?AxDeq/59JhjZ0wIA/JnOraRZ9pjVZ+Zi+eJkx+o01dPPlmqYsvzTO1gJfO?=
 =?iso-8859-1?Q?ow1o8RfbIGqgR5MG7er+c1sYa0DxnMtXaKUZDkmvsXEhGi2lfqunbYlHGY?=
 =?iso-8859-1?Q?SM4lQXzaYkCPqkZXvjJX3wWTEY0ufRSDPpEwgRVjN0zrOJ4kPopPQSWQxP?=
 =?iso-8859-1?Q?UeA58mUBpHEYSGp9zUBIapPzbTPqwXIHxF5/LKImLv6UBAsRdQCtX4SCBw?=
 =?iso-8859-1?Q?KdhQuarGlUfrSaq2Tkf/L3F76W/b12cDdbvVbxV3Y35rqxkfaFy7+rWMVl?=
 =?iso-8859-1?Q?tDZ/xB5Dp50clRSBRIfxPSoczJlZ3BGQ8//dMeY+DzyibaMw7WAaVCPp1I?=
 =?iso-8859-1?Q?kvIeQZ9GQnIgHJaSbwpcCJC6mKE/pyzDpN2lSrRzCUMqCjRAhBVdqN4/HB?=
 =?iso-8859-1?Q?IF0PS+AwIfb6oZYr4uu82AEkBVDMrG38NEDOrlnqYRE3LxbQN1PwzgVbgf?=
 =?iso-8859-1?Q?rWc39YPq82BKHgGFu3rw5ZtxTJHx1Vm6ILh5/mfupK3FyKKHcHSXkx7Hzi?=
 =?iso-8859-1?Q?dUojZU6E174pJ3DKgC5JLIIwOFL28UTi4y5r+3wFMZnfGZ0eXQK2zm078W?=
 =?iso-8859-1?Q?Mb6QCeO5o4Ye847RN4cQmPKQlr2rNkwxBqcmm/e8aPpO7Dkv//ep8ALmPo?=
 =?iso-8859-1?Q?urE7UJov/Uk8ngh4WyKhV0oUMqoI/ChPEMl6NqQWROvWsclVKTPcLVo+4u?=
 =?iso-8859-1?Q?8h6Qq0ErFAzbZEFbB73APex23JNDoqiHWS0ET0R62EDJlGM+tNRvYHdLYJ?=
 =?iso-8859-1?Q?yivSkfAPVHU38kKUmzYQDciQB1ZEPr/tCTAerv03NUNLa4KTh9SEyZReH+?=
 =?iso-8859-1?Q?0TA465X0ecwGJ5OfAl1gl4Abre1IkJoNTd73iilpeqgW4utzMtF8n1/yWl?=
 =?iso-8859-1?Q?xQR5WIemw8TLcEaBKFn88LCezXEuNjc+APEs2H+tBDdXfHTzu+sCNGJQD2?=
 =?iso-8859-1?Q?GqQQH7bNofhLXHd8q3fffjzzs9mjL769/lVhaspDveolPTd+lHzGJYm/vx?=
 =?iso-8859-1?Q?O8ocO3BvJrYxKUDTnRXg+KlDIPMxhMRDyISV21BXorfFgSQ9ufwDDnzwz8?=
 =?iso-8859-1?Q?dfyBFeQlT+yrXo8PJo+HR1MGbwV+fQw+sRW8zGxLTA6R0Vh/wzdN4KhhMZ?=
 =?iso-8859-1?Q?tb3canbL++dbtT2pTWq6w42la8X7pRF/0IlJ2SHC4ZJ8yDdlXiw9J04qSg?=
 =?iso-8859-1?Q?tg3gcle5Vh5MrG5YEC8=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316D814E4CF26B2A62EB24381092PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NBZqfJwpkWAdUa76eSCQ+OeSiQrenMIFJQKqT/tnswr8NlXtCLuszWX3/g8ceD+fs+4ACUQixkoVnyY/TNkjHdbocH8IIN9g4hol/didE6Fqprh9ry3D+TcSkIPOyfzY1nf9qA3bcPAfezEJ2dMEtxdKgf1ZvokcArzSWKjc7uKJeaZuQ71uSoUMfipfEYaWqBslVliTobjgpL2PnPx8450s6Fj43g5ZWW1OPfxCy96tzkb9fKPxT4Zwc51zoka4iMlDMoyylngbYeog3WSFTQzkRt+ACL909YtcWl6ZCGtXrUPmRoJXRyXIPCGabHDNeAKszlpAJEFUh6d0L/nVABk88P8x3N70+nzDc7MJCkQcZcpwgUgZNhAqxsxfRqDSx9uBBfbY4XuzOo52S4/LRt/Lxw9pMJVPoT1QjjsVdcFMiptaviC+ghanxbIpDn2JzfBWtCl+ER1Z0lhJckSqqB9qZ0+ai9KQIFMOpUXAUV9IA02g4YP8AWINxQou9wG4vJg01ssjt+JULMWl5aksTnbvGVZnxV7ZRMayM1nRR5erS0NhIfSHx/Z3QAfCUssyCIW1muDgRuy5GvYYm4RjXJY37dJTxVgCz1kCkcr2cD/wWvMx2BAUadVulvYdPjpi
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270cc117-9091-4c52-b5f2-08dd2890e807
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2024 05:14:58.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P82jFA/VrYcy1OiOrBjH/xnwhhv/Siz58Bq5hx+MBeUpCadIeBs8SWR0JX7XvVcvK1J4rZrvkaY4ltt5iwtxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7581
X-Proofpoint-GUID: FB36BlL0xm_aMDJGBx5awnTPeOWgsMlZ
X-Proofpoint-ORIG-GUID: FB36BlL0xm_aMDJGBx5awnTPeOWgsMlZ
X-Sony-Outbound-GUID: FB36BlL0xm_aMDJGBx5awnTPeOWgsMlZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-30_02,2024-12-24_01,2024-11-22_01

--_002_PUZPR04MB6316D814E4CF26B2A62EB24381092PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB6316D814E4CF26B2A62EB24381092PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v2-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch"
Content-Description:
 v2-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch
Content-Disposition: attachment;
	filename="v2-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch";
	size=1309; creation-date="Mon, 30 Dec 2024 05:10:30 GMT";
	modification-date="Mon, 30 Dec 2024 05:10:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1MTI4MDcyMDUzNWFiYTM4YjYzNDQ3YzM3MjI5ZGIxMDJmMjc2MTkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMTYgRGVjIDIwMjQgMTM6Mzk6NDIgKzA4MDAKU3ViamVjdDogW1BBVENIIHYyXSBl
eGZhdDogZml4IHRoZSBpbmZpbml0ZSBsb29wIGluIF9fZXhmYXRfZnJlZV9jbHVzdGVyKCkKCklu
IF9fZXhmYXRfZnJlZV9jbHVzdGVyKCksIHRoZSBjbHVzdGVyIGNoYWluIGlzIHRyYXZlcnNlZCB1
bnRpbCB0aGUKRU9GIGNsdXN0ZXIuIElmIHRoZSBjbHVzdGVyIGNoYWluIGluY2x1ZGVzIGEgbG9v
cCBkdWUgdG8gZmlsZSBzeXN0ZW0KY29ycnVwdGlvbiwgdGhlIEVPRiBjbHVzdGVyIGNhbm5vdCBi
ZSB0cmF2ZXJzZWQsIHJlc3VsdGluZyBpbiBhbgppbmZpbml0ZSBsb29wLgoKVGhpcyBjb21taXQg
dXNlcyB0aGUgdG90YWwgbnVtYmVyIG9mIGNsdXN0ZXJzIHRvIHByZXZlbnQgdGhpcyBpbmZpbml0
ZQpsb29wLgoKRml4ZXM6IDMxMDIzODY0ZTY3YSAoImV4ZmF0OiBhZGQgZmF0IGVudHJ5IG9wZXJh
dGlvbnMiKQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+
Ci0tLQogZnMvZXhmYXQvZmF0ZW50LmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhm
YXQvZmF0ZW50LmMKaW5kZXggNzczYzMyMGQ2OGYzLi4yMDNjNGRjMmRjZTkgMTAwNjQ0Ci0tLSBh
L2ZzL2V4ZmF0L2ZhdGVudC5jCisrKyBiL2ZzL2V4ZmF0L2ZhdGVudC5jCkBAIC0yMTYsNiArMjE2
LDE2IEBAIHN0YXRpYyBpbnQgX19leGZhdF9mcmVlX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9k
ZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2NoYWluCiAKIAkJCWlmIChlcnIpCiAJCQkJZ290byBk
ZWNfdXNlZF9jbHVzOworCisJCQlpZiAobnVtX2NsdXN0ZXJzID49IHNiaS0+bnVtX2NsdXN0ZXJz
IC0gRVhGQVRfRklSU1RfQ0xVU1RFUikgeworCQkJCS8qCisJCQkJICogVGhlIGNsdXN0ZXIgY2hh
aW4gaW5sY3VkZXMgYSBsb29wLCBzY2FuIHRoZQorCQkJCSAqIGJpdG1hcCB0byBnZXQgdGhlIG51
bWJlciBvZiB1c2VkIGNsdXN0ZXJzLgorCQkJCSAqLworCQkJCWV4ZmF0X2NvdW50X3VzZWRfY2x1
c3RlcnMoc2IsICZzYmktPnVzZWRfY2x1c3RlcnMpOworCisJCQkJcmV0dXJuIDA7CisJCQl9CiAJ
CX0gd2hpbGUgKGNsdSAhPSBFWEZBVF9FT0ZfQ0xVU1RFUik7CiAJfQogCi0tIAoyLjQzLjAKCg==

--_002_PUZPR04MB6316D814E4CF26B2A62EB24381092PUZPR04MB6316apcp_--


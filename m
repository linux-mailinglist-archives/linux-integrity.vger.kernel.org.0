Return-Path: <linux-integrity+bounces-4322-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8336B9EAD9C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 11:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3818802E1
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555223DE8E;
	Tue, 10 Dec 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="HVPluz4k"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647023DE8B;
	Tue, 10 Dec 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825300; cv=fail; b=IM+u0WHRU6fXL3I0d0OeByMCTqEb04y0KxfIo1YPaCvyubLLa/reLG1brjAR8g1hity2ICcX3oXq//GA/kUTi9W9zpx2AY/yK3YFUBvCVjVAAZLLz+qDnlVpteuh0tDFZbS+3uGcEN/eOAkgGl0XSscpAdjlkeLul131A5JDVpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825300; c=relaxed/simple;
	bh=PM1YbjHWpr6nKrVyzxrN+WMekx2Y03xpUMkVZwhu1+s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ED1mjO4we87MKBCwUx9MvDV+dEkhi9Zz8bnspt2JhB1A0l7A0LTGv5baRDX12FkWnGbH2CnhtG0CZLj7LGRDmR2Hh9UWpCsyKoFi53wJ3R2X+iQz/zFGwyaPahu61sJfe5mn/RtO2EwxJ5z4QujyEYDtKOLCkCPwK5QYc9Z8/js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=HVPluz4k; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA9joa5028121;
	Tue, 10 Dec 2024 10:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=DRB1AFo55o5epD5/0RP2poPhzhBNUb9
	2DENHhgZxif8=; b=HVPluz4ki9KWWBgZHkymoiIBKD6TH8yTmJ/AahHpQb9zv2t
	F+jU93xtubgyjzGBDqYxMp27PEuwxq8NcNxJJ3XzhrlEVjgkO3+Fwgo7T5fvuKYc
	QcHitGuGv2kJTcXgNF+lhYByjtwpI9gzkKWc7kLfby/JyxftpmzOMlqvqldhoVZd
	fzXpiuHhnok1ZloPEeYFNtOCwsyo3uij9e7CJZrtVOySP+HH+/Rs47GhLzVYgCOH
	GRXpZ/jGpvSspM+gyvryRjrf2yv+hIPDfecTM80JXX7zdEsel1KjoSyP0BykcuST
	zpdscMGO0EkMUfZ3WhojzETDzjXRXdNQLptJ8qg==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43cd0w2qfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 10:07:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9L/PXxJt/eB6c14ljjFT1AChHzyz6nOK7IyyVVgIgS6dI/Jw72J8pWL9yKy81yHdHKloB3YxO9yriBdqO+IceYuc69WPJfj2kT/TYPFiDPjIu6CWq+w8eznxG2IGjas5vKDOG+271KWafsDdWnUi1Wni+Mk+Ik4Tpvsrcggt2b1oWuRRajksgP4ZmHL6zpqCdXeV7vigkooel5lsknrfNeUio0XvwAJXmLgc0cKqeLGmkIlfBdN4Y1C/sidnj6Sy/C62c3H0HkzP6hLfhgMOLN2NoXUeLTJqjvO9jEYTk79uQrZr6MmtpqAXXFzk2gdK08pTrBH5zEyfAr8w+Tvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRB1AFo55o5epD5/0RP2poPhzhBNUb92DENHhgZxif8=;
 b=xtL3A9RLB//xSxnrlinFDaePMFXjGYLeKONjq/aCgfl1p5o26sw1vyiH1JW1ALC58IwVtHE1q23C4+3iYhJKL5d1bDTC8cuJJk/UrU0SkxXlsDxvJbUTs7m0+moT99RfHB1oiQaO6TldLQhqgUBgPYN+lEN5qa6dgLJVNDJVXMOouktw9r+VWlv5V4Zde71sa03qpvaFY+FqXmrp2Se7IWx0a1P5cdWOOSVEA4ZOB8HoZYcjtvrTh3G6ttfijiGmZXur2XpHc08G8rIhJmLaSKUTyIxrZu2TMo4JxLGVFMt/kZDuGnzJMfdM5OttlxWsqe5xcC0dpkZnjXSTuHFPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB7480.apcprd04.prod.outlook.com (2603:1096:990:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 10:06:54 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8230.008; Tue, 10 Dec 2024
 10:06:54 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hpa@zytor.com"
	<hpa@zytor.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
Thread-Topic: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
Thread-Index: AQHbSktW2+Jjp9TjpUCMlyY1lZIvgbLfQM3w
Date: Tue, 10 Dec 2024 10:06:54 +0000
Message-ID:
 <PUZPR04MB6316E131A563A11DB08B9C54813D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <00000000000065deef0604e8fe03@google.com>
 <6757066b.050a0220.a30f1.01a5.GAE@google.com>
In-Reply-To: <6757066b.050a0220.a30f1.01a5.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB7480:EE_
x-ms-office365-filtering-correlation-id: 461b9418-daef-4bd3-aa7f-08dd19025fa3
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/o4dKtWa40vSDtg2HFGBv8Wu8HEq2SaJpn1b4OLaRgbYrnoIlaeKzNbkf6?=
 =?iso-8859-1?Q?eWPPCx00CmNwj5WaxpTwbzwre3bCJKJCxIos4zK9lbAsLrl2dQahTCP5By?=
 =?iso-8859-1?Q?me6vCw/6XKuRhIm3hDCDEguU8scvqwK6NsnnUE0f/H+6R5WrtTj6Ow8l/J?=
 =?iso-8859-1?Q?w+r8bdC80FaSG4W46zotpI6II8vixo37srAkUpkgR1XO7bHEXzFCxnqWkZ?=
 =?iso-8859-1?Q?U1rdkchRq6JqAIvhL5SPMZtgjur0grNxBlkrNv0uKug97qup4jIFn7Xbv+?=
 =?iso-8859-1?Q?4zL1Y6SWEIZPDgYLJpeh03WLmD5wmNbegcDOjxeKtueJIJkC39B4Kyzz0W?=
 =?iso-8859-1?Q?VjZhP6djIaEQfUiXnJLklgsB7Wy/IapQwHDOU6/zSgmfacW2PxX7JY0kX0?=
 =?iso-8859-1?Q?knb5TY3DmtYdBr3xcZiFD5zGGKlSO3kg8ohA/dTkr9iHCNGNjmY6GS6dZ0?=
 =?iso-8859-1?Q?ft4F2PNEqqZkmcSe2g/Bobkw+6jFS6PtLuOCxqEUjlff+KDhrv55NUvYZ1?=
 =?iso-8859-1?Q?rqN1WepIv4H1H5DnxG5bagRE+jLJlJU3aDB7lXJeyeA2vfXyNSzLxa/0fK?=
 =?iso-8859-1?Q?rzOqptCiufYUblVHnq8JnapZ8fOceEkTsBz6IllVGsYse655SLNjuikZeD?=
 =?iso-8859-1?Q?Ky9sbNpxFwK8fs3cNT8JazSTrMBpHsQmejfrcDg2jmKTnOLd9J7vLCj6pP?=
 =?iso-8859-1?Q?BeYnheQO1ClIhjLtPqbKiiTB5Y8XGOdoRqcveKLrkU9iUlvReLGjrwwUAy?=
 =?iso-8859-1?Q?E6WbwP/66C8yjpUZb5hNLSXvdAPgVnapen6lVtNTEyT3GLCmWQPTpurghK?=
 =?iso-8859-1?Q?wNLKJkcKyfEeLC+0byFdBzUYe3sylUPm2GPrZH/EwKgEiqjuEkHvGK+kzF?=
 =?iso-8859-1?Q?peUyNNnmo5hFK8mEIsup+5SRycbB4PHpi5I8roIaWK97VW5BQeMKJZ7Kvz?=
 =?iso-8859-1?Q?1LWebtzfW+YLN1iCWllwSgVI+DPo5P3hmR/Dj7n2lN4MWQWhbWl7mdw5Uv?=
 =?iso-8859-1?Q?93qOvIT6bvgT1dl/50y0rCUSabyIBcmtMNakOUtrdiis/Xs6FI1CTXr8HV?=
 =?iso-8859-1?Q?YYuangp0Ua9vVaqMf7+ncdcdz38jwA5XDwc5Adm0fBZJeIK1vvd+ezTlAU?=
 =?iso-8859-1?Q?NWIyVf52S0FdgK7DHLPWC1UpyypKsZX2d/r46vzNmfoUJkx9nFKp77ACpc?=
 =?iso-8859-1?Q?ALsxE5fgdocnunQIQoc+Dmw7lHecg5cZA24=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RJmSuOUZSOm3HByk5h7Zt02bA4ETN0ZE+ooGgPZD0IfohHNh5fDlxiNsml?=
 =?iso-8859-1?Q?wfD8pJI4QHsbGiLjNZL66EAj5itWlSv1y53bjcwuUw1K/lq07KjCBGe6iU?=
 =?iso-8859-1?Q?y9ILwI5fg6D2JmLQRBE3Cw4GcrE9mNcaRkx0fXeaSoaxscG882q/XueOLj?=
 =?iso-8859-1?Q?8PwnGqldl0/xKi8PktEdyt8MhfIc9eIBUi6d/tIUr53LSO+8YQecMUjcA5?=
 =?iso-8859-1?Q?VLb482NAYVASrsKw0rEslSAoPWeyHBuGW/5s46vdN7PHh9wMYbJ182dBaX?=
 =?iso-8859-1?Q?6KAe6OH8U+1a1T1dBH1WKzUAeKtcUMUTZg9cykoHSG6viQvAmajFISeT/P?=
 =?iso-8859-1?Q?h4yip1qoVgk7qIV7GxMgDzgKHBSfJaC6IEzg4va3Fbg5ZFNZg9Ps8Ft2rY?=
 =?iso-8859-1?Q?+WWVD0RYE8h3siRzDLl6v1yeEr+wOegRLTLabjMuqaxf+voLRH34S0Md6w?=
 =?iso-8859-1?Q?Eg6lKbbai9oC9vXx2tvbkKf9mCogYmJDBabPwUkFlsfpjAQJ3SiJzQQXCj?=
 =?iso-8859-1?Q?d0kvOLY1KAr4V8X4joPjxotWJWYDG6im7WsNuEzh182vmmcL98eebFH3qB?=
 =?iso-8859-1?Q?Vs5q4UZsO19xpQHb/m0/izPSZCKTHUII3egNYIGPHeeFUGjW9q2gIWBNG0?=
 =?iso-8859-1?Q?Gc0gCAlXrILocEztFxsdbl/CHx0K8mCJhuIALQaFyvYAwt5daPq9Iwc/BT?=
 =?iso-8859-1?Q?VYVFhlaZ1D6tRoiTTqXYGGy7LIurD9H09h4a8B1m8ixaGfOHV+wMMvRsYP?=
 =?iso-8859-1?Q?+Dirz9O7MURVL8Rh7tGLedAlDJ8vyfqjMj7Sh1Z1qaR9/bf0CBb9fUAjcD?=
 =?iso-8859-1?Q?0qL0/OVb9AL7fpuug4+UqidL6HBFbicnSS67iXdKnCWqDJ0QRBtCaND60v?=
 =?iso-8859-1?Q?D5/IcKLie9sWxklg89Kyetr6eF8ndJLAcZnT/tYbRrkUNEuaz2KcRzxdgu?=
 =?iso-8859-1?Q?ul1GxLFJvuJMlTLbZzUtwH3HDaD8QYclWlOIvhBSoQD9p1kqyFLi5oyEyW?=
 =?iso-8859-1?Q?9R2EezNVAu394d50aRS2lALpoHpmxYEi7LNUps2h5Yperb9ro2ZFrrnORK?=
 =?iso-8859-1?Q?dcMKUnlpiuJLbf2iRsntdurF0jFAUuFFsL3sKIfF3mGIs03zBkEaN/yIL1?=
 =?iso-8859-1?Q?ow4bBy2hYlffIp3aWJBlstU6iXubYcaoAlhy17TVyCCOSLs6vIp2BhFOkA?=
 =?iso-8859-1?Q?fzJKshvE7AuYOVixATpIF+KPtCT6UeDqSoCzx2cJTgzKDyT5rTn1/S3Dwg?=
 =?iso-8859-1?Q?2Eop2r3BL3hoJDX0dHAD5oQZP2z8rGr8+xxpEkFdOH5V086bDGGIg6aSUQ?=
 =?iso-8859-1?Q?sLAE2+Dd8RgSQjjjWwEafLVkDyUteyI+LzUFjIwa0UKbETo38O5IJD5wje?=
 =?iso-8859-1?Q?8moWzmGzWlU0H+I8+nOLAWB8NPh3h4XWPX/oYjdedvjiyT8OmH5lRgPHTI?=
 =?iso-8859-1?Q?zdfyYrnjt8QTmGNSsl+T40iASO5Cx6/afOGS4RkrXACMkF55pFNs/Z1DXN?=
 =?iso-8859-1?Q?w/NYbz/Pw+Lta0wPpyTrXRIdctdW16fk79623TIoo65OIl/Y+ki0lzcaJV?=
 =?iso-8859-1?Q?EpHghkjOyVzsHGu/X/IvfwBc3d4wgFF/2DUlllqqUIIOXaWAIIrG6pvMEj?=
 =?iso-8859-1?Q?H9ac9ZTliDu+sZBa4iViBSqLchmPZRs6TvsamgB5kYrL2se0e2w7a8bM55?=
 =?iso-8859-1?Q?66gW0psV0lcI/t99uhg=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316E131A563A11DB08B9C54813D2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wi98alSIy4WAAtFdw6oxY1lIK+2B04mbgwaieLtuSJtfGQxI6r9OMQPfkMjgz2COy5MhemVI8/lXbiGTAXIZ/W+ot+uYoRNExqiKJ5eFiyThszq2O6tsdfgkRUD3d7JkGvtyeKaeVLvWossHGn4f2t1Q3SvZ6/I+pWdiUTxp0JGWFXaMvNyrGgodW2m6pPDrvEAeExCsLCcGTl0WTkkMmzr8Kv15v+z2Rr9eirXAXAyqHrmKKeUbxNKqYgVQXq6erKu+W5WVn27pZsqYQ78KMYvFmEp5r1Ig2jb5uTbFRq1uK2G9y3Ikhqfm+q8xoVuGjsQZg26FIZAsQccuUZgLLjn5nhnCs/lfZJ2Ureh6KqjigrmEsfikudeuS20sEAjOIut9Ick/w/2tgXW+Gdw0X4JkJe6AFGaLRiguWMHnt58LcZlCID4V6/ScXY869/O9RO/9CblW2+RRQF69J+KjL6wDTRaBzGZ9BmQuhtAvD3loXS7ak4qkZhKjORPTnNm8tdBTs9YfcIAgN96/QtvfC8BQcYFqrwdKuaS4QnMHYbfCHCQI089JIcy6+hwzEVOPiuZ8zOhTNc4QXLwAoMkDcogtOfyW5V9VL9kGam0XPejdC9M58OL6v80z6x8Taas4
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461b9418-daef-4bd3-aa7f-08dd19025fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 10:06:54.1145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yG49hG6en4b/4k2bCcI8JPMM4mgPzbhXJdL2f+zpXcaeQIAC2IE8lElL1TVGxOI5FuXWkRlPxLi9ysOSgFwltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7480
X-Proofpoint-GUID: iCihc1ks8wGHPgcu_UShHPjFU3C8OPmo
X-Proofpoint-ORIG-GUID: iCihc1ks8wGHPgcu_UShHPjFU3C8OPmo
X-Sony-Outbound-GUID: iCihc1ks8wGHPgcu_UShHPjFU3C8OPmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_04,2024-12-10_01,2024-11-22_01

--_002_PUZPR04MB6316E131A563A11DB08B9C54813D2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB6316E131A563A11DB08B9C54813D2PUZPR04MB6316apcp_
Content-Type: text/x-patch; name="0001-exfat-test.patch"
Content-Description: 0001-exfat-test.patch
Content-Disposition: attachment; filename="0001-exfat-test.patch"; size=727;
	creation-date="Tue, 10 Dec 2024 10:05:14 GMT";
	modification-date="Tue, 10 Dec 2024 10:05:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxZWFkMmY3ZTBjZmM2OGRjZWRlZjU3ZGU5ZTcyMzY1YjdlMTI5ZTQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFR1ZSwgMTAgRGVjIDIwMjQgMTg6MDI6MDcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBleGZh
dDogdGVzdAoKU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29t
PgotLS0KIGZzL2V4ZmF0L2ZhdGVudC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhmYXQvZmF0ZW50
LmMKaW5kZXggNTZiODcwZDljYzBkLi41MDczYzZlNzUxNGUgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0
L2ZhdGVudC5jCisrKyBiL2ZzL2V4ZmF0L2ZhdGVudC5jCkBAIC0yMTAsNiArMjEwLDggQEAgc3Rh
dGljIGludCBfX2V4ZmF0X2ZyZWVfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
ZXhmYXRfY2hhaW4gKnBfY2hhaW4KIAkJCQljdXJfY21hcF9pID0gbmV4dF9jbWFwX2k7CiAJCQl9
CiAKKwkJCXByX2VycigiZnJlZSBjbHVzdGVyICV1XG4iLCBjbHUpOworCiAJCQlleGZhdF9jbGVh
cl9iaXRtYXAoaW5vZGUsIGNsdSwgKHN5bmMgJiYgSVNfRElSU1lOQyhpbm9kZSkpKTsKIAkJCWNs
dSA9IG5fY2x1OwogCQkJbnVtX2NsdXN0ZXJzKys7Ci0tIAoyLjQzLjAKCg==

--_002_PUZPR04MB6316E131A563A11DB08B9C54813D2PUZPR04MB6316apcp_--


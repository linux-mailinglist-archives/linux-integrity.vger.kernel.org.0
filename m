Return-Path: <linux-integrity+bounces-5005-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178A9A47C5C
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA23A22CD
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 11:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3D622A7E5;
	Thu, 27 Feb 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="TCn6D8JX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2127.outbound.protection.outlook.com [40.107.103.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B018229B0D
	for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2025 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656226; cv=fail; b=aJPTimZgJ2x+YnBDcKNhxCnclnJOf2f8gsazlyiC+nzmyS+ZLggVi9WP/PbsrUbSD4QdBdlaQM6oVUo+CQ8qS+L00213IrcjVFTZKsGHmitmAhNzHTh1hTz+iu6M0dFx/Jd7mLxgdumlei92E4sWYnipTQ84dcPNDxu6dtZo/P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656226; c=relaxed/simple;
	bh=7w+v7JdrhmEcBJbrVcYOd6zRvjre4y+ROexpIztVtWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RySYDxcY0QJ7w+IB32EZZzJWo48tNieFgfUOfcKJP18awx/TuOrYl5HQwZDrfonesIM9fGegGIC4UfWQMKGzMb2vnup7FzQMnSa7sZhrud0mIvp9GdqukXqsBZ1YqT12wGNe5vt+dQlMxuU08Q3T5dRjJgG+uLEIRirpqunKOAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=TCn6D8JX; arc=fail smtp.client-ip=40.107.103.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTVqBITT3RTSMH+yy+aqCO6UogPJNQXn3NEpB7a9bKFn2Yi7eIzgS3a5FXOZCa4CulVABBbwHrzQCylVqbbT7IjOL3A5pUlToMcTaXTYmTysdYFMc/4CO7tMEgQBmSAhcJePkcuM4uztgsm8CGtcUmFo6ALClHuDm1YNzynOP3+4je4BKfSSY7aD6o1Fj8x8ZBD1LFFdB/VNfCQYpOYIA3lTdqeXjP5lLg7urEKFXius2bxqT5Yr1wt/tlfSr/nhtAhUg9/RCy/+tqc9JpBLikyCGAKZQYNtQ9MeaOJMdePcRRG+kPdy/KtPu5Jmo0q+sY1adrGYCdwGKdwBlcE5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w+v7JdrhmEcBJbrVcYOd6zRvjre4y+ROexpIztVtWY=;
 b=bE16Rjd2IoyoAzPbC/gyQa1YNoomlwxjZLSmqa839fBccdfrYUSjA+VzadGVCwfx70oM4+to9GBIqklotCNHR3lK79Mv9sLiVnbqlv+5YdObYzM8c0UjdIqRgve9b0MpsrXSO/UtxqkeLTXVldTfs9JCtV0NIhdeR+qqlFh30GqU0d8nbWq8c30403YEwEEaQDs+fnMiywRHZP7JyZUzjBsq3aiYX4FDzCFFxwNqOkTw/5drWZRkkGqOMUXUxRv/h0nlvURSkuwA3hzg89F5bAwQPxZSDNyFw2rK6tAGuIpsP38TQ+4L6+HZVIUcM6jTAo3ySzaHoVzdN+tLEsYmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w+v7JdrhmEcBJbrVcYOd6zRvjre4y+ROexpIztVtWY=;
 b=TCn6D8JXpew6MR30ok7/C8fgHFTsWR+3siInj2cQNN4s8+PKdDakNsQrPy8TALuUc4mdVlkdRgDblBjdm+5SsKFWrtDY84mtcIzXiK3J7/LZtDQCPeiM7HdZzu/SVi0ecp088SHLX7uPP2r95lMCr31Ccf+DivT9pEGBbdU00Mc=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by DBAPR05MB6967.eurprd05.prod.outlook.com (2603:10a6:10:187::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.14; Thu, 27 Feb
 2025 11:36:59 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd%4]) with mapi id 15.20.8489.014; Thu, 27 Feb 2025
 11:36:59 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
Thread-Topic: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
Thread-Index: AQHbh4kqbfMU9EdEvEuw3vrfgofl17NY02GAgAFgF4CAAEZNAIAAjvoA
Date: Thu, 27 Feb 2025 11:36:59 +0000
Message-ID: <484b1563482aca871a147daeff916fcb0730c6d6.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
	 <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
	 <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
In-Reply-To: <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR05MB9840:EE_|DBAPR05MB6967:EE_
x-ms-office365-filtering-correlation-id: 541c6a12-8096-40ad-f78e-08dd57230c09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0ltZGNCZ0hMNHFYRUZhSGdDOEMvOG5SVGlrMUVqd3dyWTdqWHBYejczNzlY?=
 =?utf-8?B?dUxEOTlIUXkvdktvV3Z5NFpNMktvb1lNTVVYMmlVY2JoTjQ2MDhLbHE0aWxr?=
 =?utf-8?B?eXlkU0pQVGU5TnBmV0FCWFdpZnMyMXRDeGxqQmFJaW1ISkRzSzNBMUFJRkFw?=
 =?utf-8?B?VFNtMEgwWm9YRG01L0tXUGZyOFNWb3JCTnNhanowZUpFUXV0L1l6U0NPa2FW?=
 =?utf-8?B?NzlaM1VQTkZQM1BiR1U2MHJGN3VmdHRLLzZkRXF3TEhkemVNM2VsTGpML0Vn?=
 =?utf-8?B?MGlXanprMGV1b2V0ZjhWOVRiMHRPMjNqd3NIQ0pnSmVFbVdGaytLZXFZOTd0?=
 =?utf-8?B?dkxXZytGOGxPejZXNWRrUjcxbEFTcEVnbUhXaVdwdFpEZnNvdW41WHczQXZl?=
 =?utf-8?B?Q3BWalllSEplZFNmSVdCWm1tbnNyK3RHaVgzQ1JITkhJRmkxaDdpdzkxRUda?=
 =?utf-8?B?Y2N3c21tbWNjRXp0RWFSa1Q2a2VpQitJL0RQeXhrTGZ3dWZTYllVNDgwSDA2?=
 =?utf-8?B?TGkvTlh6emZvekJoTGdSb0FUVGdQaTJJMHpKRXRCQytoYnhFU3lISWJja3pu?=
 =?utf-8?B?cVNWdU1xL3daZGNhNks1SStydkRpTWpVYXd1d2JheXp1dXNPdENxay84NFpj?=
 =?utf-8?B?WHVHTVpBdVVNTDNsSlM4NWdLa3A0NVk3NE1rLzgxRjNtOGp3NHRkSHRST2Np?=
 =?utf-8?B?U3hDNDR3REVOLzJFaWdFa3pBM3RqbmNzS0dOSzJOeEllM2U3QTVPRW9ETjk3?=
 =?utf-8?B?Q2VaQkNmQ01KYm9ZVTE1L3ZaUElUbWdIS1BOWk9nNTZKTm4vajE2ZUVVWjhn?=
 =?utf-8?B?bVdoWEFKRUhWelJOQVl0NHY0ZDJsZlc4Ty8vZ1RHVVBKaU96WFJOWGl5eFlR?=
 =?utf-8?B?eFM1SHdZUHFuUk44RllWM2o3NkJKUjhuNkJkYlpuNkJORXhacFI1b2lyTWhS?=
 =?utf-8?B?Y1JYdy9NcVJVRVRtWGpGemlZQUdMRmVrVDJTbGVmd3JjNGJTdjBlem9CR2d5?=
 =?utf-8?B?OUVUMFlRVzZyUGxKVnZqLzVaenBjYVUvZU9ML0pwWW81YmlzRVF2anFsb1Z6?=
 =?utf-8?B?elJtWWh1YnB2dWpiUjRadVdPVjl4WTA0WmdneW55SzU5TWtGbUNEa0xnVzdU?=
 =?utf-8?B?L0xoK3B3T0FFelp4VU1ZSHZiMEJLczNaaStoYjRleWFoSGJsOGFRSFhpTHlW?=
 =?utf-8?B?MEZRdlAyQkJVTk9ra211MkJ2NEN5Mkd6c3RHSy9MRlJMdVlZZWxkZ1ZJMWhs?=
 =?utf-8?B?Ykpob0dpYWhiZWRnWnp0M0JoS1p6MzQybHc4aGRleThVTlZ3QnpVNnhkZi9w?=
 =?utf-8?B?YzlyQmFJa1dVUlRMcHlCTHlBZW1iSVF2MUlGSVVnaU1Tb1hnQnRSbUZXQjJK?=
 =?utf-8?B?RUZoSHJ1dEcxdU1SVXJyQ09Lb1VEM1JUTFVGdnVKVGFhWnFsWlFCMldNbzNZ?=
 =?utf-8?B?ai9LK0tyOWh5ZUJuMDZOYmVOakRQd3VwRllEMHMrV3JlNzBCb1czcDVCK2hT?=
 =?utf-8?B?NTcyeUtJTUhVcGxaVlBuemJoTnJsVGNNQ1R0ZFphaWpsZXk0ZDBhNTArZkpF?=
 =?utf-8?B?ZTJqWUlLNVE0alFERFlZS3lFbzlKcnhuMUhXemYxS2RZdGk3SEg5T2pseHhB?=
 =?utf-8?B?NFdYaklraFBLYVdoZytUdFh4V0hzekc4MGJUcmhFWm4zMVdCVGt3aWpObUhB?=
 =?utf-8?B?cFhVZVRUbXlGT0EyNkRBQmdEZmlnYnJCVktNeGRHaWU4OGZTUU9nOXgwZW1u?=
 =?utf-8?B?dkJ0d1Z4MllieGFNZGZJRWYrUnlKVXZkR29KUXIxL0xNOEloTklrVUNsbmZU?=
 =?utf-8?B?RExURkFxai9VOVYrOWF5ZnVDV0ora0JuWGtWbTdyR2Y4Wnc2cE5MUjhJdzkx?=
 =?utf-8?B?cDVmSzRJVm83ZDg4V2hoSTVmS3c5QzlXS3dlbjlBaUxjRk13c0VDZVBCaEht?=
 =?utf-8?Q?np1EsAIKmAGLx9aVs30sathRnbHQpk3+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STV4bUFoTldvcnVIcHNQUFA5dnpFYWFRMWtKZTVpRVlOKy9jaXE3TXRncEZ2?=
 =?utf-8?B?TjVxb25qK05DaVp2ODM1KzlpRTdTeXhjdlNXeUc0QUdBRWtLbTRwNk9NVG1J?=
 =?utf-8?B?MnlUWnVaelltd1cwTUdLdGZwMG9uYndMN21TQ3hraWRZbnRtVEQzSkhhcUZn?=
 =?utf-8?B?OUJ5eXNLYnQwNTJtdTVmTGxrWHJjbVZmSEJLK0ptOUxzVDMxZkVzblA5WWhC?=
 =?utf-8?B?QUp2dGVPYW0rTWVqZXBxSmlmK0xncUVmejNpUnB1VmdySzhoQ040NHR3T2tC?=
 =?utf-8?B?a1cwbzdTVXdsRDNzWTNROW5IekNJV2Z4S1MrRlkreGdlSmxZQXZVcmszUzBY?=
 =?utf-8?B?Ylg0cGRyTFoxQlVIeVhKamhIeXdtSmh5MXhOMjJXZnV2aERqa1FrZnJYVDVy?=
 =?utf-8?B?TFJIRHRwUlFiWjArd1ZiOWtQMFlxaTJ2MW9RUXdtcElqYVR2N3dJT295R3hN?=
 =?utf-8?B?V2p4aStFcVVGcUVLZTV1R2JGWUFTeDFIb05tRlowWUIrcDhOaC9JcVorOWhM?=
 =?utf-8?B?bm1lRlVkbWxRalF4WFZnVDVMQ2Jkb0wvQmh2RXB6RTFYRlNjclIyYW1DTVRY?=
 =?utf-8?B?cXB0MjFNaGlNR29CZnJFcmp4RlRWN3NJZUFhTDlIdTR2Qm4wN0l0bWpSK25F?=
 =?utf-8?B?SFA0dnhDMTNSWC9tNFJKVklNb3VEMHpSdFhGZmtrNlBYbUVmOE1KV3d1dSti?=
 =?utf-8?B?cExYTGdhS0FIcDNONW9tQzkwKzQ1N1RHZEFENUhadHVUY01Ubi8yYjcyWllS?=
 =?utf-8?B?emI1aXdFTjVWeTBsRWs3bFhYZXR1UmtKU1pUN3pWNDRYbGtRQ3RTOFppdDlG?=
 =?utf-8?B?WDBjUU5HWTNtUjBHbURkTTNCc1JpemhNK090c0RpVTBsRDZWWDJwUFZET0Z5?=
 =?utf-8?B?K2wxOHhzUGVzNXZtT1hBemNGV25jbmZtV2p6Rkk1cXRJK1RYRWw1aUZodHBZ?=
 =?utf-8?B?MFdFWXd0clMzVHYvY0ZKQXRNd1ZiYzZkOTBPamsrNFgxMkRMQ3gxNzNGdk00?=
 =?utf-8?B?NzJtYmtYblhLLzhhREEraTJOREFYSFBXaG9jbkFMQ0xtZ05OdFVkTHRFYStu?=
 =?utf-8?B?dVdNOFpOalFkNFVzcCtQY2dKdmZrMEpSOFdrZDhGbEpsUWtHSGtXd2t4ei9r?=
 =?utf-8?B?ODR3QmdDY0NKbzk3Q3ZNR1dya3luRno2Q1JiaWw2cHJVYnNha2pXZkh0U0Q4?=
 =?utf-8?B?dTJJZzNWc0RFcWRJNkQ5THBLaTMvRE5SRFB4Tk9Ia3Y3ZU5FaSt5S1QvS3JC?=
 =?utf-8?B?MWRROFEzVWxwUzRDZlJzU01JUXYyakRIOE1xaGxNejNvV052TUluYlFOSE8x?=
 =?utf-8?B?NGExMGdJRTZvaldKVUE1UzA0dFc4WmJXL21xV09pM04rcTlqTEFJMlZRZUg2?=
 =?utf-8?B?Y21JSEhzbVZ1WG40U3VQL296a1dHVnJGcUFmTllaSHIycW5hNFM1QTBEZ3pq?=
 =?utf-8?B?ZFphbys5Yit5VENhZnVKVHJzeDBTV2dRRHQxQkNzamdxTVI2SVVGZFVzUHFD?=
 =?utf-8?B?K0plVU1zTS9GRE1vMXRYeVBTbnVwSHZNcDdxT2N2U04wR00xcFZFQ2NIblFx?=
 =?utf-8?B?TUR6UTkwek5IUkJDNk1ZLzZGNlJPYkxxUjVPNzVSSXZSZEd3Sks1c2pPUGQr?=
 =?utf-8?B?dkxnL1lTdVltWUlvN1QyaEIrSFNSK3c3eVlsRkVTVHltTXhQZ1djdmMyQlNx?=
 =?utf-8?B?Y1RLOWh2R2orTFN4Ri9nOWJEdHZXOWZoRzk5cWloL2l1TGE2WHZRb2RXRkJz?=
 =?utf-8?B?eEs5ZzJPYk45TzVhSUhKSFBxcDBGMVZkVFBHdHFHckhiOE8yU2kzdDhTTWtu?=
 =?utf-8?B?R2t3VWV1YUlRVS9jckF4REozOEdVME1sdU1UQUU5cUVSS28xay96YzZhMktJ?=
 =?utf-8?B?VVVpQittbDFSRCsvK3Q0TjNWdWZKSVE3TUdYY0h6R095OU0xV1FyYitZR0Vr?=
 =?utf-8?B?NnloR0krcTB6a2RqaFQ0aHFsRDl1NUpKZDlLeERiYmJTcXpES25rU2JvNHdx?=
 =?utf-8?B?ZWtwVzlkTkxnd1cyWTZYaFB5WmFtQ0pBQllxT21CMDJKdkU0R0d3c1czVnVL?=
 =?utf-8?B?eXFqSmpnYVZwRm9XQXM2WXo1SUVlQW1hUEZIMXhURWthdXQ3U3RWdDBwQzZw?=
 =?utf-8?B?Tkx1S1RFdEF2anU4YU1uV2hLUkd2NzdxcmtHdy84UkZ4R1RSSy9BdWh2anAw?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B0471B1B209E346A80335EC0E13582F@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 541c6a12-8096-40ad-f78e-08dd57230c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 11:36:59.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQiENShKwVWuVvDQduP3rxZ2vkrPeNqBJVgj1K77zqPy67eH2Nb7Zxz5pK75FehhOPmZyE0Y3hOWBNv6Z3WMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB6967

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDIyOjA1IC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBXZWQsIDIwMjUtMDItMjYgYXQgMjI6NTMgKzAwMDAsIEVucmljb8KgIEJyYXZpIHdyb3RlOg0K
PiA+IE9uIFR1ZSwgMjAyNS0wMi0yNSBhdCAyMDo1MyAtMDUwMCwgTWltaSBab2hhciB3cm90ZToN
Cj4gPiA+IE9uIFR1ZSwgMjAyNS0wMi0yNSBhdCAxNDoxMiArMDEwMCwgRW5yaWNvIEJyYXZpIHdy
b3RlOg0KPiA+ID4gPiBUaGUgZmlyc3Qgd3JpdGUgb24gdGhlIGltYSBwb2xpY3kgZmlsZSBwZXJt
aXRzIHRvIG92ZXJyaWRlIHRoZSBkZWZhdWx0DQo+ID4gPiA+IHBvbGljeSBkZWZpbmVkIHdpdGgg
dGhlIGltYV9wb2xpY3k9IGJvb3QgcGFyYW1ldGVyLiBUaGlzIGNhbiBiZSBkb25lDQo+ID4gPiA+
IGJ5IGFkZGluZyB0aGUgL2V0Yy9pbWEvaW1hLXBvbGljeSB3aGljaCBhbGxvd3MgbG9hZGluZyB0
aGUgY3VzdG9tIHBvbGljeQ0KPiA+ID4gPiBkdXJpbmcgYm9vdC4gSXQgaXMgYWxzbyBwb3NzaWJs
ZSB0byBsb2FkIGN1c3RvbSBwb2xpY3kgYXQgcnVudGltZQ0KPiA+ID4gPiB0aHJvdWdoDQo+ID4g
PiA+IGZpbGUgb3BlcmF0aW9uczoNCj4gPiA+ID4gDQo+ID4gPiA+IGNwIGN1c3RvbV9pbWFfcG9s
aWN5IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kNCj4gPiA+ID4gY2F0IGN1c3RvbV9p
bWFfcG9saWN5ID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3BvbGljeQ0KPiA+ID4gPiANCj4g
PiA+ID4gb3IgYnkgd3JpdGluZyB0aGUgYWJzb2x1dGUgcGF0aCBvZiB0aGUgZmlsZSBjb250YWlu
aW5nIHRoZSBjdXN0b20NCj4gPiA+ID4gcG9saWN5Og0KPiA+ID4gPiANCj4gPiA+ID4gZWNobyAv
cGF0aC9vZi9jdXN0b21faW1hX3BvbGljeSA+IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xp
Y3kNCj4gPiA+ID4gDQo+ID4gPiA+IEluIHRoZXNlIGNhc2VzLCBmaWxlIHNpZ25hdHVyZSBjYW4g
YmUgbmVjZXNzYXJ5IHRvIGxvYWQgdGhlIHBvbGljeQ0KPiA+ID4gPiAoZnVuYz1QT0xJQ1lfQ0hF
Q0spLiBDdXN0b20gcG9saWN5IGNhbiBhbHNvIGJlIHNldCBhdCBydW50aW1lIGJ5DQo+ID4gPiA+
IGRpcmVjdGx5DQo+ID4gPiA+IHdyaXRpbmcgdGhlIHBvbGljeSBzdHJlYW0gb24gdGhlIGltYSBw
b2xpY3kgZmlsZToNCj4gPiA+ID4gDQo+ID4gPiA+IGVjaG8gLWUgIm1lYXN1cmUgZnVuYz1CUFJN
X0NIRUNLIG1hc2s9TUFZX0VYRUNcbiIgXA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgImF1ZGl0
IGZ1bmM9QlBSTV9DSEVDSyBtYXNrPU1BWV9FWEVDXG4iIFwNCj4gPiA+ID4gwqDCoMKgwqAgPiAv
c3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4gPiA+IA0KPiA+ID4gPiBJbiB0aGlz
IGNhc2UsIHRoZXJlIGlzIG5vIG1lY2hhbmlzbSB0byB2ZXJpZnkgdGhlIGludGVncml0eSBvZiB0
aGUgbmV3DQo+ID4gPiA+IHBvbGljeS4NCj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBhIG5ldyBlbnRy
eSBpbiB0aGUgaW1hIG1lYXN1cmVtZW50cyBsaXN0IGNvbnRhaW5pbmcgdGhlIGFzY2lpIGN1c3Rv
bQ0KPiA+ID4gPiBpbWEgcG9saWN5IGJ1ZmZlciB3aGVuIG5vdCB2ZXJpZmllZCBhdCBsb2FkIHRp
bWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbnJpY28gQnJhdmkgPGVucmlj
by5icmF2aUBwb2xpdG8uaXQ+DQo+ID4gPiANCj4gPiA+IEhpIEVucmljbywNCj4gPiANCj4gPiBI
aSBNaW1pLA0KPiA+IA0KPiA+IHRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLg0KPiA+
IA0KPiA+ID4gVGhpcyBwYXRjaCBzZXQgaGFyZCBjb2RlcyBtZWFzdXJpbmcgdGhlIGluaXRpYWwg
Y3VzdG9tIElNQSBwb2xpY3kgcnVsZXMNCj4gPiA+IHRoYXQNCj4gPiA+IHJlcGxhY2UgdGhlIGJ1
aWx0aW4gcG9saWNpZXMgc3BlY2lmaWVkIG9uIHRoZSBib290IGNvbW1hbmQgbGluZS7CoCBJTUEN
Cj4gPiA+IHNob3VsZG4ndCBoYXJkIGNvZGUgcG9saWN5Lg0KPiA+IA0KPiA+IE15IGZpcnN0IGFw
cHJvYWNoIHdhcyB0byBkZWZpbmUgYSBuZXcgY3JpdGljYWwtZGF0YSByZWNvcmQswqANCg0KSGkg
TWltaSwNCg0KPiBIb3BlZnVsbHkgdGhlIG5ldyBjcml0aWNhbC1kYXRhIHdpbGwgYmUgb2YgdGhl
IGVudGlyZSBJTUEgcG9saWN5Lg0KDQp5ZXMsIGFic29sdXRlbHkuDQoNCj4gPiBidXQgcGVyZm9y
bWluZyB0aGUNCj4gPiBtZWFzdXJlbWVudCBhZnRlciB0aGUgY3VzdG9tIHBvbGljeSBiZWNvbWVz
IGVmZmVjdGl2ZSwgdGhlIG1lYXN1cmVtZW50IGNvdWxkDQo+ID4gYmUNCj4gPiBieXBhc3NlZCBv
bWl0dGluZyBmdW5jPUNSSVRJQ0FMX0RBVEEgaW4gdGhlIGN1c3RvbSBwb2xpY3kuDQo+ID4gDQo+
ID4gPiBJJ20gbm90IHF1aXRlIHN1cmUgd2h5IHlvdSdyZSBkaWZmZXJlbnRpYXRpbmcgYmV0d2Vl
bg0KPiA+ID4gbWVhc3VyaW5nIHRoZSBpbml0aWFsIGFuZCBzdWJzZXF1ZW50IGN1c3RvbSBJTUEg
cG9saWN5IHJ1bGVzLsKgwqANCj4gPiANCj4gPiBNeSBpbnRlbnRpb24gaXMgdG8gbWVhc3VyZSB0
aGUgZmlyc3QgZGlyZWN0IHdyaXRlIChsaW5lIGJ5IGxpbmUpIG9uIHRoZQ0KPiA+IHBvbGljeQ0K
PiA+IGZpbGUsIHdpdGhvdXQgbG9hZGluZyB0aGUgaW5pdGlhbCBjdXN0b20gcG9saWN5IGZyb20g
YSBmaWxlLiBUaGlzIGNhc2UsIGlmDQo+ID4gSSdtDQo+ID4gbm90IHdyb25nLCBpcyBub3QgY292
ZXJlZCBieSBmdW5jPVBPTElDWV9DSEVDSy4NCj4gDQo+IFdoZW4gc2VjdXJlIGJvb3QgaXMgZW5h
YmxlZCwgdGhlIGFyY2ggc3BlY2lmaWMgcG9saWN5IHJ1bGVzIHJlcXVpcmUgdGhlIElNQQ0KPiBw
b2xpY3kgdG8gYmUgc2lnbmVkLsKgIFdpdGhvdXQgc2VjdXJlIGJvb3QgZW5hYmxlZCwgeW91J3Jl
IGNvcnJlY3QuIFRoZSBjdXN0b20NCj4gcG9saWN5IHJ1bGVzIG1heSBkaXJlY3RseSBiZSBsb2Fk
ZWQgd2l0aG91dCBiZWluZyBtZWFzdXJlZC4NCj4gDQo+IFdoeSBvbmx5IG1lYXN1cmUgInRoZSBm
aXJzdCBkaXJlY3Qgd3JpdGUiP8KgIEFkZGl0aW9uYWwgY3VzdG9tIHBvbGljeSBydWxlcyBtYXkN
Cj4gYmUgZGlyZWN0bHkgYXBwZW5kZWQgd2l0aG91dCBiZWluZyBtZWFzdXJlZC4NCg0KWWVzLCB5
b3UgcmlnaHQuIFRoZSBhaW0gd2FzIHRvIG1lYXN1cmUgKGF0IGxlYXN0KSB0aGUgZmlyc3Qgb25l
LCBiZWNhdXNlIGl0DQpzdWJzdGl0dXRlcyB0aGUgYm9vdCBwb2xpY3ksIGJ1dCBpZiB5b3UgYXJl
IG9rIHdpdGggYWRkaW5nIGEgY3JpdGljYWwtZGF0YQ0KcmVjb3JkLCBpdCB3b3VsZCBiZSBkZWZp
bml0ZWx5IGJldHRlci4NCg0KVGhhbmsgeW91LA0KDQpFbnJpY28NCg0KPiA+IA0KPiA+ID4gQ29u
c2lkZXIgZGVmaW5pbmcgYSBuZXcgY3JpdGljYWwtZGF0YSByZWNvcmQgdG8gbWVhc3VyZSB0aGUg
Y3VycmVudCBJTUENCj4gPiA+IHBvbGljeQ0KPiA+ID4gcnVsZXMuwqAgQWxzbyBjb25zaWRlciBp
bmNsdWRpbmcgdGhlIG5ldyBjcml0aWNhbC1kYXRhIHJ1bGUgaW4gdGhlIGFyY2gNCj4gPiA+IHNw
ZWNpZmljIHBvbGljeSBydWxlcy4NCj4gPiANCj4gPiBJIHRoaW5rIHRoYXQgeW91ciBzdWdnZXN0
aW9uLCB0byBhZGQgdGhlIGNyaXRpY2FsLWRhdGEgcnVsZSBpbiB0aGUgYXJjaA0KPiA+IHBvbGlj
eQ0KPiA+IHJ1bGVzLCBzb2x2ZXMgdGhlIHByb2JsZW1zIG9mIGJ5cGFzc2luZyB0aGUgbWVhc3Vy
ZW1lbnQgYW5kIGhhcmQgY29kaW5nDQo+ID4gcG9saWN5Lg0KPiA+IA0KPiA+IFRoYW5rIHlvdSB2
ZXJ5IG11Y2ggZm9yIHlvdXIgZmVlZGJhY2suDQo+IA0KPiBZb3UncmUgd2VsY29tZS4NCj4gDQo+
IE1pbWkNCj4gPiANCg0K


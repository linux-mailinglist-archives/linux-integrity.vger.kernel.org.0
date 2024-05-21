Return-Path: <linux-integrity+bounces-2503-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D678CA8E4
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 09:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE1D281E41
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 07:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC644F5FA;
	Tue, 21 May 2024 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ri00uy1j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE40179BD;
	Tue, 21 May 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276364; cv=fail; b=R0erqBUOycXksr9MpYC4Tx7dRbcyivkifWtqXTtpNWj7DlPFMNd90wwrG1A5E58cDZlusTVivqztgSS9sYsbApbs31PYr3dWC+rl2tYjF++WMAiIzZFjqTl6/zZEJ95j7WJmV4W+Sjxm5GGdlCIZX7KaMs9mt+8pAH25CbrlYg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276364; c=relaxed/simple;
	bh=HdGjusiYP4SxqW5yqG92u8Kadpwf3tJ4ZVLn9JsxWeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nc6OQ6cNCqxLSBD4BM28SoaJB/xR0yZwGphV//ran4l5SIzVNXhoGz/Khmew9twmzOqpGooNMl5VPx6yOEfDBnaa3s57l2B6DnAYbNKQZdhKIFZjSbhwqXS9eZsJsSui568Tn//jynGwuL9Q8JybptLofqZq18oTNzALgGOtGUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ri00uy1j; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L1uIZf016449;
	Tue, 21 May 2024 00:25:41 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y6uuj84w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 00:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcyF0ImzChE0e8vtMJPJm+vZISJEBOYqydWNH57PQHbjRwbu/1bYDNgWALIXo6Rc1AwhVNRd+M0Jm9JZ71JURNmeIChTSSvDlbKe9WcZFzdy/y2bdoLVig4bHNJZ082YMx0N/NAetAPqT5z4IgJ2rC9+dM/3/5oJHmVf4bmOwm+NOAqXPnMn8fvM8gL5jF6t/YbW8svKT+/GtpO4H+DZsMXIoETrqr/6FbO8ddg1TD2jiE6shi58+5KW09RNbiTzrQG3ryw566rHGgBD6Swm1TYo6KSRTl53p+Zzo8Yc5+Hi6/auxdFrjmwZB9V8iwL4kv1vOZkOBWM3+v6hr9jHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBRc+o+jZY9y3N3sUm4L0Y2pCg0IwMqStBJDTIsaOKM=;
 b=C9mX+yRgJihqD4k3KbyHCkL63X+g7k7QW2SxWJqL572nD7M2bAndFXyvuEEmFdhcA4ThOMCI6kqsetgeOtENaOkdSjALacIWKbkBN9VEJRpDg5v+rSteKXhNBl7DgmvLUuK2T7MI2nHDwnozLTRiu7zVk2cZA5fmehmsQStvmxss4XugvJy0fBXK2BxEE8+vdxvONe1rfcertur4RyCkjgk15XpeN/MyeupjWQiHqYoTT/BLNfJibF3a8Fzx8e3F8LE2MRVmAuYqmOYxq451aKg3z9h9JV3+1zwl0BUjR/WqksmdHdJ5OExfSdVzAC/dwIVKTGwX35u7WWyFgkUS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBRc+o+jZY9y3N3sUm4L0Y2pCg0IwMqStBJDTIsaOKM=;
 b=Ri00uy1jqzvag572NQdTYtPRD+DMnXLQeFSdxdptQNgyx5rqr59P/zIqHU9WfGKK/r/L+RIGTCgfBP/R/ME4VgRDaP8jZTeYkOIK8q7VGVNOmMWaJzTLuDaAxYzAcl9lATnFvnq8LN3EYHP2XvErn3cvh19rhCHBHnZP3CGD+aU=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by CH4PR18MB6237.namprd18.prod.outlook.com (2603:10b6:610:22d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 21 May
 2024 07:25:36 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7544.041; Tue, 21 May 2024
 07:25:36 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu
	<herbert@gondor.apana.org.au>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "Andreas.Fuchs@infineon.com" <Andreas.Fuchs@infineon.com>,
        James Prestwood
	<prestwoj@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers
	<ebiggers@kernel.org>,
        James Bottomley
	<James.Bottomley@hansenpartnership.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        David Howells
	<dhowells@redhat.com>,
        James Bottomley
	<James.Bottomley@HansenPartnership.com>,
        Stefan Berger
	<stefanb@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mario Limonciello
	<mario.limonciello@amd.com>
Subject: RE: [EXTERNAL] [PATCH v2 6/6] keys: asymmetric:
 ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
Thread-Topic: [EXTERNAL] [PATCH v2 6/6] keys: asymmetric:
 ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
Thread-Index: AQHaqy2qhLHCZ9Oxa0KqLaOtRBBkjLGhSCzg
Date: Tue, 21 May 2024 07:25:36 +0000
Message-ID: 
 <SN7PR18MB531494159D3996799475209DE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-7-jarkko@kernel.org>
In-Reply-To: <20240521031645.17008-7-jarkko@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|CH4PR18MB6237:EE_
x-ms-office365-filtering-correlation-id: e9ed52d0-1b5e-4ec2-41b4-08dc7967354c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?W12PNAbLXGgD7M21dT81bgWZHv/GbqnHUYCEwF8hgsWwubApw96JMmkxLjHN?=
 =?us-ascii?Q?caFtXv18qnM/+/6RiAo8NgWTss2C08NwZPqNUnuHRBrr2QIvVIfe3JWC4i3U?=
 =?us-ascii?Q?nLkQKjj4uy9Efwo8LZ0BWNv5OazkKxmzmG+IHCVt4/0q67nFsH78zyCnCgEE?=
 =?us-ascii?Q?geOdQk6GdfBXhSKxGeqkOWm034rHaEMNG/jx68/dZ8OTq9RW6E71rZyfMKP/?=
 =?us-ascii?Q?fUK4m4iD8Ygd5/HimyE5xFMnpR2wk3158FzrBVONhMAiAXWP/PEblliu9mQi?=
 =?us-ascii?Q?GOo8QAwa1iv1++0Qk6Vl/CBW4nW4EVEcyaUBcBbkCbkkPWGRxAOzXD7NrM8Y?=
 =?us-ascii?Q?4LZ5VYUzMLxnMZMLXIHsMtInMhS7waT0rfe994D1sxoWk5kCxmF9fF1tVkw2?=
 =?us-ascii?Q?JEnBrwTq/RLmFThHgEEWm+SM51CB/muO1oExlPuwTh8TVija+/Ls23OQvWjm?=
 =?us-ascii?Q?x68FYQqoIuE0IOHJpnkgoQWQQDlYvw1kQffsq4tVoL0H36hRlstfT2w68EYK?=
 =?us-ascii?Q?YYtYLNvuQGWWNAN6wHIBF5rAeGfCTqyQE/AOeBF+mzFlz5IlJVFMYEakRMx/?=
 =?us-ascii?Q?pCdu/PELvfrmSVlclXo/PN1f02Aavem80k8VlWUVmdpLjGoD0XJftsqL/NnC?=
 =?us-ascii?Q?f+YokUa2izLNLsBP+I+7D9jjfezfxCW02GgoXuK9AAwKQCETjnRi0JlGdeTI?=
 =?us-ascii?Q?Teedu5k9WXyZwAfUQl/pw7t/vH4mVyovgk4UVquwtgnTGRczUN+ZknI0ugeK?=
 =?us-ascii?Q?DGyQbYdydJtXxUmtmNzALEKlMK5gob7t8/rHl85dEOgsWcq/c1g4GXcOvuoB?=
 =?us-ascii?Q?Eb4b+ykmipsvX4I8PXtSEjAJjJE+QPo4RxYcl60lv8JQDQ7uPZ/iHlYk1Znu?=
 =?us-ascii?Q?NiO5FnHgadYnpLHCa1YKIM8aaLqCtlVvnMbn7ObuEnIQ9OnSh7HXZ1Mxgfw1?=
 =?us-ascii?Q?UMrD0eBIUGy3ZBOarzY4CY4ukeiDipMtperJwJYQuQHyRGtv50OrkqVtsW50?=
 =?us-ascii?Q?5tcGeWdfWpQEg2EmSILReh9CpqbT5n6g3qePoe4ham3ayIVDCC09XkNx0aqd?=
 =?us-ascii?Q?Ohay0h3uPh6F47S9TzrjNnYVwQpKIyHiBw/0FwlQXd1DDFl4AwZ3F9h3dlrc?=
 =?us-ascii?Q?7qQxQz7anMw4HTPm9VZ4OVyaW0/7xmvmPFvLQEgKbKcklpnFHt7KABf1IpF3?=
 =?us-ascii?Q?A2gUvld+Aj7jxLMSQFJwtBR2zHJIL8uV7Skxd4AkpNeeCqj2x9V5cjHtd/Ta?=
 =?us-ascii?Q?wUh5NPZcgR7v8INk+E66qJ9SQDl8sVqCNIWQpNDjPw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7Sl/lqvNubSBou7a2U4SE1dcDYqsTvOnWAyAtGTbXRYezSjQIOC5cK9uOf6R?=
 =?us-ascii?Q?+koIT/F7B8C2LO/yp1X41O542DUhMeHiNJeWxRcxhgzg/NLC+L5M0ESkPMZV?=
 =?us-ascii?Q?Ce/uIvE6wSRNnCclsJ0vOIDhgCC8xYc7OFnTY45lbC/FGUwVTgFCW7LKgFHA?=
 =?us-ascii?Q?O+2FAKOb+gETvkLsfOG/V3CQ1gvF1HBnL746wb96PPdnxYvPZTke2Rz+ZpC1?=
 =?us-ascii?Q?Q+gkr5yH/DLIJytpOnueFQncgZ4sBrXJSc3BXFrK2UiyVzY1RHo++UssqcLD?=
 =?us-ascii?Q?zgilhHEVIjTTSvCQGf6dmCQ15OXrVQNRrBSWv+qilaH2OHAJ+p13Yc0VB1Td?=
 =?us-ascii?Q?usz+Y4EphTpePTeAW/42yUOUk0zsa2WRCLODqsmjohaLaFB7m1iWitog5Uz2?=
 =?us-ascii?Q?29DtI8Rz3oPSjI4LamTtfIoE2eMH7DV/xk7GaEieRnY+H8Ak9Uj7e4hRZJvn?=
 =?us-ascii?Q?YprqOrHwlmZ+RgrSJjjvqeIzKURi76bC4L+evWoCstSRE8rak+Xx2PJCt4X3?=
 =?us-ascii?Q?0OHOTht2vgb7SoPFlYoBIFLSTcjqRW4CFlDWZ5fQYHO6fQgp90kFhup6FWR3?=
 =?us-ascii?Q?/iia9IVs49EZV3vnmMStmNLpul/E3t6VodHIe0QoWNiGd70wgsjaG43Y6p55?=
 =?us-ascii?Q?HuBJmjhQAocg5QcFtOEZq1Y6QmkR9T6GESZrTJy+r2+mfU3lsHNZh9w7cif5?=
 =?us-ascii?Q?HKhDXs7WdSsuaAHeJUHeGxoPHjcoVmL7Y6rkYe1gGa+dEiKeXP14FmG3ObGG?=
 =?us-ascii?Q?NEferHXyTe4vrESL3IAmrfnPDAaIghb6yK4JozZVjSBIfda5psw9f1FYuv1m?=
 =?us-ascii?Q?kF8PC+HXsgwMsmiazxITke9SeL9RCmekEAYmXs7+Z9yNEP2gecOamHyPfy2u?=
 =?us-ascii?Q?UtxiQkIPY2vFcKLmYTGSPV5ep9/aZztIntJ7Ym/hERhushMX54BkyKfYAyoo?=
 =?us-ascii?Q?cRPfBSnRhX5enbieQ2KOxJMmDFKB4ZvoWsry/BQiLF6/4L8fR+r0jAXo9f07?=
 =?us-ascii?Q?g36orSKmfPkuO7/OwGoqIpuoPRFgQTaFUzgqIX9q+NYg7Ptg0dt0PNghkSLy?=
 =?us-ascii?Q?WBZkR0RobCjBtPnCKJCH40qHjamcJwngCIaXCKM5VEvyaCuNJvlgeI+m3ZbK?=
 =?us-ascii?Q?3oMQPLRnEXN+eYCx3rUxDbTuuSQzEKKBdi20/6L6dZI+piEdavq0SBYRlM+n?=
 =?us-ascii?Q?juCezMBH2iSI+n/mp7o+zuo5GzDdZxS2GuqQ8TlxEiY4is0zOlYMdqsmeRSg?=
 =?us-ascii?Q?llYGD4xMayLmGm8HaVxblGzDf4aB/oe9baRo4U44yYOIuXWubpZ5ZUIqFPwn?=
 =?us-ascii?Q?ZAg7WFZhAaNELdSD4ycuJj/jn7g/JoTb+RrlNLRoXbs0hy9HIqymmPuuNF5i?=
 =?us-ascii?Q?/OSv5Qfi/vZoMK+KBB9O81CaZcg+l6i4vcM0poG6L/B+p7/ZjeFKEBhJpmA6?=
 =?us-ascii?Q?l0rRgG0JfAATJWfm4GJk90p3OBIFrY3Bvpq3rXTxok1g1gKVQI+ThbMtXyyk?=
 =?us-ascii?Q?2PQCyf9MM0hotMt8xfZfuyzhYHvK9u1Jssi6xnRxxAaNAPyU4j3H9LvRj5oO?=
 =?us-ascii?Q?t4kGMJOVukf62io81Ihf2SsyqQEJemF5DW05tVIX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ed52d0-1b5e-4ec2-41b4-08dc7967354c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:25:36.2077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KO8w/bPVfSPDUXAye3zcWwcfcxWi4D+Dc4/GMNAecTRmqYrPJdI1Wqd2mYJhnZbYMx1ywL6lkD8pCxYWq1paFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6237
X-Proofpoint-GUID: cRUtVXwqqNL2IInI94ATlTAZ3rAKOhuq
X-Proofpoint-ORIG-GUID: cRUtVXwqqNL2IInI94ATlTAZ3rAKOhuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_04,2024-05-21_01,2024-05-17_01



> -----Original Message-----
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: Tuesday, May 21, 2024 8:47 AM
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-integrity@vger.kernel.org; keyrings@vger.kernel.org;
> Andreas.Fuchs@infineon.com; James Prestwood <prestwoj@gmail.com>;
> David Woodhouse <dwmw2@infradead.org>; Eric Biggers
> <ebiggers@kernel.org>; James Bottomley
> <James.Bottomley@hansenpartnership.com>; Jarkko Sakkinen
> <jarkko@kernel.org>; David S. Miller <davem@davemloft.net>; open
> list:CRYPTO API <linux-crypto@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>; David Howells <dhowells@redhat.com>; James
> Bottomley <James.Bottomley@HansenPartnership.com>; Stefan Berger
> <stefanb@linux.ibm.com>; Ard Biesheuvel <ardb@kernel.org>; Mario
> Limonciello <mario.limonciello@amd.com>
> Subject: [EXTERNAL] [PATCH v2 6/6] keys: asymmetric:
> ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
>=20
> ----------------------------------------------------------------------
> From: James Prestwood <prestwoj@gmail.com>
>=20
> Based on earlier work by James Prestwood.
>=20
> Add ASN.1 compatible asymmetric TPM2 RSA key subtype:
>=20
> 1. Signing and decryption (with the private key) is handled by
>    TPM2_RSA_Decrypt.
> 2. Encryption (with the public key) is handled by the kernel RSA
>    implementation.
>=20
> Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_all_20200518172704.29608-2D1-2Dprestwoj-
> 40gmail.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DPAAlWswPe7d8
> gHlGbCLmy2YezyK7O3Hv_t2heGnouBw&m=3DOMixrhGWcekpXpja15IeSeghOU
> 4mBNCZOSB2Vgtzbn7xcodoWU_Hnnpzp_eZh-
> XR&s=3DpKVMCPyvi19wJur3Bzq2xo3MtPHsEicDLBGr--NWRjs&e=3D
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> * Remove two spurios pr_info() messsages that I forgot to remove.
> * Clean up padding functions and add additional checks for length
>   also in tpm2_unpad_pcks1().
> * Add the missing success check kzalloc() in tpm2_key_rsa_decrypt().
> * Check that params->out_len for capacity before copying the result.
> ---
>  crypto/asymmetric_keys/Kconfig        |  16 +
>  crypto/asymmetric_keys/Makefile       |   1 +
>  crypto/asymmetric_keys/tpm2_key_rsa.c | 698
> ++++++++++++++++++++++++++
>  include/linux/tpm.h                   |   2 +
>  4 files changed, 717 insertions(+)
>  create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
>=20
> diff --git a/crypto/asymmetric_keys/Kconfig
> b/crypto/asymmetric_keys/Kconfig
> index e1345b8f39f1..4d14bb0c346e 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -15,6 +15,7 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>  	select MPILIB
>  	select CRYPTO_HASH_INFO
>  	select CRYPTO_AKCIPHER
> +	select CRYPTO_RSA
>  	select CRYPTO_SIG
>  	select CRYPTO_HASH
>  	help
> @@ -23,6 +24,21 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>  	  appropriate hash algorithms (such as SHA-1) must be available.
>  	  ENOPKG will be reported if the requisite algorithm is unavailable.
>=20
> +config ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
> +	tristate "Asymmetric TPM2 RSA crypto algorithm subtype"
> +	depends on TCG_TPM
> +	select TCG_TPM2_HMAC
> +	select CRYPTO_RSA
> +	select CRYPTO_SHA256
> +	select CRYPTO_HASH_INFO
> +	select ASN1
> +	select ASN1_ENCODER
> +	help
> +	  This option provides support for asymmetric TPM2 key type
> handling.
> +	  If signature generation and/or verification are to be used,
> +	  appropriate hash algorithms (such as SHA-256) must be available.
> +	  ENOPKG will be reported if the requisite algorithm is unavailable.
> +
>  config X509_CERTIFICATE_PARSER
>  	tristate "X.509 certificate parser"
>  	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> diff --git a/crypto/asymmetric_keys/Makefile
> b/crypto/asymmetric_keys/Makefile
> index bc65d3b98dcb..c6da84607824 100644
> --- a/crypto/asymmetric_keys/Makefile
> +++ b/crypto/asymmetric_keys/Makefile
> @@ -11,6 +11,7 @@ asymmetric_keys-y :=3D \
>  	signature.o
>=20
>  obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) +=3D public_key.o
> +obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE) +=3D tpm2_key_rsa.o
>=20
>  #
>  # X.509 Certificate handling
> diff --git a/crypto/asymmetric_keys/tpm2_key_rsa.c
> b/crypto/asymmetric_keys/tpm2_key_rsa.c
> new file mode 100644
> index 000000000000..32250ff38268
> --- /dev/null
> +++ b/crypto/asymmetric_keys/tpm2_key_rsa.c
> @@ -0,0 +1,698 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* TPM2 asymmetric public-key crypto subtype
> + *
> + * See Documentation/crypto/asymmetric-keys.rst
> + *
> + * Copyright (c) 2020 Intel Corporation
> + */
> +
> +#include <asm/unaligned.h>
> +#include <crypto/akcipher.h>
> +#include <crypto/public_key.h>
> +#include <crypto/rsa-pkcs1pad.h>
> +#include <crypto/tpm2_key.h>
> +#include <keys/asymmetric-parser.h>
> +#include <keys/asymmetric-subtype.h>
> +#include <keys/trusted-type.h>
> +#include <linux/asn1_encoder.h>
> +#include <linux/keyctl.h>
> +#include <linux/module.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/tpm.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "tpm2_key_rsa: "fmt
> +
> +#define PUB_KEY_BUF_SIZE 512
> +
> +struct tpm2_key_rsa {
> +	struct tpm2_key key;
> +	const u8 *pub;
> +	int pub_len;
> +};
> +
> +static const int PKCS1_PAD_MIN_SIZE =3D 11;
> +
> +/*
> + * Fill the data with PKCS#1 v1.5 padding.
> + */
> +static int tpm2_pad_pkcs1(const u8 *in, int in_len, u8 *out, int out_len=
)
> +{
> +	unsigned int prefix_len =3D out_len - in_len - 3;
> +
> +	if (in_len > out_len - PKCS1_PAD_MIN_SIZE)
> +		return -EBADMSG;
> +
> +	/* prefix */
> +	out[0] =3D 0;
> +	out[1] =3D 1;
> +	memset(&out[2], 0xff, prefix_len);
> +	out[2 + prefix_len] =3D 0;
> +	/* payload */
> +	memcpy(&out[2 + prefix_len + 1], in, in_len);
> +
> +	return 0;
> +}
> +
> +/*
> + * RFC 3447 - Section 7.2.2
> + * Size of the input data should be checked against public key size by
> + * the caller.
> + */
> +static const u8 *tpm2_unpad_pkcs1(const u8 *in, int in_len, int *out_len=
)
> +{
> +	int i;
> +
> +	if (in[0] !=3D 0 || in[1] !=3D 2)
> +		return NULL;
> +
> +	i =3D 2;
> +	while (in[i] !=3D 0 && i < in_len)
> +		i++;
> +
> +	if (i =3D=3D in_len || i < (PKCS1_PAD_MIN_SIZE - 1))
> +		return NULL;
> +
> +	*out_len =3D in_len - i - 1;
> +	return in + i + 1;
> +}
> +
> +/*
> + * Outputs the cipher algorithm name on success, and retuns -ENOPKG
> + * on failure.
> + */
> +static int tpm2_key_get_akcipher(const char *encoding, const char
> *hash_algo,
> +				 char *cipher)
> +{
> +	ssize_t ret;
> +
> +	if (strcmp(encoding, "pkcs1") =3D=3D 0) {
> +		if (!hash_algo) {
> +			strcpy(cipher, "pkcs1pad(rsa)");
> +			return 0;
> +		}
> +
> +		ret =3D snprintf(cipher, CRYPTO_MAX_ALG_NAME,
> +			       "pkcs1pad(rsa,%s)",
> +			       hash_algo);
> +		if (ret >=3D CRYPTO_MAX_ALG_NAME)
> +			return -ENOPKG;
> +
> +		return 0;
> +	}
> +
> +	if (strcmp(encoding, "raw") =3D=3D 0) {
> +		strcpy(cipher, "rsa");
> +		return 0;
> +	}
> +
> +	return -ENOPKG;
> +}
> +
> +static int tpm2_key_rsa_extract_pub(struct tpm2_key_rsa *key_rsa)
> +{
> +	struct tpm2_key *key =3D &key_rsa->key;
> +	struct tpm_buf buf;
> +	off_t offset =3D 2;
> +	u16 policy_len;
> +	u32 attr;
> +	u16 bits;
> +	u16 type;
> +	u16 len;
> +	u16 alg;
> +	u32 exp;
> +
> +	buf.flags =3D TPM_BUF_TPM2B;
> +	buf.length =3D key->pub_len;
> +	buf.data =3D (void *)key->pub;
> +
> +	if (get_unaligned_be16(key->pub) !=3D buf.length - 2)
> +		return -EINVAL;
> +
> +	type =3D tpm_buf_read_u16(&buf, &offset);
> +	pr_debug("pub type: 0x%04x\n", type);
> +	if (type !=3D TPM_ALG_RSA)
> +		return -EINVAL;
> +
> +	alg =3D tpm_buf_read_u16(&buf, &offset);
> +	pr_debug("pub name alg: 0x%04x\n", alg);
> +	attr =3D tpm_buf_read_u32(&buf, &offset);
> +	pr_debug("pub attributes: 0x%08x\n", attr);
> +	policy_len =3D tpm_buf_read_u16(&buf, &offset);
> +	pr_debug("pub policy length: %u bytes\n", policy_len);
> +	offset +=3D policy_len;
> +
> +	alg =3D tpm_buf_read_u16(&buf, &offset);
> +	pr_debug("pub symmetric: 0x%04x\n", alg);
> +	if (alg !=3D TPM_ALG_NULL)
> +		return -EINVAL;
> +
> +	alg =3D tpm_buf_read_u16(&buf, &offset);
> +	pr_debug("pub symmetric scheme: 0x%04x\n", alg);
> +	if (alg !=3D TPM_ALG_NULL)
> +		return -EINVAL;
> +
> +	bits =3D tpm_buf_read_u16(&buf, &offset);
> +	pr_debug("pub bits: %u\n", bits);
> +
> +	exp =3D tpm_buf_read_u32(&buf, &offset);
> +	pr_debug("pub exponent: 0x%08x\n", exp);
> +	if (exp !=3D 0x00000000 && exp !=3D  0x00010001)
> +		return -EINVAL;
> +
> +	len =3D tpm_buf_read_u16(&buf, &offset);
> +	pr_debug("pub modulus: %u bytes\n", len);
> +	key_rsa->pub =3D key->pub + offset;
> +	key_rsa->pub_len =3D len;
> +
> +	return buf.flags & TPM_BUF_BOUNDARY_ERROR ? -EIO : 0;
> +}
> +
> +static int tpm2_key_rsa_encode(const struct tpm2_key_rsa *key, u8 *buf)
> +{
> +	const int SCRATCH_SIZE =3D PAGE_SIZE;
> +	const u8 exp[3] =3D {1, 0, 1};
> +	u8 *scratch, *work, *work1, *end_work;
> +	int pub_len =3D key->pub_len;
> +	const u8 *pub =3D key->pub;
> +	int ret;
> +
> +	scratch =3D kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> +	if (!scratch)
> +		return -ENOMEM;
> +
> +	work =3D scratch;
> +	end_work =3D &scratch[SCRATCH_SIZE];
> +
> +	work =3D asn1_encode_integer(work, end_work, pub, pub_len);
> +	if (IS_ERR(work)) {
> +		ret =3D PTR_ERR(work);
> +		goto err;
> +	}
> +
> +	work =3D asn1_encode_integer(work, end_work, exp, 3);
> +	if (IS_ERR(work)) {
> +		ret =3D PTR_ERR(work);
> +		goto err;
> +	}
> +
> +	work1 =3D buf;
> +	work1 =3D asn1_encode_sequence(work1,
> &work1[PUB_KEY_BUF_SIZE],
> +				     scratch, work - scratch);
> +	if (IS_ERR(work1)) {
> +		ret =3D PTR_ERR(work1);
> +		goto err;
> +	}
> +
> +	memset(work1, 0, 8);
> +
> +	kfree(scratch);
> +	return work1 - buf;
> +
> +err:
> +	kfree(scratch);
> +	return ret;
> +}
> +
> +/*
> + * Encryption operation is performed with the public key.  Hence it is d=
one
> + * in software
> + */
> +static int tpm2_key_rsa_encrypt(struct tpm2_key_rsa *key,
> +				struct kernel_pkey_params *params,
> +				const void *in, void *out)
> +{
> +	char cipher[CRYPTO_MAX_ALG_NAME];
> +	struct scatterlist in_sg, out_sg;
> +	u8 enc_pub_key[PUB_KEY_BUF_SIZE];
> +	struct akcipher_request *req;
> +	struct crypto_akcipher *tfm;
> +	struct crypto_wait cwait;
> +	int rc;
> +
> +	rc =3D tpm2_key_get_akcipher(params->encoding, params->hash_algo,
> cipher);
> +	if (rc < 0)
> +		return rc;
> +
> +	tfm =3D crypto_alloc_akcipher(cipher, 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +
> +	rc =3D tpm2_key_rsa_encode(key, enc_pub_key);
> +	if (rc < 0)
> +		goto err_tfm;
> +
> +	rc =3D crypto_akcipher_set_pub_key(tfm, enc_pub_key, rc);
> +	if (rc < 0)
> +		goto err_tfm;
> +
> +	req =3D akcipher_request_alloc(tfm, GFP_KERNEL);
> +	if (!req) {
> +		rc =3D -ENOMEM;
> +		goto err_tfm;
> +	}
> +
> +	sg_init_one(&in_sg, in, params->in_len);
> +	sg_init_one(&out_sg, out, params->out_len);
> +	akcipher_request_set_crypt(req, &in_sg, &out_sg, params->in_len,
> +				   params->out_len);
> +
> +	crypto_init_wait(&cwait);
> +	akcipher_request_set_callback(req,
> CRYPTO_TFM_REQ_MAY_BACKLOG |
> +				      CRYPTO_TFM_REQ_MAY_SLEEP,
> +				      crypto_req_done, &cwait);
> +
> +	rc =3D crypto_akcipher_encrypt(req);
> +	rc =3D crypto_wait_req(rc, &cwait);
> +

Few Minor comments,=20
Extra line here=20

> +	if (!rc)
> +		rc =3D req->dst_len;
> +
> +	akcipher_request_free(req);
> +
> +err_tfm:
> +	crypto_free_akcipher(tfm);
> +
> +	return rc;
> +}
> +
> +static int __tpm2_key_rsa_decrypt(struct tpm_chip *chip,
> +				  struct tpm2_key_rsa *key,
> +				  struct kernel_pkey_params *params,
> +				  const void *in, int in_len, void *out)
> +{
> +	unsigned int offset =3D 0;
> +	u32 key_handle =3D 0;
> +	struct tpm_buf buf;
> +	u16 decrypted_len;
> +	u32 parent;
> +	u8 *pos;
> +	int ret;
> +
> +	ret =3D tpm_try_get_ops(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tpm2_start_auth_session(chip);
> +	if (ret)
> +		goto err_ops;
> +
> +	if (key->key.parent =3D=3D TPM2_RH_NULL) {
> +		ret =3D tpm2_load_context(chip, chip->null_key_context,
> &offset,
> +					&parent);
> +		if (ret) {
> +			ret =3D -EIO;
> +			goto err_auth;
> +		}
> +	} else {
> +		parent =3D key->key.parent;
> +	}

Do we need braces here?

> +
> +	ret =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
> +	if (ret < 0)
> +		goto err_parent;
> +
> +	tpm_buf_append_name(chip, &buf, parent, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf,
> TPM2_SA_CONTINUE_SESSION |
> +				    TPM2_SA_ENCRYPT, NULL, 0);
> +	tpm_buf_append(&buf, key->key.blob, key->key.blob_len);
> +	if (buf.flags & TPM_BUF_OVERFLOW) {
> +		ret =3D -E2BIG;
> +		goto err_buf;
> +	}
> +	tpm_buf_fill_hmac_session(chip, &buf);
> +	ret =3D tpm_transmit_cmd(chip, &buf, 4, "RSA key loading");
> +	ret =3D tpm_buf_check_hmac_response(chip, &buf, ret);
> +	if (ret) {
> +		ret =3D -EIO;
> +		goto err_buf;
> +	}
> +	key_handle =3D be32_to_cpup((__be32
> *)&buf.data[TPM_HEADER_SIZE]);
> +
> +	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_RSA_DECRYPT);
> +	tpm_buf_append_name(chip, &buf, key_handle, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
> NULL, 0);
> +	tpm_buf_append_u16(&buf, in_len);
> +	tpm_buf_append(&buf, in, in_len);
> +	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
> +	tpm_buf_append_u16(&buf, 0);
> +	tpm_buf_fill_hmac_session(chip, &buf);
> +	ret =3D tpm_transmit_cmd(chip, &buf, 4, "RSA key decrypting");
> +	ret =3D tpm_buf_check_hmac_response(chip, &buf, ret);
> +	if (ret) {
> +		ret =3D -EIO;
> +		goto err_blob;
> +	}
> +
> +	pos =3D buf.data + TPM_HEADER_SIZE + 4;
> +	decrypted_len =3D be16_to_cpup((__be16 *)pos);
> +	pos +=3D 2;
> +
> +	if (params->out_len < decrypted_len) {
> +		ret =3D -EMSGSIZE;
> +		goto err_blob;
> +	}
> +
> +	memcpy(out, pos, decrypted_len);
> +	ret =3D decrypted_len;
> +
> +err_blob:
> +	tpm2_flush_context(chip, key_handle);
> +
> +err_buf:
> +	tpm_buf_destroy(&buf);
> +
> +err_parent:
> +	if (key->key.parent =3D=3D TPM2_RH_NULL)
> +		tpm2_flush_context(chip, parent);
> +
> +err_auth:
> +	if (ret < 0)
> +		tpm2_end_auth_session(chip);
> +
> +err_ops:
> +	tpm_put_ops(chip);
> +	return ret;
> +}
> +
> +static int tpm2_key_rsa_decrypt(struct tpm_chip *chip, struct tpm2_key_r=
sa
> *key,
> +				struct kernel_pkey_params *params,
> +				const void *in, void *out)
> +{
> +	const u8 *ptr;
> +	int out_len;
> +	u8 *work;
> +	int ret;
> +
> +	work =3D kzalloc(params->out_len, GFP_KERNEL);
> +	if (!work)
> +		return -ENOMEM;

Maybe use ERR_PTR() here and couple of more places

> +
> +	ret =3D __tpm2_key_rsa_decrypt(chip, key, params, in, params->in_len,
> +				     work);
> +	if (ret < 0)
> +		goto err;
> +
> +	ptr =3D tpm2_unpad_pkcs1(work, ret, &out_len);
> +	if (!ptr) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	if (out_len > params->out_len) {
> +		ret =3D -EMSGSIZE;
> +		goto err;
> +	}
> +
> +	memcpy(out, ptr, out_len);
> +	kfree(work);
> +	return out_len;
> +
> +err:
> +	kfree(work);
> +	return ret;
> +}
> +
> +/*
> + * Sign operation is an encryption using the TPM's private key. With RSA=
 the
> + * only difference between encryption and decryption is where the paddin=
g
> goes.
> + * Since own padding can be used, TPM2_RSA_Decrypt can be repurposed to
> do
> + * encryption.
> + */
> +static int tpm2_key_rsa_sign(struct tpm_chip *chip, struct tpm2_key_rsa
> *key,
> +			     struct kernel_pkey_params *params,
> +			     const void *in, void *out)
> +{
> +	const struct rsa_asn1_template *asn1;
> +	u32 in_len =3D params->in_len;
> +	void *asn1_wrapped =3D NULL;
> +	int pub_len =3D key->pub_len;
> +	u8 *padded;
> +	int ret;
> +
> +	if (strcmp(params->encoding, "pkcs1") !=3D 0) {
> +		ret =3D -ENOPKG;
> +		goto err;
> +	}
> +
> +	if (params->hash_algo) {
> +		asn1 =3D rsa_lookup_asn1(params->hash_algo);
> +		if (!asn1) {
> +			ret =3D -ENOPKG;
> +			goto err;
> +		}
> +
> +		/* Request enough space for the ASN.1 template + input hash
> */
> +		asn1_wrapped =3D kzalloc(in_len + asn1->size, GFP_KERNEL);
> +		if (!asn1_wrapped) {
> +			ret =3D -ENOMEM;
> +			goto err;
> +		}
> +
> +		/* Copy ASN.1 template, then the input */
> +		memcpy(asn1_wrapped, asn1->data, asn1->size);
> +		memcpy(asn1_wrapped + asn1->size, in, in_len);
> +
> +		in =3D asn1_wrapped;
> +		in_len +=3D asn1->size;
> +	}
> +
> +	/* with padding: */
> +	padded =3D kmalloc(pub_len, GFP_KERNEL);
> +	tpm2_pad_pkcs1(in, in_len, padded, pub_len);
> +	ret =3D __tpm2_key_rsa_decrypt(chip, key, params, padded, pub_len,
> out);
> +	kfree(padded);
> +
> +err:
> +	kfree(asn1_wrapped);
> +	return ret;
> +}
> +
> +static void tpm2_key_rsa_describe(const struct key *asymmetric_key,
> +				  struct seq_file *m)
> +{
> +	struct tpm2_key_rsa *key =3D asymmetric_key-
> >payload.data[asym_crypto];
> +
> +	if (!key) {
> +		pr_err("key blob missing");
> +		return;
> +	}
> +
> +	seq_puts(m, "TPM2/RSA");
> +}
> +
> +static void tpm2_key_rsa_destroy(void *payload0, void *payload3)
> +{
> +	struct tpm2_key *key =3D payload0;
> +
> +	if (!key)
> +		return;
> +
> +	tpm2_key_destroy(key);
> +	kfree(key);
> +}
> +
> +static int tpm2_key_rsa_eds_op(struct kernel_pkey_params *params,
> +			       const void *in, void *out)
> +{
> +	struct tpm2_key_rsa *key =3D params->key-
> >payload.data[asym_crypto];
> +	struct tpm_chip *chip =3D tpm_default_chip();
> +
> +	if (!chip)
> +		return -ENODEV;
> +
> +	switch (params->op) {
> +	case kernel_pkey_encrypt:
> +		return tpm2_key_rsa_encrypt(key, params, in, out);
> +	case kernel_pkey_decrypt:
> +		return tpm2_key_rsa_decrypt(chip, key, params, in, out);
> +	case kernel_pkey_sign:
> +		return tpm2_key_rsa_sign(chip, key, params, in, out);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int tpm2_key_rsa_verify(const struct key *key,
> +			       const struct public_key_signature *sig)
> +{
> +	const struct tpm2_key_rsa *tpm2_key =3D key-
> >payload.data[asym_crypto];
> +	char alg_name[CRYPTO_MAX_ALG_NAME];
> +	u8 enc_pub_key[PUB_KEY_BUF_SIZE];
> +	struct akcipher_request *req;
> +	struct scatterlist src_sg[2];
> +	struct crypto_akcipher *tfm;
> +	struct crypto_wait cwait;
> +	int rc;
> +
> +	if (!sig->digest)
> +		return -ENOPKG;
> +
> +	rc =3D tpm2_key_get_akcipher(sig->encoding, sig->hash_algo,
> alg_name);
> +	if (rc < 0)
> +		return rc;
> +
> +	tfm =3D crypto_alloc_akcipher(alg_name, 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +
> +	rc =3D tpm2_key_rsa_encode(tpm2_key, enc_pub_key);
> +	if (rc < 0)
> +		goto err_tfm;
> +
> +	rc =3D crypto_akcipher_set_pub_key(tfm, enc_pub_key, rc);
> +	if (rc < 0)
> +		goto err_tfm;
> +
> +	rc =3D -ENOMEM;
> +	req =3D akcipher_request_alloc(tfm, GFP_KERNEL);
> +	if (!req)
> +		goto err_tfm;
> +
> +	sg_init_table(src_sg, 2);
> +	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
> +	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> +	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
> +				   sig->digest_size);
> +	crypto_init_wait(&cwait);
> +	akcipher_request_set_callback(req,
> CRYPTO_TFM_REQ_MAY_BACKLOG |
> +				      CRYPTO_TFM_REQ_MAY_SLEEP,
> +				      crypto_req_done, &cwait);
> +	rc =3D crypto_wait_req(crypto_akcipher_verify(req), &cwait);
> +
> +	akcipher_request_free(req);
> +
> +err_tfm:
> +	crypto_free_akcipher(tfm);
> +	return rc;
> +}
> +
> +static int tpm2_key_rsa_query(const struct kernel_pkey_params *params,
> +			      struct kernel_pkey_query *info)
> +{
> +	struct tpm2_key_rsa *tk =3D params->key->payload.data[asym_crypto];
> +	char alg_name[CRYPTO_MAX_ALG_NAME];
> +	u8 enc_pub_key[PUB_KEY_BUF_SIZE];
> +	struct crypto_akcipher *tfm;
> +	unsigned int len;
> +	int ret;
> +
> +	ret =3D tpm2_key_get_akcipher(params->encoding, params->hash_algo,
> alg_name);
> +	if (ret < 0)
> +		return ret;
> +
> +	tfm =3D crypto_alloc_akcipher(alg_name, 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +
> +	ret =3D tpm2_key_rsa_encode(tk, enc_pub_key);
> +	if (ret < 0)
> +		goto err_tfm;
> +
> +	ret =3D crypto_akcipher_set_pub_key(tfm, enc_pub_key, ret);
> +	if (ret < 0)
> +		goto err_tfm;
> +
> +	len =3D crypto_akcipher_maxsize(tfm);
> +
> +	info->key_size =3D tk->pub_len * 8;
> +	info->max_data_size =3D tk->pub_len;
> +	info->max_sig_size =3D len;
> +	info->max_enc_size =3D len;
> +	info->max_dec_size =3D tk->pub_len;
> +
> +	info->supported_ops =3D KEYCTL_SUPPORTS_ENCRYPT |
> +			      KEYCTL_SUPPORTS_DECRYPT |
> +			      KEYCTL_SUPPORTS_VERIFY |
> +			      KEYCTL_SUPPORTS_SIGN;
> +
> +err_tfm:
> +	crypto_free_akcipher(tfm);
> +	return ret;
> +}
> +
> +/*
> + * Asymmetric TPM2 RSA key. Signs and decrypts with TPM.
> + */
> +struct asymmetric_key_subtype tpm2_key_rsa_subtype =3D {
> +	.owner			=3D THIS_MODULE,
> +	.name			=3D "tpm2_key_rsa",
> +	.name_len		=3D sizeof("tpm2_key_rsa") - 1,
> +	.describe		=3D tpm2_key_rsa_describe,
> +	.destroy		=3D tpm2_key_rsa_destroy,
> +	.query			=3D tpm2_key_rsa_query,
> +	.eds_op			=3D tpm2_key_rsa_eds_op,
> +	.verify_signature	=3D tpm2_key_rsa_verify,
> +};
> +EXPORT_SYMBOL_GPL(tpm2_key_rsa_subtype);
> +
> +/*
> + * Attempt to parse a data blob for a key as a TPM private key blob.
> + */
> +static int tpm2_key_preparse(struct key_preparsed_payload *prep)
> +{
> +	struct tpm2_key_rsa *key;
> +	int ret;
> +
> +	key =3D kzalloc(sizeof(*key), GFP_KERNEL);
> +	if (!key)
> +		return -ENOMEM;
> +
> +	/*
> +	 * TPM 2.0 RSA keys are recommended to be 2048 bits long. Assume
> the
> +	 * blob is no more than 4x that.
> +	 */
> +	if (prep->datalen > 256 * 4) {
> +		kfree(key);
> +		return -EMSGSIZE;
> +	}
> +
> +	ret =3D tpm2_key_decode(prep->data, prep->datalen, &key->key,
> PAGE_SIZE);
> +	if (ret) {
> +		kfree(key);
> +		return ret;
> +	}
> +
> +	if (key->key.oid !=3D OID_TPMLoadableKey) {
> +		tpm2_key_destroy(&key->key);
> +		kfree(key);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D tpm2_key_rsa_extract_pub(key);
> +	if (ret < 0) {
> +		tpm2_key_destroy(&key->key);
> +		kfree(key);
> +		return ret;
> +	}
> +
> +	prep->payload.data[asym_subtype] =3D &tpm2_key_rsa_subtype;
> +	prep->payload.data[asym_key_ids] =3D NULL;
> +	prep->payload.data[asym_crypto] =3D key;
> +	prep->payload.data[asym_auth] =3D NULL;
> +	prep->quotalen =3D 100;
> +	return 0;
> +}
> +
> +static struct asymmetric_key_parser tpm2_key_rsa_parser =3D {
> +	.owner	=3D THIS_MODULE,
> +	.name	=3D "tpm2_key_rsa_parser",
> +	.parse	=3D tpm2_key_preparse,
> +};
> +
> +static int __init tpm2_key_rsa_init(void)
> +{
> +	return register_asymmetric_key_parser(&tpm2_key_rsa_parser);
> +}
> +
> +static void __exit tpm2_key_rsa_exit(void)
> +{
> +	unregister_asymmetric_key_parser(&tpm2_key_rsa_parser);
> +}
> +
> +module_init(tpm2_key_rsa_init);
> +module_exit(tpm2_key_rsa_exit);
> +
> +MODULE_DESCRIPTION("Asymmetric TPM2 RSA key");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 2f25ca07127b..8161758da19a 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -43,6 +43,7 @@ enum tpm2_session_types {
>  /* if you add a new hash to this, increment TPM_MAX_HASHES below */
>  enum tpm_algorithms {
>  	TPM_ALG_ERROR		=3D 0x0000,
> +	TPM_ALG_RSA		=3D 0x0001,
>  	TPM_ALG_SHA1		=3D 0x0004,
>  	TPM_ALG_AES		=3D 0x0006,
>  	TPM_ALG_KEYEDHASH	=3D 0x0008,
> @@ -271,6 +272,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_NV_READ                 =3D 0x014E,
>  	TPM2_CC_CREATE		        =3D 0x0153,
>  	TPM2_CC_LOAD		        =3D 0x0157,
> +	TPM2_CC_RSA_DECRYPT	        =3D 0x0159,
>  	TPM2_CC_SEQUENCE_UPDATE         =3D 0x015C,
>  	TPM2_CC_UNSEAL		        =3D 0x015E,
>  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
> --
> 2.45.1
>=20



Return-Path: <linux-integrity+bounces-2497-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B28CA7AB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 07:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F99B20DB9
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007840879;
	Tue, 21 May 2024 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KDDtA1fd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D23D963;
	Tue, 21 May 2024 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716269818; cv=fail; b=kSD6KAHjZwk5AoDmgy0Ahosz0AsP8DPzVmWZo8FY50I6wyOOnfoSG/7wK77xTYB05sYhwQG1Q/ib74WJr8WLkCOGZhvtm6q8xX9zub+nYTu4Gyn9xgW+zIx403FOLo2hGztiYqyKxp9zEBRq/B3NNl4M5ybZ9SsWnnTDKSlhjk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716269818; c=relaxed/simple;
	bh=tinYeyzVm2oS39TRgchi6Fw82lZqYjzgRXE1DV7K3vE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IWAX8NuTtpWFPNsRG8wSSiDGwmDaJUFfE6sj70WWhH5Y8nNEFiqK+SdiYkZUM5B+enyjxkNpwuY17gqgvnAPpT9dxfDx1h0RtwOyPaB1DfwonUEo81IrsQs5bagTJ85/6iC8T4RQq0Z9nt4bQUhcqM7IC6PokcQnzywfOzBoN0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KDDtA1fd; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L0loPC027487;
	Mon, 20 May 2024 22:36:12 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y6uuj7uxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 22:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvMpE2tqB9jiuzLQuFbgKlUsB1jZKgV3DJDjvCbzVfh14U1H8JdyYujlKXEhUX8QfW5cC95uBvYk4N7agWlqEVRtmYcdUkhe7pS3vAl94WzvcxTT1yMXVuyVknvDM7vuUvsc6oHrFHMwNbxuYd+uueDuDH/VFWH45SAIypLBQRnWoYTFFfnjqgrdy2z+pBR/4QFnl1UTITGqmZ4QqBTLjK/cBiCXZvyL6jaXNwbtwTEhYAcLG1mMpmLw3uqf60s1hAhvZZLVJ30xfM06jKs3wQ/pRMdscBbITQhAtlW7OY/oPibAkj1WNU21XE6dhkzhzGG517UZPCMm1M6KzgwxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOeTm8WW03Xd4oO4DWyAVFTtMILVrWTjGdCaWkLj2hY=;
 b=lAUK0duKeI1t/ea8qizB3+j0F3i4A+xTGGLwyEiI9Hb50d3l2jtGsB90JtwarwEyVudPy9/nd2sa7YLIW8dJK8Kz3ohumlxxcw1v2NVUszzZDcjv4s8WHX6JsTGqpnk8kGPGnZselv1C4uIlSqEG6XakVpcJW0MB2f9ddVa+mQQQCAkc5yxadqUQzGAL7XCdIl8H/KdFJvZssnjrMTi6AdczFmTW3Y9Q34clPDlqtMqYfKBZn1YY8P6iDTTjmR4z1bD+Er6jiwg53Y85DEm7jHCQtWX7SBQptzTYaKnPmEZYMXEhUKFlOOwRpyG1wLeGj9MrMve8IcPhIadLwRHfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOeTm8WW03Xd4oO4DWyAVFTtMILVrWTjGdCaWkLj2hY=;
 b=KDDtA1fd0cstdLM4UKoPf80gwOwCf/dRgMHq2Kekz61F03jd+ZGrg0ebFRveJraDU8qh3uV3RtxAQFphgA3FPNMIiySziX9rd9IZVzEdJI3I6J++FjXz2DKtqcX+hMoz68CRTFaRHLn7IAIc+yftxNQLrNLwuIMKGEndusssK1E=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by BN9PR18MB4346.namprd18.prod.outlook.com (2603:10b6:408:11f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 05:36:06 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7544.041; Tue, 21 May 2024
 05:36:06 +0000
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
        Andrew Morton
	<akpm@linux-foundation.org>,
        James Bottomley
	<James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v2 2/6] lib: Expand asn1_encode_integer() to
 variable size integers
Thread-Topic: [EXTERNAL] [PATCH v2 2/6] lib: Expand asn1_encode_integer() to
 variable size integers
Thread-Index: AQHaqy1p2zvgm4tnqE+UVehWWg/JF7GhJ8Iw
Date: Tue, 21 May 2024 05:36:06 +0000
Message-ID: 
 <SN7PR18MB5314CFBD18B011F292809EBFE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-3-jarkko@kernel.org>
In-Reply-To: <20240521031645.17008-3-jarkko@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|BN9PR18MB4346:EE_
x-ms-office365-filtering-correlation-id: 5615ef97-4e0b-4129-306a-08dc7957e977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?tRh6NVC7LfUrRSePkYwcj7CZNTM70btnEz+QsxW0WwtDqOpnzPCv8d+UzpCh?=
 =?us-ascii?Q?qVZAMCL3To0CgsEqxrqvCTtqtleTwvxVP2TtKP3wwp/NomrNJUgy3H6vE5GK?=
 =?us-ascii?Q?qy+YO/8A2z82H9i1Zq1SgR9HlzqfeIce/kECtdqsd1zMYVW9AOdL90yLtNUF?=
 =?us-ascii?Q?7oSRKz0zg4ZpIlEVYffNzBFTZbS5/Ok2oX6s3cFJqKa5IHPEYNmdyqlb6FgE?=
 =?us-ascii?Q?Tm6mGf/8MXjAMSPA/gVkY3kX9uTM22Ar6t1DyCKfuj9ygFCzXxIX8xpCtH//?=
 =?us-ascii?Q?AgcSJ+TLvpwKT7VGphetXDlf8mXBgBlWu5dSPJ7oCzjiQpbExQ6Gfe6PpQlO?=
 =?us-ascii?Q?K44VnJeu5l5jx/PkerldOat/bIg4c8cVkNxHJKdsRiZY8Wma+dSYRoYHxpue?=
 =?us-ascii?Q?MTOyODLxsnYK63mxaYppEMU7lzrA8LoZrGVn4ThDtqIX3IIiE2VwMufHkb/D?=
 =?us-ascii?Q?ur/DMuAtK+OMxF0cwAqBDdDISkIjeuZMU8vUjiugcc4DDi4Nr/OMbNkiRntq?=
 =?us-ascii?Q?F6eU7cnGQ89KLORLOS90s1eyxRPEFvjt8ctHObkLzT3D1pFRNtvY/g+U4owK?=
 =?us-ascii?Q?TYqgxMW1SABnYtnqvHPTrBBMZwDL+1+7h7jO7moZnT+WLESbAsKFMiD1fTcL?=
 =?us-ascii?Q?yyO9JfMLlVfKUtfgNLHJosVdL2o0EgPsKDDD2Qo/I7+UfecpncYGKptKmvhY?=
 =?us-ascii?Q?18ae6qvxVfGpydE1WgkruoKLQejAe16Ghv34etvtfBVJH8WKMzyBdp+xEjMR?=
 =?us-ascii?Q?LqUynv1nYVsUBcES2FHIAMO7e+sMk6TAPBdz9+fi4wFixhr7WivX3pLaYnrX?=
 =?us-ascii?Q?QKZ6KmRDsLHQWFP8Q/TI2Z0UR6PrLb3cc7zUOuVfdBZuEpy2LWvagcF8fnA2?=
 =?us-ascii?Q?VquBTuNjt0uSv/uZGDBL/L5DZcyWJha341RVpV47iJfwuhtlKzSaJEuyTF6V?=
 =?us-ascii?Q?H/08MVD9Qclys5uAcskjjwP57bOS0INXSRHGsl0B1/WelJCvCGX0m9x173zw?=
 =?us-ascii?Q?3YPj6S/KyiqUBW32wMK7Et+/xpq7d5p2+unp/lZeoAtLuedPGKurozVK5Klf?=
 =?us-ascii?Q?hQw7THGSrzZpLh4z2XpMe9+ssy++hcFZWA11dIogXO4gX+6B214NIWEsODyk?=
 =?us-ascii?Q?PYKi5jccRnNQGsRZOXmI+QnZ9n5YHnYcKRGykvdUhMTPqNfxbj9q7zhM1hIr?=
 =?us-ascii?Q?KldDodKfGhB62/iUBb/1AmcgTrJ/bHnUQ3Q8bY69xWYfjIHimiLrRj+wHakh?=
 =?us-ascii?Q?TOBF2CSqgInDKkIvZ9k9IUHAa6sVgb/aTbUHrEw+W7djTzX8Fwf8l0SeiEAT?=
 =?us-ascii?Q?fejCWK8NyuMhh9xqafWMqc25/7RtkjYUbeSrvFIzhxq5zA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SOjq+ekV5wcsf31qNyaCv5Fimjhib26pEwHa0ssFgXbn664X4eHImxDrFJL/?=
 =?us-ascii?Q?bHd07Ebo9VMvwoaqWsIvKrz4zNyDXlE96MwtgzXXcXcZVL75BwA3LDzvBDQG?=
 =?us-ascii?Q?FtJsHzVRyBZWgOqfcKmlXEH8lNj2v31L7vABkiEcuEWNbiZJS7zO56J+UH6w?=
 =?us-ascii?Q?iqAEJsz4no6npEDlh0Lcbolw8rOuYegO3ElSkc2dw2JN+gPvJb49EAca9MZQ?=
 =?us-ascii?Q?kySnpZK34ogZriHSys7uBELdgsy9nCx6USOa1D72HqpLDObOLLgQUkZIH3S5?=
 =?us-ascii?Q?JIGP973zDDD+6Mo7BZ+Gpb8JKUsi5/g1ZtM0JjRCY+Ra9wDtjXc8Jh6ahO5c?=
 =?us-ascii?Q?9+FwX7BQ8Lhf+KoA07BwGPXTNzcGF3KflKeUipUoKHt2iXtkQiDtWCDP7fbm?=
 =?us-ascii?Q?6mDjTZ7z/kZ4FKBMre1rIptYg80C8Tv79JxPrbZ1dxxNXfvKO+vR92uxWxG0?=
 =?us-ascii?Q?067Y0KCX8L4b6syLo7qBeXZ/0m9dkWJY2R5lhh3YbFVRgT9Prg7DmRI+33bI?=
 =?us-ascii?Q?BRKAO/vn+sAICapljvUeyWzP3ahvA3VUmp4Uy3EO3TUAvezLI971KPJGvCJL?=
 =?us-ascii?Q?bvNzAUcb+nxDXCzRlgsjY9VIJCDLiNSGWTENrHVRXoTMFK3e8LgGyMlIeuD6?=
 =?us-ascii?Q?qczZLODDgTUN52yREbx1ZFL3FA76nHh2tpGYggIkfgr9iiNLQDDlqq3il+F0?=
 =?us-ascii?Q?QbWEipj1oBdvjerLK87o1EeeBAxhRDefaTZVO3AY2dpHHuRp1vprekgVgV2L?=
 =?us-ascii?Q?VTVRxjMPLJDJlwhAjJUR/9JSVbtZ08/DX7IgwQ+05sK+WTvX9/z2Q8IvFZdn?=
 =?us-ascii?Q?2ZjrRer7R07lWqJXHCkuY30PTEkOImlvb9vncGfoKdPgT6i5Qk3gcEe4ZIK0?=
 =?us-ascii?Q?5C4iEfFHvK08D3BqdRdWMWaSJTpMZTidGs1JZYTohPHWpzRf5DySO+W5N0Kr?=
 =?us-ascii?Q?gnhRJSH1dczFdR+kbN2dje24LYSF9iyOcz3RnAfkKzsTWA+cQ59P3OAEpyNc?=
 =?us-ascii?Q?s/mpWHmPb9DizJQZM7RF0whJEy+fAl6nPszSuV+cyczHfs3cS9JsA9BNmHZ1?=
 =?us-ascii?Q?9oRYsHnDtiAyYJQp2gUgNffSt/ILTty80hDPWy8mtsEViwwKXAxj3Jo76fS/?=
 =?us-ascii?Q?AbtXQvzuGQKeph8sihGUrzjyRiwAU5KfapdkvnrgZJB6LdmPqzrynaN4fnOm?=
 =?us-ascii?Q?iLG1uHhTke7OuGbbdUY7x0O52CYNyUxIXXmmmZWtgzuJm3Lv31AD2W8kt0oo?=
 =?us-ascii?Q?NhiVQdN6QL4S7jTolkQZTD0sONk2F5zqhjYl2tOlL+qYueKP1dr05FhojD7N?=
 =?us-ascii?Q?vTQpigjz4NIbZzitEfx9/LcisEEPaCzTwdIPbDe1NPEuiTnYo8KDzniXOsUn?=
 =?us-ascii?Q?/6eiCfkFjh9c5UfOYTeTilqHMi66w7T/4QU3YrJQlktg4BMoFALmzzxMQIlM?=
 =?us-ascii?Q?6YNcCag+3XC0W29iAo1J28TRrLhHgktqwQquNnApILL+hGEi02NG1mKj5EzA?=
 =?us-ascii?Q?p7YJ3YIiUYh1E1QDwX7qK1BobSJevTXtNjeyWtdxoklThno346b+N7ka5IY4?=
 =?us-ascii?Q?gR2Wrn1cQ/Ae7SOMIAlZYjVQloHiTikdIhc4aP6q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5615ef97-4e0b-4129-306a-08dc7957e977
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 05:36:06.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vT4OBEprTMUSN8dovZ0F4Knekmi/F9Y/ar88GqzT69FO8n7K5Fg2jIAVu30dUbLcZUBxDAwAulcpKFa3K3Rj0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4346
X-Proofpoint-GUID: OLPvYt0GgHqWd98zH9fuwhzx7RowhoXz
X-Proofpoint-ORIG-GUID: OLPvYt0GgHqWd98zH9fuwhzx7RowhoXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_03,2024-05-21_01,2024-05-17_01

> -----Original Message-----
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: Tuesday, May 21, 2024 8:46 AM
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-integrity@vger.kernel.org; keyrings@vger.kernel.org;
> Andreas.Fuchs@infineon.com; James Prestwood <prestwoj@gmail.com>;
> David Woodhouse <dwmw2@infradead.org>; Eric Biggers
> <ebiggers@kernel.org>; James Bottomley
> <James.Bottomley@hansenpartnership.com>; Jarkko Sakkinen
> <jarkko@kernel.org>; David S. Miller <davem@davemloft.net>; open
> list:CRYPTO API <linux-crypto@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>; Andrew Morton <akpm@linux-foundation.org>;
> James Bottomley <James.Bottomley@HansenPartnership.com>; Mimi Zohar
> <zohar@linux.ibm.com>; David Howells <dhowells@redhat.com>; Paul Moore
> <paul@paul-moore.com>; James Morris <jmorris@namei.org>; Serge E. Hallyn
> <serge@hallyn.com>; open list:SECURITY SUBSYSTEM <linux-security-
> module@vger.kernel.org>
> Subject: [EXTERNAL] [PATCH v2 2/6] lib: Expand asn1_encode_integer() to
> variable size integers
>=20
> ----------------------------------------------------------------------
> Expand asn1_encode_integer() to variable size integers, meaning that it
> will get a blob in big-endian format as integer and length of the blob as
> parameters. This is required in order to encode RSA public key modulus.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  include/linux/asn1_encoder.h              |   3 +-
>  lib/asn1_encoder.c                        | 185 ++++++++++++----------
>  security/keys/trusted-keys/trusted_tpm2.c |   4 +-
>  3 files changed, 103 insertions(+), 89 deletions(-)
>=20
> diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
> index 08cd0c2ad34f..ad5fb18db9e2 100644
> --- a/include/linux/asn1_encoder.h
> +++ b/include/linux/asn1_encoder.h
> @@ -9,9 +9,10 @@
>  #include <linux/bug.h>
>=20
>  #define asn1_oid_len(oid) (sizeof(oid)/sizeof(u32))
> +
>  unsigned char *
>  asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
> -		    s64 integer);
> +		    const u8 *integer, int integer_len);
>  unsigned char *
>  asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
>  		u32 oid[], int oid_len);
> diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
> index 0fd3c454a468..51a2d7010a67 100644
> --- a/lib/asn1_encoder.c
> +++ b/lib/asn1_encoder.c
> @@ -9,12 +9,78 @@
>  #include <linux/bug.h>
>  #include <linux/string.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
> +
> +/**
> + * asn1_encode_length() - encode a length to follow an ASN.1 tag
> + * @data: pointer to encode at
> + * @data_len: pointer to remaining length (adjusted by routine)
> + * @len: length to encode
> + *
> + * This routine can encode lengths up to 65535 using the ASN.1 rules.
> + * It will accept a negative length and place a zero length tag
> + * instead (to keep the ASN.1 valid).  This convention allows other
> + * encoder primitives to accept negative lengths as singalling the
> + * sequence will be re-encoded when the length is known.
> + */
> +static int asn1_encode_length(unsigned char **data, int *data_len, int l=
en)
> +{
> +	if (*data_len < 1)
> +		return -EINVAL;
> +
> +	if (len < 0) {
> +		*((*data)++) =3D 0;
> +		(*data_len)--;
> +		return 0;
> +	}
> +
> +	if (len <=3D 0x7f) {
> +		*((*data)++) =3D len;
> +		(*data_len)--;
> +		return 0;
> +	}
> +
> +	if (*data_len < 2)
> +		return -EINVAL;
> +
> +	if (len <=3D 0xff) {
> +		*((*data)++) =3D 0x81;
> +		*((*data)++) =3D len & 0xff;
> +		*data_len -=3D 2;
> +		return 0;
> +	}
> +
> +	if (*data_len < 3)
> +		return -EINVAL;
> +
> +	if (len <=3D 0xffff) {
> +		*((*data)++) =3D 0x82;
> +		*((*data)++) =3D (len >> 8) & 0xff;
> +		*((*data)++) =3D len & 0xff;
> +		*data_len -=3D 3;
> +		return 0;
> +	}
> +
> +	if (WARN(len > 0xffffff, "ASN.1 length can't be > 0xffffff"))
> +		return -EINVAL;
> +
> +	if (*data_len < 4)
> +		return -EINVAL;
> +	*((*data)++) =3D 0x83;
> +	*((*data)++) =3D (len >> 16) & 0xff;
> +	*((*data)++) =3D (len >> 8) & 0xff;
> +	*((*data)++) =3D len & 0xff;
> +	*data_len -=3D 4;
> +
> +	return 0;
> +}
>=20
>  /**
>   * asn1_encode_integer() - encode positive integer to ASN.1
> - * @data:	pointer to the pointer to the data
> - * @end_data:	end of data pointer, points one beyond last usable byte in
> @data
> - * @integer:	integer to be encoded
> + * @data:		pointer to the pointer to the data
> + * @end_data:		end of data pointer, points one beyond last usable
> byte in @data
> + * @integer:		integer to be encoded
> + * @integer_len:	length in bytes of the integer blob
>   *
>   * This is a simplified encoder: it only currently does
>   * positive integers, but it should be simple enough to add the
> @@ -22,15 +88,17 @@
>   */
>  unsigned char *
>  asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
> -		    s64 integer)
> +		    const u8 *integer, int integer_len)
>  {
>  	int data_len =3D end_data - data;
> -	unsigned char *d =3D &data[2];
>  	bool found =3D false;
> +	unsigned char *d;
> +	int encoded_len;
> +	u8 *encoded;
> +	int ret;
>  	int i;
>=20
> -	if (WARN(integer < 0,
> -		 "BUG: integer encode only supports positive integers"))
> +	if (WARN(!integer, "BUG: integer is null"))
>  		return ERR_PTR(-EINVAL);
>=20
>  	if (IS_ERR(data))
> @@ -40,17 +108,22 @@ asn1_encode_integer(unsigned char *data, const
> unsigned char *end_data,
>  	if (data_len < 3)
>  		return ERR_PTR(-EINVAL);
>=20
> -	/* remaining length where at d (the start of the integer encoding) */
> -	data_len -=3D 2;
> +	(*data++) =3D _tag(UNIV, PRIM, INT);

Just for my clarification:=20
	First index of "data" is updated here with tag and data pointer incremente=
d.
	Next comment for continuation

> +	data_len--;
>=20
> -	data[0] =3D _tag(UNIV, PRIM, INT);
> -	if (integer =3D=3D 0) {
> -		*d++ =3D 0;
> -		goto out;
> +	if (!memchr_inv(integer, 0, integer_len)) {
> +		data[1] =3D 1;
> +		data[2] =3D 0;
> +		return &data[2];

Here we are effectively setting second and third index of original "data" p=
ointer as "data" pointer was incremented earlier.
So second index of original "data" pointer is not touched. Also returning 3=
rd index pointer of original data pointer

Is that intentional?

Thanks
-Bharat

>  	}
>=20
> -	for (i =3D sizeof(integer); i > 0 ; i--) {
> -		int byte =3D integer >> (8 * (i - 1));
> +	encoded =3D kzalloc(integer_len, GFP_KERNEL);
> +	if (!encoded)
> +		return ERR_PTR(-ENOMEM);
> +	d =3D encoded;
> +
> +	for (i =3D 0; i < integer_len; i++) {
> +		int byte =3D integer[i];
>=20
>  		if (!found && byte =3D=3D 0)
>  			continue;
> @@ -67,21 +140,23 @@ asn1_encode_integer(unsigned char *data, const
> unsigned char *end_data,
>  			 * have len >=3D 1
>  			 */
>  			*d++ =3D 0;
> -			data_len--;
>  		}
>=20
>  		found =3D true;
> -		if (data_len =3D=3D 0)
> -			return ERR_PTR(-EINVAL);
> -
>  		*d++ =3D byte;
> -		data_len--;
>  	}
>=20
> - out:
> -	data[1] =3D d - data - 2;
> +	encoded_len =3D d - encoded;
>=20
> -	return d;
> +	ret =3D asn1_encode_length(&data, &data_len, encoded_len);
> +	if (ret)  {
> +		kfree(encoded);
> +		return ERR_PTR(ret);
> +	}
> +
> +	memcpy(data, encoded, encoded_len);
> +	kfree(encoded);
> +	return data + encoded_len;
>  }
>  EXPORT_SYMBOL_GPL(asn1_encode_integer);
>=20
> @@ -176,70 +251,6 @@ asn1_encode_oid(unsigned char *data, const
> unsigned char *end_data,
>  }
>  EXPORT_SYMBOL_GPL(asn1_encode_oid);
>=20
> -/**
> - * asn1_encode_length() - encode a length to follow an ASN.1 tag
> - * @data: pointer to encode at
> - * @data_len: pointer to remaining length (adjusted by routine)
> - * @len: length to encode
> - *
> - * This routine can encode lengths up to 65535 using the ASN.1 rules.
> - * It will accept a negative length and place a zero length tag
> - * instead (to keep the ASN.1 valid).  This convention allows other
> - * encoder primitives to accept negative lengths as singalling the
> - * sequence will be re-encoded when the length is known.
> - */
> -static int asn1_encode_length(unsigned char **data, int *data_len, int l=
en)
> -{
> -	if (*data_len < 1)
> -		return -EINVAL;
> -
> -	if (len < 0) {
> -		*((*data)++) =3D 0;
> -		(*data_len)--;
> -		return 0;
> -	}
> -
> -	if (len <=3D 0x7f) {
> -		*((*data)++) =3D len;
> -		(*data_len)--;
> -		return 0;
> -	}
> -
> -	if (*data_len < 2)
> -		return -EINVAL;
> -
> -	if (len <=3D 0xff) {
> -		*((*data)++) =3D 0x81;
> -		*((*data)++) =3D len & 0xff;
> -		*data_len -=3D 2;
> -		return 0;
> -	}
> -
> -	if (*data_len < 3)
> -		return -EINVAL;
> -
> -	if (len <=3D 0xffff) {
> -		*((*data)++) =3D 0x82;
> -		*((*data)++) =3D (len >> 8) & 0xff;
> -		*((*data)++) =3D len & 0xff;
> -		*data_len -=3D 3;
> -		return 0;
> -	}
> -
> -	if (WARN(len > 0xffffff, "ASN.1 length can't be > 0xffffff"))
> -		return -EINVAL;
> -
> -	if (*data_len < 4)
> -		return -EINVAL;
> -	*((*data)++) =3D 0x83;
> -	*((*data)++) =3D (len >> 16) & 0xff;
> -	*((*data)++) =3D (len >> 8) & 0xff;
> -	*((*data)++) =3D len & 0xff;
> -	*data_len -=3D 4;
> -
> -	return 0;
> -}
> -
>  /**
>   * asn1_encode_tag() - add a tag for optional or explicit value
>   * @data:	pointer to place tag at
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> b/security/keys/trusted-keys/trusted_tpm2.c
> index 8b7dd73d94c1..ec59f9389a2d 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -38,6 +38,7 @@ static int tpm2_key_encode(struct trusted_key_payload
> *payload,
>  	u8 *end_work =3D scratch + SCRATCH_SIZE;
>  	u8 *priv, *pub;
>  	u16 priv_len, pub_len;
> +	u32 key_handle;
>  	int ret;
>=20
>  	priv_len =3D get_unaligned_be16(src) + 2;
> @@ -77,7 +78,8 @@ static int tpm2_key_encode(struct trusted_key_payload
> *payload,
>  		goto err;
>  	}
>=20
> -	work =3D asn1_encode_integer(work, end_work, options->keyhandle);
> +	key_handle =3D cpu_to_be32(options->keyhandle);
> +	work =3D asn1_encode_integer(work, end_work, (u8 *)&key_handle, 4);
>  	work =3D asn1_encode_octet_string(work, end_work, pub, pub_len);
>  	work =3D asn1_encode_octet_string(work, end_work, priv, priv_len);
>=20
> --
> 2.45.1
>=20



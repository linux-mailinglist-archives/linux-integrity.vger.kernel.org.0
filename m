Return-Path: <linux-integrity+bounces-2498-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FE98CA7BE
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 07:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FA8B2140B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5F33997;
	Tue, 21 May 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="rNpH+8Yb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C720EB;
	Tue, 21 May 2024 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716270493; cv=fail; b=dOluQsoNoJGNUb1MIkzQN7h5IpuFXdrrgad2AHM/GwDHdFqmhBCOF+lJyP8u/HASW3aCMlR9W0gdfJ7uAy6dUcOfcMi+chK07gSqgQTRUreNDiNMiwZ0lTHnfvY1AlsJCR1g7bE6J+ShQPMCan9rwB9oZZRMikx+yntE0uNuIzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716270493; c=relaxed/simple;
	bh=VmmEMwWurct8acmv+kAuVziTY+QYQO4E21m5spGNMiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPHarMB2ijL4PyZHGXII3JwffOu6DKWJx8BQbtj3rFAIQxyoXBxB4wICUZIr6sASTDMyxxrNkzA+mOavrKN1gvi9HoPIjEsL9sYorHm8sxA+3jKHRu+fvgEev9UbOGjjBx6XglFU+Cb7+gLjlx0qMfucEFtPFUQlVSn/cxuh9lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=rNpH+8Yb; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L0sHAB009575;
	Mon, 20 May 2024 22:47:47 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y6uuj7vtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 22:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wez5mwPW41n4V0oM1NumkleE8qmmhXpKhidx12uHfGwZLqlV+ZRETd7bLNO5oqBsWme9xFaw8sup859uBFj//ncWvda/QfG0//6IgWdq0B7Xvc3MRq+NGAQwJAUJ6siYa6H89aNPkNmgqcT22wSa2CiMU9y+Uf8RUTPD0dNPMTZjqDEcjAomxO6UlEtjeWEML6+nG20AUDfHI5VMOK776piTvhtWf5VM9TInv4pbTXTEmdEViU2sK81eojD9a0wSFLn97UhbXkfbwN/0ofzKlSrAhmOp/MmJoLlTQkQAp1NWJ40g6EBokMgBxjZkWYoSYJ1X89GqYVKb2QiuxkyLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6G5T2obp98vVCzEz58wCRIc6xZ9+/kdC8vFfjkoa+UM=;
 b=fzy0zG3Xty5lVyjcEomzHLrsnPrcfPCAmRPXLFwTxm3lmklcUSLTHtxgPJSSqo4OWQ8cXRvW2+BEeC92IUEQYaoxc4ikSL8GXaFBL+bksvDj/5CJjlo9ygPzpIXFLSe2ut2s3MPDk+DinAgTOIGklA5xzmDv6VKpPx5vIr3nuL6vfGT3jWu1dRtG1CHhhugHoGVxogso8PeYYucUCpuxdBa20N1bKAiwhDdTvWg7nAA1hoZjWnB64ditWG/pJ2eFN3Ltx3L6C5NaTmQYZl1TUTT0Shlfn5gQbmWei3Hau7qwPX4rixlDC43uL51QHb2NqMYNJviqZv+MmvScQChUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G5T2obp98vVCzEz58wCRIc6xZ9+/kdC8vFfjkoa+UM=;
 b=rNpH+8YbUb021gOlG7MN6SjMUS0AXwPD8fRGgX83ReR63Rq0moSXej08SAydqhZeWGv10yuRqOfkVvUPULSR7p3lb/wlnJcqlWnNtz6WlYcRShpnVubrYvJo79+F4woRUm1M2rlt+W1tImojs7qUoDIBXSRTcJfbTzrJdmRnlPo=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by CH0PR18MB4210.namprd18.prod.outlook.com (2603:10b6:610:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 05:47:41 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7544.041; Tue, 21 May 2024
 05:47:41 +0000
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
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley
	<James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v2 5/6] tpm: tpm2_key: Extend parser to
 TPM_LoadableKey
Thread-Topic: [EXTERNAL] [PATCH v2 5/6] tpm: tpm2_key: Extend parser to
 TPM_LoadableKey
Thread-Index: AQHaqy2KsbjFo2j7N0iqMaIZLK/VLLGhLihA
Date: Tue, 21 May 2024 05:47:40 +0000
Message-ID: 
 <SN7PR18MB53140F4341BC441C1C11586EE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-6-jarkko@kernel.org>
In-Reply-To: <20240521031645.17008-6-jarkko@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|CH0PR18MB4210:EE_
x-ms-office365-filtering-correlation-id: 9943a8eb-4f85-44ad-d5b3-08dc7959875f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?XDpTdtFPaeO/IRlYL06EhL5H90H5oaZpFjV1OU9JUoAp0FLNiMZuwKTw7vqB?=
 =?us-ascii?Q?9X9TJYgaaRziwq9h+nkk+hK6BdN3XD+8luzI/V9iH90afoMS2Bo7sss/SdN0?=
 =?us-ascii?Q?/f5hu1l0NyyqyF657jZc1zZpYS96Vt1HcWY4k27Y7/eMHLtPtdLhFhBJpLTg?=
 =?us-ascii?Q?qr6r4HL1i4bsgCQJKNnOOku6gGzjMJLrOHBRofaAkDHzMOSewCdIn3lJo4Ay?=
 =?us-ascii?Q?Py1/UDoW9ISLIMSdxTuhr6oiLbVC9AxsrQMAbhli+ay2SG48hU5AaNfR+7SX?=
 =?us-ascii?Q?2gPtsIxH8BL/2VZb1ToYuRt15xKNI7UIUDrvIwBTks7riJhD63v4A3cD99L3?=
 =?us-ascii?Q?JgixgHIZnrMkF1FkiXZIKAuyIVWOO/qo675q8S1IXP5/LZ6QcvEn5yidTrzO?=
 =?us-ascii?Q?0GWt6pmUaF3np2eCJcsNxpKgaZfwZT67i8D5ZdZQ8jATJvhoUj8ZSKIWlxDm?=
 =?us-ascii?Q?UGASBLNOOZlyOXnad8AExRE+QfXXUq4YPlgaRVvt/jJYJrddgewRFbiNs5SZ?=
 =?us-ascii?Q?uEUnAnVdOXtLVUYwYy3x6CBESet8OshvxdsMeiAqjxIIw6yAUw4JwSXzXQeW?=
 =?us-ascii?Q?DWPT7SDxa3Wy+eWMQQPEXKTt9j279Ph0XnJ4bU8nxwAX481T5WhLM59Lw9Mo?=
 =?us-ascii?Q?vkV+UMBrOTwEZJ5k10trT8O2AaIdj4TLHTv7PFxUM0yA5RhJ3Tw7ZKyt4/r+?=
 =?us-ascii?Q?yIBVd8jTfZ1J4UzRlgYUExE1tSlAMK5N6XTjpYqfuBecsXFZ29Ml4Ts/3xw1?=
 =?us-ascii?Q?JTr79y6BgRBp2FshG4Rr37cSoko4vh/vm0JG1bClKOLddNyalVS1s05NLeXw?=
 =?us-ascii?Q?SOLjcjN4Apb8jCEX28SdZzLg4yJRT7vgMvt5vsAFXzVeECoC4FS3dstwKqn8?=
 =?us-ascii?Q?+wnjMDP3UbH8/e6GUsPBlOtI2vi0uStwSD3dx0wg3bfWyFRY+FJmFznV6Vyl?=
 =?us-ascii?Q?Pyz/SkU9UVzSWOR5mPHnUMqNIePN0RDoA86C42s4A3ib0AHJQoCJg/huiSID?=
 =?us-ascii?Q?N4tM1DzzrI4ji3BeTEgS6TGXw655BMclpYtpYQw0EpqZNQjDkFCt8Olx1Y9N?=
 =?us-ascii?Q?8uizcxgn8hbb5C2wM1rzr0PM78AB35/6cH9qS1c6UJADc/19XoeKKcXHV6lk?=
 =?us-ascii?Q?hNuZCd7hPDB7MpdsVjn5Jp58iAApIPysSYY9jOEB8TATTl+EcjgAfyFmmlRh?=
 =?us-ascii?Q?k1mThIHx5nSr+2EN8HQe+Mj7m4srbBEYytVy7KuvI6pb3CvKEQiYY6bQ64n+?=
 =?us-ascii?Q?s9TvRi++4+1XDwYdLBjrgVF2URZzir4F3chgmggYUpE5ROsS/n+vsdh0iT9q?=
 =?us-ascii?Q?k9hrI8s9Zn7xizwpaVzuY9CDlot/hd2o1e0+dZbC/kHR9g=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5NfTAvn3SMk/biQQN8aSKNLaq268oKzbmpD1vYSFC1IZIm11Ael/NCBQs7wD?=
 =?us-ascii?Q?AHbSoSGLSLAc8iE2DUC2wfQUS34ve/LR9WHk2CqfjQKJlkjvT3zUcPGCVFPu?=
 =?us-ascii?Q?vCc3511aTgpregLQr4JZ7Bv2Ukl8nabAQHxk2dGYy+rFUQ7F7qL2ES+KJbfT?=
 =?us-ascii?Q?LhVIKtisuSMsMLCrMTXlCrGB7kK7V8fF+deCgfal+ADQxnVGzLLOodx26wYz?=
 =?us-ascii?Q?SFtJa0EHC01+i3iSSP8VFZc1sLtZ5uYe+dLrZZ2+5MWqqhI3b7RvutUq45mX?=
 =?us-ascii?Q?P6/08g7Q55v11sMYVISpCwG3RQPeQrOFWHgWDoqaL6DADhNpw6ZG76Ya8MBz?=
 =?us-ascii?Q?pwElYqs+pg4Y+GEsTUvPNOisahhmDQLSABUjocDrzqLzI5uXJ6/FJdpkUeaf?=
 =?us-ascii?Q?Woxg90wW9UF50x19l6JAZF9v5qFWsA3EnfYboUbjV+AcjC3PBWTii4wvLrEi?=
 =?us-ascii?Q?e8pp1SYzoVacKyS8/mKRVgseUeH0xzxYt72mPM9K/w+I53qroDUOz6g1d/Br?=
 =?us-ascii?Q?NHCM1OzkK9z7LNpY+73JVRhPRmFQdseGCX3erX/3wwFJSrPhLnfyYlOZ7iRZ?=
 =?us-ascii?Q?HukOVTlez8ETeofhmAOdhqw1JbKCz/u5Dp0Ql+SPeNFdP8UIillGlW5OCgjL?=
 =?us-ascii?Q?4jI+3m5xbq1KLWyUWwApkPcnMIHeczQYZGkZVRZZ3fEoylODdBsDdQUik1Oo?=
 =?us-ascii?Q?yh+SNjL0/qlP4dmGC3C9qr9W2Gg78gR3ckUbW/4+BiK0eaoHQq6g5FQjPkcQ?=
 =?us-ascii?Q?HIgHJO7gz7ki7obK8TtNWILkrvUtOdb8jcacP1OLaat3KoEPFFXMWvNIUjPz?=
 =?us-ascii?Q?hj7xlr13BI7kGijMRPy4BJJYZnPG3zjlkI+QmBaTx0j+m/oz53dlHXks7+dX?=
 =?us-ascii?Q?uI7yHwI/44uhuNJyyjYDUna33VlfP4A41DlJEdzTbiqElaX5K6Z2W2t37Pj6?=
 =?us-ascii?Q?kMYpM0Oh174LRmM5DLWE68k8q3x4qNMdKBnc5mM9cyKnm8RIeGDvD37C+8Sq?=
 =?us-ascii?Q?WpdnrbaDFxIObn7YN0x3hweArJXTdd5BfaGqjUmS5gqiB5+kVCW7UKkIyGn2?=
 =?us-ascii?Q?+/0p4JnTumNi/Z3g+kj1E1Topd7GRXOh8TwIPadXgAimUfRA9D1NyLd9cTpl?=
 =?us-ascii?Q?1Tj945jGvmlDZ0D8khGBuyKjbFegXxUVw1NcIchEa/P6FWj/1/8X3614W/Bs?=
 =?us-ascii?Q?0FIT3H4zQAAxFMwNCd2sQAR7zgMQBYgdYoOKx/EOFI/QSW7darj7RGoU8ojV?=
 =?us-ascii?Q?M2/xq2TtNpXTAiF21OBCum6eSfpdJat5vtbXzNUUyt/T1srtq9Zy5PPkB/W4?=
 =?us-ascii?Q?Dc6X6AhZKadJXlx7V4MmOzwpk0mHo6NwSFlS6jiom7YNFg+4+cLCdRPh2nn4?=
 =?us-ascii?Q?wZhmz/e2RZCeH50LKN5I4o3d8kYjCf9Q59znay7nttEVrnPfMGRqKduJzGNm?=
 =?us-ascii?Q?eY2YpWk7dcm1wR3hUDh86vv0EZrkbdzy9kv/t4+oIOx7X7WeJUUm+qtuExRH?=
 =?us-ascii?Q?w5gWC5NiMHD0KhRInipVYCVrZhVreQC9v8dp+ETu2P3tdim7QFK4T9/MpTXS?=
 =?us-ascii?Q?4vBXT0GSUT3KNFUgzyO6i91HXCP4vZeW3OLdW4gv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9943a8eb-4f85-44ad-d5b3-08dc7959875f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 05:47:40.9695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i34LAu8SdB8vgO/7dMM7Tu2g7W9jfhWNrcSWHKijTBj5QInWsAFUDX2PyaWRGUSHQ2UhmSUs4Ml9/IXavnEznw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4210
X-Proofpoint-GUID: EU0n9cutVw3xFiXIhFYdHy3rMyC_gusD
X-Proofpoint-ORIG-GUID: EU0n9cutVw3xFiXIhFYdHy3rMyC_gusD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_03,2024-05-21_01,2024-05-17_01



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
> kernel@vger.kernel.org>; Peter Huewe <peterhuewe@gmx.de>; Jason
> Gunthorpe <jgg@ziepe.ca>; James Bottomley
> <James.Bottomley@HansenPartnership.com>; Mimi Zohar
> <zohar@linux.ibm.com>; David Howells <dhowells@redhat.com>; Paul Moore
> <paul@paul-moore.com>; James Morris <jmorris@namei.org>; Serge E. Hallyn
> <serge@hallyn.com>; open list:SECURITY SUBSYSTEM <linux-security-
> module@vger.kernel.org>
> Subject: [EXTERNAL] [PATCH v2 5/6] tpm: tpm2_key: Extend parser to
> TPM_LoadableKey
>=20
> ----------------------------------------------------------------------
> Extend parser to TPM_LoadableKey. Add field for oid to struct tpm2_key
> so that callers can differentiate different key types.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm2_key.c               | 14 +++++++++++---
>  include/crypto/tpm2_key.h                 |  2 ++
>  security/keys/trusted-keys/trusted_tpm2.c |  4 ++++
>  3 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm2_key.c b/drivers/char/tpm/tpm2_key.c
> index 0112362e432e..59797dc232f1 100644
> --- a/drivers/char/tpm/tpm2_key.c
> +++ b/drivers/char/tpm/tpm2_key.c
> @@ -32,16 +32,24 @@ int tpm2_key_type(void *context, size_t hdrlen,
>  		  const void *value, size_t vlen)
>  {
>  	enum OID oid =3D look_up_OID(value, vlen);
> -
> -	if (oid !=3D OID_TPMSealedData) {
> +	struct tpm2_key *key =3D context;
> +
> +	switch (oid) {
> +	case OID_TPMSealedData:
> +		pr_info("TPMSealedData\n");
> +		break;
> +	case OID_TPMLoadableKey:
> +		pr_info("TPMLodableKey\n");
> +		break;
> +	default:
>  		char buffer[50];
> -
>  		sprint_oid(value, vlen, buffer, sizeof(buffer));
>  		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
>  			 buffer);

Maybe extend this print to say "neither TPMSealedData nor TPMLodableKey"

Thanks
-Bharat

>  		return -EINVAL;
>  	}
>=20
> +	key->oid =3D oid;
>  	return 0;
>  }
>=20
> diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
> index acf41b2e0c92..2d2434233000 100644
> --- a/include/crypto/tpm2_key.h
> +++ b/include/crypto/tpm2_key.h
> @@ -2,12 +2,14 @@
>  #ifndef __LINUX_TPM2_KEY_H__
>  #define __LINUX_TPM2_KEY_H__
>=20
> +#include <linux/oid_registry.h>
>  #include <linux/slab.h>
>=20
>  /*
>   * TPM2 ASN.1 key
>   */
>  struct tpm2_key {
> +	enum OID oid;
>  	u32 parent;
>  	const u8 *blob;
>  	u32 blob_len;
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> b/security/keys/trusted-keys/trusted_tpm2.c
> index f255388d32b8..ce4c667c3ee3 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -305,6 +305,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  		payload->old_format =3D 1;
>  	} else {
>  		blob =3D key.blob;
> +		if (key.oid !=3D OID_TPMSealedData) {
> +			tpm2_key_destroy(&key);
> +			return -EINVAL;
> +		}
>  	}
>=20
>  	if (!blob)
> --
> 2.45.1
>=20



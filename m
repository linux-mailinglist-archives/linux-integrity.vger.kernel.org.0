Return-Path: <linux-integrity+bounces-4076-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1555D9C1860
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E63B20A17
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D141DE4D9;
	Fri,  8 Nov 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="pKqqOdpD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1551D07B1
	for <linux-integrity@vger.kernel.org>; Fri,  8 Nov 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055781; cv=fail; b=c6ndsO/oNdW6JkNVWsfy973Qrh2v4coukUTC39GEgoqZ2Ys5AJDrxzhj9v4J/cf5aLrxeRbePYZDzuVrAzuSz41drot5wgTLVuvyrL7Tr3pzBEbvgrp6gNOr/U2RvTuNTHtRMG2ckJLo67eTHS6ByOxhMVkkCIHq+pyCV9vlKx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055781; c=relaxed/simple;
	bh=fQa5otMeggj2sWXGvkYrsObRMFt+NNviv1Tjy8jl/LE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZAd8bx/T8FHPgUdPfv+oDI6MDtS9Nl3xR6Zl6fqNdSJls+sKGWvayBf4KEllo3EDK2hKSGysXJFvgkjzvnn8Air+YPBppAKyWkZtSSr3J7iuidyl99eXpP9J4brhssahC745VCkZXs97UXGhi+JrwZXNoczl8KA6DnVj83QeX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=pKqqOdpD; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A87w4Jr024752;
	Fri, 8 Nov 2024 08:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=GX
	3aN3WujuSjo/3w98Y0TlzXTBYvTpBoyRKxKNsaaK8=; b=pKqqOdpDe3JVKC0NW6
	T4PC2cxtsJEtZbIqs5HPJA2AcUuyC5gT5+QiSx1I7M7JKOFW+aC/ZY0UpWROM0kO
	o6DpgnQ2jdtat9vaNQyaTWxSu6jHJeziG5JoKmvlbv2Q3sH1lsBcjDhSWfDOV6uf
	sYYBkU+76GCD/sep8weSNC397hmWqKNDhb143zPLesGNbRYFrYDSTwRZjv10/as6
	N748Yl9cU/9AI5QJGLafc1UJBEeZAv8XdYJAHVpAjrCuIrGR8fwjdwxDSUhrdWfI
	6eUS3bFkCM3z0ygitX15Jeu9P2mMPeIEkahkwiCgqFQ6U6uYKfUsRZIb0FEeIjQ2
	xW7Q==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42seqggdax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 08:48:55 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id E32AA1375F;
	Fri,  8 Nov 2024 08:48:53 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 7 Nov 2024 20:48:47 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 7 Nov 2024 20:48:40 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 7 Nov 2024 20:48:40 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 8 Nov 2024 08:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeaTEBAzR8g9cMcpN78h5CXUHAmmggqMY4V8VlzTkWcjvuyBU7wxBcYGvVWsmwHwW8ZanZJEj+wQ9StzxlBTIkYQnsmlsxNQpJ9EDdEcIsni/7rFrLf76DZsdjWBPRoDyt1bnBpTm9DbRxiOkX0tMVY6qFCL2u2mwgEOk2kFVoi+npnVn7btVlOzVZoLBcsTbjUurcjGKKXe19Y2kPY5hNqp6ZEIZuZmLh13bvbVEHmoRDvCnw0r58lT0CbDVdHH2S1K+9/t7A43HZNl44pE0UOILKc0g8vBWEP5vstOvwMOIoeqnxsI2hbj9cmUcvReCSbaVQhU0AS8l2DqG+ah/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX3aN3WujuSjo/3w98Y0TlzXTBYvTpBoyRKxKNsaaK8=;
 b=FAiEd7j1gLe4+TA48vOdkKuftEhUSRNMyKz5P5aceB62Z/0Ug6vosxTn13wlHNCw9qC5aXQLk7iW3fLHeyoyPzheVSOG+8GwQyibaxsVWlQkXVGnsgGpxsnMDuIlAWM4F/jdSYE53IjTiceGUEHM+q1HQ8Qm/IwbLiHIK7ZlN9WBrqvqpmuOdsIuqYDWSXECPMVu3jONsoGIr05481jToS1goRDJ9r7DMh4GK8aHw5Yo2rgFj8vS0As/pbHJgruRVAwRssxGTzLzXUZOrNym8xeunX67uVyeDSF/x/L7VZ9mL1icxLMSenMEtA6aYuCZ/2L2bWVLsfB0hilSokMDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::16)
 by IA1PR84MB3034.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 08:48:38 +0000
Received: from PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5bb3:55b3:afd7:c204]) by PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5bb3:55b3:afd7:c204%3]) with mapi id 15.20.8114.028; Fri, 8 Nov 2024
 08:48:38 +0000
From: "Liang, Andy (Linux Ecosystem Engineering)" <andy.liang@hpe.com>
To: Takashi Iwai <tiwai@suse.de>
CC: Stefan Berger <stefanb@linux.ibm.com>,
        Paul Menzel
	<pmenzel@molgen.mpg.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe
	<peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Golmitz, Jenifer (Linux Ecosystem Engineering)" <jenifer.golmitz@hpe.com>
Subject: RE: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
Thread-Topic: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
Thread-Index: AQHbMQcujKUx7uXr+ECzX2mQ2FnQK7Kru/2AgAAF0ICAAGyMAIAABuuAgADX1gCAAAOJ4A==
Date: Fri, 8 Nov 2024 08:48:38 +0000
Message-ID: <PH7PR84MB19575D91A43C2D4C7C842038995D2@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
References: <20241107112054.28448-1-tiwai@suse.de>
	<87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
	<878qtvi5he.wl-tiwai@suse.de>
	<262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
	<92a9ca13-ead3-41f8-88fd-ab9540c0e9b3@linux.ibm.com>
 <875xoygml3.wl-tiwai@suse.de>
In-Reply-To: <875xoygml3.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1957:EE_|IA1PR84MB3034:EE_
x-ms-office365-filtering-correlation-id: 0543e981-6e79-4a71-9944-08dcffd2235f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-7?Q?3Dcv034SDRqRAL4k8t1vrT87r4MA7MqbWlaHVG44N8Ku29tLONOArXOVEW?=
 =?iso-8859-7?Q?T0jd7Jibqk13piJSq5QzoJ9XN7cmQGFFrcfHDGJVsR8aICCoWDNCnSdl7v?=
 =?iso-8859-7?Q?9hXuAaN+xDBUNKPqJCNyA5n83WIFHPNSvIo1fcm+fDxr9Z1ptrYkjAhM9P?=
 =?iso-8859-7?Q?NfKxbLBy1+gqkwwNotjVy8/M+VpBCrAau8TFr37FM1/BlZnGd1MGp9xiXl?=
 =?iso-8859-7?Q?6ku3rNlj6SBmRJN4nfWt8BXgZN01YX3RM0RqQ53pCCuQWKO5WaaMqZCLTn?=
 =?iso-8859-7?Q?T7eGqx13hoZt0s/pikCiBnInDI+p8KqJPzYg2oE9euoWzzvhxp70Qa7LAu?=
 =?iso-8859-7?Q?jeV8evCwJqmPNRarIeHpXdSLMFanAqxXapPUiIK9mzK5CrzCqPCx0jX5en?=
 =?iso-8859-7?Q?eO5d6BnNuQ0hZRoTyX8ql/2LuIehxlHe7xp7emzH4QjatC1efw50vc123y?=
 =?iso-8859-7?Q?zmw3XfbD2sxZoPXyr8KZwNe8TjCvlc8gT4j0nesMZIDS1EtjZ7aUe4OLYa?=
 =?iso-8859-7?Q?cXBR2Mt+d3cV39U1d2gVQa23iJHkSwFwtU7jGo2/aqsqj00qigjulE4fmf?=
 =?iso-8859-7?Q?Dx5HHk4EOrt7KWLDSIDHf2IMF3EYwRJCHTfB8xynd/57F1aqfWzLzWeD76?=
 =?iso-8859-7?Q?Lr0IcK4hbcLI33YUapUtWJv32R2ekDqIZHG4JMj458LYDiqn+E1p/IT94+?=
 =?iso-8859-7?Q?WsYCodtq/uPNKkPnRHCavLM25qh6yV/3uHm96fjPlmjkAreAndk/Ut4mEa?=
 =?iso-8859-7?Q?FVosU+jB2f1DUk91z1yb6pncQD3g75HHdcrrgpFvJ8/tr26AkHncrE5O9M?=
 =?iso-8859-7?Q?tiuj64h1mFWG9cvR3Q5ervZIumAAxRhVJ9atlfS5OaTqa8m9C/nFV5kzwH?=
 =?iso-8859-7?Q?7Ws52AHB7cypSb2jgvdcEDTobgd2eZnp9h9mj/TUcpLaYdinUMJIjfzDu1?=
 =?iso-8859-7?Q?LhjLPP6yFrz14EqeMzWb85q35Qg6aU5aIAvMyjhXLlOVzwU04RsnuWhRg1?=
 =?iso-8859-7?Q?5aImkzDTURcYMSAr6IhJwIXcagZlGD5l1EYSPzsRabPDabAp6v/MHBpceS?=
 =?iso-8859-7?Q?gqjU1t3GCGdDHvUmh69cT+SmIv2ZWw8XEgge0I5+J032obORxd7D1ui5EA?=
 =?iso-8859-7?Q?dWM65fVZnJm8HEfXvAVF4RF0QcEbtk7aoDzD+a+6AqNbIVEnAUeCrHJU+2?=
 =?iso-8859-7?Q?Uq9Dsux0o9uQmHfq99fPHYKsDBDcii04Zl5HAEDyDQojV1blEyi18B+5oW?=
 =?iso-8859-7?Q?1Tdtzdw+KwQRl1tJIcaJrbnuTG19yHsL9KEHIyZhFuezsYkHZSiX46MqnE?=
 =?iso-8859-7?Q?AHLy3ygAzGYNKGd3vQSvSxzuKuDrEgnCJ1OCR7Js32O1guzEqso/UIb12d?=
 =?iso-8859-7?Q?fNDlrVZv98?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-7?Q?AdRRYUIoEHcRfqxWnG0yPTI7K4faMzeS2MFJpaADYquQW+Hs8DWt48BhLs?=
 =?iso-8859-7?Q?/Q6SvR2RYnXeyskJ2zegIBK1bezTAKfOeh6jKaEseb7w1R0ACb4naO+BGZ?=
 =?iso-8859-7?Q?KVX6Wza6007nrfZH7bVAg/eumZQV1zMsscMFTkxeIjHgxBwpil0388W7VX?=
 =?iso-8859-7?Q?eQ9aPlbctPWcoRxUVl5AGMhZAS/3AWePZ5FJUj0MyoqyaIv55Kbt/5UzZq?=
 =?iso-8859-7?Q?h5fBcHAWOzjZC/RrojL2nbRezZlxXMaMMiaZ3rKhqZ8+StJAH10E+czkTI?=
 =?iso-8859-7?Q?95/52u30Mkx61jYaTABW9pE2NUAIgVqDSGZSKXhvvQB0jEBSpoQlPx/++s?=
 =?iso-8859-7?Q?X4p5VQ0yaAHnzNoZ+Qxy7+vfp/TPQDZ82nd2iVR0RaO/Rzp6hKt/GK3gHC?=
 =?iso-8859-7?Q?9WN2dNVEuF+DGwTYHPGsJmpe5j0DkpPBns2StbI0Pi4nfzqxN1lGfdglt0?=
 =?iso-8859-7?Q?yyEbLGLEFd0VgDMytlnmDY4Bs9dUEuFidSbj6H+KqYgfrJ4eQQKRQXxlAE?=
 =?iso-8859-7?Q?g0dmks9HDndDozuH86m06z+awQggTaYKQvWGksp7R2rQFmxwHejS6pxpxB?=
 =?iso-8859-7?Q?U9lm1w96cbDx2c9elwX/UcsLJCbqmcweA77DkmTghcaVAGxkIQCAElmFyn?=
 =?iso-8859-7?Q?E3wqzaSqHJ3BPoMuh33eWRZ7G6fzPUM7KmHWJNL+oZFvNrFUlC+8zqCaK0?=
 =?iso-8859-7?Q?yIS6kCZtGqq9G6bzrojhHyQbNptjLb5FUqVEkQFsWq0X8h+d0SHx86Er0n?=
 =?iso-8859-7?Q?cq+o1IUag/d9hP3a+2vO0tCOgLEOZM+MruQzbv8Q4Cl/E8hPwbwPT//24p?=
 =?iso-8859-7?Q?zL0HfCE0vsQzHIwUKJiQwh9uqldkXhyrlMDQ4k08V/PgQMWV8x9j4nmriN?=
 =?iso-8859-7?Q?5CeW5QoYlZKG714XEHSpHk3rT+rjwsTCZObsc4JSlumqu1jXB0Qb3hGRGA?=
 =?iso-8859-7?Q?EIlqG7xmu1Rdr7yq10yEFewEqkBiu0/PsnlIjOwMnCYhQLw8cN24+fT6DB?=
 =?iso-8859-7?Q?806gupG+SJuRlYdWOl1BZ9Zw5tJ1ibDoEM9XwdCyORnY4u7qPIdDlCSZov?=
 =?iso-8859-7?Q?5c/ISG3a4ePfhCV0yjkcftj1arz/H7aJo27fxm8FM4LS7cHuv+fmTYLKgj?=
 =?iso-8859-7?Q?QbX/uyRGjnjLM1m79c7OXCjxeBaeI4KhEXlUXQTWW5jmPwK0KPgf7fbS+5?=
 =?iso-8859-7?Q?MLM72mPTuoA8hdjn7KULYSGiLzDmiOKVbTxyQ39WW9zsd4PBcEYUVmX8l2?=
 =?iso-8859-7?Q?eoHmlcF3x/I05cdtLs/aRk0TK2hx9UNjlD+fpyxk0bo7/7/hzdsuS+ULuO?=
 =?iso-8859-7?Q?vg+Z9rwLUuqEeWjT6XdL0co52iFxSG9oDX0YBBkunx2zZJ2xK4AY0CJsdz?=
 =?iso-8859-7?Q?q1R+xcdr8XDzw68UBijOD16STdprSMdfdKIk0zH4Q2eHhed3/R5Li0Osvh?=
 =?iso-8859-7?Q?4fPJQHYLJ3CZaG4eAQSN2Mmiy7Y4gdWwXqa5Gvk46LIOb2IR+iODR0qxKV?=
 =?iso-8859-7?Q?qiFLn/7MhaaqajBhd6zHWEtvCjuLGCdblzF8Wn37LUCpsw2pP4w+dffg1S?=
 =?iso-8859-7?Q?Lu/62hQ3M4kucs2Q9gT0tShQ3RcbnH0W851GIj1+rYAeryF/5V0sQ2c5+R?=
 =?iso-8859-7?Q?gj8dlzvfmP7hKlaou4orIsE+cSvvIZR4MU?=
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0543e981-6e79-4a71-9944-08dcffd2235f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 08:48:38.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yqNXZNSENsRvDu+aiKyDCJ29z7B1KBdHlosDdKfWaePqMn0jSPxc77AU0rgXCAtaGa6zhoLWqcMxUJL6RSfVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3034
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: kksQm9_79Kde-Zjuq4Xq4sx5AbcseA7c
X-Proofpoint-GUID: kksQm9_79Kde-Zjuq4Xq4sx5AbcseA7c
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080071


> On Thu, 07 Nov 2024 20:31:37 +0100,
> Stefan Berger wrote:
> >=20
> >=20
> >=20
> > On 11/7/24 2:06 PM, Stefan Berger wrote:
> > >=20
> > >=20
> > > On 11/7/24 7:38 AM, Takashi Iwai wrote:
> > >> On Thu, 07 Nov 2024 13:17:33 +0100, Paul Menzel wrote:
>>  >>>=20
>>  >>> Dear Takashi,
>>  >>>=20
>>  >>>=20
>>  >>> Thank you for the patch.
>>  >>>=20
>>  >>> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
>>  >>>> The TPM2 ACPI table may request a large size for the event log,=20
>>  >>>> and it may be over the max size of kmalloc().=A0 When this happens=
,=20
>>  >>>> the driver
>>  >>>=20
>>  >>> What is kmalloc()=A2s maximum size?
>>  >>=20
>>  >> 128kB or so, IIRC.
>>  >> And according Andy, the table can be over 4MB.
>>  >=20
>>  > Can you copy the contents of the file on that machine and tell us=20
>>  > what size it has:
>>  >=20
>>  > cp /sys/kernel/security/tpm0/binary_bios_measurements ./
>> =20
>>  Actually, you may need to have the contents parsed by a user space=20
>>  tool since the driver does not detect where the actual end may be:
>> =20
>>   tsseventextend -if ./binary_bios_measurements -sim -v
>> =20
>>  This may give you a feeling for how much is in that file and then=20
>>  you'd have to truncate it into half for example and see whether it=20
>>  still parses the same. My point is that we haven't seen such=20
>>  excessive-sized logs so far and following the parsing above we may=20
>>  find something like this more useful than allocating possibly large=20
>>  amounts of memory that a buggy ACPI table indicates (+ notify
>> manufacturer):
>> =20
>>    if (len > MAX_TPM_LOG_SIZE) {
>>        dev_err(&chip->dev, "Truncated excessive-sized TPM log of %d=20
>>  bytes\n", len);
>>       len =3D MAX_TPM_LOG_SIZE;
>>    }
>> =20
>>  If you send me the log I'd look at it.

> It's rather a question Andy; could you check give the requested info?


https://elixir.bootlin.com/linux/v6.8/source/arch/x86/include/asm/page_type=
s.h#L10
#define PAGE_SHIFT 12
#define KMALLOC_SHIFT_MAX (MAX_PAGE_ORDER + PAGE_SHIFT)
=20
https://elixir.bootlin.com/linux/v6.8/source/include/linux/mmzone.h#L30
#define MAX_PAGE_ORDER 10
=20
https://elixir.bootlin.com/linux/v6.8/source/include/linux/slab.h#L309
#define KMALLOC_MAX_SIZE (1UL << KMALLOC_SHIFT_MAX)
The max size  =3D (1UL <<  MAX_PAGE_ORDER + PAGE_SHIFT) =3D ( 1UL << (10 + =
12)) =3D 2^22 =3D4,194,304 (4MB)

For the x86, the max size is 4MB.=20

> thanks,

> Takashi


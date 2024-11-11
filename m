Return-Path: <linux-integrity+bounces-4079-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C03F9C39F0
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2024 09:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D3A1F2161B
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2024 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C716B75C;
	Mon, 11 Nov 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="EjQWCxN/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748021662FA
	for <linux-integrity@vger.kernel.org>; Mon, 11 Nov 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314673; cv=fail; b=nm3fSeK7rVMfI55bID3HPuNbJEweouB67pclvNt2aJNOaPsBHmRftXKVOlXhpkOMu+kL6ewB4KMOnr7DgkvO1cxZdHAuWNduqdyDpkRIn++5T4/QoYzUtA3zN+bYCN/E+1ProlRKDnVqxoPBZ0PViul/FoTK4qRJVsr5XOcjkPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314673; c=relaxed/simple;
	bh=9KOUNpx7cvg/ZQwhz7Mt2VUzUbIwMastRPcdzJu41Wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sa8aMtPiHF9ORNnfkAw9s+0+dGiRMYa+uTVzVIizM/FkiJbpJn2184+2TX1jwYZJ96EKEj2fwUTHff0GZsJqBD3pMXLfTyGjoTW1mgEpPm0F2B5MSjY4pHrR5OAZOfp20+zReR5Mtlk4qbbj2DyY1/Duf7sfEbwDqujfjKz9PuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=EjQWCxN/; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB5oKBP014520;
	Mon, 11 Nov 2024 08:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=/W
	VQdZhPirIfwFV4tKMi64LMrX5fT3Vdgwf6IsPF/1c=; b=EjQWCxN/tYKhZyS0oz
	8r1/ap+VC0rvppK0etBpGa6jpxOMWS7ET99sGyHGVD6aKlGhiVeY3OTEkU+3fW3r
	nNAIP0fdvkrLCj9/Yfu3JirvvvTm0VcTsM2idxhAbc4d7c2bYIzBYky7iVH6KCKO
	LTY4ALXWpw5oQ7cTc5ClV7IEwrsykObyqyfbJgy4WKMre4HiCZ154SAE96eDVRok
	SXtlBB+NX8SoTYCgAPqm/BJUdLuhV9Oc+jK9qgwX1OR+mKNWB8nMdAsJl9mjlPQZ
	rR6WhAD4sRuaw2vvl8QrJ55SHyzkAx6F9uo3zAPEls4tm4yziEy6ywO4mth9IH/+
	4dlQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42uc4kh4kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 08:43:52 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D477F1375F;
	Mon, 11 Nov 2024 08:43:50 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 10 Nov 2024 20:43:50 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Sun, 10 Nov 2024 20:43:49 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 10 Nov 2024 20:43:49 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaxP1rEhmmHcd4Umurtlca87lnNSgrAiJ2zYsqkrhet468Vd0Nr8dnJt/zCGB0VX5hpydBPM86MH46qIwQFgGGbQ2PKZDd2r2+j2QtOd9Uzs4Xc0dQdk8cZNmjCLJsC7eKKduxe/JYn6bo/3VabrtGQSHKzmXU+6C0yUjPptuWsB0he8tAalV6wMh38z+NYKYIILTt53USDx9iLD8kszD0sgJPnTSmo1VPnIkYMJMxiJS1IcvjQH67VPI0f5cwrmSDlOq2BId/J9HuNzLkPFu1O9qim/rKMdVRqjA4C5zgZ03PLdpyglUlll1wMXoMlH4k3f4yBFiRJcDZJvFUosMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WVQdZhPirIfwFV4tKMi64LMrX5fT3Vdgwf6IsPF/1c=;
 b=OYi7vY2WB+EbYDTUqd2EJ+8efFQInHZlScGps/XD1ghfhk20INzEn0w8ED0QgjsAmXxijJb5GhihDg3TfhLMflB1aD6iTd6sQ+rFH9PQz4LjVzjWNYZir6hcYcKD6svEMM4dqJo5dt+ktxB43mvh4gRPiCw7J9vsheIK0d5O6gCZD6WXq6l8Sl+zy0P3A3Hjz04bjeeYljYy5MNDPsaho4YHkAfy8mzjnFRHeNakNq3+EKMO+EUYHI6k0ou67l86QE+3pfyeI41OT/yVFG/ex3xmNoiPnsMDufaIZ5HDcls77fw2hW0DPk36/Yo9XWxx8jlCCOdU1BeD8m7e02PKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::16)
 by DS0PR84MB3747.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 08:43:45 +0000
Received: from PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5bb3:55b3:afd7:c204]) by PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5bb3:55b3:afd7:c204%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 08:43:45 +0000
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
Thread-Index: AQHbMQcujKUx7uXr+ECzX2mQ2FnQK7Kru/2AgAAF0ICAAGyMAIAABuuAgADX1gCAAAOJ4IAADm8AgASpgdA=
Date: Mon, 11 Nov 2024 08:43:45 +0000
Message-ID: <PH7PR84MB1957D36D4A45C385E3DF2DFF99582@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
References: <20241107112054.28448-1-tiwai@suse.de>
	<87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
	<878qtvi5he.wl-tiwai@suse.de>
	<262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
	<92a9ca13-ead3-41f8-88fd-ab9540c0e9b3@linux.ibm.com>
	<875xoygml3.wl-tiwai@suse.de>
	<PH7PR84MB19575D91A43C2D4C7C842038995D2@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
 <87o72qf51h.wl-tiwai@suse.de>
In-Reply-To: <87o72qf51h.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1957:EE_|DS0PR84MB3747:EE_
x-ms-office365-filtering-correlation-id: 3aa945c2-c7d6-41ae-dc59-08dd022cf454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-7?Q?rgpRDRbkd3HogUrZsC5FukDqMRdIcY2lmqD5jV1UsMUBvdsK4QaovhSxpj?=
 =?iso-8859-7?Q?ndfRmtOzIvcKLhigOjvnHd/DULFYs+R9TnQ/UkF+D/6Psm30KBO5rFMjTQ?=
 =?iso-8859-7?Q?XDXrJ08NTtBlyYOvwlrXpYwgd2wwfhCfz0is0PQ2/q6pj5uJ6J3DNIaVri?=
 =?iso-8859-7?Q?TQRBl/AWIT72ALVl92Mfg/0AVvN95ecouRtZMFBHPD/Nhur8kBT43gqkRy?=
 =?iso-8859-7?Q?jw2UrWZGbrRbCCFoM2xEjnDM5dwiLdciqttb0Bhsi87QZfBC5S4kmupumi?=
 =?iso-8859-7?Q?euur58xGN0libFgiVeDs2kjQK5BF9PTvf5x2PEP1aggbrEPwN1z3sIqrOW?=
 =?iso-8859-7?Q?0QvTfqQnUMIRJbzb2N3+Qzu0o7zw6AWAWWmNbBgn/xEE/LZuwr96dg0BqY?=
 =?iso-8859-7?Q?maoN+lMQ5e189djxHH0jR2oydJEBW/uOFps1RzD1zmG5+ZWl8109VsSdL0?=
 =?iso-8859-7?Q?G561iI/BjGAXTrQUvgSfwOhpxjUUWFiY67BYuZv+nkWcGBqzsdiDvwghiM?=
 =?iso-8859-7?Q?ZsGU9Cxv8+RFs0Umn8jQWn6twU1yCSJ+xQJBUuVNnO6hstCAk56BjobqgH?=
 =?iso-8859-7?Q?xNDPACGZffW0Mf9MtX9f0GoEw/lxj8F0otwNxI63m4moZy+8uGxkPkZxn9?=
 =?iso-8859-7?Q?40yKWcJn68Xh3ZOuCmOiXI2h60T4HFyeCFeuCEPTZ0Hn5XIRDjptEjZFdE?=
 =?iso-8859-7?Q?f4qVO/RzHCK8W+ah2X+WqqabA4P3mjHt01FlHE4Osqyt8if+pK9+gQekjy?=
 =?iso-8859-7?Q?5/1V8vOcPs9Ilp1O7E/hlfqLstRgNPD5agAF0LqXKLbuVtMUjakrlvubpz?=
 =?iso-8859-7?Q?qxNscr8/yeMtSShWuyfU3WppaVHxjouycxHLme+7UK1/LlTx7eUUXZstmF?=
 =?iso-8859-7?Q?GmysVfw3ZMTbb8dMW7jf9YwsfkxRbKP6BHXhojPPJ/35fKMa9gi3GcjvJP?=
 =?iso-8859-7?Q?qcAgKgaBfQP7r1V6hLMwqdbgQ9K9cwn/3aJ70c1U0M6wZG5IKKjfeyjTh5?=
 =?iso-8859-7?Q?gue7nRTUBC3+70WeIWt4Z3CFFrTv6FbpS6MBAgDwtZrpRN9ySJFnYNt+Sr?=
 =?iso-8859-7?Q?/vInYNGuRlQWnqeZJ/zG0BB/rsEVER+iLYPXyENQpnlk93GOyOlQ7/rt4+?=
 =?iso-8859-7?Q?rViHrodl/cHZv279CyaCczEBU0nMlBVSySlVJOQDJ2Fqd18xw/RRQajjyo?=
 =?iso-8859-7?Q?VOcuWZxHz7bSt69LfOFsfJL4E8DUGkEsz2MkHKqvhPG0mF9Juah12RwrK9?=
 =?iso-8859-7?Q?9zFCF55n0yNfmX0CVzxLklj8ukBNV0anZjrhiE1u7+Q1dcEml30WJzlU9v?=
 =?iso-8859-7?Q?Nl4EC+gfOxkbVsYOm6GOgwh2Le9spjN2PtVJMcNU8ywfnIafIVuxgX0vAO?=
 =?iso-8859-7?Q?yiDvBVF2vx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-7?Q?PlmuA05AjAwoXY1Yf/dDBK8RjYkZYNgaF2gci3QDG/3M0RqGkMrb9Bk/XQ?=
 =?iso-8859-7?Q?bx0P4tE1DS/KIH7D3pZO56752AXR8nz377bHqHlvATFYTwGQS/Zi1pYyv9?=
 =?iso-8859-7?Q?xY5cdUvuyk/g8lgZn3IHEIgJfbQO4JMOElBqOT95BO7D5zl6ts94zK54cd?=
 =?iso-8859-7?Q?1zWZjCCrE3gGBnIT5gTSndO2EAx8DOgKkdUCh+RbwguLvtjQtyVOtDolM0?=
 =?iso-8859-7?Q?EY/wouYDQkKrkeKlS8bZkWib68xK25/0AO/s8d8P1cwdNxDb52RREaURHU?=
 =?iso-8859-7?Q?7/bKro68QkZQzpwkOu3kTigFs45M7FOmEQEfP+YSZ1sYCovpx/1iWtfqYv?=
 =?iso-8859-7?Q?ghXs4FCXhqoNxDko8awZGjzxmqF7BjfD2CxZoP0I2wSWFFVYoDrFZSDC4s?=
 =?iso-8859-7?Q?iYh4SafKuMpC0jpgtrdcg08OO+FP7ZO4wIiyZaP6LBQtzgwJuVLmbawPBf?=
 =?iso-8859-7?Q?gndREH5CiSM7xIa4NYlZb7F6gqa80qNxLT6+ccFFrtZmPYk7yZIO87oHqs?=
 =?iso-8859-7?Q?luSHYPLY+OKcuv9yxkU1zVtO0bHCETu8uVzxgD5kdj3N0DSFAdqRiBodGa?=
 =?iso-8859-7?Q?f6kNtmoobGF302VaF1MUy/RrGgWRYaXnZc7kRQz/y1HBFAOu6MKWc0BRhT?=
 =?iso-8859-7?Q?q2KLcyTPeApFBWhnED1kUqr4pG78lbK6hyoHljYnQjFkdkh690Hdsf6u6H?=
 =?iso-8859-7?Q?7TECgPd89FhUZyVGDA59+fHW/wpfdJl/SP5A3EaJW+sMqH14ufS4ajT1+S?=
 =?iso-8859-7?Q?hVVG9I5T2uQv1oE7ccgJ43PC1wBFff8f+a33x6zdIChnEEsuraFBjuCV3q?=
 =?iso-8859-7?Q?4O78bPHM8Ndv5F3Aa78BFolRKwS1U9FrMsJiz+4uadpHIHVveYzOyhQF71?=
 =?iso-8859-7?Q?BfyYwBqgH2ZsGzZKk2L9c4hB2sTptMt6KGt4cytWH7/J7KUja64KuETJ1v?=
 =?iso-8859-7?Q?97brsNNgkwCLSNHFI4vIY0neDbUaOaz7zzcYkLQ3zzPeGZcJaChGeMCDE1?=
 =?iso-8859-7?Q?KK4//g8WjOp4ZwWHH3XKNadxYoz+PfpJCQI7w8EhbzictGWujoCxvg+3lD?=
 =?iso-8859-7?Q?YELiBDWskpYzJjgDTDK9k2sMAuGfcodcibcv/vD7iPsZ4shwYpXgn2iYEK?=
 =?iso-8859-7?Q?4Xx7PgUCPWXDEjAHoZQ4LgC4fS96SkxGWgA9VGq/9DJPljlZCtsaJFnAnF?=
 =?iso-8859-7?Q?PQ/103t9bW14+cS1unm1JdtF28lHGAfFq3LRLRwPJ5DW99h4nL/Z/UP6tL?=
 =?iso-8859-7?Q?Y2rqFDwpoxpz8SjixUhZVKq3s4/bdkbMA23lk4SExyEjf6CBJ8RMQdhldG?=
 =?iso-8859-7?Q?eET8R/mCkBnuvQCwvlMLdJWwhqbm0rraBCLcSB4wnWoJZtKZP4hvjA7JQi?=
 =?iso-8859-7?Q?/0wzXieOne5nLwCnhPmO7iAvSstYG1CQIfF38A9ar+uf1NnHjxzEWmUqM2?=
 =?iso-8859-7?Q?D/BNFEiJkjiKg4pxirLD08KLpX8fZw+ukwxtd45Sky0eT6+5B+Vx87ZrFG?=
 =?iso-8859-7?Q?QBFg/9cs0iLpH/xTpvdBwLOEHE84LwyLxX3nXQ/vH36ZGLFInqN1CsDswr?=
 =?iso-8859-7?Q?/Astg1P/+IjmXxfsKVWmTmpyPvRV3JnpTBqoz7+FfcMBvrDTs5/hyMfPg7?=
 =?iso-8859-7?Q?495KPGY1ZO+ZETPBa9eph+if7SZdJuJLG/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa945c2-c7d6-41ae-dc59-08dd022cf454
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:43:45.7067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xy7mjbEFRiPiynWbLPkDGa6H/Hg0SS9wPqvlI/aDPRnM8TchLQSZZLOEQvEigjDmsIZInDMf7kgd9OVgIglK5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR84MB3747
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: P9NZW6_L1ZtHc0Xu5ZCcJh7E9nhcrfPe
X-Proofpoint-GUID: P9NZW6_L1ZtHc0Xu5ZCcJh7E9nhcrfPe
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411110073

> On Fri, 08 Nov 2024 09:48:38 +0100,
> Liang, Andy (Linux Ecosystem Engineering) wrote:
> >=20
> >=20
> > > On Thu, 07 Nov 2024 20:31:37 +0100,
> > > Stefan Berger wrote:
> > > >=20
> > > >=20
> > > >=20
> > > > On 11/7/24 2:06 PM, Stefan Berger wrote:
> > > > >=20
> > > > >=20
> > > > > On 11/7/24 7:38 AM, Takashi Iwai wrote:
> > > > >> On Thu, 07 Nov 2024 13:17:33 +0100, Paul Menzel wrote:
> > >>  >>>
> > >>  >>> Dear Takashi,
> > >>  >>>
> > >>  >>>
> > >>  >>> Thank you for the patch.
> > >>  >>>
> > >>  >>> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
> > >>  >>>> The TPM2 ACPI table may request a large size for the event=20
> > >> log,  >>>> and it may be over the max size of kmalloc().=A0 When thi=
s=20
> > >> happens,  >>>> the driver  >>>  >>> What is kmalloc()=A2s maximum=20
> > >> size?
> > >>  >>
> > >>  >> 128kB or so, IIRC.
> > >>  >> And according Andy, the table can be over 4MB.
> > >>  >
> > >>  > Can you copy the contents of the file on that machine and tell=20
> > >> us  > what size it has:
> > >>  >
> > >>  > cp /sys/kernel/security/tpm0/binary_bios_measurements ./
> > >> =20
> > >>  Actually, you may need to have the contents parsed by a user space =
=20
> > >> tool since the driver does not detect where the actual end may be:
> > >> =20
> > >>   tsseventextend -if ./binary_bios_measurements -sim -v
> > >> =20
> > >>  This may give you a feeling for how much is in that file and then =
=20
> > >> you'd have to truncate it into half for example and see whether it =
=20
> > >> still parses the same. My point is that we haven't seen such =20
> > >> excessive-sized logs so far and following the parsing above we may =
=20
> > >> find something like this more useful than allocating possibly large =
=20
> > >> amounts of memory that a buggy ACPI table indicates (+ notify
> > >> manufacturer):
> > >> =20
> > >>    if (len > MAX_TPM_LOG_SIZE) {
> > >>        dev_err(&chip->dev, "Truncated excessive-sized TPM log of %d =
=20
> > >> bytes\n", len);
> > >>       len =3D MAX_TPM_LOG_SIZE;
> > >>    }
> > >> =20
> > >>  If you send me the log I'd look at it.
> >=20
> > > It's rather a question Andy; could you check give the requested info?
> >=20
> >=20
> > https://elixir.bootlin.com/linux/v6.8/source/arch/x86/include/asm/page
> > _types.h#L10
> > #define PAGE_SHIFT 12
> > #define KMALLOC_SHIFT_MAX (MAX_PAGE_ORDER + PAGE_SHIFT)
> > =20
> > https://elixir.bootlin.com/linux/v6.8/source/include/linux/mmzone.h#L3
> > 0
> > #define MAX_PAGE_ORDER 10
> > =20
> > https://elixir.bootlin.com/linux/v6.8/source/include/linux/slab.h#L309
> > #define KMALLOC_MAX_SIZE (1UL << KMALLOC_SHIFT_MAX) The max size  =3D=20
> > (1UL <<  MAX_PAGE_ORDER + PAGE_SHIFT) =3D ( 1UL << (10 + 12)) =3D 2^22=
=20
> > =3D4,194,304 (4MB)
> >=20
> > For the x86, the max size is 4MB.=20
>
> Thanks, it was already corrected by Jarkko :) But what I meant was about =
the requests:
>
> > cp /sys/kernel/security/tpm0/binary_bios_measurements ./
>
> and
>
> >   tsseventextend -if ./binary_bios_measurements -sim -v
>
> mentioned in the above.  Could you provide the info?

Please check the attached file. The file has also been uploaded to the SUSE=
 Bugzilla.
Thank you.

> thanks,
>
> Takashi


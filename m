Return-Path: <linux-integrity+bounces-9105-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL0uMnWPxWlG/QQAu9opvQ
	(envelope-from <linux-integrity+bounces-9105-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 20:56:37 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3080833B2BE
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 20:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0CEB3010D8C
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289D039FCA8;
	Thu, 26 Mar 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XzLrsvos";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rrs2dJY7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852C3A0E88;
	Thu, 26 Mar 2026 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554893; cv=fail; b=bOjTEDj9WHY8tzHp+lXdXpmDOfYyhOEdaYGFm1qHy5zb3sb66z1POcInc4VzpK0NMNXttBtsIO3gvvlzct8MZpDwBQdvMX4RJ8qm4wGqT5d3GCQRB9ynHfUNREXL81U+UwH5B+ibpO6iiWrUujzHKQllBr0MIMHBpuyiIhRuZ0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554893; c=relaxed/simple;
	bh=f0fhvPtodh96JvMz5D5ajW1tTH+YJcv2EcHgvlSDpMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OdNWpVRrlPwiJQEC/oIBHYCigJbtvTLToZd/69RTyLx+Q4TU0MYyFy2nLL+M77IDfDetKqU1Fqx3gPNp2RfKwBDKrp1dFvOWSYFDfmR7tJsFjb912aZVOh7WfmfPNOpezXpN5xDFq90zMnBws1VyE7fFHVWpLb8S5XyCvAX6SME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XzLrsvos; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rrs2dJY7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFtvOP2588373;
	Thu, 26 Mar 2026 19:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ePPsBRoLV0H2FvodzVNTc1QtGaUnKeD3vFlQQqlv3LA=; b=
	XzLrsvostfkNCfHMOAOLI9oeN5lq1mTH2rwzImG4/Z/i2Pq+C8DIrdqHKhuAnRHh
	i2QE9szeeaeXsvT8igpsE/Wuv5aQH0k9Qfdk5qyRct0AsBNXuVURLU54/mBNYTu0
	lgb1ROrh+pQo+YNWhlhHr+S45rj8AzCcRF3bqLJSXLST7JpoIM7pS0DYcc5Kimrz
	a29wEEObc2UDihHyoTUhGUNXFJfCGvPZByf1q+7benFPpLtn9iEfhZ2mI6i7QTWJ
	OxarwAVOQDmeh/GdS5kQbUvjdPsqeWijGc48E3aTJ/F9d5muZdRVC5GLgmZkWtIE
	tPxYreV+i1VT0JDLNHLmzg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kja8yhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 19:54:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QIxGNG012371;
	Thu, 26 Mar 2026 19:54:40 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hskgqwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 19:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgDXoCPjaKJpzW2E7zc63E0I80eccZPNFqQfpf1KmQveUf3m/1IyliPWW/BBg6dR7MKVQF06oFvUMeoXJyFFbJ/Cw2T6ZSJYm4Da6vyyN3D9BTfYGRVtEcy12JWa6QYhwVGy7qEl/c/JZlxH8dyURgBGO1vgsrVz+z1/SrDCI5tGqSF0ArLalKYuT8bLA+qsXpKDsVORC2q1AB5GCu7DUAMHSuavgNUvnKxS7rxEamrQF11UU9BUVFFpqGzRjweaTUJNQwP3RN4MDzKSXDTmBQQc2wNXeN7B17r27bhwr4aOoKVH5lvL4AhFZWDJ77qhENMzhdY+VFO+ln7oYIm7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePPsBRoLV0H2FvodzVNTc1QtGaUnKeD3vFlQQqlv3LA=;
 b=QJdgGeXm+cl4/i4EhlpkstPbYnIKK1WbOvPMSu7e/qfNU06sKuuEg+jKJeb2KgPFCP/V/bvFO62mqzEzr/9QON/nSVg/V+Lc+ogK8GdmIKN7mAEpbzU1/CHhVRqzTWUHo7oh9x9i+uSN0s/bpt0vBj6IwiCOnnD5m/6rPHhjjOPQTooso/XWdiFSDEbPkh1IVHj2ZZMDXbzluCC2pFDPWL6DhEJFm/t1RooBPBKkNp8GnVGjOzfBKon1jw1O4gjHyvFtiNcyNaN7v1/NS4hk1ANfgioFu6XWfPCAsZiHDP4uKxP81dTg9X0iWGtZ4q2TVQAClBo09YNJUHGvhH+Sow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePPsBRoLV0H2FvodzVNTc1QtGaUnKeD3vFlQQqlv3LA=;
 b=rrs2dJY73AUi5MRp/b41cWQAM0X2tblUWpG5Wn9NkAgd74PT9mVWIh5BFM0aDL9Q9/P/RRSdVjrGAd2bzBbzNe2m/xRtQcbsNdt+JcFKMLOsDmdvIvjLFIUvhYRyW3TXhQwBX+JVIi7lU+x4tBR/+Ch7dv7Cg5n4/4Fr0qHhc5s=
Received: from IA1PR10MB6830.namprd10.prod.outlook.com (2603:10b6:208:426::13)
 by DS7PR10MB7299.namprd10.prod.outlook.com (2603:10b6:8:ea::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Thu, 26 Mar 2026 19:54:37 +0000
Received: from IA1PR10MB6830.namprd10.prod.outlook.com
 ([fe80::28fd:197d:70ed:9f5e]) by IA1PR10MB6830.namprd10.prod.outlook.com
 ([fe80::28fd:197d:70ed:9f5e%3]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 19:54:36 +0000
From: Alec Brown <alec.r.brown@oracle.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko.sakkinen@iki.fi"
	<jarkko.sakkinen@iki.fi>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        Ross Philipson
	<ross.philipson@oracle.com>,
        "dpsmith@apertussolutions.com"
	<dpsmith@apertussolutions.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kanth
 Ghatraju <kanth.ghatraju@oracle.com>,
        "trenchboot-devel@googlegroups.com"
	<trenchboot-devel@googlegroups.com>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: RE: [PATCH 4/4] tpm: Move TPM common base definitions to the command
 header
Thread-Topic: [PATCH 4/4] tpm: Move TPM common base definitions to the command
 header
Thread-Index: AQHctigMtmRk1QR5uUS7dyPiHd64q7W7o1eAgAWBZhA=
Date: Thu, 26 Mar 2026 19:54:36 +0000
Message-ID:
 <IA1PR10MB68309FDA0D5450AB2FC0B5BFBC56A@IA1PR10MB6830.namprd10.prod.outlook.com>
References: <20260317160613.2899129-1-alec.r.brown@oracle.com>
 <20260317160613.2899129-5-alec.r.brown@oracle.com>
 <acDSwWnogOE31B76@kernel.org>
In-Reply-To: <acDSwWnogOE31B76@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_ActionId=ef42976b-5738-40d1-b88c-25d370c207ad;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_ContentBits=0;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Enabled=true;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Method=Privileged;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Name=Public;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_SetDate=2026-03-26T17:47:01Z;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB6830:EE_|DS7PR10MB7299:EE_
x-ms-office365-filtering-correlation-id: 17f2918e-793c-4c87-a966-08de8b718251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 xgyqHxkjXJJ33G86maPUiPLkZn6KB9C09+1KsEBXwBSHmp1+6nE7e4eoF7rf3cOKdZpC/OcYOAILQ9g4BEVpIneQ9CvKz6Zndygv/NC9Kbuu+8o9EoPMAfpDF424pX78Tiz+Vww1utX+h+kLgZNMjYJht9fEKn8ByqeBNyhG8qlhRWaVK2oUWi8A/eFpwqSNiEXnhzWFiR7N/oACI+a4RApfzeKz8fZak4c+A3/fU6UrttEDUdutaXMc1gxTfv7R8mwtc2Av9/BaOWnSm3TWmZd5PxWEFr6AD5NHmoNwF/YxI0QxoON0vIwyDyDEBr4GNOZ3dfOS3lpkbgMxpiBkKs2SfjGsTSYKowh6RKY9HMvF4EzmBKxd4qC8ipMzDkur3r+242Hi5VvFLO1xU4e5ar9eeAskyFK1selEZ7Cb8/9Xjyb9eu/vlyQKH6BE7GYqp7hsLkZBXob4zQNPkAEumTIVqrDr5bdaMYMrCGfZWczke7YyMN/3G9ttqqRm3u1VYZ0qEMS4e9hXI6OS/a28e0JO8K2MLP5WJfvE3VRmNGFhxH3HOTxPoZfbWZBu6ncLxm8RPYj1rEAbEXMnwa/84GxzqBr6ZVoBBDGdOzkuZuH9klc5HPb15DZV7yv962iRxN87qJl0q03yfV/Jz1E8Lmz4QJx8zpt9IjDrJ2zf/eiShXklQYYaFCokUjO4fLRfZO1AIkoUqBJ/hi9f72wDt+HHVm53IsNfhnOBOlPwUJX/BpAKLRggbM3mBnQVymCyJ6A6PNi28gE5jStZcmKHAKieK1/blIYUl9ZtTuLg2LU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6830.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IS1tVe9C8p3CbJbO44pangn6KbnOYjhhua9LwavWAYEqj4xVJXyvHz5vkdj0?=
 =?us-ascii?Q?iQ2qTs4+JyN74MXfvUr/Bcmh0NCSKwMVYbJDPEBgVeFf6j3Yv4/x2mSxIBZX?=
 =?us-ascii?Q?VEGDccjdoL+ZJPDeoIZ3y23vjmquSicoWe0B9NWqPDwVSY6QX0Ki3bIPo/GQ?=
 =?us-ascii?Q?SdN1HbRjg2XlrJ5GS3mRa9BqaxL/K/aib+OF0jh8YIXRxj7ed2NGx6eg9neZ?=
 =?us-ascii?Q?a55nIRuMmYxqxsQetZ73JI3Xaw2pyzaOh2xiko1cofmtwJLfVU4zhPgN2XOY?=
 =?us-ascii?Q?1L+wCV4iNiPMDcZ2Sp/zUa1QWuMQh+THKHRAJHdIRPs96zqTt96vMC7x5mz5?=
 =?us-ascii?Q?zQQQcR6XTxl4e+mpvmPz412ZpL+5Oz9Pd4l2wiEb7xhYKSN+qXUmDqdg96A4?=
 =?us-ascii?Q?V5K2sV/KGb+uXbX6pnfx50sS/odoYeOxMt6G8d6FBi2Qoa7zWyZEXk8vR+zk?=
 =?us-ascii?Q?7/w6pTDz/MR3jMsDnsV9pF/Ffy+Wcr5rzeqWYEfqNv4MakHvHzFILPezmHel?=
 =?us-ascii?Q?0inL0fv3PTUS8+TmvZGVy2cH5YL0E9NvKD5WLiWlVauurr95WeK2LFvDECXs?=
 =?us-ascii?Q?BOPkcdm9VS3AKV/Kr2iN9kEaXt5MMRw2dmTfhN+KyG1VncerCgAdh3yuAS3n?=
 =?us-ascii?Q?f7Q1Pw90HLZf6zK8HQ8Rmf0p+zbsOMDgX5Rcrd0p90YDEgnjPJaslqzGo2bc?=
 =?us-ascii?Q?MwM8TXAWLmP1gBY4Iogd89ZcOVAqwBLlUDDOQ+x+SkrNalkHM1PAYlLLAC/H?=
 =?us-ascii?Q?tCSKBIW0OyHPfqHCPl0sDLGF2d/cQGSp9uPwy6wLfmeWkwBsvvAg3Xs9qhi/?=
 =?us-ascii?Q?PjOqQRPkwXQJlzgvEoemlUuKqOAezbn8DKtq2yZo08GEoBISzwx1MH1f6F/h?=
 =?us-ascii?Q?i3AwgDyQ0kb8SMR3NEyTwEs91jxIAs36IT644zlYSRCOdv71zUlTtS3nibll?=
 =?us-ascii?Q?HHFu9X2PTA2dx7fGpLlkKvGV6DHds2CpGr+LXohDZBbOVelGM+sYcObneJeZ?=
 =?us-ascii?Q?/f3FzDHkwfW2yYEYve3ewWYu1yGfIFMKLriDy3AptSZWm8PrJqXoekOhbtp9?=
 =?us-ascii?Q?L6Z+CsuR6BfkW9kLrxhwRr7U9QuN3MUzpqXp4SXiEU7HvCj2VHkq9LiAGpgI?=
 =?us-ascii?Q?svhKXhEIqbkUv4LLVp1UVZ6B8yn22hIdvwBmlrsDbweSGdH9ZxgsQxA38ygr?=
 =?us-ascii?Q?adPCYU7j1APPFeYz+vFh54LoKJ+5IlGL9Av+vt03Gjw/9u6Q0ujOZhSZn4PN?=
 =?us-ascii?Q?FRc+ZWZzdcvNJ3mWDd/V1A2MbIpcUeowI2vy2lEgBDWHq/y1up9dl2JvsnRx?=
 =?us-ascii?Q?dRvCtnC+unO8NeIulL6se+FVXCRaeIcG/hJ/9c16yZETiP7O0kWvqlwC5xtX?=
 =?us-ascii?Q?0r/g728bw1yqy+P9Vlp/vnujlJA7smrJ7rBCMEz8BkhAO9JFAND1/nG3Dfzk?=
 =?us-ascii?Q?9mIpI3S95oKTuuPNd89dt6k+luTdov5VA24qLjCJv5OwU66qL4uytZoL0lkG?=
 =?us-ascii?Q?78zGLmLLMMd1gSvDDQx30UG5pbrDy+4cPspw6Xr+o5ZLRQfM/ytHLwg+eUz7?=
 =?us-ascii?Q?wF3fgDCPAJx/As0tNth/KxYdNFWQ4apy+ZHrh/djlvSzXma301yJmqwYeiRD?=
 =?us-ascii?Q?PLeFsjHjwva5KVpHkxaBz+8rhNKVzQlvEvzLqqLp+SWwkbhhe1FVbFALn4vI?=
 =?us-ascii?Q?O4Yboca7w3DsjZEYxnHHG4kGzMdwHEaK4zdKCzk+Qxn4npc6rTNssG8thiBa?=
 =?us-ascii?Q?xGKh6kTE3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wO4NEbN+eWpYBYIzTedgeS4t615xMaKen7Lbo7z08WEfq4d3GS34AI7tFR3eVUtfOeFdURcPUD8wHtOtacE1tQrVo7vnzU4Orsj+jfbWGH4S6zRaNk84+whUA1uzXCG9SCfpYu946N3ZM//AVLdKupUlNgT43qVuo6X4N81WaGSoXZ32R3dXU59DQa7EyyoSIx5bQdnzGOFATJpV2sv7gU2cVKYz6eqtSswQVbgyyl3pJJqFvwdOJOd8/mhF29oI6IdXBgpeV7oSDPjLbCNRqPZIzlr/dJ5oqfvL9nYPUAfv5GPte1iIE9aEuI5qHaz/wpBXvnCZBwu+d10KtKh8NA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6eFxxE3Ebl47kvxDrOGMgBmi/LpW0ZNsYT7TTfZGsJcq6ywVyTyzPqMM7z9Uka/IjfAY+iFesPL8V7ZpIIKJc7D1h2yB97KJ6y/WzIYYoKOifcVMP7z4PEVbeKDHdCoLNS6coh1v9NjsvsweIiYOZ557w7zFglyCOTfggwV2XtwfG7M6tp6yNSh1Uhll20/DKUQYFNAUzfkX1TNB4d+Z3eIW/ala94RROs5e5tGrXtTsPrpfM/Bby2BQWg8k1e9F4/76EQ5U9x8Hm8eEEjK0FiKQznJwJv/i97mv/kBvTDqCrF7HfhZ79XS59d8PQG6V2wS1UAVFBNsNJHmuqZERwv9SFbMTv0Y8qzpSrZrzhQmk7PoshFPPIttHr++24Myu82RBgnU+hEyp94276PgGf0Y6VbfvJ7wVGZAuz6mUE2LBnqTz9k0/vRFhWtARwj3oLc7Thkcn0+qAZCz7Dz5/NGj/CbtheekvJ1n4WIE2IZ61rCTRXTD6mUdMe3x4hPP5UQ2VKBGL6+wCIowE7s5NsKe18aOBd4TGHpXyu9NvUW0Bc1U+WYy+k+BPfF5BZW4aYSTv3NN+GUj4/g/COmY9Aj2d/yde2T3unfIJadjLu3c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6830.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f2918e-793c-4c87-a966-08de8b718251
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 19:54:36.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCxdrmxLSLO96hu5P9Mell0kCgamnSebdWqmcrcfa6hjnUKr8ZxqkmSugma2k8kC4ING+hYsHFxSsNHqk65cug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0MyBTYWx0ZWRfX2sKtPCa7azIb
 n2agpJ5XWCwKu4xx6t+7pVAghUHwBWIztXoHWt7tGGVKbqXAk6TLuFslF0/QYs7Kk2xn9MLmQwL
 peaB1qqTJ1BMSZd0eTBjLpugEJPPzNfI09kdM6myR/Kr8TP7ff+Ku/N60M6ytwBQ2ratH2E8S0t
 krfxmjnovSrsSd3XdSrOkTwetEr2I4+pkv4PA0EBFY24g4Ix6HJ/2niU3/0qlEjBVzjtjOZx0JY
 gCng03IXZj8+VA03qJWVdDdltgjsqQ1oB0UtkQaFCX4iHBNcvMuHg9m8rzMRrZB47d2OmwfCaUU
 55GXMrqDlIGMAioXBIY2OIQ5nsvvQ1UgPH5YkQ1ebMrNa3qgh6dwPsogUq28D8CBpilD42OmgZf
 6goTOr/o1ZsbjG3cXIZxdvT+OjbAOEeT6dryRjfv/RMyEXVxeYgnShUXoB3N4vdf5dMkjsZlfBX
 2mpyHaCyAY/fWrHPGVxtdqdRyDlAevn80dIrEeDg=
X-Proofpoint-GUID: 1Q_UQaRykU-iUa3qxPh-fuLDtkLkqzKX
X-Authority-Analysis: v=2.4 cv=TPdIilla c=1 sm=1 tr=0 ts=69c58f01 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=UN5060LkAAAA:8 a=FZ-F4897MP4TX1ihxBQA:9
 a=CjuIK1q_8ugA:10 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:12275
X-Proofpoint-ORIG-GUID: 1Q_UQaRykU-iUa3qxPh-fuLDtkLkqzKX
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,iki.fi,ziepe.ca,oracle.com,apertussolutions.com,googlegroups.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-9105-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alec.r.brown@oracle.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3080833B2BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 1:42 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Tue, Mar 17, 2026 at 04:03:35PM +0000, Alec Brown wrote:
> > From: Ross Philipson <ross.philipson@oracle.com>
> >
> > From: Ross Philipson <ross.philipson@oracle.com>
> >
> > These are top level definitions shared by both TPM 1 and 2 family
> > chips. This includes core definitions like TPM localities, common
> > crypto algorithm IDs, and the base TPM command header.
> >
> > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
> > ---
> >  include/linux/tpm.h         | 50 +--------------------
> >  include/linux/tpm_command.h | 89
> > +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 90 insertions(+), 49 deletions(-)
> >
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h index
> > 92957452f7a7..a282b7045a24 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -27,49 +27,12 @@
> >
> >  #include "tpm_command.h"
> >
> > -#define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> > -
> > -#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> > -#define TPM2_MAX_PCR_BANKS	8
> > -
> >  struct tpm_chip;
> >  struct trusted_key_payload;
> >  struct trusted_key_options;
> >  /* opaque structure, holds auth session parameters like the session
> > key */  struct tpm2_auth;
> >
> > -/* if you add a new hash to this, increment TPM_MAX_HASHES below */
> > -enum tpm_algorithms {
> > -	TPM_ALG_ERROR		=3D 0x0000,
> > -	TPM_ALG_SHA1		=3D 0x0004,
> > -	TPM_ALG_AES		=3D 0x0006,
> > -	TPM_ALG_KEYEDHASH	=3D 0x0008,
> > -	TPM_ALG_SHA256		=3D 0x000B,
> > -	TPM_ALG_SHA384		=3D 0x000C,
> > -	TPM_ALG_SHA512		=3D 0x000D,
> > -	TPM_ALG_NULL		=3D 0x0010,
> > -	TPM_ALG_SM3_256		=3D 0x0012,
> > -	TPM_ALG_ECC		=3D 0x0023,
> > -	TPM_ALG_CFB		=3D 0x0043,
> > -};
> > -
> > -/*
> > - * maximum number of hashing algorithms a TPM can have.  This is
> > - * basically a count of every hash in tpm_algorithms above
> > - */
> > -#define TPM_MAX_HASHES	5
> > -
> > -struct tpm_digest {
> > -	u16 alg_id;
> > -	u8 digest[TPM2_MAX_DIGEST_SIZE];
> > -} __packed;
> > -
> > -struct tpm_bank_info {
> > -	u16 alg_id;
> > -	u16 digest_size;
> > -	u16 crypto_id;
> > -};
> > -
> >  enum TPM_OPS_FLAGS {
> >  	TPM_OPS_AUTO_STARTUP =3D BIT(0),
> >  };
> > @@ -127,7 +90,7 @@ struct tpm_chip_seqops {
> >  	const struct seq_operations *seqops;  };
> >
> > -/* fixed define for the curve we use which is NIST_P256 */
> > +/* Fixed define for the curve we use which is NIST_P256 */
> >  #define EC_PT_SZ	32
> >
> >  /*
> > @@ -209,8 +172,6 @@ struct tpm_chip {
> >  #endif
> >  };
> >
> > -#define TPM_HEADER_SIZE		10
> > -
> >  static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)  {
> >  	return handle >> 24;
> > @@ -239,15 +200,6 @@ enum tpm_chip_flags {
> >
> >  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> >
> > -struct tpm_header {
> > -	__be16 tag;
> > -	__be32 length;
> > -	union {
> > -		__be32 ordinal;
> > -		__be32 return_code;
> > -	};
> > -} __packed;
> > -
> >  enum tpm_buf_flags {
> >  	/* the capacity exceeded: */
> >  	TPM_BUF_OVERFLOW	=3D BIT(0),
> > diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> > index ee76fcd5ecef..25a247254140 100644
> > --- a/include/linux/tpm_command.h
> > +++ b/include/linux/tpm_command.h
> > @@ -431,4 +431,93 @@ struct tpm2_context {
> >  	__be16 blob_size;
> >  } __packed;
> >
> > +/************************************************/
> > +/* TPM Common Defs                              */
> > +/************************************************/
> > +
> > +#define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
> > +#define TPM_BUFSIZE		4096
> > +
> > +/*
> > + * SHA-512 is, as of today, the largest digest in the TCG algorithm re=
pository.
> > + */
> > +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> > +
> > +/*
> > + * A TPM name digest i.e., TPMT_HA, is a concatenation of TPM_ALG_ID
> > +of the
> > + * name algorithm and hash of TPMT_PUBLIC.
> > + */
> > +#define TPM2_MAX_NAME_SIZE	(TPM2_MAX_DIGEST_SIZE + 2)
> > +
> > +/*
> > + * Fixed define for the size of a name.  This is actually HASHALG
> > +size
> > + * plus 2, so 32 for SHA256
> > + */
> > +#define TPM2_NULL_NAME_SIZE	34
> > +
> > +/*
> > + * The maximum number of PCR banks.
> > + */
> > +#define TPM2_MAX_PCR_BANKS	8
> > +
> > +/* If you add a new hash to this, increment TPM_MAX_HASHES below */
> > +enum tpm_algorithms {
> > +	TPM_ALG_ERROR		=3D 0x0000,
> > +	TPM_ALG_SHA1		=3D 0x0004,
> > +	TPM_ALG_AES		=3D 0x0006,
> > +	TPM_ALG_KEYEDHASH	=3D 0x0008,
> > +	TPM_ALG_SHA256		=3D 0x000B,
> > +	TPM_ALG_SHA384		=3D 0x000C,
> > +	TPM_ALG_SHA512		=3D 0x000D,
> > +	TPM_ALG_NULL		=3D 0x0010,
> > +	TPM_ALG_SM3_256		=3D 0x0012,
> > +	TPM_ALG_ECC		=3D 0x0023,
> > +	TPM_ALG_CFB		=3D 0x0043,
> > +};
> > +
> > +/*
> > + * The locality (0 - 4) for a TPM, as defined in section 3.2 of the
> > + * Client Platform Profile Specification.
> > + */
> > +enum tpm_localities {
> > +	TPM_LOCALITY_0		=3D 0, /* Static RTM */
> > +	TPM_LOCALITY_1		=3D 1, /* Dynamic OS */
> > +	TPM_LOCALITY_2		=3D 2, /* DRTM Environment */
> > +	TPM_LOCALITY_3		=3D 3, /* Aux Components */
> > +	TPM_LOCALITY_4		=3D 4, /* CPU DRTM Establishment */
> > +	TPM_MAX_LOCALITY	=3D TPM_LOCALITY_4
> > +};
> > +
> > +/*
> > + * Structure to represent active PCR algorithm banks usable by the
> > + * TPM chip.
> > + */
> > +struct tpm_bank_info {
> > +	u16 alg_id;
> > +	u16 digest_size;
> > +	u16 crypto_id;
> > +};
> > +
> > +/*
> > + * Maximum number of hashing algorithms a TPM can have.  This is
> > + * basically a count of every hash in tpm_algorithms above  */
> > +#define TPM_MAX_HASHES		5
> > +
> > +struct tpm_digest {
> > +	u16 alg_id;
> > +	u8 digest[TPM2_MAX_DIGEST_SIZE];
> > +} __packed;
> > +
> > +#define TPM_HEADER_SIZE		10
> > +
> > +struct tpm_header {
> > +	__be16 tag;
> > +	__be32 length;
> > +	union {
> > +		__be32 ordinal;
> > +		__be32 return_code;
> > +	};
> > +} __packed;
> > +
> >  #endif
> > --
> > 2.47.3
> >
>=20
> Yep, all looks great and clean to me but exactly for that reason
> this needs to the truth serum :-)
>=20
> BR, Jarkko

Thanks for taking a look! Glad to hear the patches are looking good!

Alec Brown=20


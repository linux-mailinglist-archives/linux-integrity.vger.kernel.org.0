Return-Path: <linux-integrity+bounces-8362-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M5qJheQe2nOGAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8362-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 17:51:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665BB2712
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 17:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B73CF304FA39
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035C345736;
	Thu, 29 Jan 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bpi1Pvfv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fx42PgA5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF163451CE;
	Thu, 29 Jan 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705387; cv=fail; b=qQziT2ZccV6ieWDGvnXMrwJY+SPC3OIMeZ3qhNhCuXv8CAIyTCvBovtNKljIdbHrRiyjNRjhgiGhSeWzj06D81U4n8SZ6nNF4HW5GDFyahpzx94o+r0jAMX6h0EY4sXmgn+485WslbtoMkvgNtdawtU7FdT2DuWv2WrSav5IHK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705387; c=relaxed/simple;
	bh=0TdOd9FJgMN2RQQSvzV1S2UzDxyKIl/Zwpnb0y9qOy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b3u73YFef2hyxgF3PGDwmOtX4Wldl+km1uC/BmF6ph9C399iv+xlw2Lbq5nrACPwli3Kev/GJNQ3K+Br2eBPOsVjGOIIR9efQwb4ObOFhmZenzoSt1uLhZiIxcoo4uCi8H3bULoyALx6pf7+5inWEcm1tGbHdFoOmTn9+9rCPL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bpi1Pvfv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fx42PgA5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgGgJ676658;
	Thu, 29 Jan 2026 16:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=m+ixgUQzSYVZrl711H
	l/tgZFwqMVyLmTrfYcDI0yE5M=; b=bpi1PvfvJhLRQ35onJy+1Ug8f/3OvetHhQ
	T3Mb0BqA+WTBycHMOysfakDKY1qmY9ssQjXMNVFJKdTPq1ym1MdhUni3hrYdVq1I
	coHdGv2tSQYj983oQ054yjfSoZUGmaXtywutCXO2IHOvL3sMsOOheSwf8SFT1zq+
	Ia73Pnw0hp+xS7jk04y7Oo47R4fYcjvSEJDFh/75bC+8aZDBTSDnx5wTPsweDZnK
	Dc1yZ6zJjtIMNK11fC8s+k+AWtxowslTqTBHnxKjahF+hcq/hzv1PF/ktFSdca7e
	nVO8LfkEdcUGeNwIsXUeac8eaeZgcDoSzIZGqIyGmm2jT3r7XYWQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2vgkpbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 16:48:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TFo61d036353;
	Thu, 29 Jan 2026 16:48:31 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhruxue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 16:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PveSz83xdnx2dpnPnBzyNX2/ZHPWfmtktnEWH/ey8ElM3nP5nLOBdSm6/nIC3C85c2bt05EQngAGkPNGdt1rxW99zwAPLosPJjhaFKUIR7RCI68JUMG+pepMdCMuRaketTzgUeeD3mQgUpj1SPEuQjnqnei5urAszxzxUqc8BcFLC6yaf2bajwQgEhrazy/NHwJDcQJUMFXRnKtqrY9lcil05LtZ/k6Mz3fMHeza6PSKeh0/oy+nIcvybH3DjKQhxVtulA4rSImo8uYctiTGqldLBUeoxQnH2Ah0CfMZllOR1SXQ3Pc5SxvMrRXSa8chjqxoizY9z3e65PxEJApmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+ixgUQzSYVZrl711Hl/tgZFwqMVyLmTrfYcDI0yE5M=;
 b=ozl8PnZYzkVurcBg/8kP6MwXQF7WZFF/uC3Yam7M6+BIx9HMSOMZ8dwmocnfZk1aGVgq7ONLBQzRYudjI5+PTC/cQM0A4vx3uBHtxBQKq7xR6R10uwEnOAJnjsZ7snnJhSWo2BbMQSJCqWxmZv0jUUSpss+3ZBGxGBp9h5QZSx4DFkdwP7GpbnOFbFPHzdcCsbPb0WiSnNZuqsgoHotVC8OmsxrJ5YLDRJ8vunTOn8+fTICAqZi0AuSAbYG6gHqjaAoW5eblMHcyMup6DGQtfQwww24KqAaaWnVVeNEjwwjP8XR5bHyRJ35SPCzK1H5vXF/IppioBA1axR1dd5uB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+ixgUQzSYVZrl711Hl/tgZFwqMVyLmTrfYcDI0yE5M=;
 b=fx42PgA5q1IhtszX26N4cV4F9SH+wl0zPLfhI7DUI1jbb6OmTEDJqtdCtWM2YYrzXfomQjZy0bqT3wqx0XO3PDmzZOFIlIL4NyvDtgIXa7RphAAlx0m3AwmTLA5Z/LaNeVhZgKTperWlIVbwrTdGL7putqS6NEpco/I7ShZlejk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 16:48:09 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 16:48:09 +0000
Date: Thu, 29 Jan 2026 16:48:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, wufan@kernel.org,
        mic@digikod.net, gnoack@google.com, kees@kernel.org,
        mortonm@chromium.org, casey@schaufler-ca.com,
        penguin-kernel@i-love.sakura.ne.jp,
        nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com,
        linux-mm <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework
 initcalls
Message-ID: <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com>
 <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
X-ClientProxiedBy: LO4P123CA0441.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 7598289a-8fbe-40cb-27b6-08de5f562ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g65tFLNChCAQE9w0RXtIwXd4u9zl77B8OGt1Ht5p8L1j1AnXNRbuH2CaToeH?=
 =?us-ascii?Q?sGTytvA3S3IBOAqgH04OS0cUxYZ+YRfUodNRHlqOEdhV6WAZvuVBLl4JMDSt?=
 =?us-ascii?Q?zZAo20ETl8bBjhGjvu3M/bpO7xMBsLG+NTBraZc4dT83VvU8tepw1j7p6wzN?=
 =?us-ascii?Q?0rsFXC4qZuuGHTloh7EL3LnYZXXxIheyz7iEZiO/3Vofwv09N6FqcFmlFKtQ?=
 =?us-ascii?Q?RCpWW2fBd4rmoVwXiM9zO/cPuWNMrDGswYFWkOAGcqlEucpGgY1MgKNLaNYS?=
 =?us-ascii?Q?BjADEkDEk8YQKMhCAGjHgkEGm4p2dl3UFP2RbAH6kffgcIeLoM47beZSUUxr?=
 =?us-ascii?Q?qupncSm1lkTm/JsUKJ4v51nZoVhVF6+eYHe4ad086d6SomXEiVIMX0PXcZ5V?=
 =?us-ascii?Q?p4XovnZX1VtsPua4uvEnj3mJ39u7gnjpRNxAwbN9Tr7sYrSJCmZUK9Ly2tBZ?=
 =?us-ascii?Q?WBJx1oPkIOAzXBv/jaFtB6RpbTL/BqQkPfv0ENc/Uebfi5FBeFPLmzkEVIhd?=
 =?us-ascii?Q?OFivU3/rL0s2lVvlihqoySUkaXVStOPuEMOHmN+7kgZH4WDnNDPHtNw94LSQ?=
 =?us-ascii?Q?rllre34ILCqfuiyRV/7kPn8tvdZOBoo3Com0QJNEpGP5teA3n5NYJFqtU7Cv?=
 =?us-ascii?Q?4aUo5anz1fTuqfrgFx3Hvb+wmzz5ymH6Hhj8xj4+hfQNDj7xARv2NlP30uDS?=
 =?us-ascii?Q?thHZYQM5rhvmg3adN33iJ3ng6gEWIZXBLzhXRQbOvDtrQ6xwTQO8MJQuApgo?=
 =?us-ascii?Q?4yno0es+fvABSafi7wGYEJRGPBxhLLTqKd6JFsW4VRJCO9BbTR2587+M2Bj0?=
 =?us-ascii?Q?34IpcH/MeANt1lS4lUGQKpfiUJOooB4u/TnEja1z9f2rk022mFNQLUaKd1K8?=
 =?us-ascii?Q?F6ZMLEO3M+5wBxeT5nThTrQGKVpm6dhCXkTjY0YhcvIgUuEu6OwxLoXI7hDK?=
 =?us-ascii?Q?K4ji2oZFrlJmMs1VkHNpML+cW1Vyh+gxVWz4EmQ+TfwNkOhI+YpT06+GQsAW?=
 =?us-ascii?Q?8VCm34ljLivaIZ8PDt2KxnmlTBowgkOQfROeVOv2B7CtYrNd7wtYgckBUNbU?=
 =?us-ascii?Q?vO8MRM4m7Xq1rkbjAGLWJlYmyn3oQOuBT9mvmfAJ5sMvOvCuXyxcL5NvP1L1?=
 =?us-ascii?Q?iOwK6Gj0c+Q2rESpMjRz/B4e1n8cm4kb94Crdz5ElRf/Nbcxx/ajclWU0Mzf?=
 =?us-ascii?Q?e+HiUZcqfcZUsb3a31dT6TGJw0nbVneSTOUHCCcj7wLJ5Clfdy7VepIGKjIe?=
 =?us-ascii?Q?4rpWQu1bgfsGnPmdfM8YPVVdUE1l8mHB6Yekgo4KY2GzEv5I6CBanpfrgGBN?=
 =?us-ascii?Q?TQP71l9XxL1+pHifA36Tw/vRR5vR8UGZ6C8vm9tUxTCAwSJkbrENnflG+xOo?=
 =?us-ascii?Q?xkmeOwmqalRbm5qbK4R/ZAUJzFucf95Q2Lyjvw5r13vGqeoUoVPGrgDxmlEy?=
 =?us-ascii?Q?37sD+1HFF88bR5j56zw4ic/K9/6ua5KBYLj+o7tSlnyVXhZxCaiyDt0Td0Gq?=
 =?us-ascii?Q?dtFXrOVaIHgn+BFq915rcykp4Jil9MH+A0lfmWiagE6BJ+QpW+eaezHO/fxN?=
 =?us-ascii?Q?Na58aReZ6PJ5v6FfOLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jYg/2eb3Xl2foCuFE5JMIy8cwCgM6FC9onRrTzqxw4/010wN8gNJyEmIqATx?=
 =?us-ascii?Q?vh9olca7yZlwi4TgpxAZlkAWq/v0R0BiC0UKvvVqjUePpjasWCJFe8Asyqeg?=
 =?us-ascii?Q?o4beQp+rA+WeL2PHzv36R5pG5rr3jva/YdhwbiP/sfMX8dayc7WowmWOmLlh?=
 =?us-ascii?Q?sv07ro074E1rliOxmguRq87HI7O539TRBgnmCbDKtC/nvZ90pPL3wTcsb3KM?=
 =?us-ascii?Q?pmLnsceXTnuG8zFMKLZURbWDQOCw+OPwL84CkolxHholBysfhJPwCBZLW+X1?=
 =?us-ascii?Q?c4KwhSDNSUh9gsGGUSWFwoTlDbGxoKQy0uDmDBJEeiY5MmsDSQf54zwl63P8?=
 =?us-ascii?Q?o01khxo+eR+7eDI/NjwxTrYwe9OGsthQ6LPcrHOwr4AiE2Zmpjd5rhLl3By6?=
 =?us-ascii?Q?AuSDvQwhNt4XOjkHOOnVoZYvj/Ditzx/RuqIB6BPBJ6d9y3tEyeBg2kUk6nR?=
 =?us-ascii?Q?8Qtd59sfoE1b1D1uZHsW4S/Vl2U+o5SDlb+h76A5WLJA2bxlTNANteIwXXW0?=
 =?us-ascii?Q?groi5D17JIQGqlByJAjUSaHIy//3//qpsMA7rhc5V5JrheLto/JhDHpuTCRT?=
 =?us-ascii?Q?pUKy5a4lBoFkq3wtvfOwHfSzWEwr8R51yxU76TcrvZG2nqMZKhnuYFNdxYFX?=
 =?us-ascii?Q?Ag6ENkKUEVQfgPiuGvXVg6y8oDGiSgFwhUw91w8zu0BDtAIx6EKTjLJ84ns0?=
 =?us-ascii?Q?tkDYEFBjF8OWzgUN/aNUcF7/lSq7NcRKJMdg2LRfYOKJjY9QZrT9h3jxrimS?=
 =?us-ascii?Q?xLhAJg8dDZcihgRc4Pq4NNxvMp+KZghpL+qyuN9u4Uu8gfl0C1r6qwkiwEMh?=
 =?us-ascii?Q?IYKnL0avfe2VYneXIz1pq9Luax9zUint406//HFdJ2lXVlmmn1qQ4kXicaaI?=
 =?us-ascii?Q?6R/MI8GqFgtP2nmeHVGcN+VMyHoZsUOKPP6QWaqiMP8mUl+Xov7mXhub71Bb?=
 =?us-ascii?Q?J4+fGHD5muCZOwYh+sMlDm8fn84CrTtCE45aWjk5Y6zM0698ol5AcnTHttDh?=
 =?us-ascii?Q?swcv3gbdqIf+CMDIi7SRMkakKKyoADUrg3upfd8+4C6mMhqkBIs02i/fYsTV?=
 =?us-ascii?Q?GsjqOqQ8H8kmTFc6ADltT7unvO51ziF8wZExujThvRipm3LeyEw8obumgIi8?=
 =?us-ascii?Q?Uz5RaKQGrQur/0ShXAfo+Ge8GuX7x5e1+DOX7bvRZyp8SWlMxFDFeweM2Dvx?=
 =?us-ascii?Q?zdrnFNenc4Q/6sNqJJHYeLegGFX4cmG6dJ9X+Jd31Lf+3Qj0mhRV081rF9+7?=
 =?us-ascii?Q?FhTcQaY8D5uohX3s6TGj8totBysbPJzFIsH4qafFMj9D+qpTQtiVOCKGCgGk?=
 =?us-ascii?Q?hnudxEkz4quyjJb73Qt48v2TA5uitjnfg7SUB8ZwW2X7hzC1HeG8h3dXBTL/?=
 =?us-ascii?Q?F6+aj/R1ioC0fFEurX6brYfd4PXGTQWt3xqtqFrer1WBlsSH89Ep+V53pkwM?=
 =?us-ascii?Q?H4dZltUlbmYIQE3TOHweDLBvkM93H931uA2oYIm/ybK2AGJ+fPEmnUXGAeYN?=
 =?us-ascii?Q?q30G+KP+xxkq60AAxrzWjiefPOeOl40ah3TmjY52BfNFTLvyhVVff7bYH/q8?=
 =?us-ascii?Q?KoliVxLl1yoo/iMWUYqZeHbAkAr6nswpllTOvg+OChIV48b0/XINofzrwnY6?=
 =?us-ascii?Q?kQo3ysPdqJAaPFW5Seb4ltfmd70h+83TeqZd5czkjXO9u5m1ZqBsRNXy8cua?=
 =?us-ascii?Q?+Dta0ba16XGOe1ZcJv5sHbKNfd5qOB2bS7sRjEJf4QfcVTKi153Xqt1pN3JU?=
 =?us-ascii?Q?Pn1hOBfrg2iYdOlb0OS7HTE4GwU8pTc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X7rg28+znOAKSU5qhAjzTAAioTD9JxbwbKDZjNSN0qGLqjVge2OE+45HjJp6phCHZDfaTZK78OFWUivbaK6cAkZwd3aTQE/rnVp0J+idDZXKbHAmiv0wUH/uZtZ3/A+LYVFyFVa9udBSda6t/ZJcsh3cMmkGrIKMA9B8ass9H7uzIinBRwQfT8tRJ3clKSOjsOgvje26hBHRrfihXzkRbr3W/kROUozPGkiax6Qn/9wL6cUeBSJJ3psokSuDsv0YA69kZsZwEPfgaEt16WXbjrv1wuwiHKW4pKIj+uLQs9JJQ3agoJ2cryeEz3nqpaHGsE9vZc9N265vLuWk5fYvsTTBAPvKCqa1w2FvTiZrnCz7N8wcYfNWkxRHSCLKJ8CnD5zpk4wxwCHLJAztr418nIoesuOB5yAK6JlNV+K6oxxS9KodfQJZ6nDUYKcH5jC9lHvgdsWGbHVKKjgP1iTkR4cHNvCSkUzJPyqMfMFsCUCKxfAgme3kzfP6Me5Yip6FJeWdjN5vimcD+Ld5Gj1Qkka8q//FPTQjXgAJ5SqDrxrJVqbOvu+zwERnK6NZdCg3h/hdsOZiU6zFGfeXC305jYg56Wx/+yg9VjaHf64UenY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7598289a-8fbe-40cb-27b6-08de5f562ee8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 16:48:09.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UOCHxzdoJd0DBY+otCYexaFBzcrz0j9ii0PX9TM/580Lk5vtXCmqPcTTShhMvlsuNSl6YgFr46w+WtlJE6sDCEstiYzRtBSOyNh5/9atC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290118
X-Proofpoint-GUID: RRmLWuG3ik5zyUtvIylxp0iP94lirtfW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExNyBTYWx0ZWRfX0/qYXnDDu+SB
 XRO2/6iMKsEScwTZ/YHeRn3xCXBISyXMqk25k+palfMqkuEQch63GUH3u88uyCGB8TrHCXxgDPe
 ARH1GAoW67+zbu4i6Fb20H4ouDyQZvWxIGuUzxYTaOxXpaNG3nsO4lv9Jh0cOq2LV+fMhBKXahk
 mExmgG2e2haUvA8asB+Q/PBDlBC6vLMJXVUQ1X3BbBJDZwPPuSeWetLBektbLaCU/0cCOBUQTul
 d327ondWjxhhbxcICxCPQKp/AoCEQbeGRxo6/EFluj2gCdiNmqrOSNrtV7v0xR93VnKbgivVdJW
 cOZw3j3q79K0dfK4s5WrSr30QYLIIsuvWjinCDqbxjgR2uMfhdPhqMJT9USAJgEIM6587DonmQu
 HqLJap6SBAWBcoo2q68KK/CtgeWX4BdCZmEwzrahs+NUo3SW04aauH15+3ib629eemYTdkXma1z
 pBdkw7GqGceD0SZxInkwveILMwNhI6FXM+FxhYXw=
X-Proofpoint-ORIG-GUID: RRmLWuG3ik5zyUtvIylxp0iP94lirtfW
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=697b8f60 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8 a=xVhDTqbCAAAA:8 a=LIqmfhf5tv9GQyBJQXIA:9
 a=CjuIK1q_8ugA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22
 a=GrmWmAYt4dzCMttCBZOh:22 cc=ntf awl=host:12104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8362-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lucifer.local:mid,canonical.com:email,oracle.com:dkim,schaufler-ca.com:email,paul-moore.com:email,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1665BB2712
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:31:16PM +0000, Lorenzo Stoakes wrote:
> +cc linux-mm, maintainers/reviewers of mm/Kconfig
>
> On Fri, Oct 17, 2025 at 04:48:24PM -0400, Paul Moore wrote:
> > The LSM framework itself registers a small number of initcalls, this
> > patch converts these initcalls into the new initcall mechanism.
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: John Johansen <john.johhansen@canonical.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Hi,
>
> This commit message doesn't mention at all that you've removed
> /proc/sys/vm/mmap_min_addr altogether if CONFIG_SECURITY is not set.
>
> Did you intend this change? If you did you should probably mention that
> you're doing this :)
>
> I mean it's a bit late now as this is upstream (but not _too_ late as we
> have rc8 ;), but this has broken something for me locally (mremap mm
> selftest) and I bisected to this commit.
>
> Note that CONFIG_SECURITY states:
>
> 	  This allows you to choose different security modules to be
> 	  configured into your kernel.
>
> 	  If this option is not selected, the default Linux security
> 	  model will be used.
>
> So is the 'default' Linux security model not to provide this tunable at
> all?
>
> Though I see LSM_MMAP_MIN_ADDR depends on SECURITY && SECURITY_SELINUX, the
> Makefile in security/ has:
>
> obj-$(CONFIG_MMU)			+= min_addr.o
>
> Which suggests that min_addr depends on MMU only, and not on
> LSM_MMAP_MIN_ADDR at all...
>
> And I don't have CONFIG_SECURITY_SELINUX set yet have
> /proc/sys/vm/mmap_min_addr?

Sorry to clarify here I meant to say - if I set CONFIG_SECURITY but _not_
CONFIG_SECURITY_SELINUX the tunable does in fact still appear (and afaict
still work...)

So LSM_MMAP_MIN_ADDR is really weird to require SECURITY_SELINUX, perhaps a
historic artifact where we wanted a different default or something like
this?

I know that we use that in preference to CONFIG_DEFAULT_MMAP_MIN_ADDR if
specified.

The description really probably needs updating.

The key config here we should be looking at is DEFAULT_MMAP_MIN_ADDR which
emphatically does _not_ require CONFIG_SECURITY and also in its description
explicitly mentions the tunable:

	  This value can be changed after boot using the
	  /proc/sys/vm/mmap_min_addr tunable.

The mmap_min_addr global value exposed in min_addr.c is referenced in
several places in mm and other parts of the kernel - fs/exec.c,
fs/userlandfd.c, kernel/sys.c, mm/mmap.c, mm/vma.c.

So this now silently going to zero everywhere and ignoring
CONFIG_DEFAULT_MMAP_MIN_ADDR is surely a userspace-breaking regression and
needs fixing in rc8?

Which means that... people can now mmap() at NULL everywhere despite setting
CONFIG_DEFAULT_MMAP_MIN_ADDR > 0? :)

That seems like a _really bad idea_ (TM).

So this is emphatically not a report of a trivial self test break, but
rather of something more serious AFAICT.

So yeah I think this has to be reverted/fixed.

Thanks, Lorenzo


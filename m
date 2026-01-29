Return-Path: <linux-integrity+bounces-8361-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHV+AruLe2mlFQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8361-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 17:32:59 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6837B2388
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 17:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0584300A4C4
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3BA34165E;
	Thu, 29 Jan 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gmxLxBeg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XMQ4aYQq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88126B764;
	Thu, 29 Jan 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704375; cv=fail; b=uHDfcKvdREszwwVMVqrvs1qoRNHMtsmACgtJY3R/jPjWYA+wMe9D0tDccGcFw8bXPxjEdjEHk7WehOP6KHFBBuKXy4tfvUPKFciy6lVBqLSMYrkvy0KrJeaQpXE14C3qZdsCKqCOmc0zX9mhL5HTkYx/mF3ZpJrOcHnsU8dn2eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704375; c=relaxed/simple;
	bh=womTpkpXsyAv5tpXnMGyzpcrHQb4HJflNoGjgZTAYjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XFZ8t0smd752L/hh0pdZQbgiqt7pLYVnXbBPGqnMOFCPjMvUOhuoQhIMtfn3G4eVvyF0uiQ8bZbbwx2j9w5bW1Lvc0QV2izj6i6dzjLczmxNX2T4BlsHvzUee2lJSpZOl0Ef625NuhYbUn+K3ubKp61wZxT/ZwCk+78UmD4iXtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gmxLxBeg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XMQ4aYQq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgOr21278714;
	Thu, 29 Jan 2026 16:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OzYSIRRmUJ1QgaKfzr
	D3PPHFfgdzGirNVGR9EI7HHHU=; b=gmxLxBeggkHjdqCEe4ZbnMBf15mLyG7PSp
	i86bJCHltozB9kTkcg3YgIrL2LcY+YJfNAMSlcZfGkbh1MHiFlvvVyX8gYZVHIWt
	C/vqpzOf9HvkiEE3HEhwWYf437Zazzs3NOkAv+V/fmXFb7gpXf/NK16vFJCPFAyg
	ico1Ij2A9gyZGvPz4ZDbfOryfPopnIeY5E2xPDmxBYNGD6bMmgzO2Hjt1l7jScnp
	yzqXP6oT0D6HqSxKYGg5oz+QgNl742jzXaSkRUU1NnbKku9wi9eudHpFw7bI07Sp
	YGhZKJtfSa6jIXfdE+ab1NOhAC+Uh4lAC5CqMXrfxXMBR7+XkJdA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2xqup0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 16:31:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TG3dci012724;
	Thu, 29 Jan 2026 16:31:31 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhcjs0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 16:31:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kps504AvrmJeAj+dKrM4JUeLqkMmXgc/4sNx6ZGpZLV8jX8Dw/OpKxxEoX8graHkCLhA4eSXdDaqY2Uwwnr2oLFnKR8Dzj6YlqgnG1g3JW1KmarucsN/a+JYExwY65RqWH/ZFgRDezTYVY256qkR8WIov5pGvrru5AIGnY9W1CvdBEoL/nRnNBYVafEI/nyaze+PgkeyxSPDDnUWClRH6TtsCuIz/uiAf4yhUGL0xuqQ09Ra2MrtqjTzFj0fpdxSbRXHdwMfMoMwqjaeeAYh/k2+eB5VpOZlqrJ46sT6pE2WwRfoOfTbPfjzTAChfww0ETymsOooYO2P5SMBrLuUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzYSIRRmUJ1QgaKfzrD3PPHFfgdzGirNVGR9EI7HHHU=;
 b=W4iMEC9WOFK6hc4yxzWCS1b5tC59WLRdcgTyhLwPKwjkd5agRU3NezP/Wx19ToOh0iHxq6hOTF1T45iqqg+L82kvx7YJKhz14eU0xf8JewZhj/Hs85qx84Z84tbqDNX9X7XivN15LBFowRrG/AqY18TyRFRZBUkn73NqmGC82NrHnBWI+8/wYLYmDqZcHddb3FhFghE+58aRfko+EN947k4keid17xFOrhQH51cVVyWbpfPxgRyD2YO2dLYdPFxxDjIRXdPRH4xNuRtnRRkHAYZWePISc9jEZmZvp0KD4wGC29Rzidfqs5JKEttwDJm8xp++5NDIcaz7UDBKNRUBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzYSIRRmUJ1QgaKfzrD3PPHFfgdzGirNVGR9EI7HHHU=;
 b=XMQ4aYQq9fZu7b36ihry1saU7S39HHtI34mMqxHNdAbYAnhCHf6/WwonqOpjPNmih6lA18g+EijrZTMLyZY3C08Uxe83wCHKt5gcaJMk+NnJNrD/6vUJ/UGpm2+8CfBZf3JcljuOzb95Wr9n5ME2Y74B3ibsF0x9f7xLGu+Auxc=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB4838.namprd10.prod.outlook.com (2603:10b6:408:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 16:31:26 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 16:31:26 +0000
Date: Thu, 29 Jan 2026 16:31:16 +0000
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
Message-ID: <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017204815.505363-21-paul@paul-moore.com>
X-ClientProxiedBy: LO2P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: 7feabcdd-539e-46bf-9419-08de5f53d927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+qHmbkB+eHVBJCBx/R+uxIl4EG/uuUIpphvjXyA4dy59KzWBYC1baVMFjFt?=
 =?us-ascii?Q?laJ4IX9PGd+XMlV/dqoUtkzcaQ9N8m9nh+WvikYx4/BUDKrUMS2n0MNTMTru?=
 =?us-ascii?Q?DTpoufiIW0Kl+ME61Yc7mipB0Q+wbOo3O8ziwdQraGj1Mtsh7b1yz78fsH5a?=
 =?us-ascii?Q?6mgZIdCj6W2/zZ9rVHRtzRGyp9K/eMxpwAFTm7v274OLF2In0LGec6wRkPka?=
 =?us-ascii?Q?qN0Fga8LYq9WMUuTmYSpikNE9pWXnzFI6KTv6MNTC7YdhfNm7G4RX2/P0vpd?=
 =?us-ascii?Q?rbQi/zaGKldPci4kn5fObchs3fCrsAYxo/aWQoh+eUlmD5ymzXylLnFw10KO?=
 =?us-ascii?Q?5Z84JN0Vqsj8RE6yrub545l2cTyaBoKnW9Eh4Np+kn+6y8AnMOrdISQ8RpGx?=
 =?us-ascii?Q?JaFIeSGvlmCucCOFoB6pNWOxBiU3QuK/9EnQKe+ziuhngFTn+SZFL4WsrNow?=
 =?us-ascii?Q?1ULCXQOb5rYa1LBZOrN02NIN9Z0o+BhM2jbPeesl0FZcgV3rfZPPGWq5XvQh?=
 =?us-ascii?Q?UBgQwopl2rLjCN32tJr1gVHYoqrzEfqhi++US6jjMV8HB4AtwEcmtHPW4VHw?=
 =?us-ascii?Q?+N39Y/LCErVSOzmCF3hSKsr6Vv2BDFpCeFoG3b7OA40OJ8684O++fJkWSXnP?=
 =?us-ascii?Q?CVKqQimGiF/Azf2YMwree+jtkESABcxukOEvx4iXCZvmZB+JZSX4nFUHHfeK?=
 =?us-ascii?Q?+6jdCfcftxDOLAh7NnXSnS+jdCixxbTmBQf55WYUURIraQz+326GSyAWQjma?=
 =?us-ascii?Q?Biqy+GwaIk/s1AefM/LMCFBm3trISZEqO752A2aQoZAScQQusG0UI8C2/X1/?=
 =?us-ascii?Q?CMhcJMnUcQ8cIJu9uT15R32DT2K3PPoTv8y+YhrwqMmHHTtnCD7FHqwiBPLF?=
 =?us-ascii?Q?GAeF/GRMBw1aGCZS/4D9CUh/8XqEH32njMWo9kubyAtHYtgTyZo6eihA0t2G?=
 =?us-ascii?Q?tde7Zasu+RvMzcxAh0dRufFjSq/qEBN2VOrqqMKJzcs8mQzeZsE7n13bMVFM?=
 =?us-ascii?Q?P+TKTlpu0qVUYjzy+LYdQ3DsbadyTI+oNk82spK+WKJPpQ0XBfSucwbtyHkk?=
 =?us-ascii?Q?qJaWFUdcnfVlph/cpbo0Hct4CqoIZ/Zfg0UKzwyeAcLoH6rUkg30XxAudLcv?=
 =?us-ascii?Q?2oay20jJtN7knxYjzK15gp0LYd1U3FDR+lXWWTvAUgfnRfOR5+D2eyma6jCe?=
 =?us-ascii?Q?LIA66gTY5ykf16BmVGwIB99JGbAps6mdlSlw2v/EcpD07X9HAf+7Zd48MGLR?=
 =?us-ascii?Q?gBczipbazUPJP+VxcyNkMFF+vpi33e/H7bawHIP9e20sBQk9D2IOiEtGUAA9?=
 =?us-ascii?Q?ymlbTp5UlN6LL8g7qZROKgwi4hUmKWAoICb/YgzYWseMsSByIcwbCZBrlPCf?=
 =?us-ascii?Q?IYs2F2EvP05NUhDsmmUm9VPfQ3yYX1GAPipKbh1XjBjfObf4Rc5jK/w41C8V?=
 =?us-ascii?Q?b5GuHFk0J6Hf563Z7kbQSOKH8W9i2P2HWk3V/RwP+gaQJWwmuBV61JtZPfr/?=
 =?us-ascii?Q?0umj7xZmwtcGEh4me0x5C1IdfjIw+azYsqI3o5PFVXXMRAylW1JLK+Gbo63h?=
 =?us-ascii?Q?j9WQipEP14r1Sjk4rqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?05Ri/T9z9LXAyMYpLEEyRuT7xNTv/M9mlN0EkcAK9zu61UsbdA0H6Z1Ds/67?=
 =?us-ascii?Q?Bg4y3elDnvLMdj603ob4hZObktz3crIrjjmOTGgXdnHh8fDBmLHb2kXwDNeS?=
 =?us-ascii?Q?p9KIbBsDeJYSK87uVtvMjJuiMPCndx9NjJ1En5eF2Ll9EGgE4XJogopdXH5q?=
 =?us-ascii?Q?yqJm0uqnkVQl1r6NfKyOtuXYdHJ7rnw5JRx0l0MPzViBLEJsja5mMUEE2VSN?=
 =?us-ascii?Q?XtF8sVQB/4LdD73zy74Pji3v4lOHcI0fpNoeqXWeYmrFqvLg5+j4XCwsQP08?=
 =?us-ascii?Q?rxR4/MNmda483sN1sOGTwSvPSK2pqSzKyr3fcZh6XxXcH3fN8NlGsgzdCviY?=
 =?us-ascii?Q?lSegcQHKxMT+u0LhA3OXzyGcuEkaf04jx48RGNBIqCw4+BhvfPTmLaxbGv5N?=
 =?us-ascii?Q?V8Y0rtwoNOdShMUn50HrG6otOLc6XJrefZucDifO5Ro8qvtp4FlYVInZjVuz?=
 =?us-ascii?Q?w4OYqkz5PERz1zEY+gyhzQuXTwOewOu0eMi1x11eWF33lQQqhKMnNkUKdBDn?=
 =?us-ascii?Q?TYRhOIcXFVa3Y0Dx9N8F45fTPLDemsowfceDeubSOeau8pUDkcRmuDj6laie?=
 =?us-ascii?Q?CSPxBP5tb6icd1aQT+IQN1RwZ+NhCdqxDFARC39VZMoSRsJdsnBykPcVMdUQ?=
 =?us-ascii?Q?A032/xzmrjk3UoeCpQ8Tn5KfgIicK6Tss0jewk5BV2l9Kxxh/vNTZKmxdqIh?=
 =?us-ascii?Q?I5qBKv/yY55FNYivLYZ5Ye9lNtACvk7VRC9AmvTlPZf/RwSBZridYITbGoPi?=
 =?us-ascii?Q?8k990n10Lm2HmixTwpdNJUWpE1w+c0lp3jLg2NiPjSnyif7JbOvvgBKpyTWC?=
 =?us-ascii?Q?ppY8aj1ADS2H2bHJ6N0q6cUKiTLxAMRxctBkiPJFW0R1VwEexw3WWlN4g8Pk?=
 =?us-ascii?Q?2zrkR14Wp1AcY7CoW5ENBUcSArU82h/2o2T7LlSeu6VoAYaGbDpJyutn0Hf3?=
 =?us-ascii?Q?7eWKSVZW3yLjOg7fjZAc9lPoDljieeo6rda5nqdKSOzvTN8F97Nxq5NTKOwa?=
 =?us-ascii?Q?FoG/l7movHtnCCXcZovaUYNjsbaILBL00JT7kmTXxuIP6KnK/M7skRT4Xlr/?=
 =?us-ascii?Q?7O8Ebwr7sd4sY7odcv/fiXSLMSQEEbmE2cxGPpDJDOy2+oh9LsolEu/XiyR9?=
 =?us-ascii?Q?xi7ics+S/NUqH71Fjdcy0geWtkH+KaJ6/wQkQSj7eTVEbR0zcITXa2LeI3Js?=
 =?us-ascii?Q?542TNyDB8YtqfYYhBO6YBpFU8v6dUl7x3OFoa059RmuK/tDvNCQr0kpjVUPs?=
 =?us-ascii?Q?zrYYPk0MKbPs3juh4lbkO5/jHzUYHl06kIF6P1WixSN1fjTj8m2C0AmqhFr9?=
 =?us-ascii?Q?l5wjKDVmLlYtm4seghyZhvu8bbmmDE7EE/xM1EeucKIyqN4LpnJ5iJFx7M4r?=
 =?us-ascii?Q?2MWqA9+QIV5YKKWILOc9exSSLZE2DsEaCVUCmYj0tcy65fbVe/iGb5/QvMc5?=
 =?us-ascii?Q?3ijpOkwTOyEt0BPXdWyHbggmCm4dffWY08F4ADA5vyXfBA1hxTo8yvmtMv99?=
 =?us-ascii?Q?OU34EtAgPzkqpCWb85JK4JPvo8unY9zb6zqy6/RA4kFDWo1gF9e69g0sBvse?=
 =?us-ascii?Q?iwnfhYJp+XStlHZkyRTrw1iYOwGv+KIZ9jBBtKiUUUW51gTBXt39Zm4JWrPv?=
 =?us-ascii?Q?i+Wt4tOY6tXBmphSNUH7WGG1lwU36rGzlBHDDvN+SqrVFyvczFk87FKmWj0X?=
 =?us-ascii?Q?kw4A80IuUMxZAd2cMA/eQVoXYijfmYDY1wEtWB/d82V+SPrAlK06aXGvr6FH?=
 =?us-ascii?Q?Vk8MaAtBtVZsAF5t+ep4pXrqXAApDcc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BsttuCj6QCUIZYFvrompo2QnJJ7Ysk1cVWj0rXK2MXdJYHaDgRQsTkVeBfT/OBBHJ3+kDgDP+6PhU4saXR3mBwhrVo7IRrcBTLXeWXjXgda4tMYI1EXig1IFQQAtcLoJV2aqFctPXzmBEfUy9Uty1yu5i5RynTk+RBLr+0UO9QQMP6v5xNjYFa+L1/7ldx82vSvuNQFDGVOCqgV3euqpmIHHmdIdf8wYNtWsyQ4y5tktydYGGr+WyCsQVljoNqP+IOxSQIq8NS67DBwiiBmAni73Y3DYOmUO7EpIYawi50tK785ZF/87c+2iMjTs0rh+jgUqhOMm6zDqgBX6x8QkSRQ3dQo3O61LnO93/lF1WdaV63MP150eJLmmrlXPUS7q80nsRkemRUym8cVA2mUmgMXPVUfdaaMt17jbcsyFpYmLLer3Zj6AYUAHNoOKV287WpgRNWBbCb8vYuHDoUoTJ09XZkr4NgZoNN6yL6yfWjmRNdvhwa5ZWm3i4LYTlUVuNw8ko7WgqTtaJX3FZBFq/keRpSNYpXOyf/bhvQjb9U6GxwPa7H28l4UfZRIJExkXL47zAvaSV21eXUFVbq8ZM7j0UbT0r2ygU7itvHxq+j0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7feabcdd-539e-46bf-9419-08de5f53d927
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 16:31:26.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1lxvXl8bAqpQ1NuqMrUYzedoC7uOqalx+KNk2rS+mM97F30LKuZaMBvKpPYDMiTY/aInW4N5nUUymio/MoUHuVW+l+2dxna5lbqD0BXKFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601290115
X-Proofpoint-GUID: ifW4CbbbHCuROP4j88MK83hKJygaqr8T
X-Proofpoint-ORIG-GUID: ifW4CbbbHCuROP4j88MK83hKJygaqr8T
X-Authority-Analysis: v=2.4 cv=UepciaSN c=1 sm=1 tr=0 ts=697b8b64 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8 a=xVhDTqbCAAAA:8 a=DKpffWUmHaGfMbYcwfwA:9
 a=CjuIK1q_8ugA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExNiBTYWx0ZWRfX/wNgBhyZC8cq
 mw5BwanpUmtYWduJeuB7TU8hrErYRbJKimg6XPKU7UdIQ6zCpAlC/5U1O/5j1sMnmpDFJPQfais
 oYFVSIVi6UrGaHP34f4K0LP4s7W/RgD08uoDRQOQFGXr5ZC3a1pV/iidxH4FcmFWqpeKq8APalh
 FuCBuu2nL1duj2E28025b8aGmd0V2YNv/XtyGGpBJDxjQYyYfE4cOL3nGxmPveGefb9subSe7+M
 wTRLOrhh8rrVmVVIJnQThf414MlGZHV+S66fOq26gUWNJS5stmeODDL4Fsg32xA+zGbAA/8rvwN
 yIFGJDqa8DTMrBSVD8fiipkZoPW1TsW+NbMVxCti1+sXiKfd+6OhwIur7Gxoln86j0M6YFSeuKM
 p0prgOOKwA9qS2/PZ4EBoaGQWfywYKbLzxqQXSOgC6VrKt/b/bExD0o1gENe2/OybKZgysF0EIQ
 4dsuDbUF1Myqe/m2Y7A==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8361-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:email,oracle.com:dkim,lucifer.local:mid,schaufler-ca.com:email,oracle.onmicrosoft.com:dkim];
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
X-Rspamd-Queue-Id: B6837B2388
X-Rspamd-Action: no action

+cc linux-mm, maintainers/reviewers of mm/Kconfig

On Fri, Oct 17, 2025 at 04:48:24PM -0400, Paul Moore wrote:
> The LSM framework itself registers a small number of initcalls, this
> patch converts these initcalls into the new initcall mechanism.
>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Hi,

This commit message doesn't mention at all that you've removed
/proc/sys/vm/mmap_min_addr altogether if CONFIG_SECURITY is not set.

Did you intend this change? If you did you should probably mention that
you're doing this :)

I mean it's a bit late now as this is upstream (but not _too_ late as we
have rc8 ;), but this has broken something for me locally (mremap mm
selftest) and I bisected to this commit.

Note that CONFIG_SECURITY states:

	  This allows you to choose different security modules to be
	  configured into your kernel.

	  If this option is not selected, the default Linux security
	  model will be used.

So is the 'default' Linux security model not to provide this tunable at
all?

Though I see LSM_MMAP_MIN_ADDR depends on SECURITY && SECURITY_SELINUX, the
Makefile in security/ has:

obj-$(CONFIG_MMU)			+= min_addr.o

Which suggests that min_addr depends on MMU only, and not on
LSM_MMAP_MIN_ADDR at all...

And I don't have CONFIG_SECURITY_SELINUX set yet have
/proc/sys/vm/mmap_min_addr?

So yeah, this is all very very confusing.

So I think maybe we need a revert/hotfix here if this was unintended?

I think we might be breaking userspace here... For one the mremap mm
selftest breaks immediately :)

Note that prior to this change the default of 64k seems to be set which
seems to contradict the docs in Documentation/admin-guide/sysctl/vm.rst:

	By default this value is set to 0 and no protections will be enforced by
	the security module.  Setting this value to something like 64k will allow
	the vast majority of applications to work correctly and provide defense in
	depth against future potential kernel bugs.

Also to add to the fun, we have CONFIG_DEFAULT_MMAP_MIN_ADDR as defined in
mm/Kconfig:

config DEFAULT_MMAP_MIN_ADDR
	int "Low address space to protect from user allocation"
	depends on MMU
	default 4096

Which is _only_ referenced in security/min_addr.c which of course, is now
not being used at all.

So we have a config option that people _think_ they are setting to
something to enforce a minimum address but are in fact not if
!CONFIG_SECURITY?

Thanks, Lorenzo

> ---
>  security/inode.c    |  3 +--
>  security/lsm.h      | 20 ++++++++++++++++++++
>  security/lsm_init.c | 14 ++++++++++++--
>  security/min_addr.c |  5 +++--
>  4 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/security/inode.c b/security/inode.c
> index 6620c3e42af2..ab8d6a2acadb 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -368,7 +368,7 @@ static const struct file_operations lsm_ops = {
>  };
>  #endif
>
> -static int __init securityfs_init(void)
> +int __init securityfs_init(void)
>  {
>  	int retval;
>
> @@ -387,4 +387,3 @@ static int __init securityfs_init(void)
>  #endif
>  	return 0;
>  }
> -core_initcall(securityfs_init);
> diff --git a/security/lsm.h b/security/lsm.h
> index 8dc267977ae0..81aadbc61685 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -35,4 +35,24 @@ extern struct kmem_cache *lsm_inode_cache;
>  int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
>  int lsm_task_alloc(struct task_struct *task);
>
> +/* LSM framework initializers */
> +
> +#ifdef CONFIG_MMU
> +int min_addr_init(void);
> +#else
> +static inline int min_addr_init(void)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_MMU */
> +
> +#ifdef CONFIG_SECURITYFS
> +int securityfs_init(void);
> +#else
> +static inline int securityfs_init(void)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SECURITYFS */
> +
>  #endif /* _LSM_H_ */
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index aacdac406ba5..0f668bca98f9 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -488,7 +488,12 @@ int __init security_init(void)
>   */
>  static int __init security_initcall_pure(void)
>  {
> -	return lsm_initcall(pure);
> +	int rc_adr, rc_lsm;
> +
> +	rc_adr = min_addr_init();
> +	rc_lsm = lsm_initcall(pure);
> +
> +	return (rc_adr ? rc_adr : rc_lsm);
>  }
>  pure_initcall(security_initcall_pure);
>
> @@ -506,7 +511,12 @@ early_initcall(security_initcall_early);
>   */
>  static int __init security_initcall_core(void)
>  {
> -	return lsm_initcall(core);
> +	int rc_sfs, rc_lsm;
> +
> +	rc_sfs = securityfs_init();
> +	rc_lsm = lsm_initcall(core);
> +
> +	return (rc_sfs ? rc_sfs : rc_lsm);
>  }
>  core_initcall(security_initcall_core);
>
> diff --git a/security/min_addr.c b/security/min_addr.c
> index c55bb84b8632..0fde5ec9abc8 100644
> --- a/security/min_addr.c
> +++ b/security/min_addr.c
> @@ -5,6 +5,8 @@
>  #include <linux/sysctl.h>
>  #include <linux/minmax.h>
>
> +#include "lsm.h"
> +
>  /* amount of vm to protect from userspace access by both DAC and the LSM*/
>  unsigned long mmap_min_addr;
>  /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
> @@ -52,11 +54,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
>  	},
>  };
>
> -static int __init init_mmap_min_addr(void)
> +int __init min_addr_init(void)
>  {
>  	register_sysctl_init("vm", min_addr_sysctl_table);
>  	update_mmap_min_addr();
>
>  	return 0;
>  }
> -pure_initcall(init_mmap_min_addr);
> --
> 2.51.1.dirty
>
>


Return-Path: <linux-integrity+bounces-8364-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKdPFh+Ve2nOGAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8364-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 18:13:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C28B2AFB
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA1C30297AD
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11033E379;
	Thu, 29 Jan 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dvF+cXhk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GxA+g1cd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59C2777FE;
	Thu, 29 Jan 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706674; cv=fail; b=Axj/ZjlN0VhNS3f1/zz74jELpOHEOJEHm1NB9bSMwdTF3hDc4u8L78kJLynOFsB8cLDFONiM+RHBhniZ3WulbiIIDt+m7GxhJklZu+9us3zWTg5WwUGVJmCo3GFHXOmqYzT/rXHsNZRwLTy4YaP3gf4Hb9KX9z6OqvT/BCE/bOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706674; c=relaxed/simple;
	bh=vNvd2otFDKTLY/7yn6/9/LlfPxzOIIzApoXg2L11Zw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KmVhZwReOJ/D0eRH7wGQSKmu6TNRcZem8wx3JZAjJa48uycqX08q2RbjvjMUW+Hym0g30H1pbyD61jRFgv/3poJde6IduVnubRd4yegDreBjd+OQ/gRG67i7zYUaqljUdjjmey2KoEoj86ZOK10XB+HURKsvsWbFIzSVCSviVdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dvF+cXhk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GxA+g1cd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgLOI367903;
	Thu, 29 Jan 2026 17:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vNvd2otFDKTLY/7yn6
	/9/LlfPxzOIIzApoXg2L11Zw0=; b=dvF+cXhkV4seURp56P7QDdv0Lo8qbibJH9
	l1NddR/SSURyABRNwBjOLpP7OHzbgaJvLE+L/kVkQVU8vdkqMoETnMcxHtvznPJS
	9zduZgzwWb/fA1fBXPDtpC/EjORWrzsYtX0Dm1DMlaEPyHTMShw2vw6BNBKkaZe0
	o7iRFlxHa5M+gYkfM09S8gCQ2okUuFTf+XqvwxXovMXUIq3SX+prlAS6zxZAo7jw
	vVhD9TGYlbogT2nuaci+f4SYTPQ4QLrJKdPDkY+h9GHggItqMsoGgBwcOYoIdM40
	ccw/nguv44ZEVHi2gNFaxA5QHcFBM8HftE1V3vVkDP9cTUR2Qd1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by378kqgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 17:09:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TG2Fp0035453;
	Thu, 29 Jan 2026 17:09:56 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhcjvyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 17:09:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzSw2a372gcuamwitjuC+E+xwEPfUdzZCRghHOkPiSunxShAjKDvRACHB5cBr/pntGt7OTH1b8/Homen6MAZdTbC3fukvAhOQHYW8Ipw5+F3kdtvycqJamrHqP/dRcATNF+wcW5hjskiV3oGfCHrZMLr3z6IhmLcsVpMMBkbh14VIbpL4EmpXxqboEqfKXEhL2fm4ZXYpWOBxfzSqioT0HJJFwLQWrOTwsnCnOSC6FZUVMQRc4aE6mLf0RxPBOodkdAyF7bxA3wW0ecnqdSi7kRp5sEtRf/z601l9olkoufuwVJwT0/4tUy+VE5aeIrDJ8IrKoecJoLNSVhoY3HSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNvd2otFDKTLY/7yn6/9/LlfPxzOIIzApoXg2L11Zw0=;
 b=kjq1+/vs1fhOdEbyM53CleZOaZnEhtkkr9juw9j6PeYfvQODrkt0Urf1nEe/fpmal7LHl6jfyVpaKlmCDbWsXjUzFlVBoaqM9Rd/4m6NDb0knmwCm3L2akQJicYR6ygObJkq1BO6BYae6/XwOy+qwbIURhXjEotGWhKnyBVAhFaud+1AkvfR5ezSe/aco8Y5BmBwU8/Uqq0mprtIaCpBIrWTfMdxwAjt6/oNhjcRHNj6em9Ukv59Th096e3rrwSshiKv8HPCujpA3f+4lpIjZHScBwKMEIo3KUDUkHI1hVJO5JT3B9OB4As8PoJMxdWg9UZ4q8AghT9+ysJXF+/eGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNvd2otFDKTLY/7yn6/9/LlfPxzOIIzApoXg2L11Zw0=;
 b=GxA+g1cd1DD88jTYeADx/qwJVS1BHGOoSRqklKgTJs/cuuHJ0KnxR0R86xN05Esx82Rgo+M9YcvNWk1YwtRVtLuvAyagavAYGuucXGmJCH7ZKJ5LJXk60e52Fb7cNriXdh57EAIdUkOmI7AR1Bl5Tsyz2tvl586QXTv+xmtYKzc=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 17:09:54 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 17:09:53 +0000
Date: Thu, 29 Jan 2026 17:09:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, wufan@kernel.org, mic@digikod.net,
        gnoack@google.com, kees@kernel.org, mortonm@chromium.org,
        casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp,
        nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com,
        linux-mm <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework
 initcalls
Message-ID: <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com>
 <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local>
 <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 181e9813-eb47-4b80-4b06-08de5f593831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZOgU4K263IjcEu85RxPd1QeqDlyGBhoRZARA/Zhk048pHf1z5vlsb4d4cctg?=
 =?us-ascii?Q?1P6u/Br6KxyItIU4py+nGPxb+N0hpyFKUeksbBPO1nqnjHoux+xge2iNPyAK?=
 =?us-ascii?Q?Tec4UAoh57TvjMMaumvgBYrm5py66af5Kg4nRqHXfYd7z491FJD0cW1F3COJ?=
 =?us-ascii?Q?W8Vb61Eki6bW4Dkjvm+juZSHl3/yoFvWR2CTRojXN5ZJH0UkyednaouHrmJm?=
 =?us-ascii?Q?2iwlxWqSChFqYnnSCAbIRZTHSdYnZeX2mJigUK+C0JtMFk862tH8t3QySVOK?=
 =?us-ascii?Q?uFz07Pe493cLTGuyTkzOoVe8Wj/kf7Pz8Os+wee4pqRZR65mhxi4mJM7WSJz?=
 =?us-ascii?Q?PCcy+ADQyRhrnGNjmHjmTDuJbz332O77eAfJFDVKAKVk8o/DnxRK8B/EWoDS?=
 =?us-ascii?Q?Q3Ve13mN1AJ7WLfTW+htJqmV/vf33K9najXIz2l/K88RBv5mRXVEZUmLEOW6?=
 =?us-ascii?Q?T5T2w57QsPEfn7p7uqqBqyOXRFwz5OnT5gZsmkG4p9VwtNStjXuUhvTOD2tg?=
 =?us-ascii?Q?vbCiB0ldasOQxGU9gPJqNSC6u0z4VCPOa5d2Y1MwWIfBRxasX3zROXOWnLs2?=
 =?us-ascii?Q?S4ZyQXaLrmackSEmqCwqiCAA739TIOZgKwVq8oSFDz3CNCDRuITJT0nFpW+x?=
 =?us-ascii?Q?b9mm6K0KYCCCQL9E7RNq5QDD5mAYagvzhOw9inhjaxZJ70ZE+eMBHCERNR6b?=
 =?us-ascii?Q?4uhTB/bSM5SfUseM4G4u1QtyGN2CI7t65l7l74MFl8RS0Tp6kS2KuGbLclx9?=
 =?us-ascii?Q?oDMbUbFgWkbEy9Yje3fceVmXm4tu8UC586Kq1iAe6zya+A7P8HAGfuuNEwtf?=
 =?us-ascii?Q?1PSvUYKnuv3LoTDY7jGFMRf+Bh8upDZsmObrPZ8F4iMnzxCLkTHgJ1D118Kr?=
 =?us-ascii?Q?i8xikVI2c2d4MmYYAVC+M1fi7yaJh04dy+hLTSnQbXb+up2m39myAL80aVtm?=
 =?us-ascii?Q?9IwfgayxYyqLHGrA8Q1KFQ6q5/r9DUbaMRxRaeN1xED47cVSWGclM1oxwiea?=
 =?us-ascii?Q?wruqDJVOJTGyscuKUp8isQ5q3x8OFYj1dbq0d/dz/WcTFYVvYgHAm3RSyp0/?=
 =?us-ascii?Q?uPs+SRpshoGUmYvw8xJq+ogYDUlQOKAuwjLcvHOwpCD+J2y5tB4/82ajS2zE?=
 =?us-ascii?Q?DZV7ElLzPzaGxL3aKBSZEntr0V/54q2uW8Oq7IVcDSUFYSREBziBiLodsGHf?=
 =?us-ascii?Q?wI8furVmSIQoj6dcUUG+lqpCJR2Fbc5V0e0uAdBsq7JAag7P6CsaDSvyzug5?=
 =?us-ascii?Q?6lLKwMjC7jOXUsIqCmmDf3DpQoyPij6z2QVXIrt2Cr/7RSPm47ZFu9ryCMlo?=
 =?us-ascii?Q?nsh0GRFX8tQfqOQQnWs+cteQFU1WPUVlFQkxhXRjITxrLLe9HgBelzmStz9N?=
 =?us-ascii?Q?7VnbGk5R80lSvH0T3rR0+D6/nY7PLQIRCRCCwEK1YR2aJ/c4tiAHTNdhX6ZX?=
 =?us-ascii?Q?iOVkY+n1iNz0Cth7P0bcJic9qTtdnjNjGbRk7/KmPmKGD6GkbDw5zzEBvpIf?=
 =?us-ascii?Q?WlyYPqi1WcoCoA9gRR+caTRAfek/bplZOfW6ARXgansvg9JOi99p/3L/MR7m?=
 =?us-ascii?Q?RZ1sdgOio/bX5Bez3+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LEaz1qFrtVNUt2fmeAWbOTolDL7qqxe6F7lXAcFh4VtjG4kYo/ZYB7XmWvd3?=
 =?us-ascii?Q?eMHVrIFO/YuAudPyepfmuvfu/g6NZnMz7KdJUIpb2mik0hpaMBorEPKMENe4?=
 =?us-ascii?Q?pcBF3NLG5N3eOf2gDjiO5nXahIDm4SL3cVUaW0pbzstZvKzRpYP8zZzuhl8c?=
 =?us-ascii?Q?5ssi9aPSwUJAF2ffGBD18ESUnrVBghoyHZ4064tpyAEEvgn7fCDkf/fD1OrC?=
 =?us-ascii?Q?nW746DWnApIJAV3arjNv6nv9Rv5r2YgMyFHkRfpt2GHNupb+VhDFuvyqv3GT?=
 =?us-ascii?Q?gFwUNVWN54vjA9j96apv+jn7M7GBrbGFWNvCRxuiVtftYm/33ONgxqfz6nL7?=
 =?us-ascii?Q?2jIw9D7hrfmSFUmFQe2R6BfclAsl/vSgLeofBg6d3mgRGkMcKwUjeq7pPCsS?=
 =?us-ascii?Q?8Hxl+krvBCD9WWLIJhpLdOnJ3puQ98UNLHn5T4Vl/x7FBak9zC+LFYAriWLf?=
 =?us-ascii?Q?PiwjPjoLmSW+u2QateWLLccGmtTEYe0Ah03DLyjqGbat7w+dPmrjqYy2MIp4?=
 =?us-ascii?Q?8yUQ/KFwV3XR6JP3sT9ilKbpEr59gjLjEW/RlYitGhv5s7EgzLUs4AtKwutA?=
 =?us-ascii?Q?2h8CC3rmM7goiJ4CqCFryEWVo9/FGbu1gKZvARKajwPVdhAeZgmIcj3CssLJ?=
 =?us-ascii?Q?+XYEYSLTCNz3rpiGSjVfS7/Yp+nqvxQrGXA5u3UTWNjKayks9jenXpYc/ASU?=
 =?us-ascii?Q?O+8mJcjLxUBxGiLt3R9FBs2paGYh8fNaphhNut9Nigy6EyDGwgx0y16yVwXt?=
 =?us-ascii?Q?OoKv7V50LFtP/P/V2vszZvE1C/CStl1OSpesjVNU1e1qaj/BZNUemUX2AYZE?=
 =?us-ascii?Q?lu/pn4FFc/wSg9WHrAn0JgGrXKFyUQ2dOG7CxaCkrNJfd49okKY6tJxsgDO9?=
 =?us-ascii?Q?9IlAVHr95BPiU8FhNias4rPgtOouwPhDoqf/VDdC0ETQnT2zdARWb8bziAZL?=
 =?us-ascii?Q?3da98vDdPvtiR0hTf1edlZAz9KQjtE8xsZFbdgfP5PBcH3UQ50pzVKhRvaMr?=
 =?us-ascii?Q?M4H2cuTB9663jy+QjUXSodSB+CE3lqikeUG8MnM0KqFulMuWPpJVauybH3Qz?=
 =?us-ascii?Q?X6oZMLz8kf/IyXiLCLsAJNSI/hpOAK+t9F0HQC/DNEyWY4FmfpkiFb9nnL7i?=
 =?us-ascii?Q?TtTqF/SzfJ6QH0tdHBDAsw27snpDFTWGwDieS+8BuKFtpRxTg22MUu6cOo/p?=
 =?us-ascii?Q?/VPJZSS8xiCi07WQ6Kxqb9A3nNhPt3NUB5tGESkMhtGZ+LbUgVY6phDRdJvT?=
 =?us-ascii?Q?bMLP3BKo6N0LpJucqIbnGQ0/z9lhnsKyLhVQdbinKSc2Tt85Ykfsx2cg6C00?=
 =?us-ascii?Q?EnMsIqpUJv/Eb3k+xGOxifaOWG2ZuPJbJLLZa1KHt2CEsfw8Q9vCttlAkSHb?=
 =?us-ascii?Q?PiidyFUzxYBvaRpz0bDIAo61+NYeNMV7OCH9xrcZnldk5JAo+F8XrcNUvwm4?=
 =?us-ascii?Q?tJpWzeuRkZ7yOjMTiGRduQ5FrUK21p9glbWRrSFlweAUOY9ly0ZM7JR3TH3d?=
 =?us-ascii?Q?NrnPYyaN8Objt2UGM7HBCIY782LYiWzWaNEs5oQJw/UhAeN+Xo/2qJ7iErze?=
 =?us-ascii?Q?UFnC2K1f/pkF9e328ipbSqUWDJdnAzIz7Lgw3OgIqmVd1mviY6V0GEIK+h4N?=
 =?us-ascii?Q?aa3zTk9thMs2B4P6Jg4G/cYKDQ+DQzisKfBf/lOPj/BHwOGtySDs+YsIyVPP?=
 =?us-ascii?Q?fiL0dzD9J66vinKoVxzRWgoWPcBJGdJOiYSwuFEEo+es205T2Ew45ILobbvZ?=
 =?us-ascii?Q?bfVQXSVUeHHXt7me7FIeZT4VNo+9QLs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ykeEoVS7iRN140svLvo8pbguZKsKJtmQDwIcGBOao/GlJ3xiF6tQjEF2iTvbiOgeoFkIvrLBzGICa+JXI9S5AkhB5+oO4bIINm9luuL/DXD4WOJynTdWoZeoHksfZspEWNb4nldbPECVpDA1gEppYXYOG63ZcvyCx1tNtxUXiPgzwCdsbeIbh7o3VBOliAOuTf0nRXLi8s/JeCK4dy1Nlh2J5IK+H7LnXZ6jgDQQxJUkcpDAQaJXsbrKA3+awBChrFEtZgYczyLopptsshbWQZRLERw2PvWs1toPNPzk6/Us46Lw8oh20SWoRQaLLs0j79bXXHonSNpsz8Y7bxPvKwfGpESmgBp4Ow4WI7UY6xjIdIvdLGRZFSPP5CfJ45hWOYSc+3YEuPFtfjjoTTQK6gYytCkiWqNVgenfRgolhP8svTUBdyooQ/NhT2xXMdPRLwuGtzRjlSnTkcicAFws4cjoyth+WihTCNiHpssA+rwqohaaP77TJ6k9RS91x4nm9mZJMrl6w5JOmsPtnmoMAc8VB8anD3XeLRqmww9AVKfiWmY7Gdt71YaUu9+zStzgGhiTQoqlifznYqnsVb8MSh8riFcc9uira0EmOZ24usc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181e9813-eb47-4b80-4b06-08de5f593831
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:09:53.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgYJpQq3AT35yYDDI5aAbI21w0rn5nV29f9LwGD2HkgufDbSZGFHHxTJlpvD2ia8pDBxGmZTnYvCkHir/gMUhHMhjp5ESgg0u3dJXnWtXOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=836
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMCBTYWx0ZWRfX9kFyYxfFzVyO
 tWIMv4rGWK3C/FHf4kIGZm+Cnc5R6+bv0ZWX43bj8VxAwl7QcxmNUxXO6mmVrN1+qkfby0xBjvf
 cyxoIdtkp+ou2ngvm+EigEZRprbbrMFnmdqvWJxT1OHWRuG58uBlAI4rlyFRNrcJCRfbFE1Sarq
 5UDrQ0b1d2F5JRAgiCV3PzEOwACBLfY4dmfyjduD7xgT3Wr8fv5ZynvOjUL4fRmUH9zDd7mnrsg
 gwBnZV7So+jQNoghItXmQpLbykEXh/f9nzrgtlT0A6TazSuilfxhrCVAm56cvor6JnEQ+BJzEhW
 5mxGIK5tx3BVvwUdV7U/Xg+tof+JanwU0cWXRwFFlfJ1qN0ErENSqe07db4Qb6wM1d4xQP9Qoi+
 vRgVe4Kcnprdwl3MTXpTQxZX/BrNSVBtQQDWnHDfPPvwLTguuRPe9P/9X1w84Qwiord0D515ffA
 5/xw/NIv7x4logNH68g==
X-Authority-Analysis: v=2.4 cv=a/o9NESF c=1 sm=1 tr=0 ts=697b9465 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=V0E6NdkUipxGV5Rk1rMA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: Z4sQsCU8_iPTf7cPBgN_36_ObTYB7Cyq
X-Proofpoint-ORIG-GUID: Z4sQsCU8_iPTf7cPBgN_36_ObTYB7Cyq
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8364-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 01C28B2AFB
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:02:00PM +0100, Vlastimil Babka wrote:
> Agreed, the mmap_min_addr should stay visible and applied unconditionally.
> AFAICS the only relation to SECURITY/LSM is whether CONFIG_LSM_MMAP_MIN_ADDR
> is used as an additional lower limit to both CONFIG_DEFAULT_MMAP_MIN_ADDR
> and the sysctl-written value?

Thanks, yeah we should probably actually move the non-LSM-relevant stuff
out to mm to be honest.

But that's future work, for an -rc8 hotfix we need to make the init of this
particular module not dependent on normal LSM initialisation, as horrid as
that is...

Cheers, Lorenzo


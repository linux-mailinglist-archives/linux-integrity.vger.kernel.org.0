Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0D40EF08
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 03:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbhIQCA4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 22:00:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46144 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242509AbhIQCAx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 22:00:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GNDtkD002295;
        Fri, 17 Sep 2021 01:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=HgUmtTED22mTP9Gts8WS0/I875NQJft1a8clJfzQ2ms=;
 b=cdWCqcAjoOvq8aCm+d5eWVNwv5fBBCZMDuQCqJyOPuUgmEleKTSE0Sk/bmmfuHW3X2Pi
 IWu5HLoGFRebvG69oQ2hWfpIU5mLF0bcfgj2pI/VvevRQTkWpQFrY2/7zsZsJMzgzez3
 pyG78ibRI0eU7Xk6FyjYSa/n6jzq1F44l6GtZ6zVPIvBiHbYnUrZ8JPkHC/g/HgkeqoA
 uK3RR7dHgl3S7OfXKri66VhDGl2OzXcvpmfgjb51JTGuJ5SV6LT6qL1dwGftaPEAh5mX
 N5DUK17traBO0BO/U8q4eSrl3Ub5PiB4+Bad6vdCXwAFr7stKLKUNjM7ILy72MqeYuUv iQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=HgUmtTED22mTP9Gts8WS0/I875NQJft1a8clJfzQ2ms=;
 b=nAt1EnHQGP9A4YCq/DIexBNHdIIrSTwLDwNUYqcD/nxS/ICOXONCovGEIhj5NPtc6302
 7d6Z+UaVPUrVs7vZ1ml+D4APHhEDFM24RsozfU87TlxqvFIVuiZ65iinKGPOFk+8vJKJ
 rVpmb8yWY6hfjmFE7YXjWXoXKf4YpDTpy8iyikOp9JKOYMyHh+M2QetQ7Cr0EOUGzX5f
 OAlpVpmxgDVdMAmoVwgGEp3MFhy79KW+AA1Q8FDHquUFs59RvDe79A4114kxbsQkp0Xb
 8/NvQ3U3hIVCi18CaKWwi3XpSTAQq9X1q00aUqoIbj51qfNkV9hs6slfddYq8cZWKdjo 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jysp3pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 01:59:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18H1oUYF130410;
        Fri, 17 Sep 2021 01:59:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3b0m9a6dmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 01:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+SxC8PjcVsChpbBYnmGZqw9DflYXQfXS/BBzK2c+8cGFAcryP240136Ht73hh/SesSX9eK7rLr3Vhgtp842L+WBBtCnT5cNknUc9h630r225M0prco/uLtk8Ez0cQ0j4ocNkhtujpAI3nxLzsoAden2CAXPuIbdl8/sHNKhjgmVg41HLxO7u3GDDS5u9gKddD98dugvDIJBEcEMYGdJbdZ93x83BEAu1FSEnU7prfJWyHIAkJDdA0JyxuLeJ/TLLt0QibWesllu6x2MQCgODRTHhCneRoBBl4eFXdeYkS9Cr7btQoAzFe00ODylnaFhQnaEKuoIfuRYekCwMXW6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HgUmtTED22mTP9Gts8WS0/I875NQJft1a8clJfzQ2ms=;
 b=Z9uJ/8hpzMUAFrdspxVODZqcx8vTJjZCuVjfKJaN5AJZJwALO37pTxobEuLpOXarC4Qav0smi7klQsvFnzn5VebBR9UeC+1FTvp+q87BFHe+08iEvh39/JZuK14MTnapzbXKZ+VM5YPKniLuyj2OTa1zhnzCAcyBA30ujN8dIeW7dhHuD8GvF7rmiihM34fmxNXhbkbyklzD+Mn6s4yCUAE591Vn49CC+xAfYgApgdSB+Oa83lqs4njqOXG8R7b/L2v9ZUt9YIHfNRwtvNo/p/bYZ/2ZVCgP1VY9RW2+uvoTTsoNdkzhfbAJOXDvV1k0L72uBnzesKlSXo7ivspl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgUmtTED22mTP9Gts8WS0/I875NQJft1a8clJfzQ2ms=;
 b=TKyMmgxNKhVYEqX9kxOoU8lu4tPJzBAxLUhWphcF8oa5znH6zmzAi5NfS7/1Icn+p/wcK9QGcdI1PdUUso1TIPdksdJuvCndSe5PPoVh2sCK8Pd7f0XpvVhOblSGnt3xoXZQVtXJOhBOOXRSmCs/Dzvg7ZQD3SDH1Mx3Fa7Z3UM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4844.namprd10.prod.outlook.com (2603:10b6:610:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 01:58:58 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 01:58:58 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20210916221416.onvqgz5iij3c7e6j@redhat.com>
Date:   Thu, 16 Sep 2021 19:58:48 -0600
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFCC5EFE-13A5-40C8-84AA-96877B2B7932@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <bee0ebc354a651ea5b263897f9b155dc604fa7c5.camel@kernel.org>
 <A02EE1DA-12BE-4998-ACE6-2D74FF380297@oracle.com>
 <f6e2e17cc6c8a3056cc066a7baa4d943eeb47c84.camel@kernel.org>
 <20210916221416.onvqgz5iij3c7e6j@redhat.com>
To:     Peter Jones <pjones@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SA0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:806:130::17) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:92:8000::a1d] (2606:b400:8024:1010::17c6) by SA0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:806:130::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 17 Sep 2021 01:58:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ebae946-156f-4395-5572-08d9797eb64f
X-MS-TrafficTypeDiagnostic: CH0PR10MB4844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB48445665D33974B8C7DA4D8F87DD9@CH0PR10MB4844.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59qmykmKkfzNaQeCoCm8Q9x9G+k1p5KEk0Z7c3qVjofWEjoMY7DQaYsvnpI3WR3ISXCNXdcgr+P4sfghSbSQHWAogcfKM134eaVs4d+7+qKG2DvCpJhC921iOlhC0Xn526GNkeXMTJ9OIwigqa1s4PJtJ3ElPWMcfCwLULOs/VUKjYDMB3509osw0IDw71Op5fQ4n2YUkPyh5QlkgjGX5wj1rQZIvtaQVEsGwPRh5YBqzZVtTVHnnpNcRbRoDNao/XpCTmxgmxOkeU398K4u8QUgCgmY/IU88dDbKyRk/N2iiDirvzjySAnnisfWtwYgPQ66dzndqqnrHxs/cT1hDpmNnrFoRiiqKjGVcCM6QcJ3cYiQQ3GzPOWRGruJzaHrXG/1i+em3ermYdS9zCgC2Rtf2TdorFvAfd+zu+eoKuzejQMDzG8rOy1khAls2Nn8NirmVmtpwf1emoPe9qkD0kG9BOf5BVjYVT4JD+WQaHBX1mFOnrYbmocmaYg6tzoxBESSbpOQFM8vF/fpsVJduHn92P8E5ej01Q2cO8lcEEqyqf8J0b7zFfPJarVBrAEP01cV+q9CFMu1tSWg1ZtydugRC/TYTdidBpBdMHEgcKy0xNKsoFxcrTId++lqCQPnqhuQojSELXw1TVE91hyK+U+dUXQYbP9hPj/2p+Gc0uguX9exOvQ4DExrIKqJGi4FVM/Gng+S+8CayAtERSecGIAA6FHQ5FlBJJ70GdHe/d9PLHpIssFCzh4MZaAFqXNqt83AbFzLCwEchFuBN77UfsDYaQPWEfxjzg4vRZiWTk+zZ8QNx5BUHWH1//tKXHtjQZ9S+SrVKLd7Us1c6XCAtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(86362001)(83380400001)(6486002)(36756003)(6666004)(38100700002)(107886003)(4326008)(5660300002)(53546011)(186003)(8676002)(8936002)(2616005)(52116002)(316002)(54906003)(66556008)(7416002)(2906002)(966005)(66476007)(66946007)(6916009)(508600001)(44832011)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2pNdUNIbjR5OVlqUGpTR01Ic2lpOWhaZHgrUkZXOVVKdnJIK0p2ZUFxc3Ir?=
 =?utf-8?B?YUpIZjVqSEV3YVdtUHVCZ2Z2SGZxYmJUNXlsamNpNzc2SkQyWGxNSUx2bk01?=
 =?utf-8?B?U2Z0VERISGZFQzZxMUw0R0g2L25yZjdOa0xqRUNvRE9IbTVtK3o4dWxmMFB1?=
 =?utf-8?B?Nkp4QkNlUTgzaGVYbDYzMHpvUDZuK0xEVlI4OHdNc0RJKzgwWThNL2xnNDJr?=
 =?utf-8?B?bzNKWndvZG1CV1NCcGhDMzdFbG9VSkxVTFpsQlJlYkZmcmlPUEQ4RGg5OUdZ?=
 =?utf-8?B?ekl5Uk1ROG9hM21aYVdoVncyalBJM20rcGtaUFJZdStkang5Vi9PejJBaEVM?=
 =?utf-8?B?aHVPQ3gvQnIyeDQ3YXlyN0VheW9TYVdORDB4TnlaVXprQjhpc1hyMWZiTUEr?=
 =?utf-8?B?YmZURGxxRUFZOFdXMUZudDhzQnZrSVhnSittNGFXUlVyNTVzemFhdWVIN2Va?=
 =?utf-8?B?M3BxWDNPRklDQnZwMkRVeVN5RlpGdEN3UElrSndKMVdFNlBmUWlwYXlPc3p5?=
 =?utf-8?B?V2VUWG85VjhyUFROWHVpYm91bThDcEQ2SnRkT1NhaDBIV1lnUUlHcmh4dlFs?=
 =?utf-8?B?cFdEUHJic3NxL1V4T3FTKzlRRDEwdVgxUkZaN2Zzc3M2RnVuZno1bHNyV0RG?=
 =?utf-8?B?YjIvQWd4Wnd2T2pZdldzN1grNFJZYXkwTFpUYkNBdmQxVVdYcTZaVlBXQ253?=
 =?utf-8?B?WEtkb0d6Yi91ZmpLNFMzb3E1MW9FMlo3NklvT0tZUURQelhZMGhpZUxKWlpF?=
 =?utf-8?B?VTlIQ3J6Z1lQTU5qeVdZUlJnRVBOc21NQTdlRXdWWCtxWmJIL1F2Zzc5RW9t?=
 =?utf-8?B?dmk4ckxzaVowb0NTSnl4UG5laklXZUZjaHN5ZnBUaVFIZGM0eFRxSTl4N05s?=
 =?utf-8?B?a3VlQitna3AwemtkTWJoRHE3cko3WUNHaDM2ZGwwUnN2R3IwSitPMUxFZDVW?=
 =?utf-8?B?c3MzcE5OSVltcVdFOFl3eG56N3BiOWxCeUM1Qm5iVUkvM3J3UHo0aXJWRVB6?=
 =?utf-8?B?dkhTeC8wV3Z4OFViQXhsdmRuOWQwY0M3LzJJcDBaWW5YMFlWY3JRYm1ZckRV?=
 =?utf-8?B?Q1dEbWVHV0ZiL29XVVlxdFVwQXpSMk83SzBTcGs3TjhTVjMxbVN4QWF1Z2ZH?=
 =?utf-8?B?V2tFUmpud0xINktkblZhSzlPRERWeDFkOFIreStHQ0JNZEN5NU1tQ3ZtWUov?=
 =?utf-8?B?MW15ZmhzTTZaaXRUODRzb1Bod2laemIvMkVrTllOTkw4dno0Skx6UHpHQ1dT?=
 =?utf-8?B?OGVNaEVQSWkzK0VyR1psZlRmR20xWWwreWF6YjNSSm1iZENqS0syM3h1ZWFz?=
 =?utf-8?B?anpsaGIvWTdvUGhZUjFTVVl5anFrb1d1aXl2anQxUmN0cTVLNkpldjBRcnUy?=
 =?utf-8?B?VUoxbnRISVhYUEFzOGpzM3BFclJPZ281ZnRDK3ZTRjc2OStMY2oxYjJkWXVn?=
 =?utf-8?B?aGsycGxHbnc3b0xTMWM0N0FIS0RLZEdoNUhrdUJUT0ZZazBqVmkzcm5IN2h0?=
 =?utf-8?B?QkE1SS9jTWd2OW9tSHdWRjd2VHJLcEdKbTFhK3IzSmJhTTV2aS9nQjFHMmtU?=
 =?utf-8?B?MFlTcXZjMG5sVkF3aHVtZFZXMGJUUm42MEhSVGY2dnRxKzhFb1NROVE5NkpC?=
 =?utf-8?B?bTI3dWNUdVhla1ZjU240LzBOd2dtTERCWEdTNmZFNmtwSnppYTBpQ1JTYjJN?=
 =?utf-8?B?SG5naXV2RzUrMkNwTDkrV2F6QW9qa0cxc2xaaEI5OG5oV0VJM3JlYjRVMVRx?=
 =?utf-8?B?VGd3TzQvRzdMemNjU3RVU0M2UmYrak1VbDNKSEl2Y1B3bUg5SW1kNndJbThx?=
 =?utf-8?Q?55eihdMZkVio2FF3N4+E/LVRvlRugAGSR03Kk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebae946-156f-4395-5572-08d9797eb64f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 01:58:58.2950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGHD7NMEN22qNJ45d5jvsNj6HQJ547CoaRXbSDbpbcdzuszNQODCfgVVCwZJGd5jM/Kgjq0iXdlVqDDhSsTpDV14BeIcB7FTVJTca7JupjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4844
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170010
X-Proofpoint-GUID: K7G6aflYudMSNqEiKx5ft8RRboQoqJGg
X-Proofpoint-ORIG-GUID: K7G6aflYudMSNqEiKx5ft8RRboQoqJGg
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 16, 2021, at 4:14 PM, Peter Jones <pjones@redhat.com> wrote:
>=20
> On Thu, Sep 16, 2021 at 06:15:50PM +0300, Jarkko Sakkinen wrote:
>> On Wed, 2021-09-15 at 15:28 -0600, Eric Snowberg wrote:
>>>> On Sep 15, 2021, at 11:57 AM, Jarkko Sakkinen <jarkko@kernel.org> wrot=
e:
>>>>=20
>>>> On Tue, 2021-09-14 at 17:14 -0400, Eric Snowberg wrote:
>>>>> Back in 2013 Linus requested a feature to allow end-users to have the=
=20
>>>>> ability "to add their own keys and sign modules they trust". This was
>>>>> his *second* order outlined here [1]. There have been many attempts=20
>>>>> over the years to solve this problem, all have been rejected.  Many=20
>>>>> of the failed attempts loaded all preboot firmware keys into the kern=
el,
>>>>> including the Secure Boot keys. Many distributions carry one of these=
=20
>>>>> rejected attempts [2], [3], [4]. This series tries to solve this prob=
lem=20
>>>>> with a solution that takes into account all the problems brought up i=
n=20
>>>>> the previous attempts.
>>>>>=20
>>>>> On UEFI based systems, this series introduces a new Linux kernel keyr=
ing=20
>>>>> containing the Machine Owner Keys (MOK) called machine. It also defin=
es
>>>>> a new MOK variable in shim. This variable allows the end-user to deci=
de=20
>>>>> if they want to load MOK keys into the machine keyring. Mimi has sugg=
ested=20
>>>>> that only CA keys contained within the MOK be loaded into the machine=
=20
>>>>> keyring. All other certs will load into the platform keyring instead.
>>>>>=20
>>>>> By default, nothing changes; MOK keys are not loaded into the machine
>>>>> keyring.  They are only loaded after the end-user makes the decision=
=20
>>>>> themselves.  The end-user would set this through mokutil using a new=
=20
>>>>> --trust-mok option [5]. This would work similar to how the kernel use=
s=20
>>>>> MOK variables to enable/disable signature validation as well as use/i=
gnore=20
>>>>> the db. Any kernel operation that uses either the builtin or secondar=
y=20
>>>>> trusted keys as a trust source shall also reference the new machine=20
>>>>> keyring as a trust source.
>>>>>=20
>>>>> Secure Boot keys will never be loaded into the machine keyring.  They
>>>>> will always be loaded into the platform keyring.  If an end-user want=
ed=20
>>>>> to load one, they would need to enroll it into the MOK.
>>>>>=20
>>>>> Steps required by the end user:
>>>>>=20
>>>>> Sign kernel module with user created key:
>>>>> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
>>>>>  machine_signing_key.priv machine_signing_key.x509 my_module.ko
>>>>>=20
>>>>> Import the key into the MOK
>>>>> $ mokutil --import machine_signing_key.x509
>>>>>=20
>>>>> Setup the kernel to load MOK keys into the .machine keyring
>>>>> $ mokutil --trust-mok
>>>>>=20
>>>>> Then reboot, the MokManager will load and ask if you want to trust th=
e
>>>>> MOK key and enroll the MOK into the MOKList.  Afterwards the signed k=
ernel
>>>>> module will load.
>>>>>=20
>>>>> I have included links to both the mokutil [5] and shim [6] changes I
>>>>> have made to support this new functionality.
>>>>=20
>>>> How hard it is to self-compile shim and boot it with QEMU (I
>>>> do not know even the GIT location of Shim)?
>>>=20
>>> It is not hard, that is the setup I use for my testing.  Upstream shim=
=20
>>> is located here [1].  Or you can use my repo which contains the necessa=
ry
>>> changes [2].
>>>=20
>>> [1] https://github.com/rhboot/shim
>>> [2] https://github.com/esnowberg/shim/tree/mokvars-v2
>>>=20
>>=20
>> So, my 2nd Q would be: which order these should be upstreamed?
>>=20
>> Linux patch set cannot depend on "yet to be upstreamed" things.
>>=20
>> Code changes look good enough to me.
>=20
> We can carry this support in shim before it's in kernel.  Eric's current
> patch for shim and mokutil looks mostly reasonable, though I see a few
> minor nits we'll have to sort out.

Thanks Peter.  Previously I had not sent it for a shim review since I wante=
d=20
to make sure this approach had a path forward.  I=E2=80=99ll work on submit=
ting the=20
shim changes for review now.


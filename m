Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904E070CE93
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 01:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjEVXOT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 19:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjEVXOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 19:14:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E3115;
        Mon, 22 May 2023 16:14:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOTuC016145;
        Mon, 22 May 2023 23:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ivH8KLMtAhH4YUq6KgwyZeC4Clqw/tU7QByB9JZtLrA=;
 b=ivHitRZ3dOC6oGZVQAzSKBVhLLx+Rs2rnhoMVbgB2xekrYIup3CHg7Ut8QqXbosMRFm0
 0x2NqWTfYtfthl2q4/K1NczIvAaky0XTPkcCgfDv/Tvm1F7hM0fN+qmVpo80ZeqdclA/
 WEMX37mwIhMnSU+lkFIBKtIsLxVKGdLnDspMZ5f//jRWrHrdn8qkGxJFvOXkGBHcDa8x
 0UHab3ra0uKuDNqVD6OLA46mZvngFRXcWoIPnNHV6l+8kWvfKgf1fyrigzuXN5hA0IPl
 VsSTZYRHbydd8iBaiSgd8MeIFWU5h1rGSskSl6Ntu6QbWHwf4Pnn7ewV1MJ1MJmMvu9P EA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mkvjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:13:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLcl2C027194;
        Mon, 22 May 2023 23:13:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2cu50f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFthD8zFgHQH9A4LnJLyXdVDLCGnTTJWzOnsYGOh0C8h1/HwGBnW4kN8zkCIedUyJpWOY2JfWadXov5Gn9R0o86fWVcu57YNv5GAiquCOmtf91dsPSwgz5DpWSpcwvLy9rUzHNNMdpJH+DUw5WbrqDkvubARpEz02wNdS6rgDaneNjP5BonorHnoduyr9OlIl2+qUV/4ToWYQwJ2EGC7VhlE8xkfRKwHkPd/xycAVOdtDZmU4+c0LmmoRng0LkxV3n5dEtRwBIB8589qxHfxzDPY75WbomEJbS0JeEniMawA0EzRb7ZBMwQUuppnVYU+ZkzycWFDa19BZC3oRln2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivH8KLMtAhH4YUq6KgwyZeC4Clqw/tU7QByB9JZtLrA=;
 b=HVGu8WNXBGrDzF0SVRT0Lhg5X3xwwAweYCwFBOinn5WsRhz5Pp6SumJHU9ajtm0gSkFBJOI0jCw4KIL5keDZYl5nXGIByUN8xQliWuZayXRkhmamqKm+dXC4KDu1fMWHDJbB+2ZKCXh1vQZtBpu3VmQKA4d5NX0n05PGHcx8C/BB5oFqTYTIkFod8cftQ0UVyphW4BnvqjStC4FasUu7Vg/fXej2fjJf58AhMPlL1Tr9BCGamdE5wlQfY14CqVZCijyj0OK2K76iLZZwgxUBDx8dY/PKDe/H/cRj2LUEJuopnxrRkIFxRdfewySAMbj4Y1WEB8vPpuwmuGf17+4/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivH8KLMtAhH4YUq6KgwyZeC4Clqw/tU7QByB9JZtLrA=;
 b=q9H47rwu0LtlZ5MfrZClWz9X/mvJo8jQfgwBE1S09i3ftr7Fak33eS4JXdHMFC6Z7XfmUzOuPQ2EybjN2VBhqoFRN0lGUPWCz/G4HFtNG+ZThnhXfqrychkFjwWWuh6/t3Pw/a8dLvbyZl6+kz526utj59JHw4ItyLAGSaPHNHs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA3PR10MB7095.namprd10.prod.outlook.com (2603:10b6:806:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 23:13:15 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:13:15 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/3] integrity: Enforce digitalSignature usage in the ima and evm keyrings
Date:   Mon, 22 May 2023 19:09:43 -0400
Message-Id: <20230522230944.180389-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230522230944.180389-1-eric.snowberg@oracle.com>
References: <20230522230944.180389-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA3PR10MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4181cc-6ee7-4958-ac49-08db5b1a1f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMR9x0EemkePQiTnCJOWAiRSaM7uYLVSTiztukgBMg68B0sgpNahxJY8FLvzqHJf+Piy+J72stDSiQfbcf3zleDeQMEOTu5jf+oY0OH/0bYCHV0mncjtVqiwhwHYPDQcB/97s15c3FcDUkPzN2XKklyCqNkyLiFkpb8+6P9hcfc+wlszvXU4++36CHrMr2f1+/5aUbhkJSMkO2/vxTosUB5i7RCNFklx/OUn6W38zOuG+Zs8Lrd+ASQ/7dDposhw3LzeYG7b99zo80E8213qGJ2Iozy0RRYDEUGMtqB3NbtoW8RAGbIT0ghcTXgxOjL9N3aLjgsU7xAsbbeQn5Z2VjBLEA6nCiWA6ei7RGalUG+X+iV9qioBVaD2G8eyIWSihZkdnnHU4/tVnrSmTs7Vxr1i9gyWWGURKpRKJFNMt2Umenu6YkJgY0uwB/wcIPppK0r50y+rXGIr8e/rf9bF2m0s79zsLsvfrBL6zRwDTZtxSoZBl+vd8S1UAMoSsKIipnrZUeu2A/fSI/gdk9eWJiEKj7FKZE6PORaHbSGsL6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(2906002)(7416002)(5660300002)(83380400001)(44832011)(8676002)(8936002)(36756003)(66946007)(66556008)(6486002)(966005)(66476007)(4326008)(316002)(41300700001)(478600001)(6666004)(86362001)(2616005)(1076003)(6512007)(186003)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KumZcWKms21GeqdjxlBYlRxouA4ALMgKfKqfMCCedHJ7PR77KvAOkKKK9qbd?=
 =?us-ascii?Q?dKT0ZMW1MhlfSXqyVnXzSB6rmMi2/2VRmEPMPwDvdPZQxFPa7hQpOkbpAHxq?=
 =?us-ascii?Q?tX3/QuhCiccDecsLrpw6SPZahqKNJIVRcXNlXCi9hB9GGO+0qihudspxLHUF?=
 =?us-ascii?Q?0S6DB/mYX/aT0F14rfuKyvsUkFDyBF6DIOotE1QiphygnjT3Etahminw7Vcr?=
 =?us-ascii?Q?U2pHypPYNPo6rWEw6KzXHRmmfkqxAOh3SJhirAeha0YwtoP3AaItX2aoPWhb?=
 =?us-ascii?Q?yvC7Y80qGvnGhhUha7+ZP7Ft/gV02ezGfHofBjylXqgO9Yqx33FNBVBXvwF7?=
 =?us-ascii?Q?zpIkbliF4C37TkOaMR2qLyE62l0GtgW9PaPduYHKjWtNmUdGncXsKLkl6ZYg?=
 =?us-ascii?Q?u1Lq3XCnSHEUeHpq23c7H9zk2DONdckFHW8UFZFXx84HTE3ZpEVKg2xLozml?=
 =?us-ascii?Q?GjV2YU+f8xBU8RxKZi+UDjDxl8lPQ7TgVt4dlCZZU0natFiH/aI3+05rdHV4?=
 =?us-ascii?Q?DWCsQbR8UArnN95nJAtJ5q+GAYFV238Hrz648F5MYcA7TPv94ElEEmJxiQ3e?=
 =?us-ascii?Q?acSYQqWCRodYH9aU15zFG0t5mdt2z+pMIqN1hJyYIBoASpN52kBWqEdbvaQK?=
 =?us-ascii?Q?nvlexn9gpaIQ9SIIwbQKIOYuHA8JbUdmQsHnPZoC/HEcgElrBdHTGFePsbH1?=
 =?us-ascii?Q?rU/mIN17s+G7QYZ+MsfJ+kcpmi1H98GHwvL9NSc7UKggqbqkaqAd/sFElbYm?=
 =?us-ascii?Q?hEx+HCKXh1K3uXqEJ5ZuiCDtZySg3YwdLvg5FFPVwN17wPyeChV5jyV02HpA?=
 =?us-ascii?Q?Mk7k4jlxFlt+w6k482bq8TvteeIS1pXP5fgD4s8C6eSdJjDP7e7uduPQ5nhE?=
 =?us-ascii?Q?33kYZxxwjbjeDU7OV7VgYtofURTeiOUt433bbKdMF5kgk6/Iw7yEYTsHdf/4?=
 =?us-ascii?Q?ll5+KwMB1IErQxUJemu7LeKZtnqjP6gi6APvQBqtcrAUljbh0FjF+0wndHRq?=
 =?us-ascii?Q?HB2o8EWH5D32pEqeIc9eYuyHLiBia821vYwlEoKb/bl0yRh/aJYk45ykWijN?=
 =?us-ascii?Q?/HkjfxzVfolcScTaLL/NXpJIAEKDa79kpSDYJcUtAw3taYCyrqE4puQRPS0l?=
 =?us-ascii?Q?KmUy9ZW4I7M1VIwru9CU5y8vLQDTyNJCRKnENXqCT2gife+aVJmABW9ENLBB?=
 =?us-ascii?Q?xXMAYvfM0O6C0pWyCPYQ6Oh9CUNlKnXE3/JyzR24HAsUCRU12VsVIiuAwjsj?=
 =?us-ascii?Q?qbc8sciqJnWJ9Qg6OWpU+Gd86myF4OWw+SLHMjH6h/YANasj1XVY4v5AGRru?=
 =?us-ascii?Q?NmNW/QPRAf1HSQR8z8xoJHn4my3iYEBUewdxEHWPeENoEbb5yJUEWOHm87dr?=
 =?us-ascii?Q?4C81hp/3mj9mzpOIejSQfescnqBeQCYQfp58Rb9Kz2svfevBtPKaqVXGKDPW?=
 =?us-ascii?Q?9r4vnWOkMIXb18s7aEEh1P24KvqOSSKs4Ukvg/gteCASC1GUBi33yX09rMYq?=
 =?us-ascii?Q?Y6TqP0VLWbDFGQnqAsNUM8U2rQR4Ynn19HHqcBmvVE0LXCcjBVLLvmfejCnN?=
 =?us-ascii?Q?6FNXIdFAziop8kodvR/aDc+igEy2rNULV0w2hzPP/EZboBalfKTdj6Cc6Qf3?=
 =?us-ascii?Q?SXOOnUarjwoCvSY2egdtZ7U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+y6mWSoXzNDXwHcCe7KXqXjljFCxbuGyMbOnLhzvvWPRoP+AggIm3e7fBiXx?=
 =?us-ascii?Q?086zo37dMtohP6qJjYGE3wEqwKQAjah4WrtfcWnuI/1Ke51aA8uEblqmBqBa?=
 =?us-ascii?Q?nZ3P9KA8kNoD3JSOwehMoc4HPxQEl0WyTTwOkYLwstdtxTRi+g6kphH/i3QP?=
 =?us-ascii?Q?K9WAnjOTC1rrPkeDPnEM2i/5CaxOCDeJYM6pbRW6Fe0X3sjkF7f/4kEACQf6?=
 =?us-ascii?Q?WzC44w8OyUxmbnaD4tWKudWaFRyu91XCytRZRRSg2/1FuV9qixZpKI6Orvc5?=
 =?us-ascii?Q?NUatNXCxQF2/2zaJNY+lXPZCFdd3cX5Wrz3ybdcHPFY1kHsnxxQaQ7gU2GWE?=
 =?us-ascii?Q?eQLAo8wCH/JCMLEfrxqN36c1vvuHnHnTbZCphraztPweYzgcwlLnaMs43UqG?=
 =?us-ascii?Q?0oKKbeMaKwafGFljbmRGJknWFB6xhhR3ofD68mqtplCSMuwVOJWTdjJQQacR?=
 =?us-ascii?Q?DKHyI39ugXNJIR1gF1gp3Oqy6LrxiEYbcS+QpVUjLf5mTnZ8c70IEu1PfOS9?=
 =?us-ascii?Q?cOPn+nCtC4K8NUFUelbKdcWw1oymN8MU/xIOZHuUF55A/Wo/RdPkwqyjimnE?=
 =?us-ascii?Q?AkyPSbPC0SWjV0JeDzfBBSu+zPM9LR8P7cSFPI72LQ4RzcdHoHs3/0YTs5Lh?=
 =?us-ascii?Q?Dhhk7q0y3iW+Z8MnYgxVAXeeaDxIAhqxOoYX4PsWXgXC/F+NcJSP6ppBGSCO?=
 =?us-ascii?Q?ujsOgASIQxVbN9asLDh5rLbhu4QgBOfSWOO4VP2htbgfO2FjA38dejpBAChD?=
 =?us-ascii?Q?4ILnoVdfOHcBDLhGkhFl/0eYhpj7yg8zWtUo/V6wSd6wTrISxvcQhpRAzkCM?=
 =?us-ascii?Q?yp/O3jM819y1+w6xUYwJZfRobmwyQHmG1MMq0Uoan9bEe7SyzvfcRXrFCqUW?=
 =?us-ascii?Q?OThhnOoja87RsqK5+4ysWnxM6+azQmtOQ4Piuo9FUw1Tf6XWrFVvj8vO0ZsR?=
 =?us-ascii?Q?gWHVvyHfGcERuR6zaCvs+q88lSnQX/PsoeCpyt3VVG+3WpsXZDnZ8HB+Gx9M?=
 =?us-ascii?Q?qtRs6U3BUvDz7zJ9R2RPX9wM+poy5efAEypj6sih6GYA089Ykoz37CJZZJoo?=
 =?us-ascii?Q?237Tj1k0SVW5/EzWnhFgDT1zS5JDPjO6hEW+HjPEFCTBby9v7rBq+x/oEnOm?=
 =?us-ascii?Q?7arIH4W7CLXR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4181cc-6ee7-4958-ac49-08db5b1a1f31
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:13:15.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa3W0o6isRumRN/ItnE9EQUd0ppWcODYO3AA/UIfpbyv2s8wD/tAsV1DPlQEARHAaIvmtF21gwwWh9oaPDETpdTI4LgYbJiYaLJQ9NnX/7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220197
X-Proofpoint-ORIG-GUID: xtIFL9Z0r1UBTxslNIkEEtaiJnNYgfiv
X-Proofpoint-GUID: xtIFL9Z0r1UBTxslNIkEEtaiJnNYgfiv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

After being vouched for by a system keyring, only allow keys into the .ima
and .evm keyrings that have the digitalSignature usage field set.

Link: https://lore.kernel.org/all/41dffdaeb7eb7840f7e38bc691fbda836635c9f9.camel@linux.ibm.com
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/digsig.c    | 4 ++--
 security/integrity/evm/Kconfig | 3 ++-
 security/integrity/ima/Kconfig | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 6f31ffe23c48..d0704b1597d4 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,9 +34,9 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-#define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#define restrict_link_to_ima restrict_link_by_digsig_builtin_and_secondary
 #else
-#define restrict_link_to_ima restrict_link_by_builtin_trusted
+#define restrict_link_to_ima restrict_link_by_digsig_builtin
 #endif
 
 static struct key *integrity_keyring_from_id(const unsigned int id)
diff --git a/security/integrity/evm/Kconfig b/security/integrity/evm/Kconfig
index a6e19d23e700..fba9ee359bc9 100644
--- a/security/integrity/evm/Kconfig
+++ b/security/integrity/evm/Kconfig
@@ -64,7 +64,8 @@ config EVM_LOAD_X509
 
 	   This option enables X509 certificate loading from the kernel
 	   onto the '.evm' trusted keyring.  A public key can be used to
-	   verify EVM integrity starting from the 'init' process.
+	   verify EVM integrity starting from the 'init' process. The
+	   key must have digitalSignature usage set.
 
 config EVM_X509_PATH
 	string "EVM X509 certificate path"
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 60a511c6b583..684425936c53 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -270,7 +270,8 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	help
 	  Keys may be added to the IMA or IMA blacklist keyrings, if the
 	  key is validly signed by a CA cert in the system built-in or
-	  secondary trusted keyrings.
+	  secondary trusted keyrings. The key must also have the
+	  digitalSignature usage set.
 
 	  Intermediate keys between those the kernel has compiled in and the
 	  IMA keys to be added may be added to the system secondary keyring,
-- 
2.27.0


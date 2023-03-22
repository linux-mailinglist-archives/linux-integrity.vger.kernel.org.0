Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2262C6C5064
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 17:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCVQUq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVQUp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 12:20:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D64ECD4;
        Wed, 22 Mar 2023 09:20:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCY2qQ018787;
        Wed, 22 Mar 2023 16:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ZizaT3EjoZnNPAzoL+omRQ9VQ+Ty/EDFZt1NsSUoHRM=;
 b=Dzqg1d6Yrv+67qYDPEa9Jix0KILBcYa7k+59weUXCsLMWtn2a4n+aVxj4yxY7+ZWMBD9
 89jF/prga3zl0zV8NcTIE5jprqaKec3BnaaL4zTxk0vRQy1ZH++qemiK0FhRE21AY2HY
 Ksc667GKw5w953sSTA4kiEi5QBu/cCnYoIdswUmMfdlyu+S+3YGYKluCiGd+z9zXZC/B
 pcHtw41lr9kSfXvOfGfBDy11DkOgQFW+wWwHkFkoavBZPjKW3BZF0tmKZXnFxOcuztza
 r53pyjb6BEOFBCXsQMFiLuGFyfNBJWmLZDI2YS3jS7RLEg7BetmQ2vSDDDwNkJo7vadZ zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdsb2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MFd2hp019832;
        Wed, 22 Mar 2023 16:20:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pg4gj1vqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R54mc6uJjl48xFG0MOnEHY0rygFvn9rOKN4utAR53wbTRkxaz28q1Ld7uhaZp2wdxoCpPzRGMsN/44NBVoD5zeXyPx49drONUYOFqG48/fBQhJ6uD7g0uaUZ7N24rYiA2v+VahVDBilMeGb+N7A0R3emefHV01pt2JBbWYxDMtUJhU1wqDxmxUDMpXtqwJfyqYJxs9OCFR49Bgyf4PIWACuu2ve5BWNN3AVeKjZ6lojXKfqfQOJj0paKEOLjroL9wvkbH5Mb5+xkD4bZYTstWAkjgOPZWey7y1J75mOqZPaLsKnFh3t5Df9kGY7wLS3use5TBRkl+7PiGkWdBD4ZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZizaT3EjoZnNPAzoL+omRQ9VQ+Ty/EDFZt1NsSUoHRM=;
 b=QPf0SYh7kw+9bAG8AClCHqp6qlQw+Ix5xONJj+swhDuI1m2IpdSZZAc0kwC8JzCJFbxQnaAWsqCW5EWGkI03YEDWfCRDCgHqZ/4A8mtGeafzrE+4TkbtU0z3Fo9/Z+Dq6oDBSBZ+pvq67Bzk52dl2n21PfHTCdGQjjAtAfIcUGRdQoeODIp5j6DOSOlHllsWZOEzlL1yLh35SumOyKLcWMFILW9ux1ZYweWxoAw7TGRiwxEnt8qApqJ+Alk0RIh5MDnfLAdJLqozYuS0VJJpGny3Xj3M6luZTkd1pgiDWLXdoNUVhM3sSPgrpo/Ip6pT6ZkBe2l7vlQmNmTj7jadBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZizaT3EjoZnNPAzoL+omRQ9VQ+Ty/EDFZt1NsSUoHRM=;
 b=TsS8UBzVoFVcUdP1KnAF++avGnF2ROYCl+zMHPKM75dC68iLk0P84uTLPDHnqdx5mqrSq7IMLtN1A2xLq47IJNKV+Rw3iZ+dl3Q//ser7vCpWYjH3UVuMsPwYGkXK0O29QrL6j0ZFpwBtyPonx0lL1oQpffgnmMp+XSaOia4CmI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7688.namprd10.prod.outlook.com (2603:10b6:303:246::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:20:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:20:02 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com, jlee@suse.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v6 0/6] Add CA enforcement keyring restrictions
Date:   Wed, 22 Mar 2023 12:16:28 -0400
Message-Id: <20230322161634.2233838-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff5e703-9127-458a-7631-08db2af14a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IXtbu/Wwhh/NyNO6GabduKWZkgxxO9Xr4/80WmmfPpLZlGaMRleobTHPi7Mfcm3MVUrNgtVdsFjbl062N+4CEL8jQQzmdS0HkS7Bv7apxt6hpYbyntwnodsqNbmq4SIeqpw5QvgWLn1BCn8lWq04bp4+wTRH0ZCLSPRwSVPlWiCmpPMeMhfJNongmbRFmyij1lIKrqvWivSIGZFqi+AOtT1dffKKzawy/XN6bmAZ8cZ70xaEUwTAZfXHtPfNnOtTBHAb+MvE9Q6CQowSWRD5H0LPWSeLXPkFvcClsEJ4yvjVWz/hqQW6dbTTMwjsUWwSvrmEAhFjenGACt+Itlvy/8ih4BZoFYuneU/h9VQqIkpDOnjnj5k4bU28Goxtah8bERkiFW9Qju/GDcwD4Rc8zCpahlxeohVC7vmw9ogeZ4R6ji1fl7JnTIjWgoEBQmcJYvC6YDyAp86gP/jRAEdDvkQh9DG1bUK6Bu4a5xUnVQI2GVhGfr9N+IV8VRiWnt8FSYNGktyOm36qIr9V0ZKaXVyc/9qy6/C4IDBX7+AvpWP8SL1bwzwVrDkkCR5/Y00yIyExFQH85+RWO0k5aMTulKJvoau94MmiztYTcdAzab75vMbaAiGIuoK7yJbWPNnCetvMAO6yzzkwZdljlHyiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(38100700002)(83380400001)(186003)(41300700001)(316002)(66476007)(44832011)(8676002)(5660300002)(36756003)(66556008)(4326008)(8936002)(66946007)(2906002)(7416002)(478600001)(6666004)(86362001)(2616005)(6512007)(1076003)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUMepAA8bf6/6NoQPS2G0KKo+l2ipqMQBhJphnA7qIca3FNAAZfv6VeD0amz?=
 =?us-ascii?Q?ltnkQPlq/pmwm4ErGeBqQt0EgwcjDDeQJB/KTqmb2vw+4yWUTW5Ghvk1QnHQ?=
 =?us-ascii?Q?1HfiWhcHcIUcmgppr2vIU3HZ0PdBmrc0CfWm06X3WJFuPuZB/clvBYtGTsyU?=
 =?us-ascii?Q?mDo8AZGMdSDhyG5Uo4b3DqSdy1pSEue42/rwonlE5hKyudAtM6GI7n+hrQsL?=
 =?us-ascii?Q?s+/vL2Cy8FTO7ee7QZ87lSi2aemrkNrrYyWZDOObkm5qMSW764tv3hEQHzzO?=
 =?us-ascii?Q?oerykZ67VW02zAFwc6pTbpRfKjmGxmyj8zzria7ZL+a6zqWi3D4/yqvUYAtM?=
 =?us-ascii?Q?4t/vpkBkkjMZN3bBmDeYLMQb1Tbq11/TbN6OW9t/EISWgA4gJrMwcLUWX4c+?=
 =?us-ascii?Q?Q8PLQMYC0SWYld/zxQlAf4xrCOSks0+teuRoVq1oCN8O00SnQrjxLRclhben?=
 =?us-ascii?Q?tafcPD9V3nkTSWQTaGpAQc/xy0okyBmOr/PGZUq/b90fljnJUPGU6fI0HcAg?=
 =?us-ascii?Q?BvBIZtNjx+IkzmY2X8NtLbZV4x9L/ocBnuLpUTGXTBuOtluK0DeFJD44AT0O?=
 =?us-ascii?Q?41sUkymxrx33OGJUOREJWiWRXdFjT91eOvPdXO71rD+TPh+EuBkN+hsC6aPX?=
 =?us-ascii?Q?aj1hytPA5SKE8ZbX8Yyrv025Fa5TNdEKgsoQPRCbhnP0430s8Buq+H4GirbS?=
 =?us-ascii?Q?kZFRTbXOH6ijJgDSG6jhDZTUN5FreyVSnNvWSWmY0A368Hn9g6GGOGflXAWo?=
 =?us-ascii?Q?A0fAZWRdriUAEFk820MrCxsaTgHbJXGRS79HkUfs20oB3/v+NQEkeBzrt7+3?=
 =?us-ascii?Q?u6ueIrEBpt3SeKfqg7pDp8nhgtSI7qq5Ei0vcC67kq9aguiXmPOvBlVt00J6?=
 =?us-ascii?Q?2I2zsCec4WgF2loxvLqYQ+1+yk9LR/4yMirWgcQ0/2pUKaQ4oEXbmQj2tfuJ?=
 =?us-ascii?Q?J2GNKJF5N1xTARrsbY5dOMezl9Dh78AC54XNIDsJp4v2cNanFmlOl9BXW6zV?=
 =?us-ascii?Q?lfAbyH5bSjZFydA3dkC5KoS5pWsfFVdLLvPiumHn0WSDtUkWbbsZA3cOxLrE?=
 =?us-ascii?Q?HabEREicz79XCJxS6VdsWN889NrrUbKjfYN5IqH15L4HOcEGTkJRl8bz67BI?=
 =?us-ascii?Q?qXTGc9kFp4mwChMIGuMiLgL0fTXXDlvojgJ3Z7yJcMfZIOR5P+XRQMht4JVM?=
 =?us-ascii?Q?HYssdeUWfwiTpnevln6aKT4DGYHm76mDgP3RsKYm6KOxsIFUwHMSch/xDnOU?=
 =?us-ascii?Q?quHYGpYTYn8QPgwnErRLD2GaCjeYi6gr2bd3qvvIjvHn53NhSJ9cvsDZC0rF?=
 =?us-ascii?Q?0TjwIhtTcQvUXzZkCLDRts8leUlonHIuVIQbcWc+OLvViKJ9RoOw2TxbETTE?=
 =?us-ascii?Q?ozQDUAeBSygXVcyAjbUVJ6rvavhqxO/lHUBtetba8saSRxXjYS+j2cuDa4oX?=
 =?us-ascii?Q?vfdzOVn8TVuLwFqIDRz3AZXUNlViMuZSsEHUawah7VhhmfmgWRTKO4ljg3fw?=
 =?us-ascii?Q?qLgtTnfaopw/MZ1lTqv2p35xuaFSKiYb91j+8IXI6OXi4barXsTxo4FPdTE6?=
 =?us-ascii?Q?S4cKQ28Eja9qJXAxA+0ttCFso12GBCFewTOqVK0PDueBySinR/z/NlfMpewq?=
 =?us-ascii?Q?Z6BFsFhGvjNLTpLl7ZfFanM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?akcvdVfwfn8EbrvrSIuzsgo82kKP8Jf6wm6R5szLwtq7d7Uljn9uTw6BQzw4?=
 =?us-ascii?Q?fyjyFe+LXfQzo95d2vFnS/CvTnO8vZIv7qR8FtvkJ5eCl+1sthtcnWlgIUr5?=
 =?us-ascii?Q?qlSYhgmLSBIKRoH9AOyIe6zqgesr36aSEt7eAz0QjdPFatBcH4oyHEiwoDEv?=
 =?us-ascii?Q?TFzYp6nuPmZdFKR/vc4wZnAC8kSf64jHzugblKkNt9UbJp60/hfrRBtT1tNF?=
 =?us-ascii?Q?XWNRs7JJm349t/kuGmp1aQMiFVo/tdcsSX2PnuF9v9LcP/jMYuwbwzfbXcGu?=
 =?us-ascii?Q?DBKUsk1itXXVVdY8BmRKJJG9yR1XsoGFhjuH5rd+IVu1LOuvg19eKQSJWPPO?=
 =?us-ascii?Q?mM4ETWdnHu1+PZGfES06+2Z8SbAYY3AbWmXTMC+VJ5nyygupPVrkOPfXgSFq?=
 =?us-ascii?Q?qW9ufazMlRzE+DThcv48j5gK0+rNxGOIDScz0VvTSiwRyJ58sykiB9Zur4vf?=
 =?us-ascii?Q?V9dneUQ2ezvWc55Oc1VEGupestk0Ux1qE74N2h33wZGo4wrzUyYjGOO4yRyu?=
 =?us-ascii?Q?xyaYcfM+8szrUgzUbJ9D0xBb71sdK9q/MvqsSrlwfDTCbWKbkqqkKCFZCbmK?=
 =?us-ascii?Q?5sqCAFzl4uEW7v4rkOyVr1kILcPcihaBHa15hcFoWecF90oGT4gm1z/BO3CL?=
 =?us-ascii?Q?/C6gur9C2twMKEyZ/RjGr+jkrM6GcWI0WEA4vYo9Eg+q2q0ThD+RkU0a653G?=
 =?us-ascii?Q?ErVoRZmAbDq/CfE6AV1E+yQ43amkxRX3z5g8kNDygdOi6zzp5C2Jv3ddcajS?=
 =?us-ascii?Q?aq94jgu+WwkVLoRhWOVP2c3dRaG4aCZB9+fJjQ7B+Hkx8n0GJ1s48O+oTjyX?=
 =?us-ascii?Q?tTTql62rG5wIrceu/qJMjINcdJnCbVFPr+AOJBdCCGePVapmgfUsai6f+NC/?=
 =?us-ascii?Q?razqnerhm3kI+WpvbK7/xTmRBnNjJ8e7ixV1L2fhqmImr53g+64xUcRFaerq?=
 =?us-ascii?Q?PDZNv01gb8WEgAcWymr9b0YhQBnOluOnY7EGmGdC2EpyhHr+6ZBKNbWqyMwc?=
 =?us-ascii?Q?tL/nFkXZ+e5Me+SB5zlZEZD5A2+zlhdH5Le14buYuRvK+oXfumVDBTCmLDfN?=
 =?us-ascii?Q?NqmbGtJxY/RDWTrMoiUHk7i8rFLCGRqIdpS3ajGFXVzom4T60KKwUysUo4cN?=
 =?us-ascii?Q?Yf3z4tM1cXX4/hQMR58PEcX+R0SPpDyCbHmxfuLrQjPdRf/aUOK1wPeOJoYc?=
 =?us-ascii?Q?9fvhECY7SD3zFgYk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff5e703-9127-458a-7631-08db2af14a32
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:20:02.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqKOKOTRoLbnixu45RecWl68WZd9roH7QTIH4iDWCdhzZaGFtQWoKFBnwd+lZGEBqVANVlOTXan5CXWjDkR29VrVVrBuDfYdj84h0UPzST8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220115
X-Proofpoint-GUID: sQd9h5liG34WXzo5Iu00loaVXJFbCZWJ
X-Proofpoint-ORIG-GUID: sQd9h5liG34WXzo5Iu00loaVXJFbCZWJ
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to the introduction of the machine keyring, most distros simply 
allowed all keys contained within the platform keyring to be used
for both kernel and module verification.  This was done by an out of
tree patch.  Some distros took it even further and loaded all these keys
into the secondary trusted keyring.  This also allowed the system owner 
to add their own key for IMA usage.

Each distro contains similar documentation on how to sign kernel modules
and enroll the key into the MOK.  The process is fairly straightforward.
With the introduction of the machine keyring, the process remains
basically the same, without the need for any out of tree patches.

The machine keyring allowed distros to eliminate the out of tree patches
for kernel module signing.  However, it falls short in allowing the end 
user to add their own keys for IMA. Currently, the machine keyring can not 
be used as another trust anchor for adding keys to the ima keyring, since 
CA enforcement does not currently exist.  This would expand the current 
integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
Kconfig states that keys may be added to the ima keyrings if the key is 
validly signed by a CA cert in the system built-in or secondary trusted 
keyring.  Currently, there is not code that enforces the contents of a
CA cert.

This series introduces a way to do CA enforcement with the machine
keyring.  It introduces three different ways to configure the machine
keyring.  New Kconfig options are added to control the types of keys
that may be added to it.  The default option allows all MOK keys into the
machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING is selected,
the X.509 CA bit must be true and the key usage must contain keyCertSign; 
any other usage field may also be set.  When
CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is also selected, the X.509 CA
bit must be true and the key usage must contain keyCertSign. With this
option digitialSignature usage may not be set.  If a key doesn't pass 
the CA restriction check, instead of going into the machine keyring, it 
is added to the platform keyring.  With the ability to configure the
machine keyring with CA restrictions, code that prevented the machine
keyring from being enabled with
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY has been removed.

Changelog:
v6:
- No new code changes
- Added Reviewed-by and ACKs
- Formatting change requested by Jarkko

v5:
- Removed the Kconfig _MIN Kconfig option and split it into different
  entries.
- Added requested commit message changes

v4:
- Removed all code that validated the certificate chain back to the root
  CA. Now the only restriction is what is initially placed in the
  machine keyring.
- Check and store if the X.509 usage contains digitalSignature
- New Kconfig menu item with none, min and max CA restriction on the 
  machine keyring

v3:
- Allow Intermediate CA certs to be enrolled through the MOK. The
  Intermediate CA cert must contain keyCertSign key usage and have the 
  CA bit set to true. This was done by removing the self signed
  requirement.

Eric Snowberg (6):
  KEYS: Create static version of public_key_verify_signature
  KEYS: Add missing function documentation
  KEYS: X.509: Parse Basic Constraints for CA
  KEYS: X.509: Parse Key Usage
  KEYS: CA link restriction
  integrity: machine keyring CA configuration

 certs/system_keyring.c                    | 14 +++++--
 crypto/asymmetric_keys/restrict.c         | 45 ++++++++++++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c | 50 +++++++++++++++++++++++
 include/crypto/public_key.h               | 28 +++++++++++++
 security/integrity/Kconfig                | 23 ++++++++++-
 security/integrity/digsig.c               |  8 +++-
 6 files changed, 162 insertions(+), 6 deletions(-)


base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
-- 
2.27.0


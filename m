Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3768CCFC
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 04:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBGDAl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 22:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjBGDAg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 22:00:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A736085;
        Mon,  6 Feb 2023 19:00:33 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDjXJ031540;
        Tue, 7 Feb 2023 03:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=LA7bGMGKwu1TbO8yClBXJUvW+8G3XGhyMcSJzULBAuY=;
 b=C8u7KD6ZEh21xCT+g2PXndSG5s3Q6EkNsRv43jpUflIN3TIgZ8Bepv5prAjOGCWKWb3Y
 4q67+eFBw5jWmuGePhlyNWs/zXTOwHA1QHoYQaRUy/crM8uZ5Yqih74emNWIefSk7N0x
 jr50xtLAmPyxNeCOBxP3SlFlOshwI7uj5a/cdAK0KawIQlAeLM35255oeI6diQwKrcif
 mC55sMqB76Sx7F+bgyBNhZGGFmfy+k6YayWp9VBkcBvCSAkI4JxwzqB5XHgmYiVrI9/g
 fXruDur3vXOIpV4L5aqNlWuuGSRy9qLnVfaMpu6/jlE0kUHLgWrBiGgQUDR0pN6XlTeF 1g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53cgbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3171ama2037016;
        Tue, 7 Feb 2023 03:00:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtb8bjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfKht6PLnnLkzQUB25d1Pwzro0sN62Qh20AHaQUY1r7FmuMVI/YzHybMuACwjnjDDtcuhjEX9S3OUWwF4kSEyoz+Q3MV9bntNy9qQUUELSydYhgcKPvv1mAXKDSGD5Et+36kLVDmXxWIR5qjfkGMPOuY8P13bOOzQR7Oeazg7b+wWIlr06PfdrinzRwvJH3/4sNriDXwt1bxh4U6+e4NgAJjaFBYwTDXr1c7dOPSgEzsoRh994sy6wzjobLJfENrCDDxj0TqFfC66perd2OfzxPhC5uwnTCm4aZwnn52JYDSicwwqJi0ZxIj0qAx5n8fGikt0outG9QW0W700mfg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA7bGMGKwu1TbO8yClBXJUvW+8G3XGhyMcSJzULBAuY=;
 b=NEKz9Ck14+4tZhiGJhPJpWir9UuggfudjufNfpaJ1+g6EsJeV+JC5Fcv5j2jSIekKTfSUtd4NMqNmBi30zG0NCniq+7ZCWBxNDGFXr4fwchXO+Ozk/WYSI3A/p9aY9OpPLBnZBiqK5+f8ex1wIcYYv6zTULS1YZ4A+me2hfbH7o2asOI5AdbtMhROhutQ586mTXA6Kvf+VKtJuOGcQHy4PQrRK0Sws59r9qKGW7VapkjfOFqWlKRbvXEEHhXBKKyRNJD6a03he5pWNAONUvp8TNzMsHsiNzoU1yQ4s2UOmuiuVQmRO9FNM6FYWqgGMdkSMLBsYuox7sYZLjjB0/zhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA7bGMGKwu1TbO8yClBXJUvW+8G3XGhyMcSJzULBAuY=;
 b=Wh9X0aGw/EcWFLU4090ppYyO5Wl0wzJ4Ezf6hzzAH8VypuJS/V0PejnuazG0CkA/FUaYL9FESqhbvi/7bJfu1A6YrFgcmQFY47oMWOC4D4YO7VQdYcPfthxFJs2bif4J/HS4lstnRtsUuvpyqn3YEtTHUZFGDebSY6yBDMYvBHU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Tue, 7 Feb
 2023 03:00:03 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6086.011; Tue, 7 Feb 2023
 03:00:03 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 4/6] KEYS: X.509: Parse Key Usage
Date:   Mon,  6 Feb 2023 21:59:56 -0500
Message-Id: <20230207025958.974056-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230207025958.974056-1-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:805:de::44) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c58e9a-35cb-4a76-54cb-08db08b768f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: defctE4eGs0+zAebrihL/YVnk1yLHgesWggDOizD59f1tzBSBiZwFaMM588WDUycfdOljWYuVmyr8+KfifotDaNycdR4qjC3/bJAf0+jOd0hmAagwXyxSoZLGuR1GbujFmZNUxCBo+NwwtVUvVuGSzletVe7JB4jdRHkN9Z3L7vVtjC4yeXbMEiQ3pfzv4SUFUNuXCR5cNBQG58CwIdg/jdLWi/IztAljlCUnkV6hvvEYCejP0kkh53ISfd+N75IEykRVD08VbCbrqXlfndhozXMCeL3sXu9CHUgpvYpN64g2hJO1y3ikt/ahLY0zFrjG9887TqDH2sr3UjsKWOVX/rdq+6bZvRji0zJkJbPqEBkNU2KSTrCecEfewY2gSJkj5B03Nr2FWhNhE83C1QcxajesF7fap/uDnKo8Ho+jqM9tFTEKwFpSoYK8eXXeGppeFGAt3+TExtcV2+UMzNvWWklmgqAKzMOTmbx4vx1W2n0bBTF/5Z9/YsI5ach8HExJ1IUDxmpYC9A4U3tqgVfu3bw6/54PxWgu2FYmXBBBRjpXCVNpPf5YqA1kA19gNMyh3/L5gKsXvt/frqP5VhDoppMJBG5WJgT+eIAyPDJBWPzytycUTpMO9P76bJlu/yCBC6yVvb2I3yvW9ag4CoR4dg7RbEeGEeuqKfd0FoctyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(66476007)(7416002)(6506007)(36756003)(38100700002)(316002)(186003)(6512007)(6666004)(6486002)(478600001)(966005)(44832011)(86362001)(1076003)(8936002)(5660300002)(4326008)(66946007)(2616005)(66556008)(41300700001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84bbNMkANS6wKPLLb5DClmzUM3nTkFxrcVT1UFn4CoF2hiGlgzr4J0Xg1hwt?=
 =?us-ascii?Q?HT8WA2xUy71sPCZxxWfkNmcz/ExUUpmNuKOzQFMVGH8twsjbHk5CgNUezceP?=
 =?us-ascii?Q?GIfyhlssumIFZie11086eINt1JxitoRmzDK+SMAowOUioeN3nPcYkbhHPonA?=
 =?us-ascii?Q?6mu3SKuA5Z1fNZZ4am8wJBrQwjBHa4vLyV5ypXhh/WToPvic2m8sSQCpfLdm?=
 =?us-ascii?Q?6Idjk+/FmWPjWJi98iAc4UpkDzrz+a03gblOZCx79GOjDJDPAqhSYdQqJOQb?=
 =?us-ascii?Q?YT6tHbWH7+MJUlrqC7/Gbbme1aTWfBMZtMWM0gJVwgC/ReAzJUiUD/UQ0VJ7?=
 =?us-ascii?Q?vF0ZoCrGOrID/DpWNfXNeBnmCs9JeIcRiWTEB1JlyTV4nHoVW5L+D64oz8wT?=
 =?us-ascii?Q?R75Y63eaqwov2kUTD535FiEoRFEhsIoNtelfdWx7NEHwKG/7Twfr3WJmh7gq?=
 =?us-ascii?Q?ckFt9WwKjaDrVZPrWe3uIVD73ZUpWgdOPQgLTV8ROf9bYlyHwQf1jg3H987l?=
 =?us-ascii?Q?vA4FUwZmVJ/i3FUlKgwUOQmMG/MPjHQTOZq+CK9XaUv5RJq8I5SMaxVrWjwT?=
 =?us-ascii?Q?oYEPgwAOS+Oha1RwMHeQdpauu21kdupzs3N5YueHIpTIofSrvHWtQsUBv08U?=
 =?us-ascii?Q?DPGE0YpbPYRhsqfmVHpi8ai4tgFj/RugeoDzqPuY3a385N1Zvtb8/L2ZUdF7?=
 =?us-ascii?Q?GY7P3+WYC8A8cyJu1sR9+qIOt+zsg2wEOcirjkEhXYkioaFFX+NTGLORC/7N?=
 =?us-ascii?Q?iVsIPF8TUkdgf/w40I6askFd82acYXm5plhWlSXFLOfSEBkKNpZ1XpQCJQvh?=
 =?us-ascii?Q?g++79PyAJixsEW1THJka47ODjJTMOJFxxSk3pFXQDeWTKixCj+41ea/upnKK?=
 =?us-ascii?Q?TDACpaDBP29ON+tPygtP1SrDdXf6Fiw11XFrLqRBMAAe+2Hlkamv72YObPN4?=
 =?us-ascii?Q?3IFYTHpPHeRzfv3W2FasM6BdL7Dal9BCkymxny4gKs885AdSXlEhoZrBhVAO?=
 =?us-ascii?Q?l1RbSxeIs+F7bsvJ7DYVUDw2gaFLzCkkk+LeiixDLpHQFNuZSJWhnU7tGRwy?=
 =?us-ascii?Q?w3nEoyHKWjI7CNrRooIMbdVZEqW97iYWBpXvuCm4uEdM6FLm2JdmGcIyqpxL?=
 =?us-ascii?Q?4kx1X7QiMwDkLPc1DoEarSEcuEaRa3D2P9OGrHUO+dP9qycUNLmKA/qP/peg?=
 =?us-ascii?Q?UfTIX5xrQbDOSRPoSO4yBmdjA04CiyMiJFoNmlN2nuGkw0rvirHrkXSseBBe?=
 =?us-ascii?Q?GoILTx3qWRNj3eN+9hcdFgbdqzNbthUHoaPU423Igp2odZQZXLs8tX8WL5mj?=
 =?us-ascii?Q?RclJEEw50Uo31pwVmOi+5euIlsUhXF14ddzpnovWkd10oNxOdasM7V6uJp3R?=
 =?us-ascii?Q?BxVFyZ5+LutZoWHKDfA6bGI+PMUJjY8tzfjylSpiySxLL8INv9k4ivVVYxUR?=
 =?us-ascii?Q?TSjwjdKDCZNtXvDvTE6oBHlm+wMgb0UvrSqi9sHioSfYwQef2yTL89VQDuAL?=
 =?us-ascii?Q?Y9Dw454MwfZCvJ/PXTTXdDDWFfzh5bqlQbxk4xRzgWUBh6o2DesOpha/TjyA?=
 =?us-ascii?Q?wMB9sYXeR3/GTOljHo2J7BRxDQJrLZLkPv6L0ykXARkq+C3rvIJ4BPiXcNaA?=
 =?us-ascii?Q?+yEpzCqmpBsXfQAqXmGc/zs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jvF5gQEbm3QD/IAWi//ct8tt2PW+d8c6O8bm1sabI3pe9KNRAtSvVruzXM20?=
 =?us-ascii?Q?agmREkwPhTdbO5l+V+eoo1TAgmfaBDIkbxpXLH/HXGYeWZxwjlh4iAO9V2tj?=
 =?us-ascii?Q?TKEWPC6k6UaJtj/44fypLhyg0Qx5vMAQvxzk9ULeqqkByt3tTV2jJj4aAOEm?=
 =?us-ascii?Q?w/HKFMzdXvMtJPlq5NcfK/e3N+guHjPg9oRKfua+XupmHpyabPE+BY1E1Z1L?=
 =?us-ascii?Q?cRA1XJ9y13Ven/hE3VxcEmbM4EdsW69axu2NO2WMcVV7joDBgYyymgokEy1h?=
 =?us-ascii?Q?7PGXQOyyaOyYZDqMGyX8DiZ9jXUrvhYOf1JCE5tF68658ui4NMWzdrrE7PvY?=
 =?us-ascii?Q?EhAaNJFPMSI7fdGhSjUDuby47OERxEyG+rpZt9FlezsKf4YXek2oR47rnyNC?=
 =?us-ascii?Q?7D7+Fd7FIpo7lirO9BjvVzQlhfgiigDt7VIficfaXtg+YzluqbnbZLkJBoKR?=
 =?us-ascii?Q?OTBC+daF5pmsc+sjPDcJFxVUSksqZMiAKbaKsuGPe4/7xl9v8kOvoBxSLS7e?=
 =?us-ascii?Q?f7d3IfE8Ug0Ng2f+a55wUHrC2JBo8GZcs8Mfm+cRABrgWvf/oDeKC8dqYPSp?=
 =?us-ascii?Q?7DeA3XO6cPXaFHdc99qsnZ/GVM4yFPpyuxs7uvZxUc8thYGAXQ8tf+doZCK8?=
 =?us-ascii?Q?e9nEpx2sd17DdP6fUn/XcmEaeIkPsVh5q3ZCA0CIGstRxv6rlnNkPu1HvFfQ?=
 =?us-ascii?Q?sAHrhHwuLZvW7cHHH2VQ/nw5+3AgYxwPAl0PGgEYuH1mtf67p9LeeHTRHdyd?=
 =?us-ascii?Q?SG/J65w70fDUdDVpD5Io7bjX4fmy7gG4axKZRfoQKYBIeDKfBPM/y8HxYwjW?=
 =?us-ascii?Q?Ia4dWclBt56TtZJIqyhn5LLFOLdLz8HzcLh3pWgrfJqLiaVk504tf1rPyJNG?=
 =?us-ascii?Q?MCMy2q/5bPUFfUjpneUEBQBDayvEi6qNZRpJNC1HY0bRBQH9pzmq951dorym?=
 =?us-ascii?Q?qcX19Ipdw9nkYGR8Z5zKD8YF5IzCAmAPibtxjQmt2lT0buN3HWUPmWgQXvCw?=
 =?us-ascii?Q?99i9zIdPi0Lj90xDuTZ7CYwOrZIHRG+qYJMcGxTHVnKwmljZoJNPjs4X+MpK?=
 =?us-ascii?Q?C6O2/9tp3Rfk2Houudzub2ihLBsRcOi4BVgtnW2l+DSoWyMIOW+v43ZBPtdx?=
 =?us-ascii?Q?FhkrZpQPnFOq8cSmpVq4Xkp2ySJ1X6i1FOU3JpDr2JpcOg2+ojFoMAox3FWH?=
 =?us-ascii?Q?gsPjeAi79aMEAJUz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c58e9a-35cb-4a76-54cb-08db08b768f4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:00:03.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dR+5mv+6bLM2Mioc5GS1wfhB884RzAlswwFV1bg61lodZieVyBSD1QRVdwIncqaTkHeV/Cumq5m66qsT5J+lZCQ9ZPVrWUwBqgbaleZnw3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070025
X-Proofpoint-ORIG-GUID: UWofzCrLamhGpQn9uehEeHLka52SyX9e
X-Proofpoint-GUID: UWofzCrLamhGpQn9uehEeHLka52SyX9e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Parse the X.509 Key Usage.  The key usage extension defines the purpose of
the key contained in the certificate.

   id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 }

      KeyUsage ::= BIT STRING {
           digitalSignature        (0),
           contentCommitment       (1),
           keyEncipherment         (2),
           dataEncipherment        (3),
           keyAgreement            (4),
           keyCertSign             (5),
           cRLSign                 (6),
           encipherOnly            (7),
           decipherOnly            (8) }

If the keyCertSign or digitalSignature is set, store it in the
public_key structure.  This will be used in a follow on patch that
requires knowing the certificate key usage type.

Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.3
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 28 +++++++++++++++++++++++
 include/crypto/public_key.h               |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 77547d4bd94d..0a7049b470c1 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -579,6 +579,34 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_keyUsage) {
+		/*
+		 * Get hold of the keyUsage bit string
+		 * v[1] is the encoding size
+		 *       (Expect either 0x02 or 0x03, making it 1 or 2 bytes)
+		 * v[2] is the number of unused bits in the bit string
+		 *       (If >= 3 keyCertSign is missing when v[1] = 0x02)
+		 * v[3] and possibly v[4] contain the bit string
+		 *
+		 * From RFC 5280 4.2.1.3:
+		 *   0x04 is where keyCertSign lands in this bit string
+		 *   0x80 is where digitalSignature lands in this bit string
+		 */
+		if (v[0] != ASN1_BTS)
+			return -EBADMSG;
+		if (vlen < 4)
+			return -EBADMSG;
+		if (v[2] >= 8)
+			return -EBADMSG;
+		if (v[3] & 0x80)
+			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_DIGITALSIG;
+		if (v[1] == 0x02 && v[2] <= 2 && (v[3] & 0x04))
+			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_KEYCERTSIGN;
+		else if (vlen > 4 && v[1] == 0x03 && (v[3] & 0x04))
+			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_KEYCERTSIGN;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_authorityKeyIdentifier) {
 		/* Get hold of the CA key fingerprint */
 		ctx->raw_akid = v;
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index c401762850f2..03c3fb990d59 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -30,6 +30,8 @@ struct public_key {
 	const char *pkey_algo;
 	unsigned long key_eflags;	/* key extension flags */
 #define KEY_EFLAG_CA		0	/* set if the CA basic constraints is set */
+#define KEY_EFLAG_DIGITALSIG	1	/* set if the digitalSignature usage is set */
+#define KEY_EFLAG_KEYCERTSIGN	2	/* set if the keyCertSign usage is set */
 };
 
 extern void public_key_free(struct public_key *key);
-- 
2.27.0


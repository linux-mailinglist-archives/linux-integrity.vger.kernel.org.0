Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542286A8744
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCBQro (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 11:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCBQrg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 11:47:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A20F4C6E3;
        Thu,  2 Mar 2023 08:47:29 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322FCl1B028152;
        Thu, 2 Mar 2023 16:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0y0v3HYqXP8jxWz7DNC1natKc715TPpcOTI2z4B/XtY=;
 b=poheWPZ7SSSswg+7OZq4JAxEHCkkPmtj5QTzFSZ5jm0ezJixJZTAV6chTMW6nCQY5sNd
 DkjtyqaKFAuhu4sFHqUP1i1SiZaiOvS+TZ8bqDDM2rHzxHEUTO5qXGyxx4ZTwHIE5veU
 xeYfVNRSnT9LhxMQ1fJAaqbcx6tHpFmIqf97/Lmlr/v7ruBEYgrpmvHa0IeSztZ/HIHJ
 y34TPcv9AtRIgmtT2w4Sz6gKP+VMScE5mBUZS+IitY/4F2KS8HBUso0CcApM2rCfo/5u
 DZveuS9kdNVqwyDIOjVucSO8CEfdrQ1mNiS5/RzfEf6B7rhRkcNlecwA1DkZe2ifpVS5 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wvfq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:46:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322FVce2000634;
        Thu, 2 Mar 2023 16:46:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sa9s9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRKN6O62ow51TZyxkfkR3885bKLMg5DUcEkDX4Mq83qDFH292D5o7Ra9c213/2G4i5r6MGu9ukI8QPx/3oLeAYkMRXkij/e28VMsE2wPatAOPHGghWnj2KtMTzOgHwTTtoQg3SRtpPBA8DBSZqpxynqIqkOg9aSHxYeLcUsOrk5+9a72Bnkn1+noqjwMJo646BEavkywBLIHkpg8lLCuHRdElCuVITEA2PLrKpWfejhYhiXCO8euWSPOlAFGFr3bexyaDOIIemRw8rfCRNz3kfbNGHf3AeIanRvDBCYBxrmNq8+dVutkLgpvUKf7fonhf1Qy1XODVlL5BD0KOQbbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y0v3HYqXP8jxWz7DNC1natKc715TPpcOTI2z4B/XtY=;
 b=jSGD605CVHPGwgQ6g0GiFvgBSnJEVlxqMjpEp8a4qqOGSz3EjZtq2fgcSYisu3VI02dBi5BNsT4nae9wSz1vRVOQEgYrXJbrbOv/ZmwSFTrO7bB7p5A6ku6W8RWRUe8ICM+HhR8LSe+mZtYPFJpATy/LsPmaJgC1YvegoldIb3ycjCPk0WSoaUDkBpJLEhiWkxX8/RLc5hb3nNzwlb3Qw9eR7SRvCXz9RC+bHFrwH5KCHvo0+JDe2yK+9R2B1Q1Pfl5SWrFkU4rNr7TGWgUQLDPHN5c8J/op50RFksyN6aaTCYmdSJasxJZ5IbwQw65xNdakhIdi04cPcSaCB/Taow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y0v3HYqXP8jxWz7DNC1natKc715TPpcOTI2z4B/XtY=;
 b=h1XisZg3oeJm9VRbSGnGSXtnACdeXOgSZeGP+bG7zL+VpgDZrp/vmlWKOUCh1N0HeBWtEn0cHb/FcOsfoM71kYw/WgjpUr3IREfAYic31IdVMpBLLIRLfuXQA3YyfP/XuRlQKuuoOOmHJZ8TWO28Ako1ov8vIkcnYCJP7rAljLs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH8PR10MB6357.namprd10.prod.outlook.com (2603:10b6:510:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Thu, 2 Mar
 2023 16:46:51 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 16:46:51 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 1/6] KEYS: Create static version of public_key_verify_signature
Date:   Thu,  2 Mar 2023 11:46:47 -0500
Message-Id: <20230302164652.83571-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230302164652.83571-1-eric.snowberg@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|PH8PR10MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 8932a5c5-106b-4497-e74e-08db1b3db8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05D5Le373oX6Crh7JXAgPAvtBq/v/xCVVUNqOnQIY7PyZJhX8ssTzFuzdI6ow3NnuYnmbrcAh6HgEq/POXv6AYT+RmhQjzGImgbAh7k5gmDkGgT47XmyE/UusRp1odK3fiFMF/HfOO9xPtcDoEIMyovNr7a5XyfYycUHfUAyz9oVfv2LHKkjjg/S2rrgiAmyrwm0BiDVXeTiAuN4KZhIm+7XdmqAAE/6CQ9lYGLZhulDB7m6CGLtjFC1MJ3gGWdg+couF8tufdBPicQ/Ws4YvX9Br1eqz6yeKaANiPUrhB/sf83vHZDeGLGFcGjJCtkI8szOAeWJcZ4tZPl5T1iLgaDfYp4fvF/n9yJ9hBAm8sFffGIW+mgf7avm8+0cswobq0F/7g6Y6m4UhS8THwKTJaDdPDP8Chm+nDN0dZN72MaxxrX+2FhDXgWwWLNGXl6ee0EPGxH7I3mGrzghR0NigKRVjMskJqtkJvmIb+mmFSVFeYCIEVRcZxQ45e0Y/Mjnl6a3kzWy4HTSEUB4aTsxglxD7jwh4qk56kayIJk2WRsKcfd4iDdUnr1qr8MzOCUvsYAoN18T1NZGhIkBcisHuVOMxh9uaPJlhN/cqJctfP6BKrCRwesQgnN25iyPseJeIHdn44taCb4UAzuO2S85hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199018)(4326008)(38100700002)(86362001)(36756003)(6666004)(44832011)(2906002)(8936002)(66476007)(66556008)(66946007)(5660300002)(41300700001)(7416002)(8676002)(6506007)(186003)(1076003)(6512007)(2616005)(83380400001)(316002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U8RQtdChm/5NpJ6o34joXUvorbhr6WJQzC4SG/H7cuVVPtisOcqM72K/hrHr?=
 =?us-ascii?Q?9rn5lFKy1e7hCc9ktJIFlrXwJjjtxssN8VHPV2S7r6bVQTwlSTPCbIH2FuTf?=
 =?us-ascii?Q?SChp0PvpJF83gpGRmpSW8GLoWf5V+FSeklY6mJgRe19yzmot8TRwK7svxOQj?=
 =?us-ascii?Q?mqbBD6ybYGUZ72jVcBwwf+M3FgW1xsfC8PEIr11RbaPCcZUalu2sbA6k+oqf?=
 =?us-ascii?Q?mYSuhpLwbww3IYhnPDjo25wUZq/cYKxCN0hrk5gAjkKVOX3SnVqXwRLvAxbi?=
 =?us-ascii?Q?IZg028ujwoukz+2PqRhSNxl58nWCahr0MPd3ryXhiX0VA7wbPe2a1XzBKXRk?=
 =?us-ascii?Q?1CUQE5F7k/OrDwhsKdVI3mkwj797fBFh6Rf14Vs5HBm2N9/GW6+39HUi3iaJ?=
 =?us-ascii?Q?CVFCEYdw9NM3Poekx9qeUsKZMW2KSOGtR87qtpEbL/n627Tk7vziyHZeTS8R?=
 =?us-ascii?Q?O0MRGrN9pqXPbzjOo4tCvYfChzOBE8uVqkTrFMGDToiQPgs7xbUTSgQaX31/?=
 =?us-ascii?Q?4J79fwepBA6ZcgjLdyZK3NSkWI1wGSF4u0GVmfTdwULXEb66A5cVmiiSxX/b?=
 =?us-ascii?Q?cD3EJyvMYG/eCyd8Dqoa/G6wcLl1er+i+37dknget+ir+Ny1c/Wu8XQJkQY4?=
 =?us-ascii?Q?d05PiOqvpectOiL0NpI4tArj+EASiwAjgD+KMu1ey8UDdafeEHxGWMpjPVA2?=
 =?us-ascii?Q?tVWK6HHbEKBulCsYxq2JzVo6e3+MNdtiB1PDdpLLEB4lduiiTT4XkGoSZKWg?=
 =?us-ascii?Q?UoGYfubFhGb/5TTKsVSDvXlBdZkN1YKILlswDHF7ndG17j1PY/DzVvEA8NwZ?=
 =?us-ascii?Q?8Fmms5Gi7Z3K0mVwccCTP3vQwzf/8g0U7bPNdYAXbIqpEggcJi8nX61DOpuE?=
 =?us-ascii?Q?b4GsN4J8cu67MInnlEduZiJplvX0e5I5HxNMsM8rK7J05JkrhpJe8dHhOrut?=
 =?us-ascii?Q?Sa7m22bzlTkLtQKTOUqUkvl0XU9Ct+NOPGe9wmCnSWMnHxJ4V3LwOkfHPIVv?=
 =?us-ascii?Q?YrgE1uSAXzxn/xDSb5VkfchYnclEZsB8SwRS7VxOlJvZ3Tktj02YNc7E0RjT?=
 =?us-ascii?Q?/fPEUFxD2iOtH0B5xKV0BqfY3hNrxEKC19RygTYc8b6ZV8D+v/RLdkozEZG4?=
 =?us-ascii?Q?mC/eCn9ekN9sYb0TZjHtIaUadeSP2TAkH1LnQfDIGemgKKqt29joIUmLY4kX?=
 =?us-ascii?Q?E74UN+nH/Zvvi6unAYNoO4P0/JLOpfWgszpvMOKr2FHYL9/p3DPrF3BUXWkx?=
 =?us-ascii?Q?jiHQbp3552wvMbNZZjt08qFNXYMvDIYShsKn6sQLOa6vzVSBRPt3/Ex4J6iq?=
 =?us-ascii?Q?IaYHmZUJiDmqSOsdTAuu4eWcDQ4z0CMkRX3toftWO+wec81Kaf8I6LC3DF26?=
 =?us-ascii?Q?LjbGiy1qmc0JGn1IBFaIzhWCtmiNmikBpKmk4PIz1jbsXci8sxO2kagTQto5?=
 =?us-ascii?Q?H5impAPHDsaaUfdfFxZweM73+bFeVuHhmYzAn3NqCL63r80qpHB0lwEw5lLU?=
 =?us-ascii?Q?o7C6BeFIc+SrNNvvELGtvB+FiaWigwpo321Evy5v/q0P+rHaLffHq4+YtCfy?=
 =?us-ascii?Q?3XHxgalFV81VkcJyzI9J3Xm+px6tUYwGN9133BaDtcSTGs/7Eisoob16rGr8?=
 =?us-ascii?Q?QE47kto+VrdzJeB0g0jgDcY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XoClScFGop0m2jyYkig76aqGZe29+X/Y6GgPyDwJyXVy/0AF7D14Z50LfXc/?=
 =?us-ascii?Q?2ceZuDhVzRzph/fVRyUO95i16dy5E686d+DbQzGZPdUzedqPXxgxfFwylX6T?=
 =?us-ascii?Q?2VbbSmFU0csGO53LoNRV9JQ0vc89dKXh/dsIZx4RGjVxJuBpsuUaRdL3UF+z?=
 =?us-ascii?Q?eD91awePb9QV02j6Ygih1PLZaLuGYuvGrzODox5RiQoVZ+hLCdtrVJFebpZ7?=
 =?us-ascii?Q?sIvwTtMvQw/VxudzkWdj/cv4yBJuP2nXAmmRo0KfHrB7anRyRoswdUQAb4wG?=
 =?us-ascii?Q?kduoBWBSMwSzjSYvQjNNgNcXfflOr6ptomBn7IX1H9fbXnLYKNwIrOfBhcoh?=
 =?us-ascii?Q?CT9evlG/098bcftRnfz/mbDFZkh0nX5IZ7l/5q6E0OReV62Z733B5LmlX63d?=
 =?us-ascii?Q?shDBfcLDItBvPjkSYFbkEgWs5kfejU0Q66xSBwTFR7mmli/gcoXJpzfJJzjU?=
 =?us-ascii?Q?N24SslnPD4JPUql9mFvOH1KjDbLctQWHL6f8iE1iIWoJGYKn8YtPFltbcr3O?=
 =?us-ascii?Q?Ay/VO2zbRrLleVq7jsZ1ICfwkbj7uZxtqMELsWLrRFE2bCA8XYju0VN/g+ff?=
 =?us-ascii?Q?4GayKfhtVyTvlOy7xotwsTGowWBnu8T7GxeycXzBwgTGyJ94tqxuiOk1+Ci1?=
 =?us-ascii?Q?GGcfKy9RNGnkbFCkC+OvnqYleCwJl19+Ycc5I3heiMxDMX5z/5WEtTkbcI8Y?=
 =?us-ascii?Q?4vwgZqu3kwDz+h8ecfnX+79HZ4eGfKwqEt1mTYNNp23WEQjzf39nD6CjTIxC?=
 =?us-ascii?Q?1cA8CGNADdC4hrhAJg/3XYkkJwE7TeQumo8FsmZMYqrkGQcQyl5+C56LtOlw?=
 =?us-ascii?Q?/YgV64lafABB62Ta55BAu5z6ZgLejPgwaxDDPiy1a4bjgCwF6NSnK2bGnNYX?=
 =?us-ascii?Q?D9TRqNIfxMQLkOXXpDKkc1v8gWRhp2sBs84X5fjMlDcIdo/LOEA2oKucMDYa?=
 =?us-ascii?Q?/SjlWtkpRv10PnZDpnLfXIxW5ARzRNioS9aRhuFDG8FmNW495QqJRrs0pcwE?=
 =?us-ascii?Q?yEaGd4BOHlrZaZDztMq+MxOr4TOf4b+vYe2uYaMw/IjgvYm5w7FD/xitXA6L?=
 =?us-ascii?Q?Xsg1MhHkxDZpdfajdX6s2f+fq4DEhxW8xBr0lAruK6IS7dAkl/9rpzjtNef6?=
 =?us-ascii?Q?lA9Slvl0ug6lyFluFExkT/e6krxkfM2uPeeNfs+A1Sh/FccJurSYg2g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8932a5c5-106b-4497-e74e-08db1b3db8b0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:46:50.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XotLS/yOpdRlcX5/xkblJND64OJ6PeQt6crl6aX0ux8y1pFiIOirsuKVVj0Xgf8Q0loiMFDLM9YoF9dI+YquovNWQg9IKCPsKi+xU65ev74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020146
X-Proofpoint-GUID: pZwDn_-T_ltIMFrnhgkTyfbtLkxn5jFo
X-Proofpoint-ORIG-GUID: pZwDn_-T_ltIMFrnhgkTyfbtLkxn5jFo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel test robot reports undefined reference to
public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
not defined. Create a static version in this case and return -EINVAL.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/crypto/public_key.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 68f7aa2a7e55..6d61695e1cde 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 extern int verify_signature(const struct key *,
 			    const struct public_key_signature *);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
+#else
+static inline
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.27.0


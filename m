Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD46C506D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCVQVS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCVQVN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 12:21:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763134A1EC;
        Wed, 22 Mar 2023 09:20:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCXrjw010873;
        Wed, 22 Mar 2023 16:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ze/MX9W79ISbQRcvagT2kA5DQGb9rBzuW2I2narODYQ=;
 b=PBjNCh9jmaseLh7eTnrE7JTDyv9BZgArgZS78lEv/Rxl4jdMSdmHt58YVW2M8r6hS2v/
 v5QOWa/10fdjUKL/chhDgDtrn2Bo10X+F8z7Tk7VEXmnjWHRf2a3j5ZDF/8ygU80lG4L
 X4061oD9Tz7Wl+76Vb6os4Vq4xLFi9Xg0YH3uRWMIJVZsT7xk2RAlmyEdzJJRkWfirCf
 MF0fJsbEgwOs5zkoz62ESN+qsGUXO3IABKr40q0JBsSgEjqbR+joIw+nDqEr41OpuYMD
 EQIhiHw1wGK35RJiWDUB20iB8aY5zt1NlPaXcmH1TVLFWC6rQzZezpR7polXXQl3NwLP WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uuhdbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MGJYBh008375;
        Wed, 22 Mar 2023 16:20:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pg53jg0uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY2Yqt+wv7I0BzLMEXLwWwweLf4piKLKUHdvNb1jd1K9RO9F1FNzZWBXz7UGvdzG8NgteoUIYZKrN9cystz0a9csh126Apg0UZHI1PgBsHkp5kaIurIS/IkeNJ6+ZSyKUTMPIttmUTH5eLvS1g/WdUf6eUJPs5cMeFe7Y9Q77q3cC0aXpSbijDCAjwLLtSFMfF85NpuRrR1QCTVEGUeYaOIFEVv0suzRRUzK8HSnQ29BZh+tZmM8aUyRMNgw+65036XDncluWxuOk4t8PtXJgTjnx8Lc9dClItLJOOJ0I2KipdvNl40oT06NttZTbEhy91SxmKOb0F2j411bgSgHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze/MX9W79ISbQRcvagT2kA5DQGb9rBzuW2I2narODYQ=;
 b=f70A9gqt/PlcCO5IwhGC+GeH48KKgxYInEicfxLRnMajeAt+QfV18lTa5g4t+zPBqCnSNpV2bR8AAuQ2IQbPaa64nCfevF5LMwk5rHUk3xKyIc6x60la8lvwzcRuCE/SySEf1gfhm0a29OP3YbkzMf8bMm4Qk5AFCSZa0qdZ0dIEcfBy8jR/6JKIC26mDln7mCV42domCSxGFf+ugOK+/NkfEDd+FV645F9nX0/+g9eImc5dve5RyLA15CDyHxizei8g8/oJuVx1JiOOoZ14MiZ6hpCniPKLokRuFO8UlscvfTq8s5wF7s2pitGEh3fDmXPACqcgZ49qNAVX+ovY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze/MX9W79ISbQRcvagT2kA5DQGb9rBzuW2I2narODYQ=;
 b=w5/jjUmqXXCrDs538XRPEHZEaJkYCHcdS9lzSf3JFxO3HV8NxEnccrDLnE+BnJa1PQEcBqetSK66/czLabtRzPMBXPTbe6mZilxyY7MbAuDyFSJPT7TSDCQfMFjw9K7NeVEhqv7CM42U+lXqdEdERW5tK9YS0XaWDXu+M7GnP4s=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:20:21 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:20:21 +0000
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
Subject: [PATCH v6 6/6] integrity: machine keyring CA configuration
Date:   Wed, 22 Mar 2023 12:16:34 -0400
Message-Id: <20230322161634.2233838-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230322161634.2233838-1-eric.snowberg@oracle.com>
References: <20230322161634.2233838-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SJ0PR10MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7bf59d-a60c-4527-c4ec-08db2af15521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxJvsYZd0bdpfl60AjzW0a3rqSDB+W8gKFGKW6oVMQiNzYWcJrcqDkY607fguhg2B1VjWP/aSec1O8JZGa5dx5tQlf2dKnb/xChjBdsERZdGz5lAIr4jIKnHjDUb+/p33N93ZJmbQ6mjbWcacQY7C7NrznJS7zefPkdD8rsuQFZwcmdeqYNVr+MJasWAewjUkP3jquwAiRhhFZdz4zZkgTOl0qtbQA9/Ht/Wd2koKXTlcFZmqG00lcXBxarIe5CJLxrPyMh6ncC4bg0SY8IF3ziUbf7TcR/7d5TAQHLxHpQiv1PTyxffv836vbVTyLWkqHeSXF6MFsA+JwICClt+dlvNJBrW/9OQwerFSqZXlxG9xwm9HpqeNzuKGIFDHpimjCAhZdfJCYwHmEvz785xTRwjBe6wbFSNDXsCX8XaXd7BO8ehd0lmBi9xMdw6mXJNanK2Dw/PngRlDjxUetIFnDvTeygrryiYLnW8Tkm+eIwpCLQTc5QeTaSdeWHk+PsN+6ur5fLkjVmnhDiu4UK87OZ/DgWTFbdY4GeklxPyCL12s1xSP3iJKKcJGyKB5j0MPaVBwf+Qmq9YHptFBYQEfx/zvb0ks/xVuWqN4+5qA7UDT8az8Z427HXZ9S/G6iUo8/dHx9prDSz+wpJ2rS91iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(83380400001)(36756003)(6486002)(38100700002)(478600001)(6666004)(2906002)(5660300002)(41300700001)(66946007)(316002)(8936002)(4326008)(66556008)(66476007)(7416002)(44832011)(2616005)(6512007)(86362001)(186003)(8676002)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRsNWx8Z/2qrOj1mxAQWhNow0D3B2rE2GLMDHH0PV+Z9xsAT1CxMCI7cqvD0?=
 =?us-ascii?Q?d73GjKxD/qvTAMrq1T2RQwVB/kvHmcobh3FSErXryFrZy03NTabeQxqaDkEv?=
 =?us-ascii?Q?jit7uaad2F/UpMdqaQV3Zj5967Fz7fZaUwXYl5qUMVAEFcg6gDB/0J3Ofg+e?=
 =?us-ascii?Q?1FY9T4agobIj6bCfaaA+I/BCW+QN+9jpPEvH/JYnTFDvTWFGPybTy04b2ZcW?=
 =?us-ascii?Q?cwRGRe53NSnWDw3YGZ33PovLt9afO+Df3eEJMb50icGA7DHOzX7H5YuTMEVJ?=
 =?us-ascii?Q?GAWEqVx3Hb9T2dVZqRfAjwpgGBuXygP4/2nNFX2AQ4nv80s5Tb0c1CRyoGMp?=
 =?us-ascii?Q?HzP6fJNeuCAs7ugf305P+EM2BgkCrcSYRYAVptaUlBtmX+JQkuL0aqZavVgm?=
 =?us-ascii?Q?tAjbmcIL7eAay9+ShA2FmzSr+47nT4FDhq9Pn4mrq2KKJ313l2392jKQyL9i?=
 =?us-ascii?Q?Evc7F5/A6WuVCl52fAmZEVjMpYObLrVEOTJGHW/bPCdBt+EENrb6x5acm7CQ?=
 =?us-ascii?Q?sPwrjdow+KHu2fEkRwXghKe+FAUvsX0hnUu4UZ7p3ZWbIBs/U3j3kenPpQ33?=
 =?us-ascii?Q?InYecUvQpdfCwehLhlkd+a7LDhjWmjMCeL4cdMYCxACDGV3Qq7mIh9qmtZce?=
 =?us-ascii?Q?ervBeUDO5tIpTdfwp05OAy2N5EeWGWjLmGIJm70XWoItkHidoH9GMRLPXgdF?=
 =?us-ascii?Q?TOM0E0OGiG9006x28aMqvcwsyuRQl/W856UERGrLd0/l+vgemd3QBEo6rr1n?=
 =?us-ascii?Q?JWZxZQC3rZa/NrH59vdo2QHFA7GCZTgp2KRdyVlvoWT2PBabiQ2sES74ZFco?=
 =?us-ascii?Q?pbM21oBNmnyhyHYAUt6Vm1KX5xHwY682uD/2+iTQfWOCr806FySdtl1kKSIS?=
 =?us-ascii?Q?RxegErODTZekafWHxziSvOIMATrkcILrnqQrJNiRiQdn8ET0t0oNvLOQaOv9?=
 =?us-ascii?Q?IK5JmpJ4E+wNwULDb78vNbqsvtIUb0DMS4IJycV3cm3SShBadvEuoA2MwnG4?=
 =?us-ascii?Q?33p5sehCd3UZXeEGkCBm8ALadrAZYBQYarReYTKLmJ8POvMpCUS/PdUh2PjQ?=
 =?us-ascii?Q?SxZhABzWTBr2CNESDeRkEizREg4O6apkifZIl3ilJ4vORrXzcxJw1JvT1y90?=
 =?us-ascii?Q?v4eDjw6ZhDXOWtjqPxGS8p3eYvjQ7Ea7SOF0yzSsgbF4dM0xIYgNxAFsSfUx?=
 =?us-ascii?Q?kjsssH8HC49aQ48NdgECBY4j4zvUUjJYafNFXvPkNxcP3RUWWpXSxqQjHnRl?=
 =?us-ascii?Q?mjZPovG7JYLI/a2Dx7LTRjEKCo4/3YXhmNTjQNQ0zV+nl1YHw472TvBIzbtV?=
 =?us-ascii?Q?zP6D+9dtHhBcUcLUx4eQPu3kTYLWO0VBLYTWariBH2h1zOVU30ikKnEdGT1n?=
 =?us-ascii?Q?JT7e4U4NsHKR2GEjQQI+0ieN28NfSOo0jiPeBzeg79Gu+wpnKI5OXLeeNmPB?=
 =?us-ascii?Q?Qb2pN3bkm6VdB0HvIJwUoyIlv4berrX2jpLE1OQO9SYMLDC5Uqcmlx9OlMo3?=
 =?us-ascii?Q?tl/bmQ6CvvbuA4U2QMv5QNneCh1zOb+JkAsZP0TR99bsKIPxykWtsEuAvYCl?=
 =?us-ascii?Q?TkfCru/3SHYfBuy8P28KdRc0Ggqmq/vxCLr2HVYE5411D5UALxSNBPoO3Y7M?=
 =?us-ascii?Q?CEKyGtnZtJIGq6nhhBBLi8Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CVvtOTbC1sg3Ty9tI5ul+BA8xfeFe//9chodU/9ToY0Jq7DS9R/vkAykXyPp?=
 =?us-ascii?Q?1Zacull0DRH8R6M3tfIWrAHoKF/OhUtGeQqJiRc5EPKsT7vRu6BYcqMjg0p+?=
 =?us-ascii?Q?JcSKMUfmRjhqOv7oQMJy6KLUScEEZIyqP7O7V+sKMhNs+GoPt6jlZ+qxWsAP?=
 =?us-ascii?Q?mC2eYEOZzz8Y0IopgXTImlu+LbtNEoGK/OQcWi1r3MGGZX6rh9BGIPzpDIRp?=
 =?us-ascii?Q?hLhk8z8W8euWxPMl7rbYLtqjMLr0KhwIdN/WagL3gkJ2g+1KhELOY9o47JFG?=
 =?us-ascii?Q?PWquPYQlxPdvdba2b8USk5GW+wxvu0NROsFTQtmspaEO40drZLNp5TJwxlFF?=
 =?us-ascii?Q?Uq+SWmpFUFoN3nSDyZRW2gYL64Sm3D6OQCD/OIdpERvB6ZxzRSpbyzUck1xZ?=
 =?us-ascii?Q?0XRxdBW1OAfgk7FK1iXpm7hrowxyyHFUY/NURixRj1xotXC5DcpDlpFDET2d?=
 =?us-ascii?Q?jjUoRov0MjrfhyhW1S/xteQ26gV3asQZ/4DpK7dOPCTwaMaRNWs6rbMEfyCc?=
 =?us-ascii?Q?l92cwIpSWElMmyIdbZGFoRMvUMl/vkD9jVvgXv8BJyh//4QwuSk292pYZ5Us?=
 =?us-ascii?Q?e9dfTsKfdz2yeeMsIU6FRhJGzTeQy6AO9P4IhauIioniLsb/MFzaY8MWuQaR?=
 =?us-ascii?Q?+DS0rWIX8pwlaZlPlUwVR9neLXZHn/a2NfVBKO78EE+jftMyHAebZzu8xvhp?=
 =?us-ascii?Q?UnfQtbqie0zOGT9zEfB87bTKZQTDxX1Ljui63o0pekGuGN4GAgWpHb8xdrk7?=
 =?us-ascii?Q?rk4y5/P2ZmoYzXAauxaXLYBplPTnDWggGo3kmlJL1UjwopVRSGGQkhEhYQlu?=
 =?us-ascii?Q?1+FptrFz6iPVb0Y9hexjgYwdOQZcSnztOizpR45Mfzgc03vN8aBA4RaR9GlU?=
 =?us-ascii?Q?SJNcQC99EAF80nm400B2wJdl168Tr4QyfFIQQg3qYZedHXoEiWeoAx4Vt0Sx?=
 =?us-ascii?Q?IRwpntlWnWM3SIIJk+IMPTcXj8EplA5UNVOhTek2mA8SqT43kao3RUG437vD?=
 =?us-ascii?Q?vpPL3Rvs9/8hCezGBcQmLvhcu7qPGl/QtxaKjS3yVII+aqlTlmpQqquza5w6?=
 =?us-ascii?Q?1Lnwgl5NwQBkHBp5mEcIY+Mi3CLD+/830wEjRAoaoAiZMJJtMyj7b5SLB6uX?=
 =?us-ascii?Q?rSGlL0ioxegYvwZfrvmpZQ/V7PaiHQXK06Kl1piiWI9e7zzvX9NLLj3Xi7sB?=
 =?us-ascii?Q?bHPrv/HAxniqMosA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7bf59d-a60c-4527-c4ec-08db2af15521
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:20:20.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQrWVNFTVWoP/qj7CMJ/uaAkU9EPIkRbIRmcZi6BcmeHkVNMw0mUmPtZgLqARwIY9k8djjBctoiIWfmYSX1eTQikX80X38yXy/ALspm9P3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220115
X-Proofpoint-GUID: HC2Wt4C18Msl4k9Krq3N3Bp_BHtTH7yD
X-Proofpoint-ORIG-GUID: HC2Wt4C18Msl4k9Krq3N3Bp_BHtTH7yD
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add machine keyring CA restriction options to control the type of
keys that may be added to it. The motivation is separation of
certificate signing from code signing keys. Subsquent work will
limit certificates being loaded into the IMA keyring to code
signing keys used for signature verification.

When no restrictions are selected, all Machine Owner Keys (MOK) are added
to the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING is
selected, the CA bit must be true.  Also the key usage must contain
keyCertSign, any other usage field may be set as well.

When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the CA bit must
be true. Also the key usage must contain keyCertSign and the
digitialSignature usage may not be set.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 crypto/asymmetric_keys/restrict.c |  3 +++
 security/integrity/Kconfig        | 23 ++++++++++++++++++++++-
 security/integrity/digsig.c       |  8 ++++++--
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index dd9ced32c8a1..d6cd1dc2bec8 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -144,6 +144,9 @@ int restrict_link_by_ca(struct key *dest_keyring,
 	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
 		return -ENOKEY;
 
+	if (!IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX))
+		return 0;
+
 	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
 		return -ENOKEY;
 
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 599429f99f99..ec6e0d789da1 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -68,13 +68,34 @@ config INTEGRITY_MACHINE_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
 	depends on SYSTEM_BLACKLIST_KEYRING
 	depends on LOAD_UEFI_KEYS
-	depends on !IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	help
 	 If set, provide a keyring to which Machine Owner Keys (MOK) may
 	 be added. This keyring shall contain just MOK keys.  Unlike keys
 	 in the platform keyring, keys contained in the .machine keyring will
 	 be trusted within the kernel.
 
+config INTEGRITY_CA_MACHINE_KEYRING
+	bool "Enforce Machine Keyring CA Restrictions"
+	depends on INTEGRITY_MACHINE_KEYRING
+	default n
+	help
+	  The .machine keyring can be configured to enforce CA restriction
+	  on any key added to it.  By default no restrictions are in place
+	  and all Machine Owner Keys (MOK) are added to the machine keyring.
+	  If enabled only CA keys are added to the machine keyring, all
+	  other MOK keys load into the platform keyring.
+
+config INTEGRITY_CA_MACHINE_KEYRING_MAX
+	bool "Only CA keys without DigitialSignature usage set"
+	depends on INTEGRITY_CA_MACHINE_KEYRING
+	default n
+	help
+	  When selected, only load CA keys are loaded into the machine
+	  keyring that contain the CA bit set along with the keyCertSign
+	  Usage field.  Keys containing the digitialSignature Usage field
+	  will not be loaded. The remaining MOK keys are loaded into the
+	  .platform keyring.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f2193c531f4a..6f31ffe23c48 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,7 +132,8 @@ int __init integrity_init_keyring(const unsigned int id)
 		| KEY_USR_READ | KEY_USR_SEARCH;
 
 	if (id == INTEGRITY_KEYRING_PLATFORM ||
-	    id == INTEGRITY_KEYRING_MACHINE) {
+	    (id == INTEGRITY_KEYRING_MACHINE &&
+	    !IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING))) {
 		restriction = NULL;
 		goto out;
 	}
@@ -144,7 +145,10 @@ int __init integrity_init_keyring(const unsigned int id)
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MACHINE)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
 
 	/*
 	 * MOK keys can only be added through a read-only runtime services
-- 
2.27.0


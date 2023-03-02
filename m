Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607136A874D
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCBQrq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 11:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCBQrg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 11:47:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A5F57D2B;
        Thu,  2 Mar 2023 08:47:29 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322FCifF006148;
        Thu, 2 Mar 2023 16:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HLaUN75QrwKILjjgmQMqceZ0QkdpkJ8Mw62vwbcq+mQ=;
 b=jy0sfO7lph/yWW83gIkYpS6UReky9JCascI0gdjvpOCgA93OdDI6pnl2iUFxXX7wxBA/
 1zhVxLAoZS7HctaUfp5poDB13ChU0eZT2C5baJuvcof7jBxeyzJZ54qcaC10exuFPZvM
 INPtweHiq2qwgEn9+55TwLpR6VuFedHmZBLv50Y/cCO4tELyF1zAUhbcPBOcFT7sJQNB
 x4ROIKy5b82GtPPlhTz7uLCZRe8iOKcbwZi4ibHYNT/n6lazn5ApMq4Lnd2RfI1AAZvx
 QEZcsbheSJ26qeDt8wbcrwt7jBVl6c02Wvy0sv7kQ7xSIHQnkRU/p6LSPKR4Ws8w0wMd Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9amd7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:47:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322FYCOk000609;
        Thu, 2 Mar 2023 16:47:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sa9snb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:47:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeGaCrz7d21Nf50S9Kbzv8b2Gn9NXgsA2OOdbLUd9pv5ADafEOvubgm56f1zRV86kLkMXgA2LfgUVI5lT41eevjfoYnfwtx5slao5/Ejoe3OIowso0GDf+BuX+gSzKeIfbkHODIVDq1hD6OgnVHkPeYH7BqVdXEIBWoZCqZ3XhyfwOD1xlRDNIQNLTl2U2a28Cbk4L7WnFojv/TftoQscrJGyPl/xb1FpEe7TE4HGGHVNNukyRUFINToePygo300vPtLnL9ArDa3eyd+9CaAOsIxdEYHizxs5PMBL8urGyrKtABjQEW1S8U3XP10pP8//LHCcDyIb3F2a7OWnGi3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLaUN75QrwKILjjgmQMqceZ0QkdpkJ8Mw62vwbcq+mQ=;
 b=f02KV+Qa1M/Y0yexDRt6ZD5lGwq5KEHAKdswWBc7wtfSHO1DDUA+fz63I7B2UFG4VGDXwSF+/PY7QHYRguntbVUxFboYA9abynziOPS6aQ6TavkzGUZ9GmkJTLAGSNZSQwE8qeqzteFypk+G7yusjlbaKIPH/PEbcBA/A66uU7GLbznowHveP7pGp+hhQ/1VXKCMAxIKslSh5FHiMQAGV1SycJ3/TY4mnq2Q4ybPsOa70i7vZ+Aop+iD7HQDyeQ//VzpFQnMriapAmligNolzvsd6z0IGudeQGX1PuoO87+Fp7LdsZpOs9FMmpLEMpJnFBZbQ1w56ABTQLuVE98z1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLaUN75QrwKILjjgmQMqceZ0QkdpkJ8Mw62vwbcq+mQ=;
 b=CE3HgjqhejQLiqLTdKYfy/Dx4octX2hofWZbkDAFQF0t7yH2GvgyW/asYOSoK6RAm/lT4yitGInR3gpe2d6iBBNLycEj0TKz6RSab2BicGG4etzfc2Wm2QCZxc9AGiGO3NxRGymJXQq+RuqiNl3js7ueiopu8jmzfMgXbx84kMM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5150.namprd10.prod.outlook.com (2603:10b6:5:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 16:47:03 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 16:47:03 +0000
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
Subject: [PATCH v5 5/6] KEYS: CA link restriction
Date:   Thu,  2 Mar 2023 11:46:51 -0500
Message-Id: <20230302164652.83571-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230302164652.83571-1-eric.snowberg@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:a03:117::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa2a518-ead7-4b4b-fa92-08db1b3dc021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQXLi9mWm70QPgQKGXFOzANODnGM0pdpnXEW9tCN41IrHLxsMMqkccOvA0ZcHy6zb8oeoWzBqam4KXmXg03X98M13tUBFtyazWLfdwdZSW3Ib2M51ldDbVsoHbNzKp8g0Nrb8did3w6hHghzhlsBzOlbD+xCeFCmBcdOXdLrcCj1RT9XavV1mgbjXWoaG3RJUBvD+6T/cG5QaJWg7gD1Hd9er5up4TyBPSIjMRYLVDlV8T2+hGzwFXhyH8iomsvelOWGXjYeYPN4NPin2pNvE+rWvvgDBixPVzX43XZB9WxWI0ptf6HqSEtQjAFgoZZNZAwP4EbBbPNRyk+LQ9JEkgqcH6DrTlzN+TxXIS+YZQGDHnzmInbSL4pr0y4TFu448wfG1+hLHdjGu4SZCquBDkJySJoeyxLTIP4UvmPmjXlWBOhAx7CApHeka6eVD26VHqAprFQqw8E85p8t4QBpOETVYUSk3u1B3tp3d/J0ino9KBdty77JL/R+IMaGOqueQyA/Meiqm9cETU/HvRBQsXGO65jGZB1unOjreRS67o/qHs8W9n1QLhG+YqOOTlI/pdQd5DZyuum3ad01S7spZAXKXSelQ6k90UUY3xXuRUCocbxRo8SBnYq5du+qlzegXHhS1umrZwII/w+GgnxTjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(36756003)(86362001)(8676002)(41300700001)(66556008)(66476007)(5660300002)(7416002)(8936002)(4326008)(2906002)(44832011)(38100700002)(6486002)(316002)(478600001)(6666004)(66946007)(6512007)(1076003)(6506007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yAq3/HGO1JJp9ESeS6rpKMN6ztdh3ECtdcWJLTKJgUBDfm3IFO2fMPTEPWvG?=
 =?us-ascii?Q?NpD1Nrlq+cd6GSNnzACuW0A+7gTeHOvbO0kau8PkbxRHMe81WoJApe+QY9kE?=
 =?us-ascii?Q?mes2L/ABEY7T2AjS7y0vHPOZBkegK0bEqws0mPKPDgfWTUoGaTIetBOcnK+P?=
 =?us-ascii?Q?o4BIerL6c5V6+ezLgiP1WTEVySfyiiM1ood6EQd5ZCnvYY9IYkhh/DpfXihq?=
 =?us-ascii?Q?vCClIMQ+U7/n8TO0ydrsH5JM/sV4h5msLqfCTQeEsM0zVIv5LVlDnEi3uZ14?=
 =?us-ascii?Q?8g+Ybv5BC/lIH8dPAGEI1kfAAmbptrA7TnMvTDxpQG6BrQTV3Wl+6k7/vpEh?=
 =?us-ascii?Q?4+j+P9Hi2IIMXdvMvXBgjtcm1lce/Hj8FFoS/cpIVi7fQpUTDsT2yOpeiqCL?=
 =?us-ascii?Q?6EkIX7p4AvJLql944qSr2diC7UpQNiEqMwZsVHIp8QwVSWAZYCTGWP5HZMJ6?=
 =?us-ascii?Q?mYHp8yxBkFCUwpLYJHwAvt+AhW9kokxRRDt2e9hknzQ1eQLzij7xZHxrP6lc?=
 =?us-ascii?Q?lSLHRv6Uth/VQovdVmg9BxO3RcHtLPHzcjs1p+MJpgMh2TZPT3Edj3hsbn5t?=
 =?us-ascii?Q?Q75HR9e9PsYWAEvmhQ1CsQcXFW4PZYjNQAVPg4v4cvg5vDZnhQqgqlfSakan?=
 =?us-ascii?Q?pbR5t8z9kuaDClJfe9WAxFEaHU33A3QurDtrBOTRyX9sxZsPas+NwkE3Ttdg?=
 =?us-ascii?Q?ez881BwfTNn4F+fgobpeA0PpiO9ZMSPmd3Fy/2O+lTzVW0Fmndd/sHxL7xvH?=
 =?us-ascii?Q?to4V2yqFPdlQkMLzNDLadL8PUOJfpO4i4ux8WMoBlCfTeyhhjsUDxAlY8qBe?=
 =?us-ascii?Q?KH2QwD6K6hk2YJYSaqsq6b+6oHpXoY3s6Uz0GLGX8IMUd8cTHgEXWmFN3R/1?=
 =?us-ascii?Q?WRlspe5kcDGNwljI4TcO7WxTyqmjhIt07z3mCU2MbjKNDyPLRuC/8tJYOBPI?=
 =?us-ascii?Q?/OfCGZkBcl24c18uJnY7W3/XjraUByz/l3nZ5KdiZ9Faijdeua+mR6+g9oXd?=
 =?us-ascii?Q?b6v/f31kLsZlvVtrKL4CJyxpSZx05hIX0t7X/lYzr0KznhsbIECQheI+/eNB?=
 =?us-ascii?Q?oLJYTuosO2NfTcQuqa+OpoXEDVtOxCSGdkEl7isOngvjVY+utsHYTSSYu5Ek?=
 =?us-ascii?Q?ViESDdrqg1P8WiV0hH8T0Tp8NWhOVRQS3kYKihTo19nwnS/iI9p0kW5zP6xS?=
 =?us-ascii?Q?OdVhXRMI/Qm/CxzciPXjgbEad8md48HYWXNE/HMDxSJ2mhNTBz81z+ojLkZK?=
 =?us-ascii?Q?tS5pwtbmsFprfwGt6R0azMbywvzxWv2ZTaJAVzWJ3NOTZVkbooNBph3xTJKw?=
 =?us-ascii?Q?dS9b9+TcG5xyrqrj+hlWu3MHsUhQFqPNVLbKJNyyLM0AsUp8DxewGlzOd+jd?=
 =?us-ascii?Q?9pgruUXiJR3RSUMeNUaETljC/blGrvsDJ+hTeMx327MTmFgIeaqbgySTjJe/?=
 =?us-ascii?Q?tnMBB3Get8o+SVILOqGM/jsZxfADQo7uFrimt7eVGBuxM/oWtwwmm0fT0j31?=
 =?us-ascii?Q?yVCJAI1IAl9w6tYSNVwWBLeoSaxu9xu32cMVEMPb7mRCO1lFH0IHc3MZsKE5?=
 =?us-ascii?Q?NdLU2oCvSeWA9oEln/ICGwqeBfgE9dCPkTOy7wUcYJz6xOCPgiman4mDHV3J?=
 =?us-ascii?Q?MDeOP3y3lKcBzl5qLo59rcY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sVtYYx793I2/3w+LgSvO9882ca/Bvopj0l4HwseS3kwhee2811dicneIizxH?=
 =?us-ascii?Q?pyuF0uex8vaUEJngMzCaT5UgUCCzk7Y610aff7SuvMPO4m2FjgIfejuuAh9q?=
 =?us-ascii?Q?PeBjDus/ZMBkSaW7NozPj56154KCjayf2xvPFMKVZfcdJgB4CFPtoIyle1UN?=
 =?us-ascii?Q?h2velM7ZHtwiDaCI1ViSalJ3/f+Z1WROHfwDzdxHwFg247EQY6AN4soz6Ygb?=
 =?us-ascii?Q?AA4iwaO/gOtpHqSab9yFGB2LE0ZrIOv7iugICTH/I/wvgQsdhXKenyAan9uf?=
 =?us-ascii?Q?/wBfbdIHKd03LYa0VaaCQeh3uyV4f2f3+PaDxrxpwNOdpxnqBiNaxCG8YpOa?=
 =?us-ascii?Q?tK+6E+witmyaHLG1QyqIYgvD9EI7F5wtwdrhhGVSFEoYgCBsSTmM+Oa9u0Oc?=
 =?us-ascii?Q?STDRd1+TPAlnKGpEJCY0AvqngY4w/aN7p//hrKrTF8WGYUwitZNLpV65mUQh?=
 =?us-ascii?Q?M40coBJKbWyqA+oVWla7MgVz1hYxT2q68eZajXmNAX8kTZjp0R0aZSLfpw3Q?=
 =?us-ascii?Q?RUCKyY9/i9VolrdCZrYXqdtyZaIhLTwNUYYxhI3d3QY2p/LxAnm/bXL7q+7E?=
 =?us-ascii?Q?nD1Bf0R3C/bWnTnVSsnyGcG52COqEKTZ0GdLspmYVlu1Tzl6aqGAcf7F5573?=
 =?us-ascii?Q?prg9MIIkV+5liqifsZ5fuOE74awRz9DK+I3SoMjBzeBDPW0NYCYYJhv31hcX?=
 =?us-ascii?Q?BY4jTpFGfJthP/WMuhOAFiVbUTfGsRogNc+notZ4I5GYHOL3BP9glkXvbRoj?=
 =?us-ascii?Q?6zEyRsoD5XPODNJkDkIHUe8XZIxIo4NDJE+ipZoSA2PnyFIu67Z6+Pw+VDc1?=
 =?us-ascii?Q?p7tBaDOVzDtfbcEHvqq743F6TqrlOADCkYkEorOQeveu2JH1R2OhvcMrXirX?=
 =?us-ascii?Q?XPwKUjclvjjLfdfXSGAm/KlgUU3ER1FRoWvcZTkP831BOtRgo5ZD9iZSlqZL?=
 =?us-ascii?Q?wC8mi8l82Au+L3zdwBUR8aq8ops5zC3f1LRpDssvMDdO1GgRVmBBX+mXzOXI?=
 =?us-ascii?Q?NVV2JKsuN6wPr/1aykvfZaOlvg2JnuEjL/+4cN5C085Mg0JSk7L4ROhXFl9l?=
 =?us-ascii?Q?JNAKuZZCI5NrOVxreRXNotJDMaWAB7HY5NZmibZfZhso64i96b784W39U/Cj?=
 =?us-ascii?Q?zGzfI1a9oqhU2WGHX0ud5ir3sJvOLFQWBBxdDGRVBBlH0Lxdm42VF2s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa2a518-ead7-4b4b-fa92-08db1b3dc021
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:47:03.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Dsk+FMlY7XIup5MU2tR/10tEJdwB1eVQ2BLbaS8EgXzo/IL7j8Cg6HHxErOzysfX96LAcrXUWSfRj0poduaXUU6LgWtXY2oKT4oMtGFQlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020146
X-Proofpoint-GUID: YOvRWeNHYcxanEhvwxptLIq5QTuFhvxw
X-Proofpoint-ORIG-GUID: YOvRWeNHYcxanEhvwxptLIq5QTuFhvxw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key to be added being a CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 crypto/asymmetric_keys/restrict.c | 38 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       | 15 ++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 6b1ac5f5896a..48457c6f33f9 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,44 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+/**
+ * restrict_link_by_ca - Restrict additions to a ring of CA keys
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trust_keyring: Unused.
+ *
+ * Check if the new certificate is a CA. If it is a CA, then mark the new
+ * certificate as being ok to link.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if the
+ * certificate is not a CA. -ENOPKG if the signature uses unsupported
+ * crypto, or some other error if there is a matching certificate but
+ * the signature check cannot be performed.
+ */
+int restrict_link_by_ca(struct key *dest_keyring,
+			const struct key_type *type,
+			const union key_payload *payload,
+			struct key *trust_keyring)
+{
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	pkey = payload->data[asym_crypto];
+	if (!pkey)
+		return -ENOPKG;
+	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
+		return -ENOKEY;
+	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
+		return -ENOKEY;
+	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
+		return -ENOKEY;
+
+	return 0;
+}
+
 static bool match_either_id(const struct asymmetric_key_id **pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 03c3fb990d59..653992a6e941 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -75,6 +75,21 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_KEY_TYPE)
+extern int restrict_link_by_ca(struct key *dest_keyring,
+			       const struct key_type *type,
+			       const union key_payload *payload,
+			       struct key *trust_keyring);
+#else
+static inline int restrict_link_by_ca(struct key *dest_keyring,
+				      const struct key_type *type,
+				      const union key_payload *payload,
+				      struct key *trust_keyring)
+{
+	return 0;
+}
+#endif
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
-- 
2.27.0


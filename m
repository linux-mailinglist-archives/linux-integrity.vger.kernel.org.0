Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4570CF8F
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 02:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjEVXOZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 19:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjEVXOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 19:14:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD2119;
        Mon, 22 May 2023 16:14:05 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOKc9021197;
        Mon, 22 May 2023 23:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=sMUBRzgJEu2PQTTBTZlkCLFb06qYGlfE3hU51Nsx7hI=;
 b=yXgdBiZZRbiJEc7NFQHBVtVjWprDyuoDf74GtiwqwYQAyRLkh/j8e6j2YxbvgAbXVoaR
 efsHTJf/5mJq6Ig9h+ZNMEee3deaAzrN5bbP84vFxXFwoF23iKp8oir2vXt6p/Soy76n
 n16fFgpzLAxLu8FTttHGH/4fV2GSOobYPHuVixH+rshQYYwpGzNSU2dwlVrHGi+LEcPA
 cHE315xQA45LPsO9fkPd7kFawS3EFATRJaFg9ifX1eAIfm3uHRmZHwCxuJ+uBgBoxByU
 IhUN3fTfT7gKDnqn4pBz+vP19/yRGYKEM6XerM1QNlF6irv3RdDIUAQDGJrSVMUJbQjd XQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bkuyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:13:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLcl2A027194;
        Mon, 22 May 2023 23:13:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2cu50f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIFr6lkMMja8WYxMqRdQLsTCPwEDzHDjqZDFS35oI9oUnN4E+ndpailIDZ/7bIDguu3cwr6oDXR+vJoyhyeLEzAJGaX+9RTnW/kckN8Tg0GrdxqAo7dfb2cOIJKZzzrFqrPdx+Qu5ysEdzd0uI1MjpuSjysGvYU80G5D/+6f9X7J7xvMAtoroQvkLnwpi3CySKR2cffX2MhZiG1A+AKfYFyjIAP01nA4JmmM0j8UbwNccFxJ2JbGpgAZZMBTgR3qLDfzBtsLZ5R7QjdiO8cSqHYiBGoKJl8JYhXvGH00ZuqZFLR3UxDKXlRyHT7hsX95/9wxI1Hs2kAuaSbtWnhI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMUBRzgJEu2PQTTBTZlkCLFb06qYGlfE3hU51Nsx7hI=;
 b=Wk8JYSmVVyX1M3BNXU4zewu8eAPxjNStruFL3xQRW3732YEPL5iCpfasNR4eFs+svc/MV85iNpiNUwZySRORtT13u7TjEYA7eIpzBDiIJ4vdLT7gY+7pA40dkAhchmM6uadqtS1h22+sNqRDiz/wOQAmfcNjhmteebmPPTJKOfyLVOaGVjw6vM5OXdcLWYDv5fPJ8UA4HZw1jr7PzULaPupoUg3J3vIVLlmIPZLhG8qxsc7gZmq9UbxVWcfytmF3uIHzeM+a5RzgasuOXFgJTN6OVvBjoVuX3BP+JwakXJPIYllwLWDCyXFR3FN9Buvu4hlEdOT2HzImFSajIXRDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMUBRzgJEu2PQTTBTZlkCLFb06qYGlfE3hU51Nsx7hI=;
 b=WBpNalYwFSxOFIacqO3z84/TXVRoHLoyYAc4ukI/NTsuH855VDBB6GdWHKlEhFDOWOgxlsGuXVuat0mUqTWnxrblquFDus1nM8/w1+j0A5qeTjTKXdHhG8yHUWz4oM+XV2o3OL0Regp7v+lXtHBlUSN/dFgI0vbLCs5UwzKvbT0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA3PR10MB7095.namprd10.prod.outlook.com (2603:10b6:806:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 23:13:10 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:13:10 +0000
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
Subject: [PATCH v2 0/3] Add digitalSignature enforcement keyring restrictions
Date:   Mon, 22 May 2023 19:09:41 -0400
Message-Id: <20230522230944.180389-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA3PR10MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 6368ce72-7292-4e86-5c6d-08db5b1a1bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82hyEA7IqmuYqDSwRP0DtXMxaTXC15yezVrezpn5Jg7zrkh8RLWLu7jTjN94F13g9zSO9haUcDapwo9iwMxQKacxG4qwvanCRvx/j1YII9IxF1VSV4MOBAUpj39t6HzuaD239NeB2W+gviS5VU3F2Eh1xOUDNhI3g9sEdAYEJhUC2GYSSPM6D4RL/M2NpuHV13/BDoRUY2XpGA/H4/tkr+MtmhhBs5pg1RaNUwjMg8RCUq7hb1J8PSmKslNkRDwr8xYeQc38QgMKzTXPLsrCuS4PLeMhYOtXT3TLURe7GEcX4mosK9sI+LedeES7KOOVz/5WLY5BQ7ns4F1Gh0IUSEBULeg7tkCOQ2SmFBkUdcUv84f1x3XokJohUIADUgMvJCYZX+tqI7+n4LulZoBcqmyYtXhpcY4S97Y3D9X7oFIENNAv7kVtuaGr7iv46ZAnXW2UHND+2m5F93RVk0P4/UuNdqvP+S55Y7+LqNTIN81+izgl4P/v6bd3eePj1Adz5V+kC/W8g0qEC4/LhfJt8qL4GvCmTJC7KmcyL0u5zcRp25XtJ1uok3evwKrNe5XRHfzDXEsfVwxj+W15Rg1W6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(2906002)(7416002)(5660300002)(83380400001)(44832011)(8676002)(8936002)(36756003)(66946007)(66556008)(6486002)(966005)(66476007)(4326008)(316002)(41300700001)(478600001)(6666004)(86362001)(2616005)(1076003)(6512007)(186003)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYJ8s2jK7DDhJ6IWslHeO+Mmg4A54iV4VjjqdiCztV7PP0up3k0PDXIc70dp?=
 =?us-ascii?Q?xILiIqFbTscDPI20tORdKRKRZ07v6XLlZ77cs5ZZb/MpzsqDDrTBppn+jJwZ?=
 =?us-ascii?Q?NhZb/e7JlUnxD2Qw1RWi19BzBN1erPR6APmbEx5OS138ZVSkM6NmgbKMe72N?=
 =?us-ascii?Q?opky1iDfml5VF7JcVtwERPBDcaCyWmmggaDI4xVwsQc9KDuKJM2+3m2KruuH?=
 =?us-ascii?Q?Up4etE3Uugvn6cvyqE6giCU9HPs7yPzJVUh5Zt0gNlBPBvn3G8Z4PxPZoD80?=
 =?us-ascii?Q?BqfZrSf02/JQbIZzOp5EDKyuXl1XGhDGkHYN0ULrFuIp3E8cEmOVI6zzEwO2?=
 =?us-ascii?Q?l+KO5mQenyeoEDbEEKWFZ6MlzrRejvBorq9uGSKFlZAHYT2iqkHbMQpKD4sN?=
 =?us-ascii?Q?/6xf1g22Wp8CE+UbURyXH2xnyjtECax+mosY9F1qfPGJTUQGQJM5SvRR/Vvu?=
 =?us-ascii?Q?V6IBV9c7wf4ZzD/yVMD+KhUJUma8C0I0GX4IrQUmCL7LMPJdoSMSm2W/7LBH?=
 =?us-ascii?Q?UJGuGCYZhpdQJ7hWMoZdFMe9BG2pNu6pSJF0ha4/OUASnSmwKUooQTdpkWYB?=
 =?us-ascii?Q?Xxn2RV6kgrLqg7hyUSfJzmGyGL0FOPYRGRal3j7pAPQ36TTeFJNiS443RPbd?=
 =?us-ascii?Q?Y6sZQxpUUiXUYJefQ+f6Cl0LYuTyafflZozLlxCXvWluFXQUZrPW3dwQua5O?=
 =?us-ascii?Q?aUdXP79nLAefB0/TA53G5Sm8Fz8wqo7j7qshyJcgL1TiRVtxLe3ehZHC2J2e?=
 =?us-ascii?Q?mqutSH4ZJ7Le6Hcc/JSicAhfnuy2P6/zv+Ski7K8WCAan5K3Sy1qMCaShQy5?=
 =?us-ascii?Q?ezD8ZGGTQS9yvmUAMkxxjzN+eVe0SNt091/Pak6U+0kFt67q9bcqPG6HtrRX?=
 =?us-ascii?Q?hzHJfq+6sJRPy/jrDG6jxkcf4bcwuWLyLR9qgf6asyEI7+FxB8+Dpx9+jiVt?=
 =?us-ascii?Q?16fcT6b7CNMzPk2ovlH6WE7OY7CJu28b7o+fKo3DiWIQqI4Lshk1DtJ7vYGb?=
 =?us-ascii?Q?wlj7kNW9YveIwBZdJHe//WIGirbyzH2oEplAFYk4R+hsWHamY1bYDmWWdTCy?=
 =?us-ascii?Q?Mnknu2LbW+AKP7RKf2x3UAEftLqX5iaQpPrMsBtVkVIarQM0uNcUgBjPUFgX?=
 =?us-ascii?Q?74sc4K/dryUGvvVEq8oee4DcwuU7KHuqXYN48lpexB/TNgaRkEobXsRcVDmH?=
 =?us-ascii?Q?iqOD5PhIdzRaoSfGjvYKoSqJ9xREvpa9KJqvNRv0/Nxom2no/p6dfxpgWeT5?=
 =?us-ascii?Q?y37ARNum9kT72F/WK+Gl61N87Q+FjUtb5m6eY8tcF8hNfY5NETsEVI4sYpEd?=
 =?us-ascii?Q?+PTtthQXI/cK0FoybJMzNjUEJQina1wN04aaauENLzCONactvTbJdFARieUp?=
 =?us-ascii?Q?cseyz8KMupW8XdifeuDA3p6rugMRtkDbo/EnBAKRp6HMH4EMdj4o2iWH0bX+?=
 =?us-ascii?Q?08sEi2P/Hm0RA37C9/N1EuGNZ/XEX0r2hb2BCxY5wbLK5Mg/s7EftswWKwnU?=
 =?us-ascii?Q?uQWfsCSFr5oiUDVGdJytiqYRxtc5VxxJNeCb0RlNsRzOVxEbCQT3SbKKy253?=
 =?us-ascii?Q?KrbR0XEKh5Fgc9PS1ffUJMI3FCg05LmJJ0oX+LHFRrklekOBIDcT88vD+OKa?=
 =?us-ascii?Q?w9oM3Whrdl00Ds43OzUFM00=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LtPT2RX0PgQk44N30Ci/uvKaPkGfLaeAiMz9Ii9pDqJdp4hxrpzYDM5c3qiG?=
 =?us-ascii?Q?qPyKlRvMMNZ0yTRuLS1KJGc3TPiEzPcTbznf8R0VWwEEwpuRana+H52uiLHd?=
 =?us-ascii?Q?ToAwMULNnh/KzeWau8UQpfeQcICrJWZbT/ah5dzvtjzR+E+KXJzpM65rG68e?=
 =?us-ascii?Q?Cl3fjd0n34MIxClblUAE3GJJE0g1ttdCGh4nSbBv9OOjJntVGFAR1lDIF0Cd?=
 =?us-ascii?Q?f+9f1WtANlJyK/xKVoYqbtSvWjUq8swFvoc8tGgMGVu9UOpCgifGmgx0ZXNC?=
 =?us-ascii?Q?nFDN0NcsHXsmf2q+DvWhc9GXpbc1XvzOiu+QjkuBQt3AdSUB8hNeeaQdWhj+?=
 =?us-ascii?Q?thaZK1P915tBMN4cqFvM6yynSwzWMX8hVY3qQPnQBNqAT3yr+Rg8y0UAOlpc?=
 =?us-ascii?Q?Swtec5eZW426deCnNDkIi2VtFDtNfwNZBn/s09K7bKTnhmGCfViDJAKoavW9?=
 =?us-ascii?Q?xZq9vuxFEuNLLhcXQHmEyJb/hNJzkjKXS45aiCKnl13CSlwTW8u/As+RFjzH?=
 =?us-ascii?Q?GDB0h4s6UpW50Tq/mUYYlkQhixs7wQ6TSskD+eUibJBtNs6DhZHdV+SmBhlb?=
 =?us-ascii?Q?OmES8WiDBoXtvHEVMGMidXbeubjuLrt67kZF3+ZEkPXI/x3MZGIGgp+Wv3yA?=
 =?us-ascii?Q?t5JVG1iP3ncT9qaqRDDpmWUMeJO5JZPTXFtmyoT/vn0wIIU1eG89a8E+Ojj4?=
 =?us-ascii?Q?YkRZ7vKBz134f4LD9ahF8G5JLv+prnb4+EjaE7pkFrLAgBkvXhpzRFiaNE7z?=
 =?us-ascii?Q?jJc8WpP5bL6Vo8UnUPTtpHAWkPypmJMI9AeW6LyWpC6CWaMitDkTYPoZ69Zu?=
 =?us-ascii?Q?v/GSH8InWlC384hxIh7aE6XNKKw726WOrSCIEzyTQLeBa5x3pSSVmuiV+TRe?=
 =?us-ascii?Q?5BAiPGwq6rCxbx416CAYzGUskIfX1UAlSYWXNtM2M6Qcoot4R5km4nWKHj5N?=
 =?us-ascii?Q?8hGYQk1/RSGgw+pTRQCtKAJ78CDqAhS+B9ZRJkfXMSeDjDITmSwc+yjZn1H7?=
 =?us-ascii?Q?Vn/7S2cGPd4RnzCTw5PA9VjoYVbS6uaC/lIVH1e3OzP7zrsYsT9HUzqbeIeF?=
 =?us-ascii?Q?awWrwlwrGz4C7K3gUdbqxgqZL10dwCshRiUlREZkgZK0E9YwMYu6NNvcM42A?=
 =?us-ascii?Q?KHjBN96GglPR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6368ce72-7292-4e86-5c6d-08db5b1a1bef
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:13:10.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mbfpw1upFvsdo7jJsyX4mvVL3vR+9JBW7HmCFnjsl/PsiMoUsvye6cyJQdrAwfk8q/YiwlAZi3oqhvfpbD3psDDk9u7vvgyxsDUQzdo6KcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=873 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220197
X-Proofpoint-GUID: kp_RCNIL6B5JCmqhI5p_fpUSyVfmp1cL
X-Proofpoint-ORIG-GUID: kp_RCNIL6B5JCmqhI5p_fpUSyVfmp1cL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

X.509 certificates may contain a key usage extension [1]. The key usage
extension defines the purpose of the certificate. One area of
interest is the digitalSignature. The digitalSignature usage is
typically used for code signing (integrity). 

Within the "Add CA enforcement key restrictions" [2] series, the
digitalSignature is being saved.  This series builds upon the previous
one and adds restrictions based on the digitalSignature usage.  

A new keyring restriction called restrict_link_by_digsig is added. The new
restriction only allows keys that contain digitalSignature usage within
it.

With this update, keys can be filtered based on digitalSignature. The
first two keyrings to use this restriction are the .ima and .evm
keyrings. Only keys containing a digitalSignature shall be allowed into
either keyring.

1. https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.3
2. https://lore.kernel.org/all/20230329220231.h6afgarrvdlwwdjc@kernel.org/T/

Changelog:
v2:
- No new code changes
- Added Reviewed-by and ACKs
- Updated code comments requested by Jarkko

Eric Snowberg (3):
  KEYS: DigitalSignature link restriction
  integrity: Enforce digitalSignature usage in the ima and evm keyrings
  integrity: Remove EXPERIMENTAL from Kconfig

 certs/system_keyring.c            | 50 +++++++++++++++++++++++++++++++
 crypto/asymmetric_keys/restrict.c | 44 +++++++++++++++++++++++++++
 include/crypto/public_key.h       | 11 +++++++
 include/keys/system_keyring.h     | 11 +++++++
 security/integrity/digsig.c       |  4 +--
 security/integrity/evm/Kconfig    |  3 +-
 security/integrity/ima/Kconfig    |  5 ++--
 7 files changed, 123 insertions(+), 5 deletions(-)


base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
-- 
2.27.0


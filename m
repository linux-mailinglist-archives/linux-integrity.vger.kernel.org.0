Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE970CE9F
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 01:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjEVXOa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjEVXOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 19:14:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1A811A;
        Mon, 22 May 2023 16:14:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNwqY002004;
        Mon, 22 May 2023 23:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=TH9369WrGBsKHA1xuk7oR7VDwBHzQuArMsVOPOgT0VY=;
 b=1CR8wCvMptlNk3mT1RzEBDN8JJabTNwusg+Q1dpKrC9o63qpCsioYQa8GH17FEI3Eem+
 6W6UQueVDm7A49MNOuRw2noK/VoI6Qzq2pRdIwgaSrbaVoULeAlughhaySllT3fxt3oA
 ZWmPtf6Z63+X3ONuus9vQjQBcOfU521No/LkPqP3MBgg2zkNh0tUBC/+aDN6QEpr09Ly
 6y24TG5HASG3GgBZEaGqW/dKTNon+YJHFCj1X5stut9WmOVC1AtUYWPO7lLgUhbmPq0V
 1w+9kMN/SqUtz/ESscTfUValMYenUQnZ97tUGGSoWYA1R4YB0BNGKjBz3joVYYwLtilf MA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44kth2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:13:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLcl2B027194;
        Mon, 22 May 2023 23:13:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2cu50f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Guka8PuwU0f6FW9vLN9A9aN8TZtkd25M6WE5ZphXox+yMw6GL33RGGknTWM/qTSAvbRTUpu5+eGRGm/ZDTuesfS1dN6QQ5+WLUT5zmLlWf/TzARZuuqgb4CSp0D2bF1K6p01E/UxAy3FwojMH7/3bWdNrMKf8s9hzXtiG/FSfboS47D8xkhFMduRhksIwCLaBQ0rrFN4r3UrgS02mPpnvpqs12sf1+dpDOf1aP48aABcauamaNx9dzFjbJtn5qPbnUA33ztOqUUpbWHOyegl14Ft18KusMrpxSmVXEVol+xgiiTpdqogvWdBo9TWpMkU0SIcwD6kCbwlXfIjOJEvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TH9369WrGBsKHA1xuk7oR7VDwBHzQuArMsVOPOgT0VY=;
 b=SObE/0S8rmbIHWFmqrXRoMn4uEv+yN4zL6GLnXXeKtFqiB/P1rEzGlHNBJ98L4c6LnhmoimiVt9Z8J5XEK5Qc+pfqyTbppQ1PIxdTAUtbygwdAonyLR3R6YM8zDbcUdlpg4i0l/RLase5MqcQNwuSbl0pXJFIS138LPjvifhkOBkTnVV7yJqcizAZhNamqJgwvJ8X4QND8vDMWxdeT7nDVidjbLBskpVrGGpG/mVLG/E1BoR8W8ummRvNEfyRRrkrn3eNMKLqIgEdzsftv1g2T2OXrVYY6TX2NfkLhwnsmWhMssEW0Kzkslu8QfVsbL69jnHq6LaatorNjpqnwFd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH9369WrGBsKHA1xuk7oR7VDwBHzQuArMsVOPOgT0VY=;
 b=vpoiXN/iP5mIV+Ba3uhuOdHO0nULg4G5fi8qLQVkKN2IXsgCy5acabmWdeFEhZnGhSoLdziAeyMxFKvPHSU77GT4qjS/l3XKorw3gWapBnQxPM4xXnBXAxbWOuOPJ9lx8ljsh/26k3UkIPi8kFrZFZ64iZt4yuwC2gfmnsKTbSU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA3PR10MB7095.namprd10.prod.outlook.com (2603:10b6:806:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 23:13:12 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:13:12 +0000
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
Subject: [PATCH v2 1/3] KEYS: DigitalSignature link restriction
Date:   Mon, 22 May 2023 19:09:42 -0400
Message-Id: <20230522230944.180389-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230522230944.180389-1-eric.snowberg@oracle.com>
References: <20230522230944.180389-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0095.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::36) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA3PR10MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e480c6-4fe3-442d-c4a7-08db5b1a1d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6m1Rys4l5Ye3zsodcGtuuNP8YGsSLrgOCGx4nfD4aZvEBFAQCs1toe/syMwEAXx4neQzRWEAAl0F5ZI53t4NY9mI4+BCZNGyLMBhBUQTwqcFV0owPiOidKyW3UbdZd/90taMfB0yLgRPv6nxiHf4ZOWnQ22xjid/aVoJ81oGYx5FwcPzKDvGbZhvnLBHaAP1hGpdZfH8oa4sMEsLAn1jKO7aN1dIhSlzEy29odwbCG8Jg3MF1QTcKrP0RANjWbUKmrZYxXxhceQhk+B0NJdtt+1eMbncHhKPDNqIOMbeZvISgmy30fdfQ3xUS2DNUETvZuUPvNmpPowISUkYzi+XhPeV8YQw7q8+gc+hwaU4GhnUrTOqDsr5+rIv0zsIeeWErLPx/oJJPmJeXTJSk4MIYP1RJGE1IZClrPnJ3uZt+yEkaqg7ysP+5tL0dk/+eZgV4Yf8baxfI89CmQzzX8vnWOEYXsaMxrr0eUDVqMFCY00zdAk1dxKDHcEq43sGcjXihUAo6cRc4wmZal0Ztu31k3ZtGixLfex2yz+wmvcvaZnIq+1tzDaEU7HQdRn3OwM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(2906002)(7416002)(5660300002)(83380400001)(44832011)(8676002)(8936002)(36756003)(66946007)(66556008)(6486002)(66476007)(4326008)(316002)(41300700001)(478600001)(6666004)(86362001)(2616005)(1076003)(6512007)(186003)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U8vW0IfXOVkxJsi4VLOg4Siv+WoxokjDmvN31xEPOBBuxze1+1ZgNYF0ihTT?=
 =?us-ascii?Q?54VgYEPGkShVUQYsstxy//bw+vs4QSed9WCrD0fhOG4SCgpJdKrgnqOdh9RJ?=
 =?us-ascii?Q?x0KVDv+1NdE4TZbw1M99o3UI+MNvzjyS0AXBP++fQs9LUo/L3mQwKW7l8BfN?=
 =?us-ascii?Q?/2h1UCGGz02DWT2Hnurrpn32+oJRtPKqWasIvmuqjxyqYQzuGqSXosm7bF7e?=
 =?us-ascii?Q?wQ+8ektb/r9dgzpG3stK8BNbe1CiPSNG8YR3ElNGP+nE43bROXccwzDR4+Ld?=
 =?us-ascii?Q?4FUOl7v1pvwejr9Hq+O6bj11SPC03HQHwzLdIeiMfGr0GDDuzctVtKGJGjkl?=
 =?us-ascii?Q?4O42RCM4gMW9ykQ/6bCnysM6YPke1ybgfWjQ7/04aKEDUgb2vLO1Hlc5PbVA?=
 =?us-ascii?Q?+oMqo6EgcNQLbvOQqBpiCUAbX4UHzHPVnJoEoVZjpUJgKAkE8O//T9LXPOrl?=
 =?us-ascii?Q?lfN9NnrnfUrVfRCep4HvqQ0OfGH50W1nwJ1DGuHna8j544oJzQOzm4+AUWKZ?=
 =?us-ascii?Q?cpgPOYrTPWooMpysPULIRic4dX+Ul3VDRHPgszRhRc4IzRSmlAU3t7G+A4zT?=
 =?us-ascii?Q?W7m7ZNhDg2VMTYiI8DtmiwmA6bKYHv+lwu0lI5H0mbsEcVOj+4BixHJOFtyf?=
 =?us-ascii?Q?Inq4l7FeWMm9SOybyplDQhrXu65x2fGBfytkRp2LhlIFTLuOZEgGa2YlXoWw?=
 =?us-ascii?Q?iL44z/yfusgiNRy/MfzZKmiSxc0WA7rfk9GTrBoaUaoseiYLhzAtkqJwYJ1y?=
 =?us-ascii?Q?25SS9H3MZ4t1Db+q6oX0XBHUJZfHLO02HW7vLLPgt36Vw7f1vUqPSOC8+RE8?=
 =?us-ascii?Q?6r4zXnkuzO4qCiEnjT89dfjd6JIdTp9j0txOFY42rOZwqCuUIzoZfMWkdmka?=
 =?us-ascii?Q?gRdc1unH1kpYCSf46KuRHVbT59SaPK3joJp9mTQoYBKHmv4bIPotpdisIilg?=
 =?us-ascii?Q?BXHOb7GmJzr00Y18J9B0lsY9yH23U1ODSCcGgCCayMVsI4URNpv7AZVxsOL2?=
 =?us-ascii?Q?N341CVlSe78YZJjEMCo3AgBnx2zxyckrCe9QR7+efV50PlQ1n6t00tvAODgO?=
 =?us-ascii?Q?hUHNlcBXzboq55hS7+Mbvd5R2fd+i9y8YkEXLWDWovRSSET55Qll1DnQjOG4?=
 =?us-ascii?Q?U/yge5rzGOPLy/LDFlqYMs3/ejtFGSwdTJm4k0Ilgtmw4XQfPFh8zTOEJ5Ik?=
 =?us-ascii?Q?SxV10MmpcOqQh2tK9e8o4cdPg4BU6rx83C0W3qGEC8vNe0jHsiS2MYeL7j0U?=
 =?us-ascii?Q?pvgXpOUdpqL96yOdandjk1NEVFGAshH3sBUGElmpETRX7Vw1lTICw2OirzBo?=
 =?us-ascii?Q?RkXzK2VZFYZoOF/P9mB/Z0jRoqSP24e6A2swot9iykFpeWVxfsqfqfYWIjkU?=
 =?us-ascii?Q?DNbP5qG4vYlduEIm/65gD27FT6rOCDPI8Ani2Ld84ek4yATTwohpfu2BuXl9?=
 =?us-ascii?Q?PmvytonpoormTDQ3cGMKTeuY9TljxyBlINYzXKTUn/n2of5EtkgQ/sreeGSu?=
 =?us-ascii?Q?VvbTdZX4mkwuPhXSlScb0ggOoSjKteH6usUOjlwY1tDbM2Zf29JeuKTVTV/V?=
 =?us-ascii?Q?PPYpY+Jto089jnB0Ytyrz5bQ83mD5YFEUm1pAozR0+ZtiW4iYtbSVHpi39Te?=
 =?us-ascii?Q?ME7ZKsKFOEBSm9UiZmBaofQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?V5Dtq4xP2Q+VwK7sR1jDNLETT5ykiYWTUOK41AM4dhCUL63vFYJRfgGQQqFg?=
 =?us-ascii?Q?fYI3sieRmK4xrqKcu1BAejRp2o64Wr/j5yFNR9RB5JI7vhIEB962VcmaTrNM?=
 =?us-ascii?Q?r1dglLRGhLSFEHxevS4cxU0w+EBOn/os/RAc+IDKvuJ47m4eq//WEo2H2zAj?=
 =?us-ascii?Q?s80VMc2pnxgODJg1xk0/ijVspvBeDXi/qaNEUhs9tEf/xr+XNb0KfxWDdLcq?=
 =?us-ascii?Q?7Fi/Ol8CLjJxQoD9WAACOo6BKQQIPJe+q3Rp/o34cv7XrL/88t/Ucyb2M+A6?=
 =?us-ascii?Q?Sv2KWmzJwT/0p8OzMOYK4ZqtvJFSUEjnHnstOZ36390zAgdhU1ZBEfPyF3xd?=
 =?us-ascii?Q?aElDwuAPeNEfC5QfdDLOexfNmqdg9Nf2Ppxpu0p/OgmxDSmfJsA2CwjK/VxN?=
 =?us-ascii?Q?28PUFhOremb49OcvZQiW9QtQhsY0VzaShAbZQWFaC4Xv8veI5JYjXKtiBFp6?=
 =?us-ascii?Q?1GpaORem9dA0TxenRurb7ZJ9YjbPziDYtyWq4361RF15IlYTxSsB5kO0J4cg?=
 =?us-ascii?Q?YKfBDb8WTB9pLuwNHu9FNB3J3H/YY0k1L4RfIh+7tXrvMWnmeSEQMBENvCKo?=
 =?us-ascii?Q?btSkb1uf72LT2BBVmUKSbEfDGgX+7Ei1FtFqM8rMDwAUzr7kaZv1MqUPUL4Q?=
 =?us-ascii?Q?f4/F09r43X1CeMGdDVq4bkV/0GWc1ZFRjiZNwMZ7znM9NWcl5uwOU42Rc/WX?=
 =?us-ascii?Q?pmq2qovZnOAHE9nIk8ytbT2aKwc63mhSjC3t9JIsFevbCoeQzYbfozi3V58T?=
 =?us-ascii?Q?ihG0JJRs3WC8knGx4wypR7fy4HyiwOEA4Bu+QPsOWW0g44OFSmMFRHKaCt3t?=
 =?us-ascii?Q?D4pfyP53NwvgmdzOOzFBQlXhAdq8ISiKi4Llzbv7PUDkrALIaGYWlkT3w9i+?=
 =?us-ascii?Q?2OAxkidPliZLapmRs1f29XuuXE6HY+RR4Stbq5jeEvf9QlkPMpQr8vLLKO9R?=
 =?us-ascii?Q?/lwMW2r4+O/cqPsgdtvxpUgjtHpVZFJ4Nl4pjdtdo5NAN0Mcp1EXI1FFqp7c?=
 =?us-ascii?Q?BGrMxCTuOFpmjQwdvki5ZApPX0XHk9nnLUVY5LNQyWgci6/YJL0ppLJRzzJm?=
 =?us-ascii?Q?ULfs3Z1YNdQt0+TOjQ/LviyflXI3bb3d+vUDz5eBsbsvuVSObnenANf80aE+?=
 =?us-ascii?Q?WacT7KmUSkED?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e480c6-4fe3-442d-c4a7-08db5b1a1d4d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:13:12.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alN1vVKrAl/h3erW8cNkkaytFPBoXc/ZS79jhUorsnZ1f3ekE6LyzRf5y9hWc2A+oJNXURPvAYImqfCprKMRQly7rXcYpEStA2zaTxT0OPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220197
X-Proofpoint-GUID: 0PfpiO6traYU_rSl9hXMBnW2UkANX9R4
X-Proofpoint-ORIG-GUID: 0PfpiO6traYU_rSl9hXMBnW2UkANX9R4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key having digitalSignature usage set. Additionally, verify
the new certificate against the ones in the system keyrings.  Add two
additional functions to use the new restriction within either the builtin
or secondary keyrings.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 certs/system_keyring.c            | 50 +++++++++++++++++++++++++++++++
 crypto/asymmetric_keys/restrict.c | 44 +++++++++++++++++++++++++++
 include/crypto/public_key.h       | 11 +++++++
 include/keys/system_keyring.h     | 11 +++++++
 4 files changed, 116 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index a7a49b17ceb1..f059b53d2102 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -51,6 +51,26 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 					  builtin_trusted_keys);
 }
 
+/**
+ * restrict_link_by_digsig_builtin - Restrict digitalSignature key additions by the built-in keyring
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restriction_key: A ring of keys that can be used to vouch for the new cert.
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in the built in system keyring. The new key
+ * must have the digitalSignature usage field set.
+ */
+int restrict_link_by_digsig_builtin(struct key *dest_keyring,
+				    const struct key_type *type,
+				    const union key_payload *payload,
+				    struct key *restriction_key)
+{
+	return restrict_link_by_digsig(dest_keyring, type, payload,
+				       builtin_trusted_keys);
+}
+
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 /**
  * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
@@ -83,6 +103,36 @@ int restrict_link_by_builtin_and_secondary_trusted(
 					  secondary_trusted_keys);
 }
 
+/**
+ * restrict_link_by_digsig_builtin_and_secondary - Restrict by digitalSignature.
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restrict_key: A ring of keys that can be used to vouch for the new cert.
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in either the built-in or the secondary system
+ * keyrings. The new key must have the digitalSignature usage field set.
+ */
+int restrict_link_by_digsig_builtin_and_secondary(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	/* If we have a secondary trusted keyring, then that contains a link
+	 * through to the builtin keyring and the search will follow that link.
+	 */
+	if (type == &key_type_keyring &&
+	    dest_keyring == secondary_trusted_keys &&
+	    payload == &builtin_trusted_keys->payload)
+		/* Allow the builtin keyring to be added to the secondary */
+		return 0;
+
+	return restrict_link_by_digsig(dest_keyring, type, payload,
+				       secondary_trusted_keys);
+}
+
 /*
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 276bdb627498..6b69ea40da23 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -148,6 +148,50 @@ int restrict_link_by_ca(struct key *dest_keyring,
 	return 0;
 }
 
+/**
+ * restrict_link_by_digsig - Restrict additions to a ring of digsig keys
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trust_keyring: A ring of keys that can be used to vouch for the new cert.
+ *
+ * Check if the new certificate has digitalSignature usage set. If it is,
+ * then mark the new certificate as being ok to link. Afterwards verify
+ * the new certificate against the ones in the trust_keyring.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if the
+ * certificate is not a digsig. -ENOPKG if the signature uses unsupported
+ * crypto, or some other error if there is a matching certificate but
+ * the signature check cannot be performed.
+ */
+int restrict_link_by_digsig(struct key *dest_keyring,
+			    const struct key_type *type,
+			    const union key_payload *payload,
+			    struct key *trust_keyring)
+{
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	pkey = payload->data[asym_crypto];
+
+	if (!pkey)
+		return -ENOPKG;
+
+	if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
+		return -ENOKEY;
+
+	if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
+		return -ENOKEY;
+
+	if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
+		return -ENOKEY;
+
+	return restrict_link_by_signature(dest_keyring, type, payload,
+					  trust_keyring);
+}
+
 static bool match_either_id(const struct asymmetric_key_id **pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 653992a6e941..8eb5eff059f3 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,6 +80,10 @@ extern int restrict_link_by_ca(struct key *dest_keyring,
 			       const struct key_type *type,
 			       const union key_payload *payload,
 			       struct key *trust_keyring);
+int restrict_link_by_digsig(struct key *dest_keyring,
+			    const struct key_type *type,
+			    const union key_payload *payload,
+			    struct key *trust_keyring);
 #else
 static inline int restrict_link_by_ca(struct key *dest_keyring,
 				      const struct key_type *type,
@@ -88,6 +92,13 @@ static inline int restrict_link_by_ca(struct key *dest_keyring,
 {
 	return 0;
 }
+static inline int restrict_link_by_digsig(struct key *dest_keyring,
+					  const struct key_type *type,
+					  const union key_payload *payload,
+					  struct key *trust_keyring)
+{
+	return 0;
+}
 #endif
 
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 91e080efb918..38f63f1c2cbe 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -23,10 +23,15 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
 					    const struct key_type *type,
 					    const union key_payload *payload,
 					    struct key *restriction_key);
+int restrict_link_by_digsig_builtin(struct key *dest_keyring,
+				    const struct key_type *type,
+				    const union key_payload *payload,
+				    struct key *restriction_key);
 extern __init int load_module_cert(struct key *keyring);
 
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
+#define restrict_link_by_digsig_builtin restrict_link_reject
 
 static inline __init int load_module_cert(struct key *keyring)
 {
@@ -41,8 +46,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 	const struct key_type *type,
 	const union key_payload *payload,
 	struct key *restriction_key);
+extern int restrict_link_by_digsig_builtin_and_secondary(
+	struct key *keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restriction_key);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
+#define restrict_link_by_digsig_builtin_and_secondary restrict_link_by_digsig_builtin
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
-- 
2.27.0


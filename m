Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66E68CCF7
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 04:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBGDAj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 22:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjBGDAg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 22:00:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2473527B;
        Mon,  6 Feb 2023 19:00:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KE2Vu029647;
        Tue, 7 Feb 2023 03:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=uW+yc+tJh0+xmjPvPWeI9SuMsvznb//Yz139eJyuh8g=;
 b=F9/4OnParyIKyTL3kBF9H76yB2hXCEgtUnMIWvRh9wzWsgozP+S4ItQ765Cg832qH6Ic
 xw+8nsOPROaUkxYxTZYGdwZEpfpq1ShO7o5tac1moVfBWiSPlAjn9c1/1JQ9Y48tuy0X
 e97GSu93/FGPHX3wI8ac9FHdiHnE/M9MNKzquxkzJ6NiFmEWKQMtKfPBLzItPXSMytYZ
 VqL0fe91KC9hjvw/cQx31hvQxpFLqPwmaXlu3Pl9mLjhUk2dpe6zCMFkK0k2aPO9UKAy
 XiTFvAGhFqkK1qcXUk6cnqw86b9BvysUYs9xiQMCIhoY/SgSHKkc0HIIEnMhzgEVe0Lf TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdmh40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31721H1b037579;
        Tue, 7 Feb 2023 03:00:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtb8bge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klQ/bpAAYeeHI848wY4hczFkrAX1SsJODmrhFCSyrpmjkhQnWAfzMHVdnutccy1c8P1mo3klB6AHRiLBnVcB3hqq7qCVNpjkJ5wLZ4wRSY1OOHDa8DS+IpLhdfg2RzFk+HFpdZK3YdZtltm778qSmg/ArbJ3AqnWWQ5+DQfvwgqSTJw4vRrjeucA3RdefjP181px6Hf9hW39QBiiKgam3XbDGbvCcU3bSBkdOrcX8lV0Hm6S+THr+3fHUo4raqGzHTXe4wcYHvQ3ENpYv3Qdne9KJbMkGRs7HNygoTxIfqmUtbixusqIvqbK3PEOPUGdU/Eiyzcry9p4DN2jNeJxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW+yc+tJh0+xmjPvPWeI9SuMsvznb//Yz139eJyuh8g=;
 b=m9lMAnPY0z7mJFf/Jbkq2TiKmBicSBzUKroapNEmE0uJ2ALWxbC/EFjDBqDyf0YdFvBJMLgvcGjY42aTUL45gcgOvgOtd/YBwR4YM8i7sDBKkBdUohRcVxWCiju0L33Jc7Dt62teKanrz/1zxb8tP71cbXGjO4EWVHvj8giz4a7dnL6ZLIOfgI5aLZRqNlxkNsTj5RXOafb9FocjqNGEKVMWg50rID7sbjU5AmdKmYraJcKyf5vQJFThbr+009Bcsz73dAh5NqUYcZf/hH4HeHh4on2FGxxKyk+BYO0TmTBhYxPUZEk3cuhtv3FT8CKn3FfczQ39xpyIO6j9UxIGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW+yc+tJh0+xmjPvPWeI9SuMsvznb//Yz139eJyuh8g=;
 b=rWtg9ZjrUY86Xp0E/jxKvy+Nik02Y/7clQNMKqfM5oK025jPxSWMn79In5aDccOyEVPP6U96FYb/fBkpWuT6YD063t4YqA0AAPzoxtz6G1pjIS5JSU9MAvqy7ehFVbbU3SIQS1ggRKWYuugw8w+o+M81I7sttOluZFkZwsV9f7g=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Tue, 7 Feb
 2023 03:00:01 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6086.011; Tue, 7 Feb 2023
 03:00:01 +0000
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
Subject: [PATCH v4 3/6] KEYS: X.509: Parse Basic Constraints for CA
Date:   Mon,  6 Feb 2023 21:59:55 -0500
Message-Id: <20230207025958.974056-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230207025958.974056-1-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 206d5711-ffc0-43dc-81f7-08db08b767ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+8wT0o9uoRZ8mLvak1yfchmW2w28PeIIhh29H+aqUjs5w5X2JPDy+/qu0bqyWQj7vldy7Rnix+o6768blJ/EOFGxjluJhTMKeGq3hBOW/dypCQ/f1qTxyXV4Viartl9PmHiNx0GKGrKdqIt6kEkeXbimmPDKQXF6ptul+Oq+/AbusPn7gOCDfJr7V5WERMWQQI93ydcgL7w8NqIQUWietANO5xoITNnjjTwzds4ghBAf8wFcSE7MkxiqtuLV4J0UbYsc6RrQnDI682piAgEsU8T28WPeQveCpCT9x7BSFSDU4Iv9WQwhd9S4gLDbc2/nCQSuq5+ms4wv57xIudaNjiPGzCmaBTfH+w6cCXosvKV27dBYepQmNaElbN+z6hSlV3vpcEOoPt3UOESdXO1QirmYg2KpwlcstjCkHjond2rN+j6wcDnoyqaQkezjbq9xVDfkousv0SeLtSVf8s1zQc003ahay7/xu3tQU9p+uQgmcrCtjB+Y8EDYfQ6DeMkC37mksmWl/c2gmrfAydBalnkmE3YAM6H6EhjsG7jWK5/WtiAcmpFU03wh/7yW+r3VCC/mWhOKMO1gkORkUAEhcGKjbWsO4f/jAVf41voQq2k6v9vyffnUGNULF+4MIN6WpswOH1AU4lnMMxOnIPGrB4PBWMB7KULqgmQ85Xh76k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(66476007)(7416002)(6506007)(36756003)(38100700002)(316002)(186003)(6512007)(6666004)(6486002)(478600001)(966005)(44832011)(86362001)(1076003)(8936002)(5660300002)(4326008)(66946007)(2616005)(66556008)(41300700001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dL4bCwkQwoRxtcAYqJxZ09qN4o92s3rm+LwghkQgBJg8eifKCQydurZZqTSm?=
 =?us-ascii?Q?zgg5AyUk48MP1hFWUAhBd7sHIC9/vexkclbFSPLMzhRUNZKtcd7fpZRhUouF?=
 =?us-ascii?Q?3lFk97YwMko60WblB7lM9RBzAOVwJx/WfCYOvQUGo7kCE57Y9r/NFRWGmwGp?=
 =?us-ascii?Q?KWQHZw965SAUmr4G21DK5Rb4l+nwIhIQwoPvHL8ZJzEB9qKXQ/cZ0/R0GhbC?=
 =?us-ascii?Q?h5oOKb+3BE8lBvoETvBIQVapgS0d6YEFOoX2UYQYVATrPRfUWlFMKPTCCmBl?=
 =?us-ascii?Q?ZwwgCKzo3HeTH3SsSqOLnW/pjhRNHswtHOiSL+Xroas0l9Kqh6sQ8lisbGrO?=
 =?us-ascii?Q?zd0PNZ10QURmrAMNYWCKhKfntSEvjCqoOaKO47lP1rmqABFU7GJzv4SqOdpT?=
 =?us-ascii?Q?FLGJLuWsJfIBmyuKQQF6ahthQUbPSfqULkV1gLCm00/w9VnkTw5zy51ZWNy+?=
 =?us-ascii?Q?RahjitXBMx7xP1h2HCq1cGgdYOPp6Wqp2jlTijCSo+4Ov+aYHrCkgMdVDYqr?=
 =?us-ascii?Q?Ke1zHnS3w5j3QKGJhyf12NgT+a1V4Nqkoosu1HfNOcXQ+35OfzAj2HOKDMX0?=
 =?us-ascii?Q?N1ymIkRzrYiBtL3BWFxWwQ37F/Z79IY86E+OL16yunSt5FzZwri89fjArSjq?=
 =?us-ascii?Q?DAEIeyl1iPyTpZC0jLXgpZ7kY+6m6sktOT0OkSs79xptuelJOimrGnjBVMUO?=
 =?us-ascii?Q?Ti5F5URATqr7iOaDiyuBbs7O5/QddFAqFT0irQT/IkwP2ozAPXJhGZ/XwlKh?=
 =?us-ascii?Q?4W9+irfAfTJNpgnucDJAD5CLhVjrB0WF5yIaJnRAIOrh+PcFATPiaLt05xNU?=
 =?us-ascii?Q?CR9qzoD6fkj70FLFo3pVhXJ25s5ZOnv9Q1PBYHZ8+LayLxo6BNbLDmMDplOb?=
 =?us-ascii?Q?O51qB2/+1S0oZAJ0GamF3cRlrmNPN5yPIoG1TcgNvW/573eHI557SJYe/NpR?=
 =?us-ascii?Q?ZYqdz2u351Q5WmQMdB+G+EQcWdvPmXhZOy6rDXiEkdQveyV6vy18HHeLdb2r?=
 =?us-ascii?Q?QFKKQ/7UY14WzFp2ADbDZCEcj0QTKKMz2W+wsPSt3sUNqNV34H9rVPXRk40Q?=
 =?us-ascii?Q?0YAfp76/MVuJDU4nss5UFkPVI08qi5saCuUMpXBGZBv5UtAse4EfYGaJPC4m?=
 =?us-ascii?Q?6AY91dhHiD8YWmXDx49pcvDSMQucO6Z42ObfNWMGJzG+sNEQkkU7IPALoqnm?=
 =?us-ascii?Q?/EH/JdRGVIpRNPSbI6ZujQAwvEHhNUjH1IaeVKu+0oDnU1ZCxUYr++Kgxytu?=
 =?us-ascii?Q?EcvLscH1WyZJ0LF44s2eC49zHIlVDp4WNTetvYJtrgJWOzCiu3g+IRkYq39A?=
 =?us-ascii?Q?aTUozUFwJyJD0qHsNm1eNfMrlTGJozW+ylgmN0V8V867AdjHEnRC+6Fpz0sa?=
 =?us-ascii?Q?0lnT05vG2+IQr542SJETexp5uQGPn0nFb25IEUdxMuDSOHbfY6DZssDy150n?=
 =?us-ascii?Q?4cDzLYa+ze+YhWX/ptPCP9//EofjjnsdCF2DC82R9K0vAJ8UyhEdx5VwD2eu?=
 =?us-ascii?Q?MObXsCoraQhtkjUGfl17BCBd9SsT6rCW1deMG4z7mffJ7+E85TTViZY8b/ba?=
 =?us-ascii?Q?tS/TUj4itqzjibdz3rb5mkYdJN9812uWde+uRChFUjA4TUYHIF7XF+wBAnYR?=
 =?us-ascii?Q?RJ0XNKerw3MsjyV/v8f+Z/A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?q/i9VJLpoKo5VrrlDpBEeB1fitO4cnZRK+iBVmtbaW1mOxkBLWPfghIvluJe?=
 =?us-ascii?Q?f28v9Ddm0V/BBNn+WoV+vVxDJ8z1Sl+uNTfl8bXZawq7D+mkeykH1JmZJwMK?=
 =?us-ascii?Q?rHUd+oKe6LsYw8cqW70lvC5rPwBTUwAL0YHWyCBmblgzDnIL+Z1A535D9/eg?=
 =?us-ascii?Q?axyo4eSRpCgl/gDFss0M58F2ARSPzBIQjZaymPvUGG8EDRJXHOqIDaHtaaMj?=
 =?us-ascii?Q?eTWlwyFVR1PdZ4Cx0pM73LBpttwjhOpYKu9p97YReuEgBVitWNT6Pidv7TE+?=
 =?us-ascii?Q?83gmtx5SbxEK3GkAUp3Z2r/x2Qe8xHV7x/OAYC3mytIFwt1MtK+bhEyUfd1R?=
 =?us-ascii?Q?dsG1ddWo2IQ2J/djoLaNZll4dFZOl1Qe/C44d6KUB1iBtl9vTMS5mb9uphVi?=
 =?us-ascii?Q?MnSI7BqA7k7romXx+rrzyXO3vWX2dMmO6z7Vi2UGWrfwIr12ylrwkcuD3g4L?=
 =?us-ascii?Q?KPJyT5E+6HSWtlyceASBUKXiyXkpUg14ZXKIRoXRPsl3jNOmpWz7FJQHOIxs?=
 =?us-ascii?Q?igtj4LhxYidLvJENGXDhZtECjVoZF35/BqHG0GitqMr7oHAolRP9lP2d+9Kp?=
 =?us-ascii?Q?6jf77c7hyxWo9EkNsS6HEszFHW+P2/UTlVMmZyo/rOr9nimVmkcqxQssrFxp?=
 =?us-ascii?Q?13EwyJqUvoeri6IQA4QVyKgiYnDU2WQROk3CLoFDuulW/jrcpe+PxcUx2OiV?=
 =?us-ascii?Q?bE5m3FqxYmUE2J/+cCxmMNL8rHbiUdff73HI3ERRDr9o6CkI3ezBLhTeELe5?=
 =?us-ascii?Q?HGRDNe7aAB/mO383DBMD7kzABo2LfS8NeW+b5zpSqelnGQEadtiYpbcKHbM6?=
 =?us-ascii?Q?drPh8vXFzhJgiSIR52jc7Uvv2+QSCxpo/9RH2tFY6cOYUYzcU+MEQ8xFXI7j?=
 =?us-ascii?Q?n6Qmha/Dcv6clC+zap23TTPECjlgPONcHVhHCfwBNEB+lgYXK4FTWsYiephv?=
 =?us-ascii?Q?7sKrn9SUm8shfA1xopzOK/8uGXoIPq4JL2uoEWdbm3enFp9AodUiP6tZekpG?=
 =?us-ascii?Q?tkF7m7OWsgvX2WNIozOw+w8fxOfwxL/ZkFvCN+IjSiHvblmmhWVOrRZMlDur?=
 =?us-ascii?Q?cwtlmAtmYHBb9n/mTOSEm87oyizbRinGnI+BQLqpckMZcq30pAHmg2VcVgrF?=
 =?us-ascii?Q?2iU2JyBqeo7354DaCKkKGYXsDtGLLzluZmIJX7+Yy143YRfn9xaJPpOf11Sb?=
 =?us-ascii?Q?epiNm2n9rmSVhzk/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206d5711-ffc0-43dc-81f7-08db08b767ab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:00:01.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+dNH3J+5iSGfe+ystJghODW/DSaCHj/QxHHELD36VpInzSq/LZaxGvrbPp69z6bf/gFEiV6BrgwCldQbCgbBVLUSUnEucEjXxEOREUeMd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070025
X-Proofpoint-ORIG-GUID: meLPCNklClGmx-uGJzixdNLKdoKjoH1i
X-Proofpoint-GUID: meLPCNklClGmx-uGJzixdNLKdoKjoH1i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Parse the X.509 Basic Constraints.  The basic constraints extension
identifies whether the subject of the certificate is a CA.

BasicConstraints ::= SEQUENCE {
        cA                      BOOLEAN DEFAULT FALSE,
        pathLenConstraint       INTEGER (0..MAX) OPTIONAL }

If the CA is true, store it in the public_key.  This will be used
in a follow on patch that requires knowing if the public key is a CA.

Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.9
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 22 ++++++++++++++++++++++
 include/crypto/public_key.h               |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 7a9b084e2043..77547d4bd94d 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -586,6 +586,28 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_basicConstraints) {
+		/*
+		 * Get hold of the basicConstraints
+		 * v[1] is the encoding size
+		 *	(Expect 0x2 or greater, making it 1 or more bytes)
+		 * v[2] is the encoding type
+		 *	(Expect an ASN1_BOOL for the CA)
+		 * v[3] is the contents of the ASN1_BOOL
+		 *      (Expect 1 if the CA is TRUE)
+		 * vlen should match the entire extension size
+		 */
+		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
+			return -EBADMSG;
+		if (vlen < 2)
+			return -EBADMSG;
+		if (v[1] != vlen - 2)
+			return -EBADMSG;
+		if (vlen >= 4 && v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
+			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_CA;
+		return 0;
+	}
+
 	return 0;
 }
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 6d61695e1cde..c401762850f2 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -28,6 +28,8 @@ struct public_key {
 	bool key_is_private;
 	const char *id_type;
 	const char *pkey_algo;
+	unsigned long key_eflags;	/* key extension flags */
+#define KEY_EFLAG_CA		0	/* set if the CA basic constraints is set */
 };
 
 extern void public_key_free(struct public_key *key);
-- 
2.27.0


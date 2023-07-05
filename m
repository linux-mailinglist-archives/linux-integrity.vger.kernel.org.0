Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD6974912C
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jul 2023 00:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjGEW52 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jul 2023 18:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEW51 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jul 2023 18:57:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECAC102;
        Wed,  5 Jul 2023 15:57:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365MscqY020088;
        Wed, 5 Jul 2023 22:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WHBkXW6qaq9C2qEHel80vwSwVywymNE2CtHQq4BS0b4=;
 b=JzK569mwKfcdQfM3Tf5Se6gxN/WD/DSvLigDjPSABj2Wounu/KbUAGZZU9F4IBw26MAI
 c4D5HM5nburLmnMSr0em9uQce7/3UHKNtEieQW2P6f1IoKjXt7osf9g8kGel507iF0Gr
 H9sypBDxvWmz3myMX1NcB19Ld/NTOgm6tOdzf9V192UUKP5LGYb5Bt3Kw442qZSxZQ/W
 lg9CWHMdV7sp37v06AER5STljxCV4PqckuXZCnUsRUSsjWACB3FgviCmQAuRi9pmnLIa
 3Edolti15IU3rQzcvhtpv5BtiNVnUnDWB8S+QUPZrLNuKIyEwVl+e8pZEW9bSHW0COD+ dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cqmx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 22:57:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365KqWEp033383;
        Wed, 5 Jul 2023 22:57:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6efxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 22:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVTmtR1ynIQr5UZRUg2GtkBJ6YlPMkpxrhsKDJfKTlewBXeQyqyVgfuEL8V7zL8b8H7z34vWIIXunTc/e67XUCkk4upZzK5fCgdu8ZPE/lgKDD270Lq4FmR2bFIH9rPi/fYqPsSTPIUm6Y1vKAJ7ClBFWeVsxB+PSWyFXH3MR2fGnX8BIA5QYRhrS4D3Bj7STH4T4VNeFZn28HAojeYxsmvDTGh03ioJQatJDMo1TChC0dGpx8L1+Suuz1bjZo272H4n+vBAPhBFiWQqKGmqE3iUA6AysgYwajbOqMsPLA9pb14oYw4QvogF61zjh/5CZwWNMoNeom/CCRem8FwcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHBkXW6qaq9C2qEHel80vwSwVywymNE2CtHQq4BS0b4=;
 b=iCAYpXtVHTNgASWC+PoFdatAiDUBx7jU3f+MJ7X6V7RmCPonSJx97Z7N7yd3ELZCh13LgWTYbfIXp1dzkPSa6VVIOANXhZl0ADJwMTSQTGG1Ndi6Xr35MDZWXNZ1I9nJ5c93BA798lbHu9WF//fXDZ39pThzJlQoa+x1lNcKVsuzshBeRFTq/05WlLgEZTBrq6Pon0SQ7wpZIynIwCmVtSw6zK8rGEurzavKfaKYr6H/3XXg4gcggpoEf94DWm83Scbddljt5YTMdVjY72dGoRQ87j8pe2De9aMk+gzvymLmnDXxkjiuUcTMkNAkIm8dGU3Q89MymZyspOvU5tMesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHBkXW6qaq9C2qEHel80vwSwVywymNE2CtHQq4BS0b4=;
 b=eDv5lLJg3sHTlFhOGp4WklN0uYgZhGZEBiiddfBhl3Xgf6vsS9BFjZCjHbfqtTUCd+G5peFuyR2uhq1t35ZvV3QZzIYPBfrIZluOumMYKHp7oYRkO9NbFg5pYRnypIWPAxSJREOZjfXI3S+dLeD0OrI8ogaA8AaFpzxDInsNq5s=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CYYPR10MB7674.namprd10.prod.outlook.com (2603:10b6:930:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 5 Jul
 2023 22:57:12 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::6fe7:599d:4540:5ec1]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::6fe7:599d:4540:5ec1%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 22:57:12 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2] integrity: Always reference the blacklist keyring with apprasial
Date:   Wed,  5 Jul 2023 18:52:29 -0400
Message-Id: <20230705225229.1435691-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CYYPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: c80f54c7-cb6f-493d-45cf-08db7dab2b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZmf3fLCauzoUVQxFMZ2JZmnqmDeUAZm+XicBN+q050BZvgGQHJiuut5eMWxS/RV7IsQyVodAXSJCteYJV/6YMT+zlhwRTLJPcmlc9FE1uq8QD8IYMf60WXNLCrrKy7+Zy35Iavc9ttBoVGNKWl6bvJfm8XkmrArj3qZQnpvlPWA75Jk5TobRM2sP0A/NNLGSGODdAxYSIO5G0Spi5LGFixydBSO17Y3lhZCebejUX8P6hYptJVJbR26pWYVJ3GL/AOBRm0UntaNnHhx75QK+uvBksEVln3CTg4N02kjh75IcBwL7ygO9Mq2Kchs6b0UPgbPR3wbZlHdjLDebtiva3gBnkG37j8iMow+3RFKbCYQ26SaS3Ltkz12CJB07Z7g2a62fwVCX5lFb+E0CgiAdNuhwxGxcq1zj50yj7uQb8znPaoLel8uAi4jUhSpWWbc1npgYZiOJrtWZHLjBMOsah7K6oRDUT+LBWlITSL7frJBdQyMWBy8UjvATyZDlpoW98jcIe+Mfv5EC1omBLm6D4sipQBqVZcCInSraIipUyEM+bEapUq3QeroFoVpbIWW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(6666004)(478600001)(6486002)(83380400001)(2616005)(86362001)(2906002)(186003)(36756003)(6506007)(1076003)(6512007)(66476007)(38100700002)(316002)(6916009)(4326008)(66556008)(66946007)(8676002)(5660300002)(8936002)(41300700001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g39Y1P2GR/e/OjC5ohvnBOrOHTsbm/OSddRYqaytt4bsOQCLE+WU6ViixU4I?=
 =?us-ascii?Q?VAuW2qraPjGo7VGd/GeeBaAD66Rk6+IqNgRLgvqyNRMYoITFl8HPEgdCuLb6?=
 =?us-ascii?Q?bCDKVHk4ycChAHxhnyMqOMQLvyVfF2a63sT8jmk49HxSUCIirgKSL14yxxEk?=
 =?us-ascii?Q?yOQEthFh0Y+oYd9E+f9ttX244yAvSxbJ8nTjlMccVl+I+tUdqAFurfJm4h/7?=
 =?us-ascii?Q?5gH5MrHTqigla3I8gpwyzAszlJEXKDelNbXgATMC5FTMWq5ODcaHfz1bfWxH?=
 =?us-ascii?Q?vVKtZQkjXheBmK3oYXJiXuvsVQHT7AH1yO9W4fn4qEz+NrEoAPZXNncyIw1O?=
 =?us-ascii?Q?D7ViNhkYfKyhCIzO8ZcXFZIkpAgqVbljl7hv5o/KZpBsCIColM3IGv3DFCbU?=
 =?us-ascii?Q?euE8HCB+Wo+7qd7iyhh7anYQkm2SQpy780W+hyynf5+DC6emxsNE4VNMj9Z8?=
 =?us-ascii?Q?ta4IcJdpnYVB6wYl4JtbKnq9bVOrQsIz1gItEjL4fSaeayikBw5rju+0CyRn?=
 =?us-ascii?Q?1TVXi5vMC5cnFedhgCT00d/h2UdexhV+SgBH1/ffBdS3R4db+DpWK5CSMNMw?=
 =?us-ascii?Q?3DY4p9HTUeaUT2LxnIkh57zzv7vuqPpCVXpQHo40EbxUXrqKg92emIiqBvCz?=
 =?us-ascii?Q?Kfwk+EV+62QIpLL6rsPVr889/D5SlbzY2Tl/ghkNqvLYxstBgc+wj3B3b2Tf?=
 =?us-ascii?Q?OwC2Iinu8+ijWXTBA7RWmLcrcDwTrZQBg4DpJU8u2CnV+jucJWqAp1/jIASR?=
 =?us-ascii?Q?J3pYBoMiq3HMsyKXJHSCqDGMKdvtiZJ7TIfVrdDL2hJ7UfPaujMYwL8xkIi1?=
 =?us-ascii?Q?lLCYaLbPN6eDVeK9VLsf0gKwiutkdvwOMWBuptp2RDJrolJ/6o8luO+NMRTO?=
 =?us-ascii?Q?QyEZ5pwSgstZVOzADrnrkTH+9WYJLMwSQei1KliIVIZ3cSVbRX7vyCuyYkGQ?=
 =?us-ascii?Q?iBfeSBvwQJm8metYnKxzOManndNfZAqFrHJHQLjIgqfBlwrFk/YZTGZQpYIb?=
 =?us-ascii?Q?MXFA1+bJ7lF2iT6WQcfUgvnf3eZkE3KWnu52McUVPt5XyqnT/fzeyT3kYCL9?=
 =?us-ascii?Q?3DgpN+nmaxxwfP08QVa1sJ+Wv/8PmJEtpB2VigSShIVM+0BfKDnV60ylyIFk?=
 =?us-ascii?Q?7485UJxSWtbBuOa0ddrOFaLvfSqx/oxyJKXisXcqY5JmQPmAvJzGunWHbwqI?=
 =?us-ascii?Q?umV+XvOxSUW8DATw59Ef3oCqgTVQbtRl6VxOFsZ9CSLlTmgIFZv7ts6obrlr?=
 =?us-ascii?Q?NETpIU5F87w2d+qefOnAcHPxgQGwkN48SDwRlwewIYW2Q+3ktpTQSQf1Eq/N?=
 =?us-ascii?Q?uKGm2eptKH4G2E8JLMdRPIQgumm1u/IZlFXvKW2a5oi4Al+X7Sn68J2aGmg+?=
 =?us-ascii?Q?5OKlUxsRwD307zfvAdeY8+lAhFj2bTQPdlAzHvX4CQFTLreDNRaeDReHGt5n?=
 =?us-ascii?Q?SDR+r+X7kIYqRptATDRUmYjeye+DXtFL0IH+3tZBajjLRelvilvvD1rQLnt2?=
 =?us-ascii?Q?yLZhwMy6hso+PhfeWFhtKLy45Qn2+ZtvkLR1GSvmcvrXXmoSl0fkU9XxTwP/?=
 =?us-ascii?Q?3kfvUfj0blY9eDUNCpeY+ONMDheUNTzVWiUBWwvhhVtd5DnNsk9EUzjfrzJ5?=
 =?us-ascii?Q?O7wFUquKRpQBDbacOKSPvi0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NPZhWWMvXxYph3bQEAD+FMUMHp5H9/VaFv+Ut2sPZZCbStFeJiPbEfo/uKLy?=
 =?us-ascii?Q?ueh2PkZeXjORqZnp4DbiS4EX+gfWivt57DGp64zxox8LHR+XGPqI9cOu1pyw?=
 =?us-ascii?Q?E0d31MUe39ZpZ6Lme6Psv5qe+8BCrtMqfcQJc21u63Q+s439OT+78bVIy6PQ?=
 =?us-ascii?Q?aCsiJ6PKMW6DaxpQu85v9ULTH1VsUs797PZbW8Ovu7RLaDJOSzGF6QVOOkaG?=
 =?us-ascii?Q?W2rb3acz8GQ6ViMGS5c+BALUVTxRm+YlSvz76oCWOVx+Fhm4FiPxmiFh+1TB?=
 =?us-ascii?Q?s7lJocMvAkjodhKGvk+60yAD9AdJRqc3tIRT7uTol3QJ+MBImIjSujCGwRWW?=
 =?us-ascii?Q?8Ey05/IICFbRFEDYFlLkAurCb6iwX92FJct3PqF4NCCld1ooiuKUYyQrK7OA?=
 =?us-ascii?Q?6NUqqYc4zrzo/1yiyZZO4syG52297Dz9T2sR9VELWCTSuK9OWt0zPWiVjezl?=
 =?us-ascii?Q?YpC/KsCHh/o9W4KCWKTd6nKemGocKcMP+HKAteH8A/l+ZfQKXFMLEYjlT7MF?=
 =?us-ascii?Q?faP3V/3NaubFz803Hz6y0e14EY8daLlFWAUskuUweNwQzy1oUqK78IbU5Yfi?=
 =?us-ascii?Q?E9XWyNKuYmma+sDUJFs0OI8bliDLnyb8bWajcDZdxTp9kp8DfV07ZO6gPJ7/?=
 =?us-ascii?Q?ma3jir11Ji27kUtYFziISI4ScCtoin4xYG59kvVSWeWdtpmGEggnvTVh/zF3?=
 =?us-ascii?Q?+X/pkzTur2wVqBZzf7PXF7hWTJT0YlfGLLGI8CLATuyLIHO9iSTvBYDmNM4K?=
 =?us-ascii?Q?AAnCQv4BNWCOMxx8nloKh76cDKfLpdLG7+oRa+bNMFq2IKeOctypLxfS5VeB?=
 =?us-ascii?Q?Dw5IWj/fJZgnfcQz+8j+FT0tovQkHKlypKVcEUOv4qsYrQLMTUh9KEwhvsPy?=
 =?us-ascii?Q?f3RNyk9vvJPpLFiGn0QBR/AZ4TcAzTRDS5q+Q37CLiSLJxQuWX10GRPMIhnW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80f54c7-cb6f-493d-45cf-08db7dab2b07
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 22:57:12.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6ug+jRxdj9yAvb9cWSMwEk9C31fGxwJQYXZHjf/A7VgnD7LFoUaXEZcd6pGT1hJ8nJxExsa2275V1GfV30VDxrINo34AWHJofKNcU+C+tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050207
X-Proofpoint-GUID: 9y6m3nx_BnvSen31cnsM1JGD-X20a70w
X-Proofpoint-ORIG-GUID: 9y6m3nx_BnvSen31cnsM1JGD-X20a70w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
modsig") introduced an appraise_flag option for referencing the blacklist
keyring.  Any matching binary found on this keyring fails signature
validation. This flag only works with module appended signatures.

An important part of a PKI infrastructure is to have the ability to do
revocation at a later time should a vulnerability be found.  Expand the
revocation flag usage to all appraisal functions. The flag is now
enabled by default. Setting the flag with an IMA policy has been
deprecated. Without a revocation capability like this in place, only
authenticity can be maintained. With this change, integrity can now be
achieved with digital signature based IMA appraisal.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2 changes requested by Mimi:
  Update the "case Opt_apprase_flag"
  Removed "appraise_flag=" in the powerpc arch specific policy rules
---
 Documentation/ABI/testing/ima_policy  |  6 +++---
 arch/powerpc/kernel/ima_arch.c        |  8 ++++----
 security/integrity/ima/ima_appraise.c | 12 +++++++-----
 security/integrity/ima/ima_policy.c   | 15 +++++----------
 4 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 49db0ff288e5..a712c396f6e9 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -57,9 +57,9 @@ Description:
 				stored in security.ima xattr. Requires
 				specifying "digest_type=verity" first.)
 
-			appraise_flag:= [check_blacklist]
-			Currently, blacklist check is only for files signed with appended
-			signature.
+			appraise_flag:= [check_blacklist] (deprecated)
+			Setting the check_blacklist flag is no longer necessary.
+			All apprasial functions set it by default.
 			digest_type:= verity
 			    Require fs-verity's file digest instead of the
 			    regular IMA file hash.
diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index 957abd592075..b7029beed847 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -23,9 +23,9 @@ bool arch_ima_get_secureboot(void)
  * is not enabled.
  */
 static const char *const secure_rules[] = {
-	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
 #ifndef CONFIG_MODULE_SIG
-	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
 #endif
 	NULL
 };
@@ -49,9 +49,9 @@ static const char *const trusted_rules[] = {
 static const char *const secure_and_trusted_rules[] = {
 	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
 	"measure func=MODULE_CHECK template=ima-modsig",
-	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
 #ifndef CONFIG_MODULE_SIG
-	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
 #endif
 	NULL
 };
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 491c1aca0b1c..870dde67707b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -458,11 +458,13 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
 
 		rc = is_binary_blacklisted(digest, digestsize);
-		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
-						   "blacklisted-hash", NONE,
-						   pcr, NULL, false, NULL, 0);
-	}
+	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
+		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);
+
+	if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
+		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
+					   "blacklisted-hash", NONE,
+					   pcr, NULL, false, NULL, 0);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3ca8b7348c2e..d2c02d2d740e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1279,7 +1279,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_FSNAME | IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
-				     IMA_VERITY_REQUIRED))
+				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
 			return false;
 
 		break;
@@ -1354,7 +1354,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 	/* Ensure that combinations of flags are compatible with each other */
 	if (entry->flags & IMA_CHECK_BLACKLIST &&
-	    !(entry->flags & IMA_MODSIG_ALLOWED))
+	    !(entry->flags & IMA_DIGSIG_REQUIRED))
 		return false;
 
 	/*
@@ -1802,11 +1802,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				if (entry->flags & IMA_VERITY_REQUIRED)
 					result = -EINVAL;
 				else
-					entry->flags |= IMA_DIGSIG_REQUIRED;
+					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 			} else if (strcmp(args[0].from, "sigv3") == 0) {
 				/* Only fsverity supports sigv3 for now */
 				if (entry->flags & IMA_VERITY_REQUIRED)
-					entry->flags |= IMA_DIGSIG_REQUIRED;
+					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 				else
 					result = -EINVAL;
 			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
@@ -1815,18 +1815,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 					result = -EINVAL;
 				else
 					entry->flags |= IMA_DIGSIG_REQUIRED |
-						IMA_MODSIG_ALLOWED;
+						IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST;
 			} else {
 				result = -EINVAL;
 			}
 			break;
 		case Opt_appraise_flag:
 			ima_log_string(ab, "appraise_flag", args[0].from);
-			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
-			    strstr(args[0].from, "blacklist"))
-				entry->flags |= IMA_CHECK_BLACKLIST;
-			else
-				result = -EINVAL;
 			break;
 		case Opt_appraise_algos:
 			ima_log_string(ab, "appraise_algos", args[0].from);
-- 
2.39.3


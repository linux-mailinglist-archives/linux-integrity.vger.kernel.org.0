Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830853E9C64
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhHLCVT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:21:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54834 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233760AbhHLCUk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:40 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2Aitc019188;
        Thu, 12 Aug 2021 02:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=yUritqkhMEeQvFwpdzhjtrvkIwCWQoUsmsWYUymmTys=;
 b=NAgN4rJJgFdegBarZJvEgcFPU7ojdYOVHz6UVq03opWEVCkEx4IFF3jlq6p8eh6ZqRYW
 ZCcFRQhSHGl0dqnxpQy5o7Q1+aTHxJPyax8OTA+nbq45VJivn4kOqHxXNik/8hIWjFQh
 IZzpP2YNmkSgyvs2pOUTMUT4Kk850mfD9kO0vl/EgVcV1JOTNLXOFHHcU5iy0ncnovHf
 oha/yfCPIPeZM6GM3Qn4hnf9rsJc3dDBNSLq4fEuFH/MVJWTiJINiPSZOEXp5yfWFvRR
 fxy+G7i3OaUYjBciqw0KvKk0Skwdpfo6Sys0rFhNCOkrdx9VKY1bMcjlHZdCmHN1k9OZ nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=yUritqkhMEeQvFwpdzhjtrvkIwCWQoUsmsWYUymmTys=;
 b=kvM6NYLi3Os6fnsQuk6rFzx2bCUV4qTGefb9weHpgg7nyghmz/ovQ5tttuausHM2TN6l
 f8bqWaZnndUGeq53fLKZGYMBg9EgMDbrAsqHokZidnZOcLb2sPjBz+c93qF2E09fWGub
 FQmjiFMqUSb11mOzvM+efzAlMjm2mc1V4z3QnvNGWKlZnP0aSyTFdkm6FHsGp4GUlvjU
 oiGr02tbZ7kwps00FOIYSYK6YFjltvMzSpTpNWSZN5vO+0NB6TG6Up9iC+Zdc7XS8+Gm
 +M6Fw8qmetUuVbpC2QNTHgsRjTAbyzKZch0KLi+lEgl5uUTSmL9vrzdYe+YHzJZZZFSs DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44c6hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GIHL143188;
        Thu, 12 Aug 2021 02:19:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3abjw7j8gu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI/GBbnRiXjivMeMRIco8KYIJcXNuX6ChjipsAUMIFZi3UZ/X4I5EzIIjSV12dTflhtu3iuj7R5tP/x0/FpGFG3PCDtiq73r2dE06KrukSC8YL/pNcqT6AlK6TunwR7OBjANIBr2lph/qJ8E08GPUVFdglMKQHd9JG/n5DwT4HNYDuEeEzqQCnHkByqQ7IyR/oBfitrV3QXXD+VOX3ZWtLseBNVpsIDVQNyUFqdCRZyDv1CDNruonMPG/w/9QGYu4ZmnclJuraZ9MGmv1fUOy55ymbBgDILLvNQPocgwY4mtzYgpbIP5LggALIRVPJd05xmiALrT96fN2ZnSQmJUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUritqkhMEeQvFwpdzhjtrvkIwCWQoUsmsWYUymmTys=;
 b=etfMZ+OnyTUaIWB8+fESyG+LNz+sML13DpNsnvnRrjlcVO2U/Fd/RmXiMZgSwqJ18uuGrbXO9pdOJrmPiyGvovf+NLQJcaC64fHawoxwimyk9wL0ViUcZt9xj3KvHtcjROxCckctqAtSuDMhlXd8eP0ayF4rlXiN4IP8Uugh5FtNCvB2WtIZ4pY6pK1df+nqZLTL5RG6YdF3g96WVBHrWMMavjeZ6W1iDtgsF6N7DCW+DwhjT6bmIJT6LgIWQmUFpzfPmAXuC25CYqDtvz4D3jJMwWASrau51oz6jq++EekoyiNElp5vIyYXvRGb5Efvp2pOpQ25TJzKP664DdnKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUritqkhMEeQvFwpdzhjtrvkIwCWQoUsmsWYUymmTys=;
 b=W+7HEar26RBXNycm6RT3oSS4eopI0QFkXlBA2HwK27fQ0JgkgC4QkwL7t9AV4aYW+OvRRa6LjTIN6+ZnJFBqS/W7Tf5P3oiogbFZUKCIA/ZkheTHIL1GW4F4mt4Vlax5mpW6Az9EZoHnK45Fjm0WpH0O4hst/IudF6rCYufbDOE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:46 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:46 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Subject: [PATCH v3 13/14] integrity: store reference to mok keyring
Date:   Wed, 11 Aug 2021 22:18:54 -0400
Message-Id: <20210812021855.3083178-14-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d719aa3-ab4c-4f3a-3d18-08d95d37a729
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB396027656122696FB2B90A7687F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzKX8bvwCx4pZlMKOn6co2lKhqEgxtM9VVG7WxtTewKdcxSSDF2VqZs9DSqgUI3xqN+2AcV2D931HnCuOlxv00A6Fix/r5cLKATuwONGnDRT8zP1WiA8yfuaoyANgv+HkzRivPisLjhpHrVhAqK1aFtmrV4ILslpmVfWMKu3b6FQEWu1N8As+uZSQnyNmDcHbXMuWI7pHTbUzuWa4H2aPxuLjW554TOfgpoIXkvJJQMCt88vHXoGJPkgoBL7MUjvdkWedPJ+Hzvn6DjuJdO1LymHKT+KAb4xIZKfr48YX6qsZBahPS4cpd3bSThBOuWKk8LdxFe9vwiTSD9hES6dE3wBlZ8K+B7FpYBUPn29kE8Fl2w0kCa3+kYRHAAXlPhmaNk/+xWdt953bkXujq5Hv6EeeKXghizq2DehNKkXfmr5LKqAUQbN1oVMwTT08c+0JUISYUmtzxWC6PJjMwtks7zStyBHLfBTYDsxYn9RA/UWK9RfdG6F+wZQtVHo94898r/OH48NlC9g20qoT0HmaRhvvYeNFPezINa2TG0hBKKxkzqZplpmfEly8BPtj3Skr5anaQ8alhkywPtKHaDNme9lZfNrQw4UP8X5bMpDqQCT7+MdyQzQcQJ/w7tulN/F3Rc2G3V2ZE6YPRD7iFWtw5RTeOrBEZXcIgl+94RiDK3Ox4aZnBxf3oZJIczYF+U5B2zY+PR0OR+1eX9rKCeKoMvXEkCllV3EC3dG1ePwXEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(4744005)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(921005)(83380400001)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vbq2MXkqbjomgvjqHy9kkjd+xS/+E6R/PCUTW0UbTG12X8mXEi3gOGmj5m8K?=
 =?us-ascii?Q?ZZN7/O0xPOXqJcqP4T7O5joyMjSBbfwDduY8v2VOPx35ouow9Y0ayyYI/yLs?=
 =?us-ascii?Q?M7OuKvsSMYymRpgKymVO48nso6CUIaNKimJBtlSyi0jCaM70daGYkxXUiqVs?=
 =?us-ascii?Q?seVlP/uB6Hbqa/OSMgo3elb0q5VeiBAowD+lGcP7tu5cpMmYP1k4u1uTSeWg?=
 =?us-ascii?Q?qDGG/dAiI2+eou4MkrjyM19dEj+JLRhrNlNevtwOckflEilfkI5zPz5FgEqr?=
 =?us-ascii?Q?A/ZxLIAjakSBxq/S3z5yf1nrQXgcaPJhO1N3a4Ctbj9LyYwP5EUSK06cVUIk?=
 =?us-ascii?Q?LO/WFtoVWFPBhV+XfJxYJfUriHB9BaD2A45EhiY7b7JfpR1VihbpBlZpfZuJ?=
 =?us-ascii?Q?I0NVE9PU6DxD4oZwO6TBJvKaDm/diF/OrPqyFAy+MrXndTeqNHyYK53VD3+I?=
 =?us-ascii?Q?c+CiEmhttijTg+e6n5NjWMsytk/u/ikgSXUhzifhoslSUbA9fkWhfCiPSRJa?=
 =?us-ascii?Q?C4HolEFFNxDq+EEr0xQVSKk/JMnlLyW3vFeodB0z2rTVa5zMtgMDms0B6kiP?=
 =?us-ascii?Q?RlTdpyq10Rm9aXVEEATDD5+Cs9wWkDFqlTvieXZXtdCMfd409xJLQX1Bs/7b?=
 =?us-ascii?Q?fQIvoHtwvc68/DbbGqN6KmzMIMzLA9mCeRnrr/B4o4vIEiKDgAQM/MBtzMI6?=
 =?us-ascii?Q?Kt1XZgBmNno1laxDnZ9xjmhovPk2ZqdFvLRt2wUZ/R3MrSpAP36JVX/2D23y?=
 =?us-ascii?Q?1wbzSkidmVhvNAR6cVU4lqaxutZdy1+0j2FnNomvFVUaLS04xkD/IuDUWk08?=
 =?us-ascii?Q?/L04Zbd1BGB451cAjh9ZGMq3ah7n83zroyrvgUJyrr1g5CekxGNnCO9SOZvA?=
 =?us-ascii?Q?Mist4Ukqne1q1spfOtu/AB9LdJ0XaE2GoKtMC19VaTcDSrqtDyOlDPhHzVkj?=
 =?us-ascii?Q?w9TfA/33gOA6eDtuYG1W0ZK6MNOqqe7zTZYE7UZq0X/qZat/373TgPE57d+E?=
 =?us-ascii?Q?OgeYDOKA2c2HzTc/SmiA+/RmmiWwy77XuzkbpqtEPIRR4Y1mRNX56qk6rigY?=
 =?us-ascii?Q?V7DqxcGQkz7pkpIQCxlrCVjzxO/h9XE0iQat0lCq9V7fCluBNf/rYkex9JE/?=
 =?us-ascii?Q?keIAFgfsUVI030UuxDGoApup3YYod9qKO15KwopNdqTy5qNE5h1tLTIq8MPe?=
 =?us-ascii?Q?C+AvEg7IpOgUb8qsZMzqrKAeziySlxeUeKhSwxlXbHuvEGdRUcokuotAbFod?=
 =?us-ascii?Q?tMZe1Wd6ZNXn0G+T4euckh0yvvklF+YhyjeTBklBHNM1S0R3Dvdk/FB5Xo+M?=
 =?us-ascii?Q?KlaV7edlYyaRsgA3nNv+B1HZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d719aa3-ab4c-4f3a-3d18-08d95d37a729
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:46.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEcRp2D+lWb2HT1DL4KIAoWvXtu7xM8kYAhhXpWrQ3DMPsAvnckPG1D3nF1D5BM/EJ6hQX0jLMqzohSzbO3tFF4c9rrKb+5l+um02QyjQj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: kXicW9MdUJQd46K7krcqpg-ajHTzdZuV
X-Proofpoint-GUID: kXicW9MdUJQd46K7krcqpg-ajHTzdZuV
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Store a reference to the mok keyring in system keyring code. The
reference is only set when trust_moklist is true.  This prevents the mok
keyring from linking to the secondary trusted keyrings with an empty mok
list.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: Unmodified from v2
---
 security/integrity/digsig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 0601ef458e03..996bea950972 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -112,6 +112,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_MOK && trust_moklist())
+			set_mok_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
 	}
-- 
2.18.4


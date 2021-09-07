Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E7A402CAA
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhIGQME (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:12:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14634 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233796AbhIGQMD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:12:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187Ehc3u008782;
        Tue, 7 Sep 2021 16:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=zuYJJ3h4SNmSiecoh3cT9UPkaqWHHUU8rGUneAd0OyE=;
 b=GwC9PzuZKsNdkqQj++LFrMp+LxzGwrPCg+7qtnwcQQbP56qO9L3eh+YeE7t1caEGr0UB
 2gPcnbocQNAeeZ+wCb9pGhmkXrrOz0eVdUa2Lz+CJz6vkJsjBSP3Yaf2ln8/xbvyE53r
 j1vIfjwCM0GT3rbtqyhOtbQWjun+idZWTlNlQeK2QZTXC5SUIrhDb8qSQBE95DULPOLG
 nqxJ+OfkDwOCfPEFDZyz3QIzUSX3bVPauBe6OKq20GDuNlOMFHnIGLZc+gjFSV8uqwHG
 uS0M5K/iO9iFo6DhBaOdQaZS5roRXGiutf9TDsMXdODBRVtJB8O+8BQI/6o0dySoohCB TQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=zuYJJ3h4SNmSiecoh3cT9UPkaqWHHUU8rGUneAd0OyE=;
 b=WjU8uWqkxVq5Wmv0ICfFvQbnN5E952yothwp0Rr8h9EwcilBNR1tPOPP4AR5mTL0KBFi
 +gFPAUnmM+DfkIcOnSARydAF7wbZvhjw31snvbZzAXeTp0ljQXl8sJ1YnkGjk9jNHRi7
 PcN6VpkR8WaWtNHDgq2By7jCyxgucCKXP1E1RwlTcmJBLkPjie/Bw1DkdgVJ6hWT4J8g
 B+cd5Ca3vxq1BmtAIEtHdLY5bIWctdSwyRCyk2crFmAnYyT/vkIRSsj2BtOT0dT/M432
 zEOzCzh58F8VHPaSbEwy6QIwCJXZBK/Xesx42O/Fvzxrue0O3JorstVsZACi8q+uhr36 Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awpwktk1y-23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:10:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G01dW185488;
        Tue, 7 Sep 2021 16:01:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 3av0m4t516-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrC1JGLymM6BdVKexaegFTuauDvdIA+GpN3lVFQ8zpzMDSRMeoxZjkxAWzhlM//OdeWexoGz21lnBaxiI4+5LyzNLBeDILcaOTM7b3sDB8/VrvzCUbxUlHQitib5xbs1hGNKOUih/mGrBDttzoxiSey6PJtDZMz1ssKH/ldWG6hVeOWdBFjf8Knj24iUkR3c9tuxJIyOPZiHKb3weCd03e7VspRYoN2YT/iNh/ZlCGb5RXjjqqxqQ/KigrQexntwmgn9YrnKD6XS+hbI0aJB36d4NI2Oshvz68LqZYJx1C88+pOwdNJhP7C/E+49WhqDpdSUYxo3LU+sf8R/B49POA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zuYJJ3h4SNmSiecoh3cT9UPkaqWHHUU8rGUneAd0OyE=;
 b=nPP5t8AUlAtPbvaqqnCMoC7lSeRqD9yLqdXlZuVnCjLrPIHJ5aadtHqVEgNaIXsa9qjNNmLEKckXHeU0BbWPWhSFQiuYuxlo8s6cgYLP2UmK3amCUtbyFzZiNlMQth+UMln87gAYJwOeS78VgbKRmMArZzfjoO1cUNpM3yw4SQKe6UF8Bmw3W8IUrFM45ilmqYB+rTGx+4GqcCP2Jp0tJP8RMdiCw05rrjvYMyx/A4ul+R5/JOa/uWLOpi0sCYN9Tq/pu4N1YoJa5MQLbFAxWHu4Nvi1TxSILGr77nxPq9DIonEMN/dcZPcFeH+7YXCtiqI9IGYvHBuautf7uxcWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuYJJ3h4SNmSiecoh3cT9UPkaqWHHUU8rGUneAd0OyE=;
 b=k2xo1tfiGPa7VjlSockjixowXBMyxjqIc4Qeduv7Ns0HrJDHAylC56zlf3UZ4uN//s8kA/NXpbXXU1noVr409JSmM5Cob5d75yJcP5O+SscepNKP3vAodbNa32WRxOa7Cgb+33NYfyi8ZuDkCLoDF/Xia8AvG7foeFYu2EFF7I4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 16:01:47 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:47 +0000
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
        konrad.wilk@oracle.com
Subject: [PATCH v5 09/12] KEYS: link secondary_trusted_keys to machine trusted keys
Date:   Tue,  7 Sep 2021 12:01:07 -0400
Message-Id: <20210907160110.2699645-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f41832a-8ed8-460d-ec07-08d97218cb78
X-MS-TrafficTypeDiagnostic: CH0PR10MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5004A55B51C695BE34B6547987D39@CH0PR10MB5004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUfSAFQkvdPqXs4hZRNYBhswzgZBhqu4dj5CictKXKjcUCz12WpfKVpUg2r4SJqYgOd8sOiiF+yKa/bkiAt50cezgG+H+eT/BJtKhqrHdeKiqTPfp3kNNEPMoAaEmquKnLyChEqJJTlV9f2xOlsuOn3KFdNQS+XJL/6HftCTZds+QsusSEgWn2R/sBskO97kMsjI35WkAUN3vY3GbiXSJ77HmS+aKGLCyW6FJi6M+uwq2lp1JeebZFVE6oI/rBrGiLo80plbKsxM5s16EcLW9MYeOjvAvF/cS9gVUbdRgHLrSnFHopx3AfpJYb0su5vTye+I7NZgFhCu84pLCeXj/+NtKNLcUZlQeeV9ftjR8upYpSNi/fKAaCfMTdevMXj81Hzawq3IQYi48AiFkeLPJ+jDdP1pXh6mxa+CpLItjiryV7FbxdSdCatTv4Oo/1TwY56+ca4VfWJ2Uik19J0oyyABaZLEBSFVjh3MjwxKNm8h3UD6w8lPSDujX2suzThE2hkDUZ/gznUTGlmMnkKGtxakPKwVTOQCujoEkZVj1uDQCL/Q3hn0pn7AjfbQZ4iRd3Th85QmYy24CM87lkNtpg5kkh9LKbzJcdqCdjzfDoj+42gUDnSvyrXZmi0WpAPjAgzFNFJoQ1Kt1K985bYoL8y3jSyx19fWWIdpQTbTNO3h2RCijGxGm+jvM0UuIIxjTIy5GKf9zltNA9bKpUByer85sGXOr4fp4IM1mgfeue4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(1076003)(66556008)(66946007)(508600001)(66476007)(8676002)(921005)(8936002)(44832011)(5660300002)(186003)(26005)(52116002)(4326008)(7416002)(107886003)(7696005)(36756003)(86362001)(316002)(2906002)(4744005)(956004)(2616005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGmA9Z0opthK4hy8CkwkoXZduFbc90uWFvQbipLJ1VIf3CyPK9+9vSEslW2f?=
 =?us-ascii?Q?asvc1n0RCayW9R3Y/XcGZ/YfkQwIqq4J6AmP1cEooumZ27/aFP1WcKqxjlcD?=
 =?us-ascii?Q?Hn0W+zBoH0vP2cq0jq/O3nQ5WiSFJnzmyc2iC8GYnAa3lmZJ3HWy7kVz4575?=
 =?us-ascii?Q?SRgHfw4WUsi6bRB1Mcozgkz8EBDe0RZ039K+mGhQ0fUIuPkxRn8NCjKAFh0Q?=
 =?us-ascii?Q?kO1Yz8ykjJfwDpP5F2HM5YLgYufXD2zdnIqu1Hy3qfBAEoFwCXAbT5JyPITz?=
 =?us-ascii?Q?K/NXNJsW8NAggTbppHYX2GsjwrrLDBmemEoksn7aYKFVjPe/tx5v09R106yN?=
 =?us-ascii?Q?W3HcA9bPFZLBtW7wGzLrhL21zVhcAwsrFw/sDRGefoyek95ofhoR9U7H3Iyy?=
 =?us-ascii?Q?STC5n5UpD62NO8TWAynQ3DeksUU4fsrK1lkIPwP1DpLVhTdnfWyMljjp3p+B?=
 =?us-ascii?Q?K9KFvkOMQnSDb99kiDbrRFk2gKmuzdRTGWUqWruX/XBNKCliNNTSy2dhaCaH?=
 =?us-ascii?Q?caJO7qxNjs3/KAUz9sVf9Qmy16eppCFpC8/MQDR14qUmJazgGXrdwGF2/vAq?=
 =?us-ascii?Q?Y2KxC/aDtU5gJPjtIkwlEJk+zpZGiRHCoAmMrbbdLMEkzAlKA5rxDS+ex+v0?=
 =?us-ascii?Q?BkYowy246V+bSJCWLbA9XnZ+U+0BIt/fk8yI+m6ksFOV5v261/bseGymJzv3?=
 =?us-ascii?Q?DBmrveeuhAqkGtqFDVQ0nF3R70+Fgr8SeCCk271rJK6HSE1DUoulGbISu6ss?=
 =?us-ascii?Q?I6BYpA1P5baMRkAz841b9WLw76IE7KndBJqGu2y+0s9x2ngwsbxmCe5vT0RH?=
 =?us-ascii?Q?wlIdNRl5fnIwpVn5LN/6J/rO2Zf8a/2oddOhWfPiDISbdJM6p5V+nWyr7t7/?=
 =?us-ascii?Q?Nu4nswyC77L6YXcdodWqyjl6csqaEGtbC7H5dXGscGtUICHcnaVKppLm6xyh?=
 =?us-ascii?Q?yvptcKZ+brm1zKefCAd/oszFovQWc/bwXB1AvOj+4qHS39tmnmb71T3dlmG+?=
 =?us-ascii?Q?xrT+YFh4AlnLotga5mykIv+PEHOuyrCW0g0TetX/3HKGyyyP0zodE1jE9v2r?=
 =?us-ascii?Q?WMezVj+wguJIkVXwJr6Lq5i7b43NMnzn3vBEVVnTP2/xad0QO4gcv8wJ5aR8?=
 =?us-ascii?Q?pn14wWabvdqrQ9WzXTgoXfXaIxtzmdnoVoMQFrpRX2AdSP0vq8fzEGw/6PWr?=
 =?us-ascii?Q?wOpI6pUfYkgRgCobafLxBE0cP0BAwXJR7OfkHE2GGr2hk877MYEYLC17Qyy/?=
 =?us-ascii?Q?7fQX2PyodE+WueprsRZ6jzSNZdxkp2lJqmyehUNdPG0xlRxU2Y8eZWXOX4Ul?=
 =?us-ascii?Q?gJ8CgaFRVbx5z1q1VF2uU/nG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f41832a-8ed8-460d-ec07-08d97218cb78
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:47.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGfnIz1AE81H7VyRfjt/WYQ63+QdsrXfUJD+79Y3g6RgmwVddTbNf3yyJR3xn87MJsrCAXmVQ6zplfNhAv0F1sqXtwNouRgQNWEJbELYuY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-GUID: 5gR7kSyK0SIoGfvF_vhuI49WhdzhRNWQ
X-Proofpoint-ORIG-GUID: 5gR7kSyK0SIoGfvF_vhuI49WhdzhRNWQ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow the .machine keyring to be linked to the secondary_trusted_keys.
After the link is created, keys contained in the .machine keyring will
automatically be searched when searching secondary_trusted_keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
v4: Unmodified from v3
v5: Rename to machine keyring
---
 certs/system_keyring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 747f0c528fec..e414b80f2135 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -101,6 +101,9 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
+
+	if (key_link(secondary_trusted_keys, machine_trusted_keys) < 0)
+		panic("Can't link (machine) trusted keyrings\n");
 }
 
 /**
-- 
2.18.4


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A144F5DB8
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 14:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiDFMEF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 08:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiDFMCu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 08:02:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A315E435BD2;
        Tue,  5 Apr 2022 18:54:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235KPK5x012575;
        Wed, 6 Apr 2022 01:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dWcsCcC1YHYuZ51Y0qfpwf/LiaMyQf7n9q9aYmt0Qu0=;
 b=PJWwLoQ7NCAB88nMJz3adF+/DH9XSIYgx9kKHihKDLgI/qcRlBx+CnPgFdfLzwCz8ORO
 TXTxgKJ72GGBJern0kvM9akZasFMB+E03vqGfQ7IiQ9/lVEKCUUfTUW+oQrKffCNsdv3
 pAiLgiN2DljFN1/cWL61FMqB/lCah3b44vStzzNC1kNBeXHuwuSKPICdrfTyYsZVdemJ
 ZhtDWk3JLWKfM9UFBeyXRSRq//S5quI7JuFAB2y3E7Hxn1uIAFQfeCt7NxMskoMQItOM
 CCDWbRwSUQ08jDj6uomMNuIQ/eIv0M1uopyCjIoDvloa4jlAHmIQi6wJWnrEAYDeACWk Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcfdma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2361pf3m040841;
        Wed, 6 Apr 2022 01:54:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx3yey7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0RZ3a1oHyT1SvB6yDRXaPM+SCu9oAhE+Z+YkBOmZXbjScXf66lAL/7cXVzK4jN6rbnfFZ0jPjLuRc3bBtSDETcreRjGtaj7oY11y4yHLtOQcdJ+H3A+bliS8TPOswqmW7mjNE47NOK9hFtkn7+kObw+5mtfRpYzcq56ttm6uM0okImH9aUkcoQOx/W2FCXA6hV6g9hWVz4bXmCx47e6Uo9zqCA5hG60R3u48aY+ePdtuP4EXXPNMj+/Nmc4nmDcnQ88hrLs3Pp4YYAYUfVi/kOqRyLZi/UN3o/e1ZaqY2ONxalZQrF7/PaLJ+/+8ZjT+oLp1y/qF62aCtCS9izLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWcsCcC1YHYuZ51Y0qfpwf/LiaMyQf7n9q9aYmt0Qu0=;
 b=UN6o1eN43bHKuCAGKt7hppAnqvB+vvp6X3qcS+RbsnZtieg0G6APqFQyiyzEjA9HgI/kA2k+MkGTRWQrGn+86pHuANlWzRIllb3xzWLirACwXztkXNVqC4qz36Rr9kp9/aR+tYOH9hyhrUIvFgmH0muezbhjIOErO7cdn2NXLacA0REO155BtN+5j3V5kL8m5oXiN3F6VjeISeot3efl+O5HIT28k2RVhDP+5wqTnFFwgOwh6hEHz0e6dxjILoBf8qBoCt1aAxl88dFEGQXZnSRkn5CzNGxG2VpUcoiM07u/p5f7EcokqqOZlx89R/jGfW4VgV2adkztvms+LkYxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWcsCcC1YHYuZ51Y0qfpwf/LiaMyQf7n9q9aYmt0Qu0=;
 b=nWPyabhxUFswIfGyPMfQmRSTqKcuZVfcGVf9bRt3YrObQuZBZKmmk2l6DEkrga9kXRGwIKPE8mrsRtWyhOH0/QjkiC/2seOAfCwHB1BnyiQEbFMHA9dbhRb+lzJRQKO7y4LASdbTDv6l4YB3rZjLO8NF2sMZsQkgcRKNVuBlvI0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:54:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:54:02 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        eric.snowberg@oracle.com, pvorel@suse.cz, tiwai@suse.de,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 5/7] KEYS: Introduce sig restriction that validates root of trust
Date:   Tue,  5 Apr 2022 21:53:35 -0400
Message-Id: <20220406015337.4000739-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9b4d791-62e4-474a-4cae-08da177052b0
X-MS-TrafficTypeDiagnostic: MN2PR10MB4349:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4349CB54EA74EC9B7E7049B387E79@MN2PR10MB4349.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xrgw7ENo9SMckKj+HOgP7tsvjnv0tXmT9bPo2TxaVTSyBJUTOdmkBoxPnIoSPhL1DQuSgh1INC0HxwDg0tt9YJKtD2nsvfxoM5it8AeRwlEjqm4fbXSkh639vRVUzci4Oz3ym54/mCaf2eiQgCGZMYRW0Vo/sD9plWpVP2Gv7EzwDRNUvLiRXeyLCjl7ZT4TvIaAvVBizdCBWMM8Saa/Ahr9KrtGYmbzuud7dASAx3I0w8zL9QQT03hvTX7XQ0C6VpL2pXS3TX/l58Gqxn1nc+UdRXV1Kvao3VXVSoTOXIrgIdzsNGCrWKn5D5aWl1sPfOfsQnQW2HQZdQQjVagce/XGOPCTA7OllCp64zK+YgjONbJlBiN2NdYU15lXWWIJk1UWxt1vSG5a1RAedbZ2Qe/an16zrMbebGmM8rQLqx1tUha5F1B7TXlMGfYyAVC2fxEvgKlI4Mstb++ft9G6dmdT9zQSzKS3SWXFF8R6qArqEicoNw55Bk8gVmZjOYFukJ1fRHCZzJaSucOiRB53u+ByrOiMHVS+gqaXZyE/oGTKBL4qTYN+CUtuDnz4ZyQwaHHQA9cdWBWx+CHyXmQJieURzAYXY+eqNQ1U5mauYHOey1wN3kWnRyfggiH2OPL49eA5AvuTsVoXFBe1BfhOCYUsuUZ0Yp9fWA/fJD9PH04VyASJj96J16uOy88DiHwkoVQzW0C1cIlWO6iC39XhNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(6486002)(6506007)(6512007)(6666004)(5660300002)(508600001)(316002)(4326008)(66556008)(1076003)(83380400001)(36756003)(186003)(26005)(44832011)(38350700002)(38100700002)(66946007)(2616005)(15650500001)(86362001)(8936002)(2906002)(7416002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MdEgYagNLWHMl50gaao2B6VoCYwr7t5yEB/gFKeW7xCIeMk4v/VAZtozpfQD?=
 =?us-ascii?Q?EfyDHXX3Ts7rAyVlR6heCm+nCOrD2Gvx0JRsFd4v2uKJwxTtou036LcvZ1Ey?=
 =?us-ascii?Q?DEmH/f44n9YkJoxPoRgyTldHq8Nye89l9nN9tAOmb0RbI/YZVxpB5aTfEA7z?=
 =?us-ascii?Q?hII5bGe9g5oxB7+oDqXktHz1Qw8EW0Zk1nmlLdei7w1lQptY9s+MJvG7geNL?=
 =?us-ascii?Q?Wp9jh04NeobR3Bgl4kRsvzV5d16H8hkrnIsvAX/yeLf109cdIW4lpqdcMqkT?=
 =?us-ascii?Q?Zr79K263w7b0pYRsB4pN9c6DZrcSrqfDZ/5M++3fM+9CMujaSXZloY0wIPcL?=
 =?us-ascii?Q?ghWrEtnEVMBKbIc6s+dT0rVGTxdmgxYi1n7r55SDBp7m+lK8iJzT1yr0VOMU?=
 =?us-ascii?Q?5F8ahdMwY/HuZque34+uE9444RyEhyU6yXJfkKK27xFkiPsnKVgCiHrXLW5z?=
 =?us-ascii?Q?bll3EM0cDtiI274JxOMuYx3l9uN65fOY02oGpb5CFMNvVUU+ZNWkkMdz88tl?=
 =?us-ascii?Q?MJ8OxvMPijWsEVIcdK9J5jKPxpCD/7Q3THVqKQkQHaWHuKwP1LeCxR4ctlww?=
 =?us-ascii?Q?tmvlDWvLHCU9uRx5a41YrJJ4b8W+9Nz+a4Q7fpZ7dadFPfMyEdAK47eyNjc5?=
 =?us-ascii?Q?fQADks5i5T96lKOwmQQX4Du1XYqLRaExyazRRq2cuWCBgUoWXD01O3Gb7qtE?=
 =?us-ascii?Q?g30j0XOzt0Q/omv3k0uiujDOFavsvvXf8TRx/dN5Jof5PZN9BaqL8fyvUtWO?=
 =?us-ascii?Q?QzfsX/UCLK96pEeP4NjhAHe5MoZz16LNZg1UtLjiRh0pjj7NhrEfy7Wwsbdr?=
 =?us-ascii?Q?KZlZy/Ejvw7yV6TL4GtjTQ8UAeLbXKMbwK/nenwLRr5laVso5ji+1aHSeJLp?=
 =?us-ascii?Q?lnwiO1Ke+CvjMZiH8wYnFydWr6s32NDcSMTYjtYQ/8t66T/BJ+2LreYpdjsK?=
 =?us-ascii?Q?yNjGHnCDV4P+tldPSu+j1ZTKTJCuD61wTUg31N/pWBpFxdGD0riqEoXbCXyL?=
 =?us-ascii?Q?PuYQohWDgJqN9vIdhKl1AJXaWWfG3bnqo7nHKLMQluCCf4FF/p5adgL7w+yv?=
 =?us-ascii?Q?QZJ9e0v9owZNxIzWVOY7rwdY/Q8qUtRqG3bT+hFKDrNz40fRPX2tx1+1Sy7P?=
 =?us-ascii?Q?cBhmEYUgaJYKgFmlB44V6Rt/D9Sx5mMmMpJFWywuqm7KdvM5ZpfhGwvzyubU?=
 =?us-ascii?Q?D02i4MccrD3krA5OtrDcbLnlFAsMjKFclK/3/Hf0P8TtH3Z/HaMFdBz3Rf0C?=
 =?us-ascii?Q?kRU0fah9KZEAYoxoVBajtzcAP43SQvDSWXz/cWX9vzRI3N478L56nARaA+QD?=
 =?us-ascii?Q?tIAyEI8xxTtNHU/qiDsKbFB/MHgyo9voQTF/xsu15ttfQD+IHjJEaGSGbRBU?=
 =?us-ascii?Q?Q0I0yibDFmeFsjWr5BnCO+ANq/FWbhlCCBtemPNd9ioaAX0ghrDWypP4BSGY?=
 =?us-ascii?Q?aawq+iJm5m6khAFFuHtOx4fGtcaNubjerSZbViL5O25iPVJrq1A78T1L9wec?=
 =?us-ascii?Q?m8NCWmoZu8f1lYUmlFP/ZYAnPUJ3hzwVJEw9DQo7lUKPslWDJEhdiWihJY0Y?=
 =?us-ascii?Q?XULAegU9luclvpcPWy/IMWsK+0z/DlSxfPG0N4vrdS+hu1whUHq+Ez6EUDVf?=
 =?us-ascii?Q?NC2JL3wZOXxDsRFtOy/hyZFpQmtS7Ivb2DjqnisvAzWS/z0m1IT42+1SG3Hr?=
 =?us-ascii?Q?SBv+uRKs7SouLGyLZ9xs5jgHesYO+wK7HRrI1f2hCptR+05KHoECo05h5oG2?=
 =?us-ascii?Q?/TIyhaA2aGZGrLpOMrRXrYzPI4ZJm9s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b4d791-62e4-474a-4cae-08da177052b0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:54:01.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V5rBAyYn/SEZArldj9jER/uFK77uCseKsx7J+db+Z4hmI4Bx58AB8XNjruoGuGOS544myCArq58d3Ysfd45zBeKC8QG3NMXrzyOHN5JUmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060004
X-Proofpoint-ORIG-GUID: q_xWcVwhFUd8ta2VdMKPBWTwBEJgJhRw
X-Proofpoint-GUID: q_xWcVwhFUd8ta2VdMKPBWTwBEJgJhRw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current keyring restrictions validate if a key can be vouched for by
another key already contained in a keyring.  Add a new restriction called
restrict_link_by_rot_and_signature that both vouches for the new key and
validates the vouching key contains the builtin root of trust flag.

Two new system keyring restrictions are added to use
restrict_link_by_rot_and_signature.  The first restriction called
restrict_link_by_rot_builtin_trusted  uses the builtin_trusted_keys as
the restricted keyring.  The second system keyring restriction called
restrict_link_by_rot_builtin_and_secondary_trusted uses the
secondary_trusted_keys as the restricted keyring.  Should the machine
keyring be defined, it shall be validated too, since it is linked to
the secondary_trusted_keys keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c            | 18 +++++++++++++
 crypto/asymmetric_keys/restrict.c | 42 +++++++++++++++++++++++++++++++
 include/keys/system_keyring.h     | 17 ++++++++++++-
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 05b66ce9d1c9..a8b53446ec25 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -48,6 +48,14 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 					  builtin_trusted_keys);
 }
 
+int restrict_link_by_rot_builtin_trusted(struct key *dest_keyring,
+					 const struct key_type *type,
+					 const union key_payload *payload,
+					 struct key *unused)
+{
+	return restrict_link_by_rot_and_signature(dest_keyring, type, payload,
+						  builtin_trusted_keys);
+}
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 /**
  * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
@@ -76,6 +84,16 @@ int restrict_link_by_builtin_and_secondary_trusted(
 					  secondary_trusted_keys);
 }
 
+int restrict_link_by_rot_builtin_and_secondary_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *unused)
+{
+	return restrict_link_by_rot_and_signature(dest_keyring, type, payload,
+						  secondary_trusted_keys);
+}
+
 /**
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 6b1ac5f5896a..840ea302b40a 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,48 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+int restrict_link_by_rot_and_signature(struct key *dest_keyring,
+				       const struct key_type *type,
+				       const union key_payload *payload,
+				       struct key *trust_keyring)
+{
+	const struct public_key_signature *sig;
+	struct key *key;
+	int ret;
+
+	if (!trust_keyring)
+		return -ENOKEY;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
+	if (!sig->auth_ids[0] && !sig->auth_ids[1] && !sig->auth_ids[2])
+		return -ENOKEY;
+
+	if (ca_keyid && !asymmetric_key_id_partial(sig->auth_ids[1], ca_keyid))
+		return -EPERM;
+
+	/* See if we have a key that signed this one. */
+	key = find_asymmetric_key(trust_keyring,
+				  sig->auth_ids[0], sig->auth_ids[1],
+				  sig->auth_ids[2], false);
+	if (IS_ERR(key))
+		return -ENOKEY;
+
+	if (!test_bit(KEY_FLAG_BUILTIN_ROT, &key->flags))
+		ret = -ENOKEY;
+	else if (use_builtin_keys && !test_bit(KEY_FLAG_BUILTIN, &key->flags))
+		ret = -ENOKEY;
+	else
+		ret = verify_signature(key, sig);
+	key_put(key);
+	return ret;
+}
+
+
 static bool match_either_id(const struct asymmetric_key_id **pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 2419a735420f..2c1241042f1f 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -17,9 +17,18 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
 					    const union key_payload *payload,
 					    struct key *restriction_key);
 extern __init int load_module_cert(struct key *keyring);
-
+extern int restrict_link_by_rot_builtin_trusted(struct key *keyring,
+						const struct key_type *type,
+						const union key_payload *payload,
+						struct key *unused);
+extern int restrict_link_by_rot_and_signature(struct key *dest_keyring,
+					      const struct key_type *type,
+					      const union key_payload *payload,
+					      struct key *unused);
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
+#define restrict_link_by_rot_and_signature restrict_link_reject
+#define restrict_link_by_rot_builtin_trusted restrict_link_reject
 
 static inline __init int load_module_cert(struct key *keyring)
 {
@@ -34,8 +43,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 	const struct key_type *type,
 	const union key_payload *payload,
 	struct key *restriction_key);
+extern int restrict_link_by_rot_builtin_and_secondary_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
+#define restrict_link_by_rot_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
-- 
2.27.0


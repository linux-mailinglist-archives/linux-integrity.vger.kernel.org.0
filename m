Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE9964C157
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiLNAfC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiLNAek (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB8B1DDD6;
        Tue, 13 Dec 2022 16:34:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNie6024502;
        Wed, 14 Dec 2022 00:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=rF5QMf/JaOXNw0ahVv9E4x7XqxR/0gFM/dsRxNlFVSE=;
 b=KfReXpy2CyCa1y1VbompQUUerjtwR4Hrt1Z5gYfN432oUxjRSItbMpBhhD2/Zx1kmxW8
 eV1jvqVV7vkbvLGOymHCniEAVPStd4VPtF9VnDBeD7KKWsRCemqjWn3K81nMkHKA5JP/
 SP4Q17tQclExQ1haaTsKb8+iYMvye3h6pSvNC7VMP/Bn8/FfonwF0Z8UmqwdE0HARq20
 A3i7WEkDsgOO/SdnPIJLoIz3KDrQkvl9AQjVU/7X4BZErZ0C/+L1FEyi2erboEqpjSyc
 z+X2kwAyorbOM9fDDf7RyRyw4OCujP+aDjYzsvNJ0aTGnnDf5ai8gdqAnEtRG3v3ez1V Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyerrp9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNht1O031876;
        Wed, 14 Dec 2022 00:34:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyep4h29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rgc0yyeDyBwjX5oJHVjCb9BGyHzGUZRWDMNVn9D5kG/qM16G0ompa338+Q+xu12Bo4uuVoaAPGedNzkxy/UuWo6I+eZrJepSbsQDOhZhQSlGeoWIjETMHTfpK2pR9yfn2ssdK63SJokE0mC7AYNsoIi2+BJFzDblFoLVMSlOy7f2oRJMvvabMyYmrP4hJfbXRB5X96K0GyePFWAEaSs4l+3YRtll+A8ngj60867bQTyMBDFUny0tp/gcGEuvfjgLWoTJ4vMEKI9vY8x+EyQkQDcWuzFMzCWXsQNRXAl2qvSBlWg9iM/4P8MoMa0hF6rccSliJYjhvDpDTXeMSU0QDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF5QMf/JaOXNw0ahVv9E4x7XqxR/0gFM/dsRxNlFVSE=;
 b=b5RxP2DSArl+2xoXiQ6o2kYlf4D9cXBbXoK2iqh9mDuVT86dMqOksQrowU9xpelAijaf5tISaWmGkWZVuo+41/M46FW2eZ8KcocFriOB9b+owD8c90eOZPG1w10aRlmiWN6ip2FG51D5Ic5kfxj+W+y4sZjtQZr3r1KghJelnL1z0KybTtXHdWOe0XHwGE7jOxP5U1n5zEtkFi3Nvy5mAhqsASkiht5XYTkXXLw1b+qSGwWLJkWu9HRT0/zQ3o3UxmXLjFJTAWCsd1JF3MnK8Ev6vX8LthY6AxuHJr36vXP4uTn/lk01NnkSsFQTxyPvmDm4VY6cRBJPSpbL65jynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF5QMf/JaOXNw0ahVv9E4x7XqxR/0gFM/dsRxNlFVSE=;
 b=HKmauecSxzfgbM3z+WhxjlkmOhsMJI/h4AeLTcnJsFsaLx+lXM76qnRHT1Dy3ypX1XrVsoCZIP2/zAcSFEeafVHW9byvdNW4fpYrbWwIi4bV7MNfj2STYOTsTJOuGNC1KPjuh9rkpDiaQ6AmHUBmNztgiyybCmSa95qHR68qGME=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4324.namprd10.prod.outlook.com (2603:10b6:a03:205::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:16 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:16 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 09/10] KEYS: CA link restriction
Date:   Tue, 13 Dec 2022 19:34:00 -0500
Message-Id: <20221214003401.4086781-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::23)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 544303dd-1564-40ae-2266-08dadd6aee3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0MEHBCEylG3H4fnG2f6HKFO4QcgW9QIxxP1thdw+RliQMaEQiEF4qZudYJD6BCajprM+nXqLfNpmNczrMETuvkW/Qq19Q3+7llVHFDAm4CsUb9VkiheS4pXWOT/QKog60vsAtdG7X1Z4KwkqHUyl74oO12JYc8/smEc0crL7WBve5YSJ0GAfUNlAYC+G69tNcASRO5f0tkXQZKhBoluE4vnOF18gxIOHG9FZitlLOghW9nhNg7byxS/yZ9c7W0pKKtK5m4GRE9WKmJZWqtIiHXFz0gA9rid9W5eeEatVPmhGlv8xbVDRALPSuiKJQDnD+Ds6B+iM+c4HMqm8FKFS0B9iltqrGc+rB2vyu9Ejx4nshL/cgagEm8Z7bY/87NBWCuajkls7lec7btZhuTsjihJ8Rv6thn7oeTUtvpH67Sl8NvhLqtQEGvWqUvGFPNd2XhIDs+hci+QWmjHCS+wEi692iRGhtmDlYe6+94jbJL2N5rAbvb6Cbkeglc++DbtUt4gaMaOacPv+ur51rgjverKqHLFY21paqNq+qQswozu8oYxy/whMWJYTZcz6arpwCSm45cExCccyFPhOcQc5J5WTScjF6pL7CJ80ZRw3oD8t/FGzrfRLlVTP1kQeHnmJEZR8Krhk62tMQ2n2+DetA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(36756003)(478600001)(6666004)(6486002)(38100700002)(86362001)(8936002)(1076003)(83380400001)(44832011)(5660300002)(7416002)(2616005)(8676002)(66476007)(41300700001)(66556008)(2906002)(4326008)(6506007)(6512007)(316002)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Px5nDgXJhaQLc65/YWDS+igouk5vo+H1MoThmJIDkDSn+jsMqwA/+hlxGGN?=
 =?us-ascii?Q?NzVl9NnLlPEkqHQAQ2exFvJZpUE7rkwMt+sPdWh3QTIFnzPXko2RhV3UmfAa?=
 =?us-ascii?Q?6iA5mCWzYZN7onWbxLe5HirA+k7txGjQ63599a+lgNvw2B5RGAPuIhewmdPL?=
 =?us-ascii?Q?bJpjXUsZ7uAM4JIlFItFPdQq3b1ue1yncikiRwwbtLXVU30gJYXj2/ql/1WT?=
 =?us-ascii?Q?wI3mRrS3IHwy0c2BCT9gYu6E5O7NjC8OVtpsI6R8MQ0RFUd2NN7FEdGvki7f?=
 =?us-ascii?Q?oYpD56jtE38ywiptqkrEcd5EYBo/eb+o6TjiXqWKbgQfZ2/a7D5ECyPHNEA5?=
 =?us-ascii?Q?baO4jQ5aUj7V/N/y79aFZsmHT5N17PyggqPMcjHmahSQyBVup140bGsQ+F9n?=
 =?us-ascii?Q?kZI9dQkwcfqfegYzsOO+f29wFTccTtKmj6KZF2l5jbhoDblrR01TA+XDt2Yr?=
 =?us-ascii?Q?iC5kxI27ECib9AvYrg8peGHvkQov1Cf7KlZrk/IDZcLMvojGkBK6aQpm+IRm?=
 =?us-ascii?Q?Sp91x6wgSB8eh402c1sxyga1qVlvm6g0FR6NRYvXw3tcV7BT8Rp+tmpNWFZj?=
 =?us-ascii?Q?MnkV6/8wxFiYln3sn4UAeZOyHhfvcurpg513qb93gR+DN3WGzjhi+wdPYQfR?=
 =?us-ascii?Q?yTiK1JYoB6FCd413YM9Ddw8IXNX9+i8xMvim6Qi63z2SuDA+JUqSVQKYUKg7?=
 =?us-ascii?Q?DPl7vEf+xxigUVze24I9XLyTdS3B/V/7uiC8clAS2Sx3tV0uFceBs0McmdK1?=
 =?us-ascii?Q?JjWo1dh7L8B+bnfA1LpXeIjhwK0b0WuYp6tUs0eoPvwMXzXv69VVLHa9wkLD?=
 =?us-ascii?Q?+20kEUHQ2H2Ov8VSWMLzX4+G3jRQnbfq1Ml5d9qgMA1u41CkryZML4x0P+F1?=
 =?us-ascii?Q?hpILHpge/9+bbGz1UcA12OObLd/mQG1GCQZ+kgHraK+wVKB+nkeMy6LgzVlP?=
 =?us-ascii?Q?4ShwUjkZtkZ+6GjvHffOl02u7EPuAo6X24cbfZlSiZHDSEwAtp4qJm6L/XXR?=
 =?us-ascii?Q?7HgwSD+LUYP4m2Jl2/yQCNHceEulz9s0iHLU5wvcIkAIbz6B00KQTFG0+lbw?=
 =?us-ascii?Q?rYsvQCcDi+lKt4MylaQ88mspD0WGx889CXcELdz1rYQ3v8yqeR6hhDkXjNUB?=
 =?us-ascii?Q?lQ6O0SQsjDYVcYba8SoeLVWyIJeQLgxXdY7okmfXjrzaos94v7s43H3cExlT?=
 =?us-ascii?Q?BwjVqjIWJQ52dG3AjlI/06gdR+IdCSgUtazQgokyu5NMT6vzTlDUkbHSQG52?=
 =?us-ascii?Q?mtB4VDfx/JNOXFWGDbn7pINbxMvjVY96YE1+6FY9EhzBRKd4B+Xvaw+PLUzs?=
 =?us-ascii?Q?zRPiupUYjMeNLzGuVFQS79SQ6svNvIAzdKDG+pTJJO0Q8cfzkSrvnUa+34/l?=
 =?us-ascii?Q?EJjpKe/doYBa8tDVXDulFd/WzQH2+Ud1rT+L3p+4HBnqxt47yv0zqfatNK3q?=
 =?us-ascii?Q?zO8jhOUexpUbH3VfQp5y2xw2dW7+Fhiw5uWf3emCZdf9YibeZS4zN+qTub99?=
 =?us-ascii?Q?WdNjb5i8G6GLoll2AYr7XcE6vPmguzus9WWEeREQN53F0ZwO3OwezTQZBLGG?=
 =?us-ascii?Q?P0DmDrqzQzlRw/aq93RVXR4UtGgNWrlq74Ld9k/xSni71Un72Se+rZIwIo2U?=
 =?us-ascii?Q?gC35lal//HOjPpKgwFQI0/o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544303dd-1564-40ae-2266-08dadd6aee3c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:16.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtPteGimRnUZ1UQAJAv+k/EWK2ucamrBMf9579cEGqVNK4lYT6lgUHeG+RFTB3nT8bGEM49yA5hDUl5kdliOPr1Lx7bKVRhKSLUZVsnUmD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-ORIG-GUID: zhJKs2DIhVpkEkWO125FrWAgNELqsnSV
X-Proofpoint-GUID: zhJKs2DIhVpkEkWO125FrWAgNELqsnSV
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
---
 crypto/asymmetric_keys/restrict.c        | 35 ++++++++++++++++++++++++
 crypto/asymmetric_keys/x509_public_key.c |  5 +++-
 include/crypto/public_key.h              | 16 +++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 005cb28969e4..ca305ba1c0b5 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,41 @@ int restrict_link_by_signature(struct key *dest_keyring,
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
+
+	if (!pkey->key_is_ca)
+		return -ENOKEY;
+
+	return 0;
+}
+
 int restrict_link_by_ca_and_signature(struct key *dest_keyring,
 				       const struct key_type *type,
 				       const union key_payload *payload,
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 75699987a6b1..88c6e9829224 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -209,8 +209,11 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	}
 
 	if (cert->kcs_set) {
-		if (cert->root_ca)
+		if (cert->root_ca) {
 			prep->payload_flags |= KEY_ALLOC_PECA;
+			cert->pub->key_is_ca = true;
+		}
+
 		/*
 		 * In this case it could be an Intermediate CA.  Set
 		 * KEY_MAYBE_PECA for now.  If the restriction check
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index e51bbc5ffe17..3de0f8a68914 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -26,6 +26,7 @@ struct public_key {
 	void *params;
 	u32 paramlen;
 	bool key_is_private;
+	bool key_is_ca;
 	const char *id_type;
 	const char *pkey_algo;
 };
@@ -76,6 +77,21 @@ extern int restrict_link_by_ca_and_signature(struct key *dest_keyring,
 					      const union key_payload *payload,
 					      struct key *unused);
 
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


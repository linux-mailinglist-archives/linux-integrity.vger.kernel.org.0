Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3233645FC6
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLGRNn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiLGRNl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25010578DC;
        Wed,  7 Dec 2022 09:13:38 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GGo7q021939;
        Wed, 7 Dec 2022 17:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0uoolZ7T0lcvD0qUYicCH6I74b6nKpAuV95Xs82FtmE=;
 b=ngtQCcCR4S+BF86J2U71ulwD/iCiZaT/1tLbG5kdrKF4iaYuZEDjBQVvzp7rBGrj0Ag+
 JGUHbminHDED3rnb2tpBzaIyO5ulo3zHGrL5lG5ao4wNjP/NeklfkmkyushVcvxngMQ/
 KWnRBWBDfp17B2dTfWIya9oVEb/xpwZ2lbLitREOTuiW+ALODoO7cwC+2s5Q0JwJWob+
 VefF8AZ/8g0d63CKwyn4QmLoVsIeGkOBecJmevWRfYBmu/cpq3NDKhDYulzRRrEiN1xM
 pzqmqRvU7G/PFiDNrJwk0NIM3f7qjyXuJLMkhWn5w9iuAxTU6QkXg+paVtjZ4ubXSrTw Qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maubagw0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:13:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwNni001932;
        Wed, 7 Dec 2022 17:13:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7chkea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9xv5J+OxZRy72kWTJADJFKSvNyTVgPrKoTebtODZhioxu1hP0wcEVOY/Z2uLheJa+lQ6Cm6lDYkl2C62UeDbeKm8p5WCUgEnrXz1uQwwTntELtsRhxZ6Tmli5VeX7sBbsPfusVet1Ga9JeHPglf4ukfSurd7be9ZVJnKpDTGbsstrH7xMP+k0liQonIVJ9+BSdN/aV7BCgnySefHxcG40fo2Wvga1vSou6mjheEQ0D2GalYrnNRHAhLk1UZg+Kf1A58m7uRNw8L9iO+L32SE5X9ConD11F7qknp7cq1Xeghh3pvwCiMsPCCdBy0/NhLiv+Ms6k9MZYvAKSgg5Ag8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uoolZ7T0lcvD0qUYicCH6I74b6nKpAuV95Xs82FtmE=;
 b=IJmrRnyWFCFM8iNhh335r44ZBTbl1azQdnEPwqvogk59t+Ry6yTstmeTFZ4UBI9fcqRWW7SpZrtvuIKH20CDzW0llqKVqxibzYNcs4TsEgjIlU13ZJlmiUiT5Gk2tzg16Ssq65Nx41vKvgZI0JSmI/Aw4Z2ES14C4J1iZLWc1hZqWqXV4xPB6sxQoRjJP4zKrcYQNCxH3/8PkwP9J93mAt8z5ZYLddcC3Eykm3wxWjnn2VzfYZRlwBTrzYKMcwymzw4gnpIXoVTneIvDvlEHyOXdPhaIMTJPh5bl/Jc/CyajQNFC/kyydzLmnQK9q8k8zkLDgOMIusQl0jS/4WGQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uoolZ7T0lcvD0qUYicCH6I74b6nKpAuV95Xs82FtmE=;
 b=EkSIELPQr0gSyGeoIRG3a+n+wnbrWw2RqoAKrMKLTFcVDSjEbKBdAV443gILPQh2SNj5LCOUHNO1UbAs+qxAu+lp8xmwB4BNlxrgZ58P7wXi5tTyeb11xo8MSo2MxM6YibcvrV8VhcMGDzdjLLy2/ksEFSrMak94gFgjttKqq3o=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:13:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:13:02 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        bp@suse.de, eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 09/10] KEYS: CA link restriction
Date:   Wed,  7 Dec 2022 12:12:37 -0500
Message-Id: <20221207171238.2945307-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SJ0PR10MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: 289b7e4c-3c59-4956-309b-08dad8764c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ6kUpnv3pRho+DSqLUILYKEyYS5vJZJkehEIZax8mWxH0+85peN2JpJLbaBPWgThuEUxLOFikEXeLEBvS+nbaKTEYtc31T1qruWzkxFnvTJcMIHFi1mWxRByrTwKRPWYqQ4CLM/J9a2J1O7Xi5LstOAv7rRR5eoTgMfP9Py2FVGwM0TUFFy2ppCKWegUvbuEyIcqWaqcHHxk2byiSWMYzhEM5TnZp6QcaukMFJd9ZV8y1usqO088RRMXsFfvj9ma6M4sfpxgnVLv2b7RDIGLzdr+PF8PTA26LvZGoBzYr1uJBJ/sxvbd0NoqmBE3Yf1OvWef61zZjL4I4ljMk4UcOgKfdGtor7K4Nbfc88/YE1uaky3iV2DErpRGFNPuUZWEzzZZsMD9own974p+xDr7xgaZPxJW25t/fQH0mqIvyhq9PDYKqDtwTbvAGg7a2aCw/GLUpCQlGiRpwYn0rAzp4Fm2NLJJFmsFZa1vo/nUoPWAfeZUzicRBUNLUm+MIsjHrssWlqplUD0E1BCuemU37mrH/84UQmyXeWmiTHqo3et60LnE4hsGzramERubcRXKu/YDWlKLt0T6oGg0XPvQIvCoAtphKVoBlGkSclJrx03eDT0WtkE3UJC0Mnh+7rxrzwLBwgYcubxeTrF7IZ7OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(5660300002)(1076003)(36756003)(41300700001)(2616005)(7416002)(83380400001)(38100700002)(8936002)(2906002)(44832011)(478600001)(6486002)(6666004)(6512007)(316002)(66556008)(4326008)(8676002)(66476007)(6506007)(86362001)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKtrxOJbEMPzuKn0CunM29rDsb4wP6CGkcF6pREBqXWKVqqG682kKvbYrHCO?=
 =?us-ascii?Q?HNrLJ4iDuxo+PKFSh2biFe34BxnLoEwIWoieOj2WJe6E4IoYXQEWasGz9+z8?=
 =?us-ascii?Q?4kCvr3XnOpMjCdi3Jum646Zgn6wApL+UrslJu+owfSWOg2Pvs0c8MviO5qSN?=
 =?us-ascii?Q?U2A8kRDj51GvvHHr7eMsFp0yRxng1zAu7puxB4vOLaVMYTG7OkQX4pIa7u81?=
 =?us-ascii?Q?4x6/lMMlbmrACF5cClABC7FdepIge35iB41WGUSXFQc64mvkKcsojT7Ou1dc?=
 =?us-ascii?Q?dUlxf13T/s9Rn+jbcfY5kvlHUoZUPXYOMGrdk5trVz7SS1WeXwSUwg/lAjX0?=
 =?us-ascii?Q?+q8wjfzP4bUeHQABmg9BfCqGLbZnTbfAFSXQf0JL68Bm/SsURLNrfQJqdq3g?=
 =?us-ascii?Q?FdkrppC9vsB+YGH305ih8M9DKjv6ymaxLrEvlZia/lzrlkE7d3gavbBD7VO8?=
 =?us-ascii?Q?Y1lvqaAUhimaFETMdKMRAYor1SrWd32e6LHrHNf8SCxZp8OfM5kS3tMwVHHx?=
 =?us-ascii?Q?AHY7s1P5mgxcCN9EMiALj7c85BDvXTVTC8R95VIxoZsa1y4r6cdJPSR5YOrL?=
 =?us-ascii?Q?s/qBnHwmmsHli9QnwmcglxbbBj+ug3iE0a8Bm8cK1CVrby/fmBLokuGzd39V?=
 =?us-ascii?Q?BeH3l1g1sMAzG0yTUZh9pBGMJOYYfdRgg1O2KmhwJmpA+dsTWgN7UNP4MsF2?=
 =?us-ascii?Q?Opn0txoZzZH0CeIOlze7gSILDNFafEEoyBs5GYBpggqZLc0s29sSFaKOCxiR?=
 =?us-ascii?Q?tL4xAlUnxduiip9a0ahFlosvXUMiL8C5z347v9yf6qmBQldQq7aPc/C7O8b8?=
 =?us-ascii?Q?WO3gmXsFGo65SPhfJ/HizrDUJzKcY2Cj5Tuw5ceNMjzySU7DpvaknzVf7R0d?=
 =?us-ascii?Q?2UM/5pGZtO+3ynexxu1q2jfB1W0RAg+DkNuTkaj9ql355Qf/kiagNWHUxW/g?=
 =?us-ascii?Q?C3EaZivMHmwlWW3jJxCYU68dCVmAnJmtJKSnMGy/GVdXkU0y6w1RShSrYrm7?=
 =?us-ascii?Q?p4y9XKVmM6bGTfnCFj2GSp236qnzoxBnyvB9bJf8gvPmjgzCUix+6At3NLl2?=
 =?us-ascii?Q?OJWEcNh9Y839TIEyvzxyP2AcPuhyyrN/Mf4DeicBuK9lys3qvlh6m0fRtApZ?=
 =?us-ascii?Q?quNcN18X0tz+fYx0b6T7o1wcbOEDR/vCliQos7mUx2pws0yS9iLbs72z70yb?=
 =?us-ascii?Q?1UVtiV0Ht762hkxzqE5zJLWA1NGx6ZQB8aNabWotXF5h434Q/Sr34r0BW1la?=
 =?us-ascii?Q?Kb7NEWuO5zCJHNli1tKvdLBf5c+W9TCqGByLgByU3tiIlLrqaWoump8H0dDZ?=
 =?us-ascii?Q?NUYAKoTo/AQqhen+oCdwi2modOmz1b7kJRFl/ZIA/V+rN3ymmUg7J4TluvRt?=
 =?us-ascii?Q?aDwgwaoAr3UDLy0bcBHgXxeR9tZxRfT+SXlm5Piz6i5pMj7NjHglDXHrwpSJ?=
 =?us-ascii?Q?4YRckarWjsD8In3DlbKSMB236IC0osNCXRZ0As09n5bhm0WuAhbexAFNy0pj?=
 =?us-ascii?Q?I+RuzEfmUIwW8IdhKmucUnW3jNnQMpyAR78xyagJmf8y2pGsgKoXdkpYExOM?=
 =?us-ascii?Q?DT0NU2Lc39Yp0fLWJULrVeVuOktaTJ/euh4GfvdIDBLiDKLcET9X7ep+pgI1?=
 =?us-ascii?Q?NB6KmtD9TOVwIcRx3pRY3eU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289b7e4c-3c59-4956-309b-08dad8764c66
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:13:02.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMVwkQjbPRPuLN2yjuDiRlBHT0dKSbqPONmfCWMDbsA6newdwth2MLBUrWV6Yhgcu1foNAzUYfLu4Z+SggfRhArSbJk1NeuFzkSfMqJwhKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070150
X-Proofpoint-GUID: cENZ6DYbFNXsisZXzJQlHupZlg_xEqyu
X-Proofpoint-ORIG-GUID: cENZ6DYbFNXsisZXzJQlHupZlg_xEqyu
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
 crypto/asymmetric_keys/restrict.c        | 40 ++++++++++++++++++++++++
 crypto/asymmetric_keys/x509_public_key.c |  5 ++-
 include/crypto/public_key.h              | 16 ++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 005cb28969e4..ac0a6efafb03 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,46 @@ int restrict_link_by_signature(struct key *dest_keyring,
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
+	const struct public_key_signature *sig;
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
+
+	pkey = payload->data[asym_crypto];
+	if (!pkey)
+		return -ENOPKG;
+
+	if (!pkey->key_is_ca)
+		return -ENOKEY;
+
+	return public_key_verify_signature(pkey, sig);
+}
+
 int restrict_link_by_ca_and_signature(struct key *dest_keyring,
 				       const struct key_type *type,
 				       const union key_payload *payload,
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 7a87d5c0c32b..9c2909fea63e 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -209,8 +209,11 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	}
 
 	if (cert->kcs_set) {
-		if (cert->self_signed && cert->root_ca)
+		if (cert->self_signed && cert->root_ca) {
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


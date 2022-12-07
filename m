Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D11645FB9
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLGRNj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGRNe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9056445A2A;
        Wed,  7 Dec 2022 09:13:33 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDm0U010567;
        Wed, 7 Dec 2022 17:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=cJcBvKmduYyxGeq284aGZ/rzgPTabhLNcvrVJ8EglEg=;
 b=RFIC0Q9NaZb4wepix2ryaEn2v1wQrP4XuxhIkeUKmwDCawCgfWYFZo6vdg9d5VC9lpB8
 wkroSVAcS5F6cvIung2zvTwOPKtHCuL9DVr38Bn5t9RdsglH0qOzHnKigobEcbe5eu6H
 bEspk9u5f3wYCUS+OybM+w6tMIGk1G00k27lrO7HGOksE9kFrH6A1J+/aULvvZ6oxPJX
 OuVl5W36xSAZS5CGkbNpy2XmO9L2nZOMpcaeEhpnhqAoumcboliN57N0diWj1rrgjzbx
 MevhtQb6rjsbalfWuwiXQXyfOBCBfmcN5JYeGC20Rm9+q0jTIgk41NN/YDPKYFEitj/2 pQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauf8gu6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:13:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwN58021795;
        Wed, 7 Dec 2022 17:12:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8g1kam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8pxplFIRP8+AENa+yJmMLYt/eecXzjBXhS1FsSHdl/jSrr9kUXpXTzkGP9cK/X7JYp3u2XobuATi4/uL6ojZGYE2gMnpjxEEpLj6KM+igxKKrqrysmcrxVeD1tGKDaEZKdxJ33rUP77I6KzMlxyfzKqaZby7TznD9qRhStZqQK9z5Hd384e4OFb5Y7W8KDmJDXwHoXhwZON80/fnl5cihUR3Vk3L/uIbkd6VUnauoZzW2F/hFwT5u2G6xhdDCc0h7BBk//cUscENfZXVyjluul8BAcVEPFW+YQRZ636WMXs0yvw0qwpeZB4vlWdNWqaJPYqOAdnmjMmvkwylusrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJcBvKmduYyxGeq284aGZ/rzgPTabhLNcvrVJ8EglEg=;
 b=kflbYZyN3MW5fVDubJWlDZi8CXrVHW+XT037Zz7iFPifIwt6Y4SYbdLhsf3t2grvLdpVgBYGUukrko/RcsOqFmxKEhAl5yAs4WI8VOLFwQrLhCyyJB9j43obw1XjUlwhusTcW2lteTI1Moha6CMbF93xEZYq7vNOhJ2vWX82tZ2110yEhjAkBgu2sWUkfzpC8qbpwkescee7d6oHqUpU2JLKjfUquQJEWJg1GriB80Fa4MOfNOCfjCvXOVdq3GSLBSM5zW9H1U8N6b8rZEbGRX1eGin/sWKPWGnfP3Wb2uhB8O5qgadKyqIP6ebZI7hIy4FKfSVIQphZDHvl7a1cFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJcBvKmduYyxGeq284aGZ/rzgPTabhLNcvrVJ8EglEg=;
 b=txj/vbh83urzLWE7CPPtpwCxQ0InFPrvxNg9CfvWHfNc4scii9W93MqWFVTnsdRA69p2iDC24LjBUueRchFyJ3tsKbaz2NhAPuEZIHY7a6JEf80C4e6SHYQj9UOPu9EyyDyrcgefvxpSMuq8BA5fxrsGmLIeMkMAnhctWb8RPjQ=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:12:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:12:57 +0000
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
Subject: [PATCH v2 07/10] KEYS: X.509: Flag Intermediate CA certs as endorsed
Date:   Wed,  7 Dec 2022 12:12:35 -0500
Message-Id: <20221207171238.2945307-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::38) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bbc110-1938-49b2-6aeb-08dad876494c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfAWMuCK4gZePF2c7VAaVoB+4x5OjrmU6LfkDc5SfjEvvRT7LeqjUw+bJu3VCgBcskG6nAsZtVZc40q+dMUfvhcMjdEqUSXCd+RE3tXloHtK2c/hV9hbj8exQTIaeFbmteQ4Gyl0zMR+WMFECMDhscVZ1u2OhJP1u/pA1Yy3460b6p1cVte3Qh3mwlPeF/ykePyGw+2eTbuFu25TnsygYg+ppQuESDqdDZiy7CZ1plMULyAnBnPmhBls1Q16F8qP6eCqLD21sGjMiaCQFhptkYZNX7oX4LhN9sCnFT0pnjJjzGs6saVZzPRtQRVuusp+EjBtQ/amrtn8lNHqNnO1IxYB1IsJYP6JcxZ9H0ILh/aVo4/mh/tfSSuJReazoHawPL+jAg1NpLLWxEq2R1+STAjW2rh/ISbrHgjLhB6nFYGRBtBfQzz8yOnkUzkJ9zeM41uM5ZwCMt+M5FP8oKwzj5LH8VDXLmRqWkuxawRQZgyOBzJ+Iz44pmMd66bR1TJ4q8xRQ2OwnMieXEeUw9um9Uhg29es8HI2kOSZ+cCsVJuT1x3InNJIbg+vkuyS1VwEUAvlkbklpOLWkM9k0OBoYUrxBHo/ND9H5qXr0KqcUoaffaq9UV4od+vwB/WS0oqq6jmXRbeXizbTxaFcKx7eAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(186003)(2616005)(1076003)(8676002)(5660300002)(66476007)(4326008)(66556008)(36756003)(41300700001)(83380400001)(478600001)(6486002)(6512007)(6666004)(6506007)(316002)(66946007)(2906002)(7416002)(38100700002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jniyCXH7wQ6YR7fzrEkfilNLt4OCLk4dZ4qYwRl68Cp/JxWMbLuhp+uy5N0M?=
 =?us-ascii?Q?Xm5SOeZzC7fLGF75Y2WRvSO/fWZ2Px1MR6ju5AjR5vXmP1LCPCI4HVBIxv1G?=
 =?us-ascii?Q?xYK6yWV4j29iRv2IASX6K/4Ue4RiCEdzfNaK+sCwjefgcTTxTWBWf2HH9DaL?=
 =?us-ascii?Q?tlsMkcOa19Bn//VFN2HTmXhmdumD84E4VRtoh5da7OoiKIYUFVuUBsvv0/Zj?=
 =?us-ascii?Q?F7/UwtY9t/5lQw731JiQJbuvGI9WmEkH0sjH3SDmH18aFJhe5YnjVz26eNxr?=
 =?us-ascii?Q?mgVf4PXTFXQRUUrTwdX9Kc2hF0hnfp3ScwfgFeGh1ixqToAzAsoXquh2qZXH?=
 =?us-ascii?Q?oaVJcCQzijavIzB1NypsUDk93WgIdg0KzpFGYTb5/vHO7SKoDRHlmjccg0Op?=
 =?us-ascii?Q?Rb+VuzVUUfRlMOlB7PprYckyULdUKA5OWrxCZgr4oqu7MEyv8vMRS6N2kuoa?=
 =?us-ascii?Q?wMMrnqvZ0bGOXEo26A9vvhY/FCyldQPUvYJ/xSWRe8r4jTY/QphL6FbtDLvg?=
 =?us-ascii?Q?mZP6fl5x6a7pTFFEQvzF3MRYtsGLeo99tflmBlRvZhdiA1/tAQFWNuuefRz2?=
 =?us-ascii?Q?eABMQaGVHgVJ/Etf2rmsnP/VsfxR4Z7gUAduurmfJZ/nxWkVKoJqcPt0YDJU?=
 =?us-ascii?Q?SCdeDPE03S2DjVSPLHkmoHo0D4wgb8EadQWnOOlkF2Jj8lBpIlIEUUJkkmkE?=
 =?us-ascii?Q?AOVahg6/ODuhk4xWdgyCV0LG+3/9er5uvqiibm/tK7h2dr5m2Ux7swOxP53+?=
 =?us-ascii?Q?5HftQatsip/Xa+RUfuJRgv7K38qolV+uZmGsocayGXnoBYITtO8IcN8RXuPf?=
 =?us-ascii?Q?ew5Y50WE5Tn0d7P3IgL9iml3N3J5d55F2/wMa38SU2+YVHxv/W2+UmSRpwZN?=
 =?us-ascii?Q?CoP8WQuz51n3rNDYFIsO3osWEgpj/l4GDDH7cU4g0zw0IeFm39bLhetRiiRm?=
 =?us-ascii?Q?3LrUe1vPnVd6374Zv7sFOXsrVeg0Ie2KMkQhMDeeyFzphx7cht5LnINOzkVM?=
 =?us-ascii?Q?BGqme5G9oq37+yzsjj37564t+6PAM6jPiK+MDVDC/V2LgX2ynvIjXqtxnmxC?=
 =?us-ascii?Q?PuI3smrbaq13g7uHaAvPJ1OzKyU4VxxjayXjkWfvn341EMVHAZj7djgU8bbt?=
 =?us-ascii?Q?xXLUfGNeHwGBwLfHheaHycFHml/cMB+DPPUM23wf4/OyL9hQJod0P1uD62Gi?=
 =?us-ascii?Q?ymT+5jcsbf/WNVj9lhrr+skYQ4KD76xvjGOuE4e02HJ26wR6faCwcsu+agZf?=
 =?us-ascii?Q?xdJNU0BiacnJ9UUddCRIIi3Vi5VzwSOG+iFof1h+u8wR+6owrUgVSwYfoIZd?=
 =?us-ascii?Q?bwW75di8CflUgoPLRWtJ8qX8LmohSuoENoEHEw1NUEAwg20kmOqtLbUVmQ0F?=
 =?us-ascii?Q?/ZtO6g4PvGlX1mCe1hOyNhF3kuPzgBrh1XKVdXFbty+ZE5x8msc5BdR3isJv?=
 =?us-ascii?Q?k6n2nnLh6eLskvB+/Xi8J7ZFtvylZ61wywlRNMmx7VVkG8YOTGMfNjRbOkbM?=
 =?us-ascii?Q?gJoBlnUX5X63tyTdbL+sLx8J7BGuaxoPnW82IDgIjwd0YB1vCNDy2xvcH/13?=
 =?us-ascii?Q?BD0IfEuyDvboHXwmzLk4jrujTW/tCmmAA8Qcr3WfF5+nUUturXgDRKOFEQT0?=
 =?us-ascii?Q?sO+lZO6205VzJk+Ir7xW4Ho=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bbc110-1938-49b2-6aeb-08dad876494c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:57.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oTKpJhIdt0/WIo2aQrg/R90ZFSPb9njUIyMwoW4KIIEyeQ7VJzP/ue3c/stScsUX6Vybdk3OrE89xWPTHAwmlTUCIXWPoBrL0bVAB1hRtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070150
X-Proofpoint-ORIG-GUID: g97fKBleGDtj43k3nyx2M3VxJyZi1u2M
X-Proofpoint-GUID: g97fKBleGDtj43k3nyx2M3VxJyZi1u2M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently X.509 Intermediate CA certs do not have the endorsed CA
(KEY_FLAG_ECA) set. Allow intermediate CA certs to be added.  Requirements
for an intermediate CA include: Usage extension defined as keyCertSign,
Basic Constrains for CA is false, and Intermediate CA cert is signed by a
current endorsed CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 14 ++++++++++++--
 include/linux/ima.h                      | 11 +++++++++++
 include/linux/key-type.h                 |  1 +
 security/keys/key.c                      |  5 +++++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 64cffedc4dd0..7a87d5c0c32b 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -208,8 +208,18 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 		goto error_free_kids;
 	}
 
-	if (cert->kcs_set && cert->self_signed && cert->root_ca)
-		prep->payload_flags |= KEY_ALLOC_PECA;
+	if (cert->kcs_set) {
+		if (cert->self_signed && cert->root_ca)
+			prep->payload_flags |= KEY_ALLOC_PECA;
+		/*
+		 * In this case it could be an Intermediate CA.  Set
+		 * KEY_MAYBE_PECA for now.  If the restriction check
+		 * passes later, the key will be allocated with the
+		 * correct CA flag
+		 */
+		else if (!cert->self_signed && !cert->root_ca)
+			prep->payload_flags |= KEY_MAYBE_PECA;
+	}
 
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 81708ca0ebc7..6597081b6b1a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/kexec.h>
 #include <crypto/hash_info.h>
+#include <keys/system_keyring.h>
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
@@ -181,6 +182,16 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 						 bool create) {}
 #endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
 
+#ifdef CONFIG_ASYMMETRIC_KEY_TYPE
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+#define ima_validate_builtin_ca restrict_link_by_ca_builtin_and_secondary_trusted
+#else
+#define ima_validate_builtin_ca restrict_link_by_ca_builtin_trusted
+#endif
+#else
+#define ima_validate_builtin_ca restrict_link_reject
+#endif
+
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct user_namespace *mnt_userns,
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 0b500578441c..0d2f95f6b8a1 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -38,6 +38,7 @@ struct key_preparsed_payload {
 	time64_t	expiry;		/* Expiry time of key */
 	unsigned int	payload_flags;  /* Proposed payload flags */
 #define KEY_ALLOC_PECA	0x0001		/* Proposed Endorsed CA (ECA) key */
+#define KEY_MAYBE_PECA	0x0002		/* Proposed possible ECA key */
 } __randomize_layout;
 
 typedef int (*request_key_actor_t)(struct key *auth_key, void *aux);
diff --git a/security/keys/key.c b/security/keys/key.c
index e6b4946aca70..69d5f143683f 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -900,6 +900,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		}
 	}
 
+	/* Previous restriction check passed therefore try to validate endorsed ca */
+	if ((prep.payload_flags & KEY_MAYBE_PECA) &&
+	   !(ima_validate_builtin_ca(keyring, index_key.type, &prep.payload, NULL)))
+		prep.payload_flags |= KEY_ALLOC_PECA;
+
 	/* if we're going to allocate a new key, we're going to have
 	 * to modify the keyring */
 	ret = key_permission(keyring_ref, KEY_NEED_WRITE);
-- 
2.27.0


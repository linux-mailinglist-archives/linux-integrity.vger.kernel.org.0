Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A645645FC0
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLGRNk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLGRNf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B831745A1A;
        Wed,  7 Dec 2022 09:13:34 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7HAXN4003892;
        Wed, 7 Dec 2022 17:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=cTAomxXzPIDWsbpstlgHWraRKzhHg031SenIx2me/6U=;
 b=w2ISjhhu3AyZbHqVpo9RV+X7mfjVTOaBY5szpPrtBT4w3Bzjsaoys0HRx05Ng5A5pKP2
 JVIiU47CLOMi9wumkme+Q7yehEWxPTKzC2fnP98KYl7AMFPhQssGzieoMLDJiNkd5att
 TIqrz8LmkVedOCk7iAQILIQo/zegfWaKOdv6PM+3GrYvjWTJD909Z9of/nU0uuF6GsA7
 q+gwCvpicZN6YyrbQ/E8vhPD+IhsLDp2/+u74Lsb0ZMFQsehdQbo6uNw6Gtfh66VhwWc
 tCObmmZx/EcD+34GIh72IwAoPU4W8o3jbly5HOA23hGCeDaqu1Wvj7iNzTmN+NJ9+B2T 8Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6r0bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwbQq009733;
        Wed, 7 Dec 2022 17:12:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa69a430-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBQcBd4iaspt3/GW/ARgMmadX/OFhbQ/Ym2R/kwplwbiDF8oGQus2DNcZ4KFPJIqWlXKVgAVgjirdKSAgJxHsU5aUj0ii7PGI1vKkDhH6gJrLV7ZN0pjFqBvgJD31DN4PKuu2bEHMIA/U7NI9YgZr43Um2lvt0o0lqBY7x8D9iIYueL5Wc9gkK8Zme5/q7KAlLF83uhYUJBdvfirZmjWDSMEzd8iO6rZgAbDdEytBFA+idc3sM+5ZmGT5syDryQI+te8ikCo7ctfxPNMuAiJDVF78KghtAOvt9ESelQdq77I7iS4ppDMF74KTx1Nxo0RILk9VwEQzXUVmDbh+kYssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTAomxXzPIDWsbpstlgHWraRKzhHg031SenIx2me/6U=;
 b=YqqJcExiJo/mv96AHHH3AuSfICKYM+Rp4P/yWV93Vb/9BeivoSHV5m3J2hxjzQ8Ia/xj53PGP3ErQ3y4mhLdk4YSq1YR8jllg7CFE0GlgUzhXdo6yeoZcp1SL5pAHY0oHvu+ulptPY+pHnQZPcIJAFwjvhCzz6ZA+vYOqOB++Z/uor03ryNTerFFDJpMcBMDOrYO+J77ZvBeWlWKzddDGRvokAzhVIXqDh3hCqbTDKU8T0sBd0wcKL/RfTZFwO+//AuKSdGH02LNqsYYjGBdoiiEe+Vb/NHlr+TepcB2E9pvZBSYYfCMN5q39NE+Tb2vTcPPz+Jxdtnf+qJpjGEfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTAomxXzPIDWsbpstlgHWraRKzhHg031SenIx2me/6U=;
 b=xPqHhn4XAJgAOytd859eoRxk36YWZ3fY7EstucvXKE3IL1kZ7YaNjfyos1l3+yqNJIi6kOpWC+LuYLMh5jqir7fyY+PrCI9wOAzQ7DOU00bRp0vtW+WZH/aOQEWH8gbP4v/PsoTPUM7H3biO3hRjuhK9DXVXScgW0R+WqTrYZ7U=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:12:46 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:12:46 +0000
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
Subject: [PATCH v2 03/10] KEYS: X.509: Parse Basic Constraints for CA
Date:   Wed,  7 Dec 2022 12:12:31 -0500
Message-Id: <20221207171238.2945307-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:a03:100::49) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 526a0f8a-c812-4f30-4fcb-08dad87642d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kD9gRf9TLkYOaqFK+D8LnfeFJIpxUTSNsWgkPXsDE+GaQ9uiCzseC22R+QH6OvSO58WnBUTMsf7cOLBy+Jb1IfQClZ8sZbwADt1nBUt/6WOIBpu6tOzcaNXUo7RlFW8LqxKUI5wVcBdPG/WYjSLfnB394VOXbtHosC6xMCxUZcg1YpG8AXjgxXJj0tSna+Kkf0fVv1pFVEMhypBaH0zWrKsfaMMBe8kQetqECjlECGwuk5SfAg+60xODYu/7mqnIpkR/vUXTFJhxKpho+ybV7IDbXftOzXrVJc50vqTXJcu/B9Si2thIQ2o0lW/aBilNtn6b4nOd5A/Zmu2OzUT3M7JHLNHbdZuhbUWYwk/QDxRiiX3fEyGQ7kSElkuEktZDr4Pzbx9aJsfBfi9d64w/ZI4ojjyZy8TWCHYLugNONZG5ofFfWPXM5GFFNfLo6tRbnzKdJF5oGWqa40rzR4R8lGkCLYdlEt86WKQ5xZCwqbMgH25OrhUKchx1lgvP9TBK0QoWFeF0KLeirlJqjo9FCXwShl/Ra6XsP9KMLLxblYvdybsJ3HTekq7vhvDfZt7YAZTa9J9DJ0JDwWiNidCZpdc6g+jaTA4i9at4NkTFs3Pg3r6ODBQ6vi/R/T3dN8dA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(186003)(2616005)(1076003)(8676002)(5660300002)(66476007)(4326008)(66556008)(36756003)(41300700001)(478600001)(6486002)(6512007)(6666004)(6506007)(316002)(66946007)(2906002)(7416002)(38100700002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4dcpQU0qa30qZvT//wNZAUcSPlZx4oDRotHy7Ik6KNX/wrP/g/E5+QCaUKx6?=
 =?us-ascii?Q?5zc8SOxjbI5Ycs8aa5kaOmVeUxxm6rDB2cU9Vwzd8N//0hLIE0DHC3K/go4o?=
 =?us-ascii?Q?ikjAaVzDK6w1+udGP7KqZrVHeRBXFcZnAl1Q0Lhb8GfVlEOsDOZTmPqwUJod?=
 =?us-ascii?Q?k0BR/2u9aQ2u3oYNIOk9BYboAhsB/MtaOl06/nkbndTWQi5TUxj0p/Gp90Bt?=
 =?us-ascii?Q?KfACQugv1Qy8T0/KSFhd0cv8TPqey8f0VzhvZXuVF53lkC2w1x5VFulGp6yE?=
 =?us-ascii?Q?l/Sbqwba6CII/iRf6vnpJpqflgWLpolPOkA1vvaUvBNpeZ3DIg6kQjWJyGAR?=
 =?us-ascii?Q?rnEboyjozCJAolCkLh0dxIyil01Bu68oHvBwVnm0LeCoMMcFhjt2znGwVwTE?=
 =?us-ascii?Q?j606HCfX2DYPf16kBHLLYlMQwE+ZwCQqMUdog3h87GiQqnppa3/piY1NJu4R?=
 =?us-ascii?Q?HOcaD+cxxOmvRBWvR+tMyy9OKJ5KN1sxb145PJqvQXYkbKf+hATkY8FWOOLT?=
 =?us-ascii?Q?BZET7nJW9RisEczkuEkSh2mn+MZ4v2/vHrzA+qUvI7/VxTWfXFTNXGN6FMl0?=
 =?us-ascii?Q?muBphgDaIqvBM5caLpIXLaGUHdIJz/RinvOUvidMJ22sNd/dDB4Hler53UE8?=
 =?us-ascii?Q?+mq4mDf3+LCK2CW5rJjSOTnXnxJO7040QQriNzgr+BqLiYeGGPd8x8B5Qed0?=
 =?us-ascii?Q?cnGJr5cajZM6L963pHebVw126r8cZMKgr0jG8UQpesk4Hs2ijdTKmEnwZKY0?=
 =?us-ascii?Q?FUbgxtdAhg+R0I9TtRhNSjm5fVpQR9nagOCQq7Mm4qqEQdZLkJUmgBOTFMwi?=
 =?us-ascii?Q?4+bNLgxz2NnBeUusl5hjImmv/8tFIO+6Agz3O+b3BNeQ4bXAO1slPmXi7yA2?=
 =?us-ascii?Q?f8kmf8h2x09Q8wjjVQhE0bbzFTblTssWzRz/t7YznhMWIu0fnFtiFbKcxxC0?=
 =?us-ascii?Q?Ysi3uGj7XQGraa/9WLigbQdKb7QcNETX0sT6ek0exHa39CSCO12/ZJmXJ60r?=
 =?us-ascii?Q?P9iYzYbqMaul+r9BnT/wXI6+F+YWMN4Ij1xkhtn98xRJQO3CiwYR6ufdQOCB?=
 =?us-ascii?Q?zyxSxM5pYRGW62RbL/nQYz+tjoXdiaV3B/jBpPXfQfk6FCHFbJc6x6r4HpWi?=
 =?us-ascii?Q?73lKiOUUQ7tNkRPaSDj4szpLOEFCRCGeyDrtuusUgZJj15sX7g6gCCQFTgSt?=
 =?us-ascii?Q?nxGh1mRNJ+L64DGGuRj0n2yZnNYFt9XMsUyYkliYb+Hg1ifULl/lmxAbC8hL?=
 =?us-ascii?Q?Oq5nnz+toEFs9WwD8h7Ta8AjOnpFOGTyxFtuScNh6nQLduoiqv8B92ChVzwu?=
 =?us-ascii?Q?jZ0WwmapKf0YKdl6cV2fuTpqte1Jm155OwXKfeSf8VIDr6NRUIljTUaWL1NV?=
 =?us-ascii?Q?ty22qeYZyfzw2+y+vyKhNiUO++D5hC96v7xx1lNKFXE5h/9wnCTfAgykDDJY?=
 =?us-ascii?Q?lkrGtM32MSGgkvmXufQ4cCUTErnmArAJenuGPdlrhQr3Dtm56jQnhF21OPTe?=
 =?us-ascii?Q?jbR1ceV0AIH7ZM3kcOPn8YozroSpPe3wrzVy25GAuNUyrC06OJHdSVZDC/Ar?=
 =?us-ascii?Q?lEOeXPGGQDkQr+CG0geLgMhzxmdm+uZPC07LsxZcacXSuxq5escFum8bVi0E?=
 =?us-ascii?Q?5nNJSMY65HHoUDxGKGsEUYM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526a0f8a-c812-4f30-4fcb-08dad87642d4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:46.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pD9eiMVPtipuD7KFUxjjHLIUUujllZkMWJb4hoBwoICwTF9Fof4hTVJ1exe1KsCs52QlrHLPSy1az7TVQ/XrcvbLxLia+D2Mg1RJn7c6pDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070150
X-Proofpoint-GUID: 3mw1D3Rx8jjSNpf-axa-cZNA1FsU0IqH
X-Proofpoint-ORIG-GUID: 3mw1D3Rx8jjSNpf-axa-cZNA1FsU0IqH
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

If the CA is true, store it in the x509_certificate.  This will be used
in a follow on patch that requires knowing if the public key is a CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 crypto/asymmetric_keys/x509_parser.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 7a9b084e2043..b4443e507153 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -586,6 +586,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_basicConstraints) {
+		if (vlen < 2 || v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
+			return -EBADMSG;
+		if (v[1] != vlen - 2)
+			return -EBADMSG;
+		if (vlen >= 4 && v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
+			ctx->cert->root_ca = true;
+	}
+
 	return 0;
 }
 
diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index a299c9c56f40..7c5c0ad1c22e 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -38,6 +38,7 @@ struct x509_certificate {
 	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
 	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
 	bool		blacklisted;
+	bool		root_ca;		/* T if basic constraints CA is set */
 };
 
 /*
-- 
2.27.0


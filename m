Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA2645FC1
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLGRNl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLGRNg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402C45A1E;
        Wed,  7 Dec 2022 09:13:35 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7HAZpa003903;
        Wed, 7 Dec 2022 17:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pP4Surn+7FPONQ6L3YWLkQIdsqC6Al/UKkJByFHU0SI=;
 b=wYKLPL1L/3kLBgFR63K9k2Hydx7Ufbc6bUtmemkYFr6FFaLOyGYTsNlEXbTDnkkCWUNH
 EOB6r6RBnmZiXqaPW/9FQ47JzzBjjNLby+kkN/gxpKAsqO5h8xVwHauHHxPoyve38Wfk
 b2afPcRQOQBzQM7ntzKbgWx/+4XIOoADC4YRTWK+Nk5OVxipvICYSRnUrjRT+xAP2M7T
 Pbg0QNTPcyIp//POFYN3rj6b5bW1zQOHlO/5WTTNin+xAw4T6DVgXzUYnHB/BSMLdI7c
 Jum4ZLGbwGIP3rY8QzD/mVLXX08EB9LtHGt4F/Hmo9Dvkmj4E32DVk7GqFEoqZWyxCgn 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6r0br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwbQr009733;
        Wed, 7 Dec 2022 17:12:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa69a430-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arG6M6vlFRsjBDq4A9uFSdLD/eXw6C+wNdXBRqmvoOgMLQt+b7hSKt1Dcaf/1YJz4DjOGZDkHhIqUjoZ1ypl9gVye87kT8ccIIgIrBeClEB5xpJ+Y2l18A7+7NRNmwvKqx/61AvPdBjyHqkeuot9qXQjFkfkMwyUi9BlIDiW7xiZvo/0sWcx/zR/y2fpnzIWbBPEKkkA6YJBka7zAcnaOUUaHtK4HcsKA3sqxPRgr7F6BMw3QHyuGAEWH04/jwVgEiUmwyiZWUvPvryVrx+CA1bVojqE2s8Mw8/RoA6r/x9aa3E+PBU5FLM8HIHM0VB9guTHYd9/RA9SELdi9EN9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP4Surn+7FPONQ6L3YWLkQIdsqC6Al/UKkJByFHU0SI=;
 b=VLdXmWrCm5K0XpGS+dg5Pq5p8OyvloE1rgAVURd2KFzlpu3PxmRfBgWbMqHkagKyGcqbMBNC5Ygalk9eV7ltmkoGAuyHVipEpqjZc7sG0IJt4ldmcuG4DWWq5kXruaNLPrl5SKyKjX3OZbNmgmYYISlN8FlS/RIhbFs4VkAmRNDiY5WLi1sBqiYHONS2ZG654XbL3rT0NumZ58NDYcUzwdJZ5EU8uKcxjUyDice8O22oFND73FD7Ss+LQXyQXmemwyJurSQ0eqm56wWLHRS+94kOe7H3xJk7XqfqmeKnaLZjVGl6RvzOGXIazbuodks2xHraZl+xyOQVZ8J7WfQS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP4Surn+7FPONQ6L3YWLkQIdsqC6Al/UKkJByFHU0SI=;
 b=v0k42LRUf7JKSSP/KCseHZHRZA+bxM0Wpt4qxWoqlvfFNegsebf+KdIbp7aJ46G2eADEcqmQ/ksvzgWiMiF/NuQ7bmRLXoln/lJMdIhBiQ+K6zfw9feMWPdiWZVX5ecq77MJfzuAzzRKD1ydmRiW3FVzqlvj69PwHAU0U89BCXQ=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:12:49 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:12:49 +0000
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
Subject: [PATCH v2 04/10] KEYS: X.509: Parse Key Usage
Date:   Wed,  7 Dec 2022 12:12:32 -0500
Message-Id: <20221207171238.2945307-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcd3458-1e11-4516-98a8-08dad8764457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moWBXtvRk7i9GRDikCjnj9n4Z+MJgDNV9Cs6EKACUefIq7rT6ORelo3g21IWB+tfhWP79Zqe7wmtzhW/YpYQFF0YNe3T3WvRQtztScQx7EdtIt64t/K5Byp1z738Rjdv+D5YSHLNc793dJSlVK0F1h7oQLeZyBMP4nmudkfXJ+b46RieLHgQ+Nn9SVVTE1Vv6rleS2vEj7x6kfm/N4aE3JDf5uvBLn8wlxQ9ib/uWCDdVkvScmOYK9uVwL6eFcCrBbx9tO/pFSQHO8KMC+MiUzwrdISU5/1fGF5PihLRwlu4uVh7ffk5zS+etLgJcmMyPXNeXjGzEiKg8aPakG4SFBOsaTGo6+AEIJd0S/0HeFBxIRYFa68HtKsLj4Qn/2i1xXE7S7wJJJeuqiorjmigoW5JrYeOqqw1gN/0Nu0ag7zlGe4aFqaKBFTB8MN8H5m60LAGAbKicEldhltZwfRcEwwxo8Fi4Nq5OtMXhRuyq5A2kconRisnSzqhVObRb5vSOn5oThuu8wPTBFUUreorPijwaE6/bLGoWUTb1Z1qffwD8TnN8d1P7i0FzTb91Pc72JtvUtWsZ81D5yuI/78g9FG+JHiTxRPZAZyzC05OFV4mlbOaKn3XcFq3V986BlMNYmbbBpQ9aVsbMGaCn9MCrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(186003)(2616005)(1076003)(8676002)(5660300002)(66476007)(4326008)(66556008)(36756003)(41300700001)(83380400001)(478600001)(6486002)(6512007)(6666004)(6506007)(316002)(66946007)(2906002)(7416002)(38100700002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hGdPgk9Ay+YwYuXnl5ySCdsEjZREpYaMdzhyKkbUURzmVFLUfhCrxhxRopZz?=
 =?us-ascii?Q?WC0JmlPAT+Ccall2z8bjIo082x9aIfUS6iXuh0mgbe9Pal/dwBhUheBg7WWy?=
 =?us-ascii?Q?3TY+Aq9nA7NVcyp97plRolNIEECwI9eo3ZL2xu8mYXkDsXOWZBGzu+1xTeOL?=
 =?us-ascii?Q?M7lDBTLIpuCiE+ZHmAtgXDEdYCmld5pFeL9X79/FK+kJvt14B3BKK0Fd5bWL?=
 =?us-ascii?Q?9UryBq5PGWvm4Xhb1JBC1D4+BJuSSgvB9qo6Lz3yzbUqpapUTOsNQoToOj8j?=
 =?us-ascii?Q?wgGFd/38lbFloodFW915HQD95/2s0o7bCEL0gRPCJnSgZe0GebALTBXOutDs?=
 =?us-ascii?Q?HxA8+EoLrzPsDwveFw9bHN+HtRBlwUwJP1G3DSyGElF0w52Fgu/I3ffNL2p1?=
 =?us-ascii?Q?AG9KK2j3Z/6HqUsHqCkXQJ8CJfXx7eFCq3oS1H9qrlxR9BwgKoUo1xSClbJN?=
 =?us-ascii?Q?h9PF6aisrs8rd71OD1xnQf5Dm25awfcUzJ70PAdvylD2mHvr5Gov7FRw/dha?=
 =?us-ascii?Q?ESvrSK8U6rsmYoshloSdRFoD+f28EK5dkgzwYfjCkkJlsEfTaiYqOyKEyGeO?=
 =?us-ascii?Q?dQh+PC1tkDvN40iOYkt8EYrd5dDqh6P7OXWdSFAlJcDwd4cOw3Arcbwat0PS?=
 =?us-ascii?Q?uyTxeWqxtCbnuq7d6veY/o418pifvcx3TslepuaRy1FvWYS356z8JntSNnta?=
 =?us-ascii?Q?yHawTdV3IGInw/IPFzT74hTMIriXuiBCiBfiN8I6tE1R9XUoXQsiW+5LwDVf?=
 =?us-ascii?Q?pvphbgnmuHPVYdM1EuIuMujsCm4tXiXKwCaasXE0tT+pXGDxWzTRkCSBgeIC?=
 =?us-ascii?Q?QuolcZfqpGyBOeB7PwjWBHsW56zy7AWjAXai+OPgfOkkXFXfEtX8IvhzJhz0?=
 =?us-ascii?Q?Nr5KtZ6Oi7M7TCk4tPrGuq00ObJMaVnzh3pu9yATAWAw0i9r7FoH/VCGPiTE?=
 =?us-ascii?Q?nnBhnod5Wr6juQIvA4KX0D7cHsoah83i1/b5elxYfwT059e2Hvt+ZGwrg1Vb?=
 =?us-ascii?Q?1MtWrD/pbdZHho2yQVlxjtB02V00AZAFYfZvynYTTQBfmH8pLkbcD1ijliRb?=
 =?us-ascii?Q?tOshO5OCUlvGDS0yu3weDABe85PX8cMVWtKz37q2EiVZiCtqp+sxiQVU4dku?=
 =?us-ascii?Q?VkVlSt4eXXB5BK7C5RR+4O0O0MX67bOUxV0g4UzuBz3PXPhn1V4MbDxPAR37?=
 =?us-ascii?Q?IQKqyI3cII+IVSjMCJhe75/Xwwx0646GOiTuf9LxjHid+wpT1Op8KDAeOLRI?=
 =?us-ascii?Q?UGio9Tw+RGi1qXSf7wLk6zx5KZ0fyUcAULauAB7LEowSpYOb0XNhC9WjbkN9?=
 =?us-ascii?Q?nJEpj7OwcJsv1GCalo7UnzlyjUy3Alw1Ghn8FkgjkFPJsBjw4aVNEIhX2r0E?=
 =?us-ascii?Q?O9Gcyt+Obx1dLbf05DrO1kNWSZis2gmnvOJKs9AvmCeCvG0gdAtep4OwwTHx?=
 =?us-ascii?Q?5NfIAN7imiXmjqtWHIRgcDtplgL6SEUmxe/G8nXKrxHvI+xPq1YaVJ1KTsf6?=
 =?us-ascii?Q?l2UE+1BGJAhl8iY4AGTmI9GztLjkmVHWTigOiUIaVrBqW5HeXQW6P5bnXFnE?=
 =?us-ascii?Q?QxoI8ZBtBV9jydmOj2PIUHp54domzAbqbtjBOKdS97n+41CFmfqReLlYc6jo?=
 =?us-ascii?Q?KMrifVZ4xvClGmxN0Vyq7P4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcd3458-1e11-4516-98a8-08dad8764457
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:49.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy1lZl96TAEjT8I57doAlm45cff8Og/cyclWSj93pKkcjuAvx1iwhsoMdn08uvrL6bOi4gUz5fNpqn+0zSff1MnapcTn81ihCPU4/imEuGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070150
X-Proofpoint-GUID: rkLOYZGQAMvLc9HUAf4quPYhdDgHgpJu
X-Proofpoint-ORIG-GUID: rkLOYZGQAMvLc9HUAf4quPYhdDgHgpJu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Parse the X.509 Key Usage.  The key usage extension defines the purpose of
the key contained in the certificate.

   id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 }

      KeyUsage ::= BIT STRING {
           digitalSignature        (0),
           contentCommitment       (1),
           keyEncipherment         (2),
           dataEncipherment        (3),
           keyAgreement            (4),
           keyCertSign             (5),
           cRLSign                 (6),
           encipherOnly            (7),
           decipherOnly            (8) }

If the keyCertSign is set, store it in the x509_certificate structure.
This will be used in a follow on patch that requires knowing the
certificate key usage type.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 22 ++++++++++++++++++++++
 crypto/asymmetric_keys/x509_parser.h      |  1 +
 2 files changed, 23 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index b4443e507153..edb22cf04eed 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -579,6 +579,28 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_keyUsage) {
+		/*
+		 * Get hold of the keyUsage bit string to validate keyCertSign
+		 * v[1] is the encoding size
+		 *       (Expect either 0x02 or 0x03, making it 1 or 2 bytes)
+		 * v[2] is the number of unused bits in the bit string
+		 *       (If >= 3 keyCertSign is missing)
+		 * v[3] and possibly v[4] contain the bit string
+		 * 0x04 is where KeyCertSign lands in this bit string (from
+		 *      RFC 5280 4.2.1.3)
+		 */
+		if (v[0] != ASN1_BTS)
+			return -EBADMSG;
+		if (vlen < 4)
+			return -EBADMSG;
+		if (v[1] == 0x02 && v[2] <= 2 && (v[3] & 0x04))
+			ctx->cert->kcs_set = true;
+		else if (vlen > 4 && v[1] == 0x03 && (v[3] & 0x04))
+			ctx->cert->kcs_set = true;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_authorityKeyIdentifier) {
 		/* Get hold of the CA key fingerprint */
 		ctx->raw_akid = v;
diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index 7c5c0ad1c22e..74a9f929e400 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -39,6 +39,7 @@ struct x509_certificate {
 	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
 	bool		blacklisted;
 	bool		root_ca;		/* T if basic constraints CA is set */
+	bool		kcs_set;		/* T if keyCertSign is set */
 };
 
 /*
-- 
2.27.0


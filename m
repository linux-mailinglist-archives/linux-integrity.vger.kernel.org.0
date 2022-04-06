Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D254F5D8B
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 14:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiDFMEI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiDFMCu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 08:02:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD5435BCB;
        Tue,  5 Apr 2022 18:54:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235KPK5u012575;
        Wed, 6 Apr 2022 01:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=o/zCn4Jl8NCicvbuQYM+5Tvhf3dsxlMVqbRsQbSVVNQ=;
 b=SikcTHpaVIu80RSMd1iP1936FhueJoyNAtPMSfj2I7tNeVwD+Ilv/DC58nZVTCM50zM1
 KU2kLD5vb1XYHN0yyLeab9A3sWuhsQr8SNJW00A5OsvQ0aBt8/x7uU9N7jy1U53vYCrB
 /EqmnGeA1PSsS5+OQJyMGm+u9ZN66AmbSaZ6ZvsfN5LiCBPwg/gkFuN0fL4npWgtv6T3
 4ObqjDlVhJnWGs/qwgmYXuDMVXId+wMRY4jTKw2X5iXo5Z55BGLFKglzN0Nklz4Pmlfx
 C89kvtQqlgEndMJwmB4L1eyUzUbCMpKaSeOXiw1Xxa/2O+i09kwqdsL1B5xU+xHVN7hf Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcfdkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:53:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2361oQGB003487;
        Wed, 6 Apr 2022 01:53:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx42aen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/TUjZSdTOP1FDRQ05xKs2CHfVvuZQSsyEHCH6jp6wzutE24gIsBb1NL2NKUQkx6co/MMrJVLfGlVrBz77pp+VukI83s5AnEANhNDf2z+0sqfghKvM+ksV8LwDFHfCmwbit3XsfhOsbzzTOTWMrkcrDhNVMt8M+8+UrZesiEr0UvvWH7CNHIZAJEJVF59q+o4LYahepBoO8/eEEKGoIFJft2ABSNe9B4WJmUGCZ3MzilMspD94w1NUKlK3hZJ5AuUDHqqMTtXJKvhedghQm5lOhpxg0nmXeb3beisBEld+7QQCAPbRma/5rz1sUGC9aPHpVAqdvFKZ5sPw68X17Ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/zCn4Jl8NCicvbuQYM+5Tvhf3dsxlMVqbRsQbSVVNQ=;
 b=kdEgeuWGifVdck/CG6LVZyORq7dMJAFgueuPrhrnXGJ+Q0lv0KvQMCQhl62DmVfmia/bTfQDE+s9z882D5QaVfFQxuTG3/r62vXvDasd527G0ITAiq0i0o4xuZEnIIHcsph0ePbneVwUcHO+KZVYhwqOmWn8jN/lL7r4GfKCIleCXbT8bv8lTpAMIIXvDpm7peTnBWVQAiguTOH9M95EiBBPnvyMvW/t+AN5l+9iAuU5HLjZC7fccwg0S+a0Se45/wvgDbweuX02Ku3UFzWLv+T7WXQgS4sHHyJmtG98aeKVFjwSfuuDtt2TWRLnAUReixyyIQ4wRH3VhlTDAki52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/zCn4Jl8NCicvbuQYM+5Tvhf3dsxlMVqbRsQbSVVNQ=;
 b=XlLHhGpYatyqzYgFfxHU5sMTjOn3lzihE50mpqlHatQIK35b236xsF2NRcbD+iE3cb8AOElOtj2Wk9W0jNw/UNyewPJeoeCsKJ6ltckm0aZM9BPkrU/2hdgt73JyyFClz5nTH+sAEFjKWExm2t6aA6exDBmmrvNg6PkNIaMKgjA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:53:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:53:54 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        eric.snowberg@oracle.com, pvorel@suse.cz, tiwai@suse.de,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 2/7] KEYS: X.509: Parse Basic Constraints for CA
Date:   Tue,  5 Apr 2022 21:53:32 -0400
Message-Id: <20220406015337.4000739-3-eric.snowberg@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17d64086-39c2-40d2-2ce8-08da17704dcf
X-MS-TrafficTypeDiagnostic: MN2PR10MB4349:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4349C2A069D0B4BAB091579E87E79@MN2PR10MB4349.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYsslyc9ErXW2BYYAzZSMwf08sehVdEk4qewNb5K/+883gAUbBGB9BaOAfpgsr83rxQFRm13fpr2NEiKxyUCzb5WNSQMOH+KzrvMybzIs9HQyzjmdvOs+Pp3RKAPm8vPO8to4+HS0H3DHY1ecCrbi8XHY2YFGP+j6CZmOCeyx4bp7tVrK/55ql453PX3/jj9fYEe5sZWLaHFO71XRfpI05dGlODknWsEqhJvRDXXOg7KGt7tJigRapksNEc8WgMA+izZouH7eCU3Q723gaAFkdKq35OiThLMEXIBkTkVHHpOn9NEQb6owNXhE8/r4nJglDZSsEanDhQb82NbqdrPCickoZfxBVKJP3frQezw4RNL0dDl0hirYuUTmVpD2QgCjyj7A58Kq47BrY7RLX+B1Aa/yebwASqAe1pbdPDuFh/J2aoZ2dtYjvZ0rD79CtUrmkXIdWN2VzqThm1ai0hG28WHv7M4m3j11vNg1kQ4Jr/3L0yrpB9pRa0s01yUo1I0RoP39H9AG0Ha94horuWioc1xXGsFBaMuPw5wWM1ZR9B7It55/P1k+mVPdE0NJqe/EmygQUD6rUGyfY5Qw7EHU+EDUQDYT1Uh2Jp61PxNtt+Xlb8NR2asZHXECWaaINHYfRseaDze6ANzhmW5lAVjBZFIkKj3N9TaBut8CytY/OErNeEt53Wj8I8QHWQDN1x8BAFtrgjh1NjDNleURTaVbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(6486002)(6506007)(6512007)(6666004)(5660300002)(508600001)(316002)(4326008)(66556008)(1076003)(36756003)(186003)(26005)(44832011)(38350700002)(38100700002)(66946007)(2616005)(86362001)(8936002)(2906002)(7416002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XamT7qH1du2lHNe34eNZbjNoxnxUab+Hsbj2Gk2A6jZZdU1G/CnmoouTpAeE?=
 =?us-ascii?Q?5qLmJdJ3LBcVfFnhud8L87W+hONJAdj85tbPnzRY2yfj+4d4y47AkUYGjH4o?=
 =?us-ascii?Q?eLwCpR9wjW0Me2DR9mtGAFUj4MnWE/fKtEu1qx63aKFkJAmZjGydQBo/lSF7?=
 =?us-ascii?Q?Zz9sMLgDNUW4EElhByS8QbmIaoGE/a9bUWQII61q0UksrrDUzMIhhHU3r1sH?=
 =?us-ascii?Q?CT4ELEd7Kn3D1hQrhlPq0+X0Rc+MquhUaL8HdwNn9OekNa3/vMZOHef1ECFo?=
 =?us-ascii?Q?JuxVH8Dex0vB81t6wXODNaGpd+6H9IEEzy7avlAWiSjToAAba8DXYtVngzog?=
 =?us-ascii?Q?Moke+A+VChwDhUzyCjAznmvhlazbTyUFtBk3wmEDDKl5SnKWBYjpAKduyDwy?=
 =?us-ascii?Q?XRSkhw9+zPAy3nzP4CnXURq5O1OA5CrirepQsjeMgRvSYxLnDHWtt05ZkLKA?=
 =?us-ascii?Q?25MTU+K+8825d0lWfHqdpa1Sa+DQEtYVMFXl1wUwc8zOYzbjIfs6/IGRov9g?=
 =?us-ascii?Q?atHTIlNc1m4Fr4+TBoS9Fnoy3tuDx1iVm9EZQ0qIXkWO7o9KsvosUWE1MAwf?=
 =?us-ascii?Q?qWHxtwghRPjmx7fTOHbtv3XZ8VT0ZP8cBso+tjNDq+J4ARiC8+ipHDUYyNMZ?=
 =?us-ascii?Q?0Bo7peDLnXCTlLBtq6iJHeQHmfh0Jr1pzmUA8LcMER3X97GT2c+uPfK6RAyv?=
 =?us-ascii?Q?WtHysja44mCaLt6RakfcPDoKiuP4DJG8qewqQWWKuqAEm6L+ee62EuJWJKBM?=
 =?us-ascii?Q?ELx1aMxMQGraAZCR9Fgc+4sH292+caZmmxnLpb41DDDoU0AVMC4cPEN23Rea?=
 =?us-ascii?Q?oIqjavi0aeE912kUdAOrWrp22TrjNgg2VMBzvOwGRCc32RG8o6gL/He9fhKo?=
 =?us-ascii?Q?tpliH+AV7R6+PwDDMH13LEMgeFUS6IEgyWVgpOiB9nrnHaCXcPo4MGaX1TIJ?=
 =?us-ascii?Q?7UZ0wSdKdqxO+GWZoPi1IWXWIdT/RMbOTvIEnMX3LVVY3B4POF6+ZIp4wqK0?=
 =?us-ascii?Q?7X3Nci0IeIpEdxl6R9Gjs/KIto2w7vb77xpVrAvQ68ULYOv88TRvXuEYEu0L?=
 =?us-ascii?Q?c5fCi2D9dOhN1GBvKUF4ggBYs4V13iGTg1fYOiOQsuiwOph3JC3mkD96ZI+D?=
 =?us-ascii?Q?3ev15Zcaqx2+nr+schu1WCJP2H4UKDoJZBWxlWJbJHgQOvcSMnQUj+57g22f?=
 =?us-ascii?Q?wX6Vgli1L2QW/XV/WcztunqYfzI6CtsPru81Dikjch5AriwPHGDFgn2gfa9q?=
 =?us-ascii?Q?4u4XB55tV31ezwRNF6KJXnMHiSqSrtCGQrPhMl5uSYXH1UnuaVCWmSwoCGg6?=
 =?us-ascii?Q?bD8UMmtnwFDTJWLpkw3ZpVRLMu1ASIQWaY2u0YbJ3ZAdcOwOS37clbpLIaYC?=
 =?us-ascii?Q?IBLjsUXLCk2WC6fSmfYy7Yg5XXDgjbFywRJMs6K/omZ15gi9WyqrU6t/jcus?=
 =?us-ascii?Q?Zk4RSLoKbGy12hTtzflH41YJ7yfsFRZoXWa7VQ53tiqC42xWt1Q8axKJJICX?=
 =?us-ascii?Q?+6ZDclHeyzpJAVDnirt0J5ZdVenlYZbf/qtEFxRTGX5kHzR6n/tpD0IkPUFP?=
 =?us-ascii?Q?XFESK1IlTGefRk9XQ6B46vF5o00NGiFu4PCHuVScQnuhGw1IvvrYHZj4iMim?=
 =?us-ascii?Q?myq9vkZ3ODFbdndogAVackiRSncLHI9u2D7mK1heVsGe60qGlN0oFaSG6EL/?=
 =?us-ascii?Q?aXgTEBWlBFiCtUiOj+AzAMnfOI6D3F0JHk68meV3xYT8r0acGHj+e+uU4467?=
 =?us-ascii?Q?CiYlz89Ymt9pp2ecdchXpfIrNRRcPg8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d64086-39c2-40d2-2ce8-08da17704dcf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:53:54.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y++nujo++N62+T/AzVcyPixYyT+HPtsd9Puthhl2deguIRWQfBxvnDxPPchnSp/DWbFNFpEkLYzB5e6G4vsw+ndBfAv52bHX3GqgZgWaplo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060004
X-Proofpoint-ORIG-GUID: e-rJVk0NhOkAdxtOHzD6PTnpE_4n2QDT
X-Proofpoint-GUID: e-rJVk0NhOkAdxtOHzD6PTnpE_4n2QDT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 2899ed80bb18..30f7374ea9c0 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -583,6 +583,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_basicConstraints) {
+		if (vlen < 2 || v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
+			return -EBADMSG;
+		if (v[1] != vlen - 2)
+			return -EBADMSG;
+		if (vlen >= 4 && v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
+			ctx->cert->is_root_ca = true;
+	}
+
 	return 0;
 }
 
diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index 97a886cbe01c..dc45df9f6594 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -38,6 +38,7 @@ struct x509_certificate {
 	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
 	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
 	bool		blacklisted;
+	bool		is_root_ca;		/* T if basic constraints CA is set */
 };
 
 /*
-- 
2.27.0


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA79164C147
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiLNAen (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiLNAeh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42361DA79;
        Tue, 13 Dec 2022 16:34:36 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNrUm028189;
        Wed, 14 Dec 2022 00:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=cTAomxXzPIDWsbpstlgHWraRKzhHg031SenIx2me/6U=;
 b=klcPyIIClZucSom2R7BEAPIXxkfz6JldzSW4wSK40uNvguy/MvRhu5aGtjOQrdBds4DR
 qbySHvN7yUrFmEik7rvc2jPiR6MK7inYmf8ZZcC2D4f5woMU7HaviMkOFvAgYFvu4bH+
 SOVxmV1ZijvrpDbhLFvWfFbTYShfo07xCItzw8e5G48ORgxH0FWu9aJvIYpyoqsbs6Fm
 Fn+JS942U2vgmwwr4kHoVf/D4hGDsWoHqCNExVvSBcVZEIcDmXKxkeeEwDbocp0D8oZA
 waUbS6gR/aJ/SrdBaJwu35XJAum7RFvGwj8+HMFff2EHow5LsMxFy2fHqjtI1G3E7RA6 WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu0p8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE01HTi012437;
        Wed, 14 Dec 2022 00:34:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyev4sg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4N+uAnj3cbdo0Mgj5t9+IkeTkoVvjLuTcZMkvpkSpbVF1FVNs6yL2oC3UTipofkXLQpOpH573lkfUEpfwm4+wA1Ut42lQvBUlSVJyyELpcEAkURFn+8mxf0RrpZnCclX/ZAWpAtLCb325NN/vm8rg+vTY89PNx5Q8XpQfetQosgLbLZk00KCkSCA0dljy/qpgdJsoEwBntks2bhkyXgKOZk4cctHMcPkh08ShgdqEBhcN+zE2Vnx+Z2MwUN4JT9cnNHwTsAGIjAenCvLXb58E//MxwaK9xPQ9H+g4QB6S3pKjaJ2eDCJWkUNqMYb41WWP6A7nfqkauTZswh8IPemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTAomxXzPIDWsbpstlgHWraRKzhHg031SenIx2me/6U=;
 b=JdnFnenPfc63v8MQeXR6DQbg4ZRIDcZo6EcbwFwIBelA100Tn4nBhixdM4hUv1NnXto4ZiRrCUwuebO2OKwU+p6k58oHXUUlitsReC6Ym5cMyRXmELCd08Hko7XHu6KDthM5/LsUDC/8W8JrHFaSD1PCNq4n044v4qX2KVcoOKFoYLfdJpUjGJM1oW7SmDU62Cwpg5HPl6XIrPe70oEOGI+Zlle26tTU3P4BiKQy2I+JRsYO/cirpS3dq/D/0eLrJge3IEca/IPU1lg7eo20O81Tnk70GciCA/3WRbqCm7TmD+3FNZ1PRmZJ0B3IxvMksYyxDjqbebwtGQMO1AAOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTAomxXzPIDWsbpstlgHWraRKzhHg031SenIx2me/6U=;
 b=UP+/jRPQkSuTf2fGFRMAlISgAEIExiDeA3JtUWXku1BWg0Qn9XoiweVQFUHa+XwxEF9Q9jt04c1EHfxbnCyJMZ7kf3d/1Y/LnjKN93VJPb2PvJXQnuXZml/sUVDt17P88yOpuF15Vcy3wRmIc991IXEAk9myxaVGVXrvaJBqqzk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:05 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:04 +0000
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
Subject: [PATCH v3 03/10] KEYS: X.509: Parse Basic Constraints for CA
Date:   Tue, 13 Dec 2022 19:33:54 -0500
Message-Id: <20221214003401.4086781-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a47f8bb-17f3-468f-0416-08dadd6ae785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nK6Navt0iZJiJaIZdSxMWkWIS0nEyN3R5dSphWwODnUflmkdrTtqnKA2L1EfxlWNNducjVuAjTEWbDaIHQw+zqzPse5E2haFEPj+1UXXbRW3R3CC/g7niqB0V3APCJXvFMbyL7vh35IAu4Kf5ZlcEjUMQqhK21xjN++L9rOCXIxZFHMEGY/brP+vD/EJLHUS1kot6UML5ORfOnxGmfD31xqmIWXIjPhRuyRyz8DNvuKRca9SZLYjlp0mdJ0nXJFQWnjl3N5dplW+pNGdIra1i7Myuoy/vTdEMJgImU21ZM9s8hBXoNKztavBBulVVanAqM16zjFp4/QtRtZuAOdyD9xHXsiHWZRpwI+xY53Vqx7S4lNGIycPhGflE4CvBWeMcu1KKruc6gtBlNBagmj915hUptBwr4pzyfKt1IcTQA/f95LkXQElGvEGCTfCICOM9jlny6eJo/p/wKG/ryTQShaKfpBbmuboK2RwcBjJPcnJEM2jBILr+RZ2Bkt7zutoNS+TGb25uiNAba2nEWi9nIff+/t9UJICH7DCHAqkD2JRIAcVWzIHNeGG/h09Lr+jUI/b3GKK40gCCuO5nfcsM/vtK1C27mQyNIrOMRalm8XgU2CZWUxshVpRj1ayk3ANvST3VQVC96/QXq+bKjmIWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMM+MECEqXgIJgwuWUTKV168Rd7q1Q9SGWVIoRxpLSo5OLjOVjzTRRWpCBdv?=
 =?us-ascii?Q?LJJgn7LGP7DE4kw7vzGZRLqWYSlMTmadgrjy02wohHrX+ixIlOBm/+Z3rjKM?=
 =?us-ascii?Q?jO+a7LNcFEnI9u9DkAkhKVs9jQdF/qmnwmoGWPM4OnuxE65nvd9L7FfFma44?=
 =?us-ascii?Q?rq7dJAbNhUOevdHNS767B7ROQil5TCAcp8UhRqUlZaOuHJFz39iMXbZhAJDX?=
 =?us-ascii?Q?W34O3CREtUEKl6Xd4mq5U0Ien74uXORDVnA8gjD88XeNkd3WFDRaFKHM0/uv?=
 =?us-ascii?Q?1J1TkFujnDS4OcxS2go5DgDnUmzgAKnIGKUZObxtppb0tviRLTR4+6Nn3G1i?=
 =?us-ascii?Q?7qWXwz9t7Nzo4HZk6IpSlIaAPQhTCj5OGXNfh0xBEw53VpNrPvnxnL6r/1iH?=
 =?us-ascii?Q?zHXXm+vLvdj6FTB6HAzSm6L5yC3KBpZLCFoGRP0/qPubPPY2jAbcq6gixt75?=
 =?us-ascii?Q?nsv2WOYN0UFHJtllUnILhKMzrKB10FL/zjYXQpJoxveCdQgHu6jhOTDxGd2R?=
 =?us-ascii?Q?4QKEVXsEUsrkoC3MKZSH1dgCpyEbxtRZgcx/7d9wCME8qB7IfGN5jhmBJ9ny?=
 =?us-ascii?Q?PgCTzSw0n4vRKfRA2oY2aKAxn7L9HW219xug6Ezv/rPmJpkDrsbpdzI2yB3o?=
 =?us-ascii?Q?t+o5V5Wccr3jqL1ZA3vx9oz74+mDz4m0/XfNBXgfYw8Zcz8pzEERQLG2Fg9G?=
 =?us-ascii?Q?YSsLwnokTvnXDKxs2mJbs8CCrfAhhej8p+PhxEdWm3wQzqoN3VOSeKIk47qx?=
 =?us-ascii?Q?Y2rpjUgw95/+C8xT4/8kGdJcvmrsgT4xtRor4Nt49uT7StSAyEkVXJBCo2Eg?=
 =?us-ascii?Q?H1s61wpxctXxeI7HqctxWFb5kbAipyvPbKqy739hrZHVh0optlyr2TveRqc2?=
 =?us-ascii?Q?PPtsze+7SkORXZhg/T/S+PBV37IjGtZJWVITvEfuHavosYnhVw3yR0eSMfJ3?=
 =?us-ascii?Q?F1LhM+8IGHSBT2SA70kNDYEPgXlCMfRBPJuCEyDRernjsrvP0sCgzJHtReTe?=
 =?us-ascii?Q?hYx5GZEpYXjQpS+TpK7pcIRxNgvjGDKgfpTRVWJ/HsVdDs1klWUKptA4voi0?=
 =?us-ascii?Q?NqzUznEq65kwGczXXuhkGsNLbU2Jh8n2LerTqB97QEWRVBgn4Klz7fuweQJr?=
 =?us-ascii?Q?Cai09CKzt52nAzSAHSIchCOJ+lipWnncucBrGuuGcOdvfTUZeggl2HhTiPlb?=
 =?us-ascii?Q?4s4zp5EpU7To+qYrmJlY75sUgNUNcOJx0JLVcRpyM364wtaJCnGpPDLA0t/p?=
 =?us-ascii?Q?xKgf4tlMGfOLvVNr+ciaE1m5UTJQzttpZ0TRutlOiP+DPwFteQbnbIMlMl5U?=
 =?us-ascii?Q?hXepfzgHkZp2fuitolGo1jK7l2sskKXFNRAJUc+2sU44a3VQtMS8oqvW2ggO?=
 =?us-ascii?Q?3lWA+NoIDnzbcUp5LYtZvN/D4dHkjvsI9d76kwKmbZkGG8uOlp8Z9Tl+JgHj?=
 =?us-ascii?Q?h3JnGGq00M1Uttr2pgcIku+M7elHO7swt3Y2j1r+Kwf+60DH37XNENLgkcow?=
 =?us-ascii?Q?2t7zu/0S30//hG+bopNXyCqII+3REH1mde29YeohOhg3Aa5CMID8DSP/7Rbc?=
 =?us-ascii?Q?3XkdafY/ODSMDyN7Ui8ddqsEOB0Yg4AJOMv2WhM3kYjL0NQE8tjzGy07cbLR?=
 =?us-ascii?Q?Xhgved8xSAA/4DW2G9JUFKY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a47f8bb-17f3-468f-0416-08dadd6ae785
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:04.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVZm6QoXsZBLNVOzegH+yivmniSYypsHBPyMxYLDDvR+iyvBt9hsjCoqI/SAatz2yBi9/dl2lS73K0gB3uSJ3VPbjNB83PlpAsjItWkZCNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-ORIG-GUID: ZfxX5ZQhCLBW_gpxjKA0hBQYi563WrY7
X-Proofpoint-GUID: ZfxX5ZQhCLBW_gpxjKA0hBQYi563WrY7
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


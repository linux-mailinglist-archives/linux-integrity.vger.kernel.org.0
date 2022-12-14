Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2564C12F
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiLNAec (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiLNAeb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47E1D66C;
        Tue, 13 Dec 2022 16:34:30 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLOC2F017254;
        Wed, 14 Dec 2022 00:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8W/vlhZb4o/bmF4homKSxi+DQTBL/EgQDy5hpmLy634=;
 b=kEzPBqlSeJ8p4QZs9qLxhspdgWTwXYfVKF/NlG7+09JcFZZ4Hsy6FlOp4qhmjP6oX7I6
 cQ/JXKfhfht02KsWk3d+lZ3XCBdHmfOyN/HUr+lzNMCh86afc9gUbyTSB4rPuSybIDT3
 lfiqsW9ecwhxZsytXqMjw4GjDkpPc5yKCuJQ5K6Iz97XKemI+rvjOnAiTF8+XFxRlT+o
 2Zu2IyDLU49jsGI3KSwB1nXMWU/FVGx3LSpG8aOhfN409s8/stn6G+jZW/DBYBuaxPXG
 0SgOyVeo4bTHkx+ph2GciKShVOHh8bXC3CNM4ZYPJRc33HT336J0JlAqR5Djy/uWz67x 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex0p17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE0067I012240;
        Wed, 14 Dec 2022 00:34:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyev4set-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrVrUPTX7YDJoOVyb5BI7IdlGvOCzGM1CHEbMdNrY10LJYJhjGv86xloMZBKEytWbIWwCSQ8YuM5+A8qhkJyt+ZNQfswwQPYP8Hbf21/3FcLC5fgynqQQUCEB5TygpRRGvSui31I0ipBXOaTeLtWwQsJCxVUUosoUi+JwdYY/Ea/RE3qfYzs3bgDOyclHfWy228gCWAMJn4PrMXUc6UH8545oGhMifZEvYKv5YasS5tbA28YouHf7pAmkMMAHkKeVuJDIe2GIeoMgIwdm6n58c/gQB2BXvW3zvZ2al7ahOZhKKZA0EIFf6QPJ/YrD7gmv9I/YYMcbnCPIzH2UCRHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W/vlhZb4o/bmF4homKSxi+DQTBL/EgQDy5hpmLy634=;
 b=mWM5qso4kZF6mFzfk12H/JYKXSizLkYCG2t9aUIrk382vonzBRZVMAJoPpYaCJKb/LGXC2AAsl50ZwiBoaOPa/7j2Pda4UnCDZ6NYzMM2xX8pv9Wk4kY+CPOFWHTsVTSrKOFKC9UwE0npemc4x4yMff+kazdj/lbvdeyZTSyzesc1yZmianqG59p60Nz3726ajtlwGQCnjzhtQ6amliaNvBEOQBa73JPhZB4NE9xYQdhqDdrNXI8Serb5NuAe7AqMmIwemv5rkWHMmpxUy74tAIUb0CgPPqLOIlGlHbZJqsAm+D4w35js7FlA3nVC3grETtLaLZx9k0Is1Xz5JiE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W/vlhZb4o/bmF4homKSxi+DQTBL/EgQDy5hpmLy634=;
 b=zlPhtcxt/DiquEf3dTGWgEjB0Tm8RU5RM2Gp54uVqMlOp6F9nUF/os9gznYa+txK4hALIoN5bhOGt1EORDqrPLwaY6CtXcXPmRXNOR+L6AmIQjsxRdy2Tszn7O3hnbkw+5RaOEUvGd6LwrKVwwjdnu6fjS42+2DLg9Mx+6QG8gc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:01 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:01 +0000
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
Subject: [PATCH v3 01/10] KEYS: Create static version of public_key_verify_signature
Date:   Tue, 13 Dec 2022 19:33:52 -0500
Message-Id: <20221214003401.4086781-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:8:54::15) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 26569603-dbaf-4782-671d-08dadd6ae56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxSOWh1XVpR9WI7LholYkmzojdnr9/IBy4xaxoySOBBPD1jS2KjA3qXhjgYzNzME1X2JBv39Fixd0x2Ck9gLUP6vXnQ6usPz7Bxt49fF5QPRT3pY4ptyFNJOmzkzzpcByFaHx99oQGRoNdUq0v/MjA6FZ3FGF0hAORqR3lwrbdLOec/9M391E+QdZCebONYNtr44X80XrFYVkvYhaoU5Gn1+97Ls+0UtxRdjdBSl3IwSkpPrWv9Ds0o+K1UblzBQchxynO8bJGNzcqqUn5pGrs37M1R55LNo85Rl/rTd8UC0lFRUGq4pfKZO4O2+B/wIANSGq27z4jtqCauKGUxBz84fa9ZoR9IIffXWMhxLzlz1Jpi4JDXVYDr9Y0C5YOt2qJ5+1AJjISCry5GPfLw6KdFrmvYCdHix64pW50NfGnfqoeWjvbYOrADJmYEobwlBfozStbNz+iDE+c7bgdC2Fbu6UjzxjoF+etCRT/Fdbtf3TcmGpUwrmyKbcSMJAPN4Vmb9g3GQaMNT8RWfqKIUnIuuNIvgCey54iX5ccnsXmRhLApi/gY3ymABSNBZTHBySWrSmfPrkAz4+78fM8TWav11XFnHS/ibZa/b5dmUQ4GlLfRKG1t8hrdK+FrVkXrdTzsUO6+G2wkt8D6UlszF5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(83380400001)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPS5QlTMun6Brfa+/mg1acqqSAENu1snNQjH5/GZW+qj3LD4fzIU2dWN4x9O?=
 =?us-ascii?Q?dZkVeaifLs+J2XLfccFlCff5v3JiPEG3gmPDfxE4sTkvyGVREh4UJG7xSESZ?=
 =?us-ascii?Q?QXYEc6VjBvJOHBJawJPL5xluKg7XQCmgWd+PTwSUpcUfY6AG43qZE6TNGfSo?=
 =?us-ascii?Q?DehpX+vRTWfA5NqnNLO7fbRKEJp7oceycZ2UXB/qoYkj5yhp3aepASl+5DVz?=
 =?us-ascii?Q?JSEm/Y3bq6omhBgk6qUY0bI6Ksrv5TuDyMr+CMDt9eUKqROJwvqYHnGloMip?=
 =?us-ascii?Q?5OeB1+soieL0MpJIjNnzdEoxD+vqV8KMF5y9vLx53mySwTSFPoKPrQh9M+xl?=
 =?us-ascii?Q?MascLH3lrCzblh1Q26QTYCowB4tH5zjxH92arqFldgalpdhA9D9rz8i1H5iV?=
 =?us-ascii?Q?MYONBag9l6GLBCluwARA7uwtC3rQJ354XanbHVDYbGkbIYCrFLVnzsyQUEyv?=
 =?us-ascii?Q?2DJ65qdRQkNAf57ErFqm0RHMAEk51GQlI9YVLdLOjM9aX/KAFSvyydEIh2ho?=
 =?us-ascii?Q?7iNmA48+tO5nzm5rhb37Ke3ZMQRV9lnWSBpDwXKHOU4olFpcwlj7rC65frp3?=
 =?us-ascii?Q?kH+OAiD2JCAM3geO7atJxzCrjXuM5dTvTdjy5h9/yviGVUtfj4lCysb7EeXY?=
 =?us-ascii?Q?/bZyudv9CdsaeaqRrIzKWpZ38VJFaPVjv+VkVRJdTXfVK68p14R1e7aiYKWF?=
 =?us-ascii?Q?5F/jK7a1wJeafEsbt+6tjtmbR6t3jEy3bdFPyoZwM+fS8wOjILnblvkFS3dT?=
 =?us-ascii?Q?6rgxApNaowveRTgdVcwgy98mZkSYS2H52VxjeiqSN3sCIKkv0DUdWo/ZraH/?=
 =?us-ascii?Q?GBQ6kVWMmeEWMPF0+FFQWB/lfijglKawjXzCVCMXkO1APFqOVYj136llJLm5?=
 =?us-ascii?Q?8uBZfUdirgJO/DHi1SnFxD6fog1ZJVEKkN/lzxokfK3pS+jYesEjH2FYzIGf?=
 =?us-ascii?Q?hZG9xQ2ZZtOr1E4Ln+bHGmlfy3Vs3bY3XNydEaKQwDQm8LPEuDiU4XTLm2HR?=
 =?us-ascii?Q?oCovH7RRW5clGauRv0XKveZdbhCYn7fM6Fwm06ZAx88/7gB2YQyTD/7Y7M1A?=
 =?us-ascii?Q?9N0Mjh2GsgtqAv3xJ1cFFJWcUkOSbTLzNzLqG/ArIxDYztUn2vmVi3t4+9le?=
 =?us-ascii?Q?X0JjNIdvl8qKFWGkndhUiFf5K/deIrjv1S+kpxblNFGk9V8lJUczCdksxM/D?=
 =?us-ascii?Q?QRBilbqOem5m1zYBWPFKcxYGI0UKLdau1hhKZna/lSyNMxnnGyHvPhwM5lEo?=
 =?us-ascii?Q?dXeepn65v/ixKVQD7r4bfCFibxsLPffW8fHIswOhuMH6RtPO7u5cB9MsoQJV?=
 =?us-ascii?Q?nTcByjnCc0TYK8FL1sAZbVTLZI1Yrlmcgh+gq03uRYO78Gu47IzdtuRBvlTX?=
 =?us-ascii?Q?sd4hC9Co/9syuhKQHExilZ0ry0mRui3YPGog3ND4d/C1ImqjIfkR3RrXbVCX?=
 =?us-ascii?Q?/VI0HWv0QguJcjDelT36/X+H/cKVL5nuulIOawuao9LtO0cDP8XiR8K0Mdfy?=
 =?us-ascii?Q?6ZPUVjvITE3T0bbhvu5mPFdYb5aTNLUYum5OmA0Rt2FVxEShM1YjIkvrd9it?=
 =?us-ascii?Q?e9gMKDpx1Vg4mCDuisEv6m/HRxaaWEyNJSJ0cRx8XV+Q/vRy+MLLvctoquZn?=
 =?us-ascii?Q?kVHKhkfKDE1zKqOVSjKOtKs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26569603-dbaf-4782-671d-08dadd6ae56a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:01.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3JyZCuGGREq0haF48Z6ZCaTg4IXYLPxgeyQrhFN6HN1UfFPx69vQFjgWr+dEyQmpsabgx9WdAP3ACN91jwZCSifCBo7phfaK9pN2JY68F8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-GUID: I1za-0DgIyP4bhj5j8_4ocivw7I0gQjb
X-Proofpoint-ORIG-GUID: I1za-0DgIyP4bhj5j8_4ocivw7I0gQjb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel test robot reports undefined reference to
public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
not defined. Create a static version in this case and return -EINVAL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/crypto/public_key.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 68f7aa2a7e55..6d61695e1cde 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 extern int verify_signature(const struct key *,
 			    const struct public_key_signature *);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
+#else
+static inline
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.27.0


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EF8645FCC
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLGRNo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLGRNl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256AA5B86A;
        Wed,  7 Dec 2022 09:13:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDZlF030086;
        Wed, 7 Dec 2022 17:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=0a0el1ss31WGKxwEFsv29hTbNUhOlSRxOaresSxmB2SOamTqt1O+zfDiG+WRtijcSceJ
 jGN4B2PEyP0Y7jrQ/wofC6ODj+df979n92xJFYPC+nC5vew7A9s7KbPxV5LghEeKdzHi
 hMPI2QOYHWWyugQdmneoibAXAwH/U+94RqGEOt51k7qLMKdiKWQ/LsZhVRCiV2n1EFW1
 0cMwnrYsAR/z3s68qrvTHBAHIPobuapGNSE1o8eFxowyURG5Ry66mhHuR6se5h2GSsri
 hjck5EuJdXIMNFvTrvjkYP/D3VJMwD0TBrEbMW3mVB+Okjzk4jlKkm6ZrLvhkG8EW3II qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudk8vqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwQZN017226;
        Wed, 7 Dec 2022 17:12:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa5y2ms7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzJ4IGsfYndtpNhuwDi7y8Kv6BklCPaNYELGSDwk9T8T9SKp65QYWiZ1vRPHsixs5UIO8xHHciLwthGHGMZPq6Sl1+O95rJRGVgADGgM9SyKWhaBqfb8v/rk6jhoz6SE+1rZVyU/PC9eeSdWn2zQlEF1Z9JylxfEb2rzN7Dw3KK2pvQZg0Hl540+3VblyHH4NnzDsgpR5gOLA1LePp7uXQnVSRrmBRua+LFQ4YpP7UPO9f9oMwUaYbIoNPofKh1uHKfFi//xA+yQjPaCynUtS1zi69lZ8oHKiwDXswmdDKY3IaeMnjUv7Hj1VtZmqQtlwgBd7ZWcNvgucv6sAoRWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=OICjDbZPFjqds9Xi8xP7hgJJveijfBtXZonKyYOexpJZ7fV8p0In4BluJ1nRbwoTfgpGLvHMDRBmrpGJ6vdTNhYnW2nHgL9vyeCrJ2vdH470HzfOurFQvLni6yArN0LDSizWfwnwwdapEBMU+XJ1fVqUqcMOVGe9u3jlnGQZgLcfSjIy40prKI51GNNRvnBNgBhfv0GyG2EP9tMa8BJ1wxz3YK4PHzUQ6Bf+YKpYTZtAj+lEIG48OYSzp50kN4oIsNhaygvFqaZ6zRyfDW61YynHLk1t6rg8yk3Ze+/mw8Qcf7ueJJDqkAXLRI45wFxa6RDEHiFiu+1bKaO9sFh54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=qsTyDruoYNZl1APP6VlI2Mw5uHbVtbQ7rdCshkN5Xubigf3bK/QnKKNSnM9q21rwMRqKqJ0p02+xS1GCviUT4lGdVz/CMtDVlV3Un0vc61n00FzMz63cpLbh4JDpcmUcBnnbAZWMZ3UBRtFeOkqqq8bmTJqhHP25J2n8ULOtOMs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:12:40 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:12:39 +0000
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
Subject: [PATCH v2 01/10] KEYS: Create static version of public_key_verify_signature
Date:   Wed,  7 Dec 2022 12:12:29 -0500
Message-Id: <20221207171238.2945307-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: c4293df8-0c16-459e-ba24-08dad8763ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvSt5wUrktWXiulyDT9BBBwnPfxup5j/LAnYA0a1qEhzd8ZNvog+Wv+U/4L/mupJcvx3hA10nGMGQtBDnwVNRsK1fSwJ5dHdEGRqYbG93VoXLn5bUB/hyCFAGXY7md176dOnfNq5gc8KPZOEO+MiSrrIqcjw3dbkYo+NJ+SxZ3z8zsuqo79LQg67djzMLa+MkbE75QpCjz/emVDz9XrC0aJiAO6sjQcyPPP26XT6iiXbTLC2veTNEwFXUAhYsPw1AO9P0aT11qr+a+1EHRiauWcLRpry8QRYuJltKtS6kPyCymjuW2qGvdEtHvMo9bUYV+Y2x+nAqaO2k2CV3NqVxmetOyvggnD8YsqILu85sDkGwiEy7tDyxjWjrQh4X9JcVHaecbuyft/iWQpeoXThLzHDNYVriOI0/QLiB3+fSbUssAmxvzAMX3f58CeNXNhVzjCbS7x4HL1uSkcUuFVetbbalumwGnTlt2QVYgyobA08jGESLF66Yfz0/ERXIPl2e329vSfH+zL7ytg6shHmgFS4qkd7NB7EzwjfsoQqgJ94OKNqU2hUTcxJVgeom/Wo/85khxR8m6tbT641Dq/H8B7j8yzq2HYipe2J2A+DxlQ69kyHWbfReeht1z3hTfACIq6wMXaXO2rCXWmIiaZvGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(186003)(2616005)(1076003)(8676002)(5660300002)(66476007)(4326008)(66556008)(36756003)(41300700001)(83380400001)(478600001)(6486002)(6512007)(6666004)(6506007)(316002)(66946007)(2906002)(7416002)(38100700002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUXK9biJnZXdRaD9c0k4XUepRzkcdGPu2wbz9dWHxppzz2LGoAa3IB9Ugxnm?=
 =?us-ascii?Q?1b/abs/1H0VIXi4dCU4syTFxwsmWNz2Fuv8TzhXVaF/b+cq30gPolTTo+pCP?=
 =?us-ascii?Q?vlPPNsswDxCUMOqRBaLEFHh7HbGuxm6lu0Fd2su+9p9bK1yU0kRxgH1rmE7a?=
 =?us-ascii?Q?Gai/DWyjUTAMriW0t8qPY49wpnjJhTp8OsjaSl/fQbitz8g7I4XVUdl+jkrz?=
 =?us-ascii?Q?C27nNoLWTuVbvfw7dHAaCbEaQANq9+ilOxWGP4NKLQVoat1uRlLVjLlP747h?=
 =?us-ascii?Q?26wINSsnzniJ+Td9T72HVjcu0IR4kjpkUJMYyL+o9VWfpyrNxJU0NicCZYI9?=
 =?us-ascii?Q?fUHTH2oFQY+cSS9n8lZ0Md8NVNTj+RziWfuAHuRDesbFyuoho2FqzFKSzCzW?=
 =?us-ascii?Q?SkttO6K1NLtVN/SzWGLyHEEuCH6XwJdP+gSiR+XcKLttCAzcJCuiPN1RhNgP?=
 =?us-ascii?Q?k3AmSM9/wUyOGPI5Wk/DPShaHdJ7HpVLJrKKTWKpcQun+OCx4RIEiJrNnpOB?=
 =?us-ascii?Q?R/p3TKPQ2HBF1lHervBpJ+CuIlRzAyh0DMrgkOOk+B7Ad+Ok+AYnjx2Reaos?=
 =?us-ascii?Q?zp/Y4pMFK8pHJf9Na0dvmw6oxr3GGTDSd3CPpXX5SqJqfjO6iehP32JaHw8l?=
 =?us-ascii?Q?HtaoJXmMp/dddrHXqFphaBiD/wnQNf2KY9MUrYI+Laov8WRuMxMhU+Afv5MB?=
 =?us-ascii?Q?KAi//tXIGmB2kpARHry1Brw0aH6k6TWm4KLgiKrxByaa+GLQeLaxj9SsKSuV?=
 =?us-ascii?Q?wmQdAuDnrDbPZfMBhmDHWpkvgXBkp6006hvfJqSZ0aykvl79+L04azChPe/Y?=
 =?us-ascii?Q?s0FmRZ86mWPSSxh9SUX0BTORvqo00/m9SEO/3e09JT9neH4Kv2QPnCPVzh+g?=
 =?us-ascii?Q?BUEgUBSvmh/pai2wmH4O1Gh2ryAoLu7/1/SSohK4kLJCtlP0Idb9FQfI5Zu8?=
 =?us-ascii?Q?0u/8tAeGqTy1nwLXMJzdxssIHEU4YBhikJs7N9tH2hMz+Ozr61+1DvGpD3jY?=
 =?us-ascii?Q?JX1398UgCfUdFhXZc77oIr/koNkG3ja9tnthgIwcrS3Hs2KpIkDxRNbSD4sK?=
 =?us-ascii?Q?7cMlt5gXOlxyuMaHl6+UA2AEdZ6s3vq7SMo25QGUqcvr5RJguUZqM875ZuSf?=
 =?us-ascii?Q?ivpDLe6r5Dq+J8L9JpbL9rHN+sedFs6qF5d1o1qD3WoJczlr6IyjyiRvJ8FS?=
 =?us-ascii?Q?RzXTDaCWaqApSFMH/gVw3kBvqgGIEDjoyERV1FsHNXjPcUPW5QamnpyF1K4Q?=
 =?us-ascii?Q?o83x/2Xz2JsM5b9KAYs2JYPKNOwuj7YgTG3HjjwPyTcd4vIVgD4O8Vrv04vc?=
 =?us-ascii?Q?IrDHkhrfoldtuiBmH8VGx0NsbiQ8GsrU6sLApP1SaXxw1foXdurI9JTK6P3q?=
 =?us-ascii?Q?d4/6KNCOgFBeeZtWXRqt2BEMClbaXkgucV4ZtcEs9qIlBgh/0j5aI/M124uy?=
 =?us-ascii?Q?tl6xT8/ThgrcaFHCSt+K5QzVRohpYAlr3et1zer4ymmNnzbiILMKWl9inBdx?=
 =?us-ascii?Q?+GbxrUjOqHqSuXNUSXcyNT/Ed0QTZxOTpph1fH4BwXiCA4IB7KgIqgYidjI7?=
 =?us-ascii?Q?f5goiusRf/qMwAfM2W2nDAuid/eGpFLszn4jICTnTWqlyu72WNpjGXqqWeAI?=
 =?us-ascii?Q?yCdXCzphCxOp2rz+qwcnOeg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4293df8-0c16-459e-ba24-08dad8763ec6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:39.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQ1oVGZfThJ5IWlq0KUlTdM2L2dJ8cSOQsYB7f8f+oLYzpro0mb/3fF/q+w/m2UM0vyytnOAhYljSgWl71x2itj8KUWBmGEaovQqVL7kOqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070149
X-Proofpoint-GUID: Jtsj-gmV3TclrQ24D9cp3kqKl7nv8zNy
X-Proofpoint-ORIG-GUID: Jtsj-gmV3TclrQ24D9cp3kqKl7nv8zNy
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


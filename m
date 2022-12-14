Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D4464C132
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiLNAed (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiLNAec (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B201DA53;
        Tue, 13 Dec 2022 16:34:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLOFZo014773;
        Wed, 14 Dec 2022 00:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pP4Surn+7FPONQ6L3YWLkQIdsqC6Al/UKkJByFHU0SI=;
 b=zz7DxVGEgqqroy5TQj1NwrIgDqHGN5HIMqyI8TE1ITu9QFQjW4k6LWpt/kVP8wYpWe0B
 hnTk2Gw71QVSdj6AAT1Rqk7SIPQSenKi9mUIWZBmxIMWyXvCT6o9ZxNIyTWNiraZnrdw
 LZMehcl4S6E6Yv+mjHUMFNOOcxvDOzkQ0MZZZpRBUubht1RzyeBB3ztZFC7Ow5mIutDn
 KWz3TBGHWy1a4KE4k85pbi23uiJMiwGzOxJLyuPU1m62utTILXds7Z2EQq1FBZI2G41y
 8fRSoOZ65VEMcy2nnzzllUW2flQstW9oiMZix/4n4fbwCxVCpLDpOlX1ZBxBl467W25P hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyew8nr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNxu1H012274;
        Wed, 14 Dec 2022 00:34:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyev4shc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sct49W19orIIfbhnZZTXhfjEkHooCC+qBdn0l2+LwZwoUzE/r9pO0j2hrFnOgvdWeUSCDhM3rHoQAQXjOiA6BY2mVaNHTnlA6dVSP3xd2tH8m/JM8/FPruGmwBzIdrURC4lZdFswc/DqGrgqh9nTZa3tmLIRtnlzGNSrpUXqwvMbi1bBWr8wHj1/PIYHzDShlGTKba9a7Zvxs6rPWCSibNW0XOVWs0IKlS0/h8yrEjSNpG82JdAcROKEA4IXovsuS/VgnD7Nvx9nAavg/SlptYEF9wvLhW4X7bPW40xksXlg+35dgR8iuQYjU230Il9EfMRDX2mfb0RCeu/kRlxL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP4Surn+7FPONQ6L3YWLkQIdsqC6Al/UKkJByFHU0SI=;
 b=cG1ss6pR1P5+YQ4YB6293zgCWo072RXaUkfdcrI9BJlZaQLntm8e86wfESu27MVRAmDGuc9BTae7MkC+6IyvdRm3DhX0ygr32mecOA7/tcP2Xt0FUugQC2DYpHvqnyfE7ZnpVbszmvKd2yGaK/FNgz8w7N3G98YBOQd2ESDJBVtyKPvu+chk6ZvbOpMr0w32rLHi/cOyN0ZWP4rDEmPw5P2MJSrY6eADgVM4Vz8Jy7gQgwEPnw6M+aqc8xpTG6gva9sInI58kVH4fXOvesc9xKQSfVQPSTwsZ1eYi0ksYnZA/y6sOQwCowI0qVJh/i958AFAxll/NsuiPGGpvyyO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP4Surn+7FPONQ6L3YWLkQIdsqC6Al/UKkJByFHU0SI=;
 b=mHc0Ix+Eq55pE6kaw6GMzKwUOPnCuk+G+U+nwlyBdrwBR1xeR/tHhXJWF4qIuhMmNrA/6LCttSY8YcK8QDg5UQdO1NP8lclfi8kNH1fqze1sI8gUF9If2VI2ucaT2SBGDZQEV4YpPBvLP3xHprUT7RUONHaOwZs4Heauy+OR/ns=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:07 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:07 +0000
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
Subject: [PATCH v3 04/10] KEYS: X.509: Parse Key Usage
Date:   Tue, 13 Dec 2022 19:33:55 -0500
Message-Id: <20221214003401.4086781-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0102.namprd06.prod.outlook.com
 (2603:10b6:5:336::35) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6dab43-6efe-40c1-79c5-08dadd6ae8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGnPT11s2EYOl97Pq8kS4WxQBRYBa63nim9Y3Q4BixsRdSzcyoOwXYN5UGCIPVY0ZksInw7MFVQJo3xaOfCmZB4WUpOSyJaXd3GXR8VNDu6QlPqdZIuqV/AO3kLYHWzCwDnVQ1A+NZxjM81AqA/2L8hrhfeCiq/mOTEiH7MYoNjiD6JCnNmBbXbM1HDr+mYYZiC8ziMH6y5AUkjxa/aOqi/0mt49u36alEIoJve4hmd2cJH2M40y4ZgrTf/6cdMwYvH71wIOWFAYXqPPqtnMvdWAGngyuvKqsBHipTgGr04x7RvGAYG3/b9bh+DdYHDI6PGZZNC7Q1AZ9ji/usGltHgIkonov2SPjGx4tERkZ7CXuRzlgO/i0GRb7Ak5alqY7cl3l+BZ9Lyp8uP+x1pLA6ertyvNLxmCJ4BfaDrtUPbDecOxB7TNxCal7b0f+Gbl57AAMqJb01IvBx+nQ1OSbo/QdAVoO096nDu2hpkeYROdGAwBR0p5CBG/8S/etLO/AmdZa6H+rFDAd96Dq2h6pG+zDASKPteeGZuZ87u0lkv3G3I2YAr2AWHc+IXeP+SwK1rMQ/A+9qoAQ8H3PfOKKmijFmuqjMvYfuvb0niozvO34ICkElzwJJx7/2Ac9E7HsR31/XuegJISAsJWYq6PGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(83380400001)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4arNmP6968AcoW5VJpKZxPaow9Nc/CcnHAXtP28hicbvZf81par/Be1BewUM?=
 =?us-ascii?Q?Cd/HgrpDmJYQwYlfkguAxF57PIc/IzKIjRjW6DpuQlkyDFC2zxKzzHjnE+wW?=
 =?us-ascii?Q?htu11GsuP+IsVMrjM3v4NxosaEoCaDxrTNT7eW8RHcq9+SZfotv3j0RS9s+E?=
 =?us-ascii?Q?GOJG4mNCobxJbwY/6xm2nHQ6VFaHn3N+wNPM9JG4pAsqTmvW+v+7GE6ul0Ph?=
 =?us-ascii?Q?IudrHb9fw0c0YXUhTKXRc4RPKCWuB80q4IXf1AL7Jaqh4hqM+cgXOFajm/Rg?=
 =?us-ascii?Q?Y6jTHRBtZ3gaRWcLTeJMbe0fEsV0HKOrj8lJOZU1Ga9fnzzY3ZRUIJ+eJojk?=
 =?us-ascii?Q?QCPLvDoat0E3SB5ATxnVhDo+iW7BSRORMEvyKgMWRiVEpWgGdoeRxGz5wS2i?=
 =?us-ascii?Q?vqyeq/BU0sUIWwWrNmA4PhKlAECp1hbwFUtfKBuvx56v/+kEP5g09rPag2b8?=
 =?us-ascii?Q?OeQ/+is+vkRSFuReEp3qXsUB3l1K9Mi9a7SHHBzA9E7A4gOCRYKjmMu84aNQ?=
 =?us-ascii?Q?1s05BH0WycNJhfsoaTFiSw/xNNtdbugHaGq6wtOWv2bREjKLahYugbccv2Gn?=
 =?us-ascii?Q?bNYIuyzsSjtjuWbyCRyphJXlI3sfMwaWrZBmI/Auv2+bIhvqiVH6oCr2YFbZ?=
 =?us-ascii?Q?Y3x+ArBql4nqasZbXraE7wd/VVSr572qugzOw+W2HzaEiVFjmJPQtUdFYje1?=
 =?us-ascii?Q?pt6aVNRdtriiyWM1gbaPDOzZffw2d5UsbETRrten62BeXUMd/Zjal3Q9ShYg?=
 =?us-ascii?Q?wTz7t6yjQ+2i0IhVbSYazWN+CiQHCaA88XZduYOgecGU2cwmnYE0UjsqiFZr?=
 =?us-ascii?Q?E9Sy7j4zjs7L/6nZ4fitD+RKBTj7KFeKvyvRcuKsJHavQaneXOB1Wy0Pa+eY?=
 =?us-ascii?Q?yjEOLYAekSCj2fEm/UHn5xGPMOJahEBHNTy4sf7JctdvgM0z8U6AmUpirFVz?=
 =?us-ascii?Q?qQIo/jvgGSw0rddetKJwEGC0Fa/3a+tS2IJ/C+XJ520xEvrooxLKEZNJaK4c?=
 =?us-ascii?Q?dzxKZBX5DyuqeDTeNZsoGx8QuZ/WPqCqfsb7plegOUqHOkpHj1etzl8mnXcu?=
 =?us-ascii?Q?JgKk8e6gmzJFIAIo1RWY7gf5spP42TMRH3A0PbdQGWOMkRm0usAyZEInvXYU?=
 =?us-ascii?Q?G2DuuT0unq8Qdty6+MzIGbmyEUR6fcLDJldexOxCTgDsOLFdXrntENgOAyZn?=
 =?us-ascii?Q?RV8TDsJCoea6TCiLUjTNdPGZJMsQUEo1RNPux1NNpIIspRe/W9uAPdjp1pFq?=
 =?us-ascii?Q?WiBcK03fUmmnCmd45BnUyLNwGCA3zdIb0NcHmbF6A3f6n9ExllAQvk7mvafy?=
 =?us-ascii?Q?yxruhHL9mdaCEwUTPPpPo5JnTzUH5FrYJA0GPlbVbNXy9xGMSBKNm6wa1vxT?=
 =?us-ascii?Q?gZ+a8nk6aUxdto/iaG9m7TW96d5iB93VCtl1YWdQWrDZpOlj3YryPHP8KMgj?=
 =?us-ascii?Q?btAKJuhU8urTnjGCQpLgLRU6qGLhkZgF6t2odCNikKeDM+m0W9ZdbGog34uZ?=
 =?us-ascii?Q?xj2w/r+EaGOSpgFUzPDbDvP8UtTrTjZuz2f6STq1z9ay406Tp+NEnBccM+Jm?=
 =?us-ascii?Q?6/Iiuu3cnJog+3+n23bGVIQ6SajDnj50SanIwMJmfCnXyumtJcWhUBcijl5i?=
 =?us-ascii?Q?76ujeXptCq1YKPutjIPHvD8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6dab43-6efe-40c1-79c5-08dadd6ae8dc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:07.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Loex+q1E6cSlnBmYXrZ3+EgXIQn/KUKjAiPIrm8rx0UXoDkwe2NL7+Rflng84RFgdB71edmZ4tAukmopgVf0VB7O8EnKLR53wvXDf+lA+y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-GUID: 87Zir4qgRiO9kE8gFd_WczHPZ09GHpZ7
X-Proofpoint-ORIG-GUID: 87Zir4qgRiO9kE8gFd_WczHPZ09GHpZ7
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


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC6645FB5
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLGRNh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLGRNe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569E145A1A;
        Wed,  7 Dec 2022 09:13:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GAshN010143;
        Wed, 7 Dec 2022 17:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=67/NeSQJOh9GstBqAB+Fi2Zi7ymP9847y66TJFSl5CM=;
 b=e7ACvKlfRei8X5C3eVz0VkWhyJU8YgQsrR8jwVZK0K4K1If268sh54KGwjHVQ9Glw46v
 ALqRbepnxNfnW58iFhB/3S736zavUiyWpObq8QNjqqEzwlFKSn7L0iGvu/03FCR52DvR
 WD3txm4u8U3WP4n/Ov0mFMB9tX5fNwWjz/5vI8JLknxzkP5r8xTtzkO0gc3kCKWGRjlI
 gH4I55WV1iwmTGU4PsWtQD//o7RtcvlayH5aaiRs79wGRbWCz6hyYBN1qkptI2nhDd05
 9sOyml/ErzQM4H+dRPidMKG5NK24EiooISLmpbglvSnZVosupxsF4eDfaUcjOJR9HgdX fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujkgt9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwbQt009733;
        Wed, 7 Dec 2022 17:12:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa69a430-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKPUlC4IbYpUqiur+fWt8E9AO2qfwnpEpDuMN6PDvG8TJfMYlMKH6lDMn/9mMZQYyUFuORe92MWhj7RGlIiYIhZ51AHDiZYQpt+5fE2mQ02E84/AlEGPQM/aqG1/2SZWCseHfYLxE8tVAlRfvaIpt0mGaDWiKX7uILERkzOc5KgZw3Jo3bEDEtBLC+j/d/z0WQDy8clsDvGjxpwMWEb3JUcR4bIAeWIjixtuktqLVEuHwo1Z4gSBwKmA3BQvD0/MKmXxZHIoVcyG54kWpGdwwcouzsT5VgrFbRu7UP9gK+K37Ua9JUH8ZZmbFW0z3HyU6/nis9qvT+PhfNg00Byovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67/NeSQJOh9GstBqAB+Fi2Zi7ymP9847y66TJFSl5CM=;
 b=dzDP8MNZUdRxMmiuEY45VR5fEk9FRc1Rnb6T90tcyfbQCozDiJ4i+rxhj0j9tY5ahKOrPMCWI2b/IGgvi1sXydUIgh0hLHxh0rVXAlhwBrGnMDnXQ+PLkCPHsUOnNth5qK13JZzO+ahOO85bbU5rnTn18rkzE2WlYBTMzfl/Tm5yNnpdF0UL/ttTL40cInbulegukFSPDUNEp7tAODaWH3yV9X6atzeiR8DgVDpNxRZ82XM0ll6Q1n0Z1zykQWjrpy4JuW5dX4jZSW4NTIIw1haitlluMKoXYGlC7ZdCa3FswCXYCgt5Vk1bwjk4Ok75wUD0guFiNbJiQ70wwqjlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67/NeSQJOh9GstBqAB+Fi2Zi7ymP9847y66TJFSl5CM=;
 b=CH3oT6kEKeelbsDIWCdR6whbsjMRnDRkPVfUfzXRSPkzq7cShhHyE9f5Miq49V8Kbgr+NrXahtyISXB2DqhfWpx1ZEFoS5sBV3JpIzUoER85R9NgRSurr/MTgbEl3X6IPfiumEugpIovxQXR4UoN7/mUkS+fGNqP8AxgBbeJ1G8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:12:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:12:54 +0000
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
Subject: [PATCH v2 06/10] KEYS: Introduce keyring restriction that validates ca trust
Date:   Wed,  7 Dec 2022 12:12:34 -0500
Message-Id: <20221207171238.2945307-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: a25617f4-0df0-47ee-4f9e-08dad87647a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3d0AfC50Khg1KBsox1oZWB7ddjIDeX9ecCmA07BBMMye0iWklHBLSq87IqsXGMGEYhipH8J8TVuShM4YQYXUusCVjOGqkQ6fcBiZb+gDWSC46T9yD3HM49BHglc+9dpAPvwlmtd5RHsV/5y9m85b5cemh9HfqV6++GbmiGy74ZgtoBG0apsmnUSi8iVrAU4UB1w4ICEavJ8Kx7LzogjzvNKiFKK26Bu6MrhTLwKFZatUpUnqaliJ85ICallovPlHnftAxxztqgiMqUiiBeEYlRqAcSLkvE7d2s6KIFApTxNt8OIhVq9YjgQ1jXWEdrorCw7JK+FPf5sPRWaZSP6zECTKkuo/jtXS8iRELY/HMsFUUzZMVUhXtdIC+zLQKZ0bnS+vWpjnOOcx3GhKBJtDDtXxS5EeANWchibeWqPNUYKHs/Z+LAaZkB8z2H3trAG/IE3CbEMNYihrwEcsgfzisR3JuaqKbsoKwo4MZNhSSCZPWrBhpbe5PAmLf6ln87zO1Qb4Ida9TldP0GfnLorBtQKD0riWpWnSXxCBpLnDu+12ULQqPdAitZutzhhZDghPRnofeJ/ITLaMRc4RjqRW44cAgjZQEzMgvt41UvN3MYui5iJK1rGHWGhGrgMHHBv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(186003)(2616005)(1076003)(8676002)(5660300002)(66476007)(4326008)(66556008)(36756003)(41300700001)(83380400001)(478600001)(6486002)(6512007)(6666004)(6506007)(316002)(66946007)(15650500001)(2906002)(7416002)(38100700002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pz0GErKT956OzeJtuZhMwmREfGAjpfwYD3WlwLYjh94kqQmACA0cp88XhKbA?=
 =?us-ascii?Q?tPThGreVeZDatdIl8vpF2bXrxll1ZZplMjH9X5Alt3KZk2haGpt4w7USjXo/?=
 =?us-ascii?Q?NCKl/kMY2Rd69Y3G+2GhrCWEsb+2yoUZQvHjaJOVw9M+H2ABg6VEW3YqfrPO?=
 =?us-ascii?Q?sjFIo8WJmcmm7BeEqYfYKdd8B3M2z/3hpfRrndSW7ygGiQkDan7AFWTLV+78?=
 =?us-ascii?Q?4zYC8knAVf0voszIBQrjme1NE2Jyp3ON00np/AghjVVa4scCBM+BJD01Wxp4?=
 =?us-ascii?Q?g5zA7ZnkE789JfEMB2sQY9qbTSGMZ1jIVvyzI709DN6vx65VB0XTpfnkz3n2?=
 =?us-ascii?Q?eRdeNcgXtRFZWX+wofS+mxCbbkCk34RetH4TNRnrGQNvXM+x11UO3512QZOm?=
 =?us-ascii?Q?arxzcDYvUeYM839NUEh6Fw2exFEgqt96bbc5cynEGQ41xYRl40wNjCfEansP?=
 =?us-ascii?Q?oLDqMGqeAi8HV4rk9U8SwsX2pkY2tkWf8kssYhQajWKCy8vPr9J0PL8HH3R8?=
 =?us-ascii?Q?EmUshDN5ZGF2SOrrsAMzqVKa8gRgQTuNDFSxIi5j8ljFOdN3iakwLz+9sDvp?=
 =?us-ascii?Q?GCwAJ1xhzvsTrU1Ehh431Ms+p+J0mpOO8owhPH/HHNNWG8anLSGapkPrF6fk?=
 =?us-ascii?Q?/wgvy4pU4TPZHe2ix0mJF7hc5y5XGbhzVnFnEP4k9LFeLApnISjxUPJcV4LD?=
 =?us-ascii?Q?OEq1IzJDjA4d7IDFmACwu4Yq7/NgkoR2k20e8/8dZS22IxSyKec/C6xQH8RX?=
 =?us-ascii?Q?RJTM7Ldyss+2GZsjkonLcQf0ZPGfJ3V99ZD5KGepmTAIYXJJTzvVWcO1H9BE?=
 =?us-ascii?Q?2PoqIN4f+a4xFZnpky4ViiWn+mKLI8MxGNDw4RIxn0lKIRGezV5h8MvBw2oS?=
 =?us-ascii?Q?XyimKK+9/aysQFeeL8F21BeL5SBSo+p2/GxNkiKA/BX6V82h6ueRIxBVZ3oW?=
 =?us-ascii?Q?uZqNq2ZJ5Vl7VawdxHgh/g91W9U/Oq4UWZfcKrWtuau0gWFD5DpJsxdRBC3i?=
 =?us-ascii?Q?DT3Lcv7nDbRl85QpqI+I94XqUzQab1ZLPiNtd0B7Gjqw/7ha9alIxnR0wFOl?=
 =?us-ascii?Q?5INjtAgWNUjIJZSdBoKJt3PfvzNZKYsqEwiHJjDaHk5fY0PilLITYUr5U1mQ?=
 =?us-ascii?Q?bTG49LwHhCFYSTcwEeTpjZQns3Kn2AZ+DZ8cjOzts7vhjJ0NCgFqWSU2Xbyq?=
 =?us-ascii?Q?BbxIpqOMSvgo+qml6BRBvkwC3fSwELmtz5MNequsFltTmiAJXVKyjnsQylZz?=
 =?us-ascii?Q?wWzlq/xUYbX22RhITZKvDWqojdx4gx4pzZvf7O6YKkszn8N46xJD/EiiQ+cP?=
 =?us-ascii?Q?ktxc7KIen6wnf3ZFeD496gmZAIBmLPFA0T+/jxC44ryfjSYeeUsa5Cz9ln/I?=
 =?us-ascii?Q?pP3h4PUR56yQxAwIFpD4qFXtb1iaLvLkAL2pmS3942s+Bbnjf3cV7m57emUS?=
 =?us-ascii?Q?NIoDethK+CpPP16RQMdPmLchosPreDw+oCXDDACIdW9kEX7YXqHnYXWMoqyE?=
 =?us-ascii?Q?hBVFxlpWOwbm0qmYsLX+JYp83OFSMay9LyMY68yBJE4cHLBXXFWbGHMv7GHg?=
 =?us-ascii?Q?l/kNeRfmkD08hcmp2IfcZXXRgpZRAziZODAGhY0Z6fgCG8R7auFNge4V2Z+W?=
 =?us-ascii?Q?BmO/4iwAa6///J7EE031pFY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25617f4-0df0-47ee-4f9e-08dad87647a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:54.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7j2tkmfMBWmmawmt1fq+bJ39DWVZzpnnODDgSz/dUWvJAx8z0BoZf7RLtv57h8hqvjBm5/yrfzKTHc2M/50Xbkq/6gOS5MAXT2+bXqHaqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070150
X-Proofpoint-ORIG-GUID: Tp1HIK1xCUcRWReEoYlU0sUCivubzGPo
X-Proofpoint-GUID: Tp1HIK1xCUcRWReEoYlU0sUCivubzGPo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current keyring restrictions validate if a key can be vouched for by
another key already contained in a keyring.  Add a new restriction called
restrict_link_by_ca_and_signature that both vouches for the new key and
validates the vouching key is an endorsed certificate authority.

Two new system keyring restrictions are added to use
restrict_link_by_ca_and_signature.  The first restriction called
restrict_link_by_ca_builtin_trusted  uses the builtin_trusted_keys as
the restricted keyring.  The second system keyring restriction called
restrict_link_by_ca_builtin_and_secondary_trusted uses the
secondary_trusted_keys as the restricted keyring.  Should the machine
keyring be defined, it shall be validated too, since it is linked to
the secondary_trusted_keys keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c            | 18 ++++++++++++++
 crypto/asymmetric_keys/restrict.c | 41 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       |  5 ++++
 include/keys/system_keyring.h     | 12 ++++++++-
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 250148298690..af5094ce9bcb 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -51,6 +51,14 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 					  builtin_trusted_keys);
 }
 
+int restrict_link_by_ca_builtin_trusted(struct key *dest_keyring,
+					 const struct key_type *type,
+					 const union key_payload *payload,
+					 struct key *unused)
+{
+	return restrict_link_by_ca_and_signature(dest_keyring, type, payload,
+						  builtin_trusted_keys);
+}
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 /**
  * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
@@ -83,6 +91,16 @@ int restrict_link_by_builtin_and_secondary_trusted(
 					  secondary_trusted_keys);
 }
 
+int restrict_link_by_ca_builtin_and_secondary_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *unused)
+{
+	return restrict_link_by_ca_and_signature(dest_keyring, type, payload,
+						  secondary_trusted_keys);
+}
+
 /*
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 6b1ac5f5896a..005cb28969e4 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,47 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+int restrict_link_by_ca_and_signature(struct key *dest_keyring,
+				       const struct key_type *type,
+				       const union key_payload *payload,
+				       struct key *trust_keyring)
+{
+	const struct public_key_signature *sig;
+	struct key *key;
+	int ret;
+
+	if (!trust_keyring)
+		return -ENOKEY;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
+	if (!sig->auth_ids[0] && !sig->auth_ids[1] && !sig->auth_ids[2])
+		return -ENOKEY;
+
+	if (ca_keyid && !asymmetric_key_id_partial(sig->auth_ids[1], ca_keyid))
+		return -EPERM;
+
+	/* See if we have a key that signed this one. */
+	key = find_asymmetric_key(trust_keyring,
+				  sig->auth_ids[0], sig->auth_ids[1],
+				  sig->auth_ids[2], false);
+	if (IS_ERR(key))
+		return -ENOKEY;
+
+	if (!test_bit(KEY_FLAG_ECA, &key->flags))
+		ret = -ENOKEY;
+	else if (use_builtin_keys && !test_bit(KEY_FLAG_BUILTIN, &key->flags))
+		ret = -ENOKEY;
+	else
+		ret = verify_signature(key, sig);
+	key_put(key);
+	return ret;
+}
+
 static bool match_either_id(const struct asymmetric_key_id **pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 6d61695e1cde..e51bbc5ffe17 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -71,6 +71,11 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+extern int restrict_link_by_ca_and_signature(struct key *dest_keyring,
+					      const struct key_type *type,
+					      const union key_payload *payload,
+					      struct key *unused);
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 91e080efb918..4e94bf72b998 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -24,9 +24,13 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
 					    const union key_payload *payload,
 					    struct key *restriction_key);
 extern __init int load_module_cert(struct key *keyring);
-
+extern int restrict_link_by_ca_builtin_trusted(struct key *keyring,
+						const struct key_type *type,
+						const union key_payload *payload,
+						struct key *unused);
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
+#define restrict_link_by_ca_builtin_trusted restrict_link_reject
 
 static inline __init int load_module_cert(struct key *keyring)
 {
@@ -41,8 +45,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 	const struct key_type *type,
 	const union key_payload *payload,
 	struct key *restriction_key);
+extern int restrict_link_by_ca_builtin_and_secondary_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
+#define restrict_link_by_ca_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
-- 
2.27.0


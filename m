Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963CD64C15E
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbiLNAfT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiLNAe6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73C1EEEE;
        Tue, 13 Dec 2022 16:34:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLOBYV014294;
        Wed, 14 Dec 2022 00:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2lUDxfaOkl2IOixZjwzaV8s1BFWU9qd/m1PpkSwedOA=;
 b=XQRNfbDWPLfk63//Lpf3B6uEnmzyVCWwZZBcczP2NXO6+8/j/ifAGuRF1F9UOlta4Slh
 5Z8mGyH6Qf9XLbR8pvMIpvBkbu8ZhG2OUCxIn4wEyRNZrEknTDGaRwPQ8mISvsgNFq3s
 jUrHc/kvYXt1nZum4AE02MxR1MFBBtHawH4Va8+lsaKNkV9vUbmfko9Zgp8eib/HDuRl
 qS1ewwQ6oswQmb5d1HO+B0kQTfC/Z0pXZwh0NT3ZG5b/y2VJ1kdkAlFMiJUt6D+SS873
 ZDkf4oE9rC6SzbUtCcZ2IO9E0zQw2Qs+ydpNfY98OwRilLH/xrF33IT1+G3dR54ScojJ ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyew8nr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE00AJC011802;
        Wed, 14 Dec 2022 00:34:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyenvsg7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTodrjEXusfq9LE/CDgLDqjXowG2axGtPul004Ku01KOjcOYcqnCRkzIonS0jzwbPP2x6KkoMqrrJabCvozF0FpPY86AiL/EV3JxUx/NFRXsL7eQYrpYneZC8MBl/kYROkwssKWQZGhHrfkLpasatStj2tnuqIx18QGxtuoC/b8dQKUtXIH9nvaWjkhsvyMTHsn8mRY8PqXuHxXiD768vCx8lmxLCU2yeX+qoTFa4zknLP0Z5inkP+9/O8lO4lWcbCbQ3rxMGAQJBO+o/t3ppOJqwbaLUNoh1Dcb7ZZOOkiebCEGuYZYW685/xStheQYGtB8mtGDPKfJoAVCKjKt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lUDxfaOkl2IOixZjwzaV8s1BFWU9qd/m1PpkSwedOA=;
 b=hv47EG+1HuU75V63dqt2Xgf79sXGJT39LEx8eO9nLAu5/svietNVV3Oxn98ory6Ym8gzh3/p1I5kLiQq2qz1v0sFTYkyJnhyHpN7PFAq0P0K3MEafr3p7UPJ1DCX+ZicZtXUrrCUx0MQqPNh2Q1g/nKjM4qWsUyKIDOgmpfEB10JYhMVKAtjeNF+SyS7KYHGgx/Gxn10bjxMCunDJhzXlrd39J7lYVG9I8y+UBjz1oFW/juMNbm6VoqZTuy0x2fdE/wKkxQfMr83SL8bRJ4fz5/UW8ikc/i3v+g7hlVbH/tdWCu8bJCWZFB2mJKYI6sxtwWa7zDKPPmmcCr8T8FetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lUDxfaOkl2IOixZjwzaV8s1BFWU9qd/m1PpkSwedOA=;
 b=rsvku0nplt2axLh5hzR65eB0QXumXt9dHJJRKMSgQmIkIdqeJ54QvnJtXNjajcO6hEn7JW3SaWeitYfHEJLo86L3ANODwkQBfIXn7LQ4zIzlGgucMPTEHm9kXKARpUSb8VJRH7Pt9qlHk8wzKx3GOiVUU2tKleo/VMc1kPI1uJE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:10 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:10 +0000
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
Subject: [PATCH v3 06/10] KEYS: Introduce keyring restriction that validates ca trust
Date:   Tue, 13 Dec 2022 19:33:57 -0500
Message-Id: <20221214003401.4086781-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::21) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 740bf181-db06-456b-6f1b-08dadd6aeb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzOUtONuq80RZKbd/Dw67mzpSymqvPghVueK0X32+Rgk1CnUQNijSHQbVZVhIB9BFcJqD9Eji3D8PCgIWecXoU5+PXcjbr5moMLwjbd3NBr0ggAKB13j9QCvwcfcw3xJr+23kqL4T6RinrNTnza9cj6ZXmIWtBQfInBvSVoM7fuclpsaQ6+ZVfyEj2V9a8XQ9GdTIzCtbrZLiY7B+Xb2KArT+BeDttuYHL2qCNJbw/ZeI3hZZJ392vAQs3kPgE4UOnO8n8Nc/2C7uxrxNI07wQ8FP9o66DoHDYvSK6AGsJfovNE+FFfV1+L1L7fWtjY3a+dhiNlPBK7bKhqECYxCR3NWo3jBOky9KWo2opMOeyiTLN02nQqNPPY6KDiDHz5nFd5A12nrSr9GnWpl+SJqBxkaDht2yFclhjTM0kQVyCPTZGZ+7iFOrVpKke6GJCSxmgqxhp6sn5ZKdqo9zOgvD4ozgjHb85ie0VDVdyQzFnjmPp4XxoARnB7bi4ygVKTuSmzmH4aAKyBFfGUcentkRDgDAWM3qH6uo5jxaIzyDDdHWgYkz1Xu8dlO0ZeydsowGldEy8a0w6siMrFKONpgTephDmTyhW47gILkhn/vUyH3gc73Z/6NVZjiobecAlRlTRS+koWrMAhuRl5ETf81wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(83380400001)(15650500001)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Shk6R4ng9qYZaxGJI35pPACXCN6bpeiKxQYkw6GYYGbHBtJVpU26DRAQ35bZ?=
 =?us-ascii?Q?HpvOmImtM3bIcAsS3Memfd+3tRIPGghviWTBq26s8iKDsUQ0j/NNTqJtET/D?=
 =?us-ascii?Q?l4wJ8mAnsOeIxHSl/u/g0gtyHk7TsgUPH3e8217MfYDX54g9Vw8qTk0mWPxM?=
 =?us-ascii?Q?7Bp0f6nemXZ7AS78D0up6t9COoAdDMOX5pxngkpPd/QS2b6B/XHsWqXcJrY6?=
 =?us-ascii?Q?UTVb3W30lXE0NenyDIK4oH65LdCfNn3+jqj7dHNT2UZaeJy65oc4Tq6ppWBa?=
 =?us-ascii?Q?o0GISXrQpZWbX13Y4mU6X99KPDyY9wWAGszNK5pXoxt5zql1s0MtduYcuTG0?=
 =?us-ascii?Q?dBolptmRoBgMeIqnXAOXq0+ha/+dItti/iinU1NBClyi3McYCWA7fQ4j8cAr?=
 =?us-ascii?Q?eJdYTBmp1ug3IBEztMNQTiurB9WNy+W8fHKTblVvzuPjRg2xaOwFUcza8qlG?=
 =?us-ascii?Q?bT0pI6LXRjwKV8eLfxN72h7KDphw2aby2nsDHfsPirJGPBZvDxhHS4qLpMk9?=
 =?us-ascii?Q?xnzYPPbR53C87fjVIU26ANEXYKS28RTvZHffeWVchnrYvipF/AyGXD9Xuvce?=
 =?us-ascii?Q?BeK/A4H1oXhWXyIkqzB87178nv3j88oSthBOVz/SaqackQgwPSfqyoz7WuF9?=
 =?us-ascii?Q?kljLrtcdCk71VFSYHb7IQj4R3RnlqoihII4xaqMAFQUQHYm/7N5Zn9OSwebG?=
 =?us-ascii?Q?clm5oI7MMUlpm8qXAfpNwukz5EbmOWygHG4O7DKg5VAqwDmSIA6qHF7GMB53?=
 =?us-ascii?Q?9Z9/OBjn+HmjqBlNq2XsjrWghD5DuCvzvxadsM3Za2Hh03DCOELAUuydqTAG?=
 =?us-ascii?Q?JEzYSe6TMwPvFRfGUPfBG6qoq3xkP5qChwER/UJS66RODwdx178F1R/D242k?=
 =?us-ascii?Q?mY84CRfWONuMUONLMgLXRjp+YOfVCXaFSuyZZvTTSmf8sxaAdS+09RCqBzRh?=
 =?us-ascii?Q?y22U4j9smF8Akj3D9RidjeMNeHfihr+DvDKNTBRmuAHC/txT0BynvycaksJb?=
 =?us-ascii?Q?q9UaWMpvW6qEpVT1ANu3L8ieNxCs9muM9Rj4zIR+7deapSp7UdP0qbdM6bob?=
 =?us-ascii?Q?x+o4rMPTdbejFGLXtP/bPXLXVzhkcD466dAunqZHlIDVEz2AOxMuDlMgUNth?=
 =?us-ascii?Q?5Mafx2ftJi5kA4uIVQ5pVDmsCIZn5zyYly4BVgc2Ya7qS4q4XTSjuQMueHHs?=
 =?us-ascii?Q?MofPf1fjHh7/WJeuURT2yvSsiaeOPIQktIRbUt9MJRDB4H8LTh8RWNYPZWIy?=
 =?us-ascii?Q?KXTkK9fVjfPBWmIxTmDN9xjUEIHIXI7kpJjgIoZa3tha3gOBQXX+ZpvDT0KE?=
 =?us-ascii?Q?wmRSMqdREK3C+r++QDF7PU+NkLaJ1cG0UcTeUYJTIQbNC1kIJ3aR9YrinIns?=
 =?us-ascii?Q?I/c0vuhCI+jBfBR8I2/eS/N8FUo5+upAmNHr0n1e7QCd2uKg1fffG8o35w0y?=
 =?us-ascii?Q?jvRPHBDEcHEBXyJT4IgouKdzTsZMv5tn2XVLsvfHIjvW3L+3CZs55xLwZfD3?=
 =?us-ascii?Q?nMYXCsC8cOs5XbyrzGO5s/SyP2yMwJu+DKJHiXAZkXpmBP8yB3yX6h6n+H+v?=
 =?us-ascii?Q?B2qtv3msSBkZ2xEPBOee/2uiUWlznpRbe3jOtegbBsmpqqvIYe/A/7kTNnd3?=
 =?us-ascii?Q?9H6zu//wscTK2FU3hfrd1rk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740bf181-db06-456b-6f1b-08dadd6aeb05
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:10.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iBdhBHTJohMNjXbEB9faKnB7zSnuQIGaPUP7MVTmlaQly/cK4jd3jpt2hVeU69aGnycEcY6K/hydOeXjWD693nQb3hp/a32Q3ad/tFaa44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-GUID: UUWus2xm71YT6frHTpr4LSCg7ycJWTq8
X-Proofpoint-ORIG-GUID: UUWus2xm71YT6frHTpr4LSCg7ycJWTq8
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
index e531b88bc570..0d219b6895aa 100644
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


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387B264C13C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiLNAeh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiLNAed (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD761C412;
        Tue, 13 Dec 2022 16:34:32 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLOGQ0017123;
        Wed, 14 Dec 2022 00:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=wYqep1jLDE3Xtl6dNncIJk46XRFBbv6XBL3SdSji7B0=;
 b=LxJJVnnNIqVLXKhN5Wfvhh8ruq+2CmYNEXUWozjyTUg1Dy7Uwo7T+3IUlK7B+Dpwi3E6
 OIA8Voy8spDd+eElozZf1mFoJQ/QEhgkbO1nn9HfpomTwnc2ZUVL3nts0zN4b7odg7Gf
 fLYdEaLSHuOEVRD/GJ0NZnn0qmO5H/odxml/skdUd04Qy31jSesg5C1orlcK6r7qYzOq
 19l8K8Yp1GoKJXGJSCejEDozxL5+l50Idbr3IPRVx/baBmRHItOF3k3vR2Yfbfez65gg
 SFD0gSMwv/BFlYgtWISn7G5kuVbAKiiPAnMlTKkzEtoqKAPwJ1f6nfJhdIrq818dYWg2 NQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewrntg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE00AJB011802;
        Wed, 14 Dec 2022 00:34:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyenvsg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdJoaI5Mj7az+KzhY3qOMac6sgIxX/mMsaXrxIqQnQNh3zrcPwljt2Q7o3/yyj8nUk+adwAnFEfXRQLtoGU7kuXq97kiE5NMQKSxznBFt3sG+zsIbDlgzIJEKOnMxLRQX6iYrEoUXtQb28fB0QmfYDEjlc8vm96cSswhaL3nWxacgqad/LsV5ZMdrqUNo1G8o5K1oQpBNU8S/7sV141Q/7Eg+8D2IcsfZyDeIMxoRLyDdy06Vjp7lK5Xl41E0v2SBmLkT1eCOgP7PPOkR9BTkdMJBR/thNj6xs9UGgGyUUsswxECaj9Y9MIYQPUJQ9sfaXyLBJdg+mD+6g0cW3At6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYqep1jLDE3Xtl6dNncIJk46XRFBbv6XBL3SdSji7B0=;
 b=L94A0x2rwr3EUas+E4IWA5dPm8gbbDrlzs5CmWidwNYHBLgD1q0CsrAtNZRHhWJc7VrJUeupYCaHRnf4UT5+HRt/lghnupOfZVyuyC+O9d7tNcLORTjZpd5TOpB/BFgGUwnV39n3VULG/2zpZRM69T7fBhi1YwDzOkifL2Xayhn5+hVJWv6p6RMwauAduOuxeqI9Bug2dnZuEmRDC6ZMc+yGGDpIINnSRQMPv8lgiei6tSMU57dVDDMq2FLJe/660An23JUoz2rmW1f9UjGzMauo5vg1EuQw4xv0t8VP3UklTbpclmG5vS/WHxXJPavCNaQ/aEpSRyeCFSCm4akUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYqep1jLDE3Xtl6dNncIJk46XRFBbv6XBL3SdSji7B0=;
 b=TGnbc6C94YHdUFXgiLI3wgc5w0keRCJ0UG9SX5KPThq1l83DU3br2LZ8u0L7wDmBRc/pbeo4Vmsb1F0LL4kEi//Fp2uSRWZ4/vyZ0CWM+wq3QXsCoKdoBzK5WpIAOktRBwakyjk6J7or82khAs94M4phLp6bGskxprr+UWdn5z8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:08 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:08 +0000
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
Subject: [PATCH v3 05/10] KEYS: Introduce a CA endorsed flag
Date:   Tue, 13 Dec 2022 19:33:56 -0500
Message-Id: <20221214003401.4086781-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:5:337::17) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b69f573-51ec-4da2-e1ae-08dadd6ae9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KfE1LGfGM6mULhjgEGxUMJIfYMUwM77yn4UEa7o5MB1InYnCjR2R3t2YBPrtuT3PnWP7LqfxMv7IAXyoHWsO2LXrO1kz1/C7JySom3euvtbzEhO1zOOIKbp+8N3WEOFvPoikjC480jVC8wySduz4AMIO/1AAHcIEhkOGXnZdMoiFS9CrPTUSp/w88OP6JYdXoJGFXsAZ++fNcsaLVG7sShm+94o2wpaJilJajlEyHdzHz74UlFpBIiiWFWGGcsUDYKNqnbYXvEJiQ8AuTKVPn5zaGCxhvzNi1CAwgBTzgw4DGQQHethGEBapKEYSrADW0Co2b/pH25mKrhxDe8z8ZcXrZA/bxv+mmrfSxpetTHLeGnRJerBflfc9TvYrjOvo6jSbZXZUSHi4vSVvaiqU7culldaq2R+0FVbk+WytouKlVx+215ST3aBc1MGAMNs85vqW2Vsbwwkldu1KNxWf/MLM+JyM0kmIQTE0E0asi6uBZCsLRVAnjkQtq54R5QyESOce9AbRTZ2okKae4dYQ2prh20Mk1pXIpXcny4201Fziv2cIKF1AxB1pTF2hL0necgKvrOTpGiQFzQTc8OIRgNmVeYrhDimYSPRXqgj9U3Lo3GoXkF4kUA5Rd0Lt2iQZgY1+j6DtGKgteVyaFNHrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(83380400001)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GlwcTmbuuWu2DCFESk9qhJtvvQxxyz9vdpQZxnWfwh3QToCLIEp3VIZD+bf/?=
 =?us-ascii?Q?drDxd52m2acqmnuSbuUYvwCcC9o0AsLTpasWd+yieTrRRIUWL03yLmQ9vTX9?=
 =?us-ascii?Q?QOkUeTnAkQTAfDLSkI9p5PyqRwA2kjSbZ84IxhrrKHMkkAVetKoiJ/AlbGvV?=
 =?us-ascii?Q?tsxMSJ4nelAH8xBx6QxMdWm2O43bIiLGcUIukhn1zkmy6JfLzpxzQ1BgYeL0?=
 =?us-ascii?Q?CQK8tKJKT4MXBFHtxKHE+REUEDJcMpjPZF+4tFY5kGDLZj7n5Ceb0+gO2ETq?=
 =?us-ascii?Q?uNPGDbwF5K0cqBmCyJTICAg4nHfFdt0QJu5Kc0d9LfIMFf852LgoyLCuyFGV?=
 =?us-ascii?Q?5d1AoeRlU+m37ImzM1/WzMxuQcC49Xve+j1M1jN7JnRZNlWLpQmyjB5cP1tB?=
 =?us-ascii?Q?FFiOwPceTXxym3aIkGWH0IEOim8Edsui/XNFzHXTIYnTeELHZhIee0TxLob/?=
 =?us-ascii?Q?ywmdJ7jBGQMfBRZswsrA1LPtf0Q4tpabp+WPW61v2P7XB60ZYE75DBZQg/YL?=
 =?us-ascii?Q?1g1uvhuX8vOY0wJB1LcmbPDcAb2KhisLLanO9hxFDMLFQKPKemR16oCLrjlA?=
 =?us-ascii?Q?Mh+mbEEVE6gq/oTGRVlzpVxSfs02HHC9ppr3arNI/5x353ZzrfQ4KnwaMlra?=
 =?us-ascii?Q?gAZ08N7la1yk9+jUju3ZkIbNLqPi29g0LfylNk/+wudKlUDsCpEocTCstVf4?=
 =?us-ascii?Q?32CF0mRw8m8AfGLR+Ik0LmuJSpE9GYivnEsVACJ1p0Jrk+qINMmNjQi2gJ41?=
 =?us-ascii?Q?ENLOyr/w79aXs3iLDBOWrGnjpAhOoUpBja1l1CV5GrA7L+CzqHMuVCNkwbfq?=
 =?us-ascii?Q?HlQfN49WSuGJeN1PKKs7Np2kcWTjwCvZP5qulrmSC+NA/TthBdjKEV74Mv/Q?=
 =?us-ascii?Q?sWk0B8ouTcujVGB8cCQV73SQDMiQZ4TfWplvb7AGb5buH63CJnQJ2EXGJKHy?=
 =?us-ascii?Q?iRrRUyPgkOvtAjhV9Mu/DpNUQyXqZPO/hF/O5GKsOmi9onCwd2PtnTg1NbqF?=
 =?us-ascii?Q?/RcmYqD8ndVVQIqXljwIKDzueGtpMJg9YbW2Q/UYzNOXgPiCO/fm02FAJqdz?=
 =?us-ascii?Q?37uz6pvwVhEh804jrfTqaVgVqPszzezvpLXlcEkPOSav3ofUHbWANSrQTV0z?=
 =?us-ascii?Q?2S6koykI4+0p4+Vn9vnyvrJTRpNWhP2GHfKk4G2QFRVXsWjYzgxmPyDGQ6tV?=
 =?us-ascii?Q?LLux7sn/DRzLfjdz/W7t5MsR0n3s3nOlkDM7r2CJ9+voZFOFiUHSAczap7t9?=
 =?us-ascii?Q?GITvCA0aTppwyLACmE/yG8ckSWc/sMiHk8ZdDN/8w2z8tUoi9BlCs8eLtrFt?=
 =?us-ascii?Q?LLZCDmFcGs18YAw9EIe0W2ketvHZ+mmLTQlM9t/kBgr4n0mf0yCZIbjQ7A5z?=
 =?us-ascii?Q?VxDrE10q6yGQSbCBEM0nXkSAfLCb8mchJovgJHrsbWKsbtuZ1P8NZDkaPTSv?=
 =?us-ascii?Q?N5exCvtaId1du/NeSP/J0GtZ9S2dnO7fRUtsE2CclSFZUQYO8MsGikNrjKTz?=
 =?us-ascii?Q?LJbvN1xYw68bdNWrkjLz2kVQhOB7p2j6Chgr+ePurbiLfvnUyECuNy7MdXJN?=
 =?us-ascii?Q?c9YK+mdpNx0ha+Kb3w7Z0hNKsC6nccLcHoKYXdtewx4faZo0vLF9jeuKUHDS?=
 =?us-ascii?Q?5iEsix0pItvLGbVsaFuReVA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b69f573-51ec-4da2-e1ae-08dadd6ae9e9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:08.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kvP4cnzbFj/zuCs+jlWlMUi6q0CtgwGh15VSCPLFJEOW364R9AgXYgKGVuyZb7hxtdiQfcMsWNeuSr2T/BscD2IyDQyNf5H8F8U1leP0yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-ORIG-GUID: LKRAEkKeiwSK7Dw34QaDyhKPw9F_wpHo
X-Proofpoint-GUID: LKRAEkKeiwSK7Dw34QaDyhKPw9F_wpHo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some subsystems are interested in knowing if a key has been endorsed
as or by a Certificate Authority (CA). From the data contained in struct
key, it is not possible to make this determination after the key
parsing is complete.  Introduce a new Endorsed Certificate Authority
flag called KEY_FLAG_ECA.

The first type of key to use this is X.509.  When a X.509 certificate
has the keyCertSign Key Usage set and contains the CA bit set, this new
flag is set. In the future, other usage fields could be added as flags,
i.e. digitialSignature.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 3 +++
 include/linux/key-type.h                 | 2 ++
 include/linux/key.h                      | 2 ++
 security/keys/key.c                      | 8 ++++++++
 4 files changed, 15 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 0b4943a4592b..fd1d7d6e68e7 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -208,6 +208,9 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 		goto error_free_kids;
 	}
 
+	if (cert->kcs_set && cert->root_ca)
+		prep->payload_flags |= KEY_ALLOC_PECA;
+
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
 	prep->payload.data[asym_subtype] = &public_key_subtype;
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 7d985a1dfe4a..0b500578441c 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -36,6 +36,8 @@ struct key_preparsed_payload {
 	size_t		datalen;	/* Raw datalen */
 	size_t		quotalen;	/* Quota length for proposed payload */
 	time64_t	expiry;		/* Expiry time of key */
+	unsigned int	payload_flags;  /* Proposed payload flags */
+#define KEY_ALLOC_PECA	0x0001		/* Proposed Endorsed CA (ECA) key */
 } __randomize_layout;
 
 typedef int (*request_key_actor_t)(struct key *auth_key, void *aux);
diff --git a/include/linux/key.h b/include/linux/key.h
index d27477faf00d..21d5a13ee4a9 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -236,6 +236,7 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
+#define KEY_FLAG_ECA		10	/* set if key is an Endorsed CA key */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
@@ -296,6 +297,7 @@ extern struct key *key_alloc(struct key_type *type,
 #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
 #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
 #define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
+#define KEY_ALLOC_ECA			0x0040	/* Add Endorsed CA key */
 
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
diff --git a/security/keys/key.c b/security/keys/key.c
index c45afdd1dfbb..e6b4946aca70 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -305,6 +305,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 		key->flags |= 1 << KEY_FLAG_UID_KEYRING;
 	if (flags & KEY_ALLOC_SET_KEEP)
 		key->flags |= 1 << KEY_FLAG_KEEP;
+	if (flags & KEY_ALLOC_ECA)
+		key->flags |= 1 << KEY_FLAG_ECA;
 
 #ifdef KEY_DEBUGGING
 	key->magic = KEY_DEBUG_MAGIC;
@@ -929,6 +931,12 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			perm |= KEY_POS_WRITE;
 	}
 
+	/* Only allow KEY_ALLOC_ECA flag to be set by preparser contents */
+	if (prep.payload_flags & KEY_ALLOC_PECA)
+		flags |= KEY_ALLOC_ECA;
+	else
+		flags &= ~KEY_ALLOC_ECA;
+
 	/* allocate a new key */
 	key = key_alloc(index_key.type, index_key.description,
 			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
-- 
2.27.0


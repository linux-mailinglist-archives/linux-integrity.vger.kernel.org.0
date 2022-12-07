Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D46645FB0
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLGRNg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGRNe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4FF45A1E;
        Wed,  7 Dec 2022 09:13:32 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7HAXZe003888;
        Wed, 7 Dec 2022 17:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=FNUcD2uSd5MyQDvdzTNeYf3NM/3TKwdkOVab2yNfNs0=;
 b=WElDAYYm2enlwwiFj0ytOyYd8TOuqRjlwnu0wRtk5yh5d9Rl9/gTX8sEFY8X0VUCoKXN
 lPt2TNekNdsv1/4sQaNcErJnClXWocj8lyHiO7GMKEFWmMc4i6TNpBAN+nPZ6Ujm/O5X
 w00qy1TiuRY33nTQPDKNzUqV6nAB/uidf6EbCo55KsnZqV9Xo8LniGuCAggSS+8CY80M
 EqrFJHeiycKRhLkG0GatnnaPvclZJ9XLSnESX6JvIvHXU3ErYffPzTTbpZh9woD0mOJE
 WPq0Ws5bsKkjVMIl5jTlA9j+1j0aZ1FtWzSkmjckyILcwou/vTXY6xQPoNMu9yz8cuz4 FA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6r0bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwbQs009733;
        Wed, 7 Dec 2022 17:12:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa69a430-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGfAbulwaQBeWPJrdvI6Mb1G0gFkpIqn+Jj1yvfyakeSCkCqwTCestw5gt1M21VmLuiLmcB4tCBGW/MPrug7EbVnKUd1tmWTX/yQvEv+cdtFE5qTvM8zD+O0TYv48Ejfq2C3Ro0QT3whPpmsIx247PrEVLGAI0GCExrIu6AGidvPR8hnQ5FxDVVBIIGlyTIQQ5b9bHByRZqjkN8OQsIbMma3l26GIQQvlSOZmb5Lvq8myqf0G2s4kc4bIy9P+d4UQoNOcwiYHtD0e0c6W7OmPpRNFkke8rmFI/QncEXFC/Pos7rlCoAhyNT7/A3h7bsRisPvxv9g+m2heNwHdkoYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNUcD2uSd5MyQDvdzTNeYf3NM/3TKwdkOVab2yNfNs0=;
 b=fdDP+FHzp2qe8siGl25K2QxgtlVKtqhhpmFKTOi1UA1ZWPaJ1yrFIa5wmxOgdBnADeUIxweoPUD9krj2NafjoiOWcuqcoZclTwzZMuE9KjYH+8+R3zUc7OwTkmps1+m2S7oYPpokD/4Dl31W1bppFwyvy3rSAEel1sReSKIgpmRXVZCMeK6YiPu0aAEooyfY7KiuPUo7AFdZ6jerVOG/jB01FkG/pkEpfTgyTile3PQ4oENX2h5ABUtLZnvlGzZ+S7G5DNUpMEduFjQdL8sSGqmK1HHFeHsfU4DedVzy3lPPzs8C7KpZzZR1gWJHdkKVzF+PI0sd2wU9qmq6JEfzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNUcD2uSd5MyQDvdzTNeYf3NM/3TKwdkOVab2yNfNs0=;
 b=HXFkqOsx1QbVPzPYFJ2aQYSbzDsULsseKsdwb6WetNpFNHzoeAQnORCjAaNwCj6K783t4wzW9NCzglBwettpPqKBJivaKKNYIHvQsI/v+5p8qPKi7WKdxsYHDesqOiIezaPE9d3qKohdASjS4h/FBequwvAXA4foXD2RPyCx2Xs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:12:51 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:12:51 +0000
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
Subject: [PATCH v2 05/10] KEYS: Introduce a CA endorsed flag
Date:   Wed,  7 Dec 2022 12:12:33 -0500
Message-Id: <20221207171238.2945307-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2fa197-eca9-457d-5cea-08dad87645dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qr5kPVm5mpnlYG3t1APEjYZ2aHuE2OOErnPyxPMfiVgRqLm3WNHW+J+NdbnVdw3ho0Pz3QkghFNsAmfUxAnT/8vDHs+BgEMFkkb4cvsBRp0Rx1pBoOwxMCeGlXXQSo9R0x1n4Sa0aIHsc5UCfn2gLgZPoZVDuRwtxRX3sJzW0OERuTzJqu7DVD6QbWvanMmNSGflVLYzO08A+6u5orhikHkEuEAfEDShtoC9EZcfVV8sFNZmbzO4vnvFFTx3FVp6+zvrXawpjvZxQbua+SlIXGVyhqI/pJ+V8DQJDbvSeBTPJaPuGgTpME7/RZXiFI8kiym4u0pI1975HdfSfQEjlVzW2e/hIuQDQBxjalhrzfyFubBrG6RGWmY4cS04iDAj4XRLYMiZLqmTyuE8L9u5RnH1XOgFhGBExz1TgBSRsGTF0GnDpOgMNdN0a+khEUh/U2fDFPBSPiSp53PNvP9hVFraVu1dl81Mi4SiKANj/XFBzdSohx9IN14TTuNEc5MSWJmjmZeV0G02l8ee2fqUktQPhXepBWBpPP1TeAMD5/UjdOWIMs4Od3GvpjB3IJB3X/eLY8KDS80ly3HmIXK8cx0AIv3we92qPdzK75KlJSqxKSsiVVIS6tJKFkLvg/Hg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(186003)(2616005)(1076003)(8676002)(5660300002)(66476007)(4326008)(66556008)(36756003)(41300700001)(83380400001)(478600001)(6486002)(6512007)(6666004)(6506007)(316002)(66946007)(2906002)(7416002)(38100700002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h4pHHtBCMl+n2uIALQTsAbH1DrZllVm2MRYXu8MyrtBF3abeKRu/VwBblnM9?=
 =?us-ascii?Q?Am3HAfw1BcvSX/9EYhusE29EmVaoAaInG1i1XqhHdUbaI3nah68fj+l+9xkL?=
 =?us-ascii?Q?57HFJZINyZ/IUv1nxp7Ej+3qaSGbaww8x+s/S3+lKC0AVj1AF+tRiIKpAgbj?=
 =?us-ascii?Q?PO/IpyOQAS4Ooz+sXeGDCOS8zGYij1a9n/b7IDQtEzUHVVKE25RMpCjUq2qR?=
 =?us-ascii?Q?tylYUgy3OQx1kr8lfkuMA59tsrs4vpJI3XFdlUTQfB6GhILgkVveVnWxPGRn?=
 =?us-ascii?Q?zAfjIhrnqOagRYR4I9l+x4aZg4BGkzvVgXlx7ajR22sX+OCBU1busOvlIDpX?=
 =?us-ascii?Q?/2yO1VFYRCwiqQNztARyNU+jhUD2ZLisQezUSaSuWejQMFrghj9Uo9GaUylI?=
 =?us-ascii?Q?YoaaBr2n9C4ttFWGC/LcIKnhN3LW4H2OGaesI9dfQVAox/9YRv2A9hejBHTB?=
 =?us-ascii?Q?XQAZGYFuk925yoedDr1gcLQ0Dt6naR1GFsa/5kZapHj+CdVugl49bMxz8u6x?=
 =?us-ascii?Q?rB3S56UKFtVOPDoA5GDDWWqGzbCkBdGNSkymcOn3N/UeX3/3BGlMYJMNGtxR?=
 =?us-ascii?Q?7yAzty1T+tuSROIe9/ZaJDXt3zCNK/0qnWWRx5GpoADkHTbMm3yxP8c7F0N/?=
 =?us-ascii?Q?ejxDXO2H5bO96Jib2PD4xJiVJJc3Scq3FwKRmJJQgZvC9c4DiQxI6rK8R5Io?=
 =?us-ascii?Q?FomqVHSrmQxYv+cPs5ay1xuavE8Lof0WAtcwAyEEoprRD8rn1rSkhQZtOjHs?=
 =?us-ascii?Q?pQR5poeZN9YOKbn3X7yvoNxBMZSVI+4Mu8vwOIWy1YrS2D5I2MWD6JGFGjRZ?=
 =?us-ascii?Q?Cae/PB8UKjWtIDrZz52TKp5S7k0OVHTibepEOgGAriGG98oYU4b3I1RCjJFW?=
 =?us-ascii?Q?yzqnHnPgeP2E5jUvp47UpoHxh3a0emnUl1Ao6UeYVSJMmSQPt76Bg3QhvK/4?=
 =?us-ascii?Q?cRnUcZqCIIPFJPxKh4dwBuR+W4VlmjrpkRbPmz6rPl6s8wu86fuUYOcwUzbf?=
 =?us-ascii?Q?RCxt5K6XAdPMRx/dQE9U3TBbVsP2LKU0hnVufgF36JKNUYlfMwdj+L+BKOlc?=
 =?us-ascii?Q?KB2LN0CTq4oMF4nhJ8qAbylPQGKAr7m4Kn+Iz2edPpyzMgmtzjoVf+gmFkdH?=
 =?us-ascii?Q?ucwVzp1FeYGwnlM9XtjLXEV27c5MkZM6+h7u5Y8Izqf0LwvyQxP3t5AimU4K?=
 =?us-ascii?Q?hX4Ho3+H9sihWd6WvXRwXnoNQVXVvfv33nqqCqSG/+Qk6sQ11rPWWWK9zt35?=
 =?us-ascii?Q?axvgtmNgrrOWhNNC8/5JKAAIsPppPX7ky3V1FBS7WHoLkZldHeN0ccdP8iay?=
 =?us-ascii?Q?tD8eP2x9WwAfs+2+w+Dv943RhFeBxh0kVi80I+1G9pMla2Nmeez34sPFR1b5?=
 =?us-ascii?Q?K0JV0415KF6ZWYRIlwxSmNIPuDId2EL4PDXj9Hh9E+RguerlCsRW9QGgTPql?=
 =?us-ascii?Q?kNVCqjbnbKyPoiEu7S4FwyO2pCYuGf6tpeDjhz9vvQcY4eWNFAvWYPbjUjmk?=
 =?us-ascii?Q?bADhKrpvrYteNW27XxaOnLKi/lUGAEie+qbFmi5xLvm7VVKmlN+FYrf4lhZH?=
 =?us-ascii?Q?2N0bLZvKaY2b78jajWN9AT08Aondrm8KTDzGN7rbn7Av+yzRkSXZ47qFmGTG?=
 =?us-ascii?Q?hoYENYCPXwQbovULrqXOGCg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2fa197-eca9-457d-5cea-08dad87645dc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:51.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1el5TTVlOCxDLfUEkMy3FeBxHshvhrN4JLsdkYMDk6NL/sHlRTD377U0Q2SzK1U3NfzoAwB4ZWmLg4q1odO0FpcTU9sXe720FeB39HovP+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070150
X-Proofpoint-GUID: nZnh0RXHzviYsynWwcqRDvXI8c4gLx0l
X-Proofpoint-ORIG-GUID: nZnh0RXHzviYsynWwcqRDvXI8c4gLx0l
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
as a Certificate Authority (CA). From the data contained in struct
key, it is not possible to make this determination after the key
parsing is complete.  Introduce a new Endorsed Certificate Authority
flag called KEY_FLAG_ECA.

The first type of key to use this is X.509.  When a X.509 certificate
is self signed, has the keyCertSign Key Usage set and contains the
CA bit set, this new flag is set. In the future, other usage fields
could be added as flags, i.e. digitialSignature.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 3 +++
 include/linux/key-type.h                 | 2 ++
 include/linux/key.h                      | 2 ++
 security/keys/key.c                      | 8 ++++++++
 4 files changed, 15 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 0b4943a4592b..64cffedc4dd0 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -208,6 +208,9 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 		goto error_free_kids;
 	}
 
+	if (cert->kcs_set && cert->self_signed && cert->root_ca)
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


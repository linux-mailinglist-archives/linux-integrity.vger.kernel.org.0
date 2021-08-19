Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92383F0F68
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhHSA0F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:26:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30906 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234885AbhHSA0D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:26:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0H5bp000812;
        Thu, 19 Aug 2021 00:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=2PJXkU1Y/Q24V+ECHBvDEgrn+MvquS6EKmsdYwwVkV4=;
 b=vm8rtFTerNXq2HM4ESfHYtIhFnNT+lWLHL3tcmKmIddNO/4kF/ocxqeCdiIvFZaw50TG
 0UwojLlLyB1K3i5dLUd6RxukT/1vsuHJ+AiuNSRe0E8Wv4n2zjmhkJ0RByR7i9ngitO9
 ZmLqv28r7yK6aKttuGftmL6P5meDfJpQVF26pQ0EgooZJ9Q13VhPQ5xXhZ8VVNTQ+ZL7
 zymZsar5Kj4t+16/Fpb4r9bGIi1eAE3NAWTFot2m/20ztY/Nv7H3nO0nrffS34cCkqNN
 r96yWxkle7fTMbK/xpA4tZimdSXfi22ysB2OonHEYG9AmRmW+hXMahChCBO1PyLCX+fC Rg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=2PJXkU1Y/Q24V+ECHBvDEgrn+MvquS6EKmsdYwwVkV4=;
 b=gx7zeQ1zevpgK8caIiNenacg+q/0Lsidh6RyKNXqa4ipLGWDWW54wQR4fL0VzJxMddgH
 EwEA3kwVqgMSKsh0rkLq5D3vJeML/PUBqGd82ry8qLS5TFD2WOUv7vnrgKX9dNtUox7e
 y3FM7KMvhxh6oQ7tMd9jwHwcvEuyZ2BMwXbRcrvy4KGpILi6XcUiiWMtT3RgV8WVAibo
 9wCNMkBBKdcBVruyAuajps+azCTjCvr54IhBSEgxvhIe3fb6pChUlrY22Vqkio/DXFp5
 SATI+WUlUXvMhAjB8lhLxxLPsiFLXWO2ENq52/i/OunpHRkcIK3mVstq9klTJCDk9f46 LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf4dn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:22:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0Exbg007560;
        Thu, 19 Aug 2021 00:22:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3ae3vjf8rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU3TrF3P9oJsziGwKZNQsPKACWKcrMiRxoR+HLv2l7bzwQg5VEbRkI3rdJsP4MbP8+sYsw0aPZIfbHP0KmVyzb6w9+0iywU2jtsPWiTI6pSjPPnxXs9JEH4i0Teyf3jtWeQe5rVbYMVnQDxxRU1ZIYPVjPZB884/L5D0co64/MmW6ty3oHmeVf22GX4CgTb5iC5vss2nWZ8K4MuT7BNgKnxYFYzi+Wx63rDfhkVEMi7UGl2LAmkHtTpzmkdWCaRb927P81KAMTi2+hB+IZmVhJgi3O/tlbIlMqX7jdPEmz+nWYshr3+NOcdkOVV93yckbvvo2250Qe2szDSZOd7UtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PJXkU1Y/Q24V+ECHBvDEgrn+MvquS6EKmsdYwwVkV4=;
 b=F7H+AYNnmfdVWVQbOGDpF4l9vpOiw4kesGHH0veehi/IRgPqI06cp7QoxpnNpN0AXlZpqGEQYB5tN09GgC1vZ2DgNw9nqgrGRsBLxnCWpZsXEfGpKXI5iJbesrOb2AzSME0N2mK+M9Ne72AcBSAc8sj2b6xEELMJCN5SGRDcms8XalcueCeCyHWeQ414w552RFYnG66l9QDVQljhbw9QA99IPyJDHw7b+IcLvvEFxObuTDs4EvRR1ARN5ksU0rHVokaFBb/LN7cczuY1gLlgo2nBeisrpcghLwhfIofK/fbnM2iBAAW2p/sAwWZnmMv6LezoxXnNEEMz1IHvXPSVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PJXkU1Y/Q24V+ECHBvDEgrn+MvquS6EKmsdYwwVkV4=;
 b=zUosXViWkeY8zuKcC63AU019vZ0hMZ7lfwz7jKtqWLAjCkQvJvR153U9A4bvrogS1sBFBZIugmW/O3IUDXYGHKfq8eCoVG7YtQT6mQ6IAw0aVCdH5+kHHZHOj0rgqYGpAARCevEccF5JFt1k32CPJ/5LjGMXnL2mBXBN7BRvjUk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:58 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:58 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v4 12/12] integrity: Only use mok keyring when uefi_check_trust_mok_keys is true
Date:   Wed, 18 Aug 2021 20:21:09 -0400
Message-Id: <20210819002109.534600-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe690262-425a-4a03-bc68-08d962a75b5e
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5116A02B07AC67359DF981F887C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQroZiACK2JTqF3CeNJ6IHyCVkoqAt06oISfuBK6AC6doDZya18AV4ihqpiFjMLdI0JvWCmXXIVEPakiswSYqFlzliw23elIEGX3OeMYo8Xb/GJrfeuVQs2WWbD7VjXOhGUXnI/Om1/tp6VtR21NrjCI4fDrET8trnJ6UPSkJQBBBnIJ5+SbZ/XIt3dzzPvf4ke3s869FGvxd0djhvjZJ/hQSE0LNNOh/btcFZdKfS3ai2XBqYU7CRfXwhNfn8MLcN+Jg25nKLGWZSmuabKEFaEgicpuCv69N3x1GGSWSK3qS4bacvluH4XLLuJqOGexBPJTa8Tr6QGcwfv49QwnhEc3Zaie+16lesJMos0yHdWWJnBoXtCDPEgaPDew9OcSMFowQgZ++BCYJlYYL/n/Zn9KEGZF3f1ekzlqUQI4nMbgOBKVcdK3JbxJ5jiHv3AeoVSZn6yes7IxyFIfoR1aClOmjj/fr/ntN1GWWlHYt57MkOxKmyQ9IVA+043DvJ0Z0Jql3LwtB1v8gypK3Zm9ne4OoxAPBYJgE6Oabqz/h3RTBMD0zosL/dP3qNYDr1JSuNKZO5nztJM8CqtSKfdG2+RuwX/FBMnVBw3JJRHqeshr6zEGaYILQBf1raqzpq4OjLY2j/IQRs7AGaHzvqiPGUaEpTIwxS1GFHOIMQrldS9MVYROgmveLivWeip2G2dXmXIZxkQ9Ydhu3SgKworfkIz6Is7vjpCYFL/7ohWppP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSgrN2G+f8nwQzDoummF/tb+x/wH0xeJwoIn70qb7r3xe9AIeJQd51bIsgot?=
 =?us-ascii?Q?UR6dH+LE2J9SZMRtTVgszAu4uzr8NF1v/O5+9fSamJiMR+WbmvK980dKjnn/?=
 =?us-ascii?Q?iyEXb5OoVYD9gsedu/VgMsOzGRxc3oPAkJJPzBg621dxnLi3lFjOoXVC8r8l?=
 =?us-ascii?Q?6Zigv5RGK/EBlrbJqO5Flg2KmcAJk3yhQDn7YjnlGvmp0mjAMrNtOHBhBL1U?=
 =?us-ascii?Q?BX7x3O4Ka9nqkcKV4GIudgmbKS8DWYmL8EsSduMfWoNQRp7706IP51+TUEaO?=
 =?us-ascii?Q?tUyWflZHgMvCgyDpIvz/EZkNQlZi/Ayx2wYeryIuMMK6kNAcaA3ZxpRKkTLz?=
 =?us-ascii?Q?rDWg0wCjb2PkOqddZO3tWwRmp30fewo0fXaNpQtOfTmWmsg69FMxDz62pueW?=
 =?us-ascii?Q?IiPp9XhOJDruOw7HR4m6usX0V697mtuMmB+IxKUYwR03FAg9V1EMjwAcGEUP?=
 =?us-ascii?Q?uCm59Y/sXodqYtCLR6bTG4th0wJJJpvfIIV0suHI7iSrT8yVkQW0G00Co/Vf?=
 =?us-ascii?Q?H7RCBODNKPPFEL2Noe/Uj/bMChs8S+isv9nxnYwJyT26myYW6uvrEM+TwnUZ?=
 =?us-ascii?Q?DLPTkFSM9Wfvw18MCriLkFQQS0M1+c49/5+JeO3D3Hn+Um62AJTtAsjeYJNb?=
 =?us-ascii?Q?pHff4HFWltsc5OHOKL4FQRYdASzDLEVO6YV73+GuCuoVZ/E9x7Ikqmp66aJs?=
 =?us-ascii?Q?rpu22OBSnlTvZwLg54HkYNeVZMekSDmflHkab/jsle6K+Jz6J6iTQxAz5Srz?=
 =?us-ascii?Q?asJWMDdqh2IXGN9u2v7OLR0Gs2e6vYgMCmdrIOXpx3HuESpc7dt5Y2lQq0wL?=
 =?us-ascii?Q?pN0FNgOt1//HECnGNBAIVGOige3qTAvJMcN27sThsWo9g4ARLdTkGsz7ba1s?=
 =?us-ascii?Q?088m3A9Vn2pq7vR6L5g6hA5h3+larSVjfvWQ35++BHSz/rxixyRIfnoRuqPU?=
 =?us-ascii?Q?C8RQq/v0AkfHbRiV38KhMc6a/iIly0M/9mZr5ZR+8u4BHqmypOJoWfYYgJLZ?=
 =?us-ascii?Q?9y34X1XjOLvYA8NuJXFI5W4xowCibrLs/ALtK6O/2mNVHJasjZIQE74x96do?=
 =?us-ascii?Q?wF5SUE0bl081nQ5Iee/ydC/qO6sRaFjm+LUXuAXM0JFPDdC3vBjifbmG/4Hl?=
 =?us-ascii?Q?AxdIM+8NGqVxJHl/vLSA16dUxeoNAmWZ3WaEGORHPN60g/poF+aDUxbvjmfW?=
 =?us-ascii?Q?shIg7+mC0hj1nHN0WZbB0pMLMQqd+01Cdq2DfbWn+khwwlvhoJnEIblepJ+Q?=
 =?us-ascii?Q?gkrKkM+945/HfvTLi0/kjV7A6La/xU2gHJsasJu10daAE2KRzc37woZ1BB3F?=
 =?us-ascii?Q?IkihzKrp6v+74rE3grey/+PA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe690262-425a-4a03-bc68-08d962a75b5e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:58.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbhlwtzHnSsO3IHDasEpmNZKXfEHGIWxeFjC8xyAF+cf8MHjotN/MReGZzqTSfQZJk0xAD2F4zRNIscJZ92Q03z8LbPyEXN0aD9ceQPL6A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: tswGBWOpeM21cxCuussnMHYJMnPApMQ6
X-Proofpoint-ORIG-GUID: tswGBWOpeM21cxCuussnMHYJMnPApMQ6
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the introduction of uefi_check_trust_mok_keys, it signifies the end-
user wants to trust the mok keyring as trusted keys.  If they have chosen 
to trust the mok keyring, load the qualifying keys into it during boot, 
then link it to the secondary keyring .  If the user has not chosen to 
trust the mok keyring, it will be empty and not linked to the secondary 
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v4: Initial version
---
 security/integrity/digsig.c                      |  2 +-
 security/integrity/integrity.h                   |  5 +++++
 .../integrity/platform_certs/keyring_handler.c   |  2 +-
 security/integrity/platform_certs/mok_keyring.c  | 16 ++++++++++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 0f14ffef9c43..fd255e5b6293 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -116,7 +116,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
-		if (id == INTEGRITY_KEYRING_MOK)
+		if (id == INTEGRITY_KEYRING_MOK && trust_moklist())
 			set_mok_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index be56ba49dc19..57683fdea2af 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -287,9 +287,14 @@ static inline void __init add_to_platform_keyring(const char *source,
 
 #ifdef CONFIG_INTEGRITY_MOK_KEYRING
 void __init add_to_mok_keyring(const char *source, const void *data, size_t len);
+bool __init trust_moklist(void);
 #else
 static inline void __init add_to_mok_keyring(const char *source,
 					     const void *data, size_t len)
 {
 }
+static inline bool __init trust_moklist(void)
+{
+	return false;
+}
 #endif
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index fc4ad85d9223..471bf103b444 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -82,7 +82,7 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 {
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
-		if (IS_ENABLED(CONFIG_INTEGRITY_MOK_KEYRING))
+		if (IS_ENABLED(CONFIG_INTEGRITY_MOK_KEYRING) && trust_moklist())
 			return add_to_mok_keyring;
 		else
 			return add_to_platform_keyring;
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index bcfab894a9dc..3dbb6d17e17d 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -8,6 +8,8 @@
 #include <linux/efi.h>
 #include "../integrity.h"
 
+bool trust_mok;
+
 static __init int mok_keyring_init(void)
 {
 	int rc;
@@ -67,3 +69,17 @@ static __init bool uefi_check_trust_mok_keys(void)
 	 */
 	return (status == EFI_SUCCESS && (!(attr & EFI_VARIABLE_NON_VOLATILE)));
 }
+
+bool __init trust_moklist(void)
+{
+	static bool initialized;
+
+	if (!initialized) {
+		initialized = true;
+
+		if (uefi_check_trust_mok_keys())
+			trust_mok = true;
+	}
+
+	return trust_mok;
+}
-- 
2.18.4


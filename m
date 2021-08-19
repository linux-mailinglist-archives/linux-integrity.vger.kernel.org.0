Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBDF3F0F49
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhHSAXG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:23:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28368 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235080AbhHSAWs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0HWt7029121;
        Thu, 19 Aug 2021 00:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=r5Q8wg3a9TlFXP/VHCrn3rzKthCgL1UnFvFQwZwILXU=;
 b=ICMF9u3DVfYc1PGH/y/CgCs1Ro2x5e9U/smlhI+Zp4xZwy1hpktJz4U9BR6PDiBVDjS1
 c5b326f3sK2+VcEqz4Ghrj+otSKwWvpF5QJMdZ6oHdgt0VqO6erBCHrNa94GwvL+Rs6G
 Exeg1iH8fFQ+MCk2pvVSkn7iYRGkv4RDwpqrW7pkCRMQErREST93+MEmhgxhM7mlxh6d
 6Nb2pZ315fIk5mJrCNH6W/YJAw3My3QiZgf5PzqOxi4S/byivVIMdukaT5680CJqmNmG
 hD2vondH9jZFD8b2UiSEVV6xJdd5DVoN/0TqZ3u7RwX57+RJ/qRmyl/keporuFOfpfPf 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=r5Q8wg3a9TlFXP/VHCrn3rzKthCgL1UnFvFQwZwILXU=;
 b=c9uj/CYVF8TnsqLY1N7f1bGthrOHvsg/lcbvxqzIQMYcCzo1MsugmZRJKU5ZXCkkfcZL
 N88wHXN3ag5TChCCKHaw2xUNi2MLeiuaSZOt6HEJoPLe2cc0Kno/pua1Fprhg2i/93ux
 Hmd4Xs9SD0dsNqyFT6AXOf2CV1uCUSov9Y0PIi5KuGES7merVJVkoIvyCSweJOUOfhQs
 i4HnVrjJEEiVLEHQe5FTxlnu1cPyjKoRqffN8LTl/tVPff8bbjvnSFRcIDOLdlzeZLE9
 9uC1dUsZ+XXxkLMiI3O5MUgum930JmmR5B1Ijt5I6D1MHVqQ4L111gtslZkXYINKfg5n Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmhwnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0ExTi007546;
        Thu, 19 Aug 2021 00:21:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3ae3vjf8j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+aLz09yK7Q27QOISH2XCD0SrL2QYkjAXA4eThEpGpJN0rKjePQPtSYedJdTSnElnvefKT/olXUipY/mtEymgoVrV+9t+h7j0rEmG7LkCtO6IVZPWE4KSmyd3fQTILvUnEeQJe4RBo9m7FwfX+LvsdgHZpo9JOJb+irLUwhi+GwiyOvBxTV1iAud+SzhUI+wUPgJWJyVg/2y8sSJ02f7jKSo92tWXaLcImcJsrx2wHOXzaaEJRbr1ZYoX4GbI1oOCLlnlWe1FnE0Hbx0fHDtNRhPnfnQetaB1aBGMMbM+q9Zwpn5KgSHsGek1D53S2iq9eES63VG/dIP2QRNFEzkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Q8wg3a9TlFXP/VHCrn3rzKthCgL1UnFvFQwZwILXU=;
 b=ma3UldG80nGGYOYIh817FcC+DlWn6mEV8naxNaSZi/hBuLVIpw6dNmat/x4Lvq/6IrEP9hXUDH1VWvb0hFr6XYV9rf+/amiulnByRcED/Nm+zRhTq+wNav04OYwC9tbN/ofgWoQN0hUreBID6byxmDnjFiHTEPLG54NsWURzfbss3ghsGJFXEra7FrjtwImooAtH29ZxLzdQKj8WyJrk5qTANXNKGLtgeJEtdN+gvjtKUgNugBkpBWLqqsOYb7cy8zEGUeAgjOzlSaEQG6rn+si3vQ2BmWJ6OUw17dwnqOVqTKZZQjCqbLU0wdJMShlGc6v567dWQfP89cXSBThcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Q8wg3a9TlFXP/VHCrn3rzKthCgL1UnFvFQwZwILXU=;
 b=lT+8MsF6vYV1YGdscLxuTZ8FMMXanzNJDK7daETiXrUTI8SBY1bs59XooPrMWc+9TQH8ouYmySEfklBzFcsQgGbe1KfzTvnDv0ozNVBHa9hNQzriVNOmNO4L2JHT4ByUGt4Me34JROPwwtatH1dHgwn818f4ePyz3WU1ekSpmuk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:50 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:50 +0000
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
Subject: [PATCH v4 09/12] KEYS: link secondary_trusted_keys to mok trusted keys
Date:   Wed, 18 Aug 2021 20:21:06 -0400
Message-Id: <20210819002109.534600-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696857c3-f758-4d65-cec2-08d962a75657
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5116CBF383E5D2E791FC735887C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12wTjsD+xhetaxvPtfmlz5ZAjZ5ytvXPxILoqkWVvGCzn3g6M3skyTO6Y5ivVdjvdQJuyXGOv9yeq0oA+JD3bJMzmayK+Ir2an1FeO7y41vQR13/+mMsh/lhOVgYIE9fCPep54L7scR/S5P7x7P5pnGVx7A3DJMzJeUVfCUaWBmf+z7GoTVLM6lPYVVXCjJlZlDmxoeNU/ZyhL+0GxSFATb+L+5ppTOJTVICuhaswhk6GoywIxybGpp6dAzKHNUFIMGxOaFDYwziRXhk8XHTP9ir9IwshRwg8xZOlXnFQT4E2Tclwx0NGKlP4UZcc79Xq8Kktbx5XohazxB6Df9qg6ZaQv64b5WDGFl/2F2tJ1AtHqr0TFJ89iWgPsks/lZEM/SBDyfAb0BZwQQPic8zmbic3rXDhhGz/2EHq0eOgSqxjAR0h2RwT4KKY8q1EtjjZVJVMtcignn0ufutxNUYcnodwevA/Nc5+lwhsWG5kP6zh65ACBGBMLhCmDEa20qH7gYHNaiMGQWAS0+OtFIjlMYa9M9AwbUPMIePQMWMBAq3AqZI2gA91YMX0dwBAshYp0ePT2hmqS+NnDS529cVe/EJ9RBM3CzG4wa79GFE9yZWcjoGzNax43vUU7I/cYe9B1LKO/jrmQ9ElSXhIYgUyTq4DMj70gurtShfCDv8zWSyYbedJwv+L5q5frnp9d8lYr7t7ztFRT7fr0O+0ZaikdCfMCn5HD6qVvUfrqRXuaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(4744005)(478600001)(6666004)(6486002)(66556008)(66476007)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?go38oO2/wL2W9HZdwpM2v0qEIlAiQquiyojpFRJWMljRCKXkM7sB7GRJyNW4?=
 =?us-ascii?Q?Vx2wxVhiGB8I/8sb252ZuwWZusmStM1SXQPFuOQyvXXIDvmrrygTJyxIOepe?=
 =?us-ascii?Q?kVk9tvlUyL70MG3aOFRZvAiB8xWM98b76HUO3uPwnnx7JcS/WCF1dcEmBmzT?=
 =?us-ascii?Q?aBvPNigpm/4RFc6I2WAkDJHqR/jQLlBK9GLJ+CJWSlF10UM+FgzSviDTsceG?=
 =?us-ascii?Q?2b0y+WSmMoujSK74QsVXfcKB6FPQxkWLxMyBTJu7cCcqN0wtfukNWwRbnadw?=
 =?us-ascii?Q?e9XVAfpAm8SumdmqGevq331TR4ISTDZX9LMu9VcdOSpd5JL3Dx/7cP6M4Sb9?=
 =?us-ascii?Q?2xKWhBll3ICqkIphJQhOHlNrnCvPCvr827MAzLU9jET4Pka2qfaxlDN2JyOa?=
 =?us-ascii?Q?8GmSrQR4pSQ5fUD2ahq1dXWk4LpFUQbAmH7jI6+SRYT0iLfIw6XKdM8ZfIPW?=
 =?us-ascii?Q?ls3RnexluQuVBVCuWVehMo+iNlOonq3MWYNYk9TYJNlA7DvSabN+VPK1TvMS?=
 =?us-ascii?Q?82gIciFDc8cM9Y+4wkWvdiGY9sSznN2UXvAgnp1QtPozZRkbNRggx97YlU6C?=
 =?us-ascii?Q?VM/F09zJltReH18+blSHU5bY5dKRqc/xZHfaXDFr81FuDam+DEE9XItgbHNp?=
 =?us-ascii?Q?dU+XC8V1bpdJu1aCrOjIckXaPIunMreHAgNKL8WNMoQuUPKvjOvwFbg9IVKe?=
 =?us-ascii?Q?gGEaVek6UfTDNSWHM+1agasWKVf27YIF3lzfmRHjmxcf0AA6X4y5xPH6Xzgq?=
 =?us-ascii?Q?9fLQegBASH3uqmzh0Yv3cR7WcizRuOPRaLjpPTpYAY3+skpcwLUXqwVDz3yK?=
 =?us-ascii?Q?vuPHDE6WqNaBKoUJ5sYxZfvDjSTcXDGpXCy+8Y8+vEq/Wo1McJj0GZvfDUiR?=
 =?us-ascii?Q?9VC7NxT4xlUXo/u7nPmOPO0LNxMtS/JacP2j/fRkTweZwt6THxC2NqC+5FRR?=
 =?us-ascii?Q?KQxUqLsiubFA/NbN57FwfqCzVlvBgztxzdS16RW6nccyMFva8ktFpumLyl+l?=
 =?us-ascii?Q?rEIZU/JUzprp8w6G5aC8YEKb35dVhBZ6GSOZaQHVstvkSw28KapOGM3spwzM?=
 =?us-ascii?Q?6etXI/WsacM+hiAQ0roxI1cGDo8jqroK5xhvABV1StYPKxksZdmUsBmmotcl?=
 =?us-ascii?Q?kiTXZ2mKzDrmsWKkGXhMTR+ymCM0lELSeG4LXhUiF1KFRlDzgkDSotveCjm6?=
 =?us-ascii?Q?zhh9o0s1jctanKzPfut7ZoVKlP3aDCbJxq0LKY9IsBQ9gO3wdvO6MhbwltwQ?=
 =?us-ascii?Q?3rlE018CeCuFfvQfD22uP8G9TgeNEuhWTTSYBauMNc3NQ7KVCFdXp8T0HOOD?=
 =?us-ascii?Q?wZ6McLV3uop/l+g6nfS99eLl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696857c3-f758-4d65-cec2-08d962a75657
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:50.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Er4aKOSm172D6dWniVh1wHm8Y6IaFXdSUAkZQKiFDgHHVSgOUsKps5ZiYtbBde/r2zU4Xguzqj8Klg/A6YE5BHFR8HfJIqH9lwvxdwwjdqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-ORIG-GUID: a2GOw5ImTmgPyod7VrPfG-j6Um87FHUr
X-Proofpoint-GUID: a2GOw5ImTmgPyod7VrPfG-j6Um87FHUr
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow the .mok keyring to be linked to the secondary_trusted_keys.  After
the link is created, keys contained in the .mok keyring will automatically
be searched when searching secondary_trusted_keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
v4: Unmodified from v3
---
 certs/system_keyring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 1c39af137cf1..4ce39b4ccc04 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -101,6 +101,9 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 void __init set_mok_trusted_keys(struct key *keyring)
 {
 	mok_trusted_keys = keyring;
+
+	if (key_link(secondary_trusted_keys, mok_trusted_keys) < 0)
+		panic("Can't link (mok) trusted keyrings\n");
 }
 
 /**
-- 
2.18.4


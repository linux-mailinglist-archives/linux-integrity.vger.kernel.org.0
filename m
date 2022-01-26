Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C500B49D381
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 21:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiAZUdD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 15:33:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42530 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230423AbiAZUdD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 15:33:03 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKPl4T018881;
        Wed, 26 Jan 2022 20:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5mePgKn1EmIAtauiDTFQCS/FxcygrONWgD04MNAuRHg=;
 b=BRdnREkL7RNNxDfI3gjUom4RN3pzMw+dbALmCxi6OWBlBvCrZddNs0Pm+OP2oXA0JPex
 qn9ck94R4kaLyBNg2BNArjHKpcjqLCGDUkmi0Z8eEDaS1A3xenbVaDbLP9amf2DFW0yL
 h/KJqjh7+TgdpXaBJTt4rdpGWcK8uAuBu4nrpg9vIikX8nx7i5oz6j5eiB3oa/CSiZ7r
 XaRwpv7BbfVh0A/96b6NvjXys2PGUsXHPsnykApcQ8ZHxIRt3a2NYAqp7Ibf5WW3xLfl
 V7lqGgaKJyP/Y5gJCdOykW/SXOoMNduXCXSNXP5eiv/MsP4k3QL1M6rW4SNAKeeseDRx Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7aydd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 20:32:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QKGogn082521;
        Wed, 26 Jan 2022 20:32:52 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by aserp3020.oracle.com with ESMTP id 3dtax93d2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 20:32:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoZLogL9jh2FA6bNybYU3x0m7wKf2MCV0t5TFHsNi+AOni4MY7KcGNg5wD2xwFlyXx0K6mvwIPTQanOUfyrxEuN5ybvHJpmABwxolVD4pYF9Xc9VUbTC9Sr/iCTi7aakUasd2FVl6kLO3YH0pxdbMP3nn7ZzUiXWYAO7+8pgRX4mn8kNnddXG4h+MhQSn6+0W/zrHwuyf5MbH3HZKQf9gwD9/Zbj2Cjt/2Nro7Cju8V+BUPS9PVVZJqrLVLAjUYrKpTkSyVMCsQsbrljiUtDvjE3j+3b8wX4b3zlzyJFds8cIiyiNm/agda73gUVR6kzBeFJRZOZGWhhIFMXP0cIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mePgKn1EmIAtauiDTFQCS/FxcygrONWgD04MNAuRHg=;
 b=QPn56fr682k1BEUEkpCKX5KDCiNMiaXpn3qMkiyLZixQ3M5tFr+ReDTatm0/fof4q6Af6ZoLTAh8DLcpzEVKYVHvKu6lDSDxALZo+DLsNSkU/wm+Bo8VKPaxs+8a5Yd4YIEIXdX1HOIDTv0RzYm2HFv8C6OSHcdIk5G6QrWi4CoYrhkTl04pzFMZ8Vb/S7zH8HvyBmpWR7PyHEBRs6T/YBzvcGzqWgokCV2eln8veuTJOgCt1AWFh9M73EE4Fvqy0/iW9Kwv6AtMX49OoHCJFEx8ihcA3LdwMuHG2wZgUc8YZvX9J0unsBz5Hm2AJ58e1cFcQKqIL0biDrPmtgEfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mePgKn1EmIAtauiDTFQCS/FxcygrONWgD04MNAuRHg=;
 b=gpXlsaFWG05/5Wk5ngLRHXwUEfDTus3zlYsn/kvfRVBvY8d1y8+KI4b+zXu3hA5tXHg51Ra+IVj2P38pGaIWDha6IWylwz5CGjYSRX6WRs9+rWaWKmiEY+v67B0FWHy7l5s8og1VgELxiW2QXMuDvcDCvvPr50vUSSWEKHupZVA=
Received: from SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 by CO6PR10MB5650.namprd10.prod.outlook.com (2603:10b6:303:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 20:32:50 +0000
Received: from SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::5c:9564:93b9:5654]) by SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::5c:9564:93b9:5654%5]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 20:32:50 +0000
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2] KEYS: trusted: Avoid calling null function trusted_key_exit
Date:   Wed, 26 Jan 2022 14:32:43 -0600
Message-Id: <20220126203243.231822-1-dave.kleikamp@oracle.com>
X-Mailer: git-send-email 2.35.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0136.namprd11.prod.outlook.com
 (2603:10b6:806:131::21) To SA2PR10MB4665.namprd10.prod.outlook.com
 (2603:10b6:806:fb::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d370849-b5a9-4667-a4ad-08d9e10b0589
X-MS-TrafficTypeDiagnostic: CO6PR10MB5650:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB565011B755B7B5367C6E06F487209@CO6PR10MB5650.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6lLOyaVBrl/+LDERvsm7Gg8AcVxrBVYjxNwv1ivTWxbhU8zL9l8GU9ddXOpp1FqT0osZZSVJ8gFfgcpbTGDNc789tA1rThtss92vDxnOL71GTgO+FTOVV4sB2xMFsGFhio1f73szOC0LuMT63IR568LjalH19iaBxBR546MaVu2+/qigc8NQUpiagwuWuEmyATnl3yL9v0ArNWm1ZmaKnpYc2PZez4qF8JYYC7YDu6VHA+/HWJSSikktEtfTRC399SDtGuHNZZU3MwK5VrfjlBZdcvBBESst8l87iZPXTDpWpafyX776eqHxKQ747rOadL0DhFUk1V8OyTU4XX6PhzYKvCel+LSOZ7sFHiiuWCv8BEPg4/xRuiN04n+aDVZ2lLTQOhmKkGQvdqcjVCIs/eXw0Of8zLKMlZMp2pwa1zJ99UIrE17oO2BdALMC1cHze2HR12jdtEUwihwCScJ7Dk4pAK0S3k18ahLfjpCSmLVd+uOPruUH13nMYIzNXhK5U0aouYGDQdZ6ceEx15D/gQ02xJE+/x0TtE8tU0jgdTskzYStbOtjHfHJPooduaPzmzx8X04t94NM531R8wg68VYlm7qTvjKpds44bx31e7sXSJeuUmjQZqFWjwlTT7t0qTGZ4jAkMbEyabXe7eUtc0AGKHx8lzQvUHS83xAIFym/QALh2anNgLJRiOpSu9V+8WRSB3Rd+/YBZuMt6v1Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4665.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(6666004)(52116002)(86362001)(316002)(54906003)(6486002)(83380400001)(6916009)(508600001)(44832011)(66476007)(66946007)(1076003)(2616005)(38350700002)(38100700002)(186003)(26005)(66556008)(8936002)(36756003)(4326008)(2906002)(7416002)(8676002)(5660300002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKDaoGeSppVV0fYAxsaZev9sOIhUilvr2h0LOQnJx9v966m+vaB8VOB1C+N7?=
 =?us-ascii?Q?rOB5wQqOpxSn9y9e8mCXVn0pL5nENCF8VnaJrBmdC6utcwSWIW1vR/UuLkyS?=
 =?us-ascii?Q?XaopfbDValVvbWG2DArgiqj381pST3G30VvNq/sNJcxJP7ykrg/6T78E5voS?=
 =?us-ascii?Q?8aOEj6W1b76ZWl5KENM0SNKFB2DvQluYLhuwc9/N0AkNpIHzq1dDjW6Darst?=
 =?us-ascii?Q?NBAn4Cp3/RJpSdyhtQQK1LRxBLgu+vDipi/iSFa7nqD1B7kOl3FExrKl+buB?=
 =?us-ascii?Q?u9hbHTw025FwwL+Rd3KJkTTcNuWDnNUp2JZFnuMIkk6TjTWFljCnsa3AmTqo?=
 =?us-ascii?Q?5jHqxBMcbNPvDAj7YsH84f55bW+Brq65U3fJ5Q5tnNcFsIrZfGkwHxqhRVUy?=
 =?us-ascii?Q?oq7LJSJmvOCmRgP8/jDtPKnZCPfg+O9iZXOZRxSRL86UGgvqlmb7S2XbVtcu?=
 =?us-ascii?Q?y+e0rI0ZoIVqfeA3MeHe/x9Cj6jESWgqOhLZ+ulNRUOTMQs8meh5xrBl3oQu?=
 =?us-ascii?Q?5DowsOqLaGE4dh+Vi+a6WxM/vWpomKPHziEHg3s05AOpXlPquGrBvBgkE2HV?=
 =?us-ascii?Q?lxkgse7peNDmfMCKpH7oyoQy/5IxNDprPBELjBt0zw3VBAfZ2EnkSKxWsC14?=
 =?us-ascii?Q?yiLsnfx6sXaWFr2/MUzpA3OYgGbKpVz+LsN9v9n/zvDwyKRLeJuB/ZKPhlt8?=
 =?us-ascii?Q?IRxcoqTcizJlkjYYGVXs0pRSZ/9ZNADl0X1m4zHhHx1JJ7Bkvga78C4a1zJs?=
 =?us-ascii?Q?JTF4Axt+IR5dUSyjWT14CD4WsotSj/lBWvDhS19inISwPGGRy/OJ2EbIlhca?=
 =?us-ascii?Q?1X8ENwXKoWz35nr9x10ENIruqjVOSK4l0iWTMeK5KZb16Zmp2slSMdaucbJw?=
 =?us-ascii?Q?FQ3X1p9+sG1HAjf1KLMLeWLQ8P++9+2RGl3H6x2ltPf4OXmBBBI3YxcwMbuB?=
 =?us-ascii?Q?R8qeargNL0i2jK770zbQ0+xynXBa6UPjTWPiSKkEdi1173IxHM297CY+Z0jh?=
 =?us-ascii?Q?Hb9ZxxfxLwRPz//g1KhhreoTJ0RsKLwd6xcP5nwXdOhPjZrXgyflmhBjps/K?=
 =?us-ascii?Q?tsf9Gl4o/q6O+ieUh3rPhH3S3l1CKdpDNivD3Vm8Tp/u3sfVl5Y65MBACBdP?=
 =?us-ascii?Q?jYsv0otMafwUF7M1L4FwIKMOqluahUchB4zip7dypbURqjuzNWs9wCV9dFeB?=
 =?us-ascii?Q?jTSMtSn8Al8ByovrpIyxd3cyokphxE8s9GTve3PMfkdmZCCgmMszSQvFnR8o?=
 =?us-ascii?Q?Ljz0RvBhpg8PhIQyyOWIn0Makw7yn8WoZ4MZJQsJbRz8aMg8At8nuy+RaZRd?=
 =?us-ascii?Q?3At/F8kEqGOyvqaaAC89pOvVtG9LCwAzY6nJYdP7MlT0lC8K5dEd2BpGhqV7?=
 =?us-ascii?Q?btxlC4gmqBYWSE4/tzK/y4nZtO/gJR9PS1Xzem+ADXIXmRAB0j8t0l9DMOgk?=
 =?us-ascii?Q?Rr9xqOdTGerSnk+/hCRp6DCvopJXjX3HXA9X1fFn6867bVGlKO7av8aoHowG?=
 =?us-ascii?Q?vD7iB+1YEndMFi0Zply92JGiAavmsFT0zS0a5Xnuiysmm58HMghHRd/cTFjk?=
 =?us-ascii?Q?srFS3308lAocu0DHeAc5+7uSR0nWM0LwnS8M9EEVMbIhrEIE1tOTKpbd9/Pu?=
 =?us-ascii?Q?BogY406v2QD+urTQuZ/kFvalwsUGn3+vK1BZnVkHVg2IngLoYTL8VTM22b6E?=
 =?us-ascii?Q?bxISIQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d370849-b5a9-4667-a4ad-08d9e10b0589
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4665.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 20:32:50.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuOaf7+X0ukQN+8+2vSk4cnbfxV2B329D1tud0OanCkr3zTAbvckXeDJt8nPvuAudUWHms9/wG62sfOKHe+3riBOfdYzTgjim1c94Fy6BAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5650
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260119
X-Proofpoint-GUID: MCg0VEQHAzBED6zxUemeFzRO5zXMq44n
X-Proofpoint-ORIG-GUID: MCg0VEQHAzBED6zxUemeFzRO5zXMq44n
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If one loads and unloads the trusted module, trusted_key_exit can be
NULL. Call it through static_call_cond() to avoid a kernel trap.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
v2 changes:
Header cleanup - removed empty line and cc:stable
 security/keys/trusted-keys/trusted_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index d5c891d8d353..8c14e04e2112 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -351,7 +351,7 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call(trusted_key_exit)();
+	static_call_cond(trusted_key_exit)();
 }
 
 late_initcall(init_trusted);
-- 
2.35.0


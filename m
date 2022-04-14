Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC65006B3
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Apr 2022 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbiDNHOo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Apr 2022 03:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiDNHOn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Apr 2022 03:14:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52248554BE;
        Thu, 14 Apr 2022 00:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiWFOREYODPh9eYuDj8IBvRf40F/Fl/wOrYLv2GncFUcPCl1ZrhthWnTlf7ZCuyICuT9OVVzzHan9iSds6J+hKs3wO10wlK8dvbhlUaPIZxE5NmhkoVk2DeIXRVh0Tx0BHi5rZ7PU67KTSJsGGAjbturt3WFQd5ZpPj4KTUgzKdQ+aGlNYvKoHOQFCx54uCmfWuFx8syH6HdbsJzem4atq2Rme5xpmS88kfSYNF9vs/v+l0UvraBl/w0+4wpiT/3kM5zVIEfkElvR7/7YOkNo1veJTfZ216mRJ3tML0LeirSBXbMWdGSDVMxNWdKuECq7LaVWCS03y0B5GqWjEwr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwsnkV8JxLx48pZfm//sInmlM0t0Uk+Yi8EAFIIq6U4=;
 b=c1bjXDn+AWrq3SO9k19zQZZyVb7c5JBEM61cJqI5y4tfkZCbDbhlhFZ63sKs/J7GCFwd+cMJLCC02/YWBDScSX19X8cDvJrswPphhOPVOJf2IaC9lfjhUOD/dxsM+lZZPQurn0hFgMER+GXZhYxOM7tRfe6HPL4D7f7e3Gm1CfHSdHzpOyGBTGiOF/4E6nDg5ffUfC4OrLgG5dz1MAEGMApcCHtzwWyq6jy8k2KYiQF6PW9OvZa8ZR3fMZxqfJxJUxnmWGCCVEJHvaHmGRXC2qSXH6l6u+Wago6x8Za0Ej1dMeRiD/3CfNnoIXaU5NLWn2uQYZv2PO8wJsf0kaZnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwsnkV8JxLx48pZfm//sInmlM0t0Uk+Yi8EAFIIq6U4=;
 b=bhiehbUlFEdmPmQKoFRnmtYqss9EKIsMkxpdSIpHhM7yzE21S+8HhDmMGKF+xYyQXlvbTOJ3Tt3bARNIcusVBhruTr9PzqUXqwmpTy7yOCCZRGd8CtOr7tZuuikW0Ab6GlL1AGh/+x+rKQ+uA7hJYJs8I6JIWCL/Ag+BJ9+3u9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by KL1PR0601MB4323.apcprd06.prod.outlook.com (2603:1096:820:75::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 07:12:13 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb%4]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 07:12:13 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] ima: simplify if-if to if-else
Date:   Thu, 14 Apr 2022 00:11:58 -0700
Message-Id: <20220414071159.77501-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea438ac3-1ad1-43b9-5893-08da1de6190c
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4323:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4323E95849559CED4188DE1AA2EF9@KL1PR0601MB4323.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39rA4IeKd+THTXLc5/4YaPuVtjwXWGjGP26yddwVtsUNfT0BCCJ1oDf6CQtxV1rcjSUX5QvNaSAUIEab9L8f4QulToiHgj+NMKSljY+lAZvZA3G1t/SNcVsmBdjEghlaKVaU/8tdN9m6bRzxv4Wk9MJ+OULgazuznKU5gJRFxU1bgp1XzHdr2+8+vd4zIclKu3bF3eonpgykLRuHGNV+UL96Y/ltkfY9oGEWxW+rZDW7th8mqlCnCdCTRUaLrJYDM76WibXlWvPepB+uquznBg9TMcc+ibDYhtIrftTFRIO4vWR0vqGfug4Fr1ZerNl229cmkq8TyOaNSoiTX53xMx5IDPM92H+FEGTo8JfAHGdoLpXHUkBAeddcpkfSnMeAstVpXsEbIMZKJGDEof4wXaHj/XZJk030g08wBS4/Rcx3eolgjJ5wdoSZw1msPul4OzSmlZ4/eg+ej4ZCmWqbX6fnDO54sTSpSAMRGeXyOZb1eFKUWoAVaoZHKjI+zTmREhjd07NI5sXA173y/1cFpX5bYvWIGZHxcBmmo6EKtWjsUzhH+aZEeu76kQTykQv+nTnNpKqFmD/DvtfNJtxr7ssm7yTwCd79rRZj0S+X47jttebPSUYGnLYHoQGPumHNmszrdXZPzELTuYkHfIPceWXLj16fFg+uPNjYHIHZHGvhZKHYjDCJvleqHgtBmp1uPmlWz9quzTZlqN1C8/bdbe2Sx8aHp9DETWBlAnp5XcBa7wtfF5lVaHq5giFKm7A6eP3v1Ib5P1athHvARDWGcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(316002)(86362001)(6512007)(52116002)(1076003)(2906002)(66476007)(8676002)(66556008)(36756003)(4326008)(66946007)(110136005)(6506007)(38100700002)(38350700002)(966005)(6486002)(508600001)(5660300002)(8936002)(2616005)(186003)(26005)(83380400001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xr/3qb6j4t8k4CDCqb0ER+1UaRX3rHIZi0aoEgNrQc/eImIy/Gs8rWjvoP9X?=
 =?us-ascii?Q?t1d2NbmbcQj4085/Iwos4edVUBKE8O6S1z31CtU673Caglcmha3MQ2tr5V5S?=
 =?us-ascii?Q?cBLjNqAtwAZfO2K6xCViIzc47qc5OxZGgDMUCFy2JPDP6grZdkVSIMxfq5S2?=
 =?us-ascii?Q?WYZwIISpP57ZA5ICjzIbfxbgjXx1mg/nlsZ1K48oz2ihE6sgpryK7uS9yItw?=
 =?us-ascii?Q?5GVcJCR+kjwgr+FgCp/xfb6wjIojk3YXdHgVms6X2RZFYv2yBOERtVp5UX2v?=
 =?us-ascii?Q?1yCi3NCb6okByl/RGsNnrGkpWm4QiR9f4nonETw+m7dlCQq8+WLLhT29az4d?=
 =?us-ascii?Q?vLHn+7KUiZIh3eVpygx5snBfN403S7qXUFVYXDP8Zd5YXfOBYTTo8KbshR53?=
 =?us-ascii?Q?Y1rEMt0A3AGDtOjiP7y0qM4yf6ZPj9zeO5oyjGF33/FCnc+0+fy89M8RJCut?=
 =?us-ascii?Q?Jf2iJt+cTag5u7dVSWD+fpXwmx09cyX9eZZR8smknovy+HaNo4kL8WsVY8AE?=
 =?us-ascii?Q?xkReLuPAIc7MStUZguabKSY/jrhC2CfukX+wW6Z2TboYVIHf7z7JWI4OLpu/?=
 =?us-ascii?Q?GYtXxzy0ULWYFxZe8wI8hm6MSYvt/LsbniJIaZsoDl9euIEsyGdNhlLOtQXq?=
 =?us-ascii?Q?QRgd3RrejJL/n7yzIy+E+v8fQ2E6ttlSA/oH1fF6AVjvMwVRsM8QIHgvn+bP?=
 =?us-ascii?Q?N/UIxztjgD9IpmGWG1qV1vqIR9XSnK4tW3eBRgzWUH15tDNyfHmiCoIt7g/I?=
 =?us-ascii?Q?mpuhoQX4qAFWiMEw17NUOi9DKjXqjd4pyCGZomzXZfTv+knwf7ddultfW1p2?=
 =?us-ascii?Q?2MPmWYkAp8/tmT1yQXlXJ5zp4xy+B+wMXdAcp4f7yxHKp90Q+nqQvzBqTkmA?=
 =?us-ascii?Q?/zkmDCCJ1o0JZF/uYdPgXg5so4tsUVDPTd33tRteEL/EPxxKyxXRnOfgPDpZ?=
 =?us-ascii?Q?hHrkQDRKecYGFCYILFjBTp9VhdgRSBPKdBKwMAms0jXjPICYMRqJcE+p1XsF?=
 =?us-ascii?Q?h3+K+M04U2MyZufqtQ9Q0OvFFNwz3GPZWXU4wHWNDYhxmy5QWeS6iwh+GeGW?=
 =?us-ascii?Q?eVC0VkZvoKq2uRlsIGgfZbn4PXw2Yyd+2K4RvDrNe6qcsXIN3bNPq3OWUq/v?=
 =?us-ascii?Q?zIaKXMqsV/pGvjHq6mDLv7u1jvBgh6I0VfSqEZke76q3WSRg0kPnQlu7iPbY?=
 =?us-ascii?Q?WkrikOsWdVztR9sTYj3roZWHAtS7M/zYgmfGR8XYczqotwvA3mS0CVYkbJIy?=
 =?us-ascii?Q?oRrmuk1u1B2HuyNG9HZpLV+AW9lbt5nRh9YH/0/UUd44kIAJS8dg/w3v+EwK?=
 =?us-ascii?Q?Yin/XO/Ctx8eBZ+LVNtghEWKzpXLy0fLMP7HfWgN84SZ85Qzw1ciBb+mdXDS?=
 =?us-ascii?Q?IWNZC2WrXA7Fabcx2kW5qIHOB0FLJZeVkkw+SMCTQII9lnIMEdJzj1l+uSX2?=
 =?us-ascii?Q?Yu6BuVyoOW+sjw+UD3+Iom9g+sCWtUsUHHUp8//vDVw1JuUidArRMw9xJzjX?=
 =?us-ascii?Q?E58+bvBuCU0bK8U8cmcMIr6too2zKX6rB5jEbB97DDvZ7Tg7LU9pHjJBy34W?=
 =?us-ascii?Q?lpApeIH5lqgT3JUlrAy7P//OS0sFZTmjvNfGbQGyCAIxRTHs/RbhC2903t79?=
 =?us-ascii?Q?7Im98wSMrqzVBx2xlvZ46x2e31+mIYDxR2WMcJ9Gv6j+MONCOrKpHnUUjs9t?=
 =?us-ascii?Q?gf5HXcgV7Gw8zBcZSAHb+ggH3RXE+crHQ/GUVhGW5cQplpQ+PwvgumdB0RuR?=
 =?us-ascii?Q?9deTVz8kuw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea438ac3-1ad1-43b9-5893-08da1de6190c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 07:12:12.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B+K4hwuhyVBDgUYiaImI92+2O76xST6GtnT0+IzP/7a8DSx+WaoUSDdcwZKH+I+IhsTU+2SQfIxf72ZgH7QgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replace `if (!error)` with `else` for simplification
and add curly brackets according to the kernel coding style:

"Do not unnecessarily use braces where a single statement will do."

...

"This does not apply if only one branch of a conditional statement is
a single statement; in the latter case use braces in both branches"

Please refer to:
https://www.kernel.org/doc/html/v5.17-rc8/process/coding-style.html

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 security/integrity/ima/ima_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1aebf63ad7a6..b2e43aad496c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1068,8 +1068,7 @@ static int __init init_ima(void)
 	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
-
-	if (!error)
+	else
 		ima_update_policy_flags();
 
 	return error;
-- 
2.17.1


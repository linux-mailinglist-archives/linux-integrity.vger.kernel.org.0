Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319602EBBCC
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jan 2021 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbhAFJrN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jan 2021 04:47:13 -0500
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:39120
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbhAFJrM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jan 2021 04:47:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiyUypGscHKcv/mhcBQz5Fg7VrIb1k4PxBUj83ZSS5Kdrkb6UJemLw77XzHVXYbd+05S1mh4c/C+j9vZsV/AgQkv7j5rZSsjTi0DUlkCwjBNpBYSQfku4rIUsKnrdqyHXQjGmG3eqiWwQGh3GaWpJBIqlyDLZaj1vfr7NAE+ZqmoaWy/YaJIz+Mr8AukCvYryFGz6fZtMHnfvBTK4dKIE46HyIUTV9Xd0ceP8vQwwjsMT9wTOtFjjoljz/x2N//LOcP23W5/rlNRQhsUos6LBSPmGLQBVEXDzfjY/Wiy/pyyAezKpxp9hiBoI8+lpgGq75+PpOyi5wGpkDVwcOiVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNKPypLTDj360lcIb2su2U9gc+ErcwrjHRxVp6W1HhM=;
 b=lDL39gcbh8f5v0EzrVSliHu+FkdsByxo1C5L+X9/2EdiVpkOXwxYU4jN0+LIGHoALm/QSdK20F6k0wtiVaPrVx7WJJVzFSqHUxeo73rNtVnRQMX9CwsQRm6Ooa/XyTDazkhlNVPsO8UuWYtY169OidQSrMr5hVVEhJITp+NlJuz6qCvne8WF+uFAR+uJY0F/iuPy5iZP99PyFMcehaXqkNO8LN8VhowSkpDJq1xAjTKZ/SiOcvdwRpFlpDHlcXuC3e2EH0P07DOCyzIoD+M4PdcxDx1obv2yvwqwSgtDKDhchE6evNp9I+nfTXVKky3otKhgJV9OGzQAVWlKDl3WWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNKPypLTDj360lcIb2su2U9gc+ErcwrjHRxVp6W1HhM=;
 b=bTf1ynIdmh5bchnSrypK5XKfQiyW7YXO+W98eS+WwqHP7ZuJdiuQw2++rQWa+WxlGC5Te1JmFXF3aEuFJbUszU0r/NI4JH4rPGgUSTNeCEWJL4yiHVaqe+KQKMsDKJVhBb1JFkCdGgeL+boBI24vVIKRaN1lALjucTae3br5qsLA7AKo0vFU7eittwwTYa1Y4aPkDloE6ZzDH/oOu9bKvqfWhMRznmUVOfDM/OJI/QNq4M+Ydlhe/X+6xd9cM/ejXFTY9/8IRxCLVVrs4xkh1wSlEOJc2NsMsENgI6AMW8smvT+qPQpl4DIQWM2mVpn9Y/EGRArrybcwuy7gN29Hpw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM9P191MB1367.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 09:45:55 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::692e:dea5:e2e4:c09]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::692e:dea5:e2e4:c09%7]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 09:45:55 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     pbrobinson@redhat.com, Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: [PATCH 1/2] Fix sign_hash not observing the hashalgo argument
Date:   Wed,  6 Jan 2021 10:43:34 +0100
Message-Id: <20210106094335.3178261-2-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210106094335.3178261-1-patrick@puiterwijk.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2a10:3781:662:0:daf9:2c4e:f3f0:a740]
X-ClientProxiedBy: AM0PR02CA0202.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::9) To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rowhammer.home.puiterwijk.org (2a10:3781:662:0:daf9:2c4e:f3f0:a740) by AM0PR02CA0202.eurprd02.prod.outlook.com (2603:10a6:20b:28f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 09:45:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aca6e16-0503-40f8-b657-08d8b227dd27
X-MS-TrafficTypeDiagnostic: AM9P191MB1367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P191MB136791D9B18B2E6E3B48389DC8D00@AM9P191MB1367.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aFxMDnrg+TMtkkaM+XK8oW8XaY37sdgpQnFMAD0ozVE60xaodLIENG/0dKuv+0FzFa1pqVrnPSpfToGWkx0GThgwPdU9lRqimSTJEes8o0+A1sqbPNmmvzVT1T3OPtyal8vh09O3FiKIG1s8Fm9dcebaH9vpuFMyKESc93njFIwVP87/9RbJIpr925QMs5sd7OVvTbyR+1YcyKFPkx/R9YAkONWxD0zSD4ZVo9GzhRZM3iESbFifVGSESz4u4pbaThbn4LPf79nJSG4LFih9hL7y5M5QLD3JY29kD6ozWS/c3t+nWff7Bqg4jji2crXwIHxXdHFcjd0RGw9FCdBmiH0Dhgh8hJ3TCDKT1CnPYgdOSgNqxnJ9THhJPK2QGIkwNbPUraa7lEuxf4gND1HVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39830400003)(376002)(346002)(6486002)(16526019)(186003)(83380400001)(36756003)(316002)(52116002)(8936002)(7696005)(107886003)(4326008)(6666004)(86362001)(2906002)(1076003)(2616005)(66556008)(66476007)(66946007)(478600001)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BZEYiQKgIfdTQc7W0c7tJ0O4cYqsHbFDafmizkgRmnz82XIgN8Tw7bcBI37l?=
 =?us-ascii?Q?ZzOyyI7UStP7sg4mtDHj618HfIRzVnlZC1/MflhX4IO20Xm/bbuBdzJ0m5kP?=
 =?us-ascii?Q?q3Fn4qtICbp+KhMPR811t4rzc/tkK9xf5Uo65tzbLozNzVlAa15QlWGHrOUU?=
 =?us-ascii?Q?SeGo6FqXSks2bu3nbF2IaBvB2QCnpXdApUZ0K5xpPnma2vSpe1qURjZ0j7Pp?=
 =?us-ascii?Q?ib3yRYeF0AG9/VfmdHWgbioB4oHPpvxwOer5HBBHneov4DjrbP6LysToGlRE?=
 =?us-ascii?Q?DFtL6iS8Ddj7Xl9JnkdmqI+x81x0N345a/Xk5v8gW6bMvZfP9n1r3pQhdAnr?=
 =?us-ascii?Q?sV+u27bFWB+XFBEM+kxO4ijsHVpUVsfh/HvZY8ePGrzFcstJtUc1IOANGNz7?=
 =?us-ascii?Q?VtW1iLiBvHTEzXZGU01pY1s41jNc8ag7FX9Fo+pXcK3s+jSUj4lBIsXLuT2t?=
 =?us-ascii?Q?GmnG2f7KO66EvVypViCfA+o5UqRSHCFT6L/BfUIknKLFcAlqpUACYX/8OmbY?=
 =?us-ascii?Q?VFWupDBSxYDA/MEYgd+M1T6OtYo1gB2Z2nAgitMyQLsEpbAk6SIzIk8OmzhM?=
 =?us-ascii?Q?0t2Pw+NC2Xdig6cLoA4bF21dASlBmjSsUHKhiIhgV8hNpt9vt6e86K2ewbn5?=
 =?us-ascii?Q?GbWFY4snyXhtw4euo/zwja0fic0GgQQbfwcHL26+6kQ5N1mJCYzPXMrmh5tQ?=
 =?us-ascii?Q?XI84zV5ExA4JXG15OeAUsKS+iU0cZ24G09rpcENuyKCty2PU/tlOd/CE9oOs?=
 =?us-ascii?Q?Hv4VfW8TA1C3zx7pOvyci2QZPbsFeXvq8tqATMJqEDfcALYEBKi7oMySaSjl?=
 =?us-ascii?Q?5evgeMFpFQspuE3aWVvYAJoGf3U72MVW4hMCRpD9jETGIKjbef/4+7v8VcTe?=
 =?us-ascii?Q?2DORXenEpzgiR3LnJTb2m0dDDsRkSrxM0zcPhJD4g4lGO6rFluuxzLTbGZtl?=
 =?us-ascii?Q?glq4bZ5zPwSl5aXDioSDuLQn5+4qQaU0+qSweAaavJGnLZPzhc7q/eT6iWZp?=
 =?us-ascii?Q?dbuzKD+7EesSTY9ZB/Z4yUEcFbbIXJv6PPO/I2mhTSq52lQ=3D?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 09:45:55.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aca6e16-0503-40f8-b657-08d8b227dd27
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91bv9M4bTllWCz4tCDLf6AiXI5YGrJUy3oLfiLlUmJUt6DSz61wYaIPqEEYPfeE3RVwfdhLZey3xIvCaXo/6hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P191MB1367
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This fixes sign_hash not using the correct algorithm for creating the
signature, by ensuring it uses the passed in variable value.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 src/libimaevm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index fa6c278..72d5e67 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -916,7 +916,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	log_info("hash(%s): ", imaevm_params.hash_algo);
+	log_info("hash(%s): ", algo);
 	log_dump(hash, size);
 
 	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
@@ -942,7 +942,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	if (!EVP_PKEY_sign_init(ctx))
 		goto err;
 	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
+	if (!(md = EVP_get_digestbyname(algo)))
 		goto err;
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
-- 
2.26.2


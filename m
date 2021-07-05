Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED73BC148
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 17:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGEQA5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 12:00:57 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:55374
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230305AbhGEQA5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 12:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRZN43sggVsJMbfxVxuTtFMBYZQld0sU5J1dp7ZDfQ3TX8KtRurHz0vuCndspnnptr+xd8Y+DRW8CXsv5qIO6QKMhGaOxhhra0cvGQrrSG8fGeSbEb86KFTLfK6r3bkA6miNmPxqQU/UamzlUK6+WEZG6FAMiNp04fZjjo5n6kGV/AM1y4zwe/IMVyUgkX0hguvc1bWzH8AxqmCV7k+sITyGL9BNBYD3VSPcGuwXlhSZKKB5s53nz9KbjvIP5jzP9kTT1p5ug+yiCVfcaR5vP69YcyAmaM7Nmvgcwo1ycHbSps0OwzpknvJNLc9fP4trgO9rI7dQUnluoicmUcZMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvfL+dx/ZpGSeTjhJ6vQ0fBW1PCpHR1ufFoTnSy5ZL8=;
 b=TvYmTr+WKUASlOZ6TGbfI+NkeS4CEfj9M+2tV8G8xS1Rcl8RVFCF2L/jVi6KJ5J5d4KS7cig+MEl/+JRI0lUL/IMub7ifAOeWH7JRiKQINMaMuqGEqZu6EaK4ih58yIYSXcI6cq5Slh81dMSTknkfHZppFqXznPXFNgTVRCR92KKuBqSEllgcwqLivgOgUGLKmBcf0wyHTl4svhj8X53fobRcrPwqnatn8WP+9ugg95Cqy4QqF5bMVyr1Ewu40+4vpD7pC9lXMKO/Pxqv1kBqdXavSN88fA+8wadazJNm29zeGY8/HREjYXVzOL0TuT2GxmzZyAzWglXQljiPee1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvfL+dx/ZpGSeTjhJ6vQ0fBW1PCpHR1ufFoTnSy5ZL8=;
 b=KOq/7mma2+E4BLuUGJypBnK9iYYd/h67Uj/4ZFf5K4nv+8c1DHvWfymMF7Q88qZsYVH13a/Ecw1Yejlvk3IlkFpivioR885VL81Q36MajwweojRQkesNXMDmeqqxsptehEynFV+cidQRXcKYi77HPjssL6gLcdLy30+y+rHeVNYRMeYiKeoOqhDftLLFTq3YHpfW3+fBFKWp5RYH9RDQ1kg9ZlA5x8oIjZV/B72cnEirsAOT9ANQ9rNDFkelOZQfeCBrU9VARGeehoofJ9GCx56oRLoQR+ivvCOQHn2O2ANd8QxSV1vVeDbAfRYOVZr7fJRlS5b8yVKxremQUMJ5+A==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM0P191MB0276.EURP191.PROD.OUTLOOK.COM (2603:10a6:208:45::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 15:58:18 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::356b:ce91:e81f:f038]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::356b:ce91:e81f:f038%8]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 15:58:18 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     pbrobinson@redhat.com, patrick@puiterwijk.org
Subject: [PATCH ima-evm-utils v2 1/2] Fix sign_hash not observing the hashalgo argument
Date:   Mon,  5 Jul 2021 17:49:49 +0200
Message-Id: <20210705154950.497359-2-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210705154950.497359-1-patrick@puiterwijk.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
 <20210705154950.497359-1-patrick@puiterwijk.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [45.148.140.78]
X-ClientProxiedBy: AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40)
 To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.patrick.home.puiterwijk.org (45.148.140.78) by AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 15:58:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89a7bbd5-5b9f-42b2-a9d4-08d93fcdb49f
X-MS-TrafficTypeDiagnostic: AM0P191MB0276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P191MB02764776A7D24ECDDD1F2358C81C9@AM0P191MB0276.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cHDgIINGfY5POopEOUWzCvJxzP9FiuhIBsOsOWB8Z45o1jNm/37HkhblS7MrmZS3uX1gGB3CrvmiIxnB2RO69LuMfATcwzm6sWQ4SdLNKbvphbwFnCRSmV4oDAGWt5B4ReSxbPuvVK1Mi0iaJi7tcIgbpFdkJY7qO6E6TgBvt3rtXgMnr+j81SWWJ366TKSTKbB0AtEIwcGWmWFPbAJ18WY7lLKgWI7o0Wfm4Iz9r63lKdFvjWMPZw6bFZlvxz2bn7kYBCb2xX8p8IFHmM/Ic2Io5ar1wmrEO3nPc8Ln99nY/kOgv3Nas8E1QZd5KQlb7VSVnghnuPCc+kzTRMJjmT6Y2Y0HESDwRXJomqLuWcdRAzFOFlE2QXL7OZHk0YaeWLr5lNBz+QqGtzr/43FKYjSETO1OypAP5j2ku0/EIvN2++l1kb4wBw8/kHpOMdg/l9AORlmuQSusdhjEE/YNGCa7D9sjIu5M6xe8nPJTVD0SIVp3hFUR1HwzXHHYgER1USZYjJwV+I7ezFout974jqkGIjQHBYnQiq/kGdkXtXXwNU2vNc+prDYcRVAlPdoh3bhpna0OxnyJKkuww9pRf9h8TX6gb+FKQ5n5mT18tpwvfykIIU+OjolG8PF7fe+2NxDEUWMsHVQl2zX7mSyNkcKXK3uDtcJNgbiSzlWGoo6lZboaqIRnWqJAscpvBrBowI+cjKagoVNYL/WIAIFdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39830400003)(376002)(346002)(6666004)(956004)(52116002)(7696005)(316002)(36756003)(2616005)(66946007)(66476007)(66556008)(6486002)(26005)(186003)(8936002)(38100700002)(38350700002)(478600001)(1076003)(86362001)(16526019)(2906002)(83380400001)(8676002)(4326008)(107886003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjUq6rbknUxbsu4xIDGGAgjOIrZ8f5du7cM+Uwy3ZoU/dngUMQCgswChto6g?=
 =?us-ascii?Q?tNk3ZA9iW4BWgfSA6yEnCwS6Bo+uaSw5cVox36Sr+4eQ4DrpalRb0Ro67UUN?=
 =?us-ascii?Q?HaiGnLAuywlDdZ7VwAPmyNJqFBexAKrp+Rzu248d1xKd5gzm/8R4QaQY58ID?=
 =?us-ascii?Q?Zm5zesl3lSfhbY4y44ixIXfkGNUsu1SNCE3J2hxLNX97eMfdjQz7Ck/r/lwy?=
 =?us-ascii?Q?Kim5+c/MwUxG8RpHhbqrPUslKOThh9OnwfNpwyjZdQm1DAFgLHKrfedkrvTd?=
 =?us-ascii?Q?j1xIGaymtIQvTqHXOucvrHd9nkME5KWd1/c2ox3PqYQI0+ZY+v+yRXqnfjI7?=
 =?us-ascii?Q?n0/9HoJ1C0c7u4A7Sl6J6Xfy6IBoyA4AmsNiRX6/VpfRUv3cPAw1hpNqnf8a?=
 =?us-ascii?Q?SZ1xvcSwYbLMf+xuCgN7JTwg0M+ntodXlVdAWFivU8yll5+84mp26ZFtumMN?=
 =?us-ascii?Q?RAmC/ktyZUS7bp1mW4HFHXbDcKuvg2D8EgJtVVPl+tkHjDwTBbcJbXhCSFrU?=
 =?us-ascii?Q?TIx2Qn+uN4IFYMyG19qEhDzZ7Qnrg/5zjSW3HlJZ9olFlvc3vO/tJ3rr4Nfh?=
 =?us-ascii?Q?w3TFIznzazd2cJ/R5y0errxAR6lQf1P/wRI+My9d+DlAaxWwO9aw6+WAHe8h?=
 =?us-ascii?Q?IhvC9c5mMJBPWE5FhFVz0eqgE9ogav1vj+Fe8ZboWYcNh9z8eiSZ0mimBEDm?=
 =?us-ascii?Q?Fdwy6fCewRyjNnzwQYe8rCGFAA8unz918bTgnP0o07cGDACgUXJblwy8AEGb?=
 =?us-ascii?Q?kNm3ta4a8e5vyeLHQbmC2WiKOQsvj4hMRbiP80n4zI+cr4QLAH8py2QpXGjL?=
 =?us-ascii?Q?tV/7kHUDOy2BFWzyXXHah+gGPrlL7siUgvQKbxoncaA+/AKfjHEGRf940+M2?=
 =?us-ascii?Q?8uulBplUvTwjYoGpTwbmHDsxaqG3qiltkk4V0f5FQKq/MGg1eq9omZHeVJvt?=
 =?us-ascii?Q?ivqobvgxEHrEiFQfdtpo0HC8qv0mcWQpRgOjwnY1mMVGbHOXPH4Dse3Lfnw8?=
 =?us-ascii?Q?47IFA8+ImYuHiW7X3GegjSszXduvYwpHl2EXy2S1PdrSasbaqcKXy4/TsEMU?=
 =?us-ascii?Q?HckSuc3U4fr+AerMXvzPTA4RkRDPEbFPfWHzWwRCpVfWvdOzpL/VprRuep4N?=
 =?us-ascii?Q?Ueg5IG8XJ3VI46NGuz9vkFpl01i2tJ7UkCI1eOH7xO/B5Q1caZbTQjG8GcWV?=
 =?us-ascii?Q?gVaPsERvNljKz+MbawLNeNiuaDAnwq3LQapYxm/Vci8NoTGou4hww7Yd7SLt?=
 =?us-ascii?Q?8f+rqk5GyAuOAMfFRxdZ9mPUdzRQpXJp86RUVYzVQIJ/NY8h4CuDDtyZEDSI?=
 =?us-ascii?Q?ntg1PSt6dsub8VLEDsZqNxJ6?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a7bbd5-5b9f-42b2-a9d4-08d93fcdb49f
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 15:58:18.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvTsF4wXoipYGoHcJxTq6YGFjajbggFyzFnE9sg5KLOFTgBqxfp0r5tVrSJXq7+z6gaZOSfD3TPjpMpsdEIOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P191MB0276
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This fixes sign_hash not using the correct algorithm for creating the
signature, by ensuring it uses the passed in variable value.

Fixes: 07e623b60848 ("ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API").
Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 src/libimaevm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 06f1063..2856270 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -913,7 +913,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	log_info("hash(%s): ", imaevm_params.hash_algo);
+	log_info("hash(%s): ", algo);
 	log_dump(hash, size);
 
 	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
@@ -939,7 +939,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	if (!EVP_PKEY_sign_init(ctx))
 		goto err;
 	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
+	if (!(md = EVP_get_digestbyname(algo)))
 		goto err;
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
-- 
2.31.1


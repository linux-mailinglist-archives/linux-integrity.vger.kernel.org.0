Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5877A0750
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Sep 2023 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbjINO2s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Sep 2023 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjINO2r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Sep 2023 10:28:47 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C0EE3
        for <linux-integrity@vger.kernel.org>; Thu, 14 Sep 2023 07:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvvgZWWhb26YATJ9ZmOTn1QoRtuKIaBIHDpNnLz/fuJ3rg8nwK+dRGxyBldqNTSFB7Agh06SEawUFl9/0iL79JsNw79dvD1SQhUPCEY+UkE+lhSMQLfh6oBggPTVnhQMP7HPIvbrQmUrsHtvZ0n+u8re6SGzgmvIeikgPU2T5kjKSyHTgy1+8paXac3Cjk1739tnDiozMDeQQjtV7suqYMiIptm0SwNcJsXQZuwhmsnV9R2n1t92m6PvMhiKL7HaENXOYjE/eiOq5eX9TTEVeek6/plWC5XLrRgMHw/tFRHE8R6KWJ6PO/vsWzMc/bjJinEZq48HnLNuFEvga9AXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OweYvp4Y3wfJ5eCBLl1Zes2Aakbo0bKdKpOc2/b/AZ8=;
 b=YMXmdwlANfDU5D3e2ZqTh0XqcM8PJagyaGY5NEoEEY0/5pL4eq/2+5CT9RaFAiAQxm9Jn6FfjtLWCI1JDVOojAowt9kDpa5af2EtYVe2/PdIk+q20FzLpU7rZCrFevwecMHm8OdwurzKn7am4W7E7I9IB0QpQkwgrNtRjYebyySeM2wJCmdwSuI0zu4mJ1LK9LrMDmpklwRrBJqboH6lesS1no29m9CIeBPH3UT4+7Ug0U1T1RtF41ZrJKxFcCjEZGTkoZRKa0l5KwZD1sS/sqtv8Ey7HCWCkHCXCT5Od6S9npzEWiR/Z/PbWXc3TEURJ4NRp3wMjKMhj125y29O3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OweYvp4Y3wfJ5eCBLl1Zes2Aakbo0bKdKpOc2/b/AZ8=;
 b=eJCutJrxdTegSTcwvBkUrWoheIyauAB2u6eDYp4ryXIJ0BcQ/rAiLzsuMJ1pXF4eIJgemJOYlEl6VaTA7b+g6qO7U/d1MWiE0uzTb8mNnte7r3XiokPzZffb9T8BumAl2gB8+rIyhKCIg8HbtxE7lD2EJys2UYqSSXy2jMZcGo0zMmV7a6jfET4kOXpgKyoS+35a1lNebL4SCuzL5JnmSvdDMo7Kig2+NZ7CJZdv8hxeI7bjpXTHwK3Wbw6XuvIAWPSNN0uu3Cb5HDRee+VA29zNZEafAKGnRurafFbqXPCH5mnHUnCTA67p9fNI8GFgzQyuYSJlbgYetO7WDN2lyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23)
 by DU0PR04MB9696.eurprd04.prod.outlook.com (2603:10a6:10:314::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 14:28:39 +0000
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::f749:b27f:2187:6654]) by DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::f749:b27f:2187:6654%6]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 14:28:39 +0000
Message-ID: <908e5878-61f9-7a75-129f-ac236fbc8b0a@suse.com>
Date:   Thu, 14 Sep 2023 16:28:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] tpm_tis: don't flush never initialized work
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To DU2PR04MB8790.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8790:EE_|DU0PR04MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: c958b206-1fe6-49f3-24ee-08dbb52ee3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PA4Bh8Zyrgxek8miW3AVYcDJxrlmrkVYbVuPTyS3dwrzSqqZ4wTo8b/7nfbFSf6oqr8OPYXOlREo7JV+9dpCeRPD0knz7AwaQjG10bNKqMqDPpMr+ZU6+4ITG5DsBE5ZVRcCui+Is2b/RTVncvaJ+t0tfT2LRvKKp54yzZgSLCaKKQAaRC86LqHYSXb93lL3qjdBXEPyX13Cws83oW2Rb1OQEIcc8do2elRqq//cHbQbZZnpn7Iy9S2poveMB/2Row+hVXpnx6y9Tpa9K7SwBuWBpATuHU3QAjBgDiBIHbq9i6L8bA23oGFNl9hCUAQsf7UDC/0MDrnWy8u70g7FUV+2Rdgq4p47q5d5vJB4HeoJ5caKVHHZFVVXR4aGWhiHf5KlezXBnN+IvwN9dgCrn2VsFmc86onS5SWYe6clGdbyZ50pSPv5DwPvljQNE+kOwN8SY8o578cbuDf+0R53Dy0IWUIwPTZqF4VAapyMOAq3fFIZQiWlWytuyyq68mGiwf9BnmUW4IufDcCxLT4yw+36EDYPyuvsj6G7fiAvpumflyjA+6wyKdF0P2jghCNwZMCAzpNZxn+6Uyn/uG852lNvS9+8P8Vja/OF9V+4NIVlE/QhzgSosEiFktW/r18ja2bdSXYRUerBAyZp+n202w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(1800799009)(186009)(451199024)(2616005)(86362001)(2906002)(26005)(6486002)(31696002)(6506007)(4744005)(38100700002)(6512007)(36756003)(83380400001)(478600001)(4326008)(5660300002)(66556008)(316002)(8936002)(8676002)(6916009)(54906003)(31686004)(66946007)(66476007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3ZRL0lRcjNJbGdHbDFaQk5nM254YnRvSk9DbDhFNm85NWo5cWVYM3hMTWVX?=
 =?utf-8?B?Q1dlVWNPOU1wWnhVQ3RKNzA5VGZjQUJPeXM2QWJQWmh1ZVdabTZCZzRlSkxD?=
 =?utf-8?B?MEFCMDc1aDFXV0R5WE9yOEhGSHZVeGtWYlVuOFZMY243NWZuU2JMMXk5MEp4?=
 =?utf-8?B?Y2ZGd2hOMDlUZnJLUkhkRHlmQXMyK3pzNFBZdHRtVWM2RTNRelZHU3JqYU15?=
 =?utf-8?B?L2NBQXFuNVJmUjcyQnZqbWpMVDhEYXdiSjlJQklqWGpzTzZ1dUNKamJaZ0xM?=
 =?utf-8?B?M0grYUpFUmJZVmEzY3ZKS2UzTitVSjFRcUlxZHBkYmthY1JqNzVvem1HeUlM?=
 =?utf-8?B?UFFIRWk4LzdOMUpsWXF0MmJPakNieDgvZTRCSno4TldmTENCRnBhby9nZ0FO?=
 =?utf-8?B?Qko1eXZ1dUNuSVFiY2tZbWw4YnNPbmFOT01sL3BVTUNWOVNWY1Z2Y3ZteGpJ?=
 =?utf-8?B?NXJmSDVTWG40bEdSaE1vZ3piNVJJTGlPeTNBUEVWNzJXeXYzekowa3pQZGtH?=
 =?utf-8?B?Z0I1SUo2a1d0MVluVVpaOHVUMWRySzVHT0g0aytWLzFzUTkxR3Bzdi96NFor?=
 =?utf-8?B?WXR4VCtMc0luZWxjUmpHVzRuUzVEaUFHTGs4ZXZoN04zZ3U2YTE1dlBjWnNh?=
 =?utf-8?B?c0d6M2IrRnJTbVhPNHRsL2NZVVRJSmJhTTVLS1ErcVF1U2dXNGg5eldtQzJx?=
 =?utf-8?B?MzRrdUtueVZvZE9pRC96MGNBeXRtZXc4VzRHVytUN1Q0N0RhdXVHVkJibGhu?=
 =?utf-8?B?cGxQZzV2TlFwWG5pMW9BdmNSWTlNNU9ZU0IxWFpGbVd0QVUwaXgzWkhKTDNG?=
 =?utf-8?B?aE91R3JwOEJCU01CdDlNZ1pqQkZtbENCZTdJVW1JU09FVUg5K3d5ditXZUNl?=
 =?utf-8?B?Z1VadlZuSHhFQmgrS0J2aVQ2Vzc3aVRwQjhuNVo5Z1RYQ3pMdmVkZFB1a1FD?=
 =?utf-8?B?OWVUTWNpNDVtUWpCZzZxVUJnU2FjTXdnR1ZRUGwwMGJNYWFhaUxCc0hQR1RS?=
 =?utf-8?B?NlcwV0c4cElKUEJ4RmVOalFPYmRqUFo2SFFiVy90UXZTNkpWRkxSaCtjMjZl?=
 =?utf-8?B?SnMvVW1zWTlhQ1pLQkczaHdMWUlCMFFsWEEyNmNQVEswU0RzaUtRR0JXRGhr?=
 =?utf-8?B?c0pMU21DclhiQ0RRSTNoUXozOFd4QTRtclRKbmZaWTV4cWpWSGsxZ3I2Mk02?=
 =?utf-8?B?bmhIakM1R3JMNVppQlV5WE96S3FXRmU4SjhwU2ZBSWFXSHZYbFc0SHJHY3VG?=
 =?utf-8?B?a0NVcFhtN2h6OTdOOXZSWWxML2lVdmZvT0V0TjZ1N2ZTUFl5S1BtWmZBWkN2?=
 =?utf-8?B?RmFFcTBqa0RlT1BLYVBLblliMXk2WkdTandqc21HbWFuV08rMm5RMktDaXVZ?=
 =?utf-8?B?cE9qTjhWZ2l5Z09rNnBGMkZnMEdIRFRZOS83WEhONFlxc1N0ZjJSUHIyNUR4?=
 =?utf-8?B?M2VoZTAvUk1pSmxPYTU2cVpnRXhxeDVsWkZuUStaUFMvMkRzWUVoOUNPOEp5?=
 =?utf-8?B?U3k0RWJDbU5Na204b1RsL3BOVlE4Q0hmSHVBQVhzSmNIY1RFb3dZSjBDMUUy?=
 =?utf-8?B?dllvdStLQmUwMnZoRW5FZDd6TjNHakNjcWs4aHpHUzVCZFlKWEhaeFU3c2JX?=
 =?utf-8?B?NWZHVzFSclpkWjJwWUo0bTAwd3FrYVdLejhIYUFzbTlJeHYyK0VhNVN4WkEx?=
 =?utf-8?B?bkpaN0RTUEhjZTRrTEFQVE9MSExNeHk5V2hmNWhWZ2xpalhVZlpUUlJPTWpT?=
 =?utf-8?B?YzRsRk9IUGxyQzkwOXAvREdxY1F3STNtbkE3TmFPSE11b0xrNGY2NXJHOSt1?=
 =?utf-8?B?di8zZWJhTnI2ZGZJdStYZUozeGJFaHpJZExzQVN1aUYzY29BRDdVQ3UxSnIx?=
 =?utf-8?B?RDNyRW13TEZicllzTGQ1Tm1mbFNjYll1aTZrZ2cyUUZUN2o3M1gyTi85ODBI?=
 =?utf-8?B?NnJza09FRHZ0SnBQTWx3Sm1Jc0piczNzVTdibXBkdHVRVWpQY1dJeHlWVTV2?=
 =?utf-8?B?WUd6TUN5eTBwaVJ6dFJNaUVZUEtIY0hYd25BeS9lcERRZmFlYjgwUERJc1JH?=
 =?utf-8?B?MGNPcXVpdFNKS0R2WGtwcVpZS280bGtXVHhFZDlGZEdacjBEZzhuekJlMkVV?=
 =?utf-8?Q?7BA7V7fX4p4FT4fUcX/bz4H88?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c958b206-1fe6-49f3-24ee-08dbb52ee3aa
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:28:39.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB0oa2JWNqSOHgmhj8XXkSyOlGimzpKEvonFFbE1XTeefwjbSKGfSovqPyKT5Z2cyZWulBL8NEDW53OsFEBxnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9696
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
called, in which case tpm_tis_remove() unconditionally calling
flush_work() is triggering a warning for .func still being NULL.

Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
An alternative would be to move INIT_WORK(), but where to put it is far
more difficult to tell for an outsider than simply making the flush call
conditional.

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1022,7 +1022,8 @@ void tpm_tis_remove(struct tpm_chip *chi
 		interrupt = 0;
 
 	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
-	flush_work(&priv->free_irq_work);
+	if (priv->free_irq_work.func)
+		flush_work(&priv->free_irq_work);
 
 	tpm_tis_clkrun_enable(chip, false);
 

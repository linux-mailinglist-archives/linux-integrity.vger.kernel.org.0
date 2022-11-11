Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03A626221
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Nov 2022 20:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiKKTjN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Nov 2022 14:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKTjM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Nov 2022 14:39:12 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022016.outbound.protection.outlook.com [40.93.200.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C6A7BE61;
        Fri, 11 Nov 2022 11:39:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G285MzQRrYzFIyYeIQA5R7s7qTxcEE8ZWyrGEFhpjL0jep3huI2FGiFrnHgw4VRjW8A9rLIg7LWj9nPBjx6PrGrwH97jWB3m9CX6Rs4tw3jShugLNenSAh5WGNA3vubGak29GI1DFGOkofWwgJAsFeqrA3Wg2JBNDbddhch8VJZp5g3FNjWAkPinUmGH3dOD4PoqCmTI1LmvJSiUeENedY5RcUlQs79PF0xAIeEAooDsWXEsYiYa8Qk4QNUQF2kNRumxgN9CjusynA8/F7OV75JFy95uurlvF+cN4GAvruhXluoBCF5+kF/BmP7C4AdPrbTyy7Bqe76gYqkLYkaqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZcRkiQm69eJitYu/z+P4Vn/Emzm0MJXaqcISMacPU8=;
 b=A1rx9bOvA+znD++rrYSf7lyJwI7qO/OLD+0KQ8JudwoKulYdbyd4POzA7dqM/5aJ9TohMy8hZuZFoeSD9WQvcOYMd0Bk9V1lrnniuU+KBU0cSpYW0Bhb5CiA5+2Vbvem0tbRwpsijTsZWiWFICsZopqn6LbFQIoXwMdkOOPwSNYYEKc9UPXYfy8m9sDUFO1x8pHZDsmdrTqM9rpYXAi6xL3ZF3z8BaxtICBQHZz2PT6DiQ9R+TXGeX5Jk0LiSpyYS9waqx+BrczGcOHz8upt2/+tIkkFj2ZZqPPl0QJApF+X80xsK4Z9ntlnuhy0eWXSP7eR07l9Lc6gDSJ0hBK7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZcRkiQm69eJitYu/z+P4Vn/Emzm0MJXaqcISMacPU8=;
 b=irgoOerRjeDthtPLOf/Tbj7Q+v/4uHK6KpRpDqZ89SPnhiobCxWQq+o7JdQ/4G6uibXIKi+ZvkBcYe/aTjrHv7hc4pJ+yWrO3T+A3kEZfi0JTOKZPoCzWktu6f/1BvLoozKgMdiibOPTwNWfWtJIuulQetw5jItdDWWVvnv2c8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN2PR21MB1502.namprd21.prod.outlook.com (2603:10b6:208:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Fri, 11 Nov
 2022 19:39:09 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::c3e3:a6ef:232c:299b]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::c3e3:a6ef:232c:299b%7]) with mapi id 15.20.5834.002; Fri, 11 Nov 2022
 19:39:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        tomas.winkler@intel.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] tpm/tpm_crb: Fix error message in __crb_relinquish_locality()
Date:   Fri, 11 Nov 2022 11:38:53 -0800
Message-Id: <1668195533-16761-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|MN2PR21MB1502:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae3e7ec-a418-4b52-1548-08dac41c66e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrIU229qqzQdmsX5SrUHkmJp9cGr4+jBM/bqylT/ZRCDJhHIWWRpOqSFxRv7XsJlsbzo1N1RFny6hs5M2iSTDBKokCHDOITkATFa36+E3fnRVFm+XT2zUoJqYdqeepqwpLDMF0YBCbAfmK2uW+wmIb+LMb97OHbB3DeTnRs2GaOjPoFvyPlPedV2AKO7CiL4fcavPxcioOyQlmdHf1CzCAGDULoGwAXBR0YPGkOQoH2MZfKu05D1S6a7hT0p6KuJh2CdsUw4xWxCY2wIsVXnlWoadMkcW6VOcpQ5oezAI5oGJI0I8mD+M1MD6/doRxr28tWXjpyWlMIZn9UE2daymZINNot6lX++rkK+ANLhBbNaKHeJYfdL3OipuVQ8gyV42FfbUBrEI8h6kqGvALwfHgzic6HLV/HsAqto0NM6V7aM61grOhWsF426lL3a0+EVaha4ruiU/pDqQVtL7SHUkBlV/kLF50zalGr2XwUXHarw/15Ye/ORMgD5TTdFCTkYDsQrPo63ogBduDgYpSZGJI+9L1BShsc1PKeA5ifdFJGE1H0wXyYMOjMvnv14H8v2xfezG4mho9Fc5UZeYGxDUv4nB7IK0sS0F8xv0GicxMDi4P3z1HkqlBkc37jTk1SLhX28jcdVdk/IjTm6JzRNbU/houqObNeS6XhZ19qqaKnsErsBxn48U8ROpmLdjtuTnDGCVPRsuNhT6Vw57eEYWIMOT0BH2jyD1S6fg4oQDwtytUf7tHcbNgpsJNbSREUfG2Q+MHifQyNAB2gk62DLE4leBMd035VvwKeE1dyFU1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(83380400001)(41300700001)(478600001)(82950400001)(66476007)(6486002)(66946007)(82960400001)(8936002)(5660300002)(4326008)(2906002)(66556008)(38350700002)(8676002)(36756003)(316002)(10290500003)(38100700002)(15650500001)(4744005)(2616005)(107886003)(6512007)(186003)(6666004)(52116002)(26005)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F7FIadfxTOwZJkU2LMC4anYTLz8Te7qQzvtgq0bYqokWeJNnQT3qY9d6b4Ja?=
 =?us-ascii?Q?hcImDBu2JQHRTVa0+o6YjpAQhQuDTzoVZ8zXv/+Z5IQxAV3jOOAzGdMi7maO?=
 =?us-ascii?Q?Y8idLGeYzAr1wunCpp3FUGurgrebOL3SRGgXtDbh98BkyFQv05Nx3W6sS8/2?=
 =?us-ascii?Q?gr4LITUU8XDnZDykoEZJbNkmBPb83nby5gEiF3HbV5CjG9KGaEwaNpx85nvj?=
 =?us-ascii?Q?XyH0ljg6Qu2ynwF0Pa+5OpXCHoc22bFEVL6bcpC2LyjTxC8YRNh+ammYg6rx?=
 =?us-ascii?Q?90ZIBGlABvfIUhN/+Isn76UEv0FUo5M+BZB+7vksIhUH62LEjfiw5GtNXwMf?=
 =?us-ascii?Q?vLPgxuuLsiDaTELvti4WjEWTsjL9yof+6Hs5f3SoKoDNDBmH0C9S8Dy7g0zc?=
 =?us-ascii?Q?mz+8yxMsGCCBvFaLR8e1l4JnQuPWZIOYBWWBDi+NNBh1Wb0g1dp94Im1GYux?=
 =?us-ascii?Q?cUA4bV6w1z/D+E4ng0j+huu0b28mVVaJqac5m95Za7nPAyxUyPh1w+yoa9hb?=
 =?us-ascii?Q?Vh+qkVlXZ2PmSQyrU/lIpN7OawBUXnK/REM5EYOb44zqPungdFxkObdggoW0?=
 =?us-ascii?Q?CuuHjngRSMV7hKFdphIADSzjX3w6KZ5dT5LOaFfWkIhN1ON6edv3GW60j7F0?=
 =?us-ascii?Q?ehEm1jOi5yl32pJSgzO3JfCTwHoOL1qXPzCxrMFIXOpBVUMF/1ejSEXUSqju?=
 =?us-ascii?Q?BnU2SIdqZM95omc2iTqZhFPGPkCTd1D2pG+yjT/4XNFXDEJFOSAcbcf+E+WB?=
 =?us-ascii?Q?vLoxZgluz7vQgpPNsgN1PbSW09VFiy2JXASurajSAcrIQjTVLKWyeqC/42qn?=
 =?us-ascii?Q?TJRWK6Twp2FjvHgYKVI0uejVswLIJE9G9qbwsQq1O5nqXlV+2d5WNEWHwKCp?=
 =?us-ascii?Q?mx/X0909+5o5YLYEEGZhDitBd3DVZ8RPbhk4aSrcaRHxewbSOad+tpJzG26q?=
 =?us-ascii?Q?+Jl+tvG/Gh+04rnt14KhiKSzh1gqUjy06XpdBW9jCeBHtXVnMvSk6TifdoeR?=
 =?us-ascii?Q?Kkbc11GhYjF2OkvVO8VhJpyHPj8ksDWU1X95jJrlJZB2xft9664T1BtvT/hq?=
 =?us-ascii?Q?jpxfYuaiy7fizeAQhHTrlPlPP8jWM8Q7iNhKLxoURdXYz3W8oRgMN8FSHo+l?=
 =?us-ascii?Q?efTD3p8VnEv/LyCF3hQkgu2+IYnNLGEy3jpHw0lnfKbdnn9RdIrBTl3/NCer?=
 =?us-ascii?Q?OBNbGoQE6LvW7m0O3uojExCYQliMHdpKixNZxN+wOdjo6OCm4CCfg/ZyBxAM?=
 =?us-ascii?Q?klye81DhSHI15DxYo5yaGgIZsnNvzFf2ZB5qF55oK7HSWM2r/enfGBN1wMcW?=
 =?us-ascii?Q?e+X/v6seZ80vpHsHVn+VDuWHUjSDfiXGb/sYPAXUpFoaEzNA338G/m3oulSP?=
 =?us-ascii?Q?/b1k1Fnp0jPSwcGmK5yLq1oiHXpJj0tJUjqIhB35mIYsxfgm127yGxLCor1L?=
 =?us-ascii?Q?SQ2t8heKAkv8oDSj6cuoe7aZZtP+fKZOyZMJEBOVi6onVL/8PtMey2j9A19n?=
 =?us-ascii?Q?AVRgEPNRYMWrLM/cbFDzhh/o51UxXeSeVbmADhAPahT1C3aKaNnmAtxdO79D?=
 =?us-ascii?Q?4NPwFnikAgB6se8vIc9JUZmuNOdgm1xBJAb3kN3l?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae3e7ec-a418-4b52-1548-08dac41c66e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 19:39:09.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmiGsFlRy2hqVksuxgZROl6bS4rotXa51sOj88/w7vp0Cath6v3rn/NK1z2kso8oEe5+YGY0asNqfVOc4tm3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1502
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The error message in __crb_relinquish_locality() mentions requestAccess
instead of Relinquish. Fix it.

Fixes: 888d867df441 ("tpm: cmd_ready command can be issued only after granting locality")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/char/tpm/tpm_crb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 1860665..65f8f17 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -252,7 +252,7 @@ static int __crb_relinquish_locality(struct device *dev,
 	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
 	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
 				 TPM2_TIMEOUT_C)) {
-		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
+		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed out\n");
 		return -ETIME;
 	}
 
-- 
1.8.3.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0815ADF0D
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiIFFun (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiIFFud (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:50:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5651570F;
        Mon,  5 Sep 2022 22:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlr3cw1nI9XcRK2rdK2T9cYZaK3q1+Pgu3/hbXrEjNGOsL7HLc4jckxoaZHSRBVmnIHnX5g3hhp6G9AJRrQvtOYZq/YGoo3L9WMQgrZ+hThyuNeqJxflK+sINDgos+/cGWxNm5S6x0HKy8jLfMOivW6Z6bTUenvxBibIVcdg1ze4T/NDe0u7Ny7g5+o7yADCSfnwy9P04J6WCIRnmQh/dLy4Y07EYEDAtNLrcPvx2U1U90oa4PK9tHMEmX1aruPTbqBUJVNHXjB+Xrt6uQWGncBmdZaYiMTVCyQhFtYobhIejDaZXyp65+Ol59+QBrxFoDSZ7NJDN3/Vcp//zDU+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RazakFVmBTP9WFcSFYdhGMh3h1u2i57yzpiLl038jIk=;
 b=elB30LNlg8N/Jt5g3X7XMM/i20MOoBivSWS9fRnvffbMOETCnmuYN8schytIvLUnsDsG8T+tDAm4TQh8qu6UiD0QksEvmAwnBroi+dwvnp2rW8JzXupAhXVwal99Ix4fIRWrDWr5xzEp6A9AttVPwNYcIXQfslIN8cA9RVXPmvDRPK2oC2MtvQpISWVuNnkfa/S4VjLsvL0X0D50Je4kjD6Qm+WBYg6h5YcVB4RHUBO8zjH+925XfK0/wt9f3ULlPEbLT25D3xTOwJ3ZzDpiZcHsL+Z1PPRJ2lcHLwfvBoE9LtoV83Do2wBL04YP2k7e/I6yZ3FIw1Ss+rGYr8HRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RazakFVmBTP9WFcSFYdhGMh3h1u2i57yzpiLl038jIk=;
 b=VY55izSkZMxSt+ctK/uvbeFcwz3AXwpk7+plO39hpDFmu/DY4uaMASk33Np/+3BfkirH8NE9SjeJVbpkvAZPvFjkUCNJ9lZ39+eFBvcBT14mB6Z+g4rmQYM+N9RJXBon/w17cgsaM19/5694spH1B1DmYfi0neVHE+TYoP5+srE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB6657.eurprd04.prod.outlook.com (2603:10a6:208:17a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:50:25 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:50:25 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     jarkko@kernel.org, a.fatoum@pengutronix.de, Jason@zx2c4.com,
        jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, michael@walle.cc,
        john.ernberg@actia.se, jmorris@namei.org, serge@hallyn.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        pankaj.gupta@nxp.com, V.Sethi@nxp.com
Subject: [RFC PATCH HBK: 1/8] keys-trusted: new cmd line option added
Date:   Tue,  6 Sep 2022 12:21:50 +0530
Message-Id: <20220906065157.10662-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eee0fbbd-a017-4702-9849-08da8fcbafac
X-MS-TrafficTypeDiagnostic: AM0PR04MB6657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNF2NJknmEjHh4xp3Ou6QB5dtppUl42YN8JcLBosUzyKTb/gr2xNCWm0+cqvAh0QG8DNM9N2Dbk30lGz+VmYF5uNotNn5RDkhEPlxAnCcP9eF1/h4hZK6DtFKd15vUk2nEBidduT1CcfAJ/Wxy9glpg5iJ2uQrdndRIGvZ1dE+xHK9X3OTvPIEtPIwhtbzxXadOPnqpsTu9Q/Os8P9VM/xHOy0kRuWKv1P9fHPq7gJRICSs6DIR6GqwKGOPSc18Ow03USiJEbzhGdwiiB2ALsEGSNpBBmeiAYDroqtth1ztLz1+OfUPJ9qVCpmsqfLETyBDqyEMyWwMX7Kbtg5iawXzqW7+heSvwcGdyEOi83198er4kzDyH9MBePlFmQyFN3V5FMAhPiPipNH2a8crFutb0EWsy2HjkK0ofgZecWYmVuk2qZoMBnc6g24NWP+PcZRM+T/IntO5yWZpQvnmHqGJFTswu9gazAy4SgzjAiFpHQ/L+hUtJphmgmLt6WCRjc/DDBygKzQIdj6O8xHcW53xZMEPi2oJNQdOQoCm+M8p1RuHGT6XvMLbcCnuOsrVlLBM3LM5ZYvgyOH6CTiPMIUWDFs0vXLulWKUiCRGL9oO1tUqwnsbx5TyEoWHAzFhMGrjNnHKaWrv7LwcNIivzAJW2atrYJWuZP6Z4rCc30dIj7rpVYCOQJV2XZpQvDKLTYr2AiDjiTJh0u8zYG3upyFLmYuRBv9vVV5xjNZpbIaq68fXJK1yudlP7NkCaDxbgg5ojy0/KYsDpAY0hawrbU7/vZBSzQeISMY7HoE5h6ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(6512007)(316002)(52116002)(6506007)(478600001)(6636002)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(186003)(921005)(1076003)(66556008)(66946007)(66476007)(36756003)(2906002)(8936002)(7416002)(8676002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?reAJlRn3f0q299wsAiMb5eKb6ra2LbXEBj4NhSxcoZhSug7BKtVhBjC5+aH+?=
 =?us-ascii?Q?SJUGWwFCJnLq1Platf7veLIKXTbr4/kUy79/CJEtDa4fp/wPGYXNuTZUz2Py?=
 =?us-ascii?Q?PgPCw0kwbmM+VvwD3ZDKI1OGWDdKoBkSzoaG9TKL6cvDvxUIBsBu+JG7xqRB?=
 =?us-ascii?Q?0/HrKNCGUMGh3MZcle5H4QDVYiqm27tB8+ANBFVYTlU3xJqqgLRh2IuFB4Pe?=
 =?us-ascii?Q?9eErTLyOCZV6h6cY/e91pVT0oeHprjt236T6OC9e16c4B62MsNjH0m5la3XR?=
 =?us-ascii?Q?7S0K/2+Ds/suqt7lprOx7+4lg4aQh8pjSvFGhTBIhHrpM+rk0bmgiO0HOiz7?=
 =?us-ascii?Q?p9mMLSOIcz+CfAqt5CPR7ajgHuEiQkmoBOvSMXKi+z8WVcB/FJQlw99uDtND?=
 =?us-ascii?Q?/vS3kENSCtiqW2VYERUao5HX9w6hI8dnNcHVOfjKvsOWcBnDF2riHzeBdyNg?=
 =?us-ascii?Q?XxAuE1YNsd+RJOxi82JAJpj2+RvohVNHnPofo40wKeAz2jmR7+yRpatbIy9+?=
 =?us-ascii?Q?1qZR4R2pzxkMalPkSiPhgD45L9JqIDCBLwVlOmnjK2jC/2yDE9P+IQXqv2C1?=
 =?us-ascii?Q?F8FeoPqopRMBHvAXZSj2qPvtuCohP3LkzNcvk+Dmtm+3AaBizUlAqkq3HWsk?=
 =?us-ascii?Q?VVaDaMiu3bxeT4Wn3O2onK5D4KXh+IhUHrULSNSt70kUOhIMpT3iiV98GQL6?=
 =?us-ascii?Q?duczwWFluBkJxTl6YzAEEUtnzeT+Kc4eziZcEH6vh4AAVjmxWK6DyiPPVMAk?=
 =?us-ascii?Q?BT4QSlOX2tn0xZ1Fytfymzq2TbYRL8EE40k+gK0EclTNF0QbrFQaGskHVAqd?=
 =?us-ascii?Q?fqJi7R7xNgrsmStjtCDoaaeHZGhasKcbhxKVBPl0ooJBGGC+Fq0vqaSa4GhH?=
 =?us-ascii?Q?kiTf7khG9CbFC2lJiZuhKdqBtPW3yOLzrYBrhmX6RQZrzjLUceTjWYvDPTDv?=
 =?us-ascii?Q?WCLVqaNndcnf6GL0vi3mkEOnBQHu+nq1LBt5UzdbOPeiaZjn1S4+ATkBbKIv?=
 =?us-ascii?Q?M+qdY/2oMC69YVVcOlt4yvmCuiWANYxthPmhAfry6ybmFsCpNeruff26iek9?=
 =?us-ascii?Q?u/GQccMTB+PymRg1DHbRUt2lVz5EWCyqC7EfJk6DoQQjo48JbttXArSwY/NF?=
 =?us-ascii?Q?DlU93XZ6maC3PG5IlxC92/oDbSPlynuBqdUxhPPchATiMcDtVj7ru9p5qREG?=
 =?us-ascii?Q?Kd+BUoyKpigjhh4NfqWI4uAu/Mv14cdiuco/hYUgZfoKl67Nar6p5jfWm2hX?=
 =?us-ascii?Q?lfVyXwqgd1i2L0UHnABPi/sxJfun6kijxa7lIlvRul+h2KQSQYv8DfFvdKMr?=
 =?us-ascii?Q?Pqw07oL/+DUEPB1ZVm7S4iFzOcZTFwsGeL850fwGktrv+aaprsFQooiyUb26?=
 =?us-ascii?Q?pjFgq93iOukabKiJHXI8HZBtzyWDRUJEVPqjxjifqk6pyNszWKcOI5C0NOYp?=
 =?us-ascii?Q?ZUyRnqEIY4RSifT2UUB0rmI/v6KvTiIvlI0xX/m2Dzx9wGy9qWJjBt30M82s?=
 =?us-ascii?Q?ZaozGHEcFS2qwYI6WikftmsTg8gSYfbA7zupd3TAa6AVU4RE8yHd88zWQiBV?=
 =?us-ascii?Q?jOrJBhE7d/rxP0S9Afd4vQcVflYtbp11PFB/1vVw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee0fbbd-a017-4702-9849-08da8fcbafac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:50:21.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiqA14YrXwAWsuEN1lng5PKE6ojQQ7+nQG5pORxC+X7/PPBbwXbqGkp2bWuJB+haSJ28IGeAApgOwL6Qfj0vCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Two changes are done:
- new cmd line option "hw" needs to be suffix, to generate the
  hw bound key.
  for ex:
   $:> keyctl add trusted <KEYNAME> 'new 32 hw' @s
   $:> keyctl add trusted <KEYNAME> 'load $(cat <KEY_BLOB_FILE_NAME>) hw' @s

- For "new", generating the hw bounded trusted key, updating the input key
  length as part of seal operation as well.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 include/keys/trusted-type.h               |  2 ++
 security/keys/trusted-keys/trusted_caam.c |  6 ++++++
 security/keys/trusted-keys/trusted_core.c | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 4eb64548a74f..064266b936c7 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -22,6 +22,7 @@
 #define MAX_BLOB_SIZE			512
 #define MAX_PCRINFO_SIZE		64
 #define MAX_DIGEST_SIZE			64
+#define HW_BOUND_KEY                    1
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
@@ -29,6 +30,7 @@ struct trusted_key_payload {
 	unsigned int blob_len;
 	unsigned char migratable;
 	unsigned char old_format;
+	unsigned char is_hw_bound;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
 };
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index e3415c520c0a..fceb9a271c4d 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #include <keys/trusted_caam.h>
@@ -23,6 +24,7 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
 		.input  = p->key,  .input_len   = p->key_len,
 		.output = p->blob, .output_len  = MAX_BLOB_SIZE,
 		.key_mod = KEYMOD, .key_mod_len = sizeof(KEYMOD) - 1,
+		.is_hw_bound = p->is_hw_bound,
 	};
 
 	ret = caam_encap_blob(blobifier, &info);
@@ -30,6 +32,9 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
 		return ret;
 
 	p->blob_len = info.output_len;
+	if (p->is_hw_bound)
+		p->key_len = info.input_len;
+
 	return 0;
 }
 
@@ -40,6 +45,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
 		.input   = p->blob,  .input_len  = p->blob_len,
 		.output  = p->key,   .output_len = MAX_KEY_SIZE,
 		.key_mod = KEYMOD,  .key_mod_len = sizeof(KEYMOD) - 1,
+		.is_hw_bound = p->is_hw_bound,
 	};
 
 	ret = caam_decap_blob(blobifier, &info);
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..7f7cc2551b92 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -79,6 +79,8 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 	int key_cmd;
 	char *c;
 
+	p->is_hw_bound = !HW_BOUND_KEY;
+
 	/* main command */
 	c = strsep(datablob, " \t");
 	if (!c)
@@ -94,6 +96,12 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
 			return -EINVAL;
 		p->key_len = keylen;
+		/* second argument is to determine if tied to HW */
+		c = strsep(datablob, " \t");
+		if (c) {
+			if (strcmp(c, "hw") == 0)
+				p->is_hw_bound = HW_BOUND_KEY;
+		}
 		ret = Opt_new;
 		break;
 	case Opt_load:
@@ -107,6 +115,12 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 		ret = hex2bin(p->blob, c, p->blob_len);
 		if (ret < 0)
 			return -EINVAL;
+		/* second argument is to determine if tied to HW */
+		c = strsep(datablob, " \t");
+		if (c) {
+			if (strcmp(c, "hw") == 0)
+				p->is_hw_bound = HW_BOUND_KEY;
+		}
 		ret = Opt_load;
 		break;
 	case Opt_update:
-- 
2.17.1


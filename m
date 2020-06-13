Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE31F83A8
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jun 2020 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFMOSj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Jun 2020 10:18:39 -0400
Received: from mail-eopbgr60091.outbound.protection.outlook.com ([40.107.6.91]:58168
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbgFMOSi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Jun 2020 10:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIgwSsbPHSgIQlWoDuqanegW9TYms7HFX2oFpFZvkPMZrW/bMzTwI4oauToJE4Y1p+sLIldD1qMCXwS31XPc16o9yYpFVXo7MEWLx6UTwtyKM/x3prsA1MPuroMxzEUtu1ollvBQ5Iq7z57MSplFvAUXJJwroQmjKU4Qhe69OUZQ33A84Up2SOc674IE19hB9z27DXjaeymoNCxQgcHgZJPuDkWxV6F+kr6p4FLcYnd0pz0LlOKTT1FFhFl/bddOjs05VLh+wAbA6xDp68ehD/fb7tqIi0uhDe+wsPWK4rdJFN2qv88YIRKi7BpAX2uP0qFq2Q7nTtzaKYSLT2FtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxvmxYBLwhu3F0XUVIT6NorZxiDlqgNzAAtpeIK60E0=;
 b=mh7kpHlePdvGkOgDbi1qx1k2/kvd5cBDuPl4K0+BZEPjygp8U1sh4bWQNYxkbrT0vOCNfLjCaGg3hbHAb1ixATV2nM4OjtWNT2Fhb2LLgqiZEI9yB3vg2IOIm3u1uQTjD0uHVXGQHHtZdwfNe28ppZ+Ywj4MKGMC/Cw2jqiTAsTmaTCGkxtrT/xBX8AEj5BR6UgGkMeZDsaTRCuoEP/foMTI+Ar8i+wEhRvsSnTcxym9tLvCoOLdgbuwgZJXiI31Xr5OJWxTi1ekVooqAL7y/FeLipXKuS9men2qxK4vSUH2s49IQgIPmIjkWBtI8A+I6iWH+VwTv1xhrJ3GvKovvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxvmxYBLwhu3F0XUVIT6NorZxiDlqgNzAAtpeIK60E0=;
 b=o3yLir7gJ4RYaVcM7pKgqKqKKWZ0276SYmW4HgtU4PMk9rATJ3I4KdXmuYCZl1q2eSI18yFKO904z8phDJhTA0o8kZAeJC/3n+5n+23cNnPY4W8ekw0eZmxr6Mzi9J3siaO5jwJlDO9FWwQQYPwCMVM5mo1NiDvjDmLnTfJrobM=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB4402.eurprd08.prod.outlook.com (2603:10a6:208:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Sat, 13 Jun
 2020 14:18:35 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3088.026; Sat, 13 Jun 2020
 14:18:35 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] tpm_tis: extra chip->ops check on error path in
 tpm_tis_core_init
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Message-ID: <8d6e3656-1662-dc71-8876-c7f0f11a11b1@virtuozzo.com>
Date:   Sat, 13 Jun 2020 17:18:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0087.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::40) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR10CA0087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Sat, 13 Jun 2020 14:18:34 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d0cadd-9572-410c-f315-08d80fa4a897
X-MS-TrafficTypeDiagnostic: AM0PR08MB4402:
X-Microsoft-Antispam-PRVS: <AM0PR08MB4402F49784AB0EFE47AE67D1AA9E0@AM0PR08MB4402.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0433DB2766
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPtA0tewdquBmajtrqVTRTklahZ268jUrPMfEGha0O34QqIyXJaAYSqYT4fH0RsD/cPwK7K3D1FlMj7DABohkFokpLW4FrYQBifUumCs6hCZ6daqB3fIqlyL+vepSEM/hFJgw/XQ4F+y+YY9JiMeBtUnrJLKj5wPjEx6Pwl4MaSo3a0pqZ9m30Cvhh++NFjCGm1ooeu22NW1HCe5DwlOmu0flVBzwQUar5Kq777h05RLsNJkQ1HJ9leWNFwKlwr3fKFKssBYUnUtOsXktJX13s/EIDpSrQLWiw5IV9GmPG0+kXHSCMehgw9nCk/CHT32iHWBfhpthfe9oUKaS/PXVGuoX3wA3JayPVW9u0W4Ld4y9VsvuRe38Jc40bdAFwzD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39840400004)(396003)(136003)(366004)(346002)(316002)(956004)(5660300002)(478600001)(8936002)(83380400001)(36756003)(52116002)(2616005)(2906002)(186003)(16576012)(31696002)(86362001)(54906003)(31686004)(26005)(6486002)(4744005)(4326008)(8676002)(66946007)(16526019)(66556008)(66476007)(6916009)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tsN8WOgESux271552M7DQxouRvG5PbOQ/ZYrFSMkbb/70LuMvo6iOLjVdnRTOtCvDCKYw6A2McDH5igHu8fmWqjIbV8tUfS5CEedz8+FyjpZ42w2y6nvt42uQWTGkpeS1ZKwx3OTkXDrTL1/Hk4vsQpfMpfAj3Pd+TLR34/dZ9NQkG4oGCyUmwtwhisyQpMvjVoF1PWNM6YxxOGYD2AB7q3gAMUhM9oMLHF0wytVq85dHZ9bea253Ju1kPYK09tiRjntauGwsu7Jujb5dgC/SxkxbEcGVsNdMWhxivORfh4uJJbP4yILPD71C8GfVi1D6EjhHJZGQVsY2WqiKn8+Aleqj/RC5bpQQfEGSH5A1PD9yXKj/v0l9iV+YZ6+bghVdG5D+UXT58et+31hXi+Y5PeBpVX0+ptLQlMEixrhUlIIsvSqlRB19O03tMx0zBeVM07D2Mv9qsWhzUIiGCxaCBQdt566pCNKATOJH5Tvid8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d0cadd-9572-410c-f315-08d80fa4a897
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2020 14:18:35.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocM6glBVUY3Sez4HTKBDSZ9WtBF8qVwYP61BJTm+TcetBdvmyKQ4RTPmZl5zMZ80y8e1i72ehTmMEXsgCMEuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4402
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Found by smatch:
drivers/char/tpm/tpm_tis_core.c:1088 tpm_tis_core_init() warn:
 variable dereferenced before check 'chip->ops' (see line 979)

'chip->ops' is assigned in the beginning of function
in tpmm_chip_alloc->tpm_chip_alloc
and is used before first possible goto to error path.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/char/tpm/tpm_tis_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 2435216..65ab1b0 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1085,7 +1085,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	return 0;
 out_err:
-	if ((chip->ops != NULL) && (chip->ops->clk_enable != NULL))
+	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
 	tpm_tis_remove(chip);
-- 
1.8.3.1


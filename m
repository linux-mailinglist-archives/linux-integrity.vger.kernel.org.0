Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF98714A898
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0RGP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 12:06:15 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2301 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgA0RGP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:06:15 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B982F9C7A7F77069A018;
        Mon, 27 Jan 2020 17:06:13 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 27 Jan 2020 17:06:03 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>,
        <james.bottomley@hansenpartnership.com>,
        <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to HASH_ALGO__LAST
Date:   Mon, 27 Jan 2020 18:04:36 +0100
Message-ID: <20200127170443.21538-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127170443.21538-1-roberto.sassu@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

chip->allocated_banks contains the list of TPM algorithm IDs of allocated
PCR banks. It also contains the corresponding ID of the crypto subsystem,
so that users of the TPM driver can calculate a digest for a PCR extend
operation.

However, if there is no mapping between TPM algorithm ID and crypto ID, the
crypto_id field in chip->allocated_banks remains set to zero (the array is
allocated and initialized with kcalloc() in tpm2_get_pcr_allocation()).
Zero should not be used as value for unknown mappings, as it is a valid
crypto ID (HASH_ALGO_MD4).

This patch initializes crypto_id to HASH_ALGO__LAST.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/char/tpm/tpm2-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 13696deceae8..760329598b99 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -525,6 +525,8 @@ static int tpm2_init_bank_info(struct tpm_chip *chip, u32 bank_index)
 		return 0;
 	}
 
+	bank->crypto_id = HASH_ALGO__LAST;
+
 	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
 }
 
-- 
2.17.1


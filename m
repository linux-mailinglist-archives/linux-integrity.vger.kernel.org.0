Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D429149C25
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jan 2020 18:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAZRqC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jan 2020 12:46:02 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60318 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgAZRqB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jan 2020 12:46:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 52F7D8EE10C;
        Sun, 26 Jan 2020 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1580060761;
        bh=PSyNgnp+wKPmtMYF+fst2Z8osfxDBUxdp0Rur6KrZFw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dBdu5qS4dEmHZ09LqBGouAo7m57m+Ru47YfmOxB/GAH7Og+45ph2HyCcXBBSxVVYD
         DCIlo80ZDWRfWJT5PHL+tsAsM9BKynJ1Lkr3RO7LJRsWU7TE/Pf03nRuZ0bxAFOsM1
         qjTUWAg10+4AtAQUKEHhQDMizwHMocc8hPG1SwnI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id awewdFBBS5GL; Sun, 26 Jan 2020 09:46:01 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CD2958EE0C9;
        Sun, 26 Jan 2020 09:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1580060761;
        bh=PSyNgnp+wKPmtMYF+fst2Z8osfxDBUxdp0Rur6KrZFw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dBdu5qS4dEmHZ09LqBGouAo7m57m+Ru47YfmOxB/GAH7Og+45ph2HyCcXBBSxVVYD
         DCIlo80ZDWRfWJT5PHL+tsAsM9BKynJ1Lkr3RO7LJRsWU7TE/Pf03nRuZ0bxAFOsM1
         qjTUWAg10+4AtAQUKEHhQDMizwHMocc8hPG1SwnI=
Message-ID: <1580060759.4964.12.camel@HansenPartnership.com>
Subject: Re: [PATCH] ima: fix calculating the boot_aggregate
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Jan 2020 09:45:59 -0800
In-Reply-To: <1580044434-9132-1-git-send-email-zohar@linux.ibm.com>
References: <1580044434-9132-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-01-26 at 08:13 -0500, Mimi Zohar wrote:
> Calculating the boot_aggregate assumes that the TPM SHA1 bank is
> enabled.  Before trying to read the TPM SHA1 bank, ensure it is
> enabled. If it isn't enabled, calculate the boot_aggregate using the
> first bank enabled.

Isn't it about time we shifted IMA away from SHA1 as a NIST deprecated
algorithm especially as in this case if someone can manufacture a sha1
hash collision, they can fake the TCB?  I think we should always try
use SHA256 if we have a TPM2, then fall back to whatever bank0 is if
SHA256 can't be found (that will cope with DELLs that violate the TPM2
spec by disabling the sha256 bank if the bios setting is sha1).  This
should also cope with other ODMs who violate the spec in other ways,
like not updating the sha1 bank but still leaving it allocated.

Mechanically, also, you don't need the found variable, you can see if i
reaches the max value.

James

---

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 73044fc6a952..f5f7a3aec826 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -665,12 +665,29 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 	u32 i;
 	SHASH_DESC_ON_STACK(shash, tfm);
 
+	if (ima_tpm_chip->flags & TPM_CHIP_FLAG_TPM2)
+		/* TPM2 default should be sha256 */
+		d.alg_id = TPM_ALG_SHA256;
+
 	shash->tfm = tfm;
 
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
 		return rc;
 
+	/*
+	 * Check the TPM default bank is allocated otherwise use the first one
+	 */
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
+		if (ima_tpm_chip->allocated_banks[i].alg_id == d.alg_id)
+			break;
+
+	if (i == ima_tpm_chip->nr_allocated_banks) {
+		d.alg_id = ima_tpm_chip->allocated_banks[0].alg_id;
+		pr_info("Calculating the boot-aggregregate (TPM algorithm: %d)",
+			d.alg_id);
+	}
+
 	/* cumulative sha1 over tpm registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701B276BC24
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHASTb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjHAST2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 14:19:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 750502134
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 11:19:27 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 99EEE238AE9C;
        Tue,  1 Aug 2023 11:19:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99EEE238AE9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690913966;
        bh=8ydQCAOPOcf0m6nyFkBYLJu31rgHvyoufSpVxcSoJOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTQs58MKcYI5m8cZi/KfepiNoc+9Qzhe8vHJiHCzwb1zY3l/8Lg/Jrs1O68GhFuAX
         LAyY8YhGdjR3djBs0Ot+of/N6uUFngUguWtamjN0HGQ05U7AAXOGi29drdHbumARAp
         FmLnw54tQJmRZEShydnAXu3RUCi6cIsbTLMXHINU=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Date:   Tue,  1 Aug 2023 11:19:12 -0700
Message-Id: <20230801181917.8535-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TPM2_PCR_Read command returns TPM2_PCR_Read Response struct[1].  It
contains pcrUpdateCounter member which contains the current value of TPM
PCR update counter.  The update counter provides the number of times the
PCRs are updated, which is essential for tracking changes and verifying
system integrity.  Thus, subsystems (like IMA) should measure
pcrUpdateCounter value.  Although tpm2_pcr_read_out struct is returned
by tpm2_pcr_read(), it is not used by it's caller function tpm_pcr_read().
Further, TPM2_PCR_Read Response struct and pcrUpdateCounter is not
available in tpm1_pcr_read().

PcrUpdateCounter is only needed in a specific case (IMA for measurements).
Changing tpm_pcr_read() and tpm2_pcr_read() function signature to return
tpm2_pcr_read_out struct would be a more disruptive change, since these
functions are used elsewhere too.  Creating separate functions to get
pcrUpdateCounter when needed would be a cleaner approach.

Add a function, 'tpm2_pcr_get_update_counter()' to retrieve
the update counter for a given PCR index and algorithm ID on a TPM2 chip.

This function complements existing TPM functionalities such as reading
and extending PCRs, and enhances the ability to monitor PCR status
in the Linux Kernel. 

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
Section 22.4.2, Page 206.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/char/tpm/tpm.h      |  3 +++
 drivers/char/tpm/tpm2-cmd.c | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 830014a26609..60489f21d3bd 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -288,6 +288,9 @@ static inline void tpm_add_ppi(struct tpm_chip *chip)
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
+int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
+				u32 pcr_idx, u16 alg_id,
+				u32 *update_counter);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 93545be190a5..55f4e102289a 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -216,6 +216,54 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
+/**
+ * tpm2_pcr_get_update_counter() - gets an update counter value for a PCR bank
+ * @chip: TPM chip to use
+ * @pcr_idx: PCR index used to retrieve the update counter
+ * @alg_id:	alg id used to retrieve the update counter
+ * @update_counter: output update counter value
+ *
+ * Return: Same as with tpm_transmit_cmd.
+ */
+int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
+				u32 pcr_idx, u16 alg_id, u32 *update_counter)
+{
+	int rc;
+	struct tpm_buf buf;
+	struct tpm2_pcr_read_out *read_out;
+	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
+
+	if (pcr_idx >= TPM2_PLATFORM_PCR)
+		return -EINVAL;
+
+	if (!update_counter)
+		return -EINVAL;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
+	if (rc)
+		return rc;
+
+	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
+
+	tpm_buf_append_u32(&buf, 1);
+	tpm_buf_append_u16(&buf, alg_id);
+	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
+	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
+		       sizeof(pcr_select));
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value");
+	if (rc)
+		goto out;
+
+	read_out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
+
+	*update_counter = be32_to_cpu(read_out->update_cnt);
+
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
 struct tpm2_null_auth_area {
 	__be32  handle;
 	__be16  nonce_size;
-- 
2.25.1


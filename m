Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9D117C32
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 01:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLJAKU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 19:10:20 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38224 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfLJAKT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 19:10:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 92E4B8EE112;
        Mon,  9 Dec 2019 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575936619;
        bh=qXHPTGBNkTg68Sa4gU3uMyopIzQxxDozpkSYvTM99EM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FYR8i1yI5F9Xbx+98/FbtAEYKP4XMjsGj0K3bl138O/kTYJwnDmNO3qnJpGx/kVuX
         Xoh5bysO6E73/MWMSW9l2Pkb87X3Rc7054iTGvwhw6vhCcitbxfBgNXu9+2J0iCJtm
         7JTA4bYjqK5svcDNmX4yCQSPjHEfhRt8s5HmK/Do=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1HxD2SFPLquR; Mon,  9 Dec 2019 16:10:19 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2DE018EE0FC;
        Mon,  9 Dec 2019 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575936619;
        bh=qXHPTGBNkTg68Sa4gU3uMyopIzQxxDozpkSYvTM99EM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FYR8i1yI5F9Xbx+98/FbtAEYKP4XMjsGj0K3bl138O/kTYJwnDmNO3qnJpGx/kVuX
         Xoh5bysO6E73/MWMSW9l2Pkb87X3Rc7054iTGvwhw6vhCcitbxfBgNXu9+2J0iCJtm
         7JTA4bYjqK5svcDNmX4yCQSPjHEfhRt8s5HmK/Do=
Message-ID: <1575936618.31378.58.camel@HansenPartnership.com>
Subject: [PATCH v2 8/8] security: keys: trusted: implement counter/timer
 policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 09 Dec 2019 16:10:18 -0800
In-Reply-To: <1575936272.31378.50.camel@HansenPartnership.com>
References: <1575936272.31378.50.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is actually a generic policy allowing a range of comparisons
against any value set in the TPM Clock, which includes things like the
reset count, a monotonic millisecond count and the restart count.  The
most useful comparison is against the millisecond count for expiring
keys.  However, you have to remember that currently Linux doesn't try
to sync the epoch timer with the TPM, so the expiration is actually
measured in how long the TPM itself has been powered on ... the TPM
timer doesn't count while the system is powered down.  The millisecond
counter is a u64 quantity found at offset 8 in the timer structure,
and the <= comparision operand is 9, so a policy set to expire after the
TPM has been up for 100 seconds would look like

0000016d00000000000f424000080009

Where 0x16d is the counter timer policy code and 0xf4240 is 100 000 in
hex.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 29 +++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.c          | 19 +++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index ade1a9dc8367..52d8bd8bef65 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -235,3 +235,32 @@ about the usage can be found in the file
 Another new format 'enc32' has been defined in order to support encrypted keys
 with payload size of 32 bytes. This will initially be used for nvdimm security
 but may expand to other usages that require 32 bytes payload.
+
+Appendix
+--------
+
+TPM 2.0 Policies
+----------------
+
+The current TPM supports PCR lock policies as documented above and
+CounterTimer policies which can be used to create expiring keys.  One
+caveat with expiring keys is that the TPM millisecond counter does not
+update while a system is powered off and Linux does not sync the TPM
+millisecond count with its internal clock, so the best you can expire
+in is in terms of how long any given TPM has been powered on.  (FIXME:
+Linux should simply update the millisecond clock to the current number
+of seconds past the epoch on boot).
+
+A CounterTimer policy is expressed in terms of length and offset
+against the TPM clock structure (TPMS_TIME_INFO), which looks like the
+packed structure::
+
+    struct tpms_time_info {
+            u64 uptime;       /* time in ms since last start or reset */
+	    u64 clock;        /* cumulative uptime in ms */
+	    u32 resetcount;   /* numer of times the TPM has been reset */
+	    u32 restartcount; /* number of times the TPM has been restarted */
+	    u8  safe          /* time was safely loaded from NVRam */
+    };
+
+The usual comparison for expiring keys is against clock, at offset 8.
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index 6d69f0300584..f19beb3e9e49 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -322,6 +322,25 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 			tpm_buf_append(&buf, pols->policies[i],
 				       pols->len[i] - pols->hash_size);
 			break;
+		case TPM2_CC_POLICY_COUNTER_TIMER: {
+			/*
+			 * the format of this is the last two u16
+			 * quantities are the offset and operation
+			 * respectively.  The rest is operandB which
+			 * must be zero padded in a hash digest
+			 */
+			u16 opb_len = pols->len[i] - 4;
+
+			if (opb_len > pols->hash_size)
+				return -EINVAL;
+
+			tpm_buf_append_u16(&buf, opb_len);
+			tpm_buf_append(&buf, pols->policies[i], opb_len);
+			/* offset and operand*/
+			tpm_buf_append(&buf, pols->policies[i] + opb_len, 4);
+			failure = "Counter Timer";
+			break;
+		}
 		default:
 			failure = "unknown policy";
 			break;
-- 
2.16.4


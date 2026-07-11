Return-Path: <linux-integrity+bounces-9912-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ADAsDBhpUmrcPQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9912-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:02:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7DB742156
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:02:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ECHZ14e4;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9912-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9912-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFBED3037BDD
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907A3CAA54;
	Sat, 11 Jul 2026 16:01:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BD3C945B
	for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 16:01:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785685; cv=none; b=mOpZEOs3UEg93lnaYn9ESEp3oUKoQg5nwOnaoP0lHXZbK/IlvlfC3NhbyuMwwOhyW4WNyUJTXXkqzhqKcDFXed52C0b4cG8J5iVF9RdaCjO6O4zb60E3QXbu2pGHuASQdygFKQ91QWHAjaRZgY9nGILhn5rNEYY0Reh7yRjlQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785685; c=relaxed/simple;
	bh=MW5vwa/xxN279qXJ/ncdVlQ+CMbXD49NpEFaBeZ7WCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJxIYItUK3RSA3uvnVIFfnXvOj4wU12FTsuL5t9NKh5NRwAZdvd1svaVTDhXGF2GE91EdQmeD/rbl/vxEJNh6ybgfLnRxV/OJl/AiLyTejMyxgMoKyBZbMwzeCfK9wFsdaklsl0uT311edODFEft5xH51BoPAZKCT/BdMhL5THc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECHZ14e4; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso2138166a91.2
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783785683; x=1784390483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wXH+VZFISmrEli7nt1s186UA+OwPFAZ3gli8Wbbz+8=;
        b=ECHZ14e4JGukXwcJm0zHXTxhnZBEpZ19F8IVvVYCJ83zNLVHxpQ3qqzjCC9hBmrYoT
         3cOKRLfCxnSfyY5qj7f7LJeBAan32DNriuppqHSsPHRzOlmEQBnvNZCBcIPAu5SYXWX3
         b6L/UXrXIVvI8+spBOwmElElET1GagDzGy06vcu3DVh/b92Arx3mxQukG6H0Y6PzMJAD
         Txu6I1R3OQFBQk9vClsa8oG6i8Uil90pJcoaCnJe2ijwq1nB/NIVcNE9yBimGF69tV4u
         TjsUGDO1QDLmZXZ/Pi0twuVkmegMwIFHE7LwfLV3MiKlpquzrzMhPpVKHz+bXN97TjRJ
         Mt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785683; x=1784390483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wXH+VZFISmrEli7nt1s186UA+OwPFAZ3gli8Wbbz+8=;
        b=A+nPXHbnbviEW2Jwxn32DwIO/3Uck86aKOoNuHoFrWn0N1AJRc/mILKyriiv+QlSC+
         D+hJynGVazJ6Rq5krWTlrElfBtxqW8OOaNfGZ9U2BNs4GTAIYpqJxd/osYtRafVWb69M
         Y9mnR+Y/5Rl8+M7sQps1L+9HChOcyspCyNPBKKzPzTZmHnT1zNSMJfkgpCQ0G1oRezct
         UlgOUpY9AMQ1uEcVOqRGcoltMWbuz33uuQq/1+csoT84CIt6QDF83pdYIQzqg3RvG005
         y0L3rnPCtw9DW/PH6YK/w5etQT3W+mm73w4B/nlwSWDuA4pX6ftfLcH550j911BYBI0+
         DVsg==
X-Forwarded-Encrypted: i=1; AHgh+Rosl2JO66Ad21tc8qK/5sOvNIWkgecXaBDkiIbqVLoVC3LMhZRbO0wSLXotorfplAllq2P+K8Vs0g3WeH8dQFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMXhQXuUT0hSiR+x7Z5gXowTHxsEe88oGvqZYqYm4ymJd0S1A
	7U+yZY3LUrdwvWCNsSSWkfFmWXSOvfnxWVXVzK2JwBy/7NH9QkyJwPgh
X-Gm-Gg: AfdE7cl/VeZm0QRlC1y7u+96PInMqC/rOL1eCT5iod8d7s1qLhv4+Rvli6bGdPCKwNh
	iVkFmNs9g4b4sLqOxF1yN3Pe/LetmYDJrJDq16uZy539jOl0xZg4X5DVwGkBcgje+HXLXq4P04g
	Q4rIiloj0ipWGoLahdBVhrQ++iMDDY+0FkpbXtyQCzNZ4WNCZl8teKp+1MLHQStirSK4Qwoccfw
	H5f0dgBy6LhJezBbo+7esdgNOXe0B4fsn64IZyBgQoHmHPaK3MSlVCam4k17YIHZOxBLdtZMMiZ
	H52iZjTtqzXYxO3hNhxwYi2pSGn2jDxMxAKgAc/O++8zqNri4W3KXlkqh8h+myDYJt/Fa+Bgoj2
	x/49tAE+CZULJB+zWdCAAEkn4ZVADrKBchIruuCZHmBcslSx0cjKhqMnuE4DCzbG1WLDmE7pr9P
	lNLI3aHm+QOxq6+mgyx1Ag
X-Received: by 2002:a17:90a:c884:b0:387:e0cb:7f6 with SMTP id 98e67ed59e1d1-38dc78443a4mr3138556a91.42.1783785683016;
        Sat, 11 Jul 2026 09:01:23 -0700 (PDT)
Received: from titan.lan ([2603:8000:df01:38f7:255c:dd03:30a6:e57b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313af819732sm20391907eec.16.2026.07.11.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:01:22 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	luto@amacapital.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v2 03/10] tpm: Move TPM2 specific definitions to the command header
Date: Sat, 11 Jul 2026 09:01:03 -0700
Message-ID: <20260711160110.267780-4-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711160110.267780-1-ross.philipson@gmail.com>
References: <20260711160110.267780-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9912-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-integrity@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-efi@vger.kernel.org,m:ross.philipson@gmail.com,m:dpsmith@apertussolutions.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:bp@alien8.de,m:hpa@zytor.com,m:dave.hansen@linux.intel.com,m:ardb@kernel.org,m:mjg59@srcf.ucam.org,m:James.Bottomley@hansenpartnership.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:luto@amacapital.net,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:corbet@lwn.net,m:kanth.ghatraju@oracle.com,m:daniel.kiper@oracle.com,m:andrew.cooper3@citrix.com,m:trenchboot-devel@googlegroups.com,m:rossphilipson@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,gondor.apana.org.au,davemloft.net,lwn.net,oracle.com,citrix.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,apertussolutions.com:email,trustedcomputinggroup.org:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD7DB742156

Gather all the TPM2 definitions and structures in the internal header
file drivers/char/tpm/tpm.h into the command header, including:
 - Command codes, return codes and definitions from the public and
internal tpm.h files.
 - Structures defined in numerous TPM driver C modules.

The definitions moved to these files correspond to the TCG specification
for TPM 2 family:

TPM 2.0 Library
 - https://trustedcomputinggroup.org/resource/tpm-library-specification/

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm.h        |  77 ----------
 drivers/char/tpm/tpm2-cmd.c   |  30 ----
 drivers/char/tpm/tpm2-space.c |  13 --
 include/linux/tpm.h           | 145 ------------------
 include/linux/tpm_command.h   | 271 ++++++++++++++++++++++++++++++++++
 5 files changed, 271 insertions(+), 265 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 043d78a9617a..680f89d9c9f9 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -52,83 +52,6 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-/* TPM2 specific constants. */
-#define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
-
-enum tpm2_pt_props {
-	TPM2_PT_NONE = 0x00000000,
-	TPM2_PT_GROUP = 0x00000100,
-	TPM2_PT_FIXED = TPM2_PT_GROUP * 1,
-	TPM2_PT_FAMILY_INDICATOR = TPM2_PT_FIXED + 0,
-	TPM2_PT_LEVEL = TPM2_PT_FIXED + 1,
-	TPM2_PT_REVISION = TPM2_PT_FIXED + 2,
-	TPM2_PT_DAY_OF_YEAR = TPM2_PT_FIXED + 3,
-	TPM2_PT_YEAR = TPM2_PT_FIXED + 4,
-	TPM2_PT_MANUFACTURER = TPM2_PT_FIXED + 5,
-	TPM2_PT_VENDOR_STRING_1 = TPM2_PT_FIXED + 6,
-	TPM2_PT_VENDOR_STRING_2 = TPM2_PT_FIXED + 7,
-	TPM2_PT_VENDOR_STRING_3 = TPM2_PT_FIXED + 8,
-	TPM2_PT_VENDOR_STRING_4 = TPM2_PT_FIXED + 9,
-	TPM2_PT_VENDOR_TPM_TYPE = TPM2_PT_FIXED + 10,
-	TPM2_PT_FIRMWARE_VERSION_1 = TPM2_PT_FIXED + 11,
-	TPM2_PT_FIRMWARE_VERSION_2 = TPM2_PT_FIXED + 12,
-	TPM2_PT_INPUT_BUFFER = TPM2_PT_FIXED + 13,
-	TPM2_PT_HR_TRANSIENT_MIN = TPM2_PT_FIXED + 14,
-	TPM2_PT_HR_PERSISTENT_MIN = TPM2_PT_FIXED + 15,
-	TPM2_PT_HR_LOADED_MIN = TPM2_PT_FIXED + 16,
-	TPM2_PT_ACTIVE_SESSIONS_MAX = TPM2_PT_FIXED + 17,
-	TPM2_PT_PCR_COUNT = TPM2_PT_FIXED + 18,
-	TPM2_PT_PCR_SELECT_MIN = TPM2_PT_FIXED + 19,
-	TPM2_PT_CONTEXT_GAP_MAX = TPM2_PT_FIXED + 20,
-	TPM2_PT_NV_COUNTERS_MAX = TPM2_PT_FIXED + 22,
-	TPM2_PT_NV_INDEX_MAX = TPM2_PT_FIXED + 23,
-	TPM2_PT_MEMORY = TPM2_PT_FIXED + 24,
-	TPM2_PT_CLOCK_UPDATE = TPM2_PT_FIXED + 25,
-	TPM2_PT_CONTEXT_HASH = TPM2_PT_FIXED + 26,
-	TPM2_PT_CONTEXT_SYM = TPM2_PT_FIXED + 27,
-	TPM2_PT_CONTEXT_SYM_SIZE = TPM2_PT_FIXED + 28,
-	TPM2_PT_ORDERLY_COUNT = TPM2_PT_FIXED + 29,
-	TPM2_PT_MAX_COMMAND_SIZE = TPM2_PT_FIXED + 30,
-	TPM2_PT_MAX_RESPONSE_SIZE = TPM2_PT_FIXED + 31,
-	TPM2_PT_MAX_DIGEST = TPM2_PT_FIXED + 32,
-	TPM2_PT_MAX_OBJECT_CONTEXT = TPM2_PT_FIXED + 33,
-	TPM2_PT_MAX_SESSION_CONTEXT = TPM2_PT_FIXED + 34,
-	TPM2_PT_PS_FAMILY_INDICATOR = TPM2_PT_FIXED + 35,
-	TPM2_PT_PS_LEVEL = TPM2_PT_FIXED + 36,
-	TPM2_PT_PS_REVISION = TPM2_PT_FIXED + 37,
-	TPM2_PT_PS_DAY_OF_YEAR = TPM2_PT_FIXED + 38,
-	TPM2_PT_PS_YEAR = TPM2_PT_FIXED + 39,
-	TPM2_PT_SPLIT_MAX = TPM2_PT_FIXED + 40,
-	TPM2_PT_TOTAL_COMMANDS = TPM2_PT_FIXED + 41,
-	TPM2_PT_LIBRARY_COMMANDS = TPM2_PT_FIXED + 42,
-	TPM2_PT_VENDOR_COMMANDS = TPM2_PT_FIXED + 43,
-	TPM2_PT_NV_BUFFER_MAX = TPM2_PT_FIXED + 44,
-	TPM2_PT_MODES = TPM2_PT_FIXED + 45,
-	TPM2_PT_MAX_CAP_BUFFER = TPM2_PT_FIXED + 46,
-	TPM2_PT_VAR = TPM2_PT_GROUP * 2,
-	TPM2_PT_PERMANENT = TPM2_PT_VAR + 0,
-	TPM2_PT_STARTUP_CLEAR = TPM2_PT_VAR + 1,
-	TPM2_PT_HR_NV_INDEX = TPM2_PT_VAR + 2,
-	TPM2_PT_HR_LOADED = TPM2_PT_VAR + 3,
-	TPM2_PT_HR_LOADED_AVAIL = TPM2_PT_VAR + 4,
-	TPM2_PT_HR_ACTIVE = TPM2_PT_VAR + 5,
-	TPM2_PT_HR_ACTIVE_AVAIL = TPM2_PT_VAR + 6,
-	TPM2_PT_HR_TRANSIENT_AVAIL = TPM2_PT_VAR + 7,
-	TPM2_PT_HR_PERSISTENT = TPM2_PT_VAR + 8,
-	TPM2_PT_HR_PERSISTENT_AVAIL = TPM2_PT_VAR + 9,
-	TPM2_PT_NV_COUNTERS = TPM2_PT_VAR + 10,
-	TPM2_PT_NV_COUNTERS_AVAIL = TPM2_PT_VAR + 11,
-	TPM2_PT_ALGORITHM_SET = TPM2_PT_VAR + 12,
-	TPM2_PT_LOADED_CURVES = TPM2_PT_VAR + 13,
-	TPM2_PT_LOCKOUT_COUNTER = TPM2_PT_VAR + 14,
-	TPM2_PT_MAX_AUTH_FAIL = TPM2_PT_VAR + 15,
-	TPM2_PT_LOCKOUT_INTERVAL = TPM2_PT_VAR + 16,
-	TPM2_PT_LOCKOUT_RECOVERY = TPM2_PT_VAR + 17,
-	TPM2_PT_NV_WRITE_RECOVERY = TPM2_PT_VAR + 18,
-	TPM2_PT_AUDIT_COUNTER_0 = TPM2_PT_VAR + 19,
-	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
-};
-
 extern const struct class tpm_class;
 extern const struct class tpmrm_class;
 extern dev_t tpm_devt;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 52ee350da867..280f870e6517 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -94,17 +94,6 @@ unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
 	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
 }
 
-struct tpm2_pcr_read_out {
-	__be32	update_cnt;
-	__be32	pcr_selects_cnt;
-	__be16	hash_alg;
-	u8	pcr_select_size;
-	u8	pcr_select[TPM2_PCR_SELECT_MIN];
-	__be32	digests_cnt;
-	__be16	digest_size;
-	u8	digest[];
-} __packed;
-
 /**
  * tpm2_pcr_read() - read a PCR value
  * @chip:	TPM chip to use.
@@ -238,11 +227,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
-struct tpm2_get_random_out {
-	__be16 size;
-	u8 buffer[TPM_MAX_RNG_DATA];
-} __packed;
-
 /**
  * tpm2_get_random() - get random bytes from the TPM RNG
  *
@@ -364,14 +348,6 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 }
 EXPORT_SYMBOL_GPL(tpm2_flush_context);
 
-struct tpm2_get_cap_out {
-	u8 more_data;
-	__be32 subcap_id;
-	__be32 property_cnt;
-	__be32 property_id;
-	__be32 value;
-} __packed;
-
 /**
  * tpm2_get_tpm_pt() - get value of a TPM_CAP_TPM_PROPERTIES type property
  * @chip:		a &tpm_chip instance
@@ -539,12 +515,6 @@ static int tpm2_init_bank_info(struct tpm_chip *chip, u32 bank_index)
 	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
 }
 
-struct tpm2_pcr_selection {
-	__be16  hash_alg;
-	u8  size_of_select;
-	u8  pcr_select[3];
-} __packed;
-
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 {
 	struct tpm2_pcr_selection pcr_selection;
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..7c1c0a174a2b 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -15,19 +15,6 @@
 #include <linux/unaligned.h>
 #include "tpm.h"
 
-enum tpm2_handle_types {
-	TPM2_HT_HMAC_SESSION	= 0x02000000,
-	TPM2_HT_POLICY_SESSION	= 0x03000000,
-	TPM2_HT_TRANSIENT	= 0x80000000,
-};
-
-struct tpm2_context {
-	__be64 sequence;
-	__be32 saved_handle;
-	__be32 hierarchy;
-	__be16 blob_size;
-} __packed;
-
 static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
 {
 	int i;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 1846d5485a2c..8551b24c2bff 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -38,12 +38,6 @@ struct trusted_key_options;
 /* opaque structure, holds auth session parameters like the session key */
 struct tpm2_auth;
 
-enum tpm2_session_types {
-	TPM2_SE_HMAC	= 0x00,
-	TPM2_SE_POLICY	= 0x01,
-	TPM2_SE_TRIAL	= 0x02,
-};
-
 /* if you add a new hash to this, increment TPM_MAX_HASHES below */
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
@@ -65,11 +59,6 @@ enum tpm_algorithms {
  */
 #define TPM_MAX_HASHES	5
 
-enum tpm2_curves {
-	TPM2_ECC_NONE		= 0x0000,
-	TPM2_ECC_NIST_P256	= 0x0003,
-};
-
 struct tpm_digest {
 	u16 alg_id;
 	u8 digest[TPM2_MAX_DIGEST_SIZE];
@@ -222,122 +211,11 @@ struct tpm_chip {
 
 #define TPM_HEADER_SIZE		10
 
-enum tpm2_const {
-	TPM2_PLATFORM_PCR       =     24,
-	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
-};
-
-enum tpm2_timeouts {
-	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   4000,
-	TPM2_TIMEOUT_C          =    200,
-	TPM2_TIMEOUT_D          =     30,
-};
-
-enum tpm2_durations {
-	TPM2_DURATION_SHORT     =     20,
-	TPM2_DURATION_LONG      =   2000,
-	TPM2_DURATION_DEFAULT   = 120000,
-};
-
-enum tpm2_structures {
-	TPM2_ST_NO_SESSIONS	= 0x8001,
-	TPM2_ST_SESSIONS	= 0x8002,
-	TPM2_ST_CREATION	= 0x8021,
-};
-
-/* Indicates from what layer of the software stack the error comes from */
-#define TSS2_RC_LAYER_SHIFT	 16
-#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
-
-enum tpm2_return_codes {
-	TPM2_RC_SUCCESS		= 0x0000,
-	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
-	TPM2_RC_HANDLE		= 0x008B,
-	TPM2_RC_INTEGRITY	= 0x009F,
-	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
-	TPM2_RC_FAILURE		= 0x0101,
-	TPM2_RC_DISABLED	= 0x0120,
-	TPM2_RC_UPGRADE		= 0x012D,
-	TPM2_RC_COMMAND_CODE    = 0x0143,
-	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
-	TPM2_RC_REFERENCE_H0	= 0x0910,
-	TPM2_RC_RETRY		= 0x0922,
-	TPM2_RC_SESSION_MEMORY	= 0x0903,
-};
-
-enum tpm2_command_codes {
-	TPM2_CC_FIRST		        = 0x011F,
-	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
-	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
-	TPM2_CC_CREATE_PRIMARY          = 0x0131,
-	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
-	TPM2_CC_SELF_TEST	        = 0x0143,
-	TPM2_CC_STARTUP		        = 0x0144,
-	TPM2_CC_SHUTDOWN	        = 0x0145,
-	TPM2_CC_NV_READ                 = 0x014E,
-	TPM2_CC_CREATE		        = 0x0153,
-	TPM2_CC_LOAD		        = 0x0157,
-	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
-	TPM2_CC_UNSEAL		        = 0x015E,
-	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
-	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
-	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
-	TPM2_CC_READ_PUBLIC		= 0x0173,
-	TPM2_CC_START_AUTH_SESS		= 0x0176,
-	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
-	TPM2_CC_GET_CAPABILITY	        = 0x017A,
-	TPM2_CC_GET_RANDOM	        = 0x017B,
-	TPM2_CC_PCR_READ	        = 0x017E,
-	TPM2_CC_PCR_EXTEND	        = 0x0182,
-	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
-	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
-	TPM2_CC_CREATE_LOADED           = 0x0191,
-	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
-};
-
-enum tpm2_permanent_handles {
-	TPM2_RH_NULL		= 0x40000007,
-	TPM2_RS_PW		= 0x40000009,
-};
-
-/* Most Significant Octet for key types  */
-enum tpm2_mso_type {
-	TPM2_MSO_NVRAM		= 0x01,
-	TPM2_MSO_SESSION	= 0x02,
-	TPM2_MSO_POLICY		= 0x03,
-	TPM2_MSO_PERMANENT	= 0x40,
-	TPM2_MSO_VOLATILE	= 0x80,
-	TPM2_MSO_PERSISTENT	= 0x81,
-};
-
 static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
 {
 	return handle >> 24;
 }
 
-enum tpm2_capabilities {
-	TPM2_CAP_HANDLES	= 1,
-	TPM2_CAP_COMMANDS	= 2,
-	TPM2_CAP_PCRS		= 5,
-	TPM2_CAP_TPM_PROPERTIES = 6,
-};
-
-enum tpm2_properties {
-	TPM_PT_TOTAL_COMMANDS	= 0x0129,
-};
-
-enum tpm2_startup_types {
-	TPM2_SU_CLEAR	= 0x0000,
-	TPM2_SU_STATE	= 0x0001,
-};
-
-enum tpm2_cc_attrs {
-	TPM2_CC_ATTR_CHANDLES	= 25,
-	TPM2_CC_ATTR_RHANDLE	= 28,
-	TPM2_CC_ATTR_VENDOR	= 29,
-};
-
 #define TPM_VID_INTEL    0x8086
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
@@ -389,29 +267,6 @@ struct tpm_buf {
 	u8 handles;
 };
 
-enum tpm2_object_attributes {
-	TPM2_OA_FIXED_TPM		= BIT(1),
-	TPM2_OA_ST_CLEAR		= BIT(2),
-	TPM2_OA_FIXED_PARENT		= BIT(4),
-	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
-	TPM2_OA_USER_WITH_AUTH		= BIT(6),
-	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
-	TPM2_OA_NO_DA			= BIT(10),
-	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
-	TPM2_OA_RESTRICTED		= BIT(16),
-	TPM2_OA_DECRYPT			= BIT(17),
-	TPM2_OA_SIGN			= BIT(18),
-};
-
-enum tpm2_session_attributes {
-	TPM2_SA_CONTINUE_SESSION	= BIT(0),
-	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
-	TPM2_SA_AUDIT_RESET		= BIT(3),
-	TPM2_SA_DECRYPT			= BIT(5),
-	TPM2_SA_ENCRYPT			= BIT(6),
-	TPM2_SA_AUDIT			= BIT(7),
-};
-
 struct tpm2_hash {
 	unsigned int crypto_id;
 	unsigned int tpm_id;
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 30d01953a6f8..9dd903dd6b5c 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -156,4 +156,275 @@ struct tpm1_get_random_out {
 #define TPM_NONCE_SIZE                  20
 #define TPM_ST_CLEAR			1
 
+/*
+ * == TPM 2 Family Chips ==
+ *
+ * TPM 2.0 Library
+ * https://trustedcomputinggroup.org/resource/tpm-library-specification/
+ */
+
+/* TPM2 specific constants. */
+#define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
+
+enum tpm2_session_types {
+	TPM2_SE_HMAC	= 0x00,
+	TPM2_SE_POLICY	= 0x01,
+	TPM2_SE_TRIAL	= 0x02,
+};
+
+enum tpm2_timeouts {
+	TPM2_TIMEOUT_A		= 750,
+	TPM2_TIMEOUT_B		= 4000,
+	TPM2_TIMEOUT_C		= 200,
+	TPM2_TIMEOUT_D		= 30,
+	TPM2_DURATION_SHORT	= 20,
+	TPM2_DURATION_MEDIUM	= 750,
+	TPM2_DURATION_LONG	= 2000,
+	TPM2_DURATION_LONG_LONG	= 300000,
+	TPM2_DURATION_DEFAULT	= 120000,
+};
+
+enum tpm2_structures {
+	TPM2_ST_NO_SESSIONS	= 0x8001,
+	TPM2_ST_SESSIONS	= 0x8002,
+	TPM2_ST_CREATION	= 0x8021,
+};
+
+/* Indicates from what layer of the software stack the error comes from */
+#define TSS2_RC_LAYER_SHIFT	 16
+#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
+
+enum tpm2_return_codes {
+	TPM2_RC_SUCCESS		= 0x0000,
+	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
+	TPM2_RC_HANDLE		= 0x008B,
+	TPM2_RC_INTEGRITY	= 0x009F,
+	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
+	TPM2_RC_FAILURE		= 0x0101,
+	TPM2_RC_DISABLED	= 0x0120,
+	TPM2_RC_UPGRADE		= 0x012D,
+	TPM2_RC_COMMAND_CODE	= 0x0143,
+	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
+	TPM2_RC_REFERENCE_H0	= 0x0910,
+	TPM2_RC_RETRY		= 0x0922,
+	TPM2_RC_SESSION_MEMORY	= 0x0903,
+};
+
+enum tpm2_command_codes {
+	TPM2_CC_FIRST			= 0x011F,
+	TPM2_CC_HIERARCHY_CONTROL	= 0x0121,
+	TPM2_CC_HIERARCHY_CHANGE_AUTH	= 0x0129,
+	TPM2_CC_CREATE_PRIMARY		= 0x0131,
+	TPM2_CC_SEQUENCE_COMPLETE	= 0x013E,
+	TPM2_CC_SELF_TEST		= 0x0143,
+	TPM2_CC_STARTUP			= 0x0144,
+	TPM2_CC_SHUTDOWN		= 0x0145,
+	TPM2_CC_NV_READ			= 0x014E,
+	TPM2_CC_CREATE			= 0x0153,
+	TPM2_CC_LOAD			= 0x0157,
+	TPM2_CC_SEQUENCE_UPDATE		= 0x015C,
+	TPM2_CC_UNSEAL			= 0x015E,
+	TPM2_CC_CONTEXT_LOAD		= 0x0161,
+	TPM2_CC_CONTEXT_SAVE		= 0x0162,
+	TPM2_CC_FLUSH_CONTEXT		= 0x0165,
+	TPM2_CC_READ_PUBLIC		= 0x0173,
+	TPM2_CC_START_AUTH_SESS		= 0x0176,
+	TPM2_CC_VERIFY_SIGNATURE	= 0x0177,
+	TPM2_CC_GET_CAPABILITY		= 0x017A,
+	TPM2_CC_GET_RANDOM		= 0x017B,
+	TPM2_CC_PCR_READ		= 0x017E,
+	TPM2_CC_PCR_EXTEND		= 0x0182,
+	TPM2_CC_EVENT_SEQUENCE_COMPLETE	= 0x0185,
+	TPM2_CC_HASH_SEQUENCE_START	= 0x0186,
+	TPM2_CC_CREATE_LOADED		= 0x0191,
+	TPM2_CC_LAST			= 0x0193, /* Spec 1.36 */
+};
+
+enum tpm2_capabilities {
+	TPM2_CAP_HANDLES	= 1,
+	TPM2_CAP_COMMANDS	= 2,
+	TPM2_CAP_PCRS		= 5,
+	TPM2_CAP_TPM_PROPERTIES = 6,
+};
+
+enum tpm2_properties {
+	TPM_PT_TOTAL_COMMANDS	= 0x0129,
+};
+
+enum tpm2_startup_types {
+	TPM2_SU_CLEAR		= 0x0000,
+	TPM2_SU_STATE		= 0x0001,
+};
+
+enum tpm2_cc_attrs {
+	TPM2_CC_ATTR_CHANDLES	= 25,
+	TPM2_CC_ATTR_RHANDLE	= 28,
+	TPM2_CC_ATTR_VENDOR	= 29,
+};
+
+enum tpm2_permanent_handles {
+	TPM2_RH_NULL		= 0x40000007,
+	TPM2_RS_PW		= 0x40000009,
+};
+
+/* Most Significant Octet for key types  */
+enum tpm2_mso_type {
+	TPM2_MSO_NVRAM		= 0x01,
+	TPM2_MSO_SESSION	= 0x02,
+	TPM2_MSO_POLICY		= 0x03,
+	TPM2_MSO_PERMANENT	= 0x40,
+	TPM2_MSO_VOLATILE	= 0x80,
+	TPM2_MSO_PERSISTENT	= 0x81,
+};
+
+enum tpm2_curves {
+	TPM2_ECC_NONE		= 0x0000,
+	TPM2_ECC_NIST_P256	= 0x0003,
+};
+
+enum tpm2_object_attributes {
+	TPM2_OA_FIXED_TPM		= BIT(1),
+	TPM2_OA_ST_CLEAR		= BIT(2),
+	TPM2_OA_FIXED_PARENT		= BIT(4),
+	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
+	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
+	TPM2_OA_NO_DA			= BIT(10),
+	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
+	TPM2_OA_RESTRICTED		= BIT(16),
+	TPM2_OA_DECRYPT			= BIT(17),
+	TPM2_OA_SIGN			= BIT(18),
+};
+
+enum tpm2_session_attributes {
+	TPM2_SA_CONTINUE_SESSION	= BIT(0),
+	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
+	TPM2_SA_AUDIT_RESET		= BIT(3),
+	TPM2_SA_DECRYPT			= BIT(5),
+	TPM2_SA_ENCRYPT			= BIT(6),
+	TPM2_SA_AUDIT			= BIT(7),
+};
+
+enum tpm2_pcr_select {
+	TPM2_PLATFORM_PCR	= 24,
+	TPM2_PCR_SELECT_MIN	= ((TPM2_PLATFORM_PCR + 7) / 8),
+};
+
+enum tpm2_handle_types {
+	TPM2_HT_HMAC_SESSION	= 0x02000000,
+	TPM2_HT_POLICY_SESSION	= 0x03000000,
+	TPM2_HT_TRANSIENT	= 0x80000000,
+};
+
+enum tpm2_pt_props {
+	TPM2_PT_NONE			= 0x00000000,
+	TPM2_PT_GROUP			= 0x00000100,
+	TPM2_PT_FIXED			= TPM2_PT_GROUP * 1,
+	TPM2_PT_FAMILY_INDICATOR	= TPM2_PT_FIXED + 0,
+	TPM2_PT_LEVEL		= TPM2_PT_FIXED + 1,
+	TPM2_PT_REVISION	= TPM2_PT_FIXED + 2,
+	TPM2_PT_DAY_OF_YEAR	= TPM2_PT_FIXED + 3,
+	TPM2_PT_YEAR		= TPM2_PT_FIXED + 4,
+	TPM2_PT_MANUFACTURER	= TPM2_PT_FIXED + 5,
+	TPM2_PT_VENDOR_STRING_1	= TPM2_PT_FIXED + 6,
+	TPM2_PT_VENDOR_STRING_2	= TPM2_PT_FIXED + 7,
+	TPM2_PT_VENDOR_STRING_3	= TPM2_PT_FIXED + 8,
+	TPM2_PT_VENDOR_STRING_4	= TPM2_PT_FIXED + 9,
+	TPM2_PT_VENDOR_TPM_TYPE	= TPM2_PT_FIXED + 10,
+	TPM2_PT_FIRMWARE_VERSION_1	= TPM2_PT_FIXED + 11,
+	TPM2_PT_FIRMWARE_VERSION_2	= TPM2_PT_FIXED + 12,
+	TPM2_PT_INPUT_BUFFER		= TPM2_PT_FIXED + 13,
+	TPM2_PT_HR_TRANSIENT_MIN	= TPM2_PT_FIXED + 14,
+	TPM2_PT_HR_PERSISTENT_MIN	= TPM2_PT_FIXED + 15,
+	TPM2_PT_HR_LOADED_MIN		= TPM2_PT_FIXED + 16,
+	TPM2_PT_ACTIVE_SESSIONS_MAX	= TPM2_PT_FIXED + 17,
+	TPM2_PT_PCR_COUNT	= TPM2_PT_FIXED + 18,
+	TPM2_PT_PCR_SELECT_MIN	= TPM2_PT_FIXED + 19,
+	TPM2_PT_CONTEXT_GAP_MAX	= TPM2_PT_FIXED + 20,
+	TPM2_PT_NV_COUNTERS_MAX	= TPM2_PT_FIXED + 22,
+	TPM2_PT_NV_INDEX_MAX	= TPM2_PT_FIXED + 23,
+	TPM2_PT_MEMORY		= TPM2_PT_FIXED + 24,
+	TPM2_PT_CLOCK_UPDATE	= TPM2_PT_FIXED + 25,
+	TPM2_PT_CONTEXT_HASH	= TPM2_PT_FIXED + 26,
+	TPM2_PT_CONTEXT_SYM	= TPM2_PT_FIXED + 27,
+	TPM2_PT_CONTEXT_SYM_SIZE	= TPM2_PT_FIXED + 28,
+	TPM2_PT_ORDERLY_COUNT		= TPM2_PT_FIXED + 29,
+	TPM2_PT_MAX_COMMAND_SIZE	= TPM2_PT_FIXED + 30,
+	TPM2_PT_MAX_RESPONSE_SIZE	= TPM2_PT_FIXED + 31,
+	TPM2_PT_MAX_DIGEST		= TPM2_PT_FIXED + 32,
+	TPM2_PT_MAX_OBJECT_CONTEXT	= TPM2_PT_FIXED + 33,
+	TPM2_PT_MAX_SESSION_CONTEXT	= TPM2_PT_FIXED + 34,
+	TPM2_PT_PS_FAMILY_INDICATOR	= TPM2_PT_FIXED + 35,
+	TPM2_PT_PS_LEVEL	= TPM2_PT_FIXED + 36,
+	TPM2_PT_PS_REVISION	= TPM2_PT_FIXED + 37,
+	TPM2_PT_PS_DAY_OF_YEAR	= TPM2_PT_FIXED + 38,
+	TPM2_PT_PS_YEAR		= TPM2_PT_FIXED + 39,
+	TPM2_PT_SPLIT_MAX	= TPM2_PT_FIXED + 40,
+	TPM2_PT_TOTAL_COMMANDS	= TPM2_PT_FIXED + 41,
+	TPM2_PT_LIBRARY_COMMANDS	= TPM2_PT_FIXED + 42,
+	TPM2_PT_VENDOR_COMMANDS		= TPM2_PT_FIXED + 43,
+	TPM2_PT_NV_BUFFER_MAX		= TPM2_PT_FIXED + 44,
+	TPM2_PT_MODES			= TPM2_PT_FIXED + 45,
+	TPM2_PT_MAX_CAP_BUFFER		= TPM2_PT_FIXED + 46,
+	TPM2_PT_VAR		= TPM2_PT_GROUP * 2,
+	TPM2_PT_PERMANENT	= TPM2_PT_VAR + 0,
+	TPM2_PT_STARTUP_CLEAR	= TPM2_PT_VAR + 1,
+	TPM2_PT_HR_NV_INDEX	= TPM2_PT_VAR + 2,
+	TPM2_PT_HR_LOADED	= TPM2_PT_VAR + 3,
+	TPM2_PT_HR_LOADED_AVAIL	= TPM2_PT_VAR + 4,
+	TPM2_PT_HR_ACTIVE	= TPM2_PT_VAR + 5,
+	TPM2_PT_HR_ACTIVE_AVAIL	= TPM2_PT_VAR + 6,
+	TPM2_PT_HR_TRANSIENT_AVAIL	= TPM2_PT_VAR + 7,
+	TPM2_PT_HR_PERSISTENT		= TPM2_PT_VAR + 8,
+	TPM2_PT_HR_PERSISTENT_AVAIL	= TPM2_PT_VAR + 9,
+	TPM2_PT_NV_COUNTERS		= TPM2_PT_VAR + 10,
+	TPM2_PT_NV_COUNTERS_AVAIL	= TPM2_PT_VAR + 11,
+	TPM2_PT_ALGORITHM_SET		= TPM2_PT_VAR + 12,
+	TPM2_PT_LOADED_CURVES		= TPM2_PT_VAR + 13,
+	TPM2_PT_LOCKOUT_COUNTER		= TPM2_PT_VAR + 14,
+	TPM2_PT_MAX_AUTH_FAIL		= TPM2_PT_VAR + 15,
+	TPM2_PT_LOCKOUT_INTERVAL	= TPM2_PT_VAR + 16,
+	TPM2_PT_LOCKOUT_RECOVERY	= TPM2_PT_VAR + 17,
+	TPM2_PT_NV_WRITE_RECOVERY	= TPM2_PT_VAR + 18,
+	TPM2_PT_AUDIT_COUNTER_0	= TPM2_PT_VAR + 19,
+	TPM2_PT_AUDIT_COUNTER_1	= TPM2_PT_VAR + 20,
+};
+
+struct tpm2_pcr_read_out {
+	__be32 update_cnt;
+	__be32 pcr_selects_cnt;
+	__be16 hash_alg;
+	u8 pcr_select_size;
+	u8 pcr_select[TPM2_PCR_SELECT_MIN];
+	__be32 digests_cnt;
+	__be16 digest_size;
+	u8 digest[];
+} __packed;
+
+struct tpm2_get_random_out {
+	__be16 size;
+	u8 buffer[TPM_MAX_RNG_DATA];
+} __packed;
+
+struct tpm2_get_cap_out {
+	u8 more_data;
+	__be32 subcap_id;
+	__be32 property_cnt;
+	__be32 property_id;
+	__be32 value;
+} __packed;
+
+struct tpm2_pcr_selection {
+	__be16 hash_alg;
+	u8 size_of_select;
+	u8 pcr_select[3];
+} __packed;
+
+struct tpm2_context {
+	__be64 sequence;
+	__be32 saved_handle;
+	__be32 hierarchy;
+	__be16 blob_size;
+} __packed;
+
 #endif
-- 
2.55.0



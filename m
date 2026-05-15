Return-Path: <linux-integrity+bounces-9543-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFecAP+MB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9543-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:15:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB8B557BAB
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95CA7300A641
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA263ED5C0;
	Fri, 15 May 2026 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coZxNLUV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995613ED109
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879680; cv=none; b=pu6brzUVEP7cRNDyBAibFwH1OTTqH16lIHY7CP9yarWkXCMUlX9BQhRH1KKURCKTmG8V+BbJVA7978gNyftPpWbk/Rf6QWk4uYq5vnvPKpdgO2+/U/GcMUcbpCeNXz4v4aAW9pla8i5cC0J3vs8YdjO5PVjibxphFVjQ74xG62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879680; c=relaxed/simple;
	bh=53lrliy0YE81pqMpILWMlkkyv1qPCSWN//0gQcdAdOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVoDRVIzoUfeHwbHmpx8/4a+o+EcBz03us6vnliUzlc8PJNREtu6BB1Y4COT6/v4HICKdVbkR5zvWqT60V+OkNDtNwDabUcYZ6i38PrIpe/Jx7bUFLKNXGFt9pABoCSCfZFyGZNhUiWhWBgG6+9JBNYhMh8MAbgU5MKywbEHwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coZxNLUV; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-132830d8281so946498c88.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879676; x=1779484476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaLNJCVWymRzHzAosL0l4Cb63oV8tVc7xKx597eZEkQ=;
        b=coZxNLUVyrcW4+qDpIm9h5KsdOEZWCz2mv/nyyNz6xPun9i04yI7IEbuqeCcEA0Qvo
         CgivbygcWx0y7mhjfCmX18Xhzn5RGGCZG5QjQIefM2kR6VCGk53vZyK+JaK0zwk7Gx1d
         chHzp7T1pf3t+s/JLVCigdlmd1eGo8/R3hfUzaSHyYJZRe2droz6Mi23YqCkEtxhCJfQ
         PINrqjyV0NTayQbZmjsA83XgxsDWW8qAyI3BP3aBYfb6/nnQnY4uOxlSs9Nllt9hD8tF
         d65Lj6T5vP8vOXD9/vzC8mh30K9mShaK4LbuVvMpojiNuar0rgHSi7GT1nIGWUpwBUDM
         jK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879676; x=1779484476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zaLNJCVWymRzHzAosL0l4Cb63oV8tVc7xKx597eZEkQ=;
        b=BYGLr//Uir9XBHO6vxAy+fsMYx+chXoNgUiKethiglSu7w0AReToBYk/GFRazyHH8n
         wRCW9CjskPum/9uaN4VjC4owCHQxZFDzaOMQRDWIC9mS02jq4B9yx68UtPvZJCyR9cSM
         29sEU5ygzZhmmJdS8vMM5zEJJJm7n+wqZG+qg+cjCG06pM4ZcPOXyXSZ3sUT/uKkt8w7
         PQCkXSXjdb4UnTJn1Krz44evYqllC9tCJVPQ3tivwevfiIY4CWHaDK/IuyzdNydow1jt
         7C3jFGklQFZbaTKk6tvfFgiQtmXiadLZqQLhX7zLPzyVtLYwS9Cfh0Rhyl1HdkNsM/tA
         vGmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WKk7vYyVratM6qQ+EgjJYa+4BAmHIfBYJRBojNoLfxQqdJxbs59SyzVVpO1f5OZzsE48jLJmdRodjwX4gsDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFH7/MybK4T6bjq9SQkGWBf6ZjmYBwrYfO3XWg+tGg3Rv6R7rw
	rrxnBOno+XG6y2oV15YuaoO1iURXtFsPBfoLVLK6Hpz4wYQUl3Phpg8a
X-Gm-Gg: Acq92OHuyP8XAVSmCrspRmJyjnbSrOX8HrtAGXVM7Kr5IPEhk7UtaR/g9jsYdMVSsar
	gO6pF1juWwAVSl+vp3KWBVgfzpCUoiYmYvUVeJ4xX8WS5mcS5KuUS33y4Nnlw+TcwKlXt2/Zvt7
	jXGVDhu+QKwy5J2FHN/T539Nn14HX/A9ISrjoftw+2+8N3WBtOf7iyTLEe5exj2ALTivNLKV0r3
	weJRbWAxIuAox/Qc3onEO3GgGWyf2Nsh3uA21eessd7PuHOWvzduQiktjsZZdWb7F6PH8HrcGd/
	SwmrRiI9NgnfnHoFf+rmHpU/gUf7STcpfC9qEqBEVtQ34GXR+I8tQ4/uJ+467WGQdVAhEBZ0Amt
	bFzkB1xOerYetBKjU9+ip0/4YUgnpjxoSQ9fmRNjEkPW1zLXWo7iGxj+VK5SzpcxgrkA1CqftFZ
	p7s6+mI5zJcPK21DvibdCh90jeP/UIvYg=
X-Received: by 2002:a05:7022:6b9a:b0:12d:de3e:86aa with SMTP id a92af1059eb24-13505642857mr2505039c88.40.1778879675567;
        Fri, 15 May 2026 14:14:35 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm11242540c88.12.2026.05.15.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:35 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
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
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 08/38] tpm-buf: Remove chip parameter from tpm_buf_append_handle()
Date: Fri, 15 May 2026 14:13:40 -0700
Message-ID: <20260515211410.31440-9-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CB8B557BAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9543-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,opinsys.com:email]
X-Rspamd-Action: no action

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Remove the TPM driver chip parameter from the function
tpm_buf_append_handle(). The chip parameter is only for error logging
which can be done with other facilities like WARN().

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c       | 9 ++++++---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 61833b4d81f0..99811809a72a 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -146,17 +146,20 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
 /**
  * tpm_buf_append_handle() - Add a handle
- * @chip:	&tpm_chip instance
  * @buf:	&tpm_buf instance
  * @handle:	a TPM object handle
  *
  * Add a handle to the buffer, and increase the count tracking the number of
  * handles in the command buffer. Works only for command buffers.
  */
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
 {
+	if (buf->flags & TPM_BUF_INVALID)
+		return;
+
 	if (buf->flags & TPM_BUF_TPM2B) {
-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		WARN(1, "tpm-buf: invalid type: TPM2B\n");
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 1fa3e8a43c79..c9dc35b57687 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -198,7 +198,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		}
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, &buf, pcr_idx);
+		tpm_buf_append_handle(&buf, pcr_idx);
 		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3b1cf1ca0420..eb67ae14ad73 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -257,7 +257,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(chip, buf, handle);
+		tpm_buf_append_handle(buf, handle);
 		return 0;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3c6a5bcc138a..b357f8971d03 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -235,7 +235,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.47.3



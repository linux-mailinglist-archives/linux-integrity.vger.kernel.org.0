Return-Path: <linux-integrity+bounces-7267-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729DDB98EB6
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E381D189C32B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4B6283FEB;
	Wed, 24 Sep 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="LDKQMBtb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3327FB3A;
	Wed, 24 Sep 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702936; cv=none; b=rNTGtcIG5+iXRm/xC+IV51MdiOkfbVSd+O3IGciyrIAZZYkTDYA+gLZdxMk9X5GrNhwYrCUeDLe6zX+7e+Mai90vuKHt78wVPrtPWc9nx8wiDXi4F3WMFMK6iLPHvpEBKtdq9pN0Fp5yNWEFdj8NRkiXuFzxVTYlD/JzCJBajMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702936; c=relaxed/simple;
	bh=tyuCDnoVt9JEMYaXQMhfbw8iscbYW3qwGrSm5PID79o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkna2RgPZXm53/GZI2UyZC+oQdMDvbXzjQ0X51M721NESLm9pry0fzorsXSGNRPg6vZObibFzCYd1dl5uVsbIbqpSCFDEN/9cAyblBpTpvXnir20yUiiBRfY0o0dSufIFN1UxM0Z2Am54u6/pk086bOhpdlWuUV/nRp6VABf+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=LDKQMBtb; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pU3TcxySbkmZ92KJsG90XcybzZ25TxylEc/PB+1mdW8=; b=LDKQMBtbfEOQQBwv9VEKS3OE0L
	exShnZlxZ4tkgoUaqYNnP7dka7+0lC1315UKIzo9/cr5bDv1fndzMDBEv8wDvGKy7qrcbdT3NhAGx
	Thi9z3LUnBFYc4bhDOuB/vipnT6BAhSofYjncEbqvYTR4/9dhGrsnEPXtFNQfmgWXyyZjeXvacirM
	jYH/waDOHdidRijpECfSZXMCkRGsPCSHf7fkUcbMAsjE6hYq4ZQgR+VPW4Csm3q63YU5wOysxkakq
	IsdIGF57J/6r8s9cRMSKTy6uLHHMl6PKaPeAHNGxNahGICUc456L9s7vKXlkMlUDaqFUbh5+IyGv7
	3qvqLyew==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v1KyD-00EFpj-02;
	Wed, 24 Sep 2025 09:35:25 +0100
Date: Wed, 24 Sep 2025 09:35:24 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm2-sessions: Remove unnecessary wrapper
Message-ID: <aNOtTIRBrzN_AAMa@earth.li>
References: <20250922115009.3053664-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250922115009.3053664-1-jarkko@kernel.org>

On Mon, Sep 22, 2025 at 02:50:09PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Open code tpm_buf_append_hmac_session_opt() because it adds unnecessary
>disperancy to the call sites (and reduces the amount of code).
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

I don't have a strong opinion on whether this is significantly better, 
but for 2 call sites it's not unreasonable, so:

Reviewed-By: Jonathan McDowell <noodles@earth.li>

>---
> drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++---
> include/linux/tpm.h                       | 23 -----------------------
> security/keys/trusted-keys/trusted_tpm2.c | 12 ++++++++++--
> 3 files changed, 21 insertions(+), 28 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index 7d77f6fbc152..89e6169add88 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -257,9 +257,17 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>
> 	do {
> 		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
>-		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
>-						| TPM2_SA_CONTINUE_SESSION,
>-						NULL, 0);
>+		if (tpm2_chip_auth(chip)) {
>+			tpm_buf_append_hmac_session(chip, &buf,
>+						    TPM2_SA_ENCRYPT |
>+						    TPM2_SA_CONTINUE_SESSION,
>+						    NULL, 0);
>+		} else  {
>+			offset = buf.handles * 4 + TPM_HEADER_SIZE;
>+			head = (struct tpm_header *)buf.data;
>+			if (tpm_buf_length(&buf) == offset)
>+				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
>+		}
> 		tpm_buf_append_u16(&buf, num_bytes);
> 		tpm_buf_fill_hmac_session(chip, &buf);
> 		err = tpm_transmit_cmd(chip, &buf,
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 667d290789ca..aaa407ddef21 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -534,29 +534,6 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> 				 int passphraselen);
> void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> 			 u8 attributes, u8 *passphrase, int passphraselen);
>-static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
>-						   struct tpm_buf *buf,
>-						   u8 attributes,
>-						   u8 *passphrase,
>-						   int passphraselen)
>-{
>-	struct tpm_header *head;
>-	int offset;
>-
>-	if (tpm2_chip_auth(chip)) {
>-		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
>-	} else  {
>-		offset = buf->handles * 4 + TPM_HEADER_SIZE;
>-		head = (struct tpm_header *)buf->data;
>-
>-		/*
>-		 * If the only sessions are optional, the command tag must change to
>-		 * TPM2_ST_NO_SESSIONS.
>-		 */
>-		if (tpm_buf_length(buf) == offset)
>-			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
>-	}
>-}
>
> #ifdef CONFIG_TCG_TPM2_HMAC
>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index e165b117bbca..c414a7006d78 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -482,8 +482,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 			   struct trusted_key_options *options,
> 			   u32 blob_handle)
> {
>+	struct tpm_header *head;
> 	struct tpm_buf buf;
> 	u16 data_len;
>+	int offset;
> 	u8 *data;
> 	int rc;
>
>@@ -518,8 +520,14 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 		tpm2_buf_append_auth(&buf, options->policyhandle,
> 				     NULL /* nonce */, 0, 0,
> 				     options->blobauth, options->blobauth_len);
>-		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT,
>-						NULL, 0);
>+		if (tpm2_chip_auth(chip)) {
>+			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
>+		} else  {
>+			offset = buf.handles * 4 + TPM_HEADER_SIZE;
>+			head = (struct tpm_header *)buf.data;
>+			if (tpm_buf_length(&buf) == offset)
>+				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
>+		}
> 	}
>
> 	tpm_buf_fill_hmac_session(chip, &buf);
>-- 
>2.39.5
>
>

J.

-- 
"Where else in computing can a random government that isn't even in
your country force you to make a change to your servers on three day's
notice?" -- Russ Allbery on DST


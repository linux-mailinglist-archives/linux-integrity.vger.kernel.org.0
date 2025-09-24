Return-Path: <linux-integrity+bounces-7268-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A55B98F7C
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83407B5DAB
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E2A29D29E;
	Wed, 24 Sep 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="DKqHeWjN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FCD26D4DD;
	Wed, 24 Sep 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703692; cv=none; b=W7OLMDVI0Ml7qMn9PoDYuwHYflAsf+8AjKPW31TxtccxVV5opL+ELt8T740peHWaOqXSZas/IJ8NpR80I9C3O9YWX7WwKIn4haCuccn2lig5LSAsEQ6Jjhc8E6gx1F96EbWlsOMH2Wqdi3BFbn4Lw5Op/mEwmTrX00B7m+oYGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703692; c=relaxed/simple;
	bh=uoE8mSHWj8gr4lpevWFr/wrq6ju50gysn6cSzYbmMr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjA6yFKSYrSn+bXbzBGWS4d2Mfy2esl9uu5UcisoWvTpB0sQqiMy+mdIpfRHB9FJAOkuj5cMO1PNqm/KfYwowXsAUpfXAfetl1PgzqU3cReLKXqbf8yMJeMUoOxOZTM6XRwQtX6r6EMdGos/8SsnfIXZUAX+iXTv0Q9J4zmhIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=DKqHeWjN; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6TJDoiWG2mkkA56m/9duvu1c2RVwOHrphW64bZCfJOY=; b=DKqHeWjN8FKSnINvE/HTMPI0Aa
	mcqaBv5uwey0+zFOf8l6oNmjmPVDkNT23S1pKhnM9WHqr50T3CAN/iKcbt1cg7F3uv78O/Bg7doef
	lefZZFyQ/k2biwajvOJCbnysfNOfYS/LgVxtVVkPIRqX099BToWrilKOlIWoBIICgH6jXLNzfTj7q
	slevQKzXRUTysgjbcbA0h7lA4hmzPZ5AG0K9xMhuK+TSpEPPUdsMzy2lQQtLhl3bNc+sc3YtUer/F
	jdIN29soZRvVZ2qhIgSks9YfcruPZ6ZDKsWgXh7YSd3fFRb+u5CdQccTNANLAkgJlYhlmd6+tKlSA
	eaLj0dxg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v1LAN-00EH85-25;
	Wed, 24 Sep 2025 09:47:59 +0100
Date: Wed, 24 Sep 2025 09:47:59 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 2/4] tpm2-sessions: Remove unused parameter from
 tpm_buf_append_auth
Message-ID: <aNOwP99WNsDgBVof@earth.li>
References: <20250922164318.3540792-1-jarkko@kernel.org>
 <20250922164318.3540792-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250922164318.3540792-3-jarkko@kernel.org>

On Mon, Sep 22, 2025 at 07:43:15PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>In earlier bug fix, an extra parameter was by mistake to the function.
>
>Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
> drivers/char/tpm/tpm2-cmd.c      |  2 +-
> drivers/char/tpm/tpm2-sessions.c |  5 ++---
> include/linux/tpm.h              | 25 +------------------------
> 3 files changed, 4 insertions(+), 28 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index 7d77f6fbc152..61a4daaef292 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -191,7 +191,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> 	} else {
> 		tpm_buf_append_handle(chip, &buf, pcr_idx);
>-		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
>+		tpm_buf_append_auth(chip, &buf, NULL, 0);
> 	}
>
> 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
>diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
>index 6d03c224e6b2..13f019d1312a 100644
>--- a/drivers/char/tpm/tpm2-sessions.c
>+++ b/drivers/char/tpm/tpm2-sessions.c
>@@ -266,7 +266,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> EXPORT_SYMBOL_GPL(tpm_buf_append_name);
>
> void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
>-			 u8 attributes, u8 *passphrase, int passphrase_len)
>+			 u8 *passphrase, int passphrase_len)
> {
> 	/* offset tells us where the sessions area begins */
> 	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
>@@ -327,8 +327,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> #endif
>
> 	if (!tpm2_chip_auth(chip)) {
>-		tpm_buf_append_auth(chip, buf, attributes, passphrase,
>-				    passphrase_len);
>+		tpm_buf_append_auth(chip, buf, passphrase, passphrase_len);
> 		return;
> 	}

This chunk below should be in patch 3/4 where you open code 
tpm_buf_append_hmac_session_opt, rather than here:

>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 667d290789ca..a8984d273c28 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -533,30 +533,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> 				 u8 attributes, u8 *passphrase,
> 				 int passphraselen);
> void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
>-			 u8 attributes, u8 *passphrase, int passphraselen);
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
>+			 u8 *passphrase, int passphraselen);
>
> #ifdef CONFIG_TCG_TPM2_HMAC
>
>-- 
>2.39.5
>
>

J.

-- 
101 things you can't have too much of : 19 - A Good Thing.
This .sig brought to you by the letter V and the number 13
Product of the Republic of HuggieTag


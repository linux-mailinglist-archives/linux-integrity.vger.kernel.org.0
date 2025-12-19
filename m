Return-Path: <linux-integrity+bounces-8119-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F5BCCF312
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E48CD3028105
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CC2F39C2;
	Fri, 19 Dec 2025 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="WC2cGonm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891D29D291;
	Fri, 19 Dec 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766137074; cv=none; b=LYosPwDLYU1QGVSrMwve/oun78b47JOBAIdtARSULIv8LZ5GrnpW3yao/7rB29fLuFHWjlIVzx5MgOi97X81A7Xon9r3v7F+4wSUOfS+TNxv0Vc+vlD9K5UEj/dht1Pn/2fk+fEfyjckzSOX/A3FuEQkrXtYGnYGPOjGCcnyOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766137074; c=relaxed/simple;
	bh=e5ds6+1TGSF8OhXAwhRZ/44ASECEgf7nSmR4HEBBfq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxdKwHeKqcYDMizKAFxPHkKGt10S9W+q3/O6OsIrzhSORF5lhsqCKN5cSgJ7FQwgHjaNSXyQRaKUOpuRd2CQsTudUPCJOJpwpxfvhCeky/z5ARrcdKEGcJ0FilvSHMbzyfs3b8WiGnCDAZu9zIji0FSWZ/3n89omwZYgeK3p5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=WC2cGonm; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TCSbG9lZZjyCbRQXC6cQoepl7PoqHA63k26utUIHb/w=; b=WC2cGonmCf8Wu1CjTwpq/DuOfF
	z100W+R3rVGR+Ol5qmvKgTKHzmvUjrxju6NeZmheKGNtj3VGoynaUtnRWbRssImGZnGGw6KPFT+gX
	9p+z6JkM4nmuNKPIqxVVqeZAunzkWA8fuoc0l7tQbHmXwIo+l7tCm2ppJzW+sdFsnyKaYciVxT+B3
	q+WfzLbipye5T4/BS9cVDoLdnnsWmIbSssezwGOHpPALGOk5xpFEsCO7NQwoQESsdO64qV/AkGkjB
	A3jJiWZM60t+jkJ9dy4lrabmAQp9Re8Pys4IomRgrYYIWcD7AI7wCFGO2RiJ2LlJco5dyjlRSJSD9
	ouZFZi3Q==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vWWvh-00EjkK-0d;
	Fri, 19 Dec 2025 09:37:45 +0000
Date: Fri, 19 Dec 2025 09:37:45 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 07/12] KEYS: trusted: Remove dead branch from
 tpm2_unseal_cmd
Message-ID: <aUUc6ftTmD-aUO6O@earth.li>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-8-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251216092147.2326606-8-jarkko@kernel.org>

On Tue, Dec 16, 2025 at 11:21:41AM +0200, Jarkko Sakkinen wrote:
>TPM2_Unseal requires TPM2_ST_SESSIONS, and tpm2_unseal_cmd() always does
>set up either password or HMAC session.
>
>Remove the branch in tpm2_unseal_cmd() conditionally setting
>TPM2_ST_NO_SESSIONS. It is faulty but luckily it is never exercised at
>run-time, and thus does not cause regressions.

Reviewed-by: Jonathan McDowell <noodles@meta.com>

>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
> security/keys/trusted-keys/trusted_tpm2.c | 10 +---------
> 1 file changed, 1 insertion(+), 9 deletions(-)
>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index d3a5c5f2b926..3666e3e48eab 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -451,10 +451,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 			   struct trusted_key_options *options,
> 			   u32 blob_handle)
> {
>-	struct tpm_header *head;
> 	struct tpm_buf buf;
> 	u16 data_len;
>-	int offset;
> 	u8 *data;
> 	int rc;
>
>@@ -495,14 +493,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 		tpm_buf_append_u16(&buf, options->blobauth_len);
> 		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
>
>-		if (tpm2_chip_auth(chip)) {
>+		if (tpm2_chip_auth(chip))
> 			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
>-		} else  {
>-			offset = buf.handles * 4 + TPM_HEADER_SIZE;
>-			head = (struct tpm_header *)buf.data;
>-			if (tpm_buf_length(&buf) == offset)
>-				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
>-		}
> 	}
>
> 	rc = tpm_buf_fill_hmac_session(chip, &buf);
>-- 
>2.39.5
>
>

J.

-- 
"Never test for an error condition you don't know how to handle."
  --Steinbach


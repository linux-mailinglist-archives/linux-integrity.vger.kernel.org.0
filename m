Return-Path: <linux-integrity+bounces-9058-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOv0FyeMwml9ewQAu9opvQ
	(envelope-from <linux-integrity+bounces-9058-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 14:05:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D92308E24
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CCAC30C29E8
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 12:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A686230595B;
	Tue, 24 Mar 2026 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXc+TxEn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l0qD4wtj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB12ECD3A
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356430; cv=none; b=o+gLhsJV1uoyJ3tLbSXh7BC/CKdf5xmlJaWx5v1aq7DX8s6R+WJzptuInvoYAcF3Qq/gXDx5ZN/8kaq7u6lc1xuY+GpSPCWDZbnr22VfmtOywvy9ik+mZzW79K/6Znlm5f9kjeOKWMHomQZhKzjk18hmrhqQEpPDiRPMbi7IDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356430; c=relaxed/simple;
	bh=44IdlH3Z1LynICfNHovtkTpe7uBuqeqxecs2MVt5sLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+dKlVEGw0B58Fzk9+UZGR2a0MPm5B97Su/KtBHVwf051+8MA8YC/+8/fcXZX+soxpuUR+mCiS5G+pJNO0liy1SuUGcD3qffgAOpeMUAxlT2/a84Fg57UzFZaCrOKPC6w3yBxJARac0QfdVATH9SSU81uPehjnNxihCbkvjdxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXc+TxEn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l0qD4wtj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774356428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQNV3OhO3qg7mYFlIKKOX7eBB9rn09wjtCW7vBNYpSU=;
	b=VXc+TxEnjUSLwnIRbYubbGaF+E+HOYnDB3jQds/CCKO3nXBlDw7HDZGZfTtOBfyI9UzIl6
	agx0el79Ra8xxO4GVHb4KEuvJzLQZCyK+IPtmVwblo4Kag1QgwNTS3jGACWU632y9HB06N
	ELURs7HsvlSxIYKJvuGorVVENihOsV0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-FUd5Bb_9M7uAmMB-y_84WQ-1; Tue, 24 Mar 2026 08:47:06 -0400
X-MC-Unique: FUd5Bb_9M7uAmMB-y_84WQ-1
X-Mimecast-MFC-AGG-ID: FUd5Bb_9M7uAmMB-y_84WQ_1774356426
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso42627225ad.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774356426; x=1774961226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQNV3OhO3qg7mYFlIKKOX7eBB9rn09wjtCW7vBNYpSU=;
        b=l0qD4wtjZWErE61Ncw8A0y0p8hnUAOoW2Ji2/I14RYht2+Oxpj4bXk3dztVcLbbRa0
         EhLqhh5giDPzejG9veKqKvKWrXYrk1kJIijTRnABhl/XahuvS4MZMnwXNRPMA6Uh7Ei2
         QPfeH9d51cKtdvKF06iTEs/AEMJZNfvSNBLBZw9u4il1kxpq7xRf9V440Ff7F4aM2X2c
         96Z5v6tHKdSAnP39IqKjeFFLqf1L6W3630/cR1QdfyKhVSa+mjVYFx35BiG/eLC10XuS
         LkPNnhC9HCeH0cpQ+5phdn6S87NvaApO0hBvt54uiIB/hCaa7PSTmHQ9X7nHbU2ZsnBG
         Jpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774356426; x=1774961226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQNV3OhO3qg7mYFlIKKOX7eBB9rn09wjtCW7vBNYpSU=;
        b=Rfp1SGNOjP+kFVONFM/TOewMUM/cpFmE3nhdaX9A9Cya2+njs5puoKQ0Z42JCZjQxL
         L/ABgBObhbcBviwmaa/syUGJfBWrqJ4ouX/DWPLALh42KjAtxNgnh2z3F3Vr41ion2F2
         UM1TQUHahM8QfewcM4qqydDZ1n+BoWAbum+xa2Eb2/7Y3remH062AKkNVYcqPp/I7ibw
         MdIocz0zBLwEi6PXNotR7pFBs8Mm7LI+j8Rm6onD/1PjXar3WEX0KJ8qIh/l3Sryqz30
         aQ3gLiSf2NxJdTPT5FtsdhDc/MB3FiAEgsLHmE4z+ldq3mqrEScqxGdrWICXA+xAEj22
         c5lA==
X-Forwarded-Encrypted: i=1; AJvYcCUBxt2do4Kv84GkK0VQ6oUBjkv33ASajOdnYrwBRfqN20/rz5MdhLrWb9Jf/7hicNGZvBqZr16s1SCcO12RzME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTrYPkz4mhcO3uB8Ao8URpKc24W4fA3VtzgH5Gb53m58/f+R0
	0qVSGfRJSZEV90OtKqzasAN1VkQmuisDbztgrhhtmUgRilfpoJNACVF74z4eDKGpMNfG/Yqoe82
	HQOU0UObgsCvjUt2V6A/5JU3YZhPBfAuxmUAm1Pkj4oRAVYwz0BXOaPmRetYVIo1c10j10A==
X-Gm-Gg: ATEYQzyvrXvQOIOtUJPbqxPMa6Q5c6BFckD5eCgATOhnF/S+grwHKb80M3azvaPGXA4
	R8Xg+vPCCWDK0SFopbQZxpI5dsyedT/CrKQBqXWsya3+EvIydkb1oSfiXi7r2BbrH0nMFcXSBiB
	VlNC8q9IaZv6KV/yCCMDxtAFqQI9lV5spbYYUegPN3eehP3rs+zm5kmekWyxqqgjGCvDB55oDUV
	MdK0H+o7jaMQvmYLsUPmt9TO5o3eFqM0rjkOXI855An/owjFUFH9aRBmkW4Tpfp5zg0gNeVEtuU
	WViki4nxP9Mdpg3V+MAUmwQ0Rw9lqvoVDve34czLgsyb1vC7AQhj7e3I7o6TksOz7Xa3FmSFrgz
	uPjyQiJ+HqHM=
X-Received: by 2002:a17:902:f60a:b0:2b0:9a61:9e9 with SMTP id d9443c01a7336-2b09a611475mr77425545ad.32.1774356425617;
        Tue, 24 Mar 2026 05:47:05 -0700 (PDT)
X-Received: by 2002:a17:902:f60a:b0:2b0:9a61:9e9 with SMTP id d9443c01a7336-2b09a611475mr77425305ad.32.1774356425148;
        Tue, 24 Mar 2026 05:47:05 -0700 (PDT)
Received: from fedora ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm142658105ad.25.2026.03.24.05.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:47:04 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:16:59 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 3/4] tpm_crb: Implement command and response chunking logic
Message-ID: <acKHw25k62JUbea_@fedora>
References: <20260324071803.324774-1-armenon@redhat.com>
 <20260324071803.324774-4-armenon@redhat.com>
 <acJrSXwUMjh5Pt_8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acJrSXwUMjh5Pt_8@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9058-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3D92308E24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 12:45:29PM +0200, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 12:48:02PM +0530, Arun Menon wrote:
> > Add support for sending and receiving TPM command data in chunks when
> > the payload exceeds the physical size of the hardware MMIO window.
> > 
> > This introduces the following changes:
> > 
> > - crb_map_io(): Checks the device interface capability to determine if
> >   chunking is supported, setting the chunking_supported flag. It also
> >   stores the hardware's maximum response buffer size in priv->rsp_size.
> > - crb_send(): Iteratively writes command chunks to the fixed priv->cmd
> >   MMIO window. It signals the TPM backend to process intermediate chunks
> >   using CRB_START_NEXT_CHUNK, and signals the final chunk to begin
> >   execution using CRB_START_INVOKE.
> > - crb_recv(): Parses the expected response size from the initial TPM
> >   header. It then iteratively reads chunks from the fixed priv->rsp
> >   MMIO window into the destination buffer, advancing the buffer offset
> >   until the complete response is retrieved.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> 
> This is also just description of wha this adds. I'd lessen the detail
> and write a description that describes motivation and logic of the
> change. It's a good test for author knowledge, as if you really get
> the topic you can explain its gist. In addition, it can be reflected
> to implementation (vs. the descriptions that are pseudocode in English)

Sure, I will replace the commit message with motivation+logic instead of
explaining the code step by step.

> 
> Since this RFC and QEMU does not have the feature in release it is
> good to polish stuff like this.
> 
> > ---
> >  drivers/char/tpm/tpm_crb.c | 150 +++++++++++++++++++++++++++----------
> >  1 file changed, 109 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index 10128d078245c..fb63cc3737253 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -104,11 +104,13 @@ struct crb_priv {
> >  	u8 __iomem *cmd;
> >  	u8 __iomem *rsp;
> >  	u32 cmd_size;
> > +	u32 rsp_size;
> >  	u32 smc_func_id;
> >  	u32 __iomem *pluton_start_addr;
> >  	u32 __iomem *pluton_reply_addr;
> >  	u8 ffa_flags;
> >  	u8 ffa_attributes;
> > +	bool chunking_supported;
> >  };
> >  
> >  struct tpm2_crb_smc {
> > @@ -368,38 +370,6 @@ static u8 crb_status(struct tpm_chip *chip)
> >  	return sts;
> >  }
> >  
> > -static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > -{
> > -	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > -	unsigned int expected;
> > -
> > -	/* A sanity check that the upper layer wants to get at least the header
> > -	 * as that is the minimum size for any TPM response.
> > -	 */
> > -	if (count < TPM_HEADER_SIZE)
> > -		return -EIO;
> > -
> > -	/* If this bit is set, according to the spec, the TPM is in
> > -	 * unrecoverable condition.
> > -	 */
> > -	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> > -		return -EIO;
> > -
> > -	/* Read the first 8 bytes in order to get the length of the response.
> > -	 * We read exactly a quad word in order to make sure that the remaining
> > -	 * reads will be aligned.
> > -	 */
> > -	memcpy_fromio(buf, priv->rsp, 8);
> > -
> > -	expected = be32_to_cpup((__be32 *)&buf[2]);
> > -	if (expected > count || expected < TPM_HEADER_SIZE)
> > -		return -EIO;
> > -
> > -	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> > -
> > -	return expected;
> > -}
> > -
> >  static int crb_do_acpi_start(struct tpm_chip *chip)
> >  {
> >  	union acpi_object *obj;
> > @@ -474,6 +444,8 @@ static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
> >  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  {
> >  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	size_t offset = 0;
> > +	size_t chunk_size;
> >  	int rc = 0;
> >  
> >  	/* Zero the cancel register so that the next command will not get
> > @@ -481,7 +453,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  	 */
> >  	iowrite32(0, &priv->regs_t->ctrl_cancel);
> >  
> > -	if (len > priv->cmd_size) {
> > +	if (len > priv->cmd_size && !priv->chunking_supported) {
> >  		dev_err(&chip->dev, "invalid command count value %zd %d\n",
> >  			len, priv->cmd_size);
> >  		return -E2BIG;
> > @@ -491,16 +463,101 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
> >  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
> >  
> > -	memcpy_toio(priv->cmd, buf, len);
> > +	while (offset < len) {
> > +		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
> > +
> > +		memcpy_toio(priv->cmd, buf + offset, chunk_size);
> > +		offset += chunk_size;
> > +
> > +		/* Make sure that cmd is populated before issuing start. */
> > +		wmb();
> > +		if (offset < len) {
> > +			rc = crb_trigger_tpm(chip, CRB_START_NEXT_CHUNK);
> > +			if (rc)
> > +				return rc;
> > +			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> > +			    CRB_START_NEXT_CHUNK, 0, TPM2_TIMEOUT_C)) {
> > +				dev_err(&chip->dev,
> > +					"Timeout waiting for backend to consume chunk\n");
> > +				return -ETIME;
> > +			}
> > +		} else {
> > +			rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> > +			if (rc)
> > +				return rc;
> > +		}
> > +	}
> > +	return crb_try_pluton_doorbell(priv, false);
> > +}
> >  
> > -	/* Make sure that cmd is populated before issuing start. */
> > -	wmb();
> > +static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	unsigned int expected;
> > +	size_t offset = 0;
> > +	size_t chunk_size;
> > +	size_t first_read;
> > +	int rc;
> >  
> > -	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> > -	if (rc)
> > -		return rc;
> > +	/* A sanity check that the upper layer wants to get at least the header
> > +	 * as that is the minimum size for any TPM response.
> > +	 */
> > +	if (count < TPM_HEADER_SIZE)
> > +		return -EIO;
> >  
> > -	return crb_try_pluton_doorbell(priv, false);
> > +	/* If this bit is set, according to the spec, the TPM is in
> > +	 * unrecoverable condition.
> > +	 */
> > +	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> > +		return -EIO;
> > +
> > +	/* Read the first 8 bytes in order to get the length of the response.
> > +	 * We read exactly a quad word in order to make sure that the remaining
> > +	 * reads will be aligned.
> > +	 */
> > +	memcpy_fromio(buf, priv->rsp, 8);
> > +
> > +	expected = be32_to_cpup((__be32 *)&buf[2]);
> > +	if (expected > count || expected < TPM_HEADER_SIZE)
> > +		return -EIO;
> > +
> > +	/*
> > +	 * Set chunk_size by comparing the size of the buffer that the upper layer has
> > +	 * allocated (count) to the hardware tpm limit (priv->rsp_size).
> > +	 * This is to prevent buffer overflow while writing to buf.
> > +	 */
> > +	chunk_size = min_t(size_t, count, priv->rsp_size);
> > +
> > +	/*
> > +	 * Compare the actual size of the response we found in the header to the chunk_size.
> > +	 */
> > +	first_read = min_t(size_t, expected, chunk_size);
> > +
> > +	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
> > +	offset = first_read;
> > +
> > +	while (offset < expected) {
> > +		if (!priv->chunking_supported) {
> > +			dev_err(&chip->dev, "Response larger than MMIO and chunking not supported\n");
> > +			return -EIO;
> > +		}
> > +
> > +		rc = crb_trigger_tpm(chip, CRB_START_NEXT_CHUNK);
> > +		if (rc)
> > +			return rc;
> > +
> > +		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> > +					 CRB_START_NEXT_CHUNK, 0, TPM2_TIMEOUT_C)) {
> > +			dev_err(&chip->dev, "Timeout waiting for backend response\n");
> > +			return -ETIME;
> > +		}
> > +
> > +		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
> > +		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
> > +		offset += chunk_size;
> > +	}
> > +
> > +	return expected;
> >  }
> >  
> >  static void crb_cancel(struct tpm_chip *chip)
> > @@ -727,6 +784,15 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
> >  		goto out;
> >  	}
> >  
> > +	if (priv->regs_h) {
> > +		u32 intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
> > +
> > +		if (intf_id & CRB_INTF_CAP_CRB_CHUNK) {
> > +			priv->chunking_supported = true;
> > +			dev_info(dev, "CRB Chunking is supported by backend\n");
> > +		}
> > +	}
> > +
> >  	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
> >  	rsp_pa = le64_to_cpu(__rsp_pa);
> >  	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
> > @@ -764,8 +830,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
> >  	priv->rsp = priv->cmd;
> >  
> >  out:
> > -	if (!ret)
> > +	if (!ret) {
> >  		priv->cmd_size = cmd_size;
> > +		priv->rsp_size = rsp_size;
> > +	}
> >  
> >  	__crb_go_idle(dev, priv, 0);
> >  
> > -- 
> > 2.53.0
> > 
> 
> BR, Jarkko
> 

Regards,
Arun Menon



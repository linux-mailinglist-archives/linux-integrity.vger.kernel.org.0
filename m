Return-Path: <linux-integrity+bounces-9057-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Nd5EvOLwmlvewQAu9opvQ
	(envelope-from <linux-integrity+bounces-9057-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 14:04:51 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFBE308DF6
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5919731591C1
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 12:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D8C3F7E69;
	Tue, 24 Mar 2026 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKdK4gg/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M896PAlF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D83EF0DE
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356211; cv=none; b=TL/w/OX4S92Mh/hxhWG1qJcv1e7ZqSCweiRvWuIppHJnxUqHWgEZnPLpc0pclFHxqxY0IEheRajXFJqoX8t5Y+Pc8AKNCVmWuCjBuaQZog+v55c+uBSqOnUyVEVE0cn2X2uaV+I4VHJskJ+6Fqz/daYPGiHDeYTR6bxmn5GqtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356211; c=relaxed/simple;
	bh=DfCasftR2+STAIXtK4P1K7UNMedi1wRjkjqs6vtyekk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGli6li4oY7ps5yQraxPk5ClGYK9UZIKGN0kFINNfRKB8YQW0ttl2zeADXngh0tYQ1OXqiBqXt5hCkx8vIjf9YA3Pefv9zL8QjJJ2K19YhKg+P5Inmtb+0rS7vyzhZZ/hisGD9GHqJkX4GkKxj0jfXXK6+rOomlMLa2PKtsfViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKdK4gg/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M896PAlF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774356208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oXBEexzzc00jtShUxwuQCa8xhkwv2sQ0t93WL1ksRk=;
	b=DKdK4gg/zbHhKODt6sApYCq954mkQb84IFbS83q9pVVJYsOxitsM2xJ294fxIRY7mD+Idj
	6nFdblhrBQx0cqGDm3255T0GYmHbx6wXhoHJAnbKnhSJtQTCMBz5H31UssbqOxP1u7XWMe
	xU54XYIm485juAhDHOVWmN5H8a2FMFY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-tJFJvcV8PrO1hZ7rMS5gKA-1; Tue, 24 Mar 2026 08:43:26 -0400
X-MC-Unique: tJFJvcV8PrO1hZ7rMS5gKA-1
X-Mimecast-MFC-AGG-ID: tJFJvcV8PrO1hZ7rMS5gKA_1774356206
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35449510446so1371975a91.0
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774356206; x=1774961006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oXBEexzzc00jtShUxwuQCa8xhkwv2sQ0t93WL1ksRk=;
        b=M896PAlFFytdqNDoBocZ9spNX34NOrhl3J2MaC8yQLd25zW1Fq4vrzml4oTtcS9Ekx
         mGE4Qf9Hi0ar/xlwtopCN0eyptu6CX+onSTsC7wqv/0tDuppmuVpYsgsNiNGpVw3aqZs
         EHwvQX4Ky0TxTmZFLwu7KeNh56Dgs53nv+5ty8V2heHGEjpDaYcb1gQCPi+avbcCQyiY
         nE9s3cOxeEBr3LVsb9J/HOmSE2rnhNZFmvjK7rf0fVdPaQDCc5wFMgz+MmnhrF3ARXQd
         P5t4q/EG4uNGTEkFIo+fge5UvgCsq2g6MjhSseKrjAuZ9Tg9SX+VIkeHM6EtP4rQBbPW
         iLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774356206; x=1774961006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oXBEexzzc00jtShUxwuQCa8xhkwv2sQ0t93WL1ksRk=;
        b=a/NaFSYTnfg2U3DMZo96zY/eoHPTZXs5WE++jzkyepE3Doyaviu4wdcW8mbCYbxGtG
         loxbLor8tuVJMmb0uaBFo4em2KEQU3guyMUlMsJ7AGUZktXNtqKZ7DadLEPV3rZw8GMg
         am43Kx6EZkH0bek3uxRet2F1Cs4jOi8Xt1an/A2MAW5H9Qwgibjg7SDNVzErD/bTgJoi
         B/uPND59ECNwXAYWm/wyLJ+sXg3MoiM08k2NAkgelduFcJyEzYepfw+3QJwBzFOCZQ9B
         gEcVP6kmaBgQKcKox4EZRs/KcAe6qyTo3tyrF6nCtnhZ9wejdopnEOf34yTZM4JuHbnC
         WXyw==
X-Forwarded-Encrypted: i=1; AJvYcCVconGKw1KROz4yGsZizSccvmQh936u/cK55UteuxzY/sCF39jRkjK3eKCvBFXa9xYIJF6k3KzrT+RBkLbCsYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MVh+P5/WZsPMauQFDb8zAI4DcEG41DCvDx5PechdnCanmato
	a4lY2MUZpwPz4EGbqGpungi6qbzCAKHuMK3ZS/CSwMxbUKYlvLAx8cXXcAESJRXHjFM3C7yRZ2I
	CTzTZ0R0ncq8qS3y7DZOMMIwUOXoK6Vc8yToYEn3ET2LcDZqh0BMUu2znR9nNWZttIlJLww==
X-Gm-Gg: ATEYQzzdogm246/U6o8VZuKXjFsebfERAe28AtyPW9dk27gnhSzlT3a3KTp6dznFqg4
	06fDSyV73gbhHi+w/UJEdh1LNu7GlN+10v3vCKDtAtECTzQgWOaq55bUoXB2un+4jWZu+EorFIt
	ygfGSmr/3RgUKYdrmvf2plWUWmJtHTkZ7/BPfcocOA/RQBESreiz7AOITgvBVBKMeOtvhtm6itJ
	Q6h6tgG0a07Gn/Q7fdfRhneGWzkyTTTs7BrHupU9zH9+RD0oJivFy7dGj8+nXDmmmpIZYgjM0st
	HWvxiLMc1AOL7FwIickfDukAQ2LcYaob3ygzHOcMHPBB2xOPivgZHjq7JvN1JS5Lim/tLuog/Yh
	6sp3XB0CYClE=
X-Received: by 2002:a17:90b:4c52:b0:35b:e529:2d60 with SMTP id 98e67ed59e1d1-35be5292d67mr8667088a91.8.1774356205779;
        Tue, 24 Mar 2026 05:43:25 -0700 (PDT)
X-Received: by 2002:a17:90b:4c52:b0:35b:e529:2d60 with SMTP id 98e67ed59e1d1-35be5292d67mr8667060a91.8.1774356205309;
        Tue, 24 Mar 2026 05:43:25 -0700 (PDT)
Received: from fedora ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03134bd2sm2423125a91.5.2026.03.24.05.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:43:25 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:13:20 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 2/4] tpm_crb: Add new wrapper function to invoke start
 method
Message-ID: <acKG6EQ_tXO8eqfj@fedora>
References: <20260324071803.324774-1-armenon@redhat.com>
 <20260324071803.324774-3-armenon@redhat.com>
 <acJqi8S81I2hwvsR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acJqi8S81I2hwvsR@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9057-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EFBE308DF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Mar 24, 2026 at 12:42:19PM +0200, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 12:48:01PM +0530, Arun Menon wrote:
> > - Extract start invocation code into a separate function called
> >   crb_trigger_tpm. This will be helpful in repeatedly calling the
> >   start method with different bits set to toggle between start,
> >   nextChunk or crbRspRetry behaviours.
> > - Based on the bit set, we signal the TPM to consume
> >   contents of the command/response buffer.
> > - No functional change intended.
> 
> Please write a proper commit message, which is not a task list.

Yes, I shall do that. Thank you for taking a look.

> 
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
> >  1 file changed, 27 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index 67c0061d4cab7..10128d078245c 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -445,6 +445,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
> >  }
> >  #endif
> >  
> > +static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	int rc;
> > +	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> > +	 * report only ACPI start but in practice seems to require both
> > +	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> > +	 */
> > +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> > +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> > +	    !strcmp(priv->hid, "MSFT0101"))
> > +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> > +	if (priv->sm == ACPI_TPM2_START_METHOD ||
> > +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> > +		rc = crb_do_acpi_start(chip);
> > +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> > +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> > +		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> > +	}
> > +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> > +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> > +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> > +	}
> > +	return rc;
> > +}
> > +
> >  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  {
> >  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > @@ -470,29 +496,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  	/* Make sure that cmd is populated before issuing start. */
> >  	wmb();
> >  
> > -	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> > -	 * report only ACPI start but in practice seems to require both
> > -	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> > -	 */
> > -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> > -	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> > -	    !strcmp(priv->hid, "MSFT0101"))
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -
> > -	if (priv->sm == ACPI_TPM2_START_METHOD ||
> > -	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> > -		rc = crb_do_acpi_start(chip);
> > -
> > -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> > -	}
> > -
> > -	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> > -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> > -		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> > -	}
> > -
> > +	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> >  	if (rc)
> >  		return rc;
> >  
> > -- 
> > 2.53.0
> > 
> 
> BR, Jarkko
> 

Regards,
Arun Menon



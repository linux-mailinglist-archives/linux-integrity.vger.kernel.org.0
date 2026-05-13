Return-Path: <linux-integrity+bounces-9529-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGWmHBJcBGqiHQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9529-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 13:10:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD17B531EBA
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 13:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0F31300D603
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2026 11:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542EC3859CC;
	Wed, 13 May 2026 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5iTIbm5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nenFu8bx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8733E9C29
	for <linux-integrity@vger.kernel.org>; Wed, 13 May 2026 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670576; cv=none; b=F8iPCo58WxAtg/kn9bK6+b2tj8+fyrAFY+DLeQzE4JjMv7tq2ADqPqDixw/oNfJcgY2bLpXjLqIUEAq3pTpbScOc7OZ/2+z1+Chv9PrurUKNhK/dZeWS9OCKNoXL2OF3s4LV8y7/fymtsN8Z2EeGtuDuu1ShwaTFQE2f/y506/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670576; c=relaxed/simple;
	bh=VxZrVHvvMTsJO+0g5aFCaePGNp5xIFjPpLQeQ27rCeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfNobJLP5YC9RbsotiaWrosZRaB1aL0PikyVVFfFzHwOYyKoxzWh5M+GbjkWlz9M9NMFCNBptJxbsMMz7hQvcHc4ng35ToENjjZlk/hWC3+K731qFudP79Rq+fzzO266aLvnHF8wYlEsvKHu6UP0FpE5CD9VIQpCccGnIW/Y6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5iTIbm5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nenFu8bx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778670574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RlJfaQI3WYwGNvwR+AOHY2/jIgelfdXHLs6DnIAFBw=;
	b=Z5iTIbm5bKUUIEjRJ4JmkZGFP5LtcPKGUbICWxR7OJcnYb42FoFcHE7vJ1aamFZMsenyW3
	3TuC8H7OP8KxoT5/EFwWa7JXGgDd09RucmwT2NXsSYNgvc3OXecntC3LkfyYuChs0Q2D9Q
	NB8Wzcn7+ssy6N5+ay0BY8sWQn8jXIM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-vzXSENZhNJSE28lZVVCZIQ-1; Wed, 13 May 2026 07:09:32 -0400
X-MC-Unique: vzXSENZhNJSE28lZVVCZIQ-1
X-Mimecast-MFC-AGG-ID: vzXSENZhNJSE28lZVVCZIQ_1778670572
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36641bb3d97so4110107a91.3
        for <linux-integrity@vger.kernel.org>; Wed, 13 May 2026 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778670572; x=1779275372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RlJfaQI3WYwGNvwR+AOHY2/jIgelfdXHLs6DnIAFBw=;
        b=nenFu8bxSZCxTXd1fp0cVgXYP33nQqHPbt6r6rih5bedss2xp6RMWQGq8jeZTLSTP4
         5CDfPS2nHt3+eiIPjzoCzQfVI9BWkxwHdiYx00ld60vwphTP35bZlAC76TiX8BR4BbXQ
         Ys1xQdac0HtZ6T9Mm/r2d0MtFeQmFsE8sMZCltxs4epfK/HWNRVbWfkJpIuu7YJsM3s8
         yaFGrn1Xvzngay32RRIl13yKPc1u0rcRxpllv5SnqG/50gq9VtOk02YdJh6mT5VYpWVv
         UI8tw73Gs2Zl8lD081KtQI8EH/9Ug7u5FJnbnyrA8SSWV6Hg8AN3mcIKAAuEh7hprU47
         FCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778670572; x=1779275372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RlJfaQI3WYwGNvwR+AOHY2/jIgelfdXHLs6DnIAFBw=;
        b=qxu3JcBfnrvHW+kCITDot8HpK4k8WhOTztX63MArQnqyUufaB9nTZrO228/n2NbnsH
         3qRrCqqoeydSdqMjQOAuh3dQtAvNtLNO5yv76SVuAxckvYIKA13lJx4xIEMEWxhjUZEb
         y7cKB4yIXaJEn8sRGX6DCjHlMbRL4VHHGK3k/XNRbDsMJmr6Xmb1xrLQbU7pmdOzdCny
         BgQoCufCuuu8u85K+NimKHXYfkAZ0UCVZGCV1qOTTX/OQWw7HO5ZHdH1JdIalsYcEml2
         o9uWqbItlBNt5OXkTjT5XA06e/6c8fcfx41xneK7J1y3QOmFwdXsq0n7l+TFVW5tECCW
         en3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+fa9S+DhcHgLuJj973ibk6Xjue7XfYFt9806I9M/TWv+Nnh4gYbt+2ACmnUA+5D3uv+lH6nmbx3NR26pwqWQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytiUX1DKmEa/6IOr/Ro+vl5RzkEx703hUTdYGTdVJNbeKwt7RD
	nVkqMhiTYFd2X5Gh9u2uZRjpL6OneJrhOJ+ox7dHxrnDx1W/I/VRUGlJdDabvmjSgCbWc23Tklk
	SjtJnM2VgaJ3+iIiUHVQ+qTOCA7jntII4sMQB1gY8Ohkr8mDmeocw8D+AXeqmQwAbz3H5tQ==
X-Gm-Gg: Acq92OFw/l0uJYUTBDoqw7B7b2TrbgzGtPoIt4QlNcWpB5mNCIBcXg51HaHhnD6D5v1
	2jvbaeVKT9se3+R10+DJnxFWNUQ2w+IBRWBALVno+FPGn14fdyYw1odYoD7LC0aEb8XyezBbLzs
	KKe90FN4HnuC64RadTx4lez2d3aOr9+xs3QAMhHM96yO8caJiyRi2JdEV6kG19utKoDAFp3+8Qy
	03VTxSPicLaZsClgz+L1wFS8f+oV+yzePeev2+9SCMEZhs10vhIpjss6I3IsPFsvn/IjzP3fo3J
	tuxwnMlAgnJIY6MKW+jyRgnB7xe23cVWpSsodQn9aFkSuec6vn17lvwLsVpvbFQz0xNKRuFdeK1
	Iy5X4sq5CYawa
X-Received: by 2002:a17:90b:51ca:b0:366:3df3:fe45 with SMTP id 98e67ed59e1d1-368f3e43e84mr3063210a91.19.1778670571674;
        Wed, 13 May 2026 04:09:31 -0700 (PDT)
X-Received: by 2002:a17:90b:51ca:b0:366:3df3:fe45 with SMTP id 98e67ed59e1d1-368f3e43e84mr3063186a91.19.1778670571226;
        Wed, 13 May 2026 04:09:31 -0700 (PDT)
Received: from fedora ([49.36.106.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf4d95bsm3806341a91.6.2026.05.13.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:09:31 -0700 (PDT)
Date: Wed, 13 May 2026 16:39:24 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 4/5] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <agRb5FClggBcNvGe@fedora>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-5-armenon@redhat.com>
 <af9KnU90yMf8MxnQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9KnU90yMf8MxnQ@kernel.org>
X-Rspamd-Queue-Id: CD17B531EBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9529-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 05:54:21PM +0300, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 11:42:43PM +0530, Arun Menon wrote:
> > The size of the command is checked against TPM_BUFSIZE early on before
> > even sending it to the backend. We therefore need to increase the
> > TPM_BUFSIZE to allow support for larger commands.
> > 
> > For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> > also order-1 safe.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  drivers/char/tpm/tpm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 87d68ddf270a7..26c3765fbd732 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -33,7 +33,7 @@
> >  #endif
> >  
> >  #define TPM_MINOR		224	/* officially assigned */
> > -#define TPM_BUFSIZE		4096
> > +#define TPM_BUFSIZE		8192
> >  #define TPM_NUM_DEVICES		65536
> >  #define TPM_RETRY		50
> >  
> > -- 
> > 2.53.0
> > 
> 
> Shouldn't this prepend previous patch?

yes, I am going to put this and the i2c patch before the chunking logic.
Thanks.

> 
> BR, Jarkko
> 

Regards,
Arun Menon



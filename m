Return-Path: <linux-integrity+bounces-9460-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLH1Hdjs+mn3UQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9460-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:25:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E864D72EC
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E34A303989D
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394D4372EEF;
	Wed,  6 May 2026 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho/JMMaC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pfnbdDfe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C0373BFE
	for <linux-integrity@vger.kernel.org>; Wed,  6 May 2026 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052068; cv=none; b=h497Ts+0jP/M0892zxsz4sNvtD4XndAxhwoSHKtAwxgEyQiCW91jC+/nPLiu5CTIrsKUywCjhzEMDeKTqdf4a+RBHK6zziKGD0WOE5lU6m6uuG9Ric5rYi+DRirTC4nt5lQ4o05b63A+5lLTATRYHkKIdlOyn2UkNLGe6Rxo7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052068; c=relaxed/simple;
	bh=0k/z0bv4zIRj02dwbU1ejwXJBkT6cJrSocTE8aS6j6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/PrrIJm4Aerx8lc3j3aMoYm00BNhMYR0rMRf4zG0+Zzk+EZkTHa1R1GyiuPXQcp6Bvt2g86F4lEQmQVf7Z4XWLbpJKorxJoTVVb9ZappX8Ex9OV8GN8sc0qTp1GEU9Ufxoev5le9Udu6DR8GtzbIFsWUdkyj0VA6anly2ezWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ho/JMMaC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pfnbdDfe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778052065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k/z0bv4zIRj02dwbU1ejwXJBkT6cJrSocTE8aS6j6c=;
	b=ho/JMMaCo99TrO1pjbp0/N1IwhAivlpnaoMdzI7l+KjCvldRKnQfDq5a06H9kJyn3GBLrl
	TLFhjmUALw0mmbTkqgsII3N3HZ1tbIwR38LIhn/mG7+Gem+8t6/mZs8GCAdZQg1/1BAfT3
	wZPcjSwF7OOhIuzS93ZuzAnrx9E1fP4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-VeDe-OJIP4Gmw2h7wjiy9w-1; Wed, 06 May 2026 03:21:04 -0400
X-MC-Unique: VeDe-OJIP4Gmw2h7wjiy9w-1
X-Mimecast-MFC-AGG-ID: VeDe-OJIP4Gmw2h7wjiy9w_1778052063
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e526e11ccso3238955e9.3
        for <linux-integrity@vger.kernel.org>; Wed, 06 May 2026 00:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778052063; x=1778656863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0k/z0bv4zIRj02dwbU1ejwXJBkT6cJrSocTE8aS6j6c=;
        b=pfnbdDfenhlaR4Icld3XxMV7U7V1nniCBRx+z0QmX5wqNatNPABFKNaGc+54yVqLQK
         Fyriy3HdL8dgcCbbzfgoBmmULx6ZiRfGsjXR7PaU59JDcbrexF49KQ9Cbwr4QrNHLzsa
         /kD7q7bFIDzCeUIQKEMVPBsJem+ltNxwwG+VQhjJW5gpoucHxffnP6asGFK9EID3+rN6
         02sk3cYRQHgFQo242aNe7FoZqmloK+LdPO00uP8gYP4HOPbDmbewnSvkcZ+uKr8plgpK
         B6+SId1ZYCft/hOPpVZDPNFUJSyJXmulzq0AyriZgJ3+MH7C+8VVtW4tKqQKD0ne9lgH
         n23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778052063; x=1778656863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k/z0bv4zIRj02dwbU1ejwXJBkT6cJrSocTE8aS6j6c=;
        b=M68ZQrkVY1GaKAUSQ+uqPoy/lQPyy5QuuZRyghqHcdLlNjbieGzdvLMPcTsnRtptjr
         b0mtAfZkGrm2XZ9QgweUQbDUS3bwKSB1HNWuBKIOX1Y9nCbpPNS7m/uigKbsbQVAKmgR
         xUPWlqG6snLIzske0ds7YyZcXhsjtU6YlZqQEAEKmyttEB5aAoRUkM54PX0f0IuQdsg8
         0IyhsYfgfH0vOpRYJbr3Rgfp7VxxwhjZA6inRBSxS6xBt8+lfdZczLclZ/6sEwZ1ybJw
         /kApqJG2fpF+hlm1Vl/kTc8eYDhyCWg22w6+PtISam3Xg1nQm2EaAi/T22L+3aay5wWL
         /i9w==
X-Forwarded-Encrypted: i=1; AFNElJ9EOotsSpX2QXrMAbxggDio+uuhRO+0byxN1zv+ngc47EZTBATeqwCRaOD/uoW3rqK/2SxyeAxdXSicRuUCjRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYt2aOKKZrdi+eb8VXTdGZ+6fzXzkJjrc595YWeh2ihfdQabSn
	EfE4wQ6vSEVI3O/a/nnVpIvePEj3l3Kdr1uT4Jq1jVAlZS5VkOtlwiCh37aMH4GZUq8I7Y41228
	0NjgFNydH12iK10fN4S/y7YgIUHozegoRteAxAtpYamgCe7KncpqlNdquRtQo6p1R3tsNlA==
X-Gm-Gg: AeBDietftefv9KMn2wJzJB2e9etTCaJ1f62sgEl6+FommZLPc+cIXOCIunzO9/1QR5r
	HmdByO1v2xIP82YQorH/tUcGbtUOWAl5DMnerIi7Y/8oIKkZdSae8/BusnVWL6HJBhq/DKnAVoz
	ClLv41SGjC/xYVpl4hpew4q38FgzjtP0TDqNAdBhtofvievS78ErMnxor43h4/n0biq/WAiDTZw
	2f7PD+p4Z6tz3vso/GFvfG4nXc5iqDqdzAiwAGtVmoW5vABj37sknZpFAQe1PjMaKP4TpZaqRzB
	Z3avg5GNQCbpIk4yBspIsICbw8/wGEKtKqaFa0BW9XWinXEeyJwhjAWQgSI50ICFqTa8z++7MXB
	Afw2KrdyNQfoG/m2fOMY+dBamfUf+FnDpg6fVmltGTc2NOFc8u5vcWkRlCtyrTgdFMAF5zZg2Dg
	==
X-Received: by 2002:a05:600c:83c5:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48e51f2a759mr33354555e9.9.1778052063251;
        Wed, 06 May 2026 00:21:03 -0700 (PDT)
X-Received: by 2002:a05:600c:83c5:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48e51f2a759mr33354245e9.9.1778052062811;
        Wed, 06 May 2026 00:21:02 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538bc9bdsm32305975e9.11.2026.05.06.00.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 00:21:01 -0700 (PDT)
Date: Wed, 6 May 2026 09:20:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Windsor <dwindsor@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: svsm: constify tpm_chip_ops
Message-ID: <afrqErDOpdl5-9CW@sgarzare-redhat>
References: <20260505202738.145800-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260505202738.145800-1-dwindsor@gmail.com>
X-Rspamd-Queue-Id: C9E864D72EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9460-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 04:27:38PM -0400, David Windsor wrote:
>Constify the SVSM vTPM ops. It is statically initialized and never
>written to, so let's store it in .rodata.
>
>Every other tpm_class_ops instance in drivers/char/tpm/ is already
>const.
>
>Signed-off-by: David Windsor <dwindsor@gmail.com>
>---
> drivers/char/tpm/tpm_svsm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>



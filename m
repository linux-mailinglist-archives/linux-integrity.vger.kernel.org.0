Return-Path: <linux-integrity+bounces-9798-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id plRIGGL1L2omKAUAu9opvQ
	(envelope-from <linux-integrity+bounces-9798-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 14:51:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E94686678
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 14:51:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9798-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9798-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92A003011780
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173DA3EFFC4;
	Mon, 15 Jun 2026 12:51:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7DE3EDE4B;
	Mon, 15 Jun 2026 12:50:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527861; cv=none; b=aO3ujHtXKPuh9eWaVpaCtnZncMb8B95OstK7c9WpQuia/vsVmvj2k4nkLaI/ztyz1XRfR5WPl53UaGy5e8Nr9yzD9VIRK7m6hInztzd8RCh9Wfvr+JQGzpFfUY/qcb2VyyN539JedbFIPYfLxX+FV9TKku2gEyS47xeT1IDxT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527861; c=relaxed/simple;
	bh=q1Nrz+2J9oiKFqCrI20qe5GgvhqerRO+w29kcZ5JIxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzlGxByStduNATlkuw2Df/WiTE3ItVGWRKPJBMVoCq8XQ9KLZcp6MO/YtNrKvcjMwpCNjJaVWbMgPlKzAlNEAK9wn/g2ttjArOPYhRK6rhNqX+UcGm+UIRdkH/BvAaUElocpI2V1p4c0+zZ3O4K0BiNP4Z3F/uzDaQp60h1Rw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wZ6mB-000000003SQ-47uH;
	Mon, 15 Jun 2026 12:50:52 +0000
Date: Mon, 15 Jun 2026 13:50:35 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Jun <chenjun102@huawei.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_tis: add settle delay after releasing locality
Message-ID: <ai_1G_RdwIRdXJTJ@pidgin.makrotopia.org>
References: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>
 <ai_tZ0VM9PDCRMfl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_tZ0VM9PDCRMfl@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9798-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:chenjun102@huawei.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,huawei.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,makrotopia.org:from_mime,makrotopia.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8E94686678

On Mon, Jun 15, 2026 at 03:17:43PM +0300, Jarkko Sakkinen wrote:
> On Mon, Jun 15, 2026 at 05:48:43AM +0100, Daniel Golle wrote:
> > tpm_tis_core_init() releases locality 0 then immediately reclaims it via
> > tpm_chip_start(); some TPMs (e.g. Nuvoton NPCT, TPM 2.0) need a few ms
> > before granting it again, so probe fails with -1. This back-to-back
> > release/request was added with the locality claim around TPM_INT_ENABLE.
> > 
> > Wait for the chip to settle after releasing the locality. A delay of
> > TPM_TIMEOUT (5 ms) in __tpm_tis_relinquish_locality() is reliable; values
> > below 3 ms are not.
> > 
> > Fixes: 0ef333f5ba7f ("tpm: add request_locality before write TPM_INT_ENABLE")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Can rebase to my for-next-tpm and resend v2?

I figured the fix is already in place in your tree, added by
34bc0fabf166 ("tpm: tpm_tis: Add settle time for some TPMs")

device_id 0x00FE, vendor_id 0x1050 exactly matches my TPM as well,
so please drop my patch.

Sorry for the noise...


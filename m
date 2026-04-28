Return-Path: <linux-integrity+bounces-9352-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FCiEFJR8GlNRgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9352-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 08:18:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370C47DFF1
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 08:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CDAE3006B69
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 06:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF734252B;
	Tue, 28 Apr 2026 06:18:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4572DECBF;
	Tue, 28 Apr 2026 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777357113; cv=none; b=K9RPOf7k5xMSioFCaRDMNsXyioIh/6rzMb71H4p/w5LJKWO+GqvJHQEjrv/yly2hpnRWQWAM4Goij8737Crq5Ep9TwBSGBLybP78qHLoB6i5TjjtU7QiRhBa4oSIRGeY6w5fT1x3HS/c9zX/ORio/RG74kXSP7O2aMObDEKVXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777357113; c=relaxed/simple;
	bh=xJU4vo65EGseIH0qqrDnikeHZGDDnlFm0j7v9BynM5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8SPbbalnI//uC0c2/cQlsuHDUJTIEKFsjeD85seLpCyWqE6Z06edmyVKYpyWsuhLzkP62Lp6pR/X+SM436Jo7MbyMcxzYGnRooETPVPXgUxDlu8pWYlIrKn9DyXvLK+kVQzRoyaD+cj7scc1N+qq78N+8k9Tp1FTn+K3dYVEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af76e.dynamic.kabel-deutschland.de [95.90.247.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 322FD4C4430D2F;
	Tue, 28 Apr 2026 08:18:10 +0200 (CEST)
Message-ID: <531b82e9-46c6-485d-95e1-018a3e9fc1b6@molgen.mpg.de>
Date: Tue, 28 Apr 2026 08:18:09 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, noodles@meta.com,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 jbouron@amazon.com
References: <e71c6d95-6c83-4fb4-8cd5-f66067fb68c5@molgen.mpg.de>
 <20260427225722.17878-1-gunnarku@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260427225722.17878-1-gunnarku@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9370C47DFF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,meta.com,vger.kernel.org,amazon.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9352-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[molgen.mpg.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Dear Gunnar,


Am 28.04.26 um 00:57 schrieb Gunnar Kudrjavets:
> On Sun, Apr 27, 2026 at 10:49 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>> gemini/gemini-3.1-pro-preview made a comment [1]. No idea, if it's valid.
> 
> Thanks for forwarding, Paul. AFAICS, the comment is a false positive.
> 
> My theory is that Gemini conflates two different variables named
> 'space':
> 
> 1. The 'space' parameter passed to tpm_dev_transmit(). This *can* be
>     NULL (it is NULL for /dev/tpm0 clients).
> 
> 2. The local 'space' variable inside tpm2_flush_space(). This is
>     assigned from &chip->work_space and can *never* be NULL.
> 
> The removed NULL check was testing case (2), not case (1).

Thank you for quickly looking into this. Sorry for the noise.


Kind regards,

Paul


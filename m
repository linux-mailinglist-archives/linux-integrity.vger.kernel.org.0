Return-Path: <linux-integrity+bounces-4340-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5499B9EC1A3
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 02:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C81169035
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 01:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81D6A33B;
	Wed, 11 Dec 2024 01:37:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CED3A8F7
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881023; cv=none; b=P8i3HVF5h4T4XwBeLTzOcL/wCtAftYgHBWcZF5Jvqps4sLiajwUnQq4HyUAbpszsuyI/IzxSAQVCReBQyvraXOMsY61lz5ssA4RCU3vskFr/akSqD9REjqSMq1guJQkXgSjkadg9YB/XwshLktGU0xmcKTrcdEAdWG4vi6+g48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881023; c=relaxed/simple;
	bh=KfKnH/83Fiaq+th2kwzmQ0v4Z37msoZkHl2IeCOZsTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG8hGhT2Y7GOQcloBG4az9JuozxycnAesQcltcxD1+urYQ+XMwq4F0w8CvoYAhKSfZxi6KirE62V2mwQx/mNLzrXXWZ/bANhbgMFV8pY9wSXeIi9MvWdgcZC5R3NVLdig/l7E6Mtkd57KHGHml/AZfaSCuvI0CngDNic7BWsUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 38D761F38C;
	Wed, 11 Dec 2024 01:36:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B62D13695;
	Wed, 11 Dec 2024 01:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /jhqAbvsWGcKUwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 01:36:59 +0000
Date: Wed, 11 Dec 2024 02:36:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: xiubli@redhat.com
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH v3] doc: correct the build steps for
 open_posix_testsuite
Message-ID: <20241211013657.GB383036@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241211011636.499499-1-xiubli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211011636.499499-1-xiubli@redhat.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 38D761F38C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Hi Xiubo Li,

> './configure --with-open-posix-testsuite' is needed just before
> generating the Makefiles.

Thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


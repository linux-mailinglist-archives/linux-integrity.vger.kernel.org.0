Return-Path: <linux-integrity+bounces-4676-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADCA23D8F
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 13:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139E33A3280
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE027195B33;
	Fri, 31 Jan 2025 12:09:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072416D9AF
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738325364; cv=none; b=MJojXcinvbdOheAAuFkCBWxId8N7hFFThYlPk1EcTkW0G/gkHY4iOUlIJORTU8O9dyICfGfROXcIQRBEy12QIz+Ut3S1+GYjGux0LlThhCj7lNQ307bDMDgTPyZ7gVDZODBuKK8/F61CJUDJkjL794IhG7UonsdzToBN/GsfPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738325364; c=relaxed/simple;
	bh=D7UOrx7bP+Qs38VKM0BVZgQUbJim76IQqg3EISc8CmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEjQ0hZbp8jg+ciBnbDZAaIc0JxdwHDJsw9SBvyCBGENboD/HI3GGB2nH2X4dsqKktS0DVcQiJF22dd+L55O7eo8z1ucnuU6eUJvS68EDx7KpfFs6kGu05IIvjE2jq3xMs9LxFjH7kBJBFI9FMD2PMX5ZAwvKMhsUkn6ZDWmpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 061A71F38F;
	Fri, 31 Jan 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B580133A6;
	Fri, 31 Jan 2025 12:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 46WMIHC9nGcmTgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 31 Jan 2025 12:09:20 +0000
Date: Fri, 31 Jan 2025 13:09:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [LTP] [PATCH v3 10/10] tst_test.sh: IMA: Allow to disable LSM
 warnings and use it for IMA
Message-ID: <20250131120903.GC1116925@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-11-pvorel@suse.cz>
 <Z5yXNjKBRwj2ed4s@rei.lan>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5yXNjKBRwj2ed4s@rei.lan>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 061A71F38F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

> Hi!
> Maybe a bit more description wouldn't hurt here. E.g. that we are
> printing a hint on a failure that selinux or apparmor may have caused
> the failure and we want a knob to disable it and use it for IMA.`

+1, this patch merged with the above explanation.

Thanks!

Kind regards,
Petr


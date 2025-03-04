Return-Path: <linux-integrity+bounces-5064-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C333A4DF60
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 14:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FBE18889FD
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E5204685;
	Tue,  4 Mar 2025 13:34:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF411FFC68
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095295; cv=none; b=jNUg44SKVk7wJI/QQE5pxxAdWNsM+py91CUbT3a/qX8r5HyqOeRhKLCotHiDJYSo+W3WFV1xQrOyC4iq7hPXaoPICf3CRtGVr2Ph2Ow9eQGLEoQAwIj+unarFyp5MSP/K8XRbFqBbN7UrnyQDIX2sKHO/9r4WfQ8es/6LERT8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095295; c=relaxed/simple;
	bh=KgxrzUZUl34ygjcjHyOi/iqfnBo8ioz3ocuwf9lR33s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRb0G39gAtFucRmvO2Dc50uzUL4MxiZDWbAETPo1I678RL8yoBTyJOL2TS2fzqKOL5wwTv6c8KmPrjFvI/sGem7mZL496x+I2l8VT2AsGT5t/z1qyZHwwYfiw8vy91pJDh8tSJVromTeVmDm6Py6gDnrtX4DciiRLANHBo4vOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6279A2119B;
	Tue,  4 Mar 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FA5013967;
	Tue,  4 Mar 2025 13:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f/djDnwBx2c4IAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 13:34:52 +0000
Date: Tue, 4 Mar 2025 14:34:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ima_violations.sh: force $LOG ToMToU violation
 earlier
Message-ID: <20250304133450.GD81126@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
 <20250304125749.GA81126@pevik>
 <30769565910b3198fa8d714b5edb25419fcb1457.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30769565910b3198fa8d714b5edb25419fcb1457.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6279A2119B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi Mimi,

...
> > > +	exec 3< $LOG || tst_brk TBROK "failed to read log file"
> > >  	tst_res TINFO "using log $LOG"

> > If you don't mind, I would reverse the order to get info about which log is
> > used:

> > 	tst_res TINFO "using log $LOG"
> > 	exec 3< $LOG || tst_brk TBROK "failed to read log file"

> Oh, I see what you mean.  All of the TINFO come first and then an error, if
> there is one.  That's fine.

Good. Merged this patch.

Kind regards,
Petr


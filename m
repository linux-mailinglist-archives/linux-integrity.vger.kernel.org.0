Return-Path: <linux-integrity+bounces-7080-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D0B57977
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 13:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F93204E3D
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5832302CB3;
	Mon, 15 Sep 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eF4E7UbO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFAR5b3n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eF4E7UbO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFAR5b3n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B8302CAC
	for <linux-integrity@vger.kernel.org>; Mon, 15 Sep 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937309; cv=none; b=e2dHD25aw/HXzMKcCzPWd+B2bkyYGgQawmZ+8imlD4M8nMR70cy9BJT4q0kKF1vbSzF53yKNQ07oQwjhq3LiuwDE/1cukGoKRicOeeXUD07cE2dyrQg5RuvnUYywdymsA+rebfykkNvMW8SG2fXLgh7cdPcsGYoXhkSekiycbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937309; c=relaxed/simple;
	bh=iQ5IhtZgLm+rkc5eoGm9hIH3ZDzmZomFvTPndZ9kpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLjkox9bmYd1tSfACI/LpMJqaHe5tfRqY/ClfIIdfmTeoEp2z4XXgHsquIZpsfrsu0lzHR+XvKGcXHqJ1KFHXMR6dC5qugJR/H8zeFKFGzNnVwcivzNBenEeWERd/BA9aGLiniehJifmAeTM3XophG9ngauU1XD7IL+iuu9S+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eF4E7UbO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFAR5b3n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eF4E7UbO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFAR5b3n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93E101F7B2;
	Mon, 15 Sep 2025 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=eF4E7UbODlg1fRz6r+3ixacnwcvxFRHmKrmxjgGvFEJJ83fWBB0lQQFEnABk8WlNfWZRhM
	bm3yNPNkU2dVXZDQV+yEVf7KnJCDCMZ9CDb0XmYoyuywZWLZ5NM7ghGHkXSaHmVC/1V4Ce
	Qbx+H20yT/dcaOSDfdkNVWXG1wvKjc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=yFAR5b3nyrKJtBvOY/GhTV3YOe1taVnHG+79mz05f3iFyeWtqWimTV2o9TiF4Cw7YdB2ND
	4hyswL1RwoEzpMDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=eF4E7UbODlg1fRz6r+3ixacnwcvxFRHmKrmxjgGvFEJJ83fWBB0lQQFEnABk8WlNfWZRhM
	bm3yNPNkU2dVXZDQV+yEVf7KnJCDCMZ9CDb0XmYoyuywZWLZ5NM7ghGHkXSaHmVC/1V4Ce
	Qbx+H20yT/dcaOSDfdkNVWXG1wvKjc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=yFAR5b3nyrKJtBvOY/GhTV3YOe1taVnHG+79mz05f3iFyeWtqWimTV2o9TiF4Cw7YdB2ND
	4hyswL1RwoEzpMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 798671368D;
	Mon, 15 Sep 2025 11:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tp2PHJr+x2iQLgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 15 Sep 2025 11:55:06 +0000
Date: Mon, 15 Sep 2025 13:55:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH 1/2] ima_policy.sh: Optimize check for policy writable
Message-ID: <aMf-w-2UtBe3VMZb@yuki.lan>
References: <20250912073210.47637-1-pvorel@suse.cz>
 <20250912073210.47637-2-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912073210.47637-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Hi!
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz


Return-Path: <linux-integrity+bounces-8095-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA69CC8B5A
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 17:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4223064579
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83338345CB1;
	Wed, 17 Dec 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CBejA6EP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dnT86+kt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ik+HqAIN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMm9TBAs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77E34E770
	for <linux-integrity@vger.kernel.org>; Wed, 17 Dec 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987447; cv=none; b=Tqq+wbnrpUgCRyibWf6dyvyPjoYGIuCCxt3jzOxWGjwtX0nkqJY8QpuFZQdYWn04OR3N4NOuoaARxeDb7jNPFw3mA1NML+ZsNMBW+gDpJLff+p0jgwGBTrpgzkkgayVbxOGPsWTlp+yMPZ8VmdYiHGCgcHwGDj9vv/drRnVVHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987447; c=relaxed/simple;
	bh=gXrXN/AZ0oWN3O+7Wfw6KcFLd1/3tx8UHvlMPibRGWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EADjovpxKXX5OQGbfn1XPHfm4SBpWTAr7v0vBSWgcx8uNKT/VzV98Wmu8KEOlX/W7tKkK1yECr1HPQX0Zel2ryGslWMImubphsj15/a8eXlvZnAXNg5uAYXKdL+oLbH7thfQh2z5l5oNRmEZnKesRb+f0Ezcw/VInZlPMHtWFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CBejA6EP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dnT86+kt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ik+HqAIN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMm9TBAs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC8D65BCF9;
	Wed, 17 Dec 2025 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765987444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vRk5a1ooMS2GCwtBMJRtjNK5XcxPO7/SnQWuyzMj4EY=;
	b=CBejA6EPCX5bdHbXK1hb4LqPo042NRxBNJik+03usXZ3DPMmjYsx8+gSJkAQXHIybnZoqy
	Dqhq+paEk28OlGFyo/ORpZ29wngD7Rj4zrVKU2p4+zRKwsX15FhkAeXbWJJi4bJsOcH7eV
	E/ROKXrowvdq1rlwEZNuftimhHGj6hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765987444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vRk5a1ooMS2GCwtBMJRtjNK5XcxPO7/SnQWuyzMj4EY=;
	b=dnT86+ktLe9aRtGRQjHD+P49s3RBiHxTe/lgRY6pEZFKbO1NhHroslksoYAaDp8MbMCGUp
	y9/dz3fYRGTWRlBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ik+HqAIN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MMm9TBAs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765987442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vRk5a1ooMS2GCwtBMJRtjNK5XcxPO7/SnQWuyzMj4EY=;
	b=ik+HqAINOzJdEF8krJBUdMuJD8Z3dKsUnpKX8XN/IBRB0DtoanoTQvn4rgQMJUwnC+LeX+
	u1tdMS7nLC5mcyurSwi0fecIzCFFuyLO7AUpYblak50UlKDjLi2Uwdre70Ue2GPrSuLyKW
	0FuTKFpFoz32GgS+vg2YtNfk3euCtlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765987442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vRk5a1ooMS2GCwtBMJRtjNK5XcxPO7/SnQWuyzMj4EY=;
	b=MMm9TBAsB6kfwkpGoVIoF5VLyS4byw2fgXpCzLVt4Wiz6yGJ1Y727aBKiwUBfwNOJSbUPe
	+p8SZ782WBNehBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFF783EA63;
	Wed, 17 Dec 2025 16:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m1OpMXLUQmkJZQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 17 Dec 2025 16:04:02 +0000
Date: Wed, 17 Dec 2025 17:05:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>, Li Wang <liwang@redhat.com>
Subject: Re: [PATCH v4 3/4] ima_{conditionals,measurements}.sh: Use tst_runas
Message-ID: <aULUsVxLIXFM19IV@yuki.lan>
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-4-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209185557.20598-4-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,yuki.lan:mid];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: EC8D65BCF9
X-Spam-Flag: NO
X-Spam-Score: -4.51

Hi!
> +	chown $TST_USR_UID $dir

And we need it here.

-- 
Cyril Hrubis
chrubis@suse.cz


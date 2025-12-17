Return-Path: <linux-integrity+bounces-8088-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 576ADCC86C2
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 16:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E145C30B329B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1057396543;
	Wed, 17 Dec 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Un/wvc+K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/kwTZb3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Un/wvc+K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/kwTZb3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70544393DF8
	for <linux-integrity@vger.kernel.org>; Wed, 17 Dec 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980482; cv=none; b=sj2tMLMK1ge/fj+1zF0/Psb8KhqxBFwC2Xh2N3Mq55it1Nt48OAxwc6t1Zf8YV5mz8UhuBdqP83FoMcuqR7WBmiMQADtvrbq6Kjh8cznGgDNwAcdFjsr1BinahAgRxW4v/GJPSAfUGg/STUk42hnXEbIM61/9z9y1awxvA/Hz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980482; c=relaxed/simple;
	bh=T77Qetwup3EsOnLLSa2giebdMOevf8gtwN5HAxvyseA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlCUTJ9KXu5Y+zRRuYZ53oOIqpZmrA8pQh5Aii+Mv4bqNb/AzwxRX9pCkl1E7b9ifr9OF6qOGSrsvzsjCaZ1V/pHkAIfd/1ftA67ioIrQHMzU4DZ0xCDiYtNWxnrA+Cl3sAzHZWOm5b8DyfhRe+X0dSS74RdcdPdCJYSPVpw1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Un/wvc+K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/kwTZb3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Un/wvc+K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/kwTZb3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B62D3336D7;
	Wed, 17 Dec 2025 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765980479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T77Qetwup3EsOnLLSa2giebdMOevf8gtwN5HAxvyseA=;
	b=Un/wvc+KjpHTRq61ZNpYL7qSSqbiyLUS4ezgGbMsXsGAnFLuhGiBkbSNBeRp5uMK70YMcx
	gDQTYADiCHs1asDRQWcqF1KXe/PEU3oJ3QloVH4KLfnGoTLdB2rESn9q/K1X+wAHRHjf7z
	9vZoQWJp6oLaJNKF3DP5S32Qd1qwtIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765980479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T77Qetwup3EsOnLLSa2giebdMOevf8gtwN5HAxvyseA=;
	b=U/kwTZb3gMilZVn1ptDePdxnMfG6yK1En9NypECtNPAm9irmBv0yP3nMwdSLQEjYTEisdS
	pknsN030z0LZxoBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765980479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T77Qetwup3EsOnLLSa2giebdMOevf8gtwN5HAxvyseA=;
	b=Un/wvc+KjpHTRq61ZNpYL7qSSqbiyLUS4ezgGbMsXsGAnFLuhGiBkbSNBeRp5uMK70YMcx
	gDQTYADiCHs1asDRQWcqF1KXe/PEU3oJ3QloVH4KLfnGoTLdB2rESn9q/K1X+wAHRHjf7z
	9vZoQWJp6oLaJNKF3DP5S32Qd1qwtIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765980479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T77Qetwup3EsOnLLSa2giebdMOevf8gtwN5HAxvyseA=;
	b=U/kwTZb3gMilZVn1ptDePdxnMfG6yK1En9NypECtNPAm9irmBv0yP3nMwdSLQEjYTEisdS
	pknsN030z0LZxoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B1BC3EA63;
	Wed, 17 Dec 2025 14:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eADTHD+5QmmIeAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Dec 2025 14:07:59 +0000
Date: Wed, 17 Dec 2025 15:07:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: [PATCH] ima_selinux: Fix requirements
Message-ID: <20251217140758.GA64023@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251208141321.696537-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208141321.696537-1-pvorel@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -3.48
X-Spam-Level: 
X-Spamd-Result: default: False [-3.48 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.18)[-0.908];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]

Hi all,

FYI merged.

Kind regards,
Petr


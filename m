Return-Path: <linux-integrity+bounces-5138-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7690EA554E6
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 19:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14B03A36B1
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4A41A01B9;
	Thu,  6 Mar 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gl4PuwQ1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S41VOdnG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gl4PuwQ1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S41VOdnG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F713D509
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285425; cv=none; b=RDwOcxgLAvUW4SjHCwSIwSOsLOpbANxMjQA9hAZhXsRZxfg7JKlVrK0Uur0MAwkXd8SKwCls05aOttq5IRl/kYVH67OzMybuZWo+jEz0o5Gk/pCGOkoxLHvTCuFKVbnw7Rq4okXL2HuGiLK2ZDLYVI3SON8H3DImKpmCRT9hjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285425; c=relaxed/simple;
	bh=8a4nKsbme2XkLPnoKQBlnSF4zXWYRsZYVE7Ad3McgSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abfwLFRBaGwyhECEpcBXwNWyNvWNNN3B3rGpnXPeSapGg++8qLpqTP6bxakwLK+ma62A+Ml2OiYVyl7L+a63hYlaoWlcKlzAAYE+vTTmKu2ruloneqm1YzNjZeyT3CgDz24z6PM0hAMM//YBImH9HyobP+J9wOkvTy7c/4aqpSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gl4PuwQ1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S41VOdnG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gl4PuwQ1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S41VOdnG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47D41211AD;
	Thu,  6 Mar 2025 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741285420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a4nKsbme2XkLPnoKQBlnSF4zXWYRsZYVE7Ad3McgSc=;
	b=Gl4PuwQ1fFzp9eAir9itgzsibYGPf23rnmPpGOhww6UOkAUehHHpCbacNFEHvX52J6/UqB
	jDzQEWWDSp9ZkUczCkQiIbaQ9kL7AJy3XcxnVN2+cGQBwKCYEwbtw6fEexJPa8+L7xpVAa
	lp2+9fpxAonQjninng3DDghqlgTU8AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741285420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a4nKsbme2XkLPnoKQBlnSF4zXWYRsZYVE7Ad3McgSc=;
	b=S41VOdnGhph3pTylwRrb3+NT8V5PglvlFR6Lqdr4cZVIaCwP/qepWRV/nq5OE3rjjyomT4
	ZJGCIRSO5xQqj5AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741285420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a4nKsbme2XkLPnoKQBlnSF4zXWYRsZYVE7Ad3McgSc=;
	b=Gl4PuwQ1fFzp9eAir9itgzsibYGPf23rnmPpGOhww6UOkAUehHHpCbacNFEHvX52J6/UqB
	jDzQEWWDSp9ZkUczCkQiIbaQ9kL7AJy3XcxnVN2+cGQBwKCYEwbtw6fEexJPa8+L7xpVAa
	lp2+9fpxAonQjninng3DDghqlgTU8AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741285420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a4nKsbme2XkLPnoKQBlnSF4zXWYRsZYVE7Ad3McgSc=;
	b=S41VOdnGhph3pTylwRrb3+NT8V5PglvlFR6Lqdr4cZVIaCwP/qepWRV/nq5OE3rjjyomT4
	ZJGCIRSO5xQqj5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D44EC13676;
	Thu,  6 Mar 2025 18:23:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w6ZKMivoyWdzTAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 06 Mar 2025 18:23:39 +0000
Date: Thu, 6 Mar 2025 19:23:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ima_setup.sh: Check 'cat' exit code when loading
 policy
Message-ID: <20250306182330.GA218242@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250219181926.2620960-1-pvorel@suse.cz>
 <20250219181926.2620960-2-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219181926.2620960-2-pvorel@suse.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi Mimi, all,

> Parsing stderr should be enough, but check also 'cat' exit code
> in case of error message change or other problem.

FYI patchset merged.

Kind regards,
Petr


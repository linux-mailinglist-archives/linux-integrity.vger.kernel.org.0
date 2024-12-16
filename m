Return-Path: <linux-integrity+bounces-4397-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C39F30C7
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2024 13:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5EE18843C5
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2024 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72082010E5;
	Mon, 16 Dec 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BdseUrO/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6Ob5DMF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BdseUrO/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6Ob5DMF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAE20458A
	for <linux-integrity@vger.kernel.org>; Mon, 16 Dec 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353122; cv=none; b=lTm0gepDL+NcQLZcDbAZLPaY0QKdj/wCTaXWhH7LBySWUE6LMq51KYbIONdSGju6anlTh/03oSI5Gn0eBf0MnYNcYcZq1YKXoquwP7HgMNmStLzLjvebtt8g79MqQU29lXpB3VDEVjncTiCWYRIm0Qy280TtvV3xfTx36pGRq78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353122; c=relaxed/simple;
	bh=iQ5IhtZgLm+rkc5eoGm9hIH3ZDzmZomFvTPndZ9kpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhx6+0DTCsnc+3JQDbmJK41VPb2DEL8ntz9ROYHW9Nax1ygvs8/w2LH4wY8DrJBNjTu9b9tco81hTPE3EO5cbE1yanlRl328kbyL+L9g+/wDiCI4hItffJRigJml7l4UwUzJRw4XdOlbTdbGpVpwOZVuUeDmAhH6nJ5o5DqAR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BdseUrO/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6Ob5DMF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BdseUrO/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6Ob5DMF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E50F1F385;
	Mon, 16 Dec 2024 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734353119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=BdseUrO/YHFz/Q/AKQ3ZY/QupeZZesHfuTqgf2CceTdMZ7rNnEZUCUl4D5K96l+iseg3Bw
	xz1jK7kJky0SCuGYFn686lTokK3CcbmL78c4yh5inVDaOgrmn20JJRaaPljfShRGkvrQpx
	qBVnpYO1XvHQXOv3YtWsVCk8VY5fXwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734353119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=D6Ob5DMFyDXiEp19aTy2ydqPIjtN0fvqMwMGM8XVf4te97x/Nl9BXMZa1oHqIhcy1JOil9
	LTS4+IhiKBsc6jBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734353119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=BdseUrO/YHFz/Q/AKQ3ZY/QupeZZesHfuTqgf2CceTdMZ7rNnEZUCUl4D5K96l+iseg3Bw
	xz1jK7kJky0SCuGYFn686lTokK3CcbmL78c4yh5inVDaOgrmn20JJRaaPljfShRGkvrQpx
	qBVnpYO1XvHQXOv3YtWsVCk8VY5fXwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734353119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=D6Ob5DMFyDXiEp19aTy2ydqPIjtN0fvqMwMGM8XVf4te97x/Nl9BXMZa1oHqIhcy1JOil9
	LTS4+IhiKBsc6jBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E854D137CF;
	Mon, 16 Dec 2024 12:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 81PfNt4gYGcuTwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 16 Dec 2024 12:45:18 +0000
Date: Mon, 16 Dec 2024 13:45:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: xiubli@redhat.com
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] doc: correct the build steps for open_posix_testsuite
Message-ID: <Z2Ag3uMEMaYPbkSr@yuki.lan>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi!
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz


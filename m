Return-Path: <linux-integrity+bounces-4959-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4385A3EE84
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 09:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5AA19C3301
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288401FC0FB;
	Fri, 21 Feb 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2qYaGo04";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2vpVT9vA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2qYaGo04";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2vpVT9vA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A81FBCBA
	for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2025 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125925; cv=none; b=jH5SerYMyV3uCRJYTyuznoVCcwBYfbCKXvoyh2uzQ7RpYopTBtl1iWelKyrtj2GYuK/xLQk8FsaHvVgdLsX1R9SNUHw+GYVcIgBWIPpm3iaFiESZAb1XoogGpKbwIeBnff+LSnB1tLEMiC+51Xacs4U+OQVvkeVDrG/OlSJxQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125925; c=relaxed/simple;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1U2XzbvSIzrQSrXpf4C6Qxkbydsqpyd8NFCWapWuCJYLR8+SXxNrppN5Esj7xamqwuOvo8RIfAHzFRnvR7ULLG1e9yvWHiQe1A1n/VxnzRuPAFsDqB/LhP/Lru7dAQlqFxPrXiWA3ciUf+vqPhnreWxQgmXbG9ZxsFvPrcgThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2qYaGo04; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2vpVT9vA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2qYaGo04; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2vpVT9vA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5E241F385;
	Fri, 21 Feb 2025 08:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740125921;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	b=2qYaGo04PcpuAMCv1/8Z2wTxkstHd1OEpLHQ4S+AqLhobz3AdwO0Ik1z+Wm7w+UyIGhn9r
	sgklFJTkv7Flfr9UPn98CC0jn37HW3bw0861Vh6iWckLjPLKVrsQOZK3SHLmFOInTQYY05
	MVeY46n4p9T/26S2YUYUM008N7l+QF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740125921;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	b=2vpVT9vAmVw5anxmN6dJZTjZPEuspYE0B0VfJWu8sD+YuYEVU8h7IR3tkN7jPuKLsNwaJD
	O2PQjqJ5OrY9nMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740125921;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	b=2qYaGo04PcpuAMCv1/8Z2wTxkstHd1OEpLHQ4S+AqLhobz3AdwO0Ik1z+Wm7w+UyIGhn9r
	sgklFJTkv7Flfr9UPn98CC0jn37HW3bw0861Vh6iWckLjPLKVrsQOZK3SHLmFOInTQYY05
	MVeY46n4p9T/26S2YUYUM008N7l+QF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740125921;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	b=2vpVT9vAmVw5anxmN6dJZTjZPEuspYE0B0VfJWu8sD+YuYEVU8h7IR3tkN7jPuKLsNwaJD
	O2PQjqJ5OrY9nMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AE1113888;
	Fri, 21 Feb 2025 08:18:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id viujJOE2uGdsDgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 08:18:41 +0000
Date: Fri, 21 Feb 2025 09:18:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima: limit the number of ToMToU integrity violations
Message-ID: <20250221081839.GC2739743@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
 <20250219162131.416719-3-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219162131.416719-3-zohar@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


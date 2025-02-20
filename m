Return-Path: <linux-integrity+bounces-4938-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499DBA3E3D0
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613F97027EC
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310EE2147E3;
	Thu, 20 Feb 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/8sn4GQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdDtof2B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/8sn4GQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdDtof2B"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872892144D7
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075994; cv=none; b=Ql3TDojFwyqOC7XJyhxwVsstB3n+iIi/l6AS0Z5SQR1JToAOj6qNlRRbbWNMwFtS4HxN/XugeuwFp8w870kMd/C7pao+qQE01AR+LbMOCLpIsOWBswEjdGvcbVkW4Y+UorWtlU4AAvslZ+BDlqa/udB9cWJ4mQYHTFKtYkr9sa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075994; c=relaxed/simple;
	bh=KXhPhhRiKS4A4pU+/dhLSAQZ5e8MGTXw9kp82Iw3YP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIY34hBHRfZT+4OXnWF4Ghlh2QGj+Y2KoQ60+mIDODB9tiBNozs0lRQ12O+szWhK0+qQhaTcKCVLIzLl8ewkkLP0XlvvxMKE1ik3krEluv3fSITSCJ9F94CtLkH6TbyNVsJYYlGJ3dgOKcYACtIbUabidkEAwBQNSW8K6ryl640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/8sn4GQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdDtof2B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/8sn4GQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdDtof2B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A3F821181;
	Thu, 20 Feb 2025 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740075989;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRB1FPUOeOYxOaG73hRqDHn7khAQC6qJk7n8OXKK6KU=;
	b=V/8sn4GQDqNBfFNaCyo/iJmeUZ9vKR7ZkxKlnsr9yQDcONPFS4n0qngneOzGRe4gMhXVQ+
	FfeWnO5VbFwGbUFN9TwyIQraYELPoTalqpUM9nLinNTG1qkOrIukvOBnyaH1SfQDYZyqtY
	+vpcr1XcaarJ6T2j9fCFce4jQvsO1TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740075989;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRB1FPUOeOYxOaG73hRqDHn7khAQC6qJk7n8OXKK6KU=;
	b=vdDtof2BQRWVyt0RUtjTGMBf8ieujxZ5KAbDcEWucF8jz5JF9UdfpNHJ02HSSErPbHVz7g
	NGC52tpQjGDNxxCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740075989;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRB1FPUOeOYxOaG73hRqDHn7khAQC6qJk7n8OXKK6KU=;
	b=V/8sn4GQDqNBfFNaCyo/iJmeUZ9vKR7ZkxKlnsr9yQDcONPFS4n0qngneOzGRe4gMhXVQ+
	FfeWnO5VbFwGbUFN9TwyIQraYELPoTalqpUM9nLinNTG1qkOrIukvOBnyaH1SfQDYZyqtY
	+vpcr1XcaarJ6T2j9fCFce4jQvsO1TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740075989;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRB1FPUOeOYxOaG73hRqDHn7khAQC6qJk7n8OXKK6KU=;
	b=vdDtof2BQRWVyt0RUtjTGMBf8ieujxZ5KAbDcEWucF8jz5JF9UdfpNHJ02HSSErPbHVz7g
	NGC52tpQjGDNxxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6968513A42;
	Thu, 20 Feb 2025 18:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yu+8GNVzt2c6KQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 18:26:29 +0000
Date: Thu, 20 Feb 2025 19:26:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 1/2] ima: limit the number of open-writers integrity
 violations
Message-ID: <20250220182628.GB2709977@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
 <20250219162131.416719-2-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219162131.416719-2-zohar@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

> Each time a file in policy, that is already opened for write, is opened
> for read an open-writers integrity violation audit message is emitted
> and a violation record is added to the IMA measurement list, even if an
> open-writers violation has already been recorded.

> Limit the number of open-writers integrity violations for an existing
> file open for write to one.  After the existing file open for write
> closes (__fput), subsequent open-writers integrity violations may occur.

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I also did a regression testing on LTP IMA tests on x86_64, aarch64, ppc64le.
(not testing the feature itself, just really a very basic regression testing,
therefore I do not dare to add my TBT).

Kind regards,
Petr


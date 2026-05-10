Return-Path: <linux-integrity+bounces-9514-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id enTjNaHi/2me/wAAu9opvQ
	(envelope-from <linux-integrity+bounces-9514-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 03:42:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 304EA502257
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 03:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D5630277E3
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 01:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADB221D96;
	Sun, 10 May 2026 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqeIMfwp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179B1DF248;
	Sun, 10 May 2026 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778377373; cv=none; b=DBJdHb2FEiTr/4aZcywq+wpSzCzNainkzPJUK/63rdfFT7zfhnAp70DOcVaRsRLU5wn9LyrULkoAuAu9siQMOvYab9vtU2fUdsSR6rTDmvBE0FTQTcmSYSbxuwQkglLWGMwRUbXyTk36+hMG06UsFPrEz8tJ+EzHSSiUxXImUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778377373; c=relaxed/simple;
	bh=DU5v/vXKr+84UuY5LnqHDDe6y4ebm53ChAYJDhItcJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b62SYGKZutk7nzK4WRocPGZiphBFkoWbqpffSfwV6Po/0vFxjCOFVoTYqQ52nkc70sJaehGfoAxi5rnGxdh08Gi2JV56Wm9hps/lcvIHAG+mqSiZByaWvc7aXDrk/8nF3E5S2Qd2Xpx8OTpSOkkkygAamJ2hUCtSuvAvrEIPLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqeIMfwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C27FC2BCB2;
	Sun, 10 May 2026 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778377372;
	bh=DU5v/vXKr+84UuY5LnqHDDe6y4ebm53ChAYJDhItcJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqeIMfwpa1uTQu4wzGLb030TRXnsW0NPIyN8zddagCznwnXsEZoPH2mttpzMqOH+y
	 0pzbA5jfSq7w04bPYsD/KLusI3Yerz3KKNIzFNxI1XffvEYRo2CDrya/naHMcqdcL7
	 z1tj6AytbwrzXwX8/ykfyf32/Vmvms8hgw3bRNRje6O+JkiInn9Z4u4c3yAh9dXnT3
	 VF7G3GI5gUfwkJhPTEXssSBhCUQKb881MlTjhb6WFvO8Z4XbcZlYnPz2lF9OykbsPW
	 VSrVqcCL+fjcpXWst5oMpNf44Kl2r5Kct0e3BwlTRIsBCRoF/VV5+G1UuB+3s2szrt
	 1OmgtXlKEbV6w==
Date: Sun, 10 May 2026 04:42:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: jbouron@amazon.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhijaz@amazon.com, noodles@meta.com,
	peterhuewe@gmx.de
Subject: Re: [PATCH v2] tpm: Fix uninitialized name_size_alg in
 tpm_buf_append_name()
Message-ID: <af_imAiZEQ7WEe5W@kernel.org>
References: <af-MeEbJFmab4YQ8@kernel.org>
 <20260509223500.4390-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509223500.4390-1-gunnarku@amazon.com>
X-Rspamd-Queue-Id: 304EA502257
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,ziepe.ca,vger.kernel.org,meta.com,gmx.de];
	TAGGED_FROM(0.00)[bounces-9514-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 10:34:29PM +0000, Gunnar Kudrjavets wrote:
> On Fri, May 09, 2026 at 07:35 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > This is great observation but it is not a regression technically.
> >
> > Thus, this really should just state the issue and don't make it look
> > like a bug report based on transcript that does not happen in the wild.
> 
> Thank you for the feedback, Jarkko. That's a fair point. Since no
> in-tree caller exercises this path today, framing it as a regression
> is misleading. I'm happy to rework the commit description to present
> it as a proactive hardening fix rather than a bug report, and drop the
> Fixes tag accordingly.
> 
> > I guess this is better than parameter removal since name caching would
> > make sense [1] in future.
> 
> Agreed. Keeeping the name parameter functional makes the API ready
> for name caching without further changes.
> 
> Would you prefer I resend with the adjusted description, or would you
> like to suggest specific wording? Happy to go either way.

Yeah so the point here is probably to prevent unmasking a bug in future,
with the specific example of name caching. I.e., I see the change itself
useful and important despite not being a bug fix per se.

> 
> Gunnar

BR, Jarkko


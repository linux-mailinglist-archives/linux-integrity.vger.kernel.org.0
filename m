Return-Path: <linux-integrity+bounces-9499-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL26EvMn/2nK2wAAu9opvQ
	(envelope-from <linux-integrity+bounces-9499-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 14:26:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB814FF97F
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 14:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23589300EABF
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 12:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C50434DCC7;
	Sat,  9 May 2026 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmr2wlwM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3D2F8EBB;
	Sat,  9 May 2026 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778329584; cv=none; b=ocLSTlQUHvUrZhfQ71BSkdq5Xv70mRPJv11fKzmVVPhx2aTIKuii0hrRxD1iISb/1okT92LRzqDnt2WAdxn1m/HO9tS+53PtUsxuoX7rnN6bIdJh8kwSn1wgeDGpSpGSwnbLvFHmdOGs8ga150SNbLJxoGg21H3YLwiOMP01Fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778329584; c=relaxed/simple;
	bh=Z591XzMfK8SCdEVzkSBMXXPSGkZV+KOADjj+ZPKhBsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLd4lvpzz4JCjg5fNMywzMar03tE1UWX1i9XRo36cWWtWYQwOtY9yPZQF8WTBWg5Y7uWLbq47CUR8klbmsnYX2O406ztZuH2R2WzH1EfKmTEyFqjoaWFBONszqBZGQNnqPKBMHGmFh6ka7uJki9TpJrRpnntEgOqXhObyF2zITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmr2wlwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65343C2BCB2;
	Sat,  9 May 2026 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778329583;
	bh=Z591XzMfK8SCdEVzkSBMXXPSGkZV+KOADjj+ZPKhBsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pmr2wlwMbvbRcfBMZxle8C+JHltvVnI9tozf5JP0Xn7z/Max8l1gE72rT30zoq/vJ
	 PfE3e9V2R4AefTtvFgnaTROslGq6D8sA/yMsrT6hVGls9G8F9RjUWe3+X+0jozGhKH
	 gaUva807z5V5aXlx7Mh44fkvOmSkekIDjXF/XYeb/xOTD/eLTDOYlTZY8I523WNGr2
	 El6DnwCAyk7YwEttFrNB1IXS/kxBuVlKKHm+Eep5ekSUkSsRLKEHJU90eD5RQEylz/
	 6qSTdthRo0U2kzVeW7wpV/+ety42BBHI84qXOgpV8PpoX8cXxEuhPLO6g3MP8yFz2J
	 8O9Kc2p5Ec7Qw==
Date: Sat, 9 May 2026 15:26:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Gunnar Kudrjavets <gunnarku@amazon.com>, peterhuewe@gmx.de,
	jgg@ziepe.ca, noodles@meta.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, jbouron@amazon.com
Subject: Re: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
Message-ID: <af8n6_Etq41N1gaS@kernel.org>
References: <e71c6d95-6c83-4fb4-8cd5-f66067fb68c5@molgen.mpg.de>
 <20260427225722.17878-1-gunnarku@amazon.com>
 <531b82e9-46c6-485d-95e1-018a3e9fc1b6@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531b82e9-46c6-485d-95e1-018a3e9fc1b6@molgen.mpg.de>
X-Rspamd-Queue-Id: 9DB814FF97F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmx.de,ziepe.ca,meta.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9499-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Tue, Apr 28, 2026 at 08:18:09AM +0200, Paul Menzel wrote:
> Dear Gunnar,
> 
> 
> Am 28.04.26 um 00:57 schrieb Gunnar Kudrjavets:
> > On Sun, Apr 27, 2026 at 10:49 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > > gemini/gemini-3.1-pro-preview made a comment [1]. No idea, if it's valid.
> > 
> > Thanks for forwarding, Paul. AFAICS, the comment is a false positive.
> > 
> > My theory is that Gemini conflates two different variables named
> > 'space':
> > 
> > 1. The 'space' parameter passed to tpm_dev_transmit(). This *can* be
> >     NULL (it is NULL for /dev/tpm0 clients).
> > 
> > 2. The local 'space' variable inside tpm2_flush_space(). This is
> >     assigned from &chip->work_space and can *never* be NULL.
> > 
> > The removed NULL check was testing case (2), not case (1).
> 
> Thank you for quickly looking into this. Sorry for the noise.

I felt sleep while reading the text generated by Gemini but yes exactly
because it can't be NULL the check is there.

I.e. Opus is right but the action taken is still plain wrong.

> Kind regards,
> 
> Paul

BR, Jarkko


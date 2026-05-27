Return-Path: <linux-integrity+bounces-9688-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNHUH9S0FmokogcAu9opvQ
	(envelope-from <linux-integrity+bounces-9688-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 11:09:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A225E18E8
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D0A730117AD
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CEF3E5A36;
	Wed, 27 May 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izQF6lcV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBE3E6DC1;
	Wed, 27 May 2026 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872956; cv=none; b=Litb8gTQe2icWO/lslB6Sgf0cqT5V7ACX0ob4Hkav368Yj4DhczuNPIWY7hDVCs2nStmGC34JysaC6YfBv1sF+3yPLqKRSG3wLXZG0UbcAptIyvd+pBzVkRLJAlt+lgJgkv4f7xSmoUMizPaLqZpIgwfe2olbDCDHV92gjP39fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872956; c=relaxed/simple;
	bh=IrkYTetbvHCjYmyz5CgrghKor0NwdEQ8iDTGzXP7ziE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/eWXOuQ7wyur05zgcYh1skOsOG1h0fj0pVkyMT8f5KXsAWYw5MKJrnMH15p31Af1q+Vd5NheTbXahiwzgvLjKBzrQhGdV2KhSby4qi/taQyw851D7icGfnb/6Ndlvi92+GEsEQt1SWuf4SHRPYwMyIF2m/Y2aiUxqQJDpRMPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izQF6lcV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AB61F000E9;
	Wed, 27 May 2026 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779872954;
	bh=7ksdgjc40jlzTwXE0aql93RpRNJfc1+mdFdSmhlsHOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=izQF6lcVc37gS7ka19Joj79opGsd6eRPOfrXC41G8d1jrB5I0QZI/W7HHz+vuz9Dm
	 hMsanxgxbP5JVlp+B7sqV08MPhPXNeHZWWqGFjJ71GMvc2wqthWhz7aOKWXHk+7Vdi
	 yrh+2H9v4pNQu7NfNEI5ECSFWxpxVWp9P7hiIsll+MjzB3svk+tOdTxf1kWKc/HNqZ
	 6VaQSQOzWduCt9T01SJCPJpqFaBWlGUH+cHeoYPU8+kh85Pcq/UFPEP0X2O3q77R+k
	 dUwL9oG83iV7KOnPRNIyqosG4nIOTX7SNt5V3n2m9P7Cwj9PTV6YCY+jpyex7sLuE0
	 OUG3pxnxgsE5A==
Date: Wed, 27 May 2026 10:09:11 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] firmware: arm_ffa: Treat missing FF-A feature on a
 platform as a probe miss
Message-ID: <20260527-sparkling-sloppy-muskrat-c1e4ac@sudeepholla>
References: <20260526103649.5684-1-sudeep.holla@kernel.org>
 <20260526193543.GB2851089@ax162>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526193543.GB2851089@ax162>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9688-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 30A225E18E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 12:35:43PM -0700, Nathan Chancellor wrote:
> On Tue, May 26, 2026 at 11:36:49AM +0100, Sudeep Holla wrote:
> > When FF-A initialisation is driven from a platform device probe, systems
> > that do not implement FF-A can return -EOPNOTSUPP from the early transport
> > or version discovery paths. Driver core treats that as a matched probe
> > failure and prints:
> > 
> >   |  arm-ffa arm-ffa: probe with driver arm-ffa failed with error -95
> > 
> > That is noisy for a firmware interface that can be absent on otherwise
> > valid systems. Driver core already treats -ENODEV and -ENXIO as quiet
> > rejected matches, so translate only the early unsupported discovery cases
> > to -ENODEV. Keep later setup failures unchanged so real FF-A
> > initialisation problems are still reported as probe failures.
> > 
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://lore.kernel.org/all/20260523001148.GA1319283@ax162
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> 
> Appears to work for me.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>

Thanks for reporting and testing. Much appreciated!

-- 
Regards,
Sudeep


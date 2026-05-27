Return-Path: <linux-integrity+bounces-9689-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PT+GIm3Fmo6pwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9689-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 11:21:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD725E1B4E
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 11:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7CEB307A059
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681F3E8699;
	Wed, 27 May 2026 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIeSzj7m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019FE3E5A3F;
	Wed, 27 May 2026 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873401; cv=none; b=i1MfLtOxmBIG/V4mb/HCSoxB44gIPraMd/nm3xLbbCTBQ2YJ5FWlTnID54IzX4HQ9RkHOPZHg3yNZf/Ra8Xtd8aWaTZTMsRVIrsWUqiy5OZJgta9Ee+m6L3Jk0YRSdXO8aiW7oHOrw+AZg1JRD/P/PXeRJiCWObma8sHOcXdGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873401; c=relaxed/simple;
	bh=dXoqSImamGVugsmey6+ybTPHCmxua+8SgDRak6djpzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyqFsxD/IFMeiS+FKx8NtZGvDwiYuKpKge5I/eDySrOtoMVUy4TAAfZy+aW3aNl5HX3XpW7CdYtiVsLlzBp7hiJB7od5O7a1qLevoFEkDPmok6Iv/EJX+3DmG0nuokpLydkGJMH5RBcJ4fqZzlX8Me8xghvfgarRwZH9dd98j/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIeSzj7m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971881F000E9;
	Wed, 27 May 2026 09:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779873397;
	bh=FW1o8Mstfz7HtwERoCbtrhXZitn0SCyLL8f980TymDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DIeSzj7mkAHQZrvnz4x3l4UQ5fpwG5PV0VOHWqVw/CeQs2ZgxTRqTrOB6lULCpp5F
	 BRM51npMY17KAJ+qaf99ur/O9rebdSLSnTDO3B4xUP1y0qRWjENP5dEvoTgPYUsHxE
	 eO/a9frK1eq7YSfrAyvYD4T9eKK2tglmeH2XyZnowVx/Edt/s3oNP/d2MN8jwxV6MY
	 Uqbp3c7cW7epfXTiXrgaMrBPLjsYentJwdsYfwKzKOACdFaNR+gd0nH3DHp4pRtohp
	 HRNyPNH+IWB3uTUjNhV83+IfJmSalz+BMVi9hMVjsUn4IsCehrTYChnqOR9b7hkbDB
	 TZFELXj9tdh5w==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] firmware: arm_ffa: Treat missing FF-A feature on a platform as a probe miss
Date: Wed, 27 May 2026 10:16:24 +0100
Message-ID: <177987332790.276916.3167298896223560976.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526103649.5684-1-sudeep.holla@kernel.org>
References: <20260526103649.5684-1-sudeep.holla@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9689-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CFD725E1B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 11:36:49 +0100, Sudeep Holla wrote:
> When FF-A initialisation is driven from a platform device probe, systems
> that do not implement FF-A can return -EOPNOTSUPP from the early transport
> or version discovery paths. Driver core treats that as a matched probe
> failure and prints:
> 
>   |  arm-ffa arm-ffa: probe with driver arm-ffa failed with error -95
> 
> [...]

Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/1] firmware: arm_ffa: Treat missing FF-A feature on a platform as a probe miss
      https://git.kernel.org/sudeep.holla/c/18706ea68fc4

--
Regards,
Sudeep



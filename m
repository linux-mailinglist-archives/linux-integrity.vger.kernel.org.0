Return-Path: <linux-integrity+bounces-4591-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D3A163C2
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jan 2025 20:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B71163702
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jan 2025 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF017B421;
	Sun, 19 Jan 2025 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fte+Q/JK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A37179BC;
	Sun, 19 Jan 2025 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737316633; cv=none; b=AInfWERPtmph3+DfNs7/idOeII710wwq6y+pFs6d5q95Dg0ljnbmPK0aK7HHwppsOL8bgYNuPN9zUNMwa3Ksa4qdpXft7HmUmuU/41CO+3aGqFa/Ru9xGQPiSKFDVapcOWWv5R01aNlmp4Yp4SIUJutq5vID8MfBkuZJFzVN8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737316633; c=relaxed/simple;
	bh=n3uV3i3rzKwYzykUioq/0JhsbHV7ZXcmbtlcumjBX1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KANUstzo78iypZQpmvySrVBLcZvdgZ12WBHPNjMc84Gfi6kEuqY5pfmxUrUp4nfRyChUnjYA2NB/oBD6MhTdR144TPftPgF/HLZaeG1ChQw/KXi4ZKMDXWTvcvDSoB+TGPAnUctOj3eikrVboDXv4JRbnwZSCzetA/b97cIabc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fte+Q/JK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955EAC4CED6;
	Sun, 19 Jan 2025 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737316632;
	bh=n3uV3i3rzKwYzykUioq/0JhsbHV7ZXcmbtlcumjBX1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fte+Q/JKijhDkWkOBhWwDax9qfAUqm6EGbsYC2UAySiI5aUbGJHefe8fRIR5Wn9oI
	 S97xvuETqdRN0KyqJVapYyVYam0qMmgJKC1Jq6n8XBAloW/187lyF3MgrNN6Tnl/pv
	 dKEJS1FPFHWg9JjFbSB2Ifijjz7DKpIGyAmhOm+f5MeWB3tx8iuJ68lIL4k6+NJJ8V
	 JkY6Mw51SqD3lEYbSki14DyRYTmdeu9S1IhuY6W0l/TDC/FgKCwEfLGtlWdOBbZDlM
	 F/dsRyd4eX24/QSxANW6mB1h6Jp5DgAVb29U4HpOBC7e+kdku9bdq9ork1BFPLgPVD
	 Hlq9/LXHOHbVw==
Date: Sun, 19 Jan 2025 12:57:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jeff Xu <jeffxu@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] selftests: Handle old glibc without execveat(2)
Message-ID: <20250119195706.GB1824045@ax162>
References: <20250115144753.311152-1-mic@digikod.net>
 <20250117.062883f45a7d@gnoack.org>
 <20250117.aiy2ooph6Lee@digikod.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117.aiy2ooph6Lee@digikod.net>

On Fri, Jan 17, 2025 at 04:47:05PM +0100, Mickaël Salaün wrote:
> On Fri, Jan 17, 2025 at 03:42:22PM +0100, Günther Noack wrote:
> > Do you want to add a comment next to these, to remind ourselves do undo this?
> > You are surely not planning to support old versions of glibc indefinitely?
> 
> I don't about glibc.  Minimal versions for other tools are documented
> here though:
> https://docs.kernel.org/process/changes.html
> 
> Nathan, Jon, any idea?

I do not know if the idea of setting a minimum supported version of a
libc has ever come up before (at least I am unaware of one). I suspect
most people do a patch like this then move on because it is the
maximally compatible option and these samples are not changing much, are
they? This is the first build error I can recall seeing as a result of
using an older glibc environment. If we would like to seriously consider
setting a minimum supported version of glibc, it deserves a conversation
with a wider audience since it could impact areas other than the
samples, such as host tools (and IMHO, feels like a big hammer).

Cheers,
Nathan


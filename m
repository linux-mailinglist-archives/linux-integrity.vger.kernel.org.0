Return-Path: <linux-integrity+bounces-9239-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGxuJq9O5WmVgwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9239-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 23:52:47 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1399E4259A9
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 23:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07DD83008898
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283182E1EF4;
	Sun, 19 Apr 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ2qq5Jp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028704400;
	Sun, 19 Apr 2026 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776635565; cv=none; b=ODYywF+kEKK+G/y9FmuDa1oBKeA7f56knMd7YzlQ9Wv4yoIbsZx7IJ2tbb99XO6ZVnZsN82mO8DfOfOscn2WDr5vY5WOTfCrMhT0vYqzHrbCZOhMghRbS6EX/tNnWr8M+UARi9SvxiPhnOXVSO9taigu5K2inacj7l1qqbfXD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776635565; c=relaxed/simple;
	bh=UFOElHvnY8LDWSkGy6GCIIqhsHPqlmKW6sITTLH33gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAKByoTUuA3I7I6DPprcbOLYcibZRt2X/g5uIlmERhCp87+FQjeMSpTHi4Ykh+R8BplaEzMgiTOy+lEW1HLvCCZOOImj8VIwsO9YZ7hmw+aReSb6uPphXWJ09hoI/7687r2J1UewBmvw6apinCuiHnDW+IxIQIGPRr2qRlv3iXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ2qq5Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4E9C2BCAF;
	Sun, 19 Apr 2026 21:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776635564;
	bh=UFOElHvnY8LDWSkGy6GCIIqhsHPqlmKW6sITTLH33gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJ2qq5JpBYM13vW0Jh1bz/4QZZ1yUWRRvVKGeRpBk1m2bDptDOrgvv9ibS64QQf4T
	 vHq7k9EF3Bx1hTO+iDDeRNysg9h9Ug9CXWKsn93fG1igcgHg8CWZFNhSEiba56wtwv
	 RpyRAyEUYUxFshfO1wK9cT//+ppI04oB9maTGUTmGrIt9R/NuG1QLtJBEqjuArICyB
	 5f+RuUF4TrztuyEb5Rec6decvGG9N2GmnzWBYoT+ycdSvbdvohUmFvNGL3j5P7yiBc
	 97CBip6rYP98PPaxwkTbPX4mCO/eaBrOplN7NNIPrbqiDS0ixpYtxdocp6DsQN3fFU
	 /ZzS4NRe+WgZw==
Date: Mon, 20 Apr 2026 00:52:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-7.1-rc1
Message-ID: <aeVOqT605cwcFtnu@kernel.org>
References: <aeTM2CO_mlNYViFU@kernel.org>
 <CAHk-=wiPWCUHsNvzKep7z4VGaL-Brx6Zmh7Efn28WWTPbwn5dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPWCUHsNvzKep7z4VGaL-Brx6Zmh7Efn28WWTPbwn5dA@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9239-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1399E4259A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 08:40:36AM -0700, Linus Torvalds wrote:
> On Sun, 19 Apr 2026 at 05:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > This pull request contains accumulated bug fixes for TPM driver.
> 
> This is all very recent, not all of it has been in linux-next at all,
> and stuff that appears to have been there has been rebased.
> 
> Why?
> 
>             Linus

Responded for both in keys PR but why it came so late has a QA story
behind it.

I created this week a uefi bootable buildroot target (I have tpm in the
gpios) for RPi 400 and tried to get first QA round with it but I run
into some systemd issues.

The upside (and the goal for doing that) is that for future releases I
will bare-metal testing on aarch64 for all commits that pass through.
Should have just given up on that for the time being earlier...

BR, Jarkko



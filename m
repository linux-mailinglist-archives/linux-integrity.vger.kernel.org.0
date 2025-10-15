Return-Path: <linux-integrity+bounces-7433-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C884EBDE338
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Oct 2025 13:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933DA4816CF
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Oct 2025 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69DE2F5327;
	Wed, 15 Oct 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdGN/jQp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DA1CD15;
	Wed, 15 Oct 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526181; cv=none; b=ujNX6l/mB8lkYtCx3CVz0zTunycBy95PZmIwkYMMuqC9NUESTtnpww6twWhwjlIDYeU3wefKNQYmZh+LSF7hkpWp54hbnVqyENZwjX3lUxIJMk0GnMKJRUw0bwa87SxSkoHZ4i/LojYjgrnxT57Eo3CEYRZ2PZFWXUPn30FNFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526181; c=relaxed/simple;
	bh=Rxy3oznxx1R7YxeBWAAqVtHxak3Xfg+zf9hXIGFoIyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP6Bh9XjfTk++g4mDlHJBBUBT/dhY1IGb4bzy5X+Q99BPwOK9qy7kOuVJY0edIjqz02gFKKgdBWU935hyI5OEMPjml7WXYhR218lsJrBENg9iMchDB9RTqEVS7vxNb4O/Rcq7xx6rGcJJ9oW9rqKrqxRZwwlM3D1AbisGJSp4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdGN/jQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0629C4CEF8;
	Wed, 15 Oct 2025 11:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760526181;
	bh=Rxy3oznxx1R7YxeBWAAqVtHxak3Xfg+zf9hXIGFoIyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdGN/jQpE8YGn3vDZXrbOWXXoCHF1HbuomM7dhFgeUlirD+qjy+H6xk++J2kkFzoc
	 vdvujj4EBwwVgfb7ZgNFeEICTtnTl1b/HHcPZXK+UYULjp1+FG6ekt1jJfoztbDGPc
	 WppTqb0Y/VrR37xrbPTWFSltpxic1NCfjUvDbDX0rzf6xZ02Z9U41YDH43coVRfGhG
	 WZ58bjEMlDc7ZCbgLIwuCDKt/2eXpUDG1lrHYZcko8XqVYFpWRE96Qxlp7gtsqJ/n8
	 BgczmxkB1z1AgzniiJcRdJVjzOTGsVsuVhs/UaeWf4EsKgyOWsVnzo202U59bOvYvM
	 uToUaa52pQ04w==
Date: Wed, 15 Oct 2025 14:02:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	David Howells <dhowells@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] keys: Remove redundant less-than-zero checks
Message-ID: <aO9_YVdF3qGOEBdZ@kernel.org>
References: <20251011144824.1257-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011144824.1257-2-thorsten.blum@linux.dev>

On Sat, Oct 11, 2025 at 04:48:24PM +0200, Thorsten Blum wrote:
> The local variables 'size_t datalen' are unsigned and cannot be less
> than zero. Remove the redundant conditions.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

David, I've applied this.

BR, Jarkko 


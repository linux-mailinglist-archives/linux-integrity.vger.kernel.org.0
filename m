Return-Path: <linux-integrity+bounces-3292-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58C9481EE
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2024 20:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454B028B828
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2024 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E515FD13;
	Mon,  5 Aug 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3pyDbbA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6061D540;
	Mon,  5 Aug 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883895; cv=none; b=rV6IlLO2tY6Me+jmagYzXgwDOmnyctXAEjm5Ln0EhKjB+JldjJubRjuIhIQh/3GHZQgBpCPGgEZ0ATRnWpbIds5uZX458UPK1GVaosCv7t2MTe0j1RJW1YoaE/OYPH4DHH010nRBZSp4MVwkz/FlEV7xPniq+qVInSfJagjr1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883895; c=relaxed/simple;
	bh=uf8ILAskZN/4P/S4F7SKa3SGrBWodGKtmv2kZoh7MLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMsKY4XqP4toGx9mb03nqi6KmI/x0dlU076EHz7HoK4T9csZpZrFK/xIasHUaX1sUtJNMVb5JM2GErVDvunGba/p4ntmh0gi71cdJGXhigmdaTJjciD18Lz0a2o4ZXthrWW6GyW2RkcSAmiX87yMYUQYhaSvhi8YQOxl8lAw/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3pyDbbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25914C32782;
	Mon,  5 Aug 2024 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722883894;
	bh=uf8ILAskZN/4P/S4F7SKa3SGrBWodGKtmv2kZoh7MLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3pyDbbAzcvONmuquDw8PZ6flxoE46it5ePJVAuMwygCo/wGsmYpgJVJ7p9MzEJqD
	 9ectkAhOEZoTUJz9r5RZ54q/pujI84cU6X4o3xzNRV4IGgUaRUgmwJJNrsBp7qoyPs
	 RYtYLOXeyPac2aKqmsjr3M3MExOj8mVd4KC8mmd6Rhdx5KTd75sw3mlQ1vma60VRe6
	 IJKXxmRXfMEvWGx9NpeG7XCIxv8XKud0y24Gs+GEQP30a1QLMTPE6vpcVCexMz+Frr
	 71TZOsBY0fwczfFhAYylvjyHoCcCvIHjfrDun0Xl/r+rM0zxm5kqHEn2OHEGN/fIMA
	 A9ZYjjwyFvq7Q==
Date: Mon, 5 Aug 2024 11:51:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com,
	paul@paul-moore.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v20 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
Message-ID: <20240805185132.GC1564@sol.localdomain>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-16-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722665314-21156-16-git-send-email-wufan@linux.microsoft.com>

On Fri, Aug 02, 2024 at 11:08:29PM -0700, Fan Wu wrote:
> This patch enhances fsverity's capabilities to support both integrity and
> authenticity protection by introducing the exposure of built-in
> signatures through a new LSM hook. This functionality allows LSMs,
> e.g. IPE, to enforce policies based on the authenticity and integrity of
> files, specifically focusing on built-in fsverity signatures. It enables
> a policy enforcement layer within LSMs for fsverity, offering granular
> control over the usage of authenticity claims. For instance, a policy
> could be established to only permit the execution of all files with
> verified built-in fsverity signatures.
> 
> The introduction of a security_inode_setintegrity() hook call within
> fsverity's workflow ensures that the verified built-in signature of a file
> is exposed to LSMs. This enables LSMs to recognize and label fsverity files
> that contain a verified built-in fsverity signature. This hook is invoked
> subsequent to the fsverity_verify_signature() process, guaranteeing the
> signature's verification against fsverity's keyring. This mechanism is
> crucial for maintaining system security, as it operates in kernel space,
> effectively thwarting attempts by malicious binaries to bypass user space
> stack interactions.
> 
> The second to last commit in this patch set will add a link to the IPE
> documentation in fsverity.rst.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

Acked-by: Eric Biggers <ebiggers@google.com>

- Eric


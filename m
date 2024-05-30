Return-Path: <linux-integrity+bounces-2707-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB248D43F0
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 05:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05783B232DF
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 03:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7CF1CABA;
	Thu, 30 May 2024 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYOKCDuR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16FF33C5;
	Thu, 30 May 2024 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038369; cv=none; b=APt3oW7dDyBK1sVM28hZ8a/wa5ibNQ7QIQWtrt2dFa2qJnmPRS9QIceAzybymw32Y8p43KXD9PsYp55FhaB0j0y73uUqaDs0enbnDuEcg0qo0DshLoQdGVzErjpkXOvpPYHWlYHxqagfIcsJP2C77Qof2EnMAT3QO/ewDA4JGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038369; c=relaxed/simple;
	bh=5WLfsgF8O76R3zxYvopG4iE5lsb1nbAnf+aMSgf9czA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkRY+g3LbhKrpgBoCXOScSa2gAG+WZf+s/f50x8mE8QvQXu1ld+qvU8MqK3auYfTLMaSDmeuL6LSIEhnR9dlEM6BlIZNgHK0594VRO36TkI7lwmdIiUW4MzpmfwJ5g8ZfIaAEuByVqVv5qCM3Moxt8k3aRxSD5cQy91djZwKNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYOKCDuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814FDC116B1;
	Thu, 30 May 2024 03:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717038368;
	bh=5WLfsgF8O76R3zxYvopG4iE5lsb1nbAnf+aMSgf9czA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYOKCDuR3jyQbxGiMo/Q46/CE1+8wVKBuqHvfzf3hFccaeCBJf3j8JIyW7yaiSynw
	 WEzhVw3wMa723xV57cMNVHVcBYTYai/65NHk7xQlm12gIDASpcUNRUs/bejtpZoWpe
	 bTo4P2EP4t06KxPLw4JHE9yjT5pneQyraz6MTvQVz2mPh2LImVgy8lgyLPpiPHirkz
	 r+vHZmK5rMg1KFU47P8qKDa4YK71RYWKWY37SWgs5wzx2uJqOPhBEJz3ztPM26DVGz
	 M9RrTEiLLIYr1EFzS9PqToKqV7qZOg1yyV+hHPOjSjNbg0UgJNxMOEsaQxcpuXrcHy
	 z3vxSNvzCnXBQ==
Date: Wed, 29 May 2024 20:06:05 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com,
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	eparis@redhat.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
Message-ID: <20240530030605.GA29189@sol.localdomain>
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com>

On Wed, May 29, 2024 at 09:46:57PM -0400, Paul Moore wrote:
> On Fri, May 24, 2024 at 4:46 PM Fan Wu <wufan@linux.microsoft.com> wrote:
> >
> > This patch enhances fsverity's capabilities to support both integrity and
> > authenticity protection by introducing the exposure of built-in
> > signatures through a new LSM hook. This functionality allows LSMs,
> > e.g. IPE, to enforce policies based on the authenticity and integrity of
> > files, specifically focusing on built-in fsverity signatures. It enables
> > a policy enforcement layer within LSMs for fsverity, offering granular
> > control over the usage of authenticity claims. For instance, a policy
> > could be established to permit the execution of all files with verified
> > built-in fsverity signatures while restricting kernel module loading
> > from specified fsverity files via fsverity digests.
> >
> > The introduction of a security_inode_setintegrity() hook call within
> > fsverity's workflow ensures that the verified built-in signature of a file
> > is exposed to LSMs. This enables LSMs to recognize and label fsverity files
> > that contain a verified built-in fsverity signature. This hook is invoked
> > subsequent to the fsverity_verify_signature() process, guaranteeing the
> > signature's verification against fsverity's keyring. This mechanism is
> > crucial for maintaining system security, as it operates in kernel space,
> > effectively thwarting attempts by malicious binaries to bypass user space
> > stack interactions.
> >
> > The second to last commit in this patch set will add a link to the IPE
> > documentation in fsverity.rst.
> >
> > Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >
> > ---
> > v1-v6:
> >   + Not present
> >
> > v7:
> >   Introduced
> >
> > v8:
> >   + Split fs/verity/ changes and security/ changes into separate patches
> >   + Change signature of fsverity_create_info to accept non-const inode
> >   + Change signature of fsverity_verify_signature to accept non-const inode
> >   + Don't cast-away const from inode.
> >   + Digest functionality dropped in favor of:
> >     ("fs-verity: define a function to return the integrity protected
> >       file digest")
> >   + Reworded commit description and title to match changes.
> >   + Fix a bug wherein no LSM implements the particular fsverity @name
> >     (or LSM is disabled), and returns -EOPNOTSUPP, causing errors.
> >
> > v9:
> >   + No changes
> >
> > v10:
> >   + Rename the signature blob key
> >   + Cleanup redundant code
> >   + Make the hook call depends on CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >
> > v11:
> >   + No changes
> >
> > v12:
> >   + Add constification to the hook call
> >
> > v13:
> >   + No changes
> >
> > v14:
> >   + Add doc/comment to built-in signature verification
> >
> > v15:
> >   + Add more docs related to IPE
> >   + Switch the hook call to security_inode_setintegrity()
> >
> > v16:
> >   + Explicitly mention "fsverity builtin signatures" in the commit
> >     message
> >   + Amend documentation in fsverity.rst
> >   + Fix format issue
> >   + Change enum name
> >
> > v17:
> >   + Fix various documentation issues
> >   + Use new enum name LSM_INT_FSVERITY_BUILTINSIG_VALID
> >
> > v18:
> >   + Fix typos
> >   + Move the inode_setintegrity hook call into fsverity_verify_signature()
> >
> > v19:
> >   + Cleanup code w.r.t inode_setintegrity hook refactoring
> > ---
> >  Documentation/filesystems/fsverity.rst | 23 +++++++++++++++++++++--
> >  fs/verity/signature.c                  | 18 +++++++++++++++++-
> >  include/linux/security.h               |  1 +
> >  3 files changed, 39 insertions(+), 3 deletions(-)
> 
> Eric, can you give this patch in particular a look to make sure you
> are okay with everything?  I believe Fan has addressed all of your
> previous comments and it would be nice to have your Ack/Review tag if
> you are okay with the current revision.

Sorry, I've just gotten a bit tired of finding so many basic issues in this
patchset even after years of revisions.

This patch in particular is finally looking better.  There are a couple issues
that I still see.  (BTW, you're welcome to review it too to help find these
things, given that you seem to have an interest in getting this landed...):

> +	err = security_inode_setintegrity(inode,
> +					  LSM_INT_FSVERITY_BUILTINSIG_VALID,
> +					  signature,
> +					  le32_to_cpu(sig_size));

This is doing le32_to_cpu() on a variable of type size_t, which will do the
wrong thing on big endian systems and will generate a 'sparse' warning.

Also, the commit message still incorrectly claims that this patch allows
"restricting kernel module loading from specified fsverity files via fsverity
digests".  As I said before (sigh...), this is not correct as that can be done
without this patch.

- Eric


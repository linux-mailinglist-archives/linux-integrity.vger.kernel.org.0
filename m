Return-Path: <linux-integrity+bounces-3702-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021B6986074
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF4728761B
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD991A7058;
	Wed, 25 Sep 2024 12:57:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A11A704B;
	Wed, 25 Sep 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269041; cv=none; b=SXuAhmggO67blylrtHdZ5yx23N4QS4/SgBbKZniUIjQdIYAn5lAEefAtzydt+O7cM2g14v60EAwYEDrAyMwW71E0QC3ts3mTGZMOby46PbL1lFN5BV5SlnUfXdN+WinEcNd/IdM/rrhNoTdmSRd1fJDl7lv9z3vWe6LtmDTHbFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269041; c=relaxed/simple;
	bh=h9y4gY3/47lj3mOUJL9BDXr/IXY0v8IwKjVzqJwVOVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoZtn8OwSaCqoMRQl6IHu4CKuRibdhrkyEsAE7CMas1vBVdXqY37K2Tna3CgL6X554JjUlgEsDRtjFhLZp8Xcpzbdln2ypZanpsYshUEwCKz3gVDybvSdoCsIqm9LmyPlX81+OYX/oZ7mxUyA3oG5lll0PCQLSDe6k5UoEo5b5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 50092A05; Wed, 25 Sep 2024 07:57:17 -0500 (CDT)
Date: Wed, 25 Sep 2024 07:57:17 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Milan Broz <gmazyland@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, luca.boccassi@gmail.com,
	dm-devel@lists.linux.dev, snitzer@kernel.org, serge@hallyn.com,
	wufan@linux.microsoft.com, David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, Tycho Andersen <tycho@tycho.ws>,
	Mike McCracken <mikmccra@cisco.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
Message-ID: <20240925125717.GA653365@mail.hallyn.com>
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
 <20240924215910.GA1585@sol.localdomain>
 <df791a04-feae-4708-865f-193360b35fad@gmail.com>
 <D4F8UQ7EQ1AH.28Y6BJIM287S1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4F8UQ7EQ1AH.28Y6BJIM287S1@kernel.org>

On Wed, Sep 25, 2024 at 12:05:59PM +0300, Jarkko Sakkinen wrote:
> On Wed Sep 25, 2024 at 11:03 AM EEST, Milan Broz wrote:
> > >> Doesn't dm-verity have a maintainer?
> >
> > (This reminds me of a nice comment from Neil about "little walled
> > gardens" between MD & DM.  Apparently it applies to other subsystems
> > as well. Sorry, I couldn't resist to mention it :-)
> 
> Np, it's just that last and only time I've ever read anything about
> dm-verity was 2011 article :-)
> 
> I will rephrase question: does dm-verity have a user? ;-)

It gets used for integrity guarantees in certain containers, where
the layers of tarballs are replaced by layers of squashfs, with the
dmverity root hash for each layer listed in the signed manifest, e.g.

github.com/project-stacker/stacker
github.com/project-machine/atomfs

This is used of course to verify container integrity, and also gets used by
some projects and products to create an RFS from such images during initrd

github.com/project-machine/mos

-serge


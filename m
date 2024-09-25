Return-Path: <linux-integrity+bounces-3701-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C598560C
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CF8B22433
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39057156222;
	Wed, 25 Sep 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdXxxy/f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972712D20D;
	Wed, 25 Sep 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255164; cv=none; b=BeXFHBbuXkl13NP2fhbsQDnMqo/kl9bN4S37zODJVWSKJU8/gIQmdWg+t9zdP3y8MR8FeqUd8L23bwNO6t3tQ8Cruw+lnQ7fzr3iMhRoSi9exQiamQ2PK9p+tiaqgLCxcbxbOvmB97rfnasPyCkJ1fo3qcpEIjzmUo5aFDYZBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255164; c=relaxed/simple;
	bh=Qc3vcqMtefGSPRw8PeY81lOlPjoknKL/5PRl5184CCg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dDHsmB7f6Bmkqm9NetKKLrLtwd5qltrKyB29y8zPljtO/BJYQmR4j6wY5L+J0wMLndJCwWNTuByTjbtqO4gQLUU6+wslCZz7ZwwsVMWFbS9URCrG601Odk2lF4W6BRWG5c+OKUs69Q/vcnDlHMjm4NGzarhLpjmO0mc9mHHR2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdXxxy/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41767C4CEC7;
	Wed, 25 Sep 2024 09:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727255163;
	bh=Qc3vcqMtefGSPRw8PeY81lOlPjoknKL/5PRl5184CCg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QdXxxy/faZ3L+Yn3g3fe7myCP5Y7ivhszVLy2OWxVjr5NO9vZa342/nTtF6pmCfPj
	 RGtkgyhDlYEuhcL/4t4mjgvde2OpI3q02gXzLMbLS95y3D70agPPDgLAjL3g2eR7Id
	 zmXt3NOUYQtwRkC9OXVlkbM3rSuE9txd1Jz8c/wB+7U9HEmo1/gDP9Gy19T+7xY3dQ
	 9vLy217XiAaEVR/MOmU8wm2W2LpS7j3txQyI1W1Vco3oawA2XDVf83c03ftu+BAWRw
	 N8V01CUozxtZe1OzjCi9yodGNEiGpMETmf3LSteExDCIOO0r+1mzBbdvzBkmvfNHDv
	 8P+dqoSXwjaqg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 12:05:59 +0300
Message-Id: <D4F8UQ7EQ1AH.28Y6BJIM287S1@kernel.org>
Cc: "Mikulas Patocka" <mpatocka@redhat.com>, <luca.boccassi@gmail.com>,
 <dm-devel@lists.linux.dev>, <snitzer@kernel.org>, <serge@hallyn.com>,
 <wufan@linux.microsoft.com>, "David Howells" <dhowells@redhat.com>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Milan Broz" <gmazyland@gmail.com>, "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
 <20240924215910.GA1585@sol.localdomain>
 <df791a04-feae-4708-865f-193360b35fad@gmail.com>
In-Reply-To: <df791a04-feae-4708-865f-193360b35fad@gmail.com>

On Wed Sep 25, 2024 at 11:03 AM EEST, Milan Broz wrote:
> >> Doesn't dm-verity have a maintainer?
>
> (This reminds me of a nice comment from Neil about "little walled
> gardens" between MD & DM.  Apparently it applies to other subsystems
> as well. Sorry, I couldn't resist to mention it :-)

Np, it's just that last and only time I've ever read anything about
dm-verity was 2011 article :-)

I will rephrase question: does dm-verity have a user? ;-)

BR, Jarkko


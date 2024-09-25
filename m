Return-Path: <linux-integrity+bounces-3705-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED34698657F
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279D11C23C80
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47FF53376;
	Wed, 25 Sep 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL+Bc3Rj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C555381B;
	Wed, 25 Sep 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284505; cv=none; b=TJhNxSmddR7CJia8kgxtUzc1b3YxhT8DYzDNcJ7Kg9zPT9JGTeap7jmIHgNetuL7reDf/OWZdA/pEw62+NoKOeeHVUFhv0uftF+rN6DU66A+tWaIEqq3EJw45/0a6zafuhAqbq8PHI34enw/jyLNrdFOrirIOGhDud1NgozlSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284505; c=relaxed/simple;
	bh=tK5+n5aRP/WUvnl6ZOG4ND40qDXBwxeR19BWggIH2wM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Bdw6i/sIjLWNYK6hvPga1Rn/3lH3Io3UbEbonqNw+lPAwprTaQ3AAZbYmkQEVAuHutz65XnTsfSDFn306gB4REjMzGqAPs02MwwIJUBSmsWOja+0N0Om1xiVZmyg4iiisce5mv10fo+fqQo7G6fRxVytAu7xAxHe2WW+7GpKBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL+Bc3Rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B09C4CEC3;
	Wed, 25 Sep 2024 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727284505;
	bh=tK5+n5aRP/WUvnl6ZOG4ND40qDXBwxeR19BWggIH2wM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eL+Bc3RjsKzligFYMjOV9jZyiWmeJvW2EROFujHdHYmJ4a0OyGbp+e//skYcyhjEH
	 akpizxPdMCz5HJ0qu0Z4LLkErcIHDIt98nHyew1jmgKkFwfc80V9YziMKPim2YkuLO
	 RzXsI6hr7fUPu0/RYxgDDFinM5WHa9lr7bY+ZxBNfs3EX58tOS+/hY0pS0UBIRjUNo
	 IvfzdeJ4vXTyT4ogwhuiY4ZbEfjWBkvSEO/XYX26Yrg05DYxm1YxoQQYuZ4tB+K53z
	 TDukkGwjjqZBSmFqC8qM8Ncr+dNJ3oWAaGtQ7IaYgblsiOlb48t3ZFUCQqbjLxQRfV
	 xiwxiKW69wX1Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 20:15:01 +0300
Message-Id: <D4FJ95EVCW7I.2GHRW7LZRZPBJ@kernel.org>
Cc: "Milan Broz" <gmazyland@gmail.com>, "Mikulas Patocka"
 <mpatocka@redhat.com>, <luca.boccassi@gmail.com>,
 <dm-devel@lists.linux.dev>, <snitzer@kernel.org>, <serge@hallyn.com>,
 <wufan@linux.microsoft.com>, "David Howells" <dhowells@redhat.com>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
 <20240924215910.GA1585@sol.localdomain>
 <df791a04-feae-4708-865f-193360b35fad@gmail.com>
 <D4F8UQ7EQ1AH.28Y6BJIM287S1@kernel.org>
 <20240925165338.GA3738787@google.com>
In-Reply-To: <20240925165338.GA3738787@google.com>

On Wed Sep 25, 2024 at 7:53 PM EEST, Eric Biggers wrote:
> On Wed, Sep 25, 2024 at 12:05:59PM +0300, Jarkko Sakkinen wrote:
> > On Wed Sep 25, 2024 at 11:03 AM EEST, Milan Broz wrote:
> > > >> Doesn't dm-verity have a maintainer?
> > >
> > > (This reminds me of a nice comment from Neil about "little walled
> > > gardens" between MD & DM.  Apparently it applies to other subsystems
> > > as well. Sorry, I couldn't resist to mention it :-)
> >=20
> > Np, it's just that last and only time I've ever read anything about
> > dm-verity was 2011 article :-)
> >=20
> > I will rephrase question: does dm-verity have a user? ;-)
> >=20
> > BR, Jarkko
>
> Sorry if I was unclear.  dm-verity is widely used, including by all Andro=
id and
> Chrome OS devices.  But this patch is about dm-verity's in-kernel signatu=
re
> verification which is an optional sub-feature that is not widely used.  T=
hat
> sub-feature is apparently difficult to test and not clearly specified, wh=
ich is
> why people seem to be struggling a bit with this patch.

NP, I learned a new thing ;-)

Before Linux I worked with Symbian (ugh) so this whole scheme for doing
FW updates is familiar to me from the dark ages...

And I acked the change too!

> - Eric

BR, Jarkko


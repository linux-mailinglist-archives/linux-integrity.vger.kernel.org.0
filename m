Return-Path: <linux-integrity+bounces-3914-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB20B9B0627
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509B61F2252F
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB67083B;
	Fri, 25 Oct 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH44ALbA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E8212195;
	Fri, 25 Oct 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867710; cv=none; b=lIN5OiAnqFGWMztSpe5U3wp3mWnktBhtcHz+gXuErPVd9I3PT2E+CSe+kBxyIdAKT2x/L2oXTqeAhXmAxIKzhkfKlBsAX5Ne2VkqQAVXwrTiob0UUS6S8eJCwnI/pKzGbXfmifttbUEJEujvIDsrefyJNQF6B3as6hoRiKz7/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867710; c=relaxed/simple;
	bh=aUonxWk/Wb6mMpEzIzSZDDZlf2vaFKkhtJQaWHKDrmY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ndCRtd2WGOs7zDOWqUiaTYcKsYeCMAmaDuXwU6eC9N0D3NfE0tEkxshihT0zdGwBh5Z1mH+eJTxiC3wM5bP3E7l+cZBuu53KxCKsEgUEjo1aaFnfNcom3U8KVzaEj43U2pz9etD5wkRxmGS1AZhyUOqIWmlFmuuC8+BRDK5u65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH44ALbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223EBC4CEC3;
	Fri, 25 Oct 2024 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729867710;
	bh=aUonxWk/Wb6mMpEzIzSZDDZlf2vaFKkhtJQaWHKDrmY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gH44ALbAO6nxYlI8caLeWzMji+gRCI/y69bK/6XDkizz3CPG4iVzgNhYFYcuMgX4F
	 cpDxIMa+ZdFqcg9iKjzy//sriqjfSyaoUeSnJzqmmkFKYQP7J9bhvvC4f12v3i1Ye3
	 nEGbOtF3186STLuevltzo1RLyEeLGGLtCDys2Osg6ELAMFrnverD/evZOcYifGBoT8
	 2CYpZxX7QzOj8yeOoVHYOrovot9UdgFCIyk3Qtwr5qYPO5h/+b7w3BdMZINK4ObofL
	 FMMYriiTFWIJHNCaekHPKaPdPjteeli6qpKpeifODuYoYiIvowbFmYnTJT8rTKqfzG
	 K/Z9+DPrcKqbg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Oct 2024 17:48:18 +0300
Message-Id: <D54YX5TQD6PC.KPDZRST813O5@kernel.org>
Subject: Re: [PATCH v6] tpm: Add new device/vendor ID 0x50666666
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: "Jett Rink" <jettrink@chromium.org>, "LKML"
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe" <peterhuewe@gmx.de>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240910191117.1001581-1-jettrink@chromium.org>
 <D43HINLZGMXS.FYJOK0SVQFQW@kernel.org> <ZxckGbxzpWDuXG_q@google.com>
In-Reply-To: <ZxckGbxzpWDuXG_q@google.com>

On Tue Oct 22, 2024 at 7:03 AM EEST, Tzung-Bi Shih wrote:
> Hi Jarkko,
>
> On Wed, Sep 11, 2024 at 04:21:24PM +0300, Jarkko Sakkinen wrote:
> > I applied this (will push later to my remote tree).
>
> I failed to find the patch in [1].  Is it somehow overlooked?
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.g=
it/log/?h=3Dnext

I'll check this next week. Not on purpose if it is missing.

BR, Jarkko


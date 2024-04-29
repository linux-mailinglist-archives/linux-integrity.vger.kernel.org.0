Return-Path: <linux-integrity+bounces-2256-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1BC8B634D
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA01F2112A
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914171411C9;
	Mon, 29 Apr 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="D8o33ujE";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="D8o33ujE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532231411D8;
	Mon, 29 Apr 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421519; cv=none; b=q5jPt/op+PNwcctq3U9SgUEFvUXduFJyKFthcrN/z6wZh44u032McHG9qzX98qEygdIaQj2uHD1y3rZVPKBoYgpr2YgkaaC23B1aaJ+toUqwM4Dy8RbRjblmFX4z6Xd73nt6oTO2c1kqX/2jjW9Kw/uPZpGe5HiH/31AcF6ZafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421519; c=relaxed/simple;
	bh=9oxVgAdTyecdBpenlDRDSSNyqdx/DsEUr8HfUDJQHgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=CD8Pwt7SKSKzc2G3zfGE+92PINLgqGNg4o1Hg197V/rY3bDOHxJrRggKptTLXK1/yevSJLGLTXLyZuhz/v4VjdKhkrIHMPctWAD+OWHVbfMWQxSnXfSbl4yOfsmLDxvAmVxW89P7QZE7sc9ZZlMzzHJKzQ9j1LWps1Pq5GKjDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=D8o33ujE; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=D8o33ujE; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714421517;
	bh=9oxVgAdTyecdBpenlDRDSSNyqdx/DsEUr8HfUDJQHgQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:From;
	b=D8o33ujE6Ye7RX7l2Lln4Z+QocInMKfMZnXEaC5lQ9aLLmJISbf6UqM2S2ax5hQaJ
	 7WJgRojtyfJauzv+VH8lOKX9xoy2iZUDmrz/ZURo+R1Exc83Pa24lj8SRBGUdcC+Jj
	 mjJWHvitPyku7gdfCh/AHx6zssx0wDsacfUGghgA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 91BC3128141F;
	Mon, 29 Apr 2024 16:11:57 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FJjIQxQ5PvT1; Mon, 29 Apr 2024 16:11:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714421517;
	bh=9oxVgAdTyecdBpenlDRDSSNyqdx/DsEUr8HfUDJQHgQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:From;
	b=D8o33ujE6Ye7RX7l2Lln4Z+QocInMKfMZnXEaC5lQ9aLLmJISbf6UqM2S2ax5hQaJ
	 7WJgRojtyfJauzv+VH8lOKX9xoy2iZUDmrz/ZURo+R1Exc83Pa24lj8SRBGUdcC+Jj
	 mjJWHvitPyku7gdfCh/AHx6zssx0wDsacfUGghgA=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DA8EF1280977;
	Mon, 29 Apr 2024 16:11:56 -0400 (EDT)
Message-ID: <23b3845026f6f47b70315fa94e7dee061fe1019c.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 15/21] tpm: Add the rest of the session HMAC API
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: jarkko@kernel.org
Cc: James.Bottomley@HansenPartnership.com, ardb@kernel.org, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Mon, 29 Apr 2024 16:11:55 -0400
In-Reply-To: <CZCMHZLQN9JK.105PT306O5TV1@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> OK, since there is multiple patches with KDF* dep the KDF functions
> should be their own separate patch not glued into any patch that uses
> them.

Well, I can do that if you insist, but it can't go into the kernel like
that because we'll then have a static function with no consumers which
will generate an unused function warning and break the build on -
Werror.

James




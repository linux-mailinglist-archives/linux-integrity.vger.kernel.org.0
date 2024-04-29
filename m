Return-Path: <linux-integrity+bounces-2255-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF88B6348
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D854128340A
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DD14039D;
	Mon, 29 Apr 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rytvN9yr";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VHYxvPGa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513B1411D3;
	Mon, 29 Apr 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421502; cv=none; b=UtFpwskPwYWzGy5WoqEZ7I4aQi3qzALWDJZo/fL3Z4BZGHwyX99AKWQgFJNZGFeO7AdQ3b+sx2+ZoJMgxl8+5eIFin+rNpcX5HFa5vYF+CwFB7Qyzp5nxti3iHeGp7OoN0v1ENJ5f/u/yNHVElUcm0j2AW6C7RLsW0zI/VcAWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421502; c=relaxed/simple;
	bh=40uil80hRePTPZ6U8b/Kdl4pl35Sa0QgzXGMuUJO9BI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBxqUuaWhcXrf+vLJWqykV1R+X+mNKURU0RNaGNLngeHSKD+XaiKJHkRFYTLI9oBgLOUsVSUfLyNtYuJLpog8Bew/Yh1wZRVOkxiF2kik1OjEEO8nWYyotC96KZ3zgrwONU0R+NJcHzKnKk6ISg1qbIioBp4ysgkANNLaKzd+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=rytvN9yr; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VHYxvPGa; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714421500;
	bh=40uil80hRePTPZ6U8b/Kdl4pl35Sa0QgzXGMuUJO9BI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=rytvN9yrvCZBKfcBRLj3b/um5RAJ4pbUjubt1pw1ffWxH4G0jNoq6aAtQ0W50KFWy
	 pVDU5UMkTVzph42WhkhVfWjHZG6eb2lpmpFSh2Fv1ViBbQqv1eB1lJFgQctarqO1R2
	 qfx8Zxp4IOPgCYGdwZzN8Bg0pncrF0M60lCa44hQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1DC081280977;
	Mon, 29 Apr 2024 16:11:40 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 8823Aw8nRtan; Mon, 29 Apr 2024 16:11:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714421499;
	bh=40uil80hRePTPZ6U8b/Kdl4pl35Sa0QgzXGMuUJO9BI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VHYxvPGap8gkuHQhGV+WsDmk5FloiNFigHdIRigw8UNHh/h8G7NpwWL5SYUGvPVD0
	 By1JdBD6YXT/KE5aXywxGemFod5ZWuPyFV/FET+OJ8o+IQ7u99/6JjZpTNfzrUbClg
	 I1Pkdxc6LUG/8n41o8wOtK4p7ihvi81j1aF6yxVY=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 782841280728;
	Mon, 29 Apr 2024 16:11:39 -0400 (EDT)
Message-ID: <c597904214ede9f403f43e60274f3fa6305e0587.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 14/21] tpm: Add HMAC session name/handle append
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Apr 2024 16:11:38 -0400
In-Reply-To: <CZCMF7FOZIY2.1KZL8Z57BA4RL@suppilovahvero>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
	 <20240213171334.30479-15-James.Bottomley@HansenPartnership.com>
	 <CZCMF7FOZIY2.1KZL8Z57BA4RL@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-02-23 at 19:06 +0200, Jarkko Sakkinen wrote:
> > +static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
> > +{
> > +       return handle >> 24;
> 
> did we have macro for this (cannot recall)? like oppposite
> of BIT().

No, that's why I added this. inline functions are easier to type check
than macros.

James



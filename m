Return-Path: <linux-integrity+bounces-3284-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12165946B19
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 21:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B070B20993
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2D225DA;
	Sat,  3 Aug 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eqNJOl1z";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k37vHeK6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA6F12B95
	for <linux-integrity@vger.kernel.org>; Sat,  3 Aug 2024 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722714426; cv=none; b=KHczBrCgmGJVkXZr2+yJ63CPZ3wHeoiTpbZCBQAPeX8RRZ03zvEZ0Gv3n50AYNwmvShrek5iq7BQDgRGbI9GdgI+nQTiKa8xMfRSjuUyMoNEdTYF0COpKbzPPBJokabT2yPD38LM1P7UWUjzwdzmNNoshYDLG8xtqG4D5xRgafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722714426; c=relaxed/simple;
	bh=n3ir6qbrBi1fMBhpn2PHogQa54GB6C/D1cDoyaRTzjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cG47PDLePqtm2RlmI1U7b7uJ8YFgOW0kClhjWTKinkSlvKhXsf567XFrzuwIwAy8bA/zUfhGnxYUGiBT8QPTtotC2CRPg/zhBrkUjPPHbtMatKlR8sWBL4xJOUBvJmmUuRQTHy+rBZ/68FdFQ6IfdofbSd0xwdtM9V+i2KIXNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eqNJOl1z; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=k37vHeK6; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722714424;
	bh=n3ir6qbrBi1fMBhpn2PHogQa54GB6C/D1cDoyaRTzjU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eqNJOl1zc1+XM0aedsuiPyy5jTTJ8YNvjHc7GTi5IIkermmkkqe/jcNaXr9g6OI0J
	 SOiWUnA4TqbnEIyh4ra8UBU5qWIEWfECXXTvXibPFdDAjNkhzRlmU8stnuz56Z5c1R
	 eu8dGZcUuk0OTMXyIZJvQc8tT0FButRiEU8UA3P4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1CEC11285DE0;
	Sat, 03 Aug 2024 15:47:04 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hrlR8b1gJ7j4; Sat,  3 Aug 2024 15:47:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722714423;
	bh=n3ir6qbrBi1fMBhpn2PHogQa54GB6C/D1cDoyaRTzjU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=k37vHeK6B+RPZHERf8thYaZ3gfJyQM7/AMY1PY0HB2fpTf98CUYu5oSNdboyDn5uR
	 TryEXQQLz4alDVOCid/NcOmaqU+ila3d+XVZYtzgd4MBltxCKSatkr0XQNFJU0L054
	 MJigbedkCxAH3USuFxpVGnPUp28baJwVBnOjL9zo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 742B11285D88;
	Sat, 03 Aug 2024 15:47:03 -0400 (EDT)
Message-ID: <237c1ed926d926bfddb92a959a27543479b5f0ae.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/8] tss: Fix handling of TPM_RH_NULL in intel-tss
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Jarkko Sakkinen
	 <jarkko.sakkinen@iki.fi>, openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org
Date: Sat, 03 Aug 2024 15:47:01 -0400
In-Reply-To: <D36IYI5ZD4VK.2GC6CG6GIUWK9@kernel.org>
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
	 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
	 <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
	 <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>
	 <D36IYI5ZD4VK.2GC6CG6GIUWK9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-08-03 at 22:31 +0300, Jarkko Sakkinen wrote:
> On Sat Aug 3, 2024 at 8:51 PM EEST, James Bottomley wrote:
> > On Sat, 2024-08-03 at 20:08 +0300, Jarkko Sakkinen wrote:
> > > On Fri Aug 2, 2024 at 11:25 PM EEST, James Bottomley wrote:
> > > > Now that we're going to be using the NULL primary to salt
> > > > sessions, the Intel TSS shim needs fixing to cope with this. 
> > > > In the Intel TSS, there are two internal handles representing
> > > > NULL: ESYS_TR_NONE and ESYS_TR_RH_NULL.  We translate
> > > > TPM_RH_NULL to ESYS_TR_NONE because
> > > 
> > > Can you split this into two paragraphs.
> > > 
> > > I'm lost why it has two representations.
> > 
> > Well, I actually have no idea why the Intel TSS has two
> > representations for *every* handle: an internal one (specific to
> > the TSS) and an external one that everyone uses, like 81000001 or
> > 40000007. As far as I can see it just adds pointless complexity to
> > the coding.  The IBM TSS only has one, so for code which works with
> > both, the shim has to transform between internal and external
> > handle representations before sending the command onward to the
> > Intel TSS.
> 
> Is it possible to address this complexity and move into a single
> representation? I.e. use external presentation all the way.

Yes, that's what the current code does.  It began life as pure IBM TSS
so it used what the Intel TSS would consider as all external handle
representations.  The external to internal shift (and back) happens
inside the TSS shim.

> > Even more mysteriously the Intel TSS has three representations for
> > the NULL handle: an internal one, an external one (40000007) and
> > one you use for an empty session (ESYS_TR_NONE).  The IBM TSS uses
> > TPM_RH_NULL for all three so you can't just translate from external
> > to internal you have to know if you're using the handle for a
> > session or a hierarchy as well.
> 
> Same question applies to this too.

Remember this is just fixing the Intel TSS Shim.  The fact that we have
to use three different handles for NULL isn't visible outside the shim,
so a consumer of these APIs just uses TPM_RH_NULL everywhere.  The fix
is that the Intel TSS Shim was using the wrong handle for some
operations.

> 
> > James
> 
> I'm doing my own TPM2 stack with Rust, which just re-implements the
> functionality of my old tpm2-scripts and tpm2.py module as nice small
> app called tpm2-cli.
> 
> It will be more use case based interface than than protocol spec as
> a software interface. Main goal for now is to get this whole flow
> into it (with varying parameters for the key) as single function:
> 
> tpm2_createprimary --hierarchy o -G ecc -c owner.txt
> tpm2_evictcontrol -c owner.txt 0x81000001
> openssl ecparam -name prime256v1 -genkey -noout -out private.pem
> tpm2_import -C 0x81000001 -G ecc -i private.pem -u key.pub -r
> key.priv
> tpm2_encodeobject -C 0x81000001 -u key.pub -r key.priv -o
> key.priv.pem
> openssl asn1parse -inform pem -in key.priv.pem -noout -out
> key.priv.der

Well, that's simply the library API.  That's actually what the IBM TSS
uses.  I think the Library API is by far the simplest TPM API to use,
so beyond trying to sort out the complexity of getting a compatibility
shim I've not really used the Intel TSS.  I think the Intel TSS is
based on the ESAPI document which introduces the handle conversion
complexity.  I haven't read the ESAPI spec, I just tried to reverse
engineer it (from the source) into supporting an API which can be
compatible with the library spec/IBM TSS.

James



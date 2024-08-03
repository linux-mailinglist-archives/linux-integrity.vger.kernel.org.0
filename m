Return-Path: <linux-integrity+bounces-3282-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A3946ABA
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 19:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A65281A69
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5E14265;
	Sat,  3 Aug 2024 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tg58QPDa";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tg58QPDa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322D13AD8
	for <linux-integrity@vger.kernel.org>; Sat,  3 Aug 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722707506; cv=none; b=QvhHsGGzGpv8T8zkSkT386e3tL534J0iBN6Dt4WTgBgcHAgQcV8Mas4LzhqknqjHjfgbyVcWHnrI7Lhz0T8t/WsSyIFxm4GQZUoNl+nDHlWhmZA1RMqHP0VsPIj4gIQRupZORx18z+U9NjiZVAPdaK7Tj31VZIAdYyzYdVcNMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722707506; c=relaxed/simple;
	bh=Y9Gkic50TrYVNl06FqGzpU/XQ/hwDYlSEjxxInV4DK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q689zDDdEDSQLgVKGZu5meymTz0PsS6rWUbPvDXcy9qpfy+MQqV7pKlxiTSFrfi0GsML7wa8cIrIVI3EeW9fzziqTncyvns28rJE2Ib0JZubOCz5vxYnfMUz/ML/6GtBrGwfNsmD09AmikvBlacljO70J5Pg6t0u5E95HlxHgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tg58QPDa; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tg58QPDa; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722707503;
	bh=Y9Gkic50TrYVNl06FqGzpU/XQ/hwDYlSEjxxInV4DK0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tg58QPDab6JvDlG2Spw+H9l/CTtL+10cYNinXY5icN2a/ULoWjxzSWLT63P+1WFCy
	 2uuf5Gjm7mBVO2W1HPSJyu6jNdkqGzXUecBQHn7vp27bzmpA2CBOeSRsH45Ei5Xf/t
	 jmCBAS2Nze3RJvQg7MwVzL0GlFM+vxZYq9ZzUY+g=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 62EE912863E2;
	Sat, 03 Aug 2024 13:51:43 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id yonQQw4LfAvJ; Sat,  3 Aug 2024 13:51:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722707503;
	bh=Y9Gkic50TrYVNl06FqGzpU/XQ/hwDYlSEjxxInV4DK0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tg58QPDab6JvDlG2Spw+H9l/CTtL+10cYNinXY5icN2a/ULoWjxzSWLT63P+1WFCy
	 2uuf5Gjm7mBVO2W1HPSJyu6jNdkqGzXUecBQHn7vp27bzmpA2CBOeSRsH45Ei5Xf/t
	 jmCBAS2Nze3RJvQg7MwVzL0GlFM+vxZYq9ZzUY+g=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C47D01286340;
	Sat, 03 Aug 2024 13:51:42 -0400 (EDT)
Message-ID: <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/8] tss: Fix handling of TPM_RH_NULL in intel-tss
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Date: Sat, 03 Aug 2024 13:51:40 -0400
In-Reply-To: <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
	 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
	 <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-08-03 at 20:08 +0300, Jarkko Sakkinen wrote:
> On Fri Aug 2, 2024 at 11:25 PM EEST, James Bottomley wrote:
> > Now that we're going to be using the NULL primary to salt sessions,
> > the Intel TSS shim needs fixing to cope with this.  In the Intel
> > TSS, there are two internal handles representing NULL: ESYS_TR_NONE
> > and ESYS_TR_RH_NULL.  We translate TPM_RH_NULL to ESYS_TR_NONE
> > because
> 
> Can you split this into two paragraphs.
> 
> I'm lost why it has two representations.

Well, I actually have no idea why the Intel TSS has two representations
for *every* handle: an internal one (specific to the TSS) and an
external one that everyone uses, like 81000001 or 40000007. As far as I
can see it just adds pointless complexity to the coding.  The IBM TSS
only has one, so for code which works with both, the shim has to
transform between internal and external handle representations before
sending the command onward to the Intel TSS.

Even more mysteriously the Intel TSS has three representations for the
NULL handle: an internal one, an external one (40000007) and one you
use for an empty session (ESYS_TR_NONE).  The IBM TSS uses TPM_RH_NULL
for all three so you can't just translate from external to internal you
have to know if you're using the handle for a session or a hierarchy as
well.

James



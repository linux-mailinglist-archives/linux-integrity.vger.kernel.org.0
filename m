Return-Path: <linux-integrity+bounces-3712-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA79886CC
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDAC1C22D62
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC3D18B1A;
	Fri, 27 Sep 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="elQfnAhx";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="elQfnAhx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B278467
	for <linux-integrity@vger.kernel.org>; Fri, 27 Sep 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446531; cv=none; b=Ux1iXwsOEo936PK576rS4MJ73y7eczXcN1GeH3GiwOJHmCm1sg1D8TsgXfAkRcxlrI7+kyCOmYOj1BmQ9VnRBX5Fba0JSz3TX6NN1Halz0ADOKD6L0Z4J1jCISzO//J9yZeG6Z1jgkVR6DcJnSdxhvnawd8+ji/Eu/jvK1orykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446531; c=relaxed/simple;
	bh=YpIEd/iReS6nIlB1ehVtLiIbtZUDQGWIJebh/76/gsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJ3MJJtS+e81hSMEjNLJs9y0JxLvvY9TuAmKGALbXdfHXoEsd4P/TCbdEa94MuTQVcDe9J6EChwtkGO5v2fYb6FRU+/i50A1IpIgnbs7jT4d3l7YJrl7ZKlGbXtPsistYcCO6F08d92iApgsO/qxyIg7YuX050K3NvBQ/tpAqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=elQfnAhx; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=elQfnAhx; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727446528;
	bh=YpIEd/iReS6nIlB1ehVtLiIbtZUDQGWIJebh/76/gsY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=elQfnAhxx7nZ0yQladjNhrEtoFyKuL8grjv+zzM0cAeVpdL/iwWFIVDlw+dWVXyhz
	 YtnBhqZyKIZ1MfRrAioQ9t/0Cs/1RCbHfUxKgwEHqtDLkgaE9V4pLBcQbwZJaSlLrN
	 7uG1Ff2WvFtEwDJ5a1hWYkrXbjs8WgshOL6y3ZLQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 83D621281997;
	Fri, 27 Sep 2024 10:15:28 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id D5X5PLxhL38t; Fri, 27 Sep 2024 10:15:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727446528;
	bh=YpIEd/iReS6nIlB1ehVtLiIbtZUDQGWIJebh/76/gsY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=elQfnAhxx7nZ0yQladjNhrEtoFyKuL8grjv+zzM0cAeVpdL/iwWFIVDlw+dWVXyhz
	 YtnBhqZyKIZ1MfRrAioQ9t/0Cs/1RCbHfUxKgwEHqtDLkgaE9V4pLBcQbwZJaSlLrN
	 7uG1Ff2WvFtEwDJ5a1hWYkrXbjs8WgshOL6y3ZLQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1960A1281943;
	Fri, 27 Sep 2024 10:15:26 -0400 (EDT)
Message-ID: <7025be516c4de1cbd8958c80242f503cc6e92c4a.camel@HansenPartnership.com>
Subject: Re: TPM HMAC (really) bad performance
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 27 Sep 2024 10:15:23 -0400
In-Reply-To: <d66af0d491f7576c7d865bf6de4da4c83cf0c3ba.camel@huaweicloud.com>
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
	 <d66af0d491f7576c7d865bf6de4da4c83cf0c3ba.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-27 at 15:53 +0200, Roberto Sassu wrote:
> On Fri, 2024-09-06 at 14:32 +0200, Roberto Sassu wrote:
> > Hi all
> > 
> > when running the benchmark on my new component, the Integrity
> > Digest
> > Cache, I ran into a serious performance issue.
> > 
> > The benchmark is extending a TPM PCR with 12313 entries of the IMA
> > measurement list, and calculating the time elapsed for the
> > operation.
> > 
> > Without TPM HMAC: 102.8 seconds
> > 
> > With TPM HMAC: 1941.71 seconds
> 
> Jarkko patch set [1] improved the performance:
> 
> 404.4 seconds
> 
> 
> Still quite slow.

So this is now the internal TPM overhead.  There's not much we can do
in the kernel to optimize that.  Your own figures were

> No HMAC:
> 
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
>  0)               |  tpm2_pcr_extend() {
>  0)   1.112 us    |    tpm_buf_append_hmac_session();
>  0) # 6360.029 us |    tpm_transmit_cmd();
>  0) # 6415.012 us |  }
> 
> 
> HMAC:
> 
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
>  1)               |  tpm2_pcr_extend() {
>  1)               |    tpm2_start_auth_session() {
>  1) * 36976.99 us |      tpm_transmit_cmd();
>  1) * 84746.51 us |      tpm_transmit_cmd();
>  1) # 3195.083 us |      tpm_transmit_cmd();
>  1) @ 126795.1 us |    }
>  1)   2.254 us    |    tpm_buf_append_hmac_session();
>  1)   3.546 us    |    tpm_buf_fill_hmac_session();
>  1) * 24356.46 us |    tpm_transmit_cmd();
>  1)   3.496 us    |    tpm_buf_check_hmac_response();
>  1) @ 151171.0 us |  }

or 6ms for no session extend vs 24ms for with session extend, so
effectively 4x slower, which is exactly what the above figures are also
showing.

>  We should consider not only the boot performance.
> Depending on the use case, IMA can be used after boot and slow down
> applications performance.

Right, but this is IMA fish or cut bait time: are you willing to pay a
4x penalty for improved security, bearing in mind that not all TPMs
will show the 4x slow down, since some have much better optimized
crypto routines.  If yes, we can simply keep the no flush optimization.
If no, we'd have to turn off security for IMA extends

Regards,

James



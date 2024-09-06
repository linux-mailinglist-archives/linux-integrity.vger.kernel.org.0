Return-Path: <linux-integrity+bounces-3488-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1896F6DA
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 16:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35CCB23E66
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E920E1D1730;
	Fri,  6 Sep 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LI/oPviD";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LI/oPviD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002D1C7B9B
	for <linux-integrity@vger.kernel.org>; Fri,  6 Sep 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633103; cv=none; b=dwMV0j81zn7YWPMapWR851e3EN6fnNRLLGpQm036klfziH+gQSU/Kf9sM3rfu4BsarfesuCAtE+T+k6GQ2VykmCnS/QPjyHsxUgwCHG2VUVOtChSMRSX8CxFxX/glFbfX76MnDGOUzcy8nVWRazfLYbQ8RuVwr68FDUA4bttVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633103; c=relaxed/simple;
	bh=8wR9DPbhiBBPkQRkLPJ0BC8RzrN/fj0J7XDsQJ+MVHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYTMS1ZOfhL85Enzg0WqIjT00ekmHjd/JEec8rt6KM3KIXFnq5+1S9kkQSAAfyeCrmBMPKKrj+j8FfVVld+LjzUJ5cz19UugFqe103zfR/XAPn/W8l220jPkoRya57Q5ThZ6nbvcbPwrHnOKNK8nzKMFoGWMD3BKjogN/YkRVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LI/oPviD; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LI/oPviD; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1725633100;
	bh=8wR9DPbhiBBPkQRkLPJ0BC8RzrN/fj0J7XDsQJ+MVHA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LI/oPviDFUfOshKxubAwPiJh9lYW19Y8A7iYrqUcdqUnBKElwY2BWy39nONO/buG/
	 ynWUXmc+VYpdGKt6wL3T+Qk8Dd7q6dz91kts5uGYTuoGBFmw/eAlwpwzEZmH8znkTQ
	 sgaLJ2ob/vNqfr8omVdMO0XGJkyFu38RHOGXI2GY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A4843128722A;
	Fri, 06 Sep 2024 10:31:40 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id at6XbOhRMGzq; Fri,  6 Sep 2024 10:31:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1725633100;
	bh=8wR9DPbhiBBPkQRkLPJ0BC8RzrN/fj0J7XDsQJ+MVHA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LI/oPviDFUfOshKxubAwPiJh9lYW19Y8A7iYrqUcdqUnBKElwY2BWy39nONO/buG/
	 ynWUXmc+VYpdGKt6wL3T+Qk8Dd7q6dz91kts5uGYTuoGBFmw/eAlwpwzEZmH8znkTQ
	 sgaLJ2ob/vNqfr8omVdMO0XGJkyFu38RHOGXI2GY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0874C12871AA;
	Fri, 06 Sep 2024 10:31:39 -0400 (EDT)
Message-ID: <a840582cb84e398f71c4dca218046961326d59d0.camel@HansenPartnership.com>
Subject: Re: TPM HMAC (really) bad performance
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 06 Sep 2024 10:31:38 -0400
In-Reply-To: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-06 at 14:32 +0200, Roberto Sassu wrote:
> Hi all
> 
> when running the benchmark on my new component, the Integrity Digest
> Cache, I ran into a serious performance issue.
> 
> The benchmark is extending a TPM PCR with 12313 entries of the IMA
> measurement list, and calculating the time elapsed for the operation.
> 
> Without TPM HMAC: 102.8 seconds
> 
> With TPM HMAC: 1941.71 seconds

I did worry about this and kept asking if anyone could benchmark

https://lore.kernel.org/linux-integrity/bd814edddfeac7072ed4f29365ce6bac3d235562.camel@HansenPartnership.com/

> Do you have already an idea on how to improve the situation?

One theory was that we could context save the session instead and this
might be faster but would also require degapping in the resource
manager.

James



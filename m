Return-Path: <linux-integrity+bounces-2940-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 656CD91C3DF
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2024 18:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061221F22129
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2024 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BF157A4D;
	Fri, 28 Jun 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kKuqxZ2F";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kKuqxZ2F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (unknown [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559AC14F136;
	Fri, 28 Jun 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592760; cv=none; b=QSC9W6AXImZDBEpmxSyi4B3nyUBlvtovM2lTgx/Bu/s1SzyPXjJMYNmXRMnWDiCVjqcs5GrPneky/87QeFRYgkVHzvKhxgoAArX6e3Tec9ce/IdLG7vJjgD5Jo6ntckJic6s4LGf5IcWO2MOKe1ogfniqksm5t6jnqqrrrmjDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592760; c=relaxed/simple;
	bh=ThX3VkL4XqWltRAEAJcGz6lQ6bV8PCB4b3rThe7Ub8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxZPQ345iIQ5abpYTx3uGcr7OyLrEY/WMeJfCITBUKzDZyXLi8ubPIr/ZTq6eMYI3Z/wu4vLsz2NvbjDeRMgGAu8ZC1CZrvxEmUQCTv85X3HuGyI0GJheHSstSpcaqf1RprzPaT17hNVYh/Yv6vGSaJXxoH1qNH6KWMpxJVRfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kKuqxZ2F; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kKuqxZ2F; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1719592751;
	bh=ThX3VkL4XqWltRAEAJcGz6lQ6bV8PCB4b3rThe7Ub8w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kKuqxZ2FfOivHhDKfZ2gxeX2q4n3qtKW39/16cd8rcoGQsFyHuVsnaEd1SbW0pBK/
	 a1BCnaGsetnT8G30ly+oTBaaY6RMsOse5J55tv3ZkbK1Vpt/eX30UWLXgUYiILV9EX
	 OZbMPQOmX94Qz9MlEuSe+lBRRB9g+Y3J8kFzh7qc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 89CD41280F5E;
	Fri, 28 Jun 2024 12:39:11 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id YjhWdUbX6P9N; Fri, 28 Jun 2024 12:39:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1719592751;
	bh=ThX3VkL4XqWltRAEAJcGz6lQ6bV8PCB4b3rThe7Ub8w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kKuqxZ2FfOivHhDKfZ2gxeX2q4n3qtKW39/16cd8rcoGQsFyHuVsnaEd1SbW0pBK/
	 a1BCnaGsetnT8G30ly+oTBaaY6RMsOse5J55tv3ZkbK1Vpt/eX30UWLXgUYiILV9EX
	 OZbMPQOmX94Qz9MlEuSe+lBRRB9g+Y3J8kFzh7qc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4EF451280728;
	Fri, 28 Jun 2024 12:39:10 -0400 (EDT)
Message-ID: <4108938158d888cc6ec371bb151e7ac35d3b4cb0.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Michael Ellerman <mpe@ellerman.id.au>, regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com, Stefan Berger
	 <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, jarkko@kernel.org
Date: Fri, 28 Jun 2024 12:39:08 -0400
In-Reply-To: <87pls1lwe0.fsf@mail.lhotse>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
	 <87pls1lwe0.fsf@mail.lhotse>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-06-28 at 10:54 +1000, Michael Ellerman wrote:
> Stefan Berger <stefanb@linux.ibm.com> writes:
> > Fix the following type of error message caused by a missing call to
> > tpm2_sessions_init() in the IBM vTPM driver:
> > 
> > [    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error
> > 0x01C4
> > [    2.987140] ima: Error Communicating to TPM chip, result: -14
> > 
> > Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
> > b/drivers/char/tpm/tpm_ibmvtpm.c
> > index d3989b257f42..1e5b107d1f3b 100644
> > --- a/drivers/char/tpm/tpm_ibmvtpm.c
> > +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> > @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev
> > *vio_dev,
> >                 rc = tpm2_get_cc_attrs_tbl(chip);
> >                 if (rc)
> >                         goto init_irq_cleanup;
> > +
> > +               rc = tpm2_sessions_init(chip);
> > +               if (rc)
> > +                       goto init_irq_cleanup;
> >         }
> >  
> >         return tpm_chip_register(chip);
> 
> #regzbot ^introduced: d2add27cf2b8 

Could you please test out the patch I proposed for this:

https://lore.kernel.org/linux-integrity/1302b413a2d7bf3b275133e7fdb04b44bfe2d5e3.camel@HansenPartnership.com/

Because it's not just tmp_ibmvtpm that doesn't call autostart.  From
inspection xen-tpmfront, tmp_nsc, tpm_infineon and tpm_atmel also
don't, so it would be better to fix this for everyone rather than just
for you and have to do a separate fix for each of them.

James



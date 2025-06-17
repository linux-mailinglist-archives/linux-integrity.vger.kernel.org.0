Return-Path: <linux-integrity+bounces-6458-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D5ADC4A9
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7B97A1BAE
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572CE23B62E;
	Tue, 17 Jun 2025 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7YeHmWF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B29211711
	for <linux-integrity@vger.kernel.org>; Tue, 17 Jun 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148766; cv=none; b=Sxx5vHjWIVG0I5uKK2SNnJS2bWGU1ZfSUdFnP/IJqNK+MSft4+I9k4pMQGx/SZL3gWWNp3N/5O1zkK9oQo2vKoSOyLXp1Wiqs2UPYmaj0KWs0NxH/PsQrUK2yoFg/XmQFJRWW8kvCy62H/A56cUNKqrcrUzbCv1+zhO0oD4TSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148766; c=relaxed/simple;
	bh=bHqL4d6hzjGnmPrz4kS7ZtPNmRF8JNeo69rBbGeyYMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r03bUXbIW7s8O+SeIaa+5w2YEyfy+yRPRMsxIXAPOuJnMoG9Q6KcoUSVdd4oMCOrsawR1sfqUb/1dt4UQ46sOYjRMc8Gvgedgf4/RjwWawVSjugkUbHB7YpD+MYlvm7mKEc+u7Z711HpWOoenAIGYBOAKGC3xB0f1YyY/KtiVzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7YeHmWF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750148763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tuESWdgQF0sreM50+xMhPqu+zRbHva+ThYdTCQTTky8=;
	b=B7YeHmWFWJDxd921vDcV0iOtYoi3Y5b9tJRLnzJWuIRQlc3CdrsVcLhhzyVMTeCOGMbmWw
	fjd2AJO1pNW9l1sy3LGPDLptJYkt9iE7pL0Kkwlr2T8gbaz+q56D90fkod5oEhldAaDeln
	IqibQ2qLM+IWyi5gVn4wyihBikU5rRo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-pQNieNqsM8eGs0Z9CKa3gg-1; Tue,
 17 Jun 2025 04:26:00 -0400
X-MC-Unique: pQNieNqsM8eGs0Z9CKa3gg-1
X-Mimecast-MFC-AGG-ID: pQNieNqsM8eGs0Z9CKa3gg_1750148759
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6FD91809C8F;
	Tue, 17 Jun 2025 08:25:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C95B819560A3;
	Tue, 17 Jun 2025 08:25:56 +0000 (UTC)
Date: Tue, 17 Jun 2025 16:25:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	coxu@redhat.com, piliu@redhat.com, pmenzel@molgen.mpg.de,
	chenste@linux.microsoft.com, kexec@lists.infradead.org
Subject: Re: [PATCH v3] ima: add a knob ima= to allow disabling IMA in kdump
 kernel
Message-ID: <aFEmj7ZuuMgOplZK@MiWiFi-R3L-srv>
References: <20250614022342.5988-1-bhe@redhat.com>
 <ca82fa443365217535aedacbcdf823370f387995.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca82fa443365217535aedacbcdf823370f387995.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/16/25 at 10:04am, Mimi Zohar wrote:
> On Sat, 2025-06-14 at 10:23 +0800, Baoquan He wrote:
> > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> > extra memory. It would be very helpful to allow IMA to be disabled for
> > kdump kernel.
> > 
> > Hence add a knob ima=on|off here to allow turning IMA off in kdump
> > kernel if needed.
> > 
> > Note that this IMA disabling is limited to kdump kernel, please don't
> > abuse it in other kernel and thus serious consequences are caused.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> > - Remove rdundant word 'only' and rephrase sentences in patch log code
> >   comment, and rephrase patch subject, thanks to Mimi's comments.
> 
> Thanks, Baoquan.  The patch is now queued.

Thanks a lot for your patience, careful reviewing and great suggestions.



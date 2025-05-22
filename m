Return-Path: <linux-integrity+bounces-6291-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F2AC02D3
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 05:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205EC1B66CEB
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540B1531E9;
	Thu, 22 May 2025 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1OcNt0b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7814A0A8
	for <linux-integrity@vger.kernel.org>; Thu, 22 May 2025 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747884271; cv=none; b=Bo0cYx6xi+pvyxGC5r156d9kNbQZx2NifgyR+qJjP+UziYkBV6S3jA1e0QNRpyIFAmkyOtnBIBTc/xMqeNApjGV47cSze31tqJNMpF90qtoY35Kx0diUVC5NttXTnyMd6kBG+mB2gTgqnOB2X5pwbBcg2d2EFdR3iOA79oFLEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747884271; c=relaxed/simple;
	bh=wDKUKOvuZiIsXBV7oI1I/zbaXpEd9HOGbHO7kI1RbM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw6+5RFGpfu7KekxzP+yaDIcuQWWE7xLj4MWwBnLkN0iyDls4gQrn7x0/WBT4z8nnQ4FQNDMjsd5dHssK3oGkBSUoGoAQEVsDbXHDY2HlpkxeM/DBgvesynZ9kSF/pVCod7vEYi7iNnljblggwGX2BTkoJlPx2oTqW6mW0ZWDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1OcNt0b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747884268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NHK1vKyf9FKDgti3HXT6gv903PyEoUwrQudAnu4zik=;
	b=M1OcNt0bd9rMmZrmsS16FxQySbYyim5vSz6tVB4vmJRIzJUfRunM/dU4xUBzkbZ5wvfu7L
	z5dmGAHce/0leEaYOt0A2KUJ1Xs7g+0oG03sB/+BvKhHBvDScC8y5DVyLOL2EpIR/O8T8U
	EDy9+0E0rUdE8izHS+FeJC3aprUOC+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-bTLkcJn9PpK0UXXLRcp43g-1; Wed,
 21 May 2025 23:24:22 -0400
X-MC-Unique: bTLkcJn9PpK0UXXLRcp43g-1
X-Mimecast-MFC-AGG-ID: bTLkcJn9PpK0UXXLRcp43g_1747884261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 436C518003FC;
	Thu, 22 May 2025 03:24:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0149118003FC;
	Thu, 22 May 2025 03:24:17 +0000 (UTC)
Date: Thu, 22 May 2025 11:24:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
	coxu@redhat.com, ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 05/21/25 at 08:54am, Mimi Zohar wrote:
> On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> > CC kexec list.
> > 
> > On 05/16/25 at 07:39am, Baoquan He wrote:
> > > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> > > extra memory. It would be very helpful to allow IMA to be disabled for
> > > kdump kernel.

Thanks a lot for careufl reviewing and great suggestions.

> 
> The real question is not whether kdump needs "IMA", but whether not enabling
> IMA in the kdump kernel could be abused.  The comments below don't address
> that question but limit/emphasize, as much as possible, turning IMA off is
> limited to the kdump kernel.

Are you suggesting removing below paragraph from patch log because they
are redundant? I can remove it in v2 if yes.

> 
> > > 
> > > And Coiby also mentioned that for kdump kernel incorrect ima-policy loaded
> > > by systemd could cause kdump kernel hang, and it's possible the booting
> > > process may be stopped by a strict, albeit syntax-correct policy and users
> > > can't log into the system to fix the policy. In these cases, allowing to
> > > disable IMA is very helpful too for kdump kernel.
> > > 
> > > Hence add a knob ima=on|off here to allow people to disable IMA in kdump
> > > kenrel if needed.
> 
> ^kernel

Will change.

> 
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  5 +++++
> > >  security/integrity/ima/ima_main.c             | 22 +++++++++++++++++++
> > >  2 files changed, 27 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > > b/Documentation/admin-guide/kernel-parameters.txt
> > > index d9fd26b95b34..762fb6ddcc24 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -2202,6 +2202,11 @@
> > >  			different crypto accelerators. This option can be
> > > used
> > >  			to achieve best performance for particular HW.
> > >  
> > > +	ima=		[IMA] Enable or disable IMA
> > > +			Format: { "off" | "on" }
> > > +			Default: "on"
> > > +			Note that this is only useful for kdump kernel.
> 
> Instead of "useful" I would prefer something clearer like "limited".

Makes sense, will change.

> 
> > > +
> > >  	init=		[KNL]
> > >  			Format: <full_path>
> > >  			Run specified binary instead of /sbin/init as
> > > init
> > > diff --git a/security/integrity/ima/ima_main.c
> > > b/security/integrity/ima/ima_main.c
> > > index f3e7ac513db3..07af5c6af138 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/fs.h>
> > >  #include <linux/iversion.h>
> > >  #include <linux/evm.h>
> > > +#include <linux/crash_dump.h>
> > >  
> > >  #include "ima.h"
> > >  
> > > @@ -38,11 +39,27 @@ int ima_appraise;
> > >  
> > >  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
> > >  static int hash_setup_done;
> > > +static int ima_disabled;
> 
> Like the ima_hash_algo variable definition above, ima_disabled should be
> defined as __ro_after_init.

Will add __ro_after_init.

> 
> > >  
> > >  static struct notifier_block ima_lsm_policy_notifier = {
> > >  	.notifier_call = ima_lsm_policy_change,
> > >  };
> > >  
> > > +static int __init ima_setup(char *str)
> > > +{
> 
> is_kdump_kernel() should also be called here, before the tests below. 
> Something like:
> 
> +       if (!is_kdump_kernel()) {
> +               pr_info("Warning ima setup option only permitted in kdump");
> +               return 1;
> +       }

Sure, will change as suggested.

> 
> > > +	if (strncmp(str, "off", 3) == 0)
> > > +		ima_disabled = 1;
> > > +	else if (strncmp(str, "on", 2) == 0)
> > > +		ima_disabled = 0;
> > > +	else
> > > +		pr_err("Invalid ima setup option: \"%s\" , please specify
> > > ima=on|off.", str);
> > > +
> > > +	return 1;
> > > +}
> > > +__setup("ima=", ima_setup);
> > > +
> > > +
> > > +
> 
> Remove the extraneous blank line.

sure.

> 
> > >  static int __init hash_setup(char *str)
> > >  {
> > >  	struct ima_template_desc *template_desc =
> > > ima_template_desc_current();
> > > @@ -1184,6 +1201,11 @@ static int __init init_ima(void)
> > >  {
> > >  	int error;
> > >  
> > > +	if (ima_disabled && is_kdump_kernel()) {
> > > +		pr_info("IMA functionality is disabled");
> > > +		return 0;
> > > +	}
> > > +
> 
> Even with the additional call to is_kdump_kernel() in ima_setup, please keep
> the is_kdump_kernel() test here as well.  Even though the code is self
> describing, please add a one line comment emphasizing disabling IMA is limited
> to kdump.

OK, will keep code here as this v1 is and add one line of comment at
above.

Thanks again.

> 
> > >  	ima_appraise_parse_cmdline();
> > >  	ima_init_template_list();
> > >  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > > -- 
> > > 2.41.0
> > > 
> > 
> > 
> 
> thanks,
> 
> Mimi
> 



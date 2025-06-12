Return-Path: <linux-integrity+bounces-6445-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE78AD6ED1
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E7B3A5476
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0944CEC2;
	Thu, 12 Jun 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEDJOBfZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D87231845
	for <linux-integrity@vger.kernel.org>; Thu, 12 Jun 2025 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727131; cv=none; b=Ioj0lhJt1HfPvVoU9K5eDSBv1X8zb7wcgoD4a7+qvbzp2LNeZTCMxGizI0n23ePVhqvE/f3tR1yaLenLwbVEflGCz0GTTUks7clwN3tdX1BehNJ8ytJ+Rsp8nOsMdnZoXL2kIYc9uqORhTnHRWyFCP5XSArSiL4/7bIPhEeCEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727131; c=relaxed/simple;
	bh=3JjbhQubAgFcC97e/UoQ9hKiqpfIzqZGcS7aEKOfAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvkwFyLTJC/FVeJNul7DuMklgAx27VciaaR9rd8+ClPEoQDk4RfwPzLF1Z6FP76QzQhJTYRU4u2RttFBtTNCXzUT5/+deiD90xR9JKEwy/vd1NlOsRFEz4x7vmLRFTgM8WTCd23YCEZsmYEme/WefJwib8EBGbpunU2L8c1P8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEDJOBfZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749727129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7T84xXSWCXYbJ0BcRNBZS+rZcumc2YBPF5dRlJgvCIQ=;
	b=MEDJOBfZyG25IE+p9qjIS59GgUzgByWRoPy1D1fgNpNO+cP59QYEtDZVechHJB5DQFMpM8
	re8e7LLCz0IdrByETtoZ6SXPVrVPdtB4M1bGonoOpg1aW0VnibXHgLzJ/YvrNyHNkFdv7D
	TYfoE5asgSGvnCzDQdtgli5Pe43m4Y8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-oLHAgfETPii7mcF4IS4JBw-1; Thu,
 12 Jun 2025 07:18:45 -0400
X-MC-Unique: oLHAgfETPii7mcF4IS4JBw-1
X-Mimecast-MFC-AGG-ID: oLHAgfETPii7mcF4IS4JBw_1749727124
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C725E1800292;
	Thu, 12 Jun 2025 11:18:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34D00180045C;
	Thu, 12 Jun 2025 11:18:41 +0000 (UTC)
Date: Thu, 12 Jun 2025 19:18:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	coxu@redhat.com, piliu@redhat.com, pmenzel@molgen.mpg.de,
	chenste@linux.microsoft.com
Subject: Re: [PATCH v2] ima: add a knob ima= to make IMA be able to be
 disabled
Message-ID: <aEq3jZp4Cbta8+Ms@MiWiFi-R3L-srv>
References: <20250611082535.127759-1-bhe@redhat.com>
 <c1ad06ef84170633bdcc7f49b06d646ddbbdc763.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ad06ef84170633bdcc7f49b06d646ddbbdc763.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 06/12/25 at 06:59am, Mimi Zohar wrote:
> Hi Baoquan,
> 
> As discussed
> https://lore.kernel.org/linux-integrity/aC6ezNcUZ%2FulKgpv@MiWiFi-R3L-srv/ the
> Subject line should indicate disabling IMA is limited to kdump.

Oops, my bad, I forgot this one.

> 
> On Wed, 2025-06-11 at 16:25 +0800, Baoquan He wrote:
> > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> > extra memory. It would be very helpful to allow IMA to be disabled for
> > kdump kernel.
> > 
> > Hence add a knob ima=on|off here to allow turning IMA off in kdump
> > kernel if needed.
> > 
> > Note that this IMA disabling is only limited to kdump kernel, please don't
> > abuse it in other kernel and thus serious consequences are caused.
> 
> Remove the word 'only', here, and in other places.

Sure, will udpate in all relevant places. Thanks.

> 
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v1->v2:
> > - Improve patch log and doc description;
> > - Make slight adjustment in code; 
> > These are all made according to Mimi's great suggestions. 
> > 
> >  .../admin-guide/kernel-parameters.txt         |  5 ++++
> >  security/integrity/ima/ima_main.c             | 26 +++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index b3d62f4c370a..1de67b9c20b4 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2214,6 +2214,11 @@
> >  			different crypto accelerators. This option can be used
> >  			to achieve best performance for particular HW.
> >  
> > +	ima=		[IMA] Enable or disable IMA
> > +			Format: { "off" | "on" }
> > +			Default: "on"
> > +			Note that this is only limited to kdump kernel.
> 
> Remove the word 'only' ->  Note that disabling IMA is limited to kdump kernel.
> 
> > +
> >  	indirect_target_selection= [X86,Intel] Mitigation control for Indirect
> >  			Target Selection(ITS) bug in Intel CPUs. Updated
> >  			microcode is also required for a fix in IBPB.
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index f99ab1a3b0f0..c38f3881d72f 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/iversion.h>
> >  #include <linux/evm.h>
> > +#include <linux/crash_dump.h>
> >  
> >  #include "ima.h"
> >  
> > @@ -38,11 +39,30 @@ int ima_appraise;
> >  
> >  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
> >  static int hash_setup_done;
> > +static int ima_disabled __ro_after_init;
> >  
> >  static struct notifier_block ima_lsm_policy_notifier = {
> >  	.notifier_call = ima_lsm_policy_change,
> >  };
> >  
> > +static int __init ima_setup(char *str)
> > +{
> > +	if (!is_kdump_kernel()) {
> > +		pr_info("Warning: ima setup option only permitted in kdump");
> > +		return 1;
> > +	}
> > +
> > +	if (strncmp(str, "off", 3) == 0)
> > +		ima_disabled = 1;
> > +	else if (strncmp(str, "on", 2) == 0)
> > +		ima_disabled = 0;
> > +	else
> > +		pr_err("Invalid ima setup option: \"%s\" , please specify ima=on|off.", str);
> > +
> > +	return 1;
> > +}
> > +__setup("ima=", ima_setup);
> > +
> >  static int __init hash_setup(char *str)
> >  {
> >  	struct ima_template_desc *template_desc = ima_template_desc_current();
> > @@ -1186,6 +1206,12 @@ static int __init init_ima(void)
> >  {
> >  	int error;
> >  
> > +	/*Note that turning IMA off is only limited to kdump kernel.*/
> 
> Remove the word "only"  -> Note that turning IMA off is intentionally limited to
> kdump kernel."
> 
> > +	if (ima_disabled && is_kdump_kernel()) {
> > +		pr_info("IMA functionality is disabled");
> > +		return 0;
> > +	}
> > +
> >  	ima_appraise_parse_cmdline();
> >  	ima_init_template_list();
> >  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> 
> Mimi
> 



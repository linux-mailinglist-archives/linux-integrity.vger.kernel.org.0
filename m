Return-Path: <linux-integrity+bounces-4860-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CBEA3921C
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 05:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B971693E6
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 04:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463B1A9B53;
	Tue, 18 Feb 2025 04:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqzHfcrK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E31A5BA4
	for <linux-integrity@vger.kernel.org>; Tue, 18 Feb 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739852660; cv=none; b=DujsCePJVivAOOsc1Wf9VhMN9gH5fKFlzRW0P6Xc6m6L4cFattqSkiJtnsDr/k1x1qDpizdDq93+vxmWu+9A0zwCcfCGIVp/UG9iI+KQ77lqajU+nR+do+3VnRuGgfe0/oT4qn3+zbXNT5178r8uBrKfm1R5boErs/OMY0w6vQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739852660; c=relaxed/simple;
	bh=vUp2f0dUGzyNdCIXClkjciqVJywiWEkvB8XutnkK1a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy4usL2ETXE3KgZAbKXAylWi9jD0vs/oYGPYPpYd6oqO3O+XG6uuRdwRXxo9jFR1wRENUDWsU6+8pyR308kGISkjQNAxgz6UeBAldkSLohrsObgjYgaSr2IiC8It/FEQJHwuZ/QW+FYJLjjpOhBifhCtRE1Bc8DbI+/mURF6hf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqzHfcrK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739852657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEVwY6828gii5G/EHkyb4svsHTFTS04m4XYv3raJ3OY=;
	b=JqzHfcrKwplR23BuAlXP9wdwAqDwvqS+GZRPh7Bv/dF5FLK7+WFhBaRwnMKIZWXeh5nCVD
	8rjWlmRJVWI38grlETPxwqsnxRrFNglGF5z3jvw0Q1e1/3pIzlHGKtSbvEPtWqpxjl6QY6
	zyJ8WsuPu510WKorxe6aNJLQtCeJSSs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-fzAP0MCyPn2tE5cfF2uWcA-1; Mon,
 17 Feb 2025 23:24:12 -0500
X-MC-Unique: fzAP0MCyPn2tE5cfF2uWcA-1
X-Mimecast-MFC-AGG-ID: fzAP0MCyPn2tE5cfF2uWcA_1739852650
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00B6B180056F;
	Tue, 18 Feb 2025 04:24:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61F6D19560AA;
	Tue, 18 Feb 2025 04:24:05 +0000 (UTC)
Date: Tue, 18 Feb 2025 12:24:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v7 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z7QLYd5ZFmQuV8Gx@MiWiFi-R3L-srv>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-3-chenste@linux.microsoft.com>
 <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
 <47565966-c735-4758-80a5-523fd93adc72@linux.microsoft.com>
 <b7dd78f21a9fa9dc3b6f90eae2668cfe5c7670c7.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7dd78f21a9fa9dc3b6f90eae2668cfe5c7670c7.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 02/12/25 at 08:03am, Mimi Zohar wrote:
> On Mon, 2025-02-10 at 09:06 -0800, steven chen wrote:
> > On 2/7/2025 11:15 AM, Mimi Zohar wrote:
> > > Hi Steven,
> > > 
> > > On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> > > > Currently, the mechanism to map and unmap segments to the kimage
> > > > structure is not available to the subsystems outside of kexec.  This
> > > > functionality is needed when IMA is allocating the memory segments
> > > > during kexec 'load' operation.  Implement functions to map and unmap
> > > > segments to kimage.
> > > > 
> > > > Implement kimage_map_segment() to enable mapping of IMA buffer source
> > > > pages to the kimage structure post kexec 'load'.  This function,
> > > > accepting a kimage pointer, an address, and a size, will gather the
> > > > source pages within the specified address range, create an array of page
> > > > pointers, and map these to a contiguous virtual address range.  The
> > > > function returns the start of this range if successful, or NULL if
> > > > unsuccessful.
> > > > 
> > > > Implement kimage_unmap_segment() for unmapping segments
> > > > using vunmap().
> > > > 
> > > > From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > I don't recall previously adding my "Reviewed-by" tag.
> > > 
> > > Eric, I'd appreciate your reviewing this and the subsequent patch "[PATCH v7 3/7]
> > > ima: kexec: skip IMA segment validation after kexec soft reboot" in particular.
> > Hi Eric, Could you help to review this patch as Mimi mentioned? Thanks!
> > > 
> > > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Steven, since these patches impact kdump, before re-posting the patch set, please
> include the following tags before your Signed-off-by tag on the kexec patches.

Thanks, Mimi.

Yes, Steven, please add me in CC when reposting. Thanks in advance.

I will check this version to see if there's impact on kexec/kdump
from my side.

And by the way, kdump should not need IMA, it's better be disabled by
default. I will have a look and try disabling it in kdump kernel, while
really appreciate it if any IMA expert can do it.

Thanks
Baoquan



Return-Path: <linux-integrity+bounces-5010-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B7DA490B3
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 06:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90AD3A9D23
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 05:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488A1BBBEB;
	Fri, 28 Feb 2025 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGNjYhP4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0DB1BBBD7
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719016; cv=none; b=XSmCfORpu/bfHN3lCMmdC8ICP5F4aLEsyvZ3W+TDP9gt939FjoK4DjEa89AZ8YzVzQCbi5WgyCuMRA1z5nv0p0BHm6girH9cCMXQ30PE2+deDU2vJrrx1WwJkZsUZK13CJVzWbNzYiE8am0pjTuw3ACQk2ln5/3wy9gfC/j+BOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719016; c=relaxed/simple;
	bh=4qgnoU2IzYG+runO5deGQ34JtoBImTWSSSAIltL6Cds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTYwm/5Ygxqxdac7uGDVtdRaeuoLmizNAMqcg6f1w220qdDXXHvFdIFDBpq1zimQaS4DveikKMJ/q9hgRkjWUSHwNM4Jph4ekQp3QCI1/QCCqs+gAOdnlRBsxZvHyXmi8tqHfddGJhoywXxdyISwv7gNcBfq2Asc6N+OQt1aEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGNjYhP4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740719014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rWEuJNQK68ECdNdbzEIN/CxByzhoyQY+jPP6y/Lhd0=;
	b=HGNjYhP4K+LntEnmtMdsjhMS8LjDpGNH0fV+jXLm9vJiOTpOwyAAkTj6u+8yx3e64BHMvc
	cclAJJBgp7tsD8aywSzA7c1eDTWNzwEUdsdeIMrZWcaQwZlIzsLRfIOKURW0hrQgJllEBK
	5AiMyysHhxAI3YtPjKOBBZmCXPYXMbg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-tLxX70tNO6O3fin0MZsonQ-1; Fri,
 28 Feb 2025 00:03:29 -0500
X-MC-Unique: tLxX70tNO6O3fin0MZsonQ-1
X-Mimecast-MFC-AGG-ID: tLxX70tNO6O3fin0MZsonQ_1740719006
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF7A21800876;
	Fri, 28 Feb 2025 05:03:25 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D92E19560B9;
	Fri, 28 Feb 2025 05:03:22 +0000 (UTC)
Date: Fri, 28 Feb 2025 13:03:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com, Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z8FDlp8QvnSR58Vd@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
 <55acf768b52b47dd9d33fa0486772d8c7ae38779.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55acf768b52b47dd9d33fa0486772d8c7ae38779.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 02/27/25 at 10:41am, Mimi Zohar wrote:
> [Cc'ing Mike Rapoport]
> 
> On Mon, 2025-02-24 at 14:14 +0800, Baoquan He wrote:
> > Hi Steve, Mimi,
> > 
> > On 02/18/25 at 02:54pm, steven chen wrote:
> > > Currently, the mechanism to map and unmap segments to the kimage
> > > structure is not available to the subsystems outside of kexec.  This
> > > functionality is needed when IMA is allocating the memory segments
> > > during kexec 'load' operation.  Implement functions to map and unmap
> > > segments to kimage.
> > 
> > I am done with the whole patchset understanding. My concern is if this
> > TPM PCRs content can be carried over through newly introduced KHO. I can
> > see that these patchset doesn't introduce too much new code changes,
> > while if many conponents need do this, kexec reboot will be patched all
> > over its body and become ugly and hard to maintain.
> > 
> > Please check Mike Rapoport's v4 patchset to see if IMA can register
> > itself to KHO and do somthing during 2nd kernel init to restore those
> > TPM PCRs content to make sure all measurement logs are read correctly.
> > [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
> 
> Hi Baoquan,
> 
> I was hoping to look at Mike's patch set before responding, but perhaps it is
> better to respond earlier rather than later with my initial thoughts.
> 
> The IMA measurement list isn't stored in contiguous memory, but has to be
> marshalled before being carried across kexec, and then unmarshalled to restore
> it after the kexec.  Roberto Sassu has been thinking about changing how the IMA
> measurement list is stored so marshalling/unmarshalling wouldn't be necessary. 
> Making both this change and using KHO going forward would be a good idea.
> 
> However, that sort of change wouldn't be appropriate to backport.  So the
> question comes down to whether being unable to attest the measurement list,
> because the measurements are copied too early at kexec load, but the TPM is
> being extended through kexec exec, is considered a bug.  If that is the case,
> then I suggest finish cleaning up and upstreaming this patch set so that it
> could be backported.

Ah, I understand your concern. There are stable kernels or distros
kernels which need be taken care of. If then, we can continue to work on
polishing this patchset, as you have pointed out, there are still room
in this patchset to improve before merging.



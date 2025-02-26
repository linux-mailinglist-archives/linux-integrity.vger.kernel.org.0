Return-Path: <linux-integrity+bounces-4988-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34946A4519D
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 01:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755401896E79
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC66C13B293;
	Wed, 26 Feb 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GudRu/hJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA23B19A
	for <linux-integrity@vger.kernel.org>; Wed, 26 Feb 2025 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530416; cv=none; b=WzBtLSVUrhUsxS2s4Iucav12nxG0gAh8QvOF11iDPDogW7VcV7Tx5em9mBv3Vap8TxHgpzXaXNnr1VlwTTTsNnaFuiVkuqBknGVj8PcanyHxXfFnrgcFYdK5b60X4DOT1MBEVRnjIyjrUpm9AL3LRD2vCLGoviip92cAoKhl1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530416; c=relaxed/simple;
	bh=uk2Uim0gU+hjB0BMRQBeSM98fROd/0txsPkca7sCdbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgyC8VjHpNtzLusJNgWk/4H01raFlDpdtH/ncsmUj3MuRTMTXO9jDkN+S9pbHNQpfVcmcedX88a5pMNtuEdYgqVYbG+7ie8laL9O2isjAE1NVMDtqcI9TjRO2kPOYZoGe0LkXo14YY1KNiEnI27BtHVznQCRVDsXJVYP3AU0bAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GudRu/hJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740530413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/fLOI8OoddJLVPbWF8PdboZeiEPg5BhgTCWlbYEUGLE=;
	b=GudRu/hJjK5P9q7AOo99AbLmZMKbXpmV4DUF/+UpjpCF2gKP6IdiIXga0jBOu3+M1C8rDL
	MZMQPDW2AtPiUghxT4sJ7fDkMP27uiN57RFHr+Q86f9uShYePNAhiw27VYwirB02YrIRGA
	gSKfbTwIHJreasvQ5blPNVKD+H/PKx8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540--42mYKK8MTS4avnePE08_Q-1; Tue,
 25 Feb 2025 19:40:10 -0500
X-MC-Unique: -42mYKK8MTS4avnePE08_Q-1
X-Mimecast-MFC-AGG-ID: -42mYKK8MTS4avnePE08_Q_1740530408
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24DDB180087A;
	Wed, 26 Feb 2025 00:40:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFD39300018D;
	Wed, 26 Feb 2025 00:40:03 +0000 (UTC)
Date: Wed, 26 Feb 2025 08:39:59 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z75i31INh5DAfW+R@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
 <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
 <Z70MZD+BssRG4R1H@MiWiFi-R3L-srv>
 <8504fd93-8fff-4fd9-8d2d-26b4e1e84bee@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8504fd93-8fff-4fd9-8d2d-26b4e1e84bee@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02/25/25 at 10:35am, steven chen wrote:
> On 2/24/2025 4:18 PM, Baoquan He wrote:
> > On 02/24/25 at 03:05pm, steven chen wrote:
> > > On 2/23/2025 10:14 PM, Baoquan He wrote:
> > > > Hi Steve, Mimi,
> > > > 
> > > > On 02/18/25 at 02:54pm, steven chen wrote:
> > > > > Currently, the mechanism to map and unmap segments to the kimage
> > > > > structure is not available to the subsystems outside of kexec.  This
> > > > > functionality is needed when IMA is allocating the memory segments
> > > > > during kexec 'load' operation.  Implement functions to map and unmap
> > > > > segments to kimage.
> > > > I am done with the whole patchset understanding. My concern is if this
> > > > TPM PCRs content can be carried over through newly introduced KHO. I can
> > > > see that these patchset doesn't introduce too much new code changes,
> > > > while if many conponents need do this, kexec reboot will be patched all
> > > > over its body and become ugly and hard to maintain.
> > > > 
> > > > Please check Mike Rapoport's v4 patchset to see if IMA can register
> > > > itself to KHO and do somthing during 2nd kernel init to restore those
> > > > TPM PCRs content to make sure all measurement logs are read correctly.
> > > > [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
> > > > 
> > > > Thanks
> > > > Baoquan
> > > Hi Baoquan,
> > > 
> > > For IMA, it appears that there are no current issues with TPM PCRs after a
> > > kernel soft reboot.
> > I mean using KHO to hold in 1st kernel and restore the IMA log in 2nd
> > kernel.
> > 
> > > This patches is used to get currently missed IMA measurements during the
> > > kexec process copied to new kernel after the kernel soft reboot. I think
> > > it's ok to leave it at current location: it will be easy to maintain for
> > > IMA.
> > Yeah, but I am saying this patchset increase unnecessary code
> > complexity in kexec code maintaining.
> > 
> > > Overall, for these patches, do you see any major blockers for kexec?
> > > 
> > > If you have any specific concerns or need further details, please let me
> > > know.
> > I have no concerns for this patchset implementation itself, I saw you using
> > vmap to maping the possible scattered source pages smartly and taking
> > the mapped buffer pointers to update later duing kexec jumping. That's very
> > great and clever method. BUT I am concerned about the solution, if we
> > can make use of the existed way of KHO to implement it more simply. Could
> > you please do investigation?
> 
> Hi Baoquan,
> 
> I will conduct an investigation. Thank you for your comments.

Thanks a lot, Steven.



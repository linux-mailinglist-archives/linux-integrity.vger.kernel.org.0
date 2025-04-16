Return-Path: <linux-integrity+bounces-5911-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF8A8AE67
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 05:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A94E7AAF31
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 03:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791C215CD55;
	Wed, 16 Apr 2025 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6PU+hG+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58BBA49
	for <linux-integrity@vger.kernel.org>; Wed, 16 Apr 2025 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744773784; cv=none; b=CaVr6aHtHFi52n0MYPo/D0meCZw+qG6bqGop3S60AozWBXdaRsPLga1PE0jBEJkE05/dM4BncWNOktd8yAGpSLuAKq1scrdzKLtdO8e4zwEkQb1hQeC+bURRPfRwVQ00+WDjZ6yhgMKvd1TWuiJ4c6JLVF3fgTrZwGpMvPHlB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744773784; c=relaxed/simple;
	bh=nw+YY0p6lX31X6yZILHFPBwjrXvn/ylgu+GzqgQL3BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV3fkRJ82T0WtCKZDG8fTbDY3JKtXbCTFyBYwgG3gl2QDQ4HpNg6Jc19H6IV2i227PQsnjotb6bup3z7vr9Jjx1uiIjoH35JQwbMzOFqjNLvPki5aukB31vJDwPHnR2aue00hhZlqDgurn5yGUdWYKSlaf0V/75Sz0O4u90vg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6PU+hG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744773781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSUrpdlFst4zUoEQ0PmRqqZ4BUa3aoPhJxPxerV9mYM=;
	b=E6PU+hG+sv42FU1RZe/rGixEbaqE06gzO39sY/OfT8abZ5BVtPO07Z8PFZj9NgcfYBCp3c
	1H3U/2R15zfHgvLnsc/7Zc9fKF3qNIXPPA6dElLGA++U4euaXap2770Fp9Hi20xuPoVZwk
	OoZTt5BiacMidv12rxKVw//gaTcL/B0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-jZrM28liOaqoT1eK1lmHhg-1; Tue,
 15 Apr 2025 23:22:59 -0400
X-MC-Unique: jZrM28liOaqoT1eK1lmHhg-1
X-Mimecast-MFC-AGG-ID: jZrM28liOaqoT1eK1lmHhg_1744773778
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73A2E180035E;
	Wed, 16 Apr 2025 03:22:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 084C4180176A;
	Wed, 16 Apr 2025 03:22:56 +0000 (UTC)
Date: Wed, 16 Apr 2025 11:22:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Coiby Xu <coxu@redhat.com>
Cc: chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
References: <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/09/25 at 11:40am, Mimi Zohar wrote:
> On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
......snip.. 
> > Thanks for confirming. I will consider how to fix it accordingly. Maybe
> > after Steven's patches are merged. That would be great if the buffer
> > allocating and storing can be skiped for kdump in Steven's patch. While
> > I am worried that could disrupt the progress of Steven's patches.
> 
> Agreed, let's get Steven's patch set upstreamed and then make the kdump
> exceptions.
> 
> - "ima: kexec: move IMA log copy from kexec load to execute" looks like it isn't
> copying the IMA measurement list records (kexec_post_load), but the memory for
> the IMA measurement list is being allocated (ima_alloc_kexec_file_buf).
> 
> - Do you really want to totally disable IMA for kdump or would disabling IMA-
> measurement be sufficient?  Remember there's already an option to disable IMA-
> appraisal.  Disabling just IMA-measurement would allow IMA-appraisal to continue
> to work.  Meaning based on policy the integrity of files - executables, kernel
> image, etc - could still be verified.
> 
> Without IMA-measurement:
> - No adding records to the IMA measurement list
> - No IMA measurement list pseudo securityfs files
> - No extending the TPM
> 
> With IMA-appraisal:
> - Integrity verification of files based on keys, keyrings
> - Loading keys

Currently, Kdump has no demand to do integrity verification based on
keys, keyrings, except of Coiby's LUKS support in kdump:

[PATCH v8 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
https://lore.kernel.org/all/20250207080818.129165-1-coxu@redhat.com/T/#u

I have talked to Coiby, he will do some investigations to see if loading
keys related to IMA or IMA-appraisal functionality is related to LUKS
support in kdump because the LUKS support in kdump also needs
store/restore keys/keyrings between normal kernel and kdump kernel.

> 
> Obviously my preference would be to add support to disable IMA-measurement in a
> kdump environment.
> 
> thanks,
> 
> Mimi
> 



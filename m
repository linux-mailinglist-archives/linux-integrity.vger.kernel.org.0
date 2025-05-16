Return-Path: <linux-integrity+bounces-6243-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C5AB94C8
	for <lists+linux-integrity@lfdr.de>; Fri, 16 May 2025 05:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFFB7B1B68
	for <lists+linux-integrity@lfdr.de>; Fri, 16 May 2025 03:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4F25D8F7;
	Fri, 16 May 2025 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+8oDI3d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADB25C829
	for <linux-integrity@vger.kernel.org>; Fri, 16 May 2025 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747366092; cv=none; b=vFOAOAOqkC0GT1fm4f0+VZSCWaKUnIR4Ju4Fcqk7QP2/N3B3DhuR6XJXnwJVntxYz+SMRpASLwPZiy3qHRGHJoPCaMyjoYPDV+v8Wv/MQraaApjXMdTQMA9TLI2oSciOmq0aG1SUbk/X0JSYCBTcyi3B9PgLtizgk6ukfnTLLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747366092; c=relaxed/simple;
	bh=6mMFa5NnKEN0NXcCTmZYhH9gXLFiM8XWgKEjEC3BiC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFUVDRO4pSEr1mt7Q6BEJ/q0rxftoAs/Unzy5sDwcPUnvr5SASJn208f3uH0CiDGdNs1OS8M++ogpqw4Nr40JIGv+FkXXKy+6bDwjMWTDidm7LkezMQYSLxwSFPR9g43Tz4EMpdTYCfdEaFhXtwhMD+BpewKaSnENsyc8m7ccsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+8oDI3d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747366088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ylx2tYr3O0mYWUy90qQPc3a/j5/iK6nT3+STy0Mf8rM=;
	b=S+8oDI3d0LHqvCzurT0q32QwTFQl43eYtR4lCjXbl8UwHe7IlFGVEntfdFRPtGjpX+vfJr
	AUGMNDyt1Le4mLlbunzyJFGFDqC9ZioaedG+LFflpEC6rjr6vfp0PcykgupU0Dcc5TQ7b5
	f3/qcokeJgwtOgbUZoqV7nW+OS/5p04=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-OeuX-XSXNKiKTtKwl393_w-1; Thu,
 15 May 2025 23:28:05 -0400
X-MC-Unique: OeuX-XSXNKiKTtKwl393_w-1
X-Mimecast-MFC-AGG-ID: OeuX-XSXNKiKTtKwl393_w_1747366083
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80D801800361;
	Fri, 16 May 2025 03:28:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.140])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5440A1956066;
	Fri, 16 May 2025 03:27:59 +0000 (UTC)
Date: Fri, 16 May 2025 11:27:54 +0800
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
Subject: Re: [PATCH V2] ima: do not copy measurement list to kdump kernel
Message-ID: <aCawunqY+B5lvu5b@MiWiFi-R3L-srv>
References: <20250513143129.1165-1-chenste@linux.microsoft.com>
 <47edc9708d0ca75489d59ef4b9b6ef2f5de21fe9.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47edc9708d0ca75489d59ef4b9b6ef2f5de21fe9.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 05/14/25 at 08:40am, Mimi Zohar wrote:
> On Tue, 2025-05-13 at 07:31 -0700, steven chen wrote:
> > From: Steven Chen <chenste@linux.microsoft.com>
> > 
> > Kdump kernel doesn't need IMA to do integrity measurement.
> > Hence the measurement list in 1st kernel doesn't need to be copied to
> > kdump kernel.
> > 
> > Here skip allocating buffer for measurement list copying if loading
> > kdump kernel. Then there won't be the later handling related to
> > ima_kexec_buffer.
> > 
> > Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> > Tested-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks, Boaquan, Steven.
> 
> This patch is now queued in next-integrity and next-integrity-testing.

Thanks for taking care of this.



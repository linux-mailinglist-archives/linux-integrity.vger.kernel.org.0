Return-Path: <linux-integrity+bounces-7782-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6220EC9E22A
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 09:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C198348B37
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5D29C343;
	Wed,  3 Dec 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7ee4nIQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA78299AA3
	for <linux-integrity@vger.kernel.org>; Wed,  3 Dec 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764749202; cv=none; b=IsZtiUYo0IIjZbomnY6A2GHS+WnXzygOGt12QQaTjIvvQscD9UGo97IWW7mQKcKIzNHDizG/NcJgPZR5pWQ7b8Q3ZD/56oJ/ff7HXSbVpABIbRioS89t9v/IqdBRLI1wCtSapcUjJcpNY6NTBJOZ2CU8ehCf7vCz36lmeVJUBsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764749202; c=relaxed/simple;
	bh=lA/AvlnD4jIt+bo/o2HM5XqkFgspmdxesUJ/5D245ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UknlNHWhcTKlxdtS0K1TFYHRlG6oCABzbp5w+pKdXMNMKA5cswFSfjCpyGsSQ120oLSpyGqVMcxXdNO8c1FxSIiGNhbarw0joQ7ObZarLQCWoh0MIkIF7QkFAaJryYpuwuBjTD0ty/Cxtzhj7Zbx6xmVGaczGdg+56hkDvzlKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7ee4nIQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764749199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7ea7CjgqP5nfnCXT5mMuU8byi9zvzDvcLNxH8zi7UU=;
	b=L7ee4nIQn8ZrfpzQQIkyRnE9gpoAo2ZbZVn0L8lYBwvaxwiYWeYAcrfmBEyiD6CzeeW8u6
	gZiprdnFLn5HZ5Ce9aQ40UZRez5eqo6KtYpkfRpNXHvKOwEckrmlAyYECkz8ml46aymdLO
	B586vVUsNSbGr4gq1r4EHI0gbZWSXsM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-u3VEo25bMmeBBT0lp6zryQ-1; Wed,
 03 Dec 2025 03:06:36 -0500
X-MC-Unique: u3VEo25bMmeBBT0lp6zryQ-1
X-Mimecast-MFC-AGG-ID: u3VEo25bMmeBBT0lp6zryQ_1764749195
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 527F81955E7F;
	Wed,  3 Dec 2025 08:06:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ADBE30001A5;
	Wed,  3 Dec 2025 08:06:32 +0000 (UTC)
Date: Wed, 3 Dec 2025 16:06:28 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-ID: <aS/vhE9GMwauO0+d@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <aSZTb1X26MjSZIzF@MiWiFi-R3L-srv>
 <CAF+s44S2_DG92dJAGX8GZdc-OgOz1a7E+ScbyOGcG85QayBS1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44S2_DG92dJAGX8GZdc-OgOz1a7E+ScbyOGcG85QayBS1w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 12/03/25 at 12:22pm, Pingfan Liu wrote:
> Hi Baoquan,
> 
> On Wed, Nov 26, 2025 at 9:10 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Hi Pingfan,
> >
> > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > The kexec segment index will be required to extract the corresponding
> > > information for that segment in kimage_map_segment(). Additionally,
> > > kexec_segment already holds the kexec relocation destination address and
> > > size. Therefore, the prototype of kimage_map_segment() can be changed.
> >
> > Because no cover letter, I just reply here.
> >
> > I am testing code of (tag: next-20251125, next/master) on arm64 system.
> > I saw your two patches are already in there. When I used kexec reboot
> > as below, I still got the warning message during ima_kexec_post_load()
> > invocation.
> >
> > ====================
> > kexec -d -l /boot/vmlinuz-6.18.0-rc7-next-20251125 --initrd /boot/initramfs-6.18.0-rc7-next-20251125.img --reuse-cmdline
> > ====================
> >
> 
> "I have used the Fedora 42 server and its config file to reproduce the
> issue you reported here. However, I cannot reproduce it with my patch.
> Instead, if I revert my patch, I can see the warning again.
> 
> I suspect that you observed the warning thrown by the original Fedora
> 42 kernel instead of mine.
> 
> You need to kexec-reboot into vmlinuz-6.18.0-rc7-next-20251125, and at
> that point, try 'kexec -d -l /boot/vmlinuz-6.18.0-rc7-next-20251125
> --initrd /boot/initramfs-6.18.0-rc7-next-20251125.img
> --reuse-cmdline'.
> 
> If this is a false alarm, I will rewrite the commit log and send out v3.

Thanks for checking, Pingfan. I am not quite sure if I did wrong
operation on the machine. Since you are testing the same machine and the
same linux-next code, and it still can'e be reproduced, it should be
from my mistake. Then please go ahead posting v3.

Thanks
Baoquan



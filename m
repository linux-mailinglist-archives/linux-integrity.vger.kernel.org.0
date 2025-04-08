Return-Path: <linux-integrity+bounces-5672-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08310A80F46
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD471B81C66
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0616322D4C6;
	Tue,  8 Apr 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VE7erj3I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C922CBE2
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124583; cv=none; b=YIpOd/VZeb2sNgVTMGik+RcMHoT0STqJlSqVEt6VV83hAlwV++SujORf6LwuFR6Fv2DF8LFqOJra1BxsiUhZpqO3D8RwapHxFvL3DuZ7yy5y9+zUCxv9WZTgdqVkBgQEEkxjyU/bYqUD7m0DPIeA0sK/T5g0ZHto3skQLAOPleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124583; c=relaxed/simple;
	bh=75D4nHEQFGSGvsmwcXDWaYqN3sTDjtHNmBAdwlVO/x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX5VlCnnWVccKk2Hm5fxNJi0c5VPO9f50UsH1qBVZCfI4WGkdg9bwlDTixinhFSJjRqCkyaIFy7Tx3uQsh+uxFoSMa6us74WmLQRmiWM+iBvaeyLMc2orwsc6h1p/O6dKFgwM5YRWoTpvg1f5lzeghzHxaCnjro+GppuEZ45hQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VE7erj3I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744124581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2FZ0p9mkPrqV9F+m9UVLnQoQ7Pz9+GyN/0fqGQlgCs=;
	b=VE7erj3IV8xI0ejAS4ghNWK+CE9MfsEacWDvBkMV9beKTeH/lpxXO93aG8ZlK3X90tG7aL
	cYFEx1KvXcpK9gM8QJot/BfQ/+ZOZJ/SGBlvRxsvKJRShseFYAnnM5QvBRyYxI1ePR6sJi
	z0NGZELafSKvJkANvEfmJwM+yRrREjE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-zKsBN8XdOHuLvUodn1doSg-1; Tue,
 08 Apr 2025 11:02:55 -0400
X-MC-Unique: zKsBN8XdOHuLvUodn1doSg-1
X-Mimecast-MFC-AGG-ID: zKsBN8XdOHuLvUodn1doSg_1744124561
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93592187BE12;
	Tue,  8 Apr 2025 15:02:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17FFD1956094;
	Tue,  8 Apr 2025 15:02:31 +0000 (UTC)
Date: Tue, 8 Apr 2025 23:02:27 +0800
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
	dyoung@redhat.com
Subject: Re: [PATCH v11 2/9] ima: define and call ima_alloc_kexec_file_buf()
Message-ID: <Z/U6gxOHa6JZg7Ba@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-3-chenste@linux.microsoft.com>
 <a293ed27094f7fa7a36f1641a9e6b17a49e26fa0.camel@linux.ibm.com>
 <Z/SoekIdreYI3uBZ@MiWiFi-R3L-srv>
 <36e244edd96a51f0749d54811c9567f954680a39.camel@linux.ibm.com>
 <Z/TbuF47dg7zUpsm@MiWiFi-R3L-srv>
 <fe4769ef1597a30fb5fcc26edc81b221bde55a56.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4769ef1597a30fb5fcc26edc81b221bde55a56.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 04/08/25 at 08:23am, Mimi Zohar wrote:
> On Tue, 2025-04-08 at 16:18 +0800, Baoquan He wrote:
> > On 04/08/25 at 01:03am, Mimi Zohar wrote:
> > > On Tue, 2025-04-08 at 12:39 +0800, Baoquan He wrote:
> > > > On 04/08/25 at 12:07am, Mimi Zohar wrote:
> > > > > On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> > > > > > In the current implementation, the ima_dump_measurement_list() API is 
> > > > > > called during the kexec "load" phase, where a buffer is allocated and 
> > > > > > the measurement records are copied. Due to this, new events added after
> > > > > > kexec load but before kexec execute are not carried over to the new kernel
> > > > > > during kexec operation
> > > > > 
> > > > > Repeating this here is unnecessary.
> > > > > > 
> > > > > > To allow the buffer allocation and population to be separated into distinct
> > > > > > steps, make the function local seq_file "ima_kexec_file" to a file variable.
> > > > > 
> > > > > This change was already made in [PATCH v11 1/9] ima: rename variable the
> > > > > set_file "file" to "ima_kexec_file".  Please remove.
> > > > > 
> > > > > > 
> > > > > > Carrying the IMA measurement list across kexec requires allocating a
> > > > > > buffer and copying the measurement records.  Separate allocating the
> > > > > > buffer and copying the measurement records into separate functions in
> > > > > > order to allocate the buffer at kexec 'load' and copy the measurements
> > > > > > at kexec 'execute'.
> > > > > > 
> > > > > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > > > > > ---
> > > > > >  security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
> > > > > >  1 file changed, 35 insertions(+), 11 deletions(-)
> > > > > > 
> > > > > > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > > > > > index 650beb74346c..b12ac3619b8f 100644
> > > > > > --- a/security/integrity/ima/ima_kexec.c
> > > > > > +++ b/security/integrity/ima/ima_kexec.c
> > > > > > @@ -15,26 +15,46 @@
> > > > > >  #include "ima.h"
> > > > > >  
> > > > > >  #ifdef CONFIG_IMA_KEXEC
> > > > > > +static struct seq_file ima_kexec_file;
> > > > > > +
> > > > > > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > > > > > +{
> > > > > > +	vfree(sf->buf);
> > > > > > +	sf->buf = NULL;
> > > > > > +	sf->size = 0;
> > > > > > +	sf->read_pos = 0;
> > > > > > +	sf->count = 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > > > > > +{
> > > > > > +	ima_free_kexec_file_buf(&ima_kexec_file);
> > > > > 
> > > > > After moving the vfree() here at this stage in the patch set, the IMA
> > > > > measurement list fails to verify when doing two consecutive "kexec -s -l"
> > > > > with/without a "kexec -s -u" in between.  Only after "ima: kexec: move IMA log
> > > > > copy from kexec load to execute" the IMA measurement list verifies properly with
> > > > > the vfree() here.
> > > > 
> > > > I also noticed this, patch 7 will remedy this. Put patch 7 just after
> > > > this patch or squash it into this patch?
> > > > 
> > > > [PATCH v11 7/9] ima: verify if the segment size has changed
> > > 
> > > I'm glad you noticed this too!  I've been staring at it for a while, not knowing
> > > what to do.
> > > 
> > > "ima: verify if the segment size has changed" is new to v11.  It was originally
> > > part of this patch.  My comment on v10 was:
> > > 
> > > The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
> > > ima_kexec_file.buf() hiding the fact that the above test always fails and falls
> > > through.  As a result, 'buf' is always being re-allocated.
> > > 
> > > and
> > > 
> > > Instead of adding and then removing the ima_reset_kexec_file() call from
> > > ima_add_kexec_buffer(), defer adding the segment size test to when it is
> > > actually possible for the segment size to change. Please make the segment size
> > > test as a separate patch.
> > > 
> > > ima_reset_kexec_file() will then only be called by ima_free_kexec_file_buf().
> > > Inline the ima_reset_kexec_file() code in ima_free_kexec_file_buf().
> > 
> > Thanks for deliberating on this and the details sharing, Mimi.
> > 
> > It could be fine if we add note in patch 2 log to mention the possible
> > failure. With my understanding, commit/patch bisectable means it won't
> > break compiling and block the testing. The failure you are concerned
> > about is not a blocker, right? And people won't back port partial
> > patches of this series.
> > 
> > Nore sure if there's another better way we can take or detour.
> 
> Right, doing two consecutive kexec loads in a row is not common and won't block
> testing.  Patch readability is more important, in this case, at least to me. 
> I'm fine with your suggestion.

That's great, thanks for confirming.



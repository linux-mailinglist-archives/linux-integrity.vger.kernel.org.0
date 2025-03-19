Return-Path: <linux-integrity+bounces-5319-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BF1A68344
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 03:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143321892EB1
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 02:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130E24E4DA;
	Wed, 19 Mar 2025 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cbvx8+Ej"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16124E015
	for <linux-integrity@vger.kernel.org>; Wed, 19 Mar 2025 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352226; cv=none; b=hsaJR3Xv2P1cCzO3qw06b53F5RQMR9C92PaMyRJdRQ384YMiSe1ej0+Jv/Baf7kdpHbhQ1jNzD1w6iiuWsR/HJgjt1wkfUPVaKBJyy/z4pMkgWh54+ZZ/LChizydRda68nOCzykLeL9pIGFCHM1EvDPp2U3V4Rk4qjbm3Hn+jUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352226; c=relaxed/simple;
	bh=ZQTUjePxm5TGZCk9G/ywjE3xKzudTs5M9ElXEf27t+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f61wRg41SD+Tlb61QEm29RVcSTD2YCm55zEyBtZm/GR1DqeAFKoRZiEocv0tksxK87Z09pKK2DG4/r7asFuuO9KBnysbDns/+BAuytWInJrLxWtsQq0iY51b3d/NjYzPHPJCYp0CoG9IesjMVJE5fnjVG+fRM9OX1K8apDIit4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cbvx8+Ej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742352224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pppH5gnOqQCyGbRm+GFbQIGngpP8DhwB6Ev0UDCWREA=;
	b=Cbvx8+Ejb7mY3jrn/N4QvKgye4gLZwozEeioSHJRWOI+phd0pYpYhFIue6WSA36piDMfq1
	v5l/Ni/zQaLa7QXRAg9jVB2KFdC286VMjV8/5IsIYjhk1YYM5DR1iEeL0qHBBC2WFAeW3G
	jX3modRX+DYml/17p+hIcaNEldZj4+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-aJgyg-HUOCybde04zKe6yw-1; Tue,
 18 Mar 2025 22:43:38 -0400
X-MC-Unique: aJgyg-HUOCybde04zKe6yw-1
X-Mimecast-MFC-AGG-ID: aJgyg-HUOCybde04zKe6yw_1742352216
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B294218001DE;
	Wed, 19 Mar 2025 02:43:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13EA13001D0E;
	Wed, 19 Mar 2025 02:43:32 +0000 (UTC)
Date: Wed, 19 Mar 2025 10:43:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v10 1/8] ima: rename variable the ser_file "file" to
 "ima_kexec_file"
Message-ID: <Z9ovT3CnxBqN+cKI@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-2-chenste@linux.microsoft.com>
 <d85bad29-2391-41cc-868f-73119a5fffba@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85bad29-2391-41cc-868f-73119a5fffba@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/18/25 at 11:10am, Stefan Berger wrote:
> 
> 
> On 3/17/25 9:04 PM, steven chen wrote:
> > The name of the local variable "file" of type seq_file defined in the
> > ima_dump_measurement_list function is too generic. To better reflect the
> > purpose of the variable, rename it to "ima_kexec_file". This change will
> > help improve code readability and maintainability by making the variable's
> > role more explicit.
> > 
> > The variable ima_kexec_file is indeed the memory allocated for copying IMA
> > measurement records. The ima_dump_measurement_list function calculates the
> > actual memory occupied by the IMA logs and compares it with the allocated
> > memory. If there is enough memory, it copies all IMA measurement records;
> > otherwise, it does not copy any records, which would result in a failure
> > of remote attestation.
> > 
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> 
> 
> > ---
> >   security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
> >   1 file changed, 24 insertions(+), 15 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 9d45f4d26f73..8567619889d1 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -15,33 +15,41 @@
> >   #include "ima.h"
> >   #ifdef CONFIG_IMA_KEXEC
> > +/*
> > + * Copy the measurement list to the allocated memory
> > + * compare the size of IMA measurement list with the size of the allocated memory
> 
> Compare the size of the IMA ... memory.
> 
> 
> > + *    if the size of the allocated memory is not less than the size of IMA measurement list
> > + *        copy the measurement list to the allocated memory.
> > + *    else
> > + *        return error
> 
> If the size of the allocated memory is not less than the size of IMA
> measurement list, copy the measurement list to the allocated memory, return
> an error otherwise.

Ack the suggested change.



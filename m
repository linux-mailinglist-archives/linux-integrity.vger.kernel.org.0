Return-Path: <linux-integrity+bounces-8130-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD84BCD48BD
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Dec 2025 03:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 385533008CDB
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Dec 2025 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138823090F1;
	Mon, 22 Dec 2025 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ocpgh7zQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523682FE582
	for <linux-integrity@vger.kernel.org>; Mon, 22 Dec 2025 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369408; cv=none; b=RsAdhJ4bgOAqX6+e/lVpYxP/pOAqjBx6RKvyHhFxXdNWbaE/IzzZ7roH6aiJhlMBf4nCdnzEuBCcHWpkYqRlvjQplWKXRV2hMkk2qgQGvFBdkwIUq25S5E7o9GeLI9k87UzD7IDCCcZ0SIHV78P7h09s2snEHgjgxsnwO2XUOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369408; c=relaxed/simple;
	bh=1Mpo8wTrOqD+iLIBQsx4Gcnf6jAmDrMzSaDI5BgYjHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adVg9PBSk1Da75lb5geyDvDtZHT1Js3gR8V7Ss94bfpfjFq80YpCwciloZKe2Seyk9UXe2l4pvCTOYS6iRvQv26ZYgeTAfsFUA/QvTHgcL52aSWfDJI44uXHhMugSAKQsqwSI22dp1rs4Jxj5DZWyagVEA3u2jSvsiQeHxcf2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ocpgh7zQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766369405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RTiTJP9bxiFe7cenEwFXRKuMhOl99enu+VnKq8sFL2w=;
	b=Ocpgh7zQoA2q3qOaN79ush2BB8uU/a7NqlZBn03iBoDGc9rYOgwyg9Kvvo+A9Pr3fEu07f
	GAk6mBZmuR9VeIEZJENLwGlQkU6Ad1wp2CE9Uk3gZtfs3iHbi62eAAz3ftrsRmLY9kVK0/
	/aExdl0Co2oAP+R6NkSDGSO+gOXaB8w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-a6snkLrMP0yGYdSshfcOLg-1; Sun,
 21 Dec 2025 21:10:02 -0500
X-MC-Unique: a6snkLrMP0yGYdSshfcOLg-1
X-Mimecast-MFC-AGG-ID: a6snkLrMP0yGYdSshfcOLg_1766369400
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 079A0195609D;
	Mon, 22 Dec 2025 02:10:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.76])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86E57180049F;
	Mon, 22 Dec 2025 02:09:57 +0000 (UTC)
Date: Mon, 22 Dec 2025 10:09:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv3 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-ID: <aUiocTZx986boBQX@MiWiFi-R3L-srv>
References: <20251216014852.8737-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216014852.8737-1-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 12/16/25 at 09:48am, Pingfan Liu wrote:
> The kexec segment index will be required to extract the corresponding
> information for that segment in kimage_map_segment(). Additionally,
> kexec_segment already holds the kexec relocation destination address and
> size. Therefore, the prototype of kimage_map_segment() can be changed.
> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> To: kexec@lists.infradead.org
> To: linux-integrity@vger.kernel.org
> ---
>  include/linux/kexec.h              | 4 ++--
>  kernel/kexec_core.c                | 9 ++++++---
>  security/integrity/ima/ima_kexec.c | 4 +---
>  3 files changed, 9 insertions(+), 8 deletions(-)

Ack the series:

Acked-by: Baoquan He <bhe@redhat.com>



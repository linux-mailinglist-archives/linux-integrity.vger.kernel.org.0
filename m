Return-Path: <linux-integrity+bounces-4975-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A7A4153E
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 07:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711CB1895AAE
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 06:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C276B1C878E;
	Mon, 24 Feb 2025 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTzhrf+O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C01C84A6
	for <linux-integrity@vger.kernel.org>; Mon, 24 Feb 2025 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377681; cv=none; b=assBgYJf/KmrwRNRe4v1Xi6BnJhlqVdwfDa5+wxxPvNnkeFqTyG11xcndaV4ykcOjsQv7ClhUyuDa+5CfVt4BwsY8+Pfb5tYtHvqOGrmhHMmW1BrRUH4oQr6xlyrUCdUI5STLU9dV9GugjmknCwg4V5KbwjpK2P4q3RKMJ15Zug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377681; c=relaxed/simple;
	bh=Sj+WDGRz5MVg3VGq6R+ObJqw+0Ui/+FSeflrv00EUks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4O5f3oBZpYMWLTlHc0GbxhfctgeCxHt1e/8SX7Vv+aGoMO+Xvn+rHoErkPGTx0DfeVHWyMkhabT8MT9b5MHF0P1kKxN7qGhUU+u5i60IQUC94rVAuDAvnFCR5VJ5Z7YYty7iPzMqbMefRT/ZDrBZCH/5ibMy6ngImlVdx87nwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTzhrf+O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740377678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJAE5VQtKOJvPeRIxHRRWordcbnsd54QiHO4iNapbAU=;
	b=TTzhrf+OcSeQUKsEY+cEp23uCVrDe8EKPr0y5NA5V2R47ER8g+UnyyKl9bWEnGvo7UaLo2
	X8RPgws4DeCfCPN/NuMGtNhm2420C5wFw0iNWeb9vt1n6m/fIFxDmWNo3m5f9QkmACUNXQ
	M2NcYgQudSk7VVfbp/NuqmCFHTfhuWM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-mIj5mZ4mOF6cCPhbbVyElQ-1; Mon,
 24 Feb 2025 01:14:33 -0500
X-MC-Unique: mIj5mZ4mOF6cCPhbbVyElQ-1
X-Mimecast-MFC-AGG-ID: mIj5mZ4mOF6cCPhbbVyElQ_1740377671
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 276581979057;
	Mon, 24 Feb 2025 06:14:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9565519560AA;
	Mon, 24 Feb 2025 06:14:27 +0000 (UTC)
Date: Mon, 24 Feb 2025 14:14:22 +0800
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
Message-ID: <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218225502.747963-3-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Steve, Mimi,

On 02/18/25 at 02:54pm, steven chen wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.  This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.  Implement functions to map and unmap
> segments to kimage.

I am done with the whole patchset understanding. My concern is if this
TPM PCRs content can be carried over through newly introduced KHO. I can
see that these patchset doesn't introduce too much new code changes,
while if many conponents need do this, kexec reboot will be patched all
over its body and become ugly and hard to maintain.

Please check Mike Rapoport's v4 patchset to see if IMA can register
itself to KHO and do somthing during 2nd kernel init to restore those
TPM PCRs content to make sure all measurement logs are read correctly.
[PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)

Thanks
Baoquan



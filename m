Return-Path: <linux-integrity+bounces-5622-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF6A7D1C2
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 03:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C53169F40
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 01:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F142E62D4;
	Mon,  7 Apr 2025 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmdN5hbc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75072F22
	for <linux-integrity@vger.kernel.org>; Mon,  7 Apr 2025 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743989683; cv=none; b=TO2/fsoXHXJwj//+qS0yErhUr80IfB6ip27iDL3zJtDBvl58gD/xRFwJSt50bAcmUPE00EzUh2QhmBPeE7REWu22vCOcrN5YInSjYHfPL1/JSEZhRXf7tAN4ipswswF9+PPKelHwnoE/iTTSEuoGkQUTivzP570tPJ+UJuVD+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743989683; c=relaxed/simple;
	bh=rkdrnHrQUuFQGYdVXkdcV12rbMUOo49rbBtzkXDd1to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6u7/22VJ0blgEaNLlBNMdfgPoB/bETAxNQZYNdJ0pb4A+wgkQffeGglzR+NvCjc8ldWYI6R0n5lDpnJL8BRS1km74qY+EEvBX7A7DLFIVljdiivNxZTVsV8WUTf7rei5aNyi1efvDfiHaOw9dqGb4wMkhxkZNwS/z2XXfJY6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmdN5hbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743989679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvy9TMt2iMUz/JiuHPEeTKpKgTrJBeMjozXjTZWahsw=;
	b=NmdN5hbcnSCJImJ10yxweL37PW2huBWg8ppD7KcQCnii78sNY76c/uYqSr+TOUAFnBzgQ2
	8u6ECJyJQoeQvSozykE3OEVZNBQlWiINk8K57F7BQggIESQTf38LlV7nw2aoh0GRE6P22H
	d3rkSLc5kClnxNhWmoseLk9HPX/LFXU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-qA-GdddjMC6XU4e3XoP8NA-1; Sun,
 06 Apr 2025 21:34:36 -0400
X-MC-Unique: qA-GdddjMC6XU4e3XoP8NA-1
X-Mimecast-MFC-AGG-ID: qA-GdddjMC6XU4e3XoP8NA_1743989675
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9323E19560B3;
	Mon,  7 Apr 2025 01:34:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83C2E192C7C3;
	Mon,  7 Apr 2025 01:34:33 +0000 (UTC)
Date: Mon, 7 Apr 2025 09:34:28 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, RuiRui Yang <ruyang@redhat.com>,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
References: <20250331061611.253919-1-bhe@redhat.com>
 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 04/03/25 at 04:03pm, Mimi Zohar wrote:
> On Wed, 2025-04-02 at 19:49 +0800, Baoquan He wrote:
> > On 04/02/25 at 04:43pm, Coiby Xu wrote:
> > > On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
> > > > On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
> > > [...]
> > > > > > > that.  Please don't make it generic like this.
> > > > > > > 
> > > > > > > Please refer to ima_appraise_parse_cmdline().
> > > > > > 
> > > > > > Hi Mimi,
> > > > > > 
> > > > > > To save memory for kdump, it seems init_ima has been to be skipped thus
> > > > > > ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
> > > > > > you have any specific concerns in mind?
> > > > > 
> > > > > I think as Mimi said see below logic enforces the IMA even with the
> > > > > cmdline disabling, see ima_appraise_parse_cmdline:
> > > > > if (sb_state) {
> > > > >                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> > > > >                         pr_info("Secure boot enabled: ignoring
> > > > > ima_appraise=%s option",
> > > > >                                 str);
> > > > >         } else {
> > > > >                 ima_appraise = appraisal_state;
> > > > >         }
> > > 
> > > Thanks for pointing me to the above code! Note with the whole IMA
> > > disabled as done by this patch, the above code will not run so IMA
> > > (appraisal) won't be enforced.
> > > 
> > > > 
> > > > Thanks, RuiRui.
> > > > 
> > > 
> > > Mimi, so do I understand it correctly that your want IMA-appraisal to be
> > > always enabled as long as secure boot is enabled even if users choose to
> > > disable IMA? 
> 
> Secure boot is not the only reason.  Based on policy IMA-appraisal and EVM
> calculate and store file hashes and HMAC's in their respective security xattrs.
> Normally the usage of file hashes and HMAC's is limited to mutable files. 
> Disabling IMA-appraisal could result in not properly updating the security
> xattrs, which would result in not being able to verify the file's integrity on
> reboot.
> 
> On systems where the RPM includes file signatures, file signatures of immutable
> files can be safely restored.  Although it is possible to walk the filesystem(s)
> "fixing" the xattrs of mutable files, it defeats the purpose.  "fix" mode should
> only be enabled in a trusted environment.
> 
> > > I wonder what security issue will it bring if this promise
> > > gets broken considering other LSMs can SELinux can be disabled when
> > > secure boot is enabled?
> 
> The builtin IMA policy rules are not defined in terms of SELinux labels.  If the
> initial IMA custom policy defines rules based on SELinux labels and SELinux is
> not enabled, the policy will fail to be loaded.
> 
> > > > Coiby, would disabling just IMA-measurement, as opposed to IMA-appraisal, save
> > > > sufficient memory for kdump?
> > > 
> > > For disabling just IMA-measurement, do you mean not enabling any measure
> > > rules?  The more memory reserved for the kdump kernel, the less memory
> > > can be used by the 1st kernel. So from the perfective of kdump, we try
> > > to make the memory footprint as smaller as possible.
> 
> Got it.
> 
> > > Baoquan, do you have any statistics about the memory overhead of IMA?
> > 
> > I am getting a system to check that. I think there are two aspects of
> > IMA functionality we want to disable. One is disable the IMA-measurement
> > copying from 1st kernel to 2nd kernel, this is only needed by kexec
> > reboot; the other is IMA is not needed at all in kdump kernel, means we
> > don't want to call ima_init() to initialize
> > ima_keyring/crypto/template/digests/fs etc. 
> > 
> > With my shallow knowledge about IMA, I don't know how to imitate
> > appraisal cmdline to disable IMA partially in kdump kernel case.

Thanks for detailed explanations. Just back from holiday, sorry for late
reply.

> 
> The IMA policy controls how much or how little IMA measures and appraises.  Most
> of the memory usage is the IMA measurement list, itself, and the per file cache
> info.  (The per file cache info limits re-measuring or re-appraising files.)

In Steve Chen's kexec supporting ima patchset, kdump kernel loading
should skip ima_kexec buffers allocating and storing via checking if
(image->type == KEXEC_TYPE_CRASH).
> 
> Similarly my knowledge of kdump is very limited.  Is there a way for the kernel
> to differentiate between kexec and kdump?  If we need a mechanism to disable
> IMA-measurement, I'd *really* prefer it be limited to kdump.

Yes, function is_kdump_kernel() is provided for checking if the current
kernel is in kdump kernel.

As said in earlier reply, for kdump kernel, there are two things we
should do:
1) when loading 2nd kernel to prepare for switching, we should not
allocate buffer and store IMA measurement list;
2) when switched into kdump kernel, we should not call ima_init() to do
kinds of init which is useless.

My personnal opinion.

Thanks
Baoquan



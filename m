Return-Path: <linux-integrity+bounces-5547-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23953A78D7A
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 13:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EA73AF6CB
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9291F03C8;
	Wed,  2 Apr 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drMch8A+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC57D1EE7A3
	for <linux-integrity@vger.kernel.org>; Wed,  2 Apr 2025 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594578; cv=none; b=C401n9lLlBLVNDnUYpb97RweJH1A+zpif9ZH6fEsGPrC3eOiYVN1JcIjyJLFNv+yH5ahiOjPryASXSbQQNhub/W2kSOOsO3d8I8QXp05IhVY59Itx22cnQBAIurDF6m/xijgiJXKubRrmf2DQIaYrGzLt4/pC3AxMlq7ssqYwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594578; c=relaxed/simple;
	bh=xSvZ1xLznp4eDmekudriY+bsQUfAfkQT1rhhCxihth8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO9HvH7Oy8rrMsOUMbngGyz9+ZD7hO4C5e/tkWQ1uORKB6Kli4IY8WgKlcM6IJwaDMV01tRjo7CQwqGffawMsBr0ArMIzq5aCx/sQGTfIjINuLz8dGCQgybf3c2M1hn72K71fS60u2HAh2xo58Qy2IgGt1ay4G3racmhKxTUjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drMch8A+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743594575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QY16FlaFz/8AAtmk+eEXNvgP9tXOB0A0u1SLLOqmEPg=;
	b=drMch8A+N90LiNZE2docgkPbv+aaxYHNLfaCt6/obolU0Va+jR1bTpimMrsqUOu0s6xLK9
	oMzI51ARrwnsl0jfzoo9iH9JncVuMvuotqW8rOwtq6m6/4XRIRM5k/mpBsSFGu3KYLNt1K
	2pS/dqj6lEKiB0f/j2qVVmeE+oH443c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-4Vn8jndVOgCQk1a3RQWe8A-1; Wed,
 02 Apr 2025 07:49:34 -0400
X-MC-Unique: 4Vn8jndVOgCQk1a3RQWe8A-1
X-Mimecast-MFC-AGG-ID: 4Vn8jndVOgCQk1a3RQWe8A_1743594573
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 932A1180035E;
	Wed,  2 Apr 2025 11:49:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21B0A1801747;
	Wed,  2 Apr 2025 11:49:31 +0000 (UTC)
Date: Wed, 2 Apr 2025 19:49:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, RuiRui Yang <ruyang@redhat.com>,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
References: <20250331061611.253919-1-bhe@redhat.com>
 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/02/25 at 04:43pm, Coiby Xu wrote:
> On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
> > On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
> [...]
> > > > > that.  Please don't make it generic like this.
> > > > >
> > > > > Please refer to ima_appraise_parse_cmdline().
> > > >
> > > > Hi Mimi,
> > > >
> > > > To save memory for kdump, it seems init_ima has been to be skipped thus
> > > > ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
> > > > you have any specific concerns in mind?
> > > 
> > > I think as Mimi said see below logic enforces the IMA even with the
> > > cmdline disabling, see ima_appraise_parse_cmdline:
> > > if (sb_state) {
> > >                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> > >                         pr_info("Secure boot enabled: ignoring
> > > ima_appraise=%s option",
> > >                                 str);
> > >         } else {
> > >                 ima_appraise = appraisal_state;
> > >         }
> 
> Thanks for pointing me to the above code! Note with the whole IMA
> disabled as done by this patch, the above code will not run so IMA
> (appraisal) won't be enforced.
> 
> > 
> > Thanks, RuiRui.
> > 
> 
> Mimi, so do I understand it correctly that your want IMA-appraisal to be
> always enabled as long as secure boot is enabled even if users choose to
> disable IMA? I wonder what security issue will it bring if this promise
> gets broken considering other LSMs can SELinux can be disabled when
> secure boot is enabled?
> 
> > Coiby, would disabling just IMA-measurement, as opposed to IMA-appraisal, save
> > sufficient memory for kdump?
> 
> For disabling just IMA-measurement, do you mean not enabling any measure
> rules?  The more memory reserved for the kdump kernel, the less memory
> can be used by the 1st kernel. So from the perfective of kdump, we try
> to make the memory footprint as smaller as possible.
> 
> Baoquan, do you have any statistics about the memory overhead of IMA?

I am getting a system to check that. I think there are two aspects of
IMA functionality we want to disable. One is disable the IMA-measurement
copying from 1st kernel to 2nd kernel, this is only needed by kexec
reboot; the other is IMA is not needed at all in kdump kernel, means we
don't want to call ima_init() to initialize
ima_keyring/crypto/template/digests/fs etc. 

With my shallow knowledge about IMA, I don't know how to imitate
appraisal cmdline to disable IMA partially in kdump kernel case.

One exmaple is 'cgroup_disable=memory' we have been doing to add into
kdump cmdline because mem_cgroup is not needed at all for kdump kernel.
We want to achieve that effect.



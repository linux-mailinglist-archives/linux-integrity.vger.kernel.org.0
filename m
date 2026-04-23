Return-Path: <linux-integrity+bounces-9293-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLoBOwP56WnkpwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9293-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 12:48:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61480450E34
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC65D301D948
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111137C11D;
	Thu, 23 Apr 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaENADvy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rkssEZMb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F59322B7D
	for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2026 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941311; cv=none; b=hxoxfOJTukkxWXs3J3Yc0SrYBv2CJHQLJ7p6IylR/5mFYdL8Tn8d79cZabh9JlVCrKDsGdUgApJznNr8RC12piL5cEROYkbYJ+cTtZdLDnbyGkwFzIewXMBgOeTJYMQwZlg0LJ01G6YvCOA/+j6IUpQWQDO5mUQukf6XdfebpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941311; c=relaxed/simple;
	bh=e3JpOMecabnf0ynxVynL0y5KoWFr1eXjbdJMDsNKqeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVm+g0RPLHQE/BKxsIsb1QgYgQt86Q1Ew9oUunCw6CGAJue6NPwKViJz3hL/ygORin/1kEwUPQ/OlO+bg44qLWlStCV03yDPmxPaaHprNIpBv+fRk8t4sVsVsJQyrbH/3dta9Xiqskw98Moq3n9i6UbZTd3SFu14HZCNA2HQRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaENADvy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rkssEZMb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776941309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdQE12F5F+nVKkR36QQ3Ryy6QgSHPeBKTx4cGIBi8Tw=;
	b=YaENADvyTgUOTVraYm2+kY7ZwZS7ZBFwocjZ+JrxqV3Qci+Ex6CQoEovtRRflW3QLxhYQg
	Doa8AIFzV9tu3xkdqv9b8J1Lpx381+LHXMbjbbsPwCErbjwFCbKDWVZ2vVY5sYSzP/9jtL
	EQTzHftaIzBkfqAQ1Ch+o+U6mDmzQHg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-U-qx-ajeMheiZJAksLzbmw-1; Thu, 23 Apr 2026 06:48:27 -0400
X-MC-Unique: U-qx-ajeMheiZJAksLzbmw-1
X-Mimecast-MFC-AGG-ID: U-qx-ajeMheiZJAksLzbmw_1776941307
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35842aa350fso12913285a91.0
        for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2026 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776941307; x=1777546107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdQE12F5F+nVKkR36QQ3Ryy6QgSHPeBKTx4cGIBi8Tw=;
        b=rkssEZMbfxIDDbXb6X3Gd9+61Xq3WKC6Q5RFnyKkU9O3vkQhxJHbiI8ZsTLNRvP5NV
         YJ9mzIuxDH93cR0DgafHsCriPYZ27dUOoGzZXjX4+3p28YGfgv15W1Qn/CnuTiC19K+J
         DFUMXKODgxtlRX3B3QT0Nz8hqrkNCA5+nivSYWGNHnMxUdAPhjX3teHbyWRQj7/AHs8b
         TpPAH13Yphj50FsF5i15AP0icFlTI9y0BjJuUD63PGTrM9So3C5Q0UrhGyu18A7SvPNO
         XMiZV8e8lWvks6A+CfjYHu4A8JDGf/WS1YcOLQMbEVCkhDszNNYs5tIfQTr2o1KNm1WL
         ZdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941307; x=1777546107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdQE12F5F+nVKkR36QQ3Ryy6QgSHPeBKTx4cGIBi8Tw=;
        b=AIkCebQV+gIeM38VGFVC+kUzI2l0nw790h4kFGbnRPx74uHPPgv0/LJA++NBOEllnr
         3r8hDIRrswDovy341Uhfvx2Kvw4JIGn8Xw7vacTW7iC3HkymHAb3FmHwdR5e+h+H1tZr
         vu5lc0QjcubASI1vNvUEXv3OEYwLxSLpyjOHo3dE/6rYB1YvF/gWnx/naTIRVK2GbVRi
         LiT6RB66jnorx0gOP6zhl5ehkCMqrId95xkrJ1oU7HpGTnJz8DQQNAaK7bCYFG8yPnDd
         QnR239P29hsJrmwINlAA55RVetY7ndzDxnPnkvK17SBaVhx8QQBt9i2PwUFxp2nPKbUK
         Wfiw==
X-Forwarded-Encrypted: i=1; AFNElJ9xF94+PQkV/l7Mhpa5EMCbra8WSOd43zYFTVxhMwpMPd3DH9J7tWDrMd+uJQT7TJYMqnmczhcvfwbZSqub7Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR23/J1UvZcRBlwxf6SVtXdN1E6iLEeczn3zwsPm94H6rF9KvF
	ZuBMZys/Gcf7+GFgKzEpgI3z2pswx3b2g/UZWRy+0SmFwhdv5uf/QB/KuefVKBG8hhtXMdFPliR
	ztDsVcXg2rTmUDWx7qUEVkx8sxxt9bxnfmjDjGY/JepM/PcG2XyuDdoeDC/69/rYwtlIYeQ==
X-Gm-Gg: AeBDiesDd4y3nO/WS12EhMYLkpaQ4r1+H8oTBG6qn8dBbE6B6vRzjVS9e4i3APTAHp4
	5sd21TAS5oLAmsehQU/0sO9MWXVHgbbUi5z8MamW4NsBob3xNZcOXTIcUP/+WMrsg7DGxpU2rip
	02VanmluuGm0Ufs/EdDjFjqgRV2bfZ7jLvY/zfN2Fi6sNnadTrZ4Dzy6PnRpi6+xKNHj4uhfWmR
	I3pX78fXfv7NH9huxgq6HjXVlHbiV8jRxiBCIibM0dK+Ukp1fkvQAgCOpa63pozkTlCd0qJu9KP
	j4EpPqFVZdNjn8/ifPvHK2puVxDoxIADn3ktMsmKElKhcQhM+HPi3RrwkzxIxulLHKAz/l1LWS4
	O9E2lOfntcXKayBiknm03nyQ=
X-Received: by 2002:a17:90b:8cb:b0:35b:b52d:f34d with SMTP id 98e67ed59e1d1-361403b01b9mr19878791a91.5.1776941306788;
        Thu, 23 Apr 2026 03:48:26 -0700 (PDT)
X-Received: by 2002:a17:90b:8cb:b0:35b:b52d:f34d with SMTP id 98e67ed59e1d1-361403b01b9mr19878776a91.5.1776941306350;
        Thu, 23 Apr 2026 03:48:26 -0700 (PDT)
Received: from fedora ([49.36.110.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm19457122a91.10.2026.04.23.03.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:48:25 -0700 (PDT)
Date: Thu, 23 Apr 2026 16:18:08 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 2/4] tpm_crb: Add new wrapper function to invoke start
 method
Message-ID: <aen46JaAKQZUpfGk@fedora>
References: <20260324071803.324774-1-armenon@redhat.com>
 <20260324071803.324774-3-armenon@redhat.com>
 <acJqi8S81I2hwvsR@kernel.org>
 <acKG6EQ_tXO8eqfj@fedora>
 <adYTdmCKferDsu4_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adYTdmCKferDsu4_@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9293-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61480450E34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 11:36:06AM +0300, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 06:13:20PM +0530, Arun Menon wrote:
> > 
> > On Tue, Mar 24, 2026 at 12:42:19PM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Mar 24, 2026 at 12:48:01PM +0530, Arun Menon wrote:
> > > > - Extract start invocation code into a separate function called
> > > >   crb_trigger_tpm. This will be helpful in repeatedly calling the
> > > >   start method with different bits set to toggle between start,
> > > >   nextChunk or crbRspRetry behaviours.
> > > > - Based on the bit set, we signal the TPM to consume
> > > >   contents of the command/response buffer.
> > > > - No functional change intended.
> > > 
> > > Please write a proper commit message, which is not a task list.
> > 
> > Yes, I shall do that. Thank you for taking a look.
> 
> Yeah, and now is good time to improve cosmetic details like this.
> 
> I rather take closer look at code when I can run it as I'm not LLM
> coding agent, I need to run to understand cannot hallucinate it :-)

Makes total sense. I have updated the commit messages in v2.
https://lore.kernel.org/lkml/20260324181244.17741-2-armenon@redhat.com/

> 
> BR, Jarkko

Regards,
Arun Menon



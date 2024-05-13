Return-Path: <linux-integrity+bounces-2373-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AA48C42CB
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB31F21403
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF0615358F;
	Mon, 13 May 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="DzShIiKS";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="DzShIiKS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC94153598;
	Mon, 13 May 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609038; cv=none; b=cou21guH9qCsXf+JvKUucpp62vq6tkiwpzbKB+KJa0aAHo+83tApnxuKpAvjcHelQnPZEovbPGss60Td4N6DzfviV63AjfluOV0hDGdkEfmIchKUdbru0MSixHvxbMUDglimV4O876CfRqjhII5lH2ghGp44xPRFbYhj2vlDIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609038; c=relaxed/simple;
	bh=Lgh6G1eAGr1IMo9Vxnj39v+o8JT8rLEQeJcV+88RQik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llnAGMNbgRWdep23V2QLaCJcx7YYGg8QcTdYa4gJYc+YhQ/jRtSdU2M4IzOWSfoX1Id4MxSTGiJwQV4YRkvFE+J7aatMdChVm4flhOD6Ko4X/r4hoJTVTlD4fwLe5jrIOfT6qGxrlnXVxGP1LUIjfpHtDZ1qU29zk7vNvb+2RAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=DzShIiKS; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=DzShIiKS; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715609035;
	bh=Lgh6G1eAGr1IMo9Vxnj39v+o8JT8rLEQeJcV+88RQik=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=DzShIiKSdsasr4E5wVwexE/6FI5q7gmgOCvYJelYgn5BBWydE+yU+fFY6TxQRQK9p
	 eoCxlHz+3inoYRyYQUU36n7EplsZYAILi0eTMzHY7svMU6X9BcOUCqldaILXNl0S7R
	 ZpqQSofQA2kPOjl5toD/5mti2kL2wVIXHDv1T1DE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A27841286A69;
	Mon, 13 May 2024 10:03:55 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id fsnPAtpqdWnn; Mon, 13 May 2024 10:03:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715609035;
	bh=Lgh6G1eAGr1IMo9Vxnj39v+o8JT8rLEQeJcV+88RQik=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=DzShIiKSdsasr4E5wVwexE/6FI5q7gmgOCvYJelYgn5BBWydE+yU+fFY6TxQRQK9p
	 eoCxlHz+3inoYRyYQUU36n7EplsZYAILi0eTMzHY7svMU6X9BcOUCqldaILXNl0S7R
	 ZpqQSofQA2kPOjl5toD/5mti2kL2wVIXHDv1T1DE=
Received: from [172.21.4.27] (unknown [50.204.89.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 069031286A24;
	Mon, 13 May 2024 10:03:54 -0400 (EDT)
Message-ID: <a8ea533bf30c658508875948f29341663360db57.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 4/4] tsm: Allow for extending and reading
 configured RTMRs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Samuel Ortiz <sameo@rivosinc.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Qinkun Bao
 <qinkun@google.com>,  "Yao, Jiewen" <jiewen.yao@intel.com>, "Xing, Cedric"
 <cedric.xing@intel.com>, Dionna Amalie Glaze <dionnaglaze@google.com>,
 biao.lu@intel.com, linux-coco@lists.linux.dev, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 May 2024 08:03:53 -0600
In-Reply-To: <ZkHoiYMseU0XqEbR@vermeer>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
	 <20240128212532.2754325-5-sameo@rivosinc.com>
	 <ec7edddcf8c74e48cb392db0789b03243ab05692.camel@HansenPartnership.com>
	 <ZkHoiYMseU0XqEbR@vermeer>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-05-13 at 12:16 +0200, Samuel Ortiz wrote:
> On Fri, May 10, 2024 at 10:57:37PM -0400, James Bottomley wrote:
> > I'm not really sure where to hang this, since there's no posted
> > agenda
> > or materials for the CCC meeting today.
> 
> The agenda was posted on the linux-coco ml [1]. I sent a link to the
> presentation slides [2] to the thread.

That's great, thanks.

> > However, it struck me you missed a third option: use the ima log
> > format.  This has the advantage that we can define additional
> > events and have them published with a kernel patch (the IMA log
> > format is defined in the kernel).  Thanks to the TCG, it's also CEL
> > compatible but doesn't require any sort of TCG blessing of the
> > events.  Plus we also have existing kernel infrastructure to log to
> > that format.
> 
> That's an interesting idea. It may avoid having to extend the CEL
> spec with a new Content Type, but otoh the current spec defines which
> IMA events are supported. So adding new ones may require to also
> eventually extend the spec. But I guess since IMA is a Linux kernel
> subsystem, changing the kernel code and ABI would de-facto extend the
> TCG CEL IMA spec.

That's what I was assuming since the TCG is currently deferring to IMA
in that regard.

> Here I assume you're talking about the IMA_TEMPLATE CEL specified
> format, which is designed to accomodate for the current kernel IMA
> log format. The main drawback of this format is that the digest does
> not include the whole content event, making the CEL content type, the
> IMA tag name and both lengths (for the content event and the IMA
> content) untrusted for event log verifiers.

That's only because IMA doesn't yet have such an event.  If we're
assuming effectively designing an IMA log format for non repudiation of
external events, one can be added.  Although I wouldn't want to be
hasty: one of the big problems of all options is that no existing log
format really covers the measure container use case and we're not
completely sure what other use cases will arise (the firewall rules
measurements was one that regulated cloud providers seem to think would
be important ... and that has a periodic rush of events, but there will
be others).

However, the current IMA templates (event descriptions) are known by an
ASCII prefix (they all begin ima-):

https://docs.kernel.org/security/IMA-templates.html#supported-template-fields-and-descriptors

So it would be easy to add more with a non ima- prefix.  Note that this
doc is out of date an IMA does support hashes all the way to SHA256
although SHA384 isn't currently listed.

The current record fields are defined in

security/integrity/ima/ima_template.c

> CEL defines another IMA format (IMA_TLV), that hashes the whole event
> content. I think we should at least use that format as our output
> ABI, if we want to use a TCG specified IMA content type.

Possibly.  Although avoiding double hashing may be a useful performance
measure (not really sure how fast records will come in yet).

James



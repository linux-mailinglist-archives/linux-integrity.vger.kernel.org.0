Return-Path: <linux-integrity+bounces-9780-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uGcsEdfYJ2oT3QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9780-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 11:11:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF2B65E246
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 11:11:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=IC5g+LfR;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9780-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9780-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E71863092FAF
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2026 09:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72439F160;
	Tue,  9 Jun 2026 09:05:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37B39EF23;
	Tue,  9 Jun 2026 09:05:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995921; cv=none; b=pag8h7Na8EQ6cZk5Mx69IhZBAxlt+U0UlauGEQgIFZDV2W/PKG55nOAu13pJ36oUfBXfOQ3PCKVYZGDbjDLjyCfLGERdtKQQ8trDlMNmLkxl54nOClkEc1reFbqnCyq9DQFPWeuRn6OkTvwS+KzWksuzupe12a89Z9p2OMuUUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995921; c=relaxed/simple;
	bh=6ahOKGWhGv78RMA0wC7cY/2iSyNGFmRNo4+FTJxzhcI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cU3SFAfOQSi3ZdRjVCyUb1emYcmu9e9B/SFz2JjkXwghCvdcrMAcnp75z4vRIS3oaWWfmc1WymatpJ+2nQjpCO0GhqN9PESQsQOygwrHf5euPR+JPVPSY2gEWFVX6oJNeaqatoNTWUO2GRz0/2eolw8/iwgXAG13VWlRJ2I9/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IC5g+LfR; arc=none smtp.client-ip=115.124.30.111
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780995916; h=Date:Message-ID:From:To:Subject;
	bh=6ahOKGWhGv78RMA0wC7cY/2iSyNGFmRNo4+FTJxzhcI=;
	b=IC5g+LfRkl4PiEpxyq4e5LiY9OUvhM1ZQYpqeXU00KWoeHdZ59GpEBhpreFzNgTAshJ+BUdxPM3YysEhfhIhjx2BikSqcKSo48d+kNPcg5CpV3szo/KpQczc2cbwFQVSj5aW5GsMQ8UhK1/vtNKg8qBCBGIZAKjyFRHrJQ3HT70=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=zongyao.chen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X4Vy9R8_1780995914;
Received: from localhost(mailfrom:ZongYao.Chen@linux.alibaba.com fp:SMTPD_---0X4Vy9R8_1780995914 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Jun 2026 17:05:15 +0800
Date: Tue, 09 Jun 2026 17:05:14 +0800
Message-ID: <c5fe56644b04526faf52d3fb570d7f11@linux.alibaba.com>
From: ZongYao.Chen@linux.alibaba.com
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Nayna Jain <nayna@linux.vnet.ibm.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: eventlog: tpm2: allow event log entries ending at the log boundary
In-Reply-To: <aiY_1doMftc_2WRp@kernel.org>
References: <20260604025356.3436943-1-ZongYao.Chen@linux.alibaba.com> <aiY_1doMftc_2WRp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,linux.vnet.ibm.com,linux.alibaba.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9780-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:nayna@linux.vnet.ibm.com,m:tianjia.zhang@linux.alibaba.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ZongYao.Chen@linux.alibaba.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ZongYao.Chen@linux.alibaba.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFF2B65E246

On Mon, Jun 08, 2026 at 07:06:45AM +0300, Jarkko Sakkinen wrote:
> This looks unnecessary turnover. Please rethink. We should be minizing
> the diff for bug fixes, not the other way around.

Hi Jarkko,

You're right, please drop this patch.

After closer investigation, the issue turned out to be caused by
non-compliant firmware rather than a kernel bug. I will not pursue this
change.

Sorry for the noise.

Zongyao


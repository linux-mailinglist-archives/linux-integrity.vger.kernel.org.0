Return-Path: <linux-integrity+bounces-9512-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOfrFvG7/2nm9wAAu9opvQ
	(envelope-from <linux-integrity+bounces-9512-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 00:57:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C3501F1A
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 00:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF1693020EF5
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 22:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8777B382F0C;
	Sat,  9 May 2026 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sUfdIS3y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D136E460;
	Sat,  9 May 2026 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778367304; cv=none; b=Xkbt84bGEjqcoUmD86+APY7vXtqZpbRn6pziscUVGvxdJeTUZuvLcret/E9NlV/W9y9UsUVl5UW7aCJXlcGZYioVlcXBFxOJYroZ387u0SMy3scDlECNm/XcTeHwdbglGQCDpKvTOoR7rBS+xe5WhvXeEpvmjirtFHOfA+wuwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778367304; c=relaxed/simple;
	bh=YnqZ6fALL68v4IIVCqAdLhs5TJAUt8WKNMevqIgY1wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LR9Fs6pitBLx+5gSDMrSLcDrhgzlt8KJs6k3RN5CNrEJdk0F97MlhmQ5p9faPElniXxr17o+pKxkY/cJwv5UmaKw1o+qhT8gJoMqaA/eOTmj9mFnU69QR9f6jc0+ecY0FYjsPN4IPVA78nEKkF97ZB9qbwnMGGC8TLxGm2lO8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sUfdIS3y; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778367302; x=1809903302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YnqZ6fALL68v4IIVCqAdLhs5TJAUt8WKNMevqIgY1wg=;
  b=sUfdIS3ycT42XmZXHRMP1sextQ9pcg6hXY9YqD3zRh2cD7mor0NVCmvX
   l9QX+RWs1+atUhON1Ig6OJOpzTHO4SUlhRvEZZKRAzY/U+rhKpYCvWLk4
   2Tum5aBTVAeedH/YnleyXXhAbQJqc+PcvQI5GJ1vXzT1GdT1sHVNWgkKj
   HfaPF7nT3a4umqqLs64go8TxW4xm7nGgSQ2hv8NPuIBNZH/CeHEDV82ld
   hUhPrO4+TjIS9eWFjibZb+E0m2G9BYaEL1JXT2U5fIdZrLX5nOfg8BQ6O
   zQqW+YMVY3NolVgZJzkjIe4R9JMpHcH8E+ssmPU6TIG01R0Y4nfPp98sO
   Q==;
X-CSE-ConnectionGUID: 6P4S8ZNOSyCkP0Y+sc6k3w==
X-CSE-MsgGUID: MNUxI7rYTY6B9MQiLc/onQ==
X-IronPort-AV: E=Sophos;i="6.23,225,1770595200"; 
   d="scan'208";a="19258207"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 22:55:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:22102]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.227:2525] with esmtp (Farcaster)
 id b6b0afdd-9700-4361-a648-ecc040b7a4d2; Sat, 9 May 2026 22:55:02 +0000 (UTC)
X-Farcaster-Flow-ID: b6b0afdd-9700-4361-a648-ecc040b7a4d2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 9 May 2026 22:55:00 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sat, 9 May 2026
 22:55:00 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <jarkko@kernel.org>
CC: <gunnarku@amazon.com>, <jbouron@amazon.com>, <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<noodles@meta.com>, <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
Date: Sat, 9 May 2026 22:54:49 +0000
Message-ID: <20260509225450.29027-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <af8aRHUDDho2orTW@kernel.org>
References: <af8aRHUDDho2orTW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: CA0C3501F1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,ziepe.ca,vger.kernel.org,meta.com,gmx.de];
	FROM_NEQ_ENVFROM(0.00)[gunnarku@amazon.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9512-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri, May 09, 2026 at 11:28 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> Just for sake of understanding:
>
> What is "kiro" and is assisted-by the tag supposed to be used here?

Kiro is an AI-powered IDE built on top of Claude [1]. In this case,
it helped with reasoning about the correctness of the fix, generating
test cases to validate the change, and formalizing the commit message.

I'm trying to follow the established guidelines for AI attribution
in kernel contributions to maintain scientific integrity [2] ;-)

On a more utopian note, it is likely that in a year or so there'll be
research conducted into how AI-assisted development is influencing the
changes to the kernel. My goal is to get into the habit of indicating
that AI was used to increase the number of valid data points.

[1] https://kiro.dev/
[2] https://docs.kernel.org/process/coding-assistants.html

Gunnar


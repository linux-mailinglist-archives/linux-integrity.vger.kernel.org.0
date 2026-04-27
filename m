Return-Path: <linux-integrity+bounces-9349-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNz3D+Hp72m+HgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9349-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 00:57:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD947BA78
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 00:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367183038A5C
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3FC3ACA6A;
	Mon, 27 Apr 2026 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="AlXtDKIV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00596282F3F;
	Mon, 27 Apr 2026 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330654; cv=none; b=qRV/Z/kNL2nAhQ8SMXcx9ZizlM8ott4Gssv5THU+cEELRTaC6WYiOg2XQoPU5kd2qntODkNCmKbxJD9fmuM08U7gerWuyEVK69qZkiC/17fLuMFGiwgU8JCZfL47le/8L7QHAAngIQe8DSSBsVedRR4PHxqi7OqPq7iwIm/kcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330654; c=relaxed/simple;
	bh=UojAyneGOxCujNs+AL+2IdzklKqc716tlo88PBL5hBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cipyFjSHLlp5ngEDDYlaDnER+sm7kSnMlO8RPYQwDBrhAXTfPpiD6/ODUZIerD52ai2yj7F3uVQxWAmq9ZTwUC89ZX7jhsv221uBTIfWTOUfB3iSpOxIJBlnETTgKOrlpDx8g8H6/hVjaZHdnLPO1AmaqzUVHTCnaiHpF0dRGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=AlXtDKIV; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777330653; x=1808866653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xI8TNJF6ot7RBXN9VbUnHPpvIE8B5Pm5H/FzYTCqNyY=;
  b=AlXtDKIV5jes8LmiXc5foJJSDudACoCshrDmxc+yc04k5taYAh1WN7vv
   l1FyC1fCXLAj4hlJ2I58gf+z247lGcFYcTgdLjouMbDGy7QSTD734AKFs
   N0WLEGeUVrtjJJu1V1h9GBPRcMFhmegok9uUbDAWSHmkvR1QvP0KnXE1S
   1aCYXWYbqR/iF1/67Q2CH0jYLcOoXYYk/cGbcnRUzlFj5VKvCJOZGMR4M
   ZSK3SvTWjAyIKlFwwF2SIubRMsu+2SA4I1ezsDlXivdbgLYpGrWIafdHN
   XVe+9pO3+cESCFBEZLE3qJ2p1/AR95xWFMDgOVCbpK2EpAoGagyWNxNLZ
   w==;
X-CSE-ConnectionGUID: s4PUGXQJTZWfm2OHHtiRFg==
X-CSE-MsgGUID: 8qa4/1d8SxWKy/S4z70IFQ==
X-IronPort-AV: E=Sophos;i="6.23,203,1770595200"; 
   d="scan'208";a="18322468"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:57:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:12200]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.10:2525] with esmtp (Farcaster)
 id 63d87d76-eb1d-4826-86ed-252a5119c6f7; Mon, 27 Apr 2026 22:57:32 +0000 (UTC)
X-Farcaster-Flow-ID: 63d87d76-eb1d-4826-86ed-252a5119c6f7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 27 Apr 2026 22:57:31 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 27 Apr 2026
 22:57:30 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <pmenzel@molgen.mpg.de>
CC: <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	<noodles@meta.com>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jbouron@amazon.com>, <gunnarku@amazon.com>
Subject: Re: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
Date: Mon, 27 Apr 2026 22:57:03 +0000
Message-ID: <20260427225722.17878-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e71c6d95-6c83-4fb4-8cd5-f66067fb68c5@molgen.mpg.de>
References: <e71c6d95-6c83-4fb4-8cd5-f66067fb68c5@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 96BD947BA78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9349-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,meta.com,vger.kernel.org,amazon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gunnarku@amazon.com,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Sun, Apr 27, 2026 at 10:49 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> gemini/gemini-3.1-pro-preview made a comment [1]. No idea, if it's valid.

Thanks for forwarding, Paul. AFAICS, the comment is a false positive.

My theory is that Gemini conflates two different variables named
'space':

1. The 'space' parameter passed to tpm_dev_transmit(). This *can* be
   NULL (it is NULL for /dev/tpm0 clients).

2. The local 'space' variable inside tpm2_flush_space(). This is
   assigned from &chip->work_space and can *never* be NULL.

The removed NULL check was testing case (2), not case (1).

Regards,
Gunnar


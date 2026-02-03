Return-Path: <linux-integrity+bounces-8428-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPp4DEf2gWljNAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8428-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 14:21:11 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CE5D9D94
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7E22303032A
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6419D38E127;
	Tue,  3 Feb 2026 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRGdYrt7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC935CB63;
	Tue,  3 Feb 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124864; cv=none; b=s14xsLxDOsu5Dmg7gxovl1mcQ5tLywlKrlW5GTA/qwTLOVQHyn04D5XdyJe/g9uwlkent7XSptiwBhyDAZ4QBeAsp741ioaKVTbu62HI/8JXdmBDsKig+NW5pd5Q8Izznc+e6haqwAYTNr+gOddw8xSVLP/++PbggQsVOWAoFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124864; c=relaxed/simple;
	bh=fhjQDZsbflj++sBXbybFgSrpzuUYncVFx59CsoIKVn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SzwtcgLGSaIpzMboErfMpQ9zmpkPN5PCpePsc2+ui3VL/LbLfO7NQ/ewSahiD9fKr6Z89VCOE7YNRUhKtf4xeDyUVL/93rryssQS1bQzqKEMSxfQvNJp4yPhZTLA8e6g9NCnQXk2NPG6CjFyA4o4D1Jq+m2lKwcYUhZuFUg46kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRGdYrt7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770124863; x=1801660863;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fhjQDZsbflj++sBXbybFgSrpzuUYncVFx59CsoIKVn4=;
  b=QRGdYrt7OZIwzQmLhjcqiGemULnpUf8kls+F2FJfMfVl3NJFzlDasiwQ
   Plb3wPhg+ycpRjBQ0nbaIdEmr93oIEAp1Pc1mqcy8cMNNt40hfGOVbmQB
   UnwCAVcY1UySeaHs2BpE5HQ+lbZyt8Ez5UbJecFY2mzg0UveFoqmXsARD
   JJJuLj5wof5GxIXdRFYxY0odE+X8t3RiXIhja9nRjm7pD2Yu5A3DNNyL/
   OKKZ0B5vmUBsm8kdF1G475U627O2dW0LCSb2DuoVHynamtzSRP2jKj8DO
   uoZUwfMvYepEzMsRRgJwJvfqUgLhTUqMh13AbJJh/6YyBR7P7GR2bN6c1
   A==;
X-CSE-ConnectionGUID: wpxFmTcGT2uiwxpyHjC77w==
X-CSE-MsgGUID: 94m3BR8DTliLQL47NlMkkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70312542"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="70312542"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 05:21:02 -0800
X-CSE-ConnectionGUID: fyXg2gorQaK60iWJJSU0mg==
X-CSE-MsgGUID: KiRA/fApSPKNvysjlQ5obQ==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.205])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 05:20:57 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: johannes.goede@oss.qualcomm.com, Jarkko Sakkinen <jarkko@kernel.org>,
 linux-media@vger.kernel.org
Cc: anisse@astier.eu, oleksandr@natalenko.name,
 linux-integrity@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi
 <jacopo.mondi@ideasonboard.com>, Ricardo Ribalda <ribalda@chromium.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
In-Reply-To: <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
Date: Tue, 03 Feb 2026 15:20:55 +0200
Message-ID: <37a0d91c2e78c97f3d956444c4f7a2a2fca9ae06@intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8428-lists,linux-integrity=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,linux-integrity@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: D5CE5D9D94
X-Rspamd-Action: no action

On Tue, 03 Feb 2026, johannes.goede@oss.qualcomm.com wrote:
> The problem is that what you're suggesting is basically a much
> improved (using dma-buf is way better) v4l2-loopback driver and
> v4l2-loopback has been blocked from getting merged into the kernel
> because besides the mobile-phone camera use, the other main use-case
> is to allow running proprietary camera stacks like Intel's proprietary
> camerastack and then presenting that to userspace as a standard v4l2
> cam so that userspace apps will just work.

...

> The community concensus is that the solution here is for apps to
> access cameras through pipewire. Together with the shift of laptops
> cameras from UVC to "raw" MIPI cameras there also is a shift to
> running applications sandboxed as flatpacks because of the changing
> "cyber" security landscape. This is why pipewire was chosen because
> it also solves the accessing cameras from a sandbox issue.

Why is v4l2-loopback problematic from the perspective of facilitating
running proprietary camera stacks, but pipewire isn't?

BR,
Jani.

-- 
Jani Nikula, Intel


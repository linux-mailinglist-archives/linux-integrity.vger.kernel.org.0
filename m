Return-Path: <linux-integrity+bounces-8434-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAsjIohEgmlHRQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8434-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 19:55:04 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A88CBDDE76
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 19:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D2A630192A2
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711A318BBE;
	Tue,  3 Feb 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mt3lILHH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FB26B756;
	Tue,  3 Feb 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144804; cv=none; b=g3FTXo/OWiELt5OW9fABKn6gyOnVeSpZP0UOu8dVlmZ20wcfbAy4vz8a4yBGAQus8tthP1JHary/VhZ7mwS3knb6VkUPpNeDec4xRiZTMtKLfu4/yuF0PhemjB1WHgYZ1WXd6fjryyrkzXsKxd41ZItXtUCbuv6zg1mrLjFk8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144804; c=relaxed/simple;
	bh=s4q+NiCRmoTLb6bCypTgN56XD7KPRRtIDidTskOTv2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vEIKKDdrkw0XHosh34pNKFW+PVc5KNdNrB7jWVwd2hF+yg4a8yi4Gd9ESz8uUpAJszgXJDmFEHAXB6LrhavLG9MaZnXn7rb52Gen324sxnQn5o2egm6+V5EvddOxweAbH6v6SuIyzKUp16OiGs+iaNt9hvtnUzlivhorRLBZBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mt3lILHH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770144803; x=1801680803;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=s4q+NiCRmoTLb6bCypTgN56XD7KPRRtIDidTskOTv2Q=;
  b=mt3lILHHAJbpLd1RZF7Cjen0vZk+pL0MbrHiDwLsj/See6j81RwHpA1g
   UXgc2fuslzelMKp86xAEvKU/kmycrBJ9CDEoFqBmHNK/8Ll0jdKwn965E
   xZwfCcccHrx/OoHocxFhBQJC1E4jc7qGUU/2KuoZT8FEXf+IeCcOHMVwG
   osnjg5DN+uLTTwKh6OAk8tvMoIXJrMhd8YsFB+e44BPTHeroTZJsOYGau
   SJa8x8rBa86t4LRzzHYeILcAN5XjvBqhswAs7JJSdzw5a0i0ts2gTHnXD
   CJt+hbCXRvXhAWTPJ42EYFVxRMUa7yNHbC8C1J/xLg1Sbvszo1cBVbcfe
   w==;
X-CSE-ConnectionGUID: fvfMHq3WSGqBjpmBRvrJ0A==
X-CSE-MsgGUID: /vZv2GqMT9etsU+yHbT5IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="81955315"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="81955315"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:53:22 -0800
X-CSE-ConnectionGUID: UpHXyacrTXmG80ZyL9F+Qw==
X-CSE-MsgGUID: N1Mg281QTF63CW9wdle5fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214084276"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.205])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:53:16 -0800
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
In-Reply-To: <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
 <37a0d91c2e78c97f3d956444c4f7a2a2fca9ae06@intel.com>
 <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
Date: Tue, 03 Feb 2026 20:53:13 +0200
Message-ID: <2bda02cb3da6cb6ca7dcf545a5b7af27fb7a6e37@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8434-lists,linux-integrity=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,linux-integrity@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A88CBDDE76
X-Rspamd-Action: no action

On Tue, 03 Feb 2026, johannes.goede@oss.qualcomm.com wrote:
> OTHO evdi: https://github.com/DisplayLink/evdi has been kept out
> of the kernel for pretty much the same reasons by the drm/kms folks.
>
> At least AFAIK there still is no way to present virtual kms capable
> display outputs backed by userspace in the kernel.
>
> I completely understand where you're coming from wrt v4l2-loopback
> support (or something equivalent) but asking for this really is
> the same as asking for the evdi driver to get merged, which AFAIK
> has been blocked for the reason of avoiding proprietary userspace
> display output drivers (I guess there might be technical reasons too).

I'm not sure this is the same thing, though.

The DRM subsystem does require an open source userspace for new uAPI,
which is stricter than most subsystems [1]. Other than that, I don't
think anyone's actively keeping evdi out of the kernel. AFAIK there
hasn't been a serious attempt at upstreaming it either. Which is pretty
much because there's no open userspace. Nobody's cared enough to either
write one or open source the existing one for a decade [2].


BR,
Jani.


[1] https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-requirements
[2] https://github.com/DisplayLink/evdi/issues/25

-- 
Jani Nikula, Intel


Return-Path: <linux-integrity+bounces-8408-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIoDNx0qgWkwEgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8408-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Feb 2026 23:50:05 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802ED2771
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Feb 2026 23:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC56B300D9F0
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Feb 2026 22:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4C30EF8E;
	Mon,  2 Feb 2026 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4Tni2bo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADD335555;
	Mon,  2 Feb 2026 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072602; cv=none; b=HfX7cDeg0IILMlpFAmu/stDZ3YqCDMm7HbDsvwHL1NShPViMDNGA9+lvIh8ImY3visa+bc+lNbDKf8Cy8c7ODSPtB6AqWTsXQPX2rcdqFiTmr9CfaM8DxH2rBUHuEcd/oK0rmfKpTLRdXvMY0YdcmNOmr0+6uuLHD2QnX6FdgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072602; c=relaxed/simple;
	bh=HsWm+12mW3e1n9FSM8CsNFFIUnSPpNgvtbF9w57Md8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muM5DPAeCslTz/+E4cfOurB2rJI3RXHvAb54ENTiNWqmcbvvpOtqZCnq6CbzSZsWoa4Iktd6O0BVuRT0uNocwVTdDWTLrCyiXpnMK6mnOEZw++uqftvItO4/uEgjgxsyiEczB/SVGik1NBdN71t/UqFwlx152BjY+5v08XFOI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4Tni2bo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770072600; x=1801608600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HsWm+12mW3e1n9FSM8CsNFFIUnSPpNgvtbF9w57Md8U=;
  b=b4Tni2bovNekz6MvF21XR0OrPxOcQKO2uHwNvVxzY8ZLKielJtpSSZw0
   DvOhAutjX6X4tqkKKwNg5FHb5PX/6GRXfgdf/c4v3A5um8buSW31BgXOZ
   tI+OSThJ8+skn3NgGmexf3IzcrRa1YscFj6vcJfVxqsBPSvJZmJOpPdfu
   o40leV7myNeMyCfTJeURSEN0KZUC7Qy3sKQ3f/wJEszFXIuXLHbEjI9ae
   XeyWfmsTy0Z4Vqyc1y7mz8wzSj6KGDNtxjEMtAzh+GcVg0Y12WYCdRxyT
   XRgEOaJ9cW69AO/249PdqojLJkOf4KHgJaYFD5+JBkU3xAx5+PXX/QfZQ
   w==;
X-CSE-ConnectionGUID: siOdhaVsR86bUGGZ7dDnIA==
X-CSE-MsgGUID: 2tnzbkwrR4m7e363dGO46A==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="96695495"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="96695495"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 14:49:59 -0800
X-CSE-ConnectionGUID: vkznrARIQyOjo/AMg2TrGQ==
X-CSE-MsgGUID: K3IkIOVRQZS6NPGobYvU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209434905"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.16])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 14:49:56 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 26440121D8F;
	Tue, 03 Feb 2026 00:50:06 +0200 (EET)
Date: Tue, 3 Feb 2026 00:50:06 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-media@vger.kernel.org, jani.nikula@linux.intel.com,
	anisse@astier.eu, oleksandr@natalenko.name,
	linux-integrity@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <aYEqHogDBqR1qGw3@kekkonen.localdomain>
References: <20260202204425.2614054-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202204425.2614054-1-jarkko@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8408-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kekkonen.localdomain:mid]
X-Rspamd-Queue-Id: 1802ED2771
X-Rspamd-Action: no action

Hi Jarkko,

On Mon, Feb 02, 2026 at 10:44:21PM +0200, Jarkko Sakkinen wrote:
> Already a quick Google survey backs strongly that OOT drivers (e.g.,
> v4l2loopback) are the defacto solution for streaming phone cameras in
> video conference calls, which puts confidential discussions at risk.

As I think it was pointed out in review comments for v1, the reason behind
using v4l2loopback is the use of a downstream driver, which itself is a
source of a security risk. If I understand correctly, supporting this
(proprietary/downstream vendor drivers) would be the main use case this
driver serves? Should this downstream driver be upstreamed to alleviate the
security risks, the need for v4l2loopback or similar drivers presumably
disappears.

Another of the downsides of such proprietary/downstream solutions is they
can never be properly integrated into the Linux ecosystem so functionality
will remain spotty (limited to specific systems and specific releases of
specific distributions) at best.

In other words, this driver appears to be orthogonal to solving either of
the above two problems the proprietary/downstream solutions have.

From the Open Source libcamera based camera software stack point of view
there doesn't seem to be a need for v4l2loopback or another similar driver.
The two main reasons for this is that (1) there's no need for glueing
something separate together like this and (2) V4L2 isn't a great
application interface for cameras -- use libcamera or Pipewire instead.

> 
> It can be also claimed that there's enough OOT usage in the wild that
> possible security bugs could be considered as potential zerodays for the
> benefit of malicious actors.
> 
> The situation has been stagnated for however many years, which is
> unsastainable situation, and it further factors potential security
> risks. Therefore, a driver is needed to address the popular use case.
> 
> vcam is a DMA-BUF backed virtual camera driver capable of creating video
> capture devices to which data can be streamed through /dev/vcam after
> calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> with VCAM_IOC_DEQUEUE. Zero-copy semantics are supported for shared DMA-BUF
> between capture and output.
> 
> This enables efficient implementation of software, which can manage network
> video streams from phone cameras, and map those streams to video devices.

I'd really try to avoid involving V4L2 in-kernel implementation when the
source of the video is network. V4L2 is meant to be used (when it comes to
video) for interfacing video related hardware such as cameras, ISPs and
codecs. There are limited number of video output related devices, too, but
network is something quite different from these.

-- 
Kind regards,

Sakari Ailus


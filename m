Return-Path: <linux-integrity+bounces-2361-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE08C2F2A
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2024 04:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C572841E6
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2024 02:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31E6224F0;
	Sat, 11 May 2024 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZxImCP11";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XDSyHVnG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8279FD;
	Sat, 11 May 2024 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715396262; cv=none; b=I4uIIwNZkj0ZVi+el5eMAvUej7t0bvtuS/cGhMAN9Yb05+7WGshxl31zFUHTfihcb+498xt69UR1RbqpX/+lL61VefoV4Ez7BaeK6HwNwuL3MXwNOylu/GA6kMNPCJFN/MGVN+m5ExijbLK9xIoE3LeC/KIYXlKa3701RgH059E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715396262; c=relaxed/simple;
	bh=Ci/8eci8d+aYYXQPBBV+0M5SEyZvy7co+xzrCKJ/N7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fe40iBZ0XYFimllzxVLBzltZKnu6VIRsvMZ87LYAT4fGH8+evQjrrQXh/0nc9DZkeRdL5HwWwZ1M+hKn+WNpNCLYAs7ORuB/1W0rOamtwiAb0+7LD9rXLeMFK1oIfECZ+56Hp64qfnjChUhYPEmiiDXRUfthNewCRQ3F+SDTOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZxImCP11; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=XDSyHVnG; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715396260;
	bh=Ci/8eci8d+aYYXQPBBV+0M5SEyZvy7co+xzrCKJ/N7s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZxImCP11L+/TuCyBzZ9OMqKVaBuVbsJqXLxWIjoHAxX4Hx8Ekqi/XxTtz6bNTpokf
	 Z8eBYh32RueBzTnAMEqpv3CII3AFG2OM4OWYxLZA3NbRjG4RY7MBKxiOE1iL24mjp9
	 xuR2RG3N0dBXCw3l8Ix6ERLY+YivPOnPituXkgAw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2D5521287DB3;
	Fri, 10 May 2024 22:57:40 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Ag4CuZiUsEnf; Fri, 10 May 2024 22:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715396259;
	bh=Ci/8eci8d+aYYXQPBBV+0M5SEyZvy7co+xzrCKJ/N7s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=XDSyHVnGGpdn1My9eUuEYCPnpw5jvhRETX0ye2EAEYawg96cmprmz2XBNvxQIompr
	 vV+tI65u9ApfXmYiPgILazcv7q6fQy4AaoJXvg3vcQBOXegkBSdJGuVN1MhXJ8tyUG
	 p9xUF/g3dnK3vUyPxyo0BWYexB1W3AD9dTCoZB+E=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F1E691287DA5;
	Fri, 10 May 2024 22:57:38 -0400 (EDT)
Message-ID: <ec7edddcf8c74e48cb392db0789b03243ab05692.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 4/4] tsm: Allow for extending and reading
 configured RTMRs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Samuel Ortiz <sameo@rivosinc.com>, Dan Williams
 <dan.j.williams@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>, Dionna Amalie Glaze
 <dionnaglaze@google.com>,  biao.lu@intel.com, linux-coco@lists.linux.dev,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 10 May 2024 22:57:37 -0400
In-Reply-To: <20240128212532.2754325-5-sameo@rivosinc.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
	 <20240128212532.2754325-5-sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

I'm not really sure where to hang this, since there's no posted agenda
or materials for the CCC meeting today.  I'm afraid I also don't have a
copy of the presentation to point people who weren't at the meeting to.
However, it struck me you missed a third option: use the ima log
format.  This has the advantage that we can define additional events
and have them published with a kernel patch (the IMA log format is
defined in the kernel).  Thanks to the TCG, it's also CEL compatible
but doesn't require any sort of TCG blessing of the events.  Plus we
also have existing kernel infrastructure to log to that format.

Regards,

James



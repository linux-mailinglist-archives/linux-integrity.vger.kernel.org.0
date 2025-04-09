Return-Path: <linux-integrity+bounces-5745-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02EA834BB
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B592444701
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A721CC7C;
	Wed,  9 Apr 2025 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+Cq8r8v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8FB2135AD;
	Wed,  9 Apr 2025 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242216; cv=none; b=Aq0TwqSkqM6n7ImBS7OiI2rw+fNLeDv3iIUUWXq7Cvxki62Xbs8pUVrbZy9LgeLstHpWtZnHco97rCt2K4gPxrxHNokenx8+io9SMncnwGRZNWO7dHZLuTXg0rqxYnPBj9xLB50ZAwe9BqSf5dIkt5zSzJHvNRph8ZPg3G1OEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242216; c=relaxed/simple;
	bh=6cvQObOBBiVoU1xvgoKYW1gaUqE3m5oqCSkuNQ/V4w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVGHQrFD8yE/X+K+TVYEIa20DP5p0+r+Qk/3mnkR1b7KiqK79/elyH4y+EXJx7aLve252CEUrkUZxFcPQdgJFKdRgHri3Zw38ryyBmTaeyjIJ9f8EPZM19QyaoGch9NA4zG1gv3X83EqEHnIl4wdsWH2QhAonWhpztZLlq0LxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+Cq8r8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3F9C4CEE2;
	Wed,  9 Apr 2025 23:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242216;
	bh=6cvQObOBBiVoU1xvgoKYW1gaUqE3m5oqCSkuNQ/V4w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+Cq8r8vgo2oeKsuCafBCI+ZBEnMbbZc8SuBF8Bzda5zYqiRCAZ9j8XrOOG2wWbcG
	 eVEX2moqvDsOynpvXQ6OtZL+xJtRj1FlTw/UIj/eMaT3TrzKCUt+p88urIYiyEMDun
	 EO8SkC2EjMq0dxb5AxDL27JkJpUlpEAZ8Rnsv3PBNkuXonxFO3/Pw6epPNUKpk289U
	 OROb66cfBWdeqvDWWE11Ci08OSs6CultUY4BR4ndBFMzezHR7T4HdYJtLtL86h7EH+
	 wjoguWc3PjftDCqVC4qNLwB7SBkPfI/yXmgdexMnEaPRiuKzRDpje2RgPkkhUvWE+V
	 KhuE/VKAbHnhg==
Date: Wed, 9 Apr 2025 16:43:33 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 22/29] safesetid: move initcalls to the LSM framework
Message-ID: <202504091643.3C42B66ECB@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-53-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-53-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:07PM -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


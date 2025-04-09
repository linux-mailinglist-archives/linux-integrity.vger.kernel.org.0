Return-Path: <linux-integrity+bounces-5747-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA09A834C4
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D5319E4598
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB56E21CC7C;
	Wed,  9 Apr 2025 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKMpQjLf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0702135AD;
	Wed,  9 Apr 2025 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242295; cv=none; b=CN2xrJGunCE7zg6oWZPRZErxLuxtyimdSHmwjkxFFw9nCwQnXyaVszwoWW4gOdKfY2oA3fTOCJqTFfTm3YHqjpUCOqTJx6vg1isbFgVktGR2F7bYcRzohx/H/tRCptxDQFO9KfpPKiNYiWLncX3Q5dkkuiV6nKNX/GKjM3vtbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242295; c=relaxed/simple;
	bh=Ur8cq4MpymjQ3DpUU+n8NGgdxxkEtAtQuWi8Lr3Caw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAVV7hyFNEVy8oTfX/jfT8dIDGliY4UEpDAaJktbVehL56pl9pBtDjePtgt4T91N7dazZaJnmB1UJJ9zftm2NI/CniYQvP+pexun/M4SrLW1IL0uLn4FbbcjngQ2Y4xgJ/YJFNJpt9tz+iL7sA0AEcQN+dzkdATjAU9pWUMo0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKMpQjLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AA6C4CEE2;
	Wed,  9 Apr 2025 23:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242295;
	bh=Ur8cq4MpymjQ3DpUU+n8NGgdxxkEtAtQuWi8Lr3Caw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKMpQjLfKA3p/uMygbtIcwX23OUpRv2zvjyB1ONWqdUhVAvxbGpnPXlIhSBFS8nbR
	 7lGHwThQWlFqJy6pL3VzVFi1Qpe1DHkk2L7XTz8l5oqNRB/tjIrNWt9+46bdRz1Wcl
	 pRP93CpcNCF7Kb4tsxr3Vgl9KsjYQg3/rtwiWd1qUhYHO4y5toK4ZLQmFjgAEF+ZlK
	 /cZRoFvVsEy1sd/PahSG/HQISDyb8ijKrJgLuaJuuxnvs0TFoKvYHmvByy/oDtPxgI
	 B/vfy8swx8ohzFvUt7nWuTYcfevmJ0TpgaMjZhKqpzLqxgPh3xhtPVpYIE/OELnKGi
	 jQBWntG8Ytulg==
Date: Wed, 9 Apr 2025 16:44:52 -0700
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
Subject: Re: [RFC PATCH 24/29] lockdown: move initcalls to the LSM framework
Message-ID: <202504091644.5ACA37DB@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-55-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-55-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:09PM -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


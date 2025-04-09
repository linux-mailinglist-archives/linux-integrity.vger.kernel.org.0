Return-Path: <linux-integrity+bounces-5741-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0BA834A9
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC398A6E44
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165521C18A;
	Wed,  9 Apr 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcdmiDh1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305319ADA4;
	Wed,  9 Apr 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241998; cv=none; b=dmpSkddNwpZ6slOR7gHSoVw3QGRHEXieCb0vewOvmRq+g2026Z4YClCEgPgmubUGYvuLQuf7r1q6ZXtG1xZ1JUKrWVZ4fS1Zcgp7IY2x2aQwBmBNWF0skuZ5uIYZg0S7FAFD4kgD6WjRSHiun/HrKt1+3VIAErM6gCQAyWzSDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241998; c=relaxed/simple;
	bh=dYUTr+qyZa7iqalTpmK0ef0UtaFKL0dpXCmENKNuSBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqcsp62b46msYRPnjfnpFpfwzwxH4+W7S/5+ZG2cvy7rh+NwcaEPEGyIOPMljXTHxLqSCr2i8C8drFaoBeeDS5WjxiYMHhfIv4LAnW0mRZCKvLfrk7ceXOczdTXEvdcpznhwKMXYUxWAElriTecg+Of83qIRRxJdlFgECWuKdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcdmiDh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A571C4CEE2;
	Wed,  9 Apr 2025 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744241997;
	bh=dYUTr+qyZa7iqalTpmK0ef0UtaFKL0dpXCmENKNuSBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcdmiDh1YYjeilpTGqMS2Bs6rar18JAsSwbdIDSmkeT6IzqSEt8+bbJKybohjQSBr
	 sJKTP5w9SwAZijbEZRTmkK/fI1lSBjR5O5cP1F8X93lJOtmdwUCwBRUJ0Sw9YzWfFx
	 PJU8RuUcTv49dEcWZiSqkynNlEmmi3ZSF/LZCfXiEK0NPKBrUhqxrU/7h5/fTmVTnO
	 LTUam+Snyh7OfVG4c8xQlfjJjsG2KVrM0VDoQAVqhvvel2PJFe/EMXnCARO/sOFIPV
	 ZKiEZoWb+z863BBRgMenAoEeHO+fl3aTEivsO8JjSDgTCz9qR7F9/znOIcdv677/P+
	 ZtTW+AtA0zcfQ==
Date: Wed, 9 Apr 2025 16:39:54 -0700
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
Subject: Re: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
Message-ID: <202504091639.A12E1A853E@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-49-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-49-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:03PM -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


Return-Path: <linux-integrity+bounces-7604-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E3C3FA53
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 12:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1D2834B681
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55330215E;
	Fri,  7 Nov 2025 11:06:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15092FFF9D;
	Fri,  7 Nov 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513590; cv=none; b=AK/7wf3nZBrAvR4ICMYHqCLS+pKxEiJ6925Zyiv0PLCSTeFS3HRoc/gbpkJ9kPfpqgxMN7MfXujp3dD41Ilg7vNCNdCEN4DuqK1vm1qMNLSmEsP36j46IGhLWMRQS4OKW5da7oNX1HQfMHdQvhtybxSQQQTVtDUeZFQzyQOsAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513590; c=relaxed/simple;
	bh=Ddn9+v5tDzKJaLK8Xu0fX61QUW0yU0QBxparbvZ+5y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9qxRaSkdgnb6r1HlmOrliQg5aD5Hqpf4/DS2topFSi2j+Sc1lgqckzu99hLtttU3iGp89uOmlJIIUG29haDZ6GJHkmCkbqNUu1ADE4V4WZx0ZBAUFZREbAjG8HScgfumk6e7LWZTuxXWBViVU2xcB6uvROzxLAvjnbTT9MhD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 4A903E80C89;
	Fri, 07 Nov 2025 11:56:24 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id D6672160170; Fri, 07 Nov 2025 11:56:23 +0100 (CET)
Date: Fri, 7 Nov 2025 11:56:23 +0100
From: Lennart Poettering <mzxreary@0pointer.de>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Tahera Fahimi <taherafahimi@linux.microsoft.com>, zohar@linux.ibm.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	code@tyhicks.com
Subject: Re: [Patch V1] ima: avoid duplicate policy rules insertions
Message-ID: <aQ3QV03_PtB4qg32@gardel-login>
References: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
 <1cc67c25a141aef8982840898a6e7397cbdf10d9.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc67c25a141aef8982840898a6e7397cbdf10d9.camel@huaweicloud.com>

On Fr, 07.11.25 10:44, Roberto Sassu (roberto.sassu@huaweicloud.com) wrote:

> On Thu, 2025-11-06 at 18:14 +0000, Tahera Fahimi wrote:
> > Prevent redundant IMA policy rules by checking for duplicates before insertion. This ensures that
> > rules are not re-added when userspace is restarted (using systemd-soft-reboot) without a full system
> > reboot. ima_rule_exists() detects duplicates in both temporary and active rule lists.
>
> + Lennart
>
> Hi Tahera
>
> thanks for the patch!
>
> Wouldn't be better to enhance systemd-soft-reboot to not send the same
> IMA policy again?

the soft-reboot logic doesn't load the IMA policy. It's just that
soft-reboot means we reexec PID1: the old pid1 gets replaced by the
new one. And that new PID1 then initializes as it usually would, and
loads security policies again. It currently has support for selinux
policies, ima, ipe, smack.

These policies are supposed to *replace* whatever was loaded
before. Looking at our IMA logic, this doesn't happen right now
though, it just adds stuff:

https://github.com/systemd/systemd/blob/main/src/core/ima-setup.c

Is there a way to replace the old IMA policy with the new, with the
current IMA userspace interface? If so, we should probably make use of
that in systemd, and replace the policy that way. Or in other words:
under the assumption that one can flush out the old IMA policy and
replace it with a new one, I think this should be fixed in systemd,
not the kernel. (of there's no api for flushing out the old
policy/replacing it with the new, then of course we need something
like that in the kernel first).

My understanding of IMA is kinda limited though. I just know what we
do in our codebase.

Lennart


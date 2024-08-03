Return-Path: <linux-integrity+bounces-3278-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE29468A8
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E6D28209C
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37EA14C5AA;
	Sat,  3 Aug 2024 08:15:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81013398A;
	Sat,  3 Aug 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722672933; cv=none; b=OETvmZT0YiiGHZLBYS4tAHtoW186cyKpgFtUPm1uU1bjM+Yr3Sw+qkBF50CEVZdvS3liLA3lICOuk6W53ubMfbchdUg0BzShU+wRhHj2YQ3JuMuJUo6fL+zsN3HwdZWXhTsGJXYNQmJh9XHYH/NS5zdgqNnH/lH75A+KAyfShHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722672933; c=relaxed/simple;
	bh=SE8XpBNQlH3cEE27mlw49F50SuobwczKwaqo8X15frY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONa9oYSqbI9aHE0zCnvrqF9QbBpLFt2QNeAR+0o+Kppe6iswekaAe1cnVqy8zpxCKd0PzW5O5G9YOFdbaAVSylGQLKsSMiWb+7NpBuPo7xm0Q2H1Hb9Wql3vsc3pLh2gI5GJCselKxFl+HATdCshQ2FJuEhw0wRob8Oi8yZxjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.91.14] (dynamic-176-000-002-166.176.0.pool.telefonica.de [176.0.2.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E2A8E61E5FE01;
	Sat,  3 Aug 2024 10:14:24 +0200 (CEST)
Message-ID: <de7857fb-63d9-42fc-af1e-12ffcdfcdda8@molgen.mpg.de>
Date: Sat, 3 Aug 2024 10:14:20 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 20/20] MAINTAINERS: ipe: add ipe maintainer
 information
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com,
 paul@paul-moore.com, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 fsverity@lists.linux.dev, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-21-git-send-email-wufan@linux.microsoft.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1722665314-21156-21-git-send-email-wufan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Fan,


Thank you very much for your patch. Two nits, should you sent another 
interation: A more specific summary would avoid people having to look at 
the message body or diff, and `git log --oneline` would be enough.

MAINTAINERS: Add IPE entry with M: Fan Wu

MAINTAINERS: Add IPE entry with Fan Wu as maintainer

Am 03.08.24 um 08:08 schrieb Fan Wu:
> Update MAINTAINERS to include ipe maintainer information.

I’d at least mention Integrity Policy Enforcement. As you not only 
include the maintainer information but add a new entry, I’d leave the 
body out, or mention that a new entry is added.

> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> --
> v1-v16:
>    + Not present
> 
> v17:
>    + Introduced
> 
> v18:
>    + No changes
> 
> v19:
>    + No changes
> 
> v20:
>    + No changes
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8766f3e5e87e..4cdf2d5a2058 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11118,6 +11118,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>   F:	security/integrity/
>   F:	security/integrity/ima/
>   
> +INTEGRITY POLICY ENFORCEMENT (IPE)
> +M:	Fan Wu <wufan@linux.microsoft.com>
> +L:	linux-security-module@vger.kernel.org
> +S:	Supported
> +T:	git https://github.com/microsoft/ipe.git
> +F:	Documentation/admin-guide/LSM/ipe.rst
> +F:	Documentation/security/ipe.rst
> +F:	scripts/ipe/
> +F:	security/ipe/
> +
>   INTEL 810/815 FRAMEBUFFER DRIVER
>   M:	Antonino Daplas <adaplas@gmail.com>
>   L:	linux-fbdev@vger.kernel.org


Kind regards,

Paul


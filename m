Return-Path: <linux-integrity+bounces-6283-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07027ABFB26
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 18:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83C917A48D
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB322A7F3;
	Wed, 21 May 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gRTyPkwu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2015B54A;
	Wed, 21 May 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844780; cv=none; b=imj3B8eVAN2ljHRtqZwMcUFlnxGyMuP4IZX3wECIBKpmChgnhH5QvwQA6sjvQJtaiEv2hvAnmdICEqZK/oV9tnxpbUGB0mR3WQzAmT8gYva246uZNCFDgXKDAQvTIUP87Z3y22C4wUKRPR9fQpmtHITHqZiC7zXIFklC5GGvCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844780; c=relaxed/simple;
	bh=oLYyWGPH4HbAJ7JTxmDgm+Qti6QYY6fpsP0+tf3iOdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdhsKAsSzQiRy3MtrQk8t13RuHbAtMdd4IYrfqvdZI9P6DImvjG9v9VF7Amc57jNT/5j5bYQ//OA6y6YPnOLbep2X0CcS2IFLZ6TBANqQtMpNvd6A2Gu0O76sQFWKjMLyEKrUD9AleNTxvpLHBg6FkIH0f44bBWQpaMBK8XdpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gRTyPkwu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=up79q/7A2LSUqgti3jWs90TZZOGVCW7IOursVguezwU=; b=gRTyPkwuiqsz0ZgG2R5YjG2v2H
	6LqazeN1q/XbO51+FgPcMUme8oAWtLihzYAvWecpQbthyzlGFUiIOV7fEIOVfopRMDkOUKAkMypFt
	oY2NNUEDXuuc1vFnpFwIiFjHhwopkZvT6szC0Uh1nskGaSeKbTAZ2Y71IpShgdfwZhvHNohKVdl0+
	QbQKLeQqA62xbYKPEQKwZ+gqEV97F4zKThZ393cw1tfk0XDt8YZk/QIjgMEDmRnlk4hKl5b/3JnlF
	sfCCQF8brlw4uXfl5MWVfzKpP5MCbmb5Ai7hBsJp2tBzMgiVCNyyWyDe2FNYOd/TjxEqRK7MrczgA
	sRXzPWZg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHmGi-00000004rGs-2bME;
	Wed, 21 May 2025 16:26:12 +0000
Message-ID: <ef2d4d13-d8f3-4922-b3ce-54606d733b1b@infradead.org>
Date: Wed, 21 May 2025 09:26:10 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Simon THOBY <git@nightmared.fr>, linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250521140121.591482-1-git@nightmared.fr>
 <20250521140121.591482-10-git@nightmared.fr>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250521140121.591482-10-git@nightmared.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 5/21/25 7:01 AM, Simon THOBY wrote:
> Introduce a minimal documentation for Loadpol, presenting the policy
> format and the two user interfaces: the securityfs policy file and the
> sysctl.
> 
> Signed-off-by: Simon THOBY <git@nightmared.fr>
> ---
>  Documentation/admin-guide/LSM/Loadpol.rst | 81 +++++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst   |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst
> 
> diff --git a/Documentation/admin-guide/LSM/Loadpol.rst b/Documentation/admin-guide/LSM/Loadpol.rst
> new file mode 100644
> index 000000000000..0aa24a8d393c
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/Loadpol.rst
> @@ -0,0 +1,81 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======
> +Loadpol
> +=======
> +
> +Loadpol is a Linux Security Module that enforces a user-provided policy
> +when decided whether a dynamic module can be loaded or not.
> +
> +The policy can be read and rewritten at ``/sys/kernel/security/loadpol/policy``.
> +
> +A default policy is created that contains the current list of blacklisted modules,

Where does the current list of blacklisted modules come from?
Is it from the kernel command line parameter "module_blacklist=" or
somewhere else?

> +and a catch-all entry that allow loading any module.
> +
> +Policy format
> +=============
> +
> +The policy is defined as a set of line-separated entries.
> +Each entry define the conditions for a match (the origin of the load request and
> +the name of the kernel module), and the action to take when the load request
> +matches the entry.
> +
> +
> +Entry syntax: ``[origin=(userspace|kernel|kernel,userspace)] [module=<module_name>] action=(allow|deny)``
> +
> +There are two matching conditions:
> +
> +``origin``:
> +    Load Requests can come from two origins:
> +
> +    * ``userspace`` (ie. a program in userspace called modprobe/insmod)
                       (i.e.,

> +    * ``kernel`` (the kernel requested the module directly by calling
> +      ``request_module(...)``, e.g. loading a filesystem when performing a
> +      ``-o loop`` mount).
> +
> +    When unspecified, the condition defaults to ``kernel,userspace`` (which means
> +    that both origins match).
> +
> +``module``:
> +    Name of the kernel module being matched. The name can contain wilcards.

                                                                     wildcards.

> +    Beware, module aliases do not work!
> +


-- 
~Randy



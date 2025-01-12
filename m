Return-Path: <linux-integrity+bounces-4535-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB0A0ACBF
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2025 01:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C5E3A275B
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2025 00:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9451918E20;
	Mon, 13 Jan 2025 00:00:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A53125B2;
	Mon, 13 Jan 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736726441; cv=none; b=JQSdUfcK6IjtZ7fuSqkbdNnu4POk42XqnHvk5hlPVAttmka5eEWMRxZHbP4aqdbuin/UB1Y1BfM7Qt6bVwrl2nBsjDB1xi/nBF3zQelb8FpDRRcqQpiYmbAHcQ9delZig1piTLtKBpqVThrdCLfQgWe4FIMe9li+gl2VnD0k0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736726441; c=relaxed/simple;
	bh=G1i6DuQOdi7JZpHu+yqI+eelut6Fj3nWgDrwuaAFMPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fe1IsOsHKRKVhWrr2Ypgugz/ZetyeeuFZCWmIWFmADps8hr93aivIY+iEvbEvF0GOE1AGfOnY5A6zuyZbd8JTD49DYrt3QkOlZUeSpHUTTRnUzL1CdDrd5xRm4KEKcwecj8dgSAdJnXJ3xsM5kEHwZiMGV5kmNhVRPOI4sgBNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 50CNxBh9042985;
	Mon, 13 Jan 2025 08:59:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 50CNx7EL042956
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 13 Jan 2025 08:59:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3c73cee2-a4aa-4e85-bafd-d5571e857849@I-love.SAKURA.ne.jp>
Date: Mon, 13 Jan 2025 08:59:08 +0900
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] security: fix typos and spelling errors
To: Paul Moore <paul@paul-moore.com>,
        Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: casey@schaufler-ca.com, takedakn@nttdata.co.jp,
        john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, mic@digikod.net,
        gnoack@google.com, stephen.smalley.work@gmail.com, omosnace@redhat.com,
        linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        skhan@linuxfoundation.org, anupnewsmail@gmail.com
References: <20250111.22fc32ae0729@gnoack.org>
 <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
 <CAHC9VhRbZLtBZ8dH-kASnkQUehG4Cu=zd23A6Jj9zfnyeGOTsA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRbZLtBZ8dH-kASnkQUehG4Cu=zd23A6Jj9zfnyeGOTsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/01/13 1:36, Paul Moore wrote:
> Hi Tanya,
> 
> Ideally this patchset would be split into into seperate, independent
> patches, one for AppArmor, one for IMA/EVM, one for Landlock, one for
> SELinux, one for Smack, and one for TOMOYO.

I don't think we need to split this patchset into individual modules,
especially because this patchset does not affect the result of kernel build.
We sometimes need to do "git bisect", and reducing number of commits helps
saving building time and testing time for bisection.



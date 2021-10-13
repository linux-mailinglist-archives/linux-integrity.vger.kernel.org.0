Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F342C4BF
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 17:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhJMP1m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 11:27:42 -0400
Received: from smtp-42a9.mail.infomaniak.ch ([84.16.66.169]:35269 "EHLO
        smtp-42a9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhJMP1l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 11:27:41 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HTxDx2kspzMqDVQ;
        Wed, 13 Oct 2021 17:25:37 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4HTxDv6zF2zlh8TG;
        Wed, 13 Oct 2021 17:25:35 +0200 (CEST)
Subject: Re: [PATCH 2/2] fs: extend the trusted_for syscall to call IMA
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20211013110113.13239-1-zohar@linux.ibm.com>
 <20211013110113.13239-2-zohar@linux.ibm.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <d4273866-607e-37be-076b-a920bbf08bf9@digikod.net>
Date:   Wed, 13 Oct 2021 17:26:32 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20211013110113.13239-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Nice!

On 13/10/2021 13:01, Mimi Zohar wrote:
> Extend the trusted_for syscall to call the newly defined
> ima_trusted_for hook.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/open.c           | 3 +++
>  include/linux/ima.h | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index c79c138a638c..4d54e2a727e1 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -585,6 +585,9 @@ SYSCALL_DEFINE3(trusted_for, const int, fd, const enum trusted_for_usage, usage,
>  	err = inode_permission(file_mnt_user_ns(f.file), inode,
>  			mask | MAY_ACCESS);
>  
> +	if (!err)
> +		err = ima_trusted_for(f.file, usage);

Could you please implement a new LSM hook instead? Other LSMs may want
to use this information as well.

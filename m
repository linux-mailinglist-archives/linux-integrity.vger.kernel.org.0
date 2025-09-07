Return-Path: <linux-integrity+bounces-7021-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2B9B4795C
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 09:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629FB189FC2B
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDF1E32BE;
	Sun,  7 Sep 2025 07:42:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EB12D1F1;
	Sun,  7 Sep 2025 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757230922; cv=none; b=HDGKrxNSCuGrpCkw+VgPDkbckG/YXtrode1HMd+/1BDz0k+ooofF7agwVAEn/5iJQHtoALBg3yNDN642+C70ISO2Oiyu6+5FsyUiWSzs/MaPZWwQS1wrePAfP4vSCfFUQNbArP1i/KS8XaCF2rJLiFMG5h/pU9aqusw/nvEc6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757230922; c=relaxed/simple;
	bh=uIBRNfeOntsaWXKl0FdR27t1eyl1VeE8XgL0h03PsI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDFoiwacmg/fSM/nrdXW3O4WzSYUdBkoVg8TyNvitSArMDbXvdzIw73tec6WpNIsScIOowffqls6Nkx8D5zkCpPeNXR1+gmq6oBqi3QmpNDDuIgyv02AVrgJyBdqhhJlvkFIABqFWygajeJe0he3WX/+iIlOEZKOHacHq0w+2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5877Z9hk056152;
	Sun, 7 Sep 2025 16:35:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5877Z9B8056148
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 7 Sep 2025 16:35:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6e4bb79d-ba8f-47fa-ad12-0bb79d4442e0@I-love.SAKURA.ne.jp>
Date: Sun, 7 Sep 2025 16:35:08 +0900
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some
 cleanup
To: Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
 <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com>
 <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
 <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

On 2025/09/05 2:52, Paul Moore wrote:
> +       if (unlikely(!str)) {
> +               char *str_tmp;
> +               size_t len_tmp = 0;
> +

Wants a comment that lsm_active_cnt > 0 is guaranteed, or someone
(maybe static analyzers) thinks that we hit ZERO_SIZE_PTR pointer
dereference when lsm_active_cnt == 0.

> +               for (i = 0; i < lsm_active_cnt; i++)
> +                       /* the '+ 1' accounts for either a comma or a NUL */
> +                       len_tmp += strlen(lsm_idlist[i]->name) + 1;
> +
> +               str_tmp = kmalloc(len_tmp, GFP_KERNEL);
> +               if (!str_tmp)
> +                       return -ENOMEM;
> +               str_tmp[0] = '\0';
> +
> +               for (i = 0; i < lsm_active_cnt; i++) {
> +                       if (i > 0)
> +                               strcat(str_tmp, ",");
> +                       strcat(str_tmp, lsm_idlist[i]->name);
> +               }
> +
> +               spin_lock(&lock);
> +               if (!str) {
> +                       str = str_tmp;
> +                       len = len_tmp - 1;

This needs to be

			len = len_tmp - 1;
			mb();
			str = str_tmp;

, or concurrent access might reach simple_read_from_buffer()
with str != 0 and len == 0. (If you don't want mb(), you can use

-	if (unlikely(!str)) {
+	if (unlikely(!str || !len)) {

instead).

> +               } else
> +                       kfree(str_tmp);
> +               spin_unlock(&lock);
> +       }
> +
> +       return simple_read_from_buffer(buf, count, ppos, str, len);
> }



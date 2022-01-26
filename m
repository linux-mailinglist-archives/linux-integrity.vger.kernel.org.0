Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487F749C002
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 01:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiAZAOT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 19:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiAZAOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 19:14:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58450C06161C;
        Tue, 25 Jan 2022 16:14:17 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 07DD7383;
        Wed, 26 Jan 2022 00:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 07DD7383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643156057; bh=jznSEapcUo+3Aq5KyBfFLHbReyAvoHjrY4InTDYlV6g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OhpMjDrQd3mIA1FrNusk8Y05T5t6Gxwx+jX5iNZT28HO0/K3CL5YwqqwrcLJVCDUW
         hA6vfClGKHDW5BflY7U5+Fo3+WKDi6nAhDoYGmLtuLhcT7A4ekhVXa8kMaGGqlN2py
         5cGCuV+de8IDnlF2VySS9sKJTC9XsVsqfakjC2JGRxQzr1sGL4YYyB9pqCjgRoAeII
         fAjG5wyTMWPSO10/6BhwDxSg/2gzPxPcRa9QCIOANTVmQLZrBuMhr32cW2vmCMIxHA
         UQTdTOuIDJcGuf3WX7snLJoTwjt/JW09KJ6wptzk0vEJnORYv7pL9S42qWsr+DTQIl
         UtroPO/pEQhmQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     GUO Zihua <guozihua@huawei.com>, zohar@linux.ibm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com, linux-integrity@vger.kernel.org,
        guozihua@huawei.com
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
In-Reply-To: <20220125090237.120357-1-guozihua@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
Date:   Tue, 25 Jan 2022 17:14:45 -0700
Message-ID: <87o83zwdxm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

GUO Zihua <guozihua@huawei.com> writes:

> From: Guo Zihua <guozihua@huawei.com>
>
> Commandline parameter ima_hash= and ima_template= has order requirement
> for them to work correctly together. Namely ima_hash= must be
> specified after ima_template=, otherwise ima_template= will be ignored.
>
> The reason is that when handling ima_hash=, ima template would be set to
> the default value if it has not been initialized already, and that value
> cannot be changed afterwards by ima_template=.
>
> This patch adds this limitation to the documentation.
>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Guo Zihua <guozihua@huawei.com>

I've applied this, but I'm wondering: where did this review take place?
I can't find it on the lists...

Thanks,

jon

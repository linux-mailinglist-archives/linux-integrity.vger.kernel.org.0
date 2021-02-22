Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483CB3221EF
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 23:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhBVWGx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 17:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhBVWGv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 17:06:51 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7842C061574
        for <linux-integrity@vger.kernel.org>; Mon, 22 Feb 2021 14:06:11 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1D03230D;
        Mon, 22 Feb 2021 22:05:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1D03230D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614031524; bh=mVpGQtY39PwSVfVA6+F22qVIQsISZpq5oPaG6W1QHfw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rq34begmijlY0n+vFhKMnV0C4JxDhzKd186EyMixq1Q0bD2xhb5rvUyn62TTCmCIU
         H/0+R2Yl5MDpx3RhbThrgUYnN+UhZ3X2wLW9p84o9s1ncbdhU0oYgzm/vZ2ZwH/m43
         G24uyRUMl7CNwX0TnIXfwVAJmGKGXPpPektptCq71TZIhQ8xdG8huvOxHYObnoit6Q
         aXj9YwT4GlOI6lSrcycASC1UEKgBISHczswloTcPG1tgUw22t9HI36hsf9MV9ZF2Nj
         wQw0oUZQkvQT/g3CyG6wsnMEzpC9NhbJoJ8gchfkigdDP1sviOBC927CMNUmGqctDR
         c/8/xN78WIo5A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Michael =?utf-8?Q?Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Michael =?utf-8?Q?Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: testing: ima_policy: Fixed missing bracket
In-Reply-To: <20210215102031.10622-1-michael.weiss@aisec.fraunhofer.de>
References: <20210215102031.10622-1-michael.weiss@aisec.fraunhofer.de>
Date:   Mon, 22 Feb 2021 15:05:23 -0700
Message-ID: <87wnuzkbbw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de> writes:

> This fixes a minor typo introduced by commit 34433332841d:
> "docs: ABI: testing: make the files compatible with ReST output"
>
> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
> ---
>  Documentation/ABI/testing/ima_policy | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, but I rewrote the changelog to use a Fixes: tag and to cite the
offending commit in the proper format:

    Fixes: 34433332841d ("docs: ABI: testing: make the files compatible wit=
h ReST output")

Thanks,

jon

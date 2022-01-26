Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978B449CFC4
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiAZQbY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 11:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbiAZQbY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 11:31:24 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80654C06161C
        for <linux-integrity@vger.kernel.org>; Wed, 26 Jan 2022 08:31:23 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9096F845;
        Wed, 26 Jan 2022 16:31:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9096F845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643214682; bh=mw/5BIA+HP3FZ2Q/ERDUMG7NkuPkmxw7Inwvb8/Upqs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=I2YXBvaNewcBOt7keiePkfWIhz78ZraOhRTkJaG+UEH0CUp6UZhoJJpOI+tDKVCgr
         t8jzfcJ8XcdlH1pu/luNNZh+QDjJYEJ3GB3AAf/4FjsFsZUZQsKqwGYQw7Zye1dOUz
         xo9nWdNGkBBK9vgG7s1c/Cf7eggZHh5liT5w+D0GHCnfpi+9VsFgYaduWSmnxETB1Y
         62mjnnBvNLgDp18lPzCD9tOBWElz1kUCAmBAESl4Sniij9cI1xRWB1fywI0NfAPWKo
         C2krPYDAyJ2pTW4xcDv4asnzejECgWBvQueDRDCD2x0FhL38bSJ+EkRogkjPDSLQyX
         BPdNnEIWHrwxQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>,
        Xiujianfeng <xiujianfeng@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
In-Reply-To: <220a8c9f3ab34f2183c0a88941c145d0@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
 <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
 <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
 <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
 <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
 <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
 <173fffb6cde54ae4ac7676d18a84c79f@huawei.com>
 <6f0890f135b61c41d81b03bf084ebab1b3e551e1.camel@linux.ibm.com>
 <220a8c9f3ab34f2183c0a88941c145d0@huawei.com>
Date:   Wed, 26 Jan 2022 09:31:52 -0700
Message-ID: <87pmoev4p3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Roberto Sassu <roberto.sassu@huawei.com> writes:

> I understood that Jonathan already applied the patch. If it is possible
> to make a new patch according to your suggestion, I would ask Zihua
> to do that.
>
> Jonathan, would it be fine for you to discard this patch?

OK, I will drop it.

jon

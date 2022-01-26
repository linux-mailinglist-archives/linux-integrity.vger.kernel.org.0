Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE149C568
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 09:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiAZIiZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 03:38:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42308 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAZIiZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 03:38:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4A7CB81C0D;
        Wed, 26 Jan 2022 08:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C61EC340E3;
        Wed, 26 Jan 2022 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643186302;
        bh=hql5taXDX4ZFmojFgMRXFkOGKx291CxE+GSNeSfAA2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNb+YTM6/mJuqAYTriG5zewRhHzjPggPybHpoW8TTb59Zd19gxWB+rotrC6gceiZI
         aNYPvP5pSSYQKToxenZI6nFnIV7BbVqeXKHRsXl7cgtqYGdsk5Ww6saclUG/juZHhU
         DRwmm4doPU4RrdV1ehlVGIrxpIkOuWVP7huqJsmNMl3eWUgsTBTLkR5Yrq4hUd427k
         ljHiNHVKcLEGP8sirEGX0NJWHdtNZSW4Jy1GRWON4i9isvXo7vH0Ks+l4EEqwOFil4
         pqiXmnpmZTP3AdsYYeSaU+mUeO+RysNjQR9OGFglrTSz6GT1PKmkYdn1Js7gEkKTFy
         x+lyBwK1EV8uw==
Date:   Wed, 26 Jan 2022 09:38:14 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 02/23] ima: Do not print policy rule with inactive LSM
 labels
Message-ID: <20220126083814.3ndwkhivir573aok@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-3-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:24PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Before printing a policy rule scan for inactive LSM labels in the policy
> rule. Inactive LSM labels are identified by args_p != NULL and
> rule == NULL.
> 
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")

That commit message of the referenced patch reads:

"Don't do lazy policy updates while running the rule matching, run the
updates as they happen."

and given that we had a lengthy discussion how to update the rules I'd
really would have liked an explanation why the update needs to run
immediately. Not doing it lazily is the whole reason we have this
notifier infra. Why can't this be done lazily?

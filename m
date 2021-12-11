Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8691D471443
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 15:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhLKOoj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 09:44:39 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:58946 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhLKOoj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 09:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1639233878;
        bh=u7YJrtEsUUWjwexDAYwFQC/8rMSyJeVa31PFSxuanm0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tWzOzDpI+7mKEY/O8ouz+NjIFbYCFBw621J6+YAbPLHPyju0EBFO5+t/E74o1eZvw
         9tZbJD0U9o3lP8+MTQmOwk0CcZBMgzILm2nR4snS+Xm4BscihRAbfDWvJ9WS6oYwAU
         yYW/gKHAOAh0lWFxkCNQaJx3OMcAxoa9AF58FDpY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BC95212803A4;
        Sat, 11 Dec 2021 09:44:38 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8znrXHDMOZci; Sat, 11 Dec 2021 09:44:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1639233878;
        bh=u7YJrtEsUUWjwexDAYwFQC/8rMSyJeVa31PFSxuanm0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tWzOzDpI+7mKEY/O8ouz+NjIFbYCFBw621J6+YAbPLHPyju0EBFO5+t/E74o1eZvw
         9tZbJD0U9o3lP8+MTQmOwk0CcZBMgzILm2nR4snS+Xm4BscihRAbfDWvJ9WS6oYwAU
         yYW/gKHAOAh0lWFxkCNQaJx3OMcAxoa9AF58FDpY=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EBA2A128037C;
        Sat, 11 Dec 2021 09:44:36 -0500 (EST)
Message-ID: <a68ead0d882410a4cdf86f677973864fafc590d8.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 11/16] securityfs: Only use
 simple_pin_fs/simple_release_fs for init_user_ns
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Sat, 11 Dec 2021 09:44:35 -0500
In-Reply-To: <a71b600f34f66d6eca5c50259529b3fc476880f6.camel@iki.fi>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
         <20211207202127.1508689-12-stefanb@linux.ibm.com>
         <a71b600f34f66d6eca5c50259529b3fc476880f6.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-12-11 at 16:16 +0200, Jarkko Sakkinen wrote:
> On Tue, 2021-12-07 at 15:21 -0500, Stefan Berger wrote:
> > To prepare for virtualization of SecurityFS, use simple_pin_fs and
> > simpe_release_fs only when init_user_ns is active.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> 
> What do you mean by virtualization, and how does this prepare
> securityfs for it? The commit message should be way more verbose.

Heh, well cart before horse: we're still trying to work out how to do
it correctly, so we can't really document it until we've figured that
bit out.

Once that's all sorted, the output is likely something in
Documentation/ explaining how to namespace a pseudo filesystem (since
we have quite a few of them in the kernel) rather than a commit message
which will get hard to find the next time someone wants to do this.

James



Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A63319E54
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 13:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhBLMYb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 07:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhBLMW4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 07:22:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4366364E08;
        Fri, 12 Feb 2021 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613132535;
        bh=kL29m8B0BlKb4QIpXdEX+ADv5B/oc9gQuw1FfsQLD9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+dgREgRgSE8KbbgP9crNtAgqGKxU6y26G/RPkFQlbX0sd1F0ba0mGsQ3NZ+Nh04k
         pPVOI7qtYe+QKH2I8GwccmNx9iU9wGHr8Xmn+Yku6OD3XBZqCXpOT7aVKHbgeDKnVu
         V+YzGwm1doa07j7en/GB9Pexa9dwU1jFVD7BZ5rB8Mc18PmgYBRnnqsR27FgA/+7lE
         wrqrNPBBXHeRZACL7Dgc0e9paAcNgqpAEMgPPg+XQMIO3Kugb+2Si7u+yjKPCzqsO1
         N0fb5aqh92Gl1y3FJAbbOz7+RwKqKhzxDbMVDK/kMbGsJNz08149OemyiAdZqF7ooX
         xpwybHFk4/3Gw==
Date:   Fri, 12 Feb 2021 14:22:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        linux-security-module@vger.kernel.org, daniel.thompson@linaro.org,
        op-tee@lists.trustedfirmware.org, corbet@lwn.net,
        jejb@linux.ibm.com, janne.karhunen@gmail.com,
        linux-doc@vger.kernel.org, jmorris@namei.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, Markus.Wamser@mixed-mode.de,
        casey@schaufler-ca.com, linux-integrity@vger.kernel.org,
        jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org,
        serge@hallyn.com
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
Message-ID: <YCZy7mZ0yBPRSm9E@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-2-git-send-email-sumit.garg@linaro.org>
 <YCQRPo0o6MZ0pcUa@kernel.org>
 <f51409f7-05b4-31b6-f1c5-d9e6d7c0bb46@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f51409f7-05b4-31b6-f1c5-d9e6d7c0bb46@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 11, 2021 at 11:34:21AM +0100, Ahmad Fatoum wrote:
> Hello Jarkko,
> 
> On 10.02.21 18:00, Jarkko Sakkinen wrote:
> > On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
> >> +	case Opt_new:
> >> +		key_len = payload->key_len;
> >> +		ret = static_call(trusted_key_get_random)(payload->key,
> >> +							  key_len);
> >> +		if (ret != key_len) {
> >> +			pr_info("trusted_key: key_create failed (%d)\n", ret);
> >> +			goto out;
> >> +		}
> > 
> > This repeats a regression in existing code, i.e. does not check
> > "ret < 0" condition. I noticed this now when I rebased the code
> > on top of my fixes.
> > 
> > I.e. it's fixed in my master branch, which caused a merge conflict,
> > and I found this.
> 
> Does that mean this series will go out for the next merge window?
> Can you point me where your git tree is, so I can rebase on top?

No I mean the bug that is propagated here is fixed in my master
branch, i.e. get_random() should check also '< 0' condition.

/Jarkko

Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B9316BFF
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 18:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhBJRBp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 12:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232159AbhBJRBg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 12:01:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4707564DF6;
        Wed, 10 Feb 2021 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612976456;
        bh=H7GaOW+CiBvaeY1yYaT/BLhAmPmDWl62qWGA8z+LWpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moAfNVCjfFxnZKnAhRc+lbDyBoG0CzSSD4svV6t34566SHtjaTQaILzmcSpytKcN6
         6ZyunSK/Q0VeXwZNg99SMzv4TbQUenOMQ+F2lU+d41OfjFMaMvKYCo0xe/zUdOAOxp
         aSA6T5N4akhoDz3agOWkj8TtDV9QIL7iUAKGzPY9R2lCbcS9t5bdad5fu9qgKwWjQ1
         /XtDLtVe7ZjbWJuwuSPvT+JTmZO8w0V9oydRT26oW/RDRzLxxcGGefQKF+CEKtiSbC
         U0GJpe1dEEhTZ9gLLm8bdLRt1FlI4cnosdVslVSvahasqIQwQffVygPUC9Ec4XVVY0
         zSbRzHQucknLA==
Date:   Wed, 10 Feb 2021 19:00:46 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com, dhowells@redhat.com, jens.wiklander@linaro.org,
        corbet@lwn.net, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, janne.karhunen@gmail.com,
        daniel.thompson@linaro.org, Markus.Wamser@mixed-mode.de,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
Message-ID: <YCQRPo0o6MZ0pcUa@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604419306-26105-2-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
> +	case Opt_new:
> +		key_len = payload->key_len;
> +		ret = static_call(trusted_key_get_random)(payload->key,
> +							  key_len);
> +		if (ret != key_len) {
> +			pr_info("trusted_key: key_create failed (%d)\n", ret);
> +			goto out;
> +		}

This repeats a regression in existing code, i.e. does not check
"ret < 0" condition. I noticed this now when I rebased the code
on top of my fixes.

I.e. it's fixed in my master branch, which caused a merge conflict,
and I found this.

/Jarkko

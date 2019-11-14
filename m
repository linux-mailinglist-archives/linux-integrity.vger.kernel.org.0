Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43334FCD68
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKNSX7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 13:23:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60796 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfKNSX5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 13:23:57 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 13DE720B4901;
        Thu, 14 Nov 2019 10:23:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13DE720B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573755837;
        bh=uaxB7fUN27FEr/HjjP9552g8B1mnqLqdPLb3Hiy8bRE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=pcyBkNUSx6Hooo6K5jiENhuK5ihKQm2UW0RSfdxuCPV17NWdcG0D1w57ucDBsyf4V
         9NPtLNUUlxX0gaxVeBQS1oUVWkkPj6eQtjAfjjYtcstss21aWWM5uuPthLH+KfrPNh
         OnGv+NGqHOFXR+JxkUrO852eU4Ky/huD51NRhMv0=
Subject: Re: [PATCH v7 3/5] KEYS: Call the IMA hook to measure keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
 <20191114031202.18012-4-nramas@linux.microsoft.com>
 <1573743267.4793.43.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <24262d82-c90b-b64d-f237-9ef038f38d0e@linux.microsoft.com>
Date:   Thu, 14 Nov 2019 10:24:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573743267.4793.43.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/14/2019 6:54 AM, Mimi Zohar wrote:

> No need to Cc David Howells on the entire patch set.  Just Cc him,
> here, after your tag.
ok

> With this patch, keys are now being measured.  With the boot command
> line, we can verify the measurement entry against /proc/cmdline.  How
> can the key measurement entry be verified?  Please include that
> information, here, in this patch description.

Glad you could verify measurement of keys. Thanks a lot for trying it.

Will add information on testing\validating the feature.

> Also, can the key data, now included in the measurement list, be used
> to verify signatures in the ima-sig or ima-modsig templates?  Is there
> a way of correlating a signature with a key?  Perhaps include a
> kselftest as an example.
> 
> Mimi

I am not familiar with kselftest. Will take a look and see if it'd be 
possible to correlate a signature with a key.

thanks,
  -lakshmi

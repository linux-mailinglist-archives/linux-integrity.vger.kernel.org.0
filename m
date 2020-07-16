Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758F0222E56
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 00:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgGPWDe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 18:03:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37492 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgGPWDe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 18:03:34 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 41FA820B4909;
        Thu, 16 Jul 2020 15:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41FA820B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594937013;
        bh=BO4avn92Gom5gc+t7EdSdrx5xcXiDN2axravan300r8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=alO1yY324W0XtvJF3jJ20uUtbfZIxvf5wdeVrVykT/x6h7DAdLUYXLhQmKKM1FSLm
         QrQ8rV0+7PDptRV66+ZZQExLfZNMxwrenrawEk4eIjI5uVEm2JZhZ7t/gi9fzXKtBb
         4QLIkDA5LTA6svI/oegPWWMZ2q4ojUcWUeUrjHFg=
Subject: Re: [PATCH v2 4/5] LSM: Define SELinux function to measure security
 state
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200716174351.20128-1-nramas@linux.microsoft.com>
 <20200716174351.20128-5-nramas@linux.microsoft.com>
 <CAEjxPJ43eXK0xgrE=gDxZVg2SDTz4bkd7N4otjk-cvxf3fKL-g@mail.gmail.com>
 <9478ddca-8298-5170-836d-8cbc7a070df2@linux.microsoft.com>
 <CAEjxPJ5p_T+C1NDz3iF7fvQzQAURpAcipvQfQXLZTfLP4Wiqbg@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <37d3d380-f4e2-1bdc-88c8-7bb8ffbee612@linux.microsoft.com>
Date:   Thu, 16 Jul 2020 15:03:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5p_T+C1NDz3iF7fvQzQAURpAcipvQfQXLZTfLP4Wiqbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/16/20 12:45 PM, Stephen Smalley wrote:
> On Thu, Jul 16, 2020 at 3:13 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>>
>> On 7/16/20 11:54 AM, Stephen Smalley wrote:
>>> Not sure about this error handling approach (silent, proceeding as if
>>> the length was zero and then later failing with ENOMEM on every
>>> attempt?). I'd be more inclined to panic/BUG here but I know Linus
>>> doesn't like that.
>> I am not sure if failing (kernel panic/BUG) to "measure" LSM data under
>> memory pressure conditions is the right thing. But I am open to treating
>> this error as a fatal error. Please let me know.
> 
> Let's at least log an error message since it otherwise silently
> disables all measuring of security state.
Agree - will log error messages as appropriate.

> Also not sure why we bother returning errors from
> selinux_measure_data() since nothing appears to check or use the
> result.
Maybe SELinux can log audit messages on failures, but I guess it may be 
better to do that closer to where the error occurs.

Will change selinux_measure_data() to void function.

> Don't know if integrity/IMA has any equivalent to the audit
> subsystem's concept of audit_failure settings to control whether
> errors that prevent auditing (measuring) are handled silently, with a
> log message, or via a panic.  If not, I guess that can be explored
> separately.
> 

Yes - integrity subsystem logs audit messages for errors\failures.

  -lakshmi



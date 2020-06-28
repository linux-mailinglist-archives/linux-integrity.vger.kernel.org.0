Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23BA20C4EF
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jun 2020 02:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgF1ADN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Jun 2020 20:03:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43772 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgF1ADN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jun 2020 20:03:13 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5875520B4901;
        Sat, 27 Jun 2020 17:03:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5875520B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593302592;
        bh=AheOVy8WalcaWac91mKAT8KIpgDUzXZHzWpyNG3m0gg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MVfHOkX1d6GxzRyYYiQQPB1TuVfYstSj4CFuXd6M8e9GBo2IMLbe9MnwUym/ifhvc
         984TXaD/DGHpcRhVFfvhdqGRTiNBQi7tSBdWHMUowMMzyk7poES0Yms1vAetyoW12l
         I3tqljz9xfBYIxayF2XOz5zuK5JIc81dBZ+2F65Q=
Subject: Re: [PATCH v2 11/11] ima: Support additional conditionals in the
 KEXEC_CMDLINE hook function
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-12-tyhicks@linux.microsoft.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f8897c9a-2ee4-c42b-3138-15ea9d14852c@linux.microsoft.com>
Date:   Sat, 27 Jun 2020 17:03:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626223900.253615-12-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/26/20 3:39 PM, Tyler Hicks wrote:
> Take the properties of the kexec kernel's inode and the current task
> ownership into consideration when matching a KEXEC_CMDLINE operation to
> the rules in the IMA policy. This allows for some uniformity when
> writing IMA policy rules for KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK,
> and KEXEC_CMDLINE operations.
> 
> Prior to this patch, it was not possible to write a set of rules like
> this:
> 
>   dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
>   dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
>   dont_measure func=KEXEC_CMDLINE obj_type=foo_t
>   measure func=KEXEC_KERNEL_CHECK
>   measure func=KEXEC_INITRAMFS_CHECK
>   measure func=KEXEC_CMDLINE
> 
> The inode information associated with the kernel being loaded by a
> kexec_kernel_load(2) syscall can now be included in the decision to
> measure or not
> 
> Additonally, the uid, euid, and subj_* conditionals can also now be
> used in KEXEC_CMDLINE rules. There was no technical reason as to why
> those conditionals weren't being considered previously other than
> ima_match_rules() didn't have a valid inode to use so it immediately
> bailed out for KEXEC_CMDLINE operations rather than going through the
> full list of conditional comparisons.
> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> ---
> 
> * v2
>    - Moved the inode parameter of process_buffer_measurement() to be the
>      first parameter so that it more closely matches process_masurement()
> 
>   include/linux/ima.h                          |  4 ++--
>   kernel/kexec_file.c                          |  2 +-
>   security/integrity/ima/ima.h                 |  2 +-
>   security/integrity/ima/ima_api.c             |  2 +-
>   security/integrity/ima/ima_appraise.c        |  2 +-
>   security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>   security/integrity/ima/ima_main.c            | 23 +++++++++++++++-----
>   security/integrity/ima/ima_policy.c          | 17 +++++----------
>   security/integrity/ima/ima_queue_keys.c      |  2 +-
>   9 files changed, 31 insertions(+), 25 deletions(-)
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

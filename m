Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F71162FD4
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2020 20:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBRTZ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 14:25:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58788 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTZ5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 14:25:57 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 24D4720B9C02;
        Tue, 18 Feb 2020 11:25:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24D4720B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582053957;
        bh=IlZjYMt8348usfDsk/hmaIjApktRG/nXtvI4U//iFDw=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=T4bNp0VpB7uwx7OA32BD/YZwewN4xTZ4f+Ka9ScZtV4WJsvlWw8p2FMMtj3du515t
         u64+c253RlXLIIUI/KB25ZGspmEMZ8f/oA5TWokG1ScEB0rQHFXNV/dMKdm+SHUMMs
         5qf0oAa2QB82ysg7xNXk6Ad/ucn+M0Lr2c537Vj0=
Subject: Re: [PATCH v4 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
 <20200215014709.3006-2-tusharsu@linux.microsoft.com>
Message-ID: <857c8dc6-d09c-423e-c520-53bb85c6d46c@linux.microsoft.com>
Date:   Tue, 18 Feb 2020 11:25:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215014709.3006-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 2020-02-14 5:47 p.m., Tushar Sugandhi wrote:
> The kbuild Makefile specifies object files for vmlinux in the $(obj-y)
> lists. These lists depend on the kernel configuration[1].
> 
> The kbuild Makefile for IMA combines the object files for IMA into a
> single object file namely ima.o. All the object files for IMA should be
> combined into ima.o. But certain object files are being added to their
> own $(obj-y). This results in the log messages from those modules getting
> prefixed with their respective base file name, instead of "ima". This is
> inconsistent with the log messages from the IMA modules that are combined
> into ima.o.
> 
> This change fixes the above issue.
> 
> [1] Documentation\kbuild\makefiles.rst
> 
Is there any feedback on this patch description?
I can address it in the next iteration.

Thanks,
Tushar
